# using PythonCall

# elements = pyimport("gnpy.core.elements")

# numpy= pyimport("numpy")
# array = numpy.array

# Currently errors appear if you use PythonCall functions

# ideas to solve this problem:
# 1. maybe don't "import" PythonCall with "using" statement, use another way
# 2. try to use PyCall instead of PythonCall

DEBUG_01 = true
"""
$(TYPEDSIGNATURES)

creates fiber description in julia dictionary format
"""
function fiber_obj(complete_fiber_description_dict,list_of_attr,fiber_params_attr_list, py_modules)

    # attr_list_fiber_rm_no_setters_available =  ["lat","latitude","lng","loc", "location", "longitude","loss"]

   
    
    fiber_default_dict = Dict(
        "uid" => "dummy fiber",
        "params" => Dict(
            "att_in"=> 0,
            "length" => 80000.0, 
            "length_units" => "km",
            "pmd_coef" => 1.265e-15,
            "loss_coef"=> 0.2,
            "con_in"=> 0.5,
            "con_out"=> 0.5,
            "lumped_losses"=> py_modules["numpy"].array([], dtype="float64"),
            "ref_frequency"=> 193414489032258.06
        )
    )

    element_fiber = py_modules["elements"].Fiber(
        uid = fiber_default_dict["uid"],
        params = fiber_default_dict["params"]
        )

    for i in list_of_attr
        if DEBUG_01
            println(i)                
        end

        if i == "params"
            #println("IN PARAMS")
            py_modules["builtins"].setattr(
                element_fiber, 
                i,
                fiberparams_obj(
                    complete_fiber_description_dict[i],
                    fiber_params_attr_list,
                    py_modules
                    ))
        else
            py_modules["builtins"].setattr(element_fiber, i,complete_fiber_description_dict[i])
        end
        
    end


    return element_fiber
end

"""
$(TYPEDSIGNATURES)

creates fiber description in julia dictionary format
"""

# using PythonCall

# numpy_py = pyimport(numpy)

function fiberparams_obj(complete_fiberparams_description_dict, list_of_attr, py_modules)

    # create dummy FiberParams

    fiber_params_object = py_modules["parameters"].FiberParams(
        length = 10,
        length_units = "km",
        pmd_coef = 1.265e-15,
        loss_coef = 0.0002
    )


    for i in list_of_attr
        #println(i)
        py_modules["builtins"].setattr(fiber_params_object, i ,complete_fiberparams_description_dict[i])
    end

   

    return fiber_params_object
end


"""
$(TYPEDSIGNATURES)

creates Transceiver description in julia dictionary format
"""
function transceiver_obj(complete_trx_description_dict, list_of_attr, py_modules)


    element_trx = py_modules["elements"].Transceiver(
        uid = "dummy trx_uid"
    )
    
    for i in list_of_attr
        #println(i)
        py_modules["builtins"].setattr(element_trx, i ,complete_trx_description_dict[i])
    end


    return element_trx
end

