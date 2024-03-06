# loading gnpy element object descriptions and propagating signal through path
# this example provides the same results as using the gnpy-transmission-example from the cli using no inputs (see bottom)


using Revise
using GNPyWrapper
using CondaPkg
using PythonCall

# CONSTANTS
REPRESENT_RESULTS_01 = true
COMPARISON_01 = true
PRINT_COMMENTS_01 = true

# import necessary Python modules and safe them in a dictionary
py_modules = Dict()
py_modules["numpy"] = pyimport("numpy")
py_modules["elements"] = pyimport("gnpy.core.elements")
py_modules["builtins"] = pyimport("builtins")
py_modules["parameters"] = pyimport("gnpy.core.parameters")
py_modules["json_io"] = pyimport("gnpy.tools.json_io")
py_modules["pathlib"] = pyimport("pathlib")
py_modules["cli_examples"] = pyimport("gnpy.tools.cli_examples")
py_modules["cli_examples_02"] = pyimport("gnpy.tools.cli_examples_02")
py_modules["info"] = pyimport("gnpy.core.info")

#########################
#########################
# 1. initialization
#########################
# 1.1. initialize the network elements

# First network element: Transceiver A 

# get specific description of trx from example storage
trx_dict_01, trx_attr_list = transceiver_example_des("example_01_a", py_modules)
# create object
trx_01 = transceiver_obj(trx_dict_01, trx_attr_list, py_modules)

# Second network element: Fiber

# get specific description of fiber from example storage
fiber_dict_01, fiber_attr_lists = fiber_example_des("example_01", py_modules)
# create object
fiber_01 = element_fiber_01= fiber_obj(fiber_dict_01,fiber_attr_lists["attr_list_fiber"],fiber_attr_lists["attr_list_fiber_params"],py_modules)


# Third network element: EDFA
# get specific description of edfa from example storage
edfa_dict_01, edfa_attr_lists = edfa_example_des("example_01", py_modules)

# create object
edfa_01 = edfa_obj(edfa_dict_01, edfa_attr_lists["attr_list_edfa"], edfa_attr_lists["attr_list_edfa_params"],  edfa_attr_lists["attr_list_edfa_operational"], py_modules)



# Fourth network element: Transceiver B

# get specific description of trx from example storage
trx_dict_02, trx_attr_list = transceiver_example_des("example_01_b", py_modules)
# create object
trx_02 = transceiver_obj(trx_dict_02, trx_attr_list, py_modules)

#########################
# 1.2 initialize the signal

# create si from example_01
si_dictionary_01 = spectral_information_example_des("example_01", py_modules)
# create si object
si_start_01 = spectral_information_obj(si_dictionary_01,py_modules)

#########################
#########################
# 2. propagate signal through path

# create path

path_01 = [trx_01, fiber_01, edfa_01, trx_02]

for el in path_01
    el(si_start_01)
end

# include update step for trx

trx_01.update_snr(si_start_01.tx_osnr)
trx_02.update_snr(si_start_01.tx_osnr)


#########################
#########################
# 3. analyze results

# using repr function
if REPRESENT_RESULTS_01
    for el in path_01
        println(el)
    end
end

#########################
#########################
#########################
# COMPARISON WITH "original" gnpy-transmission-example

if COMPARISON_01

    if PRINT_COMMENTS_01
        println("##################")
        println("##################")
        println("STARTED COMPARISON")
        println("##################")
    end


    # YOU NEED TO PROVIDE THE FILES!

    # Define path to example json data
    _examples_dir = py_modules["pathlib"].Path(@__FILE__).parent
    
    folder_01 = "\\example_json_files"
    # prepare equipemnt filename    
    equipment_filename = string(_examples_dir , folder_01, "\\eqpt_config.json")
    equipment_filename_02 = py_modules["pathlib"].Path(equipment_filename)
    
    
    # prepare network filename
    topology_filename = string(_examples_dir , folder_01, "\\edfa_example_network.json")
    topology_filename_02 = py_modules["pathlib"].Path(topology_filename)

    # load equipment and network using load_commen_data
    equipment, network = py_modules["cli_examples_02"].load_common_data(equipment_filename_02, topology_filename_02,simulation_filename= nothing, save_raw_network_filename = nothing)

    # run transmission_main_example in its original form 

    py_modules["cli_examples_02"].transmission_main_example(equipment, network, 0, false, true, false, false)



end
