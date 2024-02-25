# using PythonCall

# elements = pyimport("gnpy.core.elements")

# numpy= pyimport("numpy")
# array = numpy.array

# Currently errors appear if you use PythonCall functions

# ideas to solve this problem:
# 1. maybe don't "import" PythonCall with "using" statement, use another way
# 2. try to use PyCall instead of PythonCall

DEBUG_01 = false
"""
$(TYPEDSIGNATURES)

creates fiber description in julia dictionary format
"""
function fiber_example_des(key,py_modules)

    fiber_example_dict = Dict()


    # the following dictionary was created by using fiber_des function and editting it by hand

    fiber_example_dict["example_01"] = Dict(
        "lat" =>  1, 
        "passive" => true, 
        "propagated_labels" => [""], 
        "pch_out_db" => nothing, 
        "name" => "Span1", 
        "location" => nothing, #Location(latitude=1, longitude=0, city=None, region='')>, 
        "lng" => nothing, #<py 0>, 
        "loc" => nothing, #<py Location(latitude=1, longitude=0, city=None, region='')>, 
        "type_variety" => "SSMF", 
        "uid" => "Span1", 
        "z_lumped_losses" => py_modules["numpy"].array([], dtype="float64"), 
        "lumped_losses" => py_modules["numpy"].array([], dtype="float64"), 
        "params" => Dict(
            "_dispersion" =>py_modules["numpy"].array(1.67e-05), 
            "_f_loss_ref" => py_modules["numpy"].array(1.93414489e+14), 
            "con_out" => 0.5, 
            "con_in" => 0.5, 
            "att_in" => 0, 
            "length" => 80000.0, 
            "_raman_reference_frequency" => 206184634112792, 
            "_gamma" => 0.0012698236920844867, 
            "_ref_frequency" => 193414489032258.06, 
            "_length" => 80000.0, 
            "_g0" => py_modules["numpy"].array(
                [
                    0.00000000e+00, 1.12351610e-05, 3.47838074e-05, 5.79356636e-05,
                    8.06921680e-05, 9.79845709e-05, 1.10454361e-04, 1.18735302e-04,
                    1.24736889e-04, 1.30110053e-04, 1.41001273e-04, 1.46383247e-04,
                    1.57011792e-04, 1.70765865e-04, 1.88408911e-04, 2.05914127e-04,
                    2.24074028e-04, 2.47508283e-04, 2.77729174e-04, 3.08044243e-04,
                    3.34764439e-04, 3.56481704e-04, 3.77127256e-04, 3.96269124e-04,
                    4.10955175e-04, 4.18718761e-04, 4.19511263e-04, 4.17025384e-04,
                    4.13565369e-04, 4.07726048e-04, 3.83671291e-04, 4.08564283e-04,
                    3.69571936e-04, 3.14442090e-04, 2.16074535e-04, 1.23097823e-04,
                    8.95457457e-05, 7.52470400e-05, 7.19806145e-05, 8.87961158e-05,
                    9.30812065e-05, 9.37058268e-05, 8.45719619e-05, 6.90585286e-05,
                    4.50407159e-05, 3.36521245e-05, 3.02292475e-05, 2.69376939e-05,
                    2.60020897e-05, 2.82958958e-05, 3.08667558e-05, 3.66024657e-05,
                    5.80610307e-05, 6.54797937e-05, 6.25022715e-05, 5.37806442e-05,
                    3.94996621e-05, 2.68120644e-05, 2.33038554e-05, 1.79140757e-05,
                    1.52472424e-05, 1.32707565e-05, 1.06541760e-05, 9.84649374e-06,
                    9.13999627e-06, 9.08971012e-06, 1.04227525e-05, 1.50419271e-05,
                    1.77838232e-05, 2.15810815e-05, 2.03744008e-05, 1.81939341e-05,
                    1.31862121e-05, 9.65352116e-06, 8.62698322e-06, 9.18688016e-06,
                    1.01737784e-05, 1.08017817e-05, 1.03903588e-05, 9.30040333e-06,
                    8.30809173e-06, 6.90650401e-06, 5.52238029e-06, 3.90648708e-06,
                    2.22908227e-06, 1.55796177e-06, 9.77218716e-07, 3.23477236e-07,
                    1.60602454e-07, 7.97306386e-08
                    ]
                    ), 
            "_contrast" => 0.0030427418913107004, 
            "_att_in" => 0, 
            "_core_radius" => 4.2e-06, 
            "_n2" => 2.6e-20, 
            "_pmd_coef" => 1.265e-15, 
            "_con_out" => 0.5, 
            "_latency" => 0.0003917376734007098, 
            "_lumped_losses" => py_modules["numpy"].array([], dtype="float64"), 
            "_loss_coef" => py_modules["numpy"].array([0.0002]), 
            "_n1" => 1.468, 
            "_con_in" => 0.5, 
            "_effective_area" => 8.3e-11, 
            "_dispersion_slope" => nothing, 
            "_ref_wavelength" => 1.55e-06, 
            "_f_dispersion_ref" => py_modules["numpy"].array(1.93414489e+14)
            ), 
        "loss" => 17.0, 
        "latitude" => 1, 
        "operational" => nothing, 
        "longitude" => nothing , #0, 
        "metadata" => nothing , #<py {'location': Location(latitude=1, longitude=0, city=None, region='')}>
        )


    # for generating edfa obj use the following list of attr:

    attr_fiber_lists_dict = Dict(

        "attr_list_fiber" => ["lumped_losses", "metadata", "name", "operational", "params", "passive", "pch_out_db", "propagated_labels", "type_variety", "uid", "z_lumped_losses"],
        "attr_list_fiber_params" => ["_att_in", "_con_in", "_con_out", "_contrast", "_core_radius", "_dispersion", "_dispersion_slope", "_effective_area", "_f_dispersion_ref", "_f_loss_ref", "_g0", "_gamma", "_latency", "_length", "_loss_coef", "_lumped_losses", "_n1", "_n2", "_pmd_coef", "_raman_reference_frequency", "_ref_frequency", "_ref_wavelength", "att_in", "con_in", "con_out", "length"]
        )


    return fiber_example_dict[key], attr_fiber_lists_dict