"""
$(TYPEDSIGNATURES)

creates Edfa description in julia dictionary format
"""
function edfa_obj(complete_edfa_description_dict, list_of_attr, attr_list_edfa_params, attr_list_edfa_operational, py_modules)

    Model_vg = py_modules["json_io"].Model_vg

    Model_fg = py_modules["json_io"].Model_fg
    Model_openroadm_ila = py_modules["json_io"].Model_openroadm_ila
    Model_hybrid = py_modules["json_io"].Model_hybrid
    Model_dual_stage = py_modules["json_io"].Model_dual_stage

    element_edfa  = py_modules["elements"].Edfa(
        uid = "dummy edfa",
        params = Dict(
            "type_variety" => "dummy type variety",
            "type_def" => "variable_gain",
            "f_min" => 191350000000000.0,
            "f_max" => 196100000000000.0,
            "f_ripple_ref"  => nothing,
            "gain_flatmax" => 16,
            "gain_min" => 8,
            "gain_ripple" => [0.0],
            "tilt_ripple" => 0,
            "p_max" => 23,
            "nf_model" => Model_vg(nf1=6.291600683685861, nf2=6.5916006836858605, delta_p=2.615736110359066, orig_nf_min=6.5, orig_nf_max=11),
            "nf_min" => nothing,
            "nf_max" => nothing,
            "nf_coef" => nothing,
            "nf0" => nothing,
            "nf_fit_coeff" => nothing,
            "nf_ripple" => [0.0],
            "out_voa_auto" => false,
            "dual_stage_model" => nothing,
            "pmd" => 0,
            "pdl" => 0,
            "raman" => false,
            "dgt" => [1.0,
            1.017807767853702,
            1.0356155337864215,
            1.0534217504465226,
            1.0712204022764056,
            1.0895983485572227,
            1.108555289615659,
            1.1280891949729075,
            1.1476135933863398,
            1.1672278304018044,
            1.1869318618366975,
            1.2067249615595257,
            1.2264996957264114,
            1.2428104897182262,
            1.2556591482982988,
            1.2650555289898042,
            1.2744470198196236,
            1.2838336236692311,
            1.2932153453410835,
            1.3040618749785347,
            1.316383926863083,
            1.3301807335621048,
            1.3439818461440451,
            1.3598972673004606,
            1.3779439775587023,
            1.3981208704326855,
            1.418273806730323,
            1.4340878115214444,
            1.445565137158368,
            1.45273959485914,
            1.4599103316162523,
            1.4670307626366115,
            1.474100442252211,
            1.48111939735681,
            1.488134243479226,
            1.495145456062699,
            1.502153039909686,
            1.5097346239790443,
            1.5178910621476225,
            1.5266220576235803,
            1.5353620432989845,
            1.545374152761467,
            1.5566577309558969,
            1.569199764184379,
            1.5817353179379183,
            1.5986915141218316,
            1.6201194134191075,
            1.6460167077689267,
            1.6719047669939942,
            1.6918150918099673,
            1.7057507692361864,
            1.7137640932265894,
            1.7217732861435076,
            1.7297783508684146,
            1.737780757913635,
            1.7459181197626403,
            1.7541903672600494,
            1.7625959636196327,
            1.7709972329654864,
            1.7793941781790852,
            1.7877868031023945,
            1.7961751115773796,
            1.8045606557581335,
            1.8139629377087627,
            1.824381436842932,
            1.835814081380705,
            1.847275503201129,
            1.862235672444246,
            1.8806927939516411,
            1.9026104247588487,
            1.9245345552113182,
            1.9482128147680253,
            1.9736443063300082,
            2.0008103857988204,
            2.0279625371819305,
            2.055100772005235,
            2.082225099873648,
            2.1183028432496016,
            2.16337565384239,
            2.2174389328192197,
            2.271520771371253,
            2.322373696229342,
            2.3699990328716107,
            2.414398437185221,
            2.4587748041127506,
            2.499446286796604,
            2.5364027376452056,
            2.5696460593920065,
            2.602860350286428,
            2.630396440815385,
            2.6521732021128046,
            2.6681935771243177,
            2.6841217449620203,
            2.6947834587664494,
            2.705443819238505,
            2.714526681131686],
            "advance_configurations_from_json" => nothing,
            "allowed_for_design" => true
            
        )


        )
        
    for i in list_of_attr
        if DEBUG_01
            println(i)                
        end

        if i == "params"
            #println("IN PARAMS")
            py_modules["builtins"].setattr(
                element_edfa, 
                i,
                edfa_params_obj(
                    complete_edfa_description_dict[i],
                    attr_list_edfa_params,
                    py_modules
                    ))
        elseif i == "operational"
            py_modules["builtins"].setattr(
                element_edfa, 
                i,
                edfa_operational_obj(
                    complete_edfa_description_dict[i],
                    attr_list_edfa_operational,
                    py_modules
                    ))

        else
            py_modules["builtins"].setattr(element_edfa, i,complete_edfa_description_dict[i])
        end
        
    end


    
  


    return element_edfa
end
"""
$(TYPEDSIGNATURES)

creates Edfa description in julia dictionary format
"""
function edfa_operational_obj(complete_edfa_operational_description_dict, list_of_attr, py_modules)

    element_edfa_operational = py_modules["parameters"].EdfaOperational(


    )


    for i in list_of_attr
        # println(i)
        py_modules["builtins"].setattr(element_edfa_operational, i ,complete_edfa_operational_description_dict[i])
    end



    return element_edfa_operational

