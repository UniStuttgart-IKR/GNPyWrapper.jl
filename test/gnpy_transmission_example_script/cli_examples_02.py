#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
gnpy.tools.cli_examples
=======================

Common code for CLI examples
"""

import argparse
import logging
import sys
from math import ceil
from numpy import linspace, mean
from pathlib import Path

import gnpy.core.ansi_escapes as ansi_escapes
from gnpy.core.elements import Transceiver, Fiber, RamanFiber
from gnpy.core.equipment import trx_mode_params
import gnpy.core.exceptions as exceptions
from gnpy.core.network import build_network
from gnpy.core.parameters import SimParams
from gnpy.core.utils import db2lin, lin2db, automatic_nch
from gnpy.topology.request import (ResultElement, jsontocsv, compute_path_dsjctn, requests_aggregation,
                                   BLOCKING_NOPATH, correct_json_route_list,
                                   deduplicate_disjunctions, compute_path_with_disjunction,
                                   PathRequest, compute_constrained_path, propagate)
from gnpy.topology.spectrum_assignment import build_oms_list, pth_assign_spectrum
from gnpy.tools.json_io import (load_equipment, load_network, load_json, load_requests, save_network,
                                requests_from_json, disjunctions_from_json, save_json, load_initial_spectrum)
from gnpy.tools.plots import plot_baseline, plot_results

_logger = logging.getLogger(__name__)
_examples_dir = Path(__file__).parent.parent / 'example-data'
_help_footer = '''
This program is part of GNPy, https://github.com/TelecomInfraProject/oopt-gnpy

Learn more at https://gnpy.readthedocs.io/

'''
_help_fname_json = 'FILE.json'
_help_fname_json_csv = 'FILE.(json|csv)'


def show_example_data_dir():
    print(f'{_examples_dir}/')


def load_common_data(equipment_filename, topology_filename, simulation_filename, save_raw_network_filename):
    """Load common configuration from JSON files"""

    try:
        equipment = load_equipment(equipment_filename)
        network = load_network(topology_filename, equipment)
        if save_raw_network_filename is not None:
            save_network(network, save_raw_network_filename)
            print(f'{ansi_escapes.blue}Raw network (no optimizations) saved to {save_raw_network_filename}{ansi_escapes.reset}')
        if not simulation_filename:
            sim_params = {}
            if next((node for node in network if isinstance(node, RamanFiber)), None) is not None:
                print(f'{ansi_escapes.red}Invocation error:{ansi_escapes.reset} '
                      f'RamanFiber requires passing simulation params via --sim-params')
                sys.exit(1)
        else:
            sim_params = load_json(simulation_filename)
        SimParams.set_params(sim_params)
    except exceptions.EquipmentConfigError as e:
        print(f'{ansi_escapes.red}Configuration error in the equipment library:{ansi_escapes.reset} {e}')
        sys.exit(1)
    except exceptions.NetworkTopologyError as e:
        print(f'{ansi_escapes.red}Invalid network definition:{ansi_escapes.reset} {e}')
        sys.exit(1)
    except exceptions.ParametersError as e:
        print(f'{ansi_escapes.red}Simulation parameters error:{ansi_escapes.reset} {e}')
        sys.exit(1)
    except exceptions.ConfigurationError as e:
        print(f'{ansi_escapes.red}Configuration error:{ansi_escapes.reset} {e}')
        sys.exit(1)
    except exceptions.ServiceError as e:
        print(f'{ansi_escapes.red}Service error:{ansi_escapes.reset} {e}')
        sys.exit(1)

    return (equipment, network)


def _setup_logging(args):
    logging.basicConfig(level={2: logging.DEBUG, 1: logging.INFO, 0: logging.WARNING}.get(args.verbose, logging.DEBUG))


def _add_common_options(parser: argparse.ArgumentParser, network_default: Path):
    parser.add_argument('topology', nargs='?', type=Path, metavar='NETWORK-TOPOLOGY.(json|xls|xlsx)',
                        default=network_default,
                        help='Input network topology')
    parser.add_argument('-v', '--verbose', action='count', default=0,
                        help='Increase verbosity (can be specified several times)')
    parser.add_argument('-e', '--equipment', type=Path, metavar=_help_fname_json,
                        default=_examples_dir / 'eqpt_config.json', help='Equipment library')
    parser.add_argument('--sim-params', type=Path, metavar=_help_fname_json,
                        default=None, help='Path to the JSON containing simulation parameters (required for Raman). '
                                           f'Example: {_examples_dir / "sim_params.json"}')
    parser.add_argument('--save-network', type=Path, metavar=_help_fname_json,
                        help='Save the final network as a JSON file')
    parser.add_argument('--save-network-before-autodesign', type=Path, metavar=_help_fname_json,
                        help='Dump the network into a JSON file prior to autodesign')
    parser.add_argument('--no-insert-edfas', action='store_true',
                        help='Disable insertion of EDFAs after ROADMs and fibers '
                             'as well as splitting of fibers by auto-design.')


def transmission_main_example(equipment,network, power_db, no_insert_edfas, PRINT_ON_CONSOLE, source, destination):


    transceivers = {n.uid: n for n in network.nodes() if isinstance(n, Transceiver)}

    if not transceivers:
        sys.exit('Network has no transceivers!')
    if len(transceivers) < 2:
        sys.exit('Network has only one transceiver!')



    # If no partial match or no source/destination provided pick random
    if not source:
        source = list(transceivers.values())[0]
        del transceivers[source.uid]

    if not destination:
        destination = list(transceivers.values())[0]


    # CREATE PATHREQUEST

    params = {}
    params['request_id'] = 0
    params['trx_type'] = ''
    params['trx_mode'] = ''
    params['source'] = source.uid
    params['destination'] = destination.uid
    params['bidir'] = False
    params['nodes_list'] = [destination.uid]
    params['loose_list'] = ['strict']
    params['format'] = ''
    params['path_bandwidth'] = 0
    params['effective_freq_slot'] = None


    trx_params = trx_mode_params(equipment)
    

    trx_params['power'] = db2lin(float(power_db)) * 1e-3

    params.update(trx_params)
    initial_spectrum = None
    
    nb_channels = automatic_nch(trx_params['f_min'], trx_params['f_max'], trx_params['spacing'])
    
    params['nb_channel'] = nb_channels
    req = PathRequest(**params)
    req.initial_spectrum = initial_spectrum

    if PRINT_ON_CONSOLE:
        print(f'There are {nb_channels} channels propagating')


    power_mode = equipment['Span']['default'].power_mode

    if PRINT_ON_CONSOLE:
        print('\n'.join([f'Power mode is set to {power_mode}',
                     f'=> it can be modified in eqpt_config.json - Span']))

    # Keep the reference channel for design: the one from SI, with full load same channels
    pref_ch_db = lin2db(req.power * 1e3)  # reference channel power / span (SL=20dB)
    pref_total_db = pref_ch_db + lin2db(req.nb_channel)  # reference total power / span (SL=20dB)
    try:
        build_network(network, equipment, pref_ch_db, pref_total_db, no_insert_edfas)
    except exceptions.NetworkTopologyError as e:
        print(f'{ansi_escapes.red}Invalid network definition:{ansi_escapes.reset} {e}')
        sys.exit(1)
    except exceptions.ConfigurationError as e:
        print(f'{ansi_escapes.red}Configuration error:{ansi_escapes.reset} {e}')
        sys.exit(1)
    path = compute_constrained_path(network, req)

    spans = [s.params.length for s in path if isinstance(s, RamanFiber) or isinstance(s, Fiber)]
    if PRINT_ON_CONSOLE:
        print(f'\nThere are {len(spans)} fiber spans over {sum(spans)/1000:.0f} km between {source.uid} '
          f'and {destination.uid}')
    if PRINT_ON_CONSOLE:
        print(f'\nNow propagating between {source.uid} and {destination.uid}:')

    power_range = [0]
    if power_mode:
        # power cannot be changed in gain mode
        try:
            p_start, p_stop, p_step = equipment['SI']['default'].power_range_db
            p_num = abs(int(round((p_stop - p_start) / p_step))) + 1 if p_step != 0 else 1
            power_range = list(linspace(p_start, p_stop, p_num))
        except TypeError:
            print('invalid power range definition in eqpt_config, should be power_range_db: [lower, upper, step]')
    for dp_db in power_range:
        req.power = db2lin(pref_ch_db + dp_db) * 1e-3
        # if initial spectrum did not contain any power, now we need to use this one.
        # note the initial power defines a differential wrt req.power so that if req.power is set to 2mW (3dBm)
        # and initial spectrum was set to 0, this sets a initial per channel delta power to -3dB, so that
        # whatever the equalization, -3 dB is applied on all channels (ie initial power in initial spectrum pre-empts
        # "--power" option)
        if power_mode:
            if PRINT_ON_CONSOLE:
                print(f'\nPropagating with input power = {ansi_escapes.cyan}{lin2db(req.power*1e3):.2f} dBm{ansi_escapes.reset}:')
        else:
            if PRINT_ON_CONSOLE:
                print(f'\nPropagating in {ansi_escapes.cyan}gain mode{ansi_escapes.reset}: power cannot be set manually')
        infos = propagate(path, req, equipment)
        if len(power_range) == 1:
            for elem in path:
                print(elem)
            if power_mode:
                print(f'\nTransmission result for input power = {lin2db(req.power*1e3):.2f} dBm:')
            else:
                print(f'\nTransmission results:')
            print(f'  Final GSNR (0.1 nm): {ansi_escapes.cyan}{mean(destination.snr_01nm):.02f} dB{ansi_escapes.reset}')
        else:
            print(path[-1])




def half_transmission_main_example(equipment,network, power_db, no_insert_edfas, PRINT_ON_CONSOLE, source, destination):


    transceivers = {n.uid: n for n in network.nodes() if isinstance(n, Transceiver)}

    if not transceivers:
        sys.exit('Network has no transceivers!')
    if len(transceivers) < 2:
        sys.exit('Network has only one transceiver!')



    # If no partial match or no source/destination provided pick random
    if not source:
        source = list(transceivers.values())[0]
        del transceivers[source.uid]

    if not destination:
        destination = list(transceivers.values())[0]


    # CREATE PATHREQUEST

    params = {}
    params['request_id'] = 0
    params['trx_type'] = ''
    params['trx_mode'] = ''
    params['source'] = source.uid
    params['destination'] = destination.uid
    params['bidir'] = False
    params['nodes_list'] = [destination.uid]
    params['loose_list'] = ['strict']
    params['format'] = ''
    params['path_bandwidth'] = 0
    params['effective_freq_slot'] = None


    trx_params = trx_mode_params(equipment)
    

    trx_params['power'] = db2lin(float(power_db)) * 1e-3

    params.update(trx_params)
    initial_spectrum = None
    
    nb_channels = automatic_nch(trx_params['f_min'], trx_params['f_max'], trx_params['spacing'])
    
    params['nb_channel'] = nb_channels
    req = PathRequest(**params)
    req.initial_spectrum = initial_spectrum

    if PRINT_ON_CONSOLE:
        print(f'There are {nb_channels} channels propagating')


    power_mode = equipment['Span']['default'].power_mode

    if PRINT_ON_CONSOLE:
        print('\n'.join([f'Power mode is set to {power_mode}',
                     f'=> it can be modified in eqpt_config.json - Span']))

    # Keep the reference channel for design: the one from SI, with full load same channels
    pref_ch_db = lin2db(req.power * 1e3)  # reference channel power / span (SL=20dB)
    pref_total_db = pref_ch_db + lin2db(req.nb_channel)  # reference total power / span (SL=20dB)
    try:
        build_network(network, equipment, pref_ch_db, pref_total_db, no_insert_edfas)
    except exceptions.NetworkTopologyError as e:
        print(f'{ansi_escapes.red}Invalid network definition:{ansi_escapes.reset} {e}')
        sys.exit(1)
    except exceptions.ConfigurationError as e:
        print(f'{ansi_escapes.red}Configuration error:{ansi_escapes.reset} {e}')
        sys.exit(1)
    path = compute_constrained_path(network, req)

    spans = [s.params.length for s in path if isinstance(s, RamanFiber) or isinstance(s, Fiber)]
    if PRINT_ON_CONSOLE:
        print(f'\nThere are {len(spans)} fiber spans over {sum(spans)/1000:.0f} km between {source.uid} '
          f'and {destination.uid}')
        print(f'\nNow propagating between {source.uid} and {destination.uid}:')

    power_range = [0]
    if power_mode:
        # power cannot be changed in gain mode
        try:
            p_start, p_stop, p_step = equipment['SI']['default'].power_range_db
            p_num = abs(int(round((p_stop - p_start) / p_step))) + 1 if p_step != 0 else 1
            power_range = list(linspace(p_start, p_stop, p_num))
        except TypeError:
            print('invalid power range definition in eqpt_config, should be power_range_db: [lower, upper, step]')
    for dp_db in power_range:
        req.power = db2lin(pref_ch_db + dp_db) * 1e-3
        # if initial spectrum did not contain any power, now we need to use this one.
        # note the initial power defines a differential wrt req.power so that if req.power is set to 2mW (3dBm)
        # and initial spectrum was set to 0, this sets a initial per channel delta power to -3dB, so that
        # whatever the equalization, -3 dB is applied on all channels (ie initial power in initial spectrum pre-empts
        # "--power" option)
        if power_mode:
            if PRINT_ON_CONSOLE:
                print(f'\nPropagating with input power = {ansi_escapes.cyan}{lin2db(req.power*1e3):.2f} dBm{ansi_escapes.reset}:')
        else:
            if PRINT_ON_CONSOLE:
                print(f'\nPropagating in {ansi_escapes.cyan}gain mode{ansi_escapes.reset}: power cannot be set manually')
        

        # Create list for further analysing the path in julia (it includes a dictionary the type and the specific object itself)
        path_01 = []

        counter = 0
        import gnpy.core.elements as elements
        for i in path:
            dummy_dict ={}
            if isinstance(i, elements.Transceiver):
                dummy_dict["type"] = "Transceiver"
            if isinstance(i, elements.Fiber):
                dummy_dict["type"] = "Fiber"
            if isinstance(i, elements.Roadm):
                dummy_dict["type"] = "Roadm"
            if isinstance(i, elements.Edfa):
                dummy_dict["type"] = "Edfa"
            if isinstance(i, elements.Fused):
                dummy_dict["type"] = "Fused"
            dummy_dict["object"] = i
            path_01.append(dummy_dict)
            counter = counter + 1
        return path, path_01 
        
        #infos = propagate(path, req, equipment)
        # if len(power_range) == 1:
        #     for elem in path:
        #         print(elem)
        #     if power_mode:
        #         print(f'\nTransmission result for input power = {lin2db(req.power*1e3):.2f} dBm:')
        #     else:
        #         print(f'\nTransmission results:')
        #     print(f'  Final GSNR (0.1 nm): {ansi_escapes.cyan}{mean(destination.snr_01nm):.02f} dB{ansi_escapes.reset}')
        # else:
        #     print(path[-1])