end


function transceiver_example_des(key,py_modules)


    trx_example_dict = Dict()
    # the following dictionary was created by using transceiver_des function and editting it by hand <- this must be automated!!!!!

    
    trx_example_dict["example_01_a"] = Dict(

        "pdl" => nothing, 
        "passive" =>false, 
        "propagated_labels" => [""], 
        "pmd" => nothing, 
        "chromatic_dispersion" => nothing, 
        "name" => "Site_A", 
        "baud_rate" => nothing, 
        "latency" => nothing, 
        "penalties" => Dict(), 
        "osnr_nli" => nothing, 
        "total_penalty" => nothing, 
        "osnr_ase_01nm" => nothing, 
        "uid" => "Site_A", 
        "params" => nothing, 
        "operational" => nothing, 
        "osnr_ase" => nothing, 
        "metadata" => nothing, #<py {'location': Location(latitude=0, longitude=0, city='Site A', region='')}>, 
        "snr" => nothing)

    trx_example_dict["example_01_b"] = Dict(
        "pdl" => nothing, 
        "passive" => false, 
        "propagated_labels" => [""], 
        "pmd" => nothing, 
        "chromatic_dispersion" => nothing, 
        "name" => "Site_B", 
        "baud_rate" => nothing, 
        "latency" => nothing, 
        "penalties" => Dict(), 
        "osnr_nli" => nothing, 
        "total_penalty" => 0, 
        "osnr_ase_01nm" => nothing, 
        "uid" => "Site_B", 
        "params" => nothing, 
        "operational" => nothing, 
        "osnr_ase" => nothing, 
        "metadata" => nothing,# <py {'location': Location(latitude=2, longitude=0, city='Site B', region='')}>, 
        "snr" => nothing)

        #   for generating trx obj use the following list of attr:

        attr_list_trx = ["baud_rate", "chromatic_dispersion", "latency", "metadata", "name", "operational", "osnr_ase", "osnr_ase_01nm", "osnr_nli", "params", "passive", "pdl", "penalties", "pmd", "propagated_labels", "snr", "total_penalty", "uid"]

    return trx_example_dict[key], attr_list_trx

end 