end 
"""
$(TYPEDSIGNATURES)

creates Edfa description in julia dictionary format
"""
function edfa_params_obj(complete_edfa_params_description_dict, list_of_attr, py_modules)

    Model_vg = py_modules["json_io"].Model_vg

    Model_fg = py_modules["json_io"].Model_fg
    Model_openroadm_ila = py_modules["json_io"].Model_openroadm_ila
    Model_hybrid = py_modules["json_io"].Model_hybrid
    Model_dual_stage = py_modules["json_io"].Model_dual_stage


    element_edfa_params = py_modules["parameters"].EdfaParams(
        type_variety = "dummy type variety",
        type_def = "variable_gain",
        f_min = 191350000000000.0,
        f_max = 196100000000000.0,
        f_ripple_ref  = nothing,
        gain_flatmax = 16,
        gain_min = 8,
        gain_ripple = [0.0],
        tilt_ripple = 0,
        p_max = 23,
        nf_model = Model_vg(nf1=6.291600683685861, nf2=6.5916006836858605, delta_p=2.615736110359066, orig_nf_min=6.5, orig_nf_max=11),
        nf_min = nothing,
        nf_max = nothing,
        nf_coef = nothing,
        nf0 = nothing,
        nf_fit_coeff = nothing,
        nf_ripple = [0.0],
        out_voa_auto = false,
        dual_stage_model = nothing,
        pmd = 0,
        pdl = 0,
        raman = false,
        dgt = [1.0,
        1.017807767853702,
        1.0356155337864215,
        1.0534217504465226,
        1.0712204022764056,
        1.0895983485572227,
        1.108555289615659,
        1.1280891949729075,
        1.1476135933863398,
        1.1672278304018044,
        1.1869318618366975,
        1.2067249615595257,
        1.2264996957264114,
        1.2428104897182262,
        1.2556591482982988,
        1.2650555289898042,
        1.2744470198196236,
        1.2838336236692311,
        1.2932153453410835,
        1.3040618749785347,
        1.316383926863083,
        1.3301807335621048,
        1.3439818461440451,
        1.3598972673004606,
        1.3779439775587023,
        1.3981208704326855,
        1.418273806730323,
        1.4340878115214444,
        1.445565137158368,
        1.45273959485914,
        1.4599103316162523,
        1.4670307626366115,
        1.474100442252211,
        1.48111939735681,
        1.488134243479226,
        1.495145456062699,
        1.502153039909686,
        1.5097346239790443,
        1.5178910621476225,
        1.5266220576235803,
        1.5353620432989845,
        1.545374152761467,
        1.5566577309558969,
        1.569199764184379,
        1.5817353179379183,
        1.5986915141218316,
        1.6201194134191075,
        1.6460167077689267,
        1.6719047669939942,
        1.6918150918099673,
        1.7057507692361864,
        1.7137640932265894,
        1.7217732861435076,
        1.7297783508684146,
        1.737780757913635,
        1.7459181197626403,
        1.7541903672600494,
        1.7625959636196327,
        1.7709972329654864,
        1.7793941781790852,
        1.7877868031023945,
        1.7961751115773796,
        1.8045606557581335,
        1.8139629377087627,
        1.824381436842932,
        1.835814081380705,
        1.847275503201129,
        1.862235672444246,
        1.8806927939516411,
        1.9026104247588487,
        1.9245345552113182,
        1.9482128147680253,
        1.9736443063300082,
        2.0008103857988204,
        2.0279625371819305,
        2.055100772005235,
        2.082225099873648,
        2.1183028432496016,
        2.16337565384239,
        2.2174389328192197,
        2.271520771371253,
        2.322373696229342,
        2.3699990328716107,
        2.414398437185221,
        2.4587748041127506,
        2.499446286796604,
        2.5364027376452056,
        2.5696460593920065,
        2.602860350286428,
        2.630396440815385,
        2.6521732021128046,
        2.6681935771243177,
        2.6841217449620203,
        2.6947834587664494,
        2.705443819238505,
        2.714526681131686],
        advance_configurations_from_json = nothing,
        allowed_for_design = true
        
    )
    
    for i in list_of_attr
        #println(i)
        py_modules["builtins"].setattr(element_edfa_params, i ,complete_edfa_params_description_dict[i])
    end



    #TODO original_edfa_params_object.nf_model #TODO # attention! # here must be a dictionary not an object
    



    return element_edfa_params
end

