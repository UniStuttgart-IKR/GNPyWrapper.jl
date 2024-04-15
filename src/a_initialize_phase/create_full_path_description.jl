



"""
$(TYPEDSIGNATURES)

creates full path description from cli example 02

"""
function create_full_path_des_from_cli_examples_02(equipment, network, pw_input , py_modules)




    path, path_01 = py_modules["cli_examples_02"].half_transmission_main_example(equipment, network, pw_input, false, false, false, false)


    # attribute lists

    # for trx

    attr_list_trx = ["baud_rate", "chromatic_dispersion", "latency", "metadata", "name", "operational", "osnr_ase", "osnr_ase_01nm", "osnr_nli", "params", "passive", "pdl", "penalties", "pmd", "propagated_labels", "snr", "total_penalty", "uid"]

    # for fiber
    attr_fiber_lists_dict = Dict(

    "attr_list_fiber" => ["lumped_losses", "metadata", "name", "operational", "params", "passive", "pch_out_db", "propagated_labels", "type_variety", "uid", "z_lumped_losses"],
    "attr_list_fiber_params" => ["_att_in", "_con_in", "_con_out", "_contrast", "_core_radius", "_dispersion", "_dispersion_slope", "_effective_area", "_f_dispersion_ref", "_f_loss_ref", "_g0", "_gamma", "_latency", "_length", "_loss_coef", "_lumped_losses", "_n1", "_n2", "_pmd_coef", "_raman_reference_frequency", "_ref_frequency", "_ref_wavelength", "att_in", "con_in", "con_out", "length"]
    )

    # for edfa
    attr_edfa_lists_dict = Dict(

        "attr_list_edfa" => ["att_in", "channel_freq", "delta_p", "effective_gain", "effective_pch_out_db", "gprofile", "interpol_dgt", "interpol_gain_ripple", "interpol_nf_ripple", "metadata", "name", "nch", "nf", "operational", "out_voa", "params", "passive", "pin_db", "pout_db", "propagated_labels", "target_pch_out_db", "tilt_target", "uid", "variety_list"], #"type_variety"
        "attr_list_edfa_params" => ["advance_configurations_from_json", "allowed_for_design", "bandwidth", "dgt", "dual_stage_model", "f_cent", "f_max", "f_min", "f_ripple_ref", "gain_flatmax", "gain_min", "gain_ripple", "nf0", "nf_coef", "nf_fit_coeff", "nf_max", "nf_min", "nf_model", "nf_ripple", "out_voa_auto", "p_max", "pdl", "pmd", "raman", "tilt_ripple", "type_def", "type_variety"],
        "attr_list_edfa_operational" => ["default_values", "delta_p", "gain_target", "out_voa", "tilt_target"]
    )

    # for roadm

    attr_roadm_lists_dict = Dict(
    # "lat", "latitude","lng", "loc","location","longitude", "to_json", 
    "attr_list_roadm" => ["loss", "metadata", "name", "operational", "params", "passive", "per_degree_pch_out_dbm", "per_degree_pch_psd", "per_degree_pch_psw", "propagated_labels", "ref_effective_loss", "ref_pch_out_dbm", "restrictions", "target_out_mWperSlotWidth", "target_pch_out_dbm", "target_psd_out_mWperGHz", "type_variety", "uid"],
    
    "attr_list_roadm_params" => ["add_drop_osnr", "pdl", "per_degree_pch_out_db", "per_degree_pch_psd", "per_degree_pch_psw", "pmd", "restrictions", "target_out_mWperSlotWidth", "target_pch_out_db", "target_psd_out_mWperGHz"]
    )

    # for fused

    attr_fused_lists_dict = Dict(
    # "lat", "latitude", "lng", "loc", "location", "longitude", "to_json"
    "attr_list_fused" => [ "loss", "metadata", "name", "operational", "params", "passive", "uid"],
    "attr_list_fused_params" => ["loss"]

    )

    # all attribute lists in one dict

    complete_attr_lists_dict = Dict(
        "Transceiver" => attr_list_trx,
        "Fiber" => attr_fiber_lists_dict,
        "Edfa" => attr_edfa_lists_dict,
        "Roadm" => attr_roadm_lists_dict,
        "Fused" => attr_fused_lists_dict,
        "RamanFiber" => "not provided (yet?)"
    )

    path_description = []

    
    for el in path_01
        #println(el["type"])



        # go through attributes and remove methods


        if string(el["type"]) == "Fiber"


            dummy_dict = Dict(
                "type" => string(el["type"]),
                "description" => fiber_des(el["object"], attr_fiber_lists_dict["attr_list_fiber"], attr_fiber_lists_dict["attr_list_fiber_params"],py_modules)

                )

           
        elseif string(el["type"]) == "Transceiver"

            dummy_dict = Dict(
                "type" => string(el["type"]),
                "description" => transceiver_des(el["object"], attr_list_trx, py_modules)
                )
    





        elseif string(el["type"]) == "Edfa"

            dummy_dict = Dict(
                "type" => string(el["type"]),
                "description" => edfa_des(el["object"], attr_edfa_lists_dict["attr_list_edfa"], attr_edfa_lists_dict["attr_list_edfa_params"],attr_edfa_lists_dict["attr_list_edfa_operational"], py_modules)

                )
    




        elseif string(el["type"]) == "Roadm"

            dummy_dict = Dict(
                "type" => string(el["type"]),
                "description" => roadm_des(el["object"],attr_roadm_lists_dict["attr_list_roadm"], attr_roadm_lists_dict["attr_list_roadm_params"], py_modules)

                )
    

   

        elseif string(el["type"]) == "Fused"
            dummy_dict = Dict(
                "type" => string(el["type"]),
                "description" =>fused_des(el["object"],attr_fused_lists_dict["attr_list_fused"], attr_fused_lists_dict["attr_list_fused_params"], py_modules)

                )
    




        else
            dummy_dict = Dict(
                "type" => string(el["type"]),
                "description" => "not yet in scope of the work, probably a raman fiber ..."
                )
    



        end

        push!(path_description, dummy_dict)

    end

    return path_description, complete_attr_lists_dict

end 
