module GNPyWrapper

using PythonCall

using DocStringExtensions

export DummyStruct
export dummymult10, dummyfunction

export dummyfunction_02



export second_layer_fiber_des

export fiber_des

export transceiver_des

export edfa_des

export roadm_des

export fused_des

#functions for creating
export fiber_obj
# test pythoncall stuff
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

# export fiber_des,fiber_obj
# export transceiver_des, transceiver_obj
# export fused_des, fused_obj
# export roadm_des, roadm_obj
# export edfa_des, edfa_obj

# Write your package code here.
include("examplefile.jl")


# #newly added
# include("a_initialize_phase/create_description.jl")

# include("a_initialize_phase/create_gnpy_object.jl")

# include("a_initialize_phase/from_json_get_list_of_objects_in_path.jl")

include("examplefile_02.jl")

include("a_initialize_phase/examplefile_03.jl")
include("a_initialize_phase/create_description.jl")
include("a_initialize_phase/create_object.jl")
include("z_python_auxiliary_functions/analye_py_obj.jl")
include("examples/gnpy_object_descriptions.jl")

end