# TODO
# fused, 
# roadm
# spectral information TODO

"""
$(TYPEDSIGNATURES)

creates Edfa description in julia dictionary format
"""
function roadm_obj(complete_roadm_description_dict,list_of_attr, attr_list_roadm_params, py_modules)

    element_roadm  = py_modules["elements"].Roadm(
        
    
        uid = "dummy uid",
        params = Dict(
            "add_drop_osnr" => 38,
            "pmd" => 0,
            "pdl" => 0,
            "restrictions" => nothing
        )
    
    
    
    )

    for i in list_of_attr
        if DEBUG_01
            println(i)                
        end

        if i == "params"
            #println("IN PARAMS")
            py_modules["builtins"].setattr(
                element_roadm, 
                i,
                roadm_params_obj(
                    complete_roadm_description_dict[i],
                    attr_list_roadm_params,
                    py_modules
                    ))

        else
            py_modules["builtins"].setattr(element_roadm, i,complete_roadm_description_dict[i])
        end
        
    end


    return element_roadm
    
end

"""
$(TYPEDSIGNATURES)

creates Edfa description in julia dictionary format
"""
function roadm_params_obj(complete_roadm_params_description_dict, list_of_attr,py_modules)

    element_roadm_params =  py_modules["parameters"].RoadmParams(
        add_drop_osnr = 38,
        pmd = 0,
        pdl = 0,
        restrictions = nothing
    )

    for i in list_of_attr
        #println(i)
        py_modules["builtins"].setattr(element_roadm_params, i ,complete_roadm_params_description_dict[i])
    end

    return element_roadm_params
end

# """
# $(TYPEDSIGNATURES)

# creates Edfa description in julia dictionary format
# """
# function roadm_ref_carrier_obj(original_roadm_ref_carrier_object)

#     roadm_ref_carrier_dict = Dict()

#     roadm_ref_carrier_dict["baud_rate"] = original_roadm_ref_carrier_object.baud_rate
#     roadm_ref_carrier_dict["slot_width"] = original_roadm_ref_carrier_object.slot_width


#     return roadm_ref_carrier_dict
# end

"""
$(TYPEDSIGNATURES)

creates Edfa description in julia dictionary format
"""
function fused_obj(complete_fused_description_dict,list_of_attr,attr_list_fused_params , py_modules)

 
    element_fused = py_modules["elements"].Fused(
        uid = "dummy fused uid"
    )

    for i in list_of_attr
        if DEBUG_01
            println(i)                
        end

        if i == "params"
            #println("IN PARAMS")
            py_modules["builtins"].setattr(
                element_fused, 
                i,
                roadm_params_obj(
                    complete_fused_description_dict[i],
                    attr_list_fused_params,
                    py_modules
                    ))

        else
            py_modules["builtins"].setattr(element_fused, i,complete_fused_description_dict[i])
        end
        
    end



    return element_fused 
end

"""
$(TYPEDSIGNATURES)

creates Edfa description in julia dictionary format
"""
function fused_params_obj(complete_fused_params_description_dict, list_of_attr, py_modules)

    element_fused_params =  py_modules["parameters"].FusedParams()

    for i in list_of_attr
        #println(i)
        py_modules["builtins"].setattr(element_fused_params, i ,complete_fused_params_description_dict[i])
    end

    return element_fused_params
end

"""
$(TYPEDSIGNATURES)

creates Edfa description in julia dictionary format
"""
function spectral_information_obj(si_dictionary, py_modules)

    
    return py_modules["info"].SpectralInformation(
        frequency=si_dictionary["frequency"], 
        slot_width=si_dictionary["slot_width"],
        signal= si_dictionary["signal"], 
        nli= si_dictionary["nli"],
        ase= si_dictionary["ase"],
        baud_rate=si_dictionary["baud_rate"], 
        roll_off=si_dictionary["roll_off"],
        chromatic_dispersion= si_dictionary["chromatic_dispersion"],  
        pmd=si_dictionary["pmd"], 
        pdl=si_dictionary["pdl"], 
        latency=si_dictionary["latency"],       
        delta_pdb_per_channel=si_dictionary["delta_pdb_per_channel"],
        tx_osnr= si_dictionary["tx_osnr"],
        ref_power= si_dictionary["ref_power"], 
        label= si_dictionary["label"]
    )
end