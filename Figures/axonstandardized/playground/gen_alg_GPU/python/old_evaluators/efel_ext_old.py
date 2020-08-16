import efel
import numpy as np
import math
import matplotlib.pyplot as plt

stim_start = 100#ms
stim_end = 400#ms
decay_start_after_stim =1
decay_end_after_stim = 10
nCpus = 80
#feature_list = ['Spikecount','time_to_first_spike', 'min_AHP_indices','peak_voltage','mean_AP_amplitude', 'AHP_depth','AP_begin_indices', 'spike_half_width', 'min_AHP_indices','AP_amplitude','min_AHP_values','voltage_base','steady_state_voltage_stimend']
#feature_list = ['voltage_base','steady_state_voltage_stimend','decay_time_constant_after_stim','sag_amplitude','ohmic_input_resistance','voltage_after_stim','voltage_deflection','voltage_deflection_vb_ssse','sag_ratio1','sag_ratio2']
#feature_list = ['voltage_base','steady_state_voltage_stimend','voltage_after_stim','ohmic_input_resistance']
all_feature_list = ['voltage_base','AP_amplitude','voltage_after_stim','peak_time','spike_half_width','AHP_depth','chi']
feature_list =  ['voltage_base','AP_amplitude','voltage_after_stim','peak_time','spike_half_width','AHP_depth']
feature_number = len(feature_list)
efel.api.setDoubleSetting('Threshold', -30)

def get_chi(orig_volts,volts,times):
    chi = []
    for curr_volts in volts:
        chi.append(np.sum(np.sqrt(np.square(np.subtract(orig_volts,curr_volts))))/len(times))
        
    return chi
def eval(target_volts_list, data_volts_list,times):
    def diff_lists(lis1, lis2):
        if lis1 is None or lis2 is None:
            return 1000
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
   # curr_trace_target['stimulus_current'] = [-0.40]
    curr_trace_target['decay_start_after_stim'] = [decay_start_after_stim]
    curr_trace_target['decay_end_after_stim'] = [decay_end_after_stim]
    #feature = efel.getFeatureValues([curr_trace_target], feature_list)
    traces = [curr_trace_target]
    nan_inds_bol = np.isnan(data_volts_list).any(axis=1)
    nan_inds = [i for i, x in enumerate(nan_inds_bol) if x]
    data_volts_list = np.delete(data_volts_list,nan_inds,axis=0)
    for i in range(len(data_volts_list)):
        curr_trace_data = {}
        curr_trace_data['T'] = times
        curr_trace_data['V'] = data_volts_list[i]
        curr_trace_data['stim_start'] = [stim_start]
        curr_trace_data['stim_end'] = [stim_end]
       # curr_trace_data['stimulus_current'] = [-0.40]
        curr_trace_data['decay_start_after_stim'] = [decay_start_after_stim]
        curr_trace_data['decay_end_after_stim'] = [decay_end_after_stim]
        traces.append(curr_trace_data)     
   
    print('in efel before getting features')
    traces_results = efel.getFeatureValues(traces, feature_list, raise_warnings=False)
    print(np.array(traces_results), "TRACE RES")
    print('in efel after getting features')
    if 'chi' in all_feature_list:
        all_chis =  get_chi(target_volts_list[0],data_volts_list,times)
    for i in range(len(data_volts_list)):
        curr_feature_list=[]
        f_counter = 0
        for feature_name in all_feature_list:
            if feature_name is not 'chi':
                diff_feature = diff_lists(traces_results[0][feature_name], traces_results[i+1][feature_name])
               # diff_feature = diff_feature * weights[f_counter]
                if math.isnan(diff_feature):
                    diff_feature = 10000
    #            if diff_feature == 0:
    #                print('i is' +str(i) + 'feature is ' + feature_name)
    #                plt.plot(data_volts_list[i],'r')
    #                plt.plot(target_volts_list[0],'b')
    #                plt.show()            
            else:
                diff_feature = all_chis[i]
                if math.isnan(diff_feature):
                    diff_feature = 10000
            curr_feature_list.append(diff_feature)
            f_counter +=1
        all_features.append(tuple(curr_feature_list))
    all_features = np.array(all_features)
    res = []
    counter = 0
    for ind in nan_inds_bol:
        if ind:
            res.append(np.zeros(len(all_feature_list))+100000)
        else:
            res.append(all_features[counter])
            counter +=1
    print(['best indvs ',res[0]])
    return res
