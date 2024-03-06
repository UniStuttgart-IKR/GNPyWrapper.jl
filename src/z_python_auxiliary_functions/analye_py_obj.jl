# # counter = 0
# # for i in dir(el_fiber_dummy):
# #     for u in dir(el_fiber_02):
# #         if i == u and not i.startswith("__"):
# #             if not i in list_01 and not u in list_01:
# #                 print("--------")
# #                 counter = counter + 1
# #                 print("counter: " + str(counter))
# #                 print(i)
# #                 #print(type(i))
# #                 print(getattr(el_fiber_02, i))
# #                 print(type(getattr(el_fiber_02, i)))
# #                 print("--------")
# #                 #print(u)
# #                 #print(type(u))
# #                 #print(getattr(el_fiber_02, u))
# #                 #el_fiber_dummy.i = getattr(el_fiber_02, u)



"""
$(TYPEDSIGNATURES)

TOBE FILLED OUT
"""
function py_dir_funct(py_object, py_modules, display, return_list)


    if display
        for i in py_modules["builtins"].dir(py_object)
            println(i)
        end
        return
    end

    if return_list
        attr_list = []
    
        for i in py_modules["builtins"].dir(py_object)
            push!(attr_list,i)
        end
        return attr_list
    end
end

"""
$(TYPEDSIGNATURES)

TOBE FILLED OUT
"""
function py_dir_funct_02(py_object, py_modules, display, return_list)


    if display
        for i in py_modules["builtins"].dir(py_object)
            if !startswith(string(i), "__")
                println(string(i))
            end
        end
        return nothing
    end

    if return_list
        attr_list = []
    
        for i in py_modules["builtins"].dir(py_object)
            if !startswith(string(i), "__")
                push!(attr_list,string(i))
            end
            
        end
        return attr_list
    end
end

"""
$(TYPEDSIGNATURES)

TOBE FILLED OUT
"""
function py_get_attr(py_object, list_of_attr,  py_modules, display, return_list)
    # println("--------------------- ")

    # println("BEGIN GET ATTRIBUTE ")

    if display
        #println("test-01")
        for i in list_of_attr
            println(i)
            println(py_modules["builtins"].type(py_modules["builtins"].getattr(py_object,i)))

            println(py_modules["builtins"].getattr(py_object,i))
        end

        # println("--------------------- ")

        # println("END GET ATTRIBUTE ")
        # println("--------------------- ")
        # println("--------------------- ")

        return nothing

    end


    if return_list
    return nothing
    end


end

function py_set_attr(py_object, list_of_attr, py_modules, display, return_list)

    if display
        println("test-02")
        for i in list_of_attr                
            println(i)
            py_modules["builtins"].setattr(py_object,i, nothing)
        end

        return nothing

    end


    if return_list
    return nothing
    end

end

# function rm_attr_items(original_attr_list, rm_items_list)

#     original_attr_list


# end

# function repr_all_attr(py_object, py_modules, display, return_list)

#     if display
#         for i in py_modules["builtins"].dir(py_object)
#             println(i)
#             println()
#         end
#         return
#     end

# end