function edfa_example_des(key, py_modules)


    Model_vg = py_modules["json_io"].Model_vg

    Model_fg = py_modules["json_io"].Model_fg
    Model_openroadm_ila = py_modules["json_io"].Model_openroadm_ila
    Model_hybrid = py_modules["json_io"].Model_hybrid
    Model_dual_stage = py_modules["json_io"].Model_dual_stage


    edfa_example_dict = Dict()

    # edfa_example_dict["example_01"] = Dict("a" => 4)

    edfa_example_dict["example_01"] = Dict(

    "pout_db" => nothing, 
    "passive" => false, 
    "propagated_labels" =>[""], 
    "att_in" => nothing, 
    "effective_gain" => 15.0, 
    "name" => "Edfa1", 
    "out_voa" => 0, 
    "effective_pch_out_db" => nothing, 
    "delta_p" => -2, 
    "nch" => nothing, 
    "nf" => nothing, 
    "type_variety" => "std_low_gain", 
    "interpol_dgt" => nothing, 
    "interpol_nf_ripple" => nothing, 
    "target_pch_out_db" => nothing, 
    "tilt_target" => 0, 
    "uid" => "Edfa1", 
    "gprofile" => nothing, 
    "params" => Dict(
        "nf_ripple" => py_modules["numpy"].array([0.]), 
        "pdl" => 0, 
        "out_voa_auto" => false, 
        "nf0" => nothing, 
        "nf_max" => nothing, 
        "bandwidth" => 4750000000000.0, 
        "pmd" => 0, 
        "raman" => false, 
        "f_min" => 191350000000000.0, 
        "allowed_for_design" => true, 
        "f_cent" => 193725000000000.0, 
        "advance_configurations_from_json" => nothing, 
        "f_max" => 196100000000000.0, 
        "dual_stage_model" => nothing, 
        "nf_model" => Model_vg(nf1=6.291600683685861, nf2=6.5916006836858605, delta_p=2.615736110359066, orig_nf_min=6.5, orig_nf_max=11), 
        "f_ripple_ref" => py_modules["numpy"].array([1.9135e+14]), 
        "type_variety" => "std_low_gain", 
        "nf_coef" => nothing, 
        "tilt_ripple" => py_modules["numpy"].array([0]), 
        "p_max" => 23, 
        "nf_fit_coeff" => nothing, 
        "dgt" =>[1.0, 1.017807767853702, 1.0356155337864215, 1.0534217504465226, 1.0712204022764056, 1.0895983485572227, 1.108555289615659, 1.1280891949729075, 1.1476135933863398, 1.1672278304018044, 1.1869318618366975, 1.2067249615595257, 1.2264996957264114, 1.2428104897182262, 1.2556591482982988, 1.2650555289898042, 1.2744470198196236, 1.2838336236692311, 1.2932153453410835, 1.3040618749785347, 1.316383926863083, 1.3301807335621048, 1.3439818461440451, 1.3598972673004606, 1.3779439775587023, 1.3981208704326855, 1.418273806730323, 1.4340878115214444, 1.445565137158368, 1.45273959485914, 1.4599103316162523, 1.4670307626366115, 1.474100442252211, 1.48111939735681, 1.488134243479226, 1.495145456062699, 1.502153039909686, 1.5097346239790443, 1.5178910621476225, 1.5266220576235803, 1.5353620432989845, 1.545374152761467, 1.5566577309558969, 1.569199764184379, 1.5817353179379183, 1.5986915141218316, 1.6201194134191075, 1.6460167077689267, 1.6719047669939942, 1.6918150918099673, 1.7057507692361864, 1.7137640932265894, 1.7217732861435076, 1.7297783508684146, 1.737780757913635, 1.7459181197626403, 1.7541903672600494, 1.7625959636196327, 1.7709972329654864, 1.7793941781790852, 1.7877868031023945, 1.7961751115773796, 1.8045606557581335, 1.8139629377087627, 1.824381436842932, 1.835814081380705, 1.847275503201129, 1.862235672444246, 1.8806927939516411, 1.9026104247588487, 1.9245345552113182, 1.9482128147680253, 1.9736443063300082, 2.0008103857988204, 2.0279625371819305, 2.055100772005235, 2.082225099873648, 2.1183028432496016, 2.16337565384239, 2.2174389328192197, 2.271520771371253, 2.322373696229342, 2.3699990328716107, 2.414398437185221, 2.4587748041127506, 2.499446286796604, 2.5364027376452056, 2.5696460593920065, 2.602860350286428, 2.630396440815385, 2.6521732021128046, 2.6681935771243177, 2.6841217449620203, 2.6947834587664494, 2.705443819238505, 2.714526681131686], 
        "gain_min" => 8, 
        "type_def" => "variable_gain", 
        "gain_ripple" => py_modules["numpy"].array([0.]), 
        "gain_flatmax" => 16, 
        "nf_min" => nothing), 
    "pin_db" => nothing, 
    "operational" => Dict(
        "out_voa" => 0, 
        "tilt_target" => 0, 
        "delta_p" => nothing, 
        "gain_target" => 17, 
        "default_values" => Dict("gain_target"=> nothing, "delta_p"=> nothing, "out_voa"=> nothing, "tilt_target"=> 0)),
    "interpol_gain_ripple" => nothing, 
    "channel_freq" => nothing, 
    "metadata" => Dict("location"=> py_modules["elements"].Location(latitude=2, longitude=0, city=nothing, region="")), 
    "variety_list" => nothing)



    # for generating edfa obj use the following list of attr:

    attr_edfa_lists_dict = Dict(

        "attr_list_edfa" => ["att_in", "channel_freq", "delta_p", "effective_gain", "effective_pch_out_db", "gprofile", "interpol_dgt", "interpol_gain_ripple", "interpol_nf_ripple", "metadata", "name", "nch", "nf", "operational", "out_voa", "params", "passive", "pin_db", "pout_db", "propagated_labels", "target_pch_out_db", "tilt_target", "type_variety", "uid", "variety_list"],
        "attr_list_edfa_params" => ["advance_configurations_from_json", "allowed_for_design", "bandwidth", "dgt", "dual_stage_model", "f_cent", "f_max", "f_min", "f_ripple_ref", "gain_flatmax", "gain_min", "gain_ripple", "nf0", "nf_coef", "nf_fit_coeff", "nf_max", "nf_min", "nf_model", "nf_ripple", "out_voa_auto", "p_max", "pdl", "pmd", "raman", "tilt_ripple", "type_def", "type_variety"],
        "attr_list_edfa_operational" => ["default_values", "delta_p", "gain_target", "out_voa", "tilt_target"]
    )

    return edfa_example_dict[key], attr_edfa_lists_dict

