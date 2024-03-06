



"""
$(TYPEDSIGNATURES)

Generates from full path description full path with gnpy element/objects
"""
function create_full_real_path(path_description, attr_lists, py_modules)

    real_path =[]

    for i in 1:length(path_description)
        #println(i)
    
        if string(getindex(path_description,i)["type"]) == "Roadm"
    
        
            roadm_obj_01 = roadm_obj(
                getindex(path_description,i)["description"], 
                attr_lists["Roadm"]["attr_list_roadm"], 
                attr_lists["Roadm"]["attr_list_roadm_params"],
                py_modules)
    
            push!(real_path, roadm_obj_01)
    
        
        
        elseif string(getindex(path_description,i)["type"]) == "Fused"
    
        
            fused_obj_01 = fused_obj(
                getindex(path_description,i)["description"], 
                attr_lists["Fused"]["attr_list_fused"], 
                attr_lists["Fused"]["attr_list_fused_params"],
                py_modules)
    
    
            push!(real_path, fused_obj_01)
    
        
        
        elseif string(getindex(path_description,i)["type"]) == "Fiber"
    
        
            fiber_obj_01 = fiber_obj(
                getindex(path_description,i)["description"], 
                attr_lists["Fiber"]["attr_list_fiber"], 
                attr_lists["Fiber"]["attr_list_fiber_params"],
                py_modules)
    
    
            push!(real_path, fiber_obj_01)
    
        
    
        elseif string(getindex(path_description,i)["type"]) == "Transceiver"
    
        
            trx_obj_01 = transceiver_obj(
                getindex(path_description,i)["description"], 
                attr_lists["Transceiver"],
                py_modules)
    
    
            push!(real_path, trx_obj_01)
    
        
    
        elseif string(getindex(path_description,i)["type"]) == "Edfa"
    
        
            edfa_obj_01 = edfa_obj(
                getindex(path_description,i)["description"], 
                attr_lists["Edfa"]["attr_list_edfa"], 
                attr_lists["Edfa"]["attr_list_edfa_params"],
                attr_lists["Edfa"]["attr_list_edfa_operational"],
                py_modules)
    
    
            push!(real_path, edfa_obj_01)
            
        else 

            push!(real_path, "ERROR PROBABLY RAMAN FIBER") # not yet implemented

        end

    end
    return real_path
end