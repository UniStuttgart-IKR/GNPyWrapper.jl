module GNPyWrapper

using PythonCall

using DocStringExtensions

export second_layer_fiber_des

export fiber_des

export transceiver_des

export edfa_des

export roadm_des

export fused_des

export fiber_obj

export fiber_obj_02

export py_dir_funct

export py_dir_funct_02

export py_get_attr

export py_set_attr

export fiber_example_des

export transceiver_obj

export spectral_information_example_des

export spectral_information_obj

export transceiver_example_des

export edfa_operational_obj

export edfa_params_obj

export edfa_obj

export edfa_example_des

export create_full_path_des_from_cli_examples_02

export roadm_obj

export fused_obj

export create_full_real_path


# Write your package code here.


include("a_initialize_phase/create_description.jl")
include("a_initialize_phase/create_object.jl")
include("z_python_auxiliary_functions/analyze_py_obj.jl")
include("examples/gnpy_object_descriptions.jl")

include("a_initialize_phase/create_full_path_description.jl")
include("a_initialize_phase/create_path.jl")

end