end


"""
$(TYPEDSIGNATURES)

creates fiber description in julia dictionary format
"""
function spectral_information_example_des(key, py_modules)


    si_dictionary = Dict()

    si_dictionary["example_01"] = Dict(
            "ase"=> py_modules["numpy"].array([0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0.,
            0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0.,
            0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0.,
            0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0.,
            0., 0., 0., 0., 0., 0., 0., 0.]),
    "baud_rate" => py_modules["numpy"].array([3.2e+10, 3.2e+10, 3.2e+10, 3.2e+10, 3.2e+10, 3.2e+10, 3.2e+10,
            3.2e+10, 3.2e+10, 3.2e+10, 3.2e+10, 3.2e+10, 3.2e+10, 3.2e+10,
            3.2e+10, 3.2e+10, 3.2e+10, 3.2e+10, 3.2e+10, 3.2e+10, 3.2e+10,
            3.2e+10, 3.2e+10, 3.2e+10, 3.2e+10, 3.2e+10, 3.2e+10, 3.2e+10,
            3.2e+10, 3.2e+10, 3.2e+10, 3.2e+10, 3.2e+10, 3.2e+10, 3.2e+10,
            3.2e+10, 3.2e+10, 3.2e+10, 3.2e+10, 3.2e+10, 3.2e+10, 3.2e+10,
            3.2e+10, 3.2e+10, 3.2e+10, 3.2e+10, 3.2e+10, 3.2e+10, 3.2e+10,
            3.2e+10, 3.2e+10, 3.2e+10, 3.2e+10, 3.2e+10, 3.2e+10, 3.2e+10,
            3.2e+10, 3.2e+10, 3.2e+10, 3.2e+10, 3.2e+10, 3.2e+10, 3.2e+10,
            3.2e+10, 3.2e+10, 3.2e+10, 3.2e+10, 3.2e+10, 3.2e+10, 3.2e+10,
            3.2e+10, 3.2e+10, 3.2e+10, 3.2e+10, 3.2e+10, 3.2e+10]),
    "chromatic_dispersion"=>  py_modules["numpy"].array([0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0.,
            0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0.,
            0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0.,
            0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0.,
            0., 0., 0., 0., 0., 0., 0., 0.]),
    "delta_pdb_per_channel"=>  py_modules["numpy"].array([0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0.,
            0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0.,
            0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0.,
            0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0.,
            0., 0., 0., 0., 0., 0., 0., 0.]),
    "frequency" => py_modules["numpy"].array([1.9135e+14, 1.9140e+14, 1.9145e+14, 1.9150e+14, 1.9155e+14,
            1.9160e+14, 1.9165e+14, 1.9170e+14, 1.9175e+14, 1.9180e+14,
            1.9185e+14, 1.9190e+14, 1.9195e+14, 1.9200e+14, 1.9205e+14,
            1.9210e+14, 1.9215e+14, 1.9220e+14, 1.9225e+14, 1.9230e+14,
            1.9235e+14, 1.9240e+14, 1.9245e+14, 1.9250e+14, 1.9255e+14,
            1.9260e+14, 1.9265e+14, 1.9270e+14, 1.9275e+14, 1.9280e+14,
            1.9285e+14, 1.9290e+14, 1.9295e+14, 1.9300e+14, 1.9305e+14,
            1.9310e+14, 1.9315e+14, 1.9320e+14, 1.9325e+14, 1.9330e+14,
            1.9335e+14, 1.9340e+14, 1.9345e+14, 1.9350e+14, 1.9355e+14,
            1.9360e+14, 1.9365e+14, 1.9370e+14, 1.9375e+14, 1.9380e+14,
            1.9385e+14, 1.9390e+14, 1.9395e+14, 1.9400e+14, 1.9405e+14,
            1.9410e+14, 1.9415e+14, 1.9420e+14, 1.9425e+14, 1.9430e+14,
            1.9435e+14, 1.9440e+14, 1.9445e+14, 1.9450e+14, 1.9455e+14,
            1.9460e+14, 1.9465e+14, 1.9470e+14, 1.9475e+14, 1.9480e+14,
            1.9485e+14, 1.9490e+14, 1.9495e+14, 1.9500e+14, 1.9505e+14,
            1.9510e+14]),
    "label"=> py_modules["numpy"].array([
    "32.00G", "32.00G", "32.00G", "32.00G", "32.00G", "32.00G",
    "32.00G", "32.00G", "32.00G", "32.00G", "32.00G", "32.00G",
    "32.00G", "32.00G", "32.00G", "32.00G", "32.00G", "32.00G",
    "32.00G", "32.00G", "32.00G", "32.00G", "32.00G", "32.00G",
    "32.00G", "32.00G", "32.00G", "32.00G", "32.00G", "32.00G",
    "32.00G", "32.00G", "32.00G", "32.00G", "32.00G", "32.00G",
    "32.00G", "32.00G", "32.00G", "32.00G", "32.00G", "32.00G",
    "32.00G", "32.00G", "32.00G", "32.00G", "32.00G", "32.00G",
    "32.00G", "32.00G", "32.00G", "32.00G", "32.00G", "32.00G",
    "32.00G", "32.00G", "32.00G", "32.00G", "32.00G", "32.00G",
    "32.00G", "32.00G", "32.00G", "32.00G", "32.00G", "32.00G",
    "32.00G", "32.00G", "32.00G", "32.00G", "32.00G", "32.00G",
    "32.00G", "32.00G", "32.00G", "32.00G"], 
            dtype="<U6"),
    "latency"=> py_modules["numpy"].array([0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0.,
            0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0.,
            0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0.,
            0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0.,
            0., 0., 0., 0., 0., 0., 0., 0.]),
    "nli" => py_modules["numpy"].array([0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0.,
            0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0.,
            0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0.,
            0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0.,
            0., 0., 0., 0., 0., 0., 0., 0.]),
    "pdl" => py_modules["numpy"].array([0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0.,
            0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0.,
            0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0.,
            0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0.,
            0., 0., 0., 0., 0., 0., 0., 0.]),
    "pmd"=> py_modules["numpy"].array([0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0.,
            0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0.,
            0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0.,
            0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0.,
            0., 0., 0., 0., 0., 0., 0., 0.]),
    "ref_power" => py_modules["info"].Pref(p_span0=0.0, p_spani=0.0, ref_carrier=py_modules["info"].ReferenceCarrier(baud_rate=32000000000.0, slot_width=50000000000.0)),
    "roll_off" => py_modules["numpy"].array([0.15, 0.15, 0.15, 0.15, 0.15, 0.15, 0.15, 0.15, 0.15, 0.15, 0.15,
            0.15, 0.15, 0.15, 0.15, 0.15, 0.15, 0.15, 0.15, 0.15, 0.15, 0.15,
            0.15, 0.15, 0.15, 0.15, 0.15, 0.15, 0.15, 0.15, 0.15, 0.15, 0.15,
            0.15, 0.15, 0.15, 0.15, 0.15, 0.15, 0.15, 0.15, 0.15, 0.15, 0.15,
            0.15, 0.15, 0.15, 0.15, 0.15, 0.15, 0.15, 0.15, 0.15, 0.15, 0.15,
            0.15, 0.15, 0.15, 0.15, 0.15, 0.15, 0.15, 0.15, 0.15, 0.15, 0.15,
            0.15, 0.15, 0.15, 0.15, 0.15, 0.15, 0.15, 0.15, 0.15, 0.15]),
    "signal" => py_modules["numpy"].array([0.001, 0.001, 0.001, 0.001, 0.001, 0.001, 0.001, 0.001, 0.001,
            0.001, 0.001, 0.001, 0.001, 0.001, 0.001, 0.001, 0.001, 0.001,
            0.001, 0.001, 0.001, 0.001, 0.001, 0.001, 0.001, 0.001, 0.001,
            0.001, 0.001, 0.001, 0.001, 0.001, 0.001, 0.001, 0.001, 0.001,
            0.001, 0.001, 0.001, 0.001, 0.001, 0.001, 0.001, 0.001, 0.001,
            0.001, 0.001, 0.001, 0.001, 0.001, 0.001, 0.001, 0.001, 0.001,
            0.001, 0.001, 0.001, 0.001, 0.001, 0.001, 0.001, 0.001, 0.001,
            0.001, 0.001, 0.001, 0.001, 0.001, 0.001, 0.001, 0.001, 0.001,
            0.001, 0.001, 0.001, 0.001]),
    "slot_width" => py_modules["numpy"].array([5.e+10, 5.e+10, 5.e+10, 5.e+10, 5.e+10, 5.e+10, 5.e+10, 5.e+10,
            5.e+10, 5.e+10, 5.e+10, 5.e+10, 5.e+10, 5.e+10, 5.e+10, 5.e+10,
            5.e+10, 5.e+10, 5.e+10, 5.e+10, 5.e+10, 5.e+10, 5.e+10, 5.e+10,
            5.e+10, 5.e+10, 5.e+10, 5.e+10, 5.e+10, 5.e+10, 5.e+10, 5.e+10,
            5.e+10, 5.e+10, 5.e+10, 5.e+10, 5.e+10, 5.e+10, 5.e+10, 5.e+10,
            5.e+10, 5.e+10, 5.e+10, 5.e+10, 5.e+10, 5.e+10, 5.e+10, 5.e+10,
            5.e+10, 5.e+10, 5.e+10, 5.e+10, 5.e+10, 5.e+10, 5.e+10, 5.e+10,
            5.e+10, 5.e+10, 5.e+10, 5.e+10, 5.e+10, 5.e+10, 5.e+10, 5.e+10,
            5.e+10, 5.e+10, 5.e+10, 5.e+10, 5.e+10, 5.e+10, 5.e+10, 5.e+10,
            5.e+10, 5.e+10, 5.e+10, 5.e+10]),
    "tx_osnr"=> py_modules["numpy"].array([40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40,
            40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40,
            40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40,
            40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40, 40,
            40, 40, 40, 40, 40, 40, 40, 40])
            )

    return si_dictionary[key]
end
