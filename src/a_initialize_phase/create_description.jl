
"""
$(TYPEDSIGNATURES)

creates fiber description in julia dictionary format
"""
function fiber_des(original_fiber_object, attr_list,fiber_params_attr_list, py_modules)

    # attr_list_fiber_rm_methods = ["alpha","beta2","beta3", "chromatic_dispersion","cr","gamma", "interpolate_parameter_over_spectrum", "loss_coef_func", "propagate", "update_pref"]


    complete_fiber_description_dict = Dict()
    for i in attr_list
        if i == "params"
            #println("IN PARAMS DES")
            complete_fiber_description_dict[string(i)] = fiberparams_des(
                py_modules["builtins"].getattr(original_fiber_object, string(i)),
                fiber_params_attr_list,
                py_modules
                )

        else
            complete_fiber_description_dict[string(i)] = py_modules["builtins"].getattr(original_fiber_object, string(i))
        end
        
    end

    return complete_fiber_description_dict
end

"""
$(TYPEDSIGNATURES)

creates fiber description in julia dictionary format
"""

# using PythonCall

# numpy_py = pyimport(numpy)

function fiberparams_des(original_fiberparams_object, attr_list, py_modules)

    complete_fiberparams_description_dict = Dict()
    for i in attr_list

        complete_fiberparams_description_dict[string(i)] = py_modules["builtins"].getattr(original_fiberparams_object, string(i))
        
    end

    return complete_fiberparams_description_dict
end


"""
$(TYPEDSIGNATURES)

creates Transceiver description in julia dictionary format
"""
function transceiver_des(original_transceiver_object, attr_list,py_modules)


    transceiver_dict = Dict()

    for i in attr_list

        transceiver_dict[string(i)] = py_modules["builtins"].getattr(original_transceiver_object, string(i))
        
    end

    return transceiver_dict
end

"""
$(TYPEDSIGNATURES)

creates Edfa description in julia dictionary format
"""
function edfa_des(original_edfa_object,attr_list, attr_list_edfa_params, attr_list_edfa_operational, py_modules)


    edfa_dict = Dict()

    for i in attr_list

        if i == "params"

            edfa_dict[string(i)] = edfa_params_des(
                py_modules["builtins"].getattr(original_edfa_object, string(i)),
                attr_list_edfa_params,
                py_modules

            ) 


        elseif i == "operational"
            edfa_dict[string(i)] = edfa_params_des(
                py_modules["builtins"].getattr(original_edfa_object, string(i)),
                attr_list_edfa_operational,
                py_modules)
        else

            edfa_dict[string(i)] = py_modules["builtins"].getattr(original_edfa_object, string(i))
        end
    end

  


    return edfa_dict
end

"""
$(TYPEDSIGNATURES)

creates Edfa description in julia dictionary format
"""
function edfa_operational_des(original_edfa_operational_object, attr_list, py_modules)




    edfa_operational_dict = Dict()

    for i in attr_list

        edfa_operational_dict[string(i)] = py_modules["builtins"].getattr(original_edfa_operational_object, string(i))
        
    end


    return edfa_operational_dict

end 
"""
$(TYPEDSIGNATURES)

creates Edfa description in julia dictionary format
"""
function edfa_params_des(original_edfa_params_object, attr_list, py_modules)

    edfa_params_dict = Dict()

    #TODO original_edfa_params_object.nf_model #TODO # attention! # here must be a dictionary not an object
    
    for i in attr_list

        edfa_params_dict[string(i)] = py_modules["builtins"].getattr(original_edfa_params_object, string(i))
        
    end

    return edfa_params_dict
end

# TODO
# fused, 
# roadm
# spectral information TODO

"""
$(TYPEDSIGNATURES)

creates Edfa description in julia dictionary format
"""
function roadm_des(original_roadm_object, attr_list, attr_list_roadm_params, py_modules)


    roadm_dict = Dict()

    for i in attr_list

        if i == "params"

            roadm_dict[string(i)] = roadm_params_des(
                    py_modules["builtins"].getattr(original_roadm_object, string(i)),
                    attr_list_roadm_params,
                    py_modules

                ) 

        else

            roadm_dict[string(i)] = py_modules["builtins"].getattr(original_roadm_object, string(i))
        
        end
        
    end

    return roadm_dict

end

"""
$(TYPEDSIGNATURES)

creates Edfa description in julia dictionary format
"""
function roadm_params_des(original_roadm_params_object, attr_list, py_modules)

    roadm_params_dict = Dict()


    for i in attr_list

        roadm_params_dict[string(i)] = py_modules["builtins"].getattr(original_roadm_params_object, string(i))
        
    end

    return roadm_params_dict
end

# """
# $(TYPEDSIGNATURES)

# creates Edfa description in julia dictionary format
# """
# function roadm_ref_carrier_des(original_roadm_ref_carrier_object)

#     roadm_ref_carrier_dict = Dict()

#     roadm_ref_carrier_dict["baud_rate"] = original_roadm_ref_carrier_object.baud_rate
#     roadm_ref_carrier_dict["slot_width"] = original_roadm_ref_carrier_object.slot_width


#     return roadm_ref_carrier_dict
# end

"""
$(TYPEDSIGNATURES)

creates Edfa description in julia dictionary format
"""
function fused_des(original_fused_object, attr_list, attr_list_fused_params, py_modules)

    fused_dict = Dict()



    for i in attr_list

        if i == "params"

            fused_dict[string(i)] = fused_params_des(
                py_modules["builtins"].getattr(original_fused_object, string(i)),
                attr_list_fused_params,
                py_modules
            )
        else

            fused_dict[string(i)] = py_modules["builtins"].getattr(original_fused_object, string(i))
        
        end
        
    end

    return fused_dict
end

"""
$(TYPEDSIGNATURES)

creates Edfa description in julia dictionary format
"""
function fused_params_des(original_fused_params_object, attr_list, py_modules)

    fused_params_dict = Dict()

    
    for i in attr_list

        fused_params_dict[string(i)] = py_modules["builtins"].getattr(original_fused_params_object, string(i))
        
    end

    return fused_params_dict
end