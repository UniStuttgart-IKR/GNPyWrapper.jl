"""
This code was(/is) used to generate the spectral information descriptions

copy and paste this code

put this code into gnpy.core.info right before the SpectralInformation object gets created

and "uncomment" it

if you want to see the description set the DEBUG_MODE to True
"""
# DEBUG_MODE = False
# import pprint


# if DEBUG_MODE:
#             print("####################################")
#             print("####################################")
#             print("Object of class SpectralInformation gets created")
#             print("it has the following configuration data:")
            
#             spectralinformation_dict= {'frequency': frequency, 
#                                     'slot_width': slot_width,
#                                     'signal': signal, 
#                                     'nli': nli, 
#                                     'ase': ase,
#                                     'baud_rate': baud_rate, 
#                                     'roll_off': roll_off,
#                                     'chromatic_dispersion': chromatic_dispersion,
#                                     'pmd': pmd, 
#                                     'pdl': pdl, 
#                                     'latency':latency,
#                                     'delta_pdb_per_channel': delta_pdb_per_channel,
#                                     'tx_osnr': tx_osnr, 
#                                     'ref_power': ref_power,
#                                     'label': label}# does have ref_power
#             print('type of spectralinformation_dict: ' + str(type(spectralinformation_dict)))
#             pprint.pprint(spectralinformation_dict)
#             print("####################################")