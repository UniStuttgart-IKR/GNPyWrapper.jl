# loading gnpy element object descriptions and propagating signal through path
# this example provides the same results as using the gnpy-transmission-example from the cli with input argument "fused_roadm_example_network.json"


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

# automatically generate the descriptions from json-data

# YOU NEED TO PROVIDE THE FILES!

# Define path to example json data
_examples_dir = py_modules["pathlib"].Path(@__FILE__).parent

folder_01 = "\\example_json_files"
# prepare equipemnt filename    
equipment_filename = string(_examples_dir , folder_01, "\\eqpt_config.json")
equipment_filename_02 = py_modules["pathlib"].Path(equipment_filename)


# prepare network filename
topology_filename = string(_examples_dir , folder_01, "\\fused_roadm_example_network.json") # fused_roadm_example_network.json # edfa_example_network.json
topology_filename_02 = py_modules["pathlib"].Path(topology_filename)

# load equipment and network using load_commen_data
equipment_02, network_02 = py_modules["cli_examples_02"].load_common_data(equipment_filename_02, topology_filename_02,simulation_filename= nothing, save_raw_network_filename = nothing)

path_description, attr_lists = create_full_path_des_from_cli_examples_02(equipment_02, network_02, 0, py_modules)


# from path description generate objects

real_path = create_full_real_path(path_description, attr_lists, py_modules)

if PRINT_COMMENTS_01
    for i in real_path
        println(i)
    end
end


#########################
# 1.2 initialize the signal

# create si from example_01
si_dictionary_01 = spectral_information_example_des("example_02", py_modules)
# create si object
si_start_01 = spectral_information_obj(si_dictionary_01,py_modules)

#########################
#########################
# 2. propagate signal through path

for i in real_path
    if pyconvert(Bool, py_modules["builtins"].isinstance(i, py_modules["elements"].Roadm))

        #println("IN LOOP")
        i(si_start_01, "DUMMY UID") # check what is necessary here (look into propagate function in gnpy.topology.request)
    else
        i(si_start_01)
    end
end

# include update step for trx # check what is necessary here (look into propagate function in gnpy.topology.request)

# for i in real_path
#     if pyconvert(Bool, py_modules["builtins"].isinstance(i, py_modules["elements"].Transceiver))

#         i.update_snr(si_start_01.tx_osnr)
 
#     end
# end

getindex(real_path,1).update_snr(si_start_01.tx_osnr)
DEFAULT_ROADM_ADD_DROP_OSNR = 38
getindex(real_path,9).update_snr(si_start_01.tx_osnr, DEFAULT_ROADM_ADD_DROP_OSNR)


#########################
#########################
# 3. analyze results

# using repr function
if REPRESENT_RESULTS_01
    for i in real_path
        #if pyconvert(Bool, py_modules["builtins"].isinstance(i, py_modules["elements"].Transceiver))
            println(i)
        #end
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
    topology_filename = string(_examples_dir , folder_01, "\\fused_roadm_example_network.json")
    topology_filename_02 = py_modules["pathlib"].Path(topology_filename)

    # load equipment and network using load_commen_data
    equipment, network = py_modules["cli_examples_02"].load_common_data(equipment_filename_02, topology_filename_02,simulation_filename= nothing, save_raw_network_filename = nothing)

    # run transmission_main_example in its original form 

    py_modules["cli_examples_02"].transmission_main_example(equipment, network, 0, false, false, false, false)



end
