import efel
import numpy as np
import math

stim_start = 275#ms
stim_end = 335#ms
decay_start_after_stim =1
decay_end_after_stim = 10
#feature_list = ['Spikecount','time_to_first_spike', 'min_AHP_indices','peak_voltage','mean_AP_amplitude', 'AHP_depth','AP_begin_indices', 'spike_half_width', 'min_AHP_indices','AP_amplitude','min_AHP_values','voltage_base','steady_state_voltage_stimend']
feature_list = ['voltage_base','steady_state_voltage_stimend','decay_time_constant_after_stim','sag_amplitude','ohmic_input_resistance','voltage_after_stim','voltage_deflection','voltage_deflection_vb_ssse','sag_ratio1','sag_ratio2']
#feature_list = ['voltage_base','steady_state_voltage_stimend','voltage_after_stim','ohmic_input_resistance']
feature_number = len(feature_list)
efel.api.setDoubleSetting('Threshold', -40)


def eval(target_volts_list, data_volts_list,times):
    def diff_lists(lis1, lis2):
        if lis1 is None or lis2 is None:
            return 100
        len1, len2 = len(lis1), len(lis2)
        if len1 > len2:
            lis2 = np.concatenate((lis2, np.zeros(len1 - len2)), axis=0)
        if len2 > len1:
            lis1 = np.concatenate((lis1, np.zeros(len2 - len1)), axis=0)
        # print(np.sqrt(((lis1 - lis2)**2).mean()))
        # print('\n')
        return np.sqrt(((lis1 - lis2)**2).mean())

    all_features = []
    curr_trace_target  = {}
    curr_trace_target['T'] = times
    curr_trace_target['V'] = target_volts_list[0]
    curr_trace_target['stim_start'] =  [stim_start]
    curr_trace_target['stim_end'] = [stim_end]
    curr_trace_target['stimulus_current'] = [-0.40]
    curr_trace_target['decay_start_after_stim'] = [decay_start_after_stim]
    curr_trace_target['decay_end_after_stim'] = [decay_end_after_stim]
    #feature = efel.getFeatureValues([curr_trace_target], feature_list)
    traces = [curr_trace_target]
    for i in range(len(data_volts_list)):
       
        curr_trace_data = {}
        curr_trace_data['T'] = times
        curr_trace_data['V'] = data_volts_list[i]
        curr_trace_data['stim_start'] = [stim_start]
        curr_trace_data['stim_end'] = [stim_end]
        curr_trace_data['stimulus_current'] = [-0.40]
        curr_trace_data['decay_start_after_stim'] = [decay_start_after_stim]
        curr_trace_data['decay_end_after_stim'] = [decay_end_after_stim]
        traces.append(curr_trace_data)
    print('in efel before getting features')
    traces_results = efel.getFeatureValues(traces, feature_list)
    print('in efel after getting features')
    for i in range(len(data_volts_list)):
        curr_feature_list=[]
        f_counter = 0
        for feature_name in feature_list:
            diff_feature = diff_lists(traces_results[0][feature_name], traces_results[i+1][feature_name])
           # diff_feature = diff_feature * weights[f_counter]
            if math.isnan(diff_feature):
                print('we got nan')
                diff_feature = 10000
#            if diff_feature == 0:
#                print('i is' +str(i) + 'feature is ' + feature_name)
#                plt.plot(data_volts_list[i],'r')
#                plt.plot(target_volts_list[0],'b')
#                plt.show()            
            curr_feature_list.append(diff_feature)
            f_counter +=1
        all_features.append(tuple(curr_feature_list))
    print(['best indvs ',all_features[0]])
    return all_features