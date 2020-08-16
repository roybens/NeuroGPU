import numpy as np
import math
import efel
import matplotlib.pyplot as plt
import time as timer
# These are here for efficiency. In order to avoid redundant computation, we cache the results for
# comp_width_helper, comp_height_helper and traj_score_helper. The name of stim and index as a string
# need to be passed in to do this.
comp_width_dict = {}
comp_height_dict = {}
traj_score_dict = {}
threshold = -10
from concurrent.futures import ProcessPoolExecutor as Pool

# These constants exist for efel features
time_stamps =  10000
starting_time_stamp = 1000
ending_time_stamp = 7000

########################################################################
# These functions are util functions.
def zero_pad(list1, list2):
    if isinstance(list1, int) or isinstance(list2, int) or isinstance(list1, float) or isinstance(list2, float):
        return list1, list2
    if len(list1) > len(list2):
        list2 = list2 + [0 for i in range(0, len(list1) - len(list2))]
    elif len(list2) > len(list1):
        list1 = list1 + [0 for i in range(0, len(list2) - len(list1))]
    return list1, list2

def safe_mean(lis):
    if np.size(lis) == 0:
        return 0
    return np.mean(lis)

def find_positive_inds(lis):
    return [i for i in range(0, len(lis)) if lis[i] > 0]

def find_positive_inds(lis):
    return [i for i in range(0, len(lis)) if lis[i] > 0]

def find_peaks(lis, min_value):
    inds = [i for i in range(1, len(lis) - 1) if lis[i] >= lis[i - 1] and lis[i] >= lis[i + 1] and lis[i] >= min_value]
    return [lis[i] for i in inds], inds

def diff(lis):
    return [lis[i + 1] - lis[i] for i in range(0, len(lis) - 1)]

########################################################################

# chi_square_normal takes one dimensional lists target and data and return mean of (x_1 - x_2)^2 for
# each timepoints.
def chi_square_normal(target, data, dt=0.02, stims=None, index=None):
    diff = np.square(np.array(target) - np.array(data))
    score = safe_mean(diff)
    return score

# abs_cumsum_diff takes one dimensional lists target and data and return abs(x_1 - x_2) for
# each timepoints in the cumsum.
def abs_cumsum_diff(target, data, dt=0.02, stims=None, index=None):
    cumsum_chi = np.absolute(np.cumsum(np.array(target)) - np.cumsum(np.array(data)))
    score = safe_mean(cumsum_chi)
    return score

# comp_rest_potential takes one dimensional lists target and data and compares the resting
# potential by squaring the difference of last elements in lists.
def comp_rest_potential(target, data, dt=0.02, stims=None, index=None):
    v_rest_ind = len(target) - 1
    v_rest_target = target[v_rest_ind]
    v_rest_data = data[v_rest_ind]

    return (v_rest_target - v_rest_data) ** 2

# comp_width takes one dimensional lists target and data and compares the widths of action potentials
# comp_width_avg does very similar thing but takes average. The two functions share very similar code
# but it was just copy pasted because I was lazy.
def comp_width_helper(target, data):
    def AP_inds(positive_ind_vec):
        ind_when_change = [i for i in range(0, len(positive_ind_vec) - 1) if positive_ind_vec[i + 1] - positive_ind_vec[i] > 1]
        AP_ends = [positive_ind_vec[i] for i in ind_when_change] + [positive_ind_vec[len(positive_ind_vec) - 1]]
        AP_starts = [positive_ind_vec[0]] + [positive_ind_vec[i + 1] for i in ind_when_change]
        return AP_starts, AP_ends
    postive_target_inds = find_positive_inds(target)
    postive_data_inds = find_positive_inds(data)

    if postive_target_inds:
        target_AP_start, target_AP_end = AP_inds(postive_target_inds)
        curr_target_widths = [target_AP_end[i] - target_AP_start[i] for i in range(0, min(len(target_AP_end), len(target_AP_start)))]
        target_width_avg = safe_mean(curr_target_widths)
    else:
        curr_target_widths = []
        target_width_avg = 0

    if postive_data_inds:
        data_AP_start, data_AP_end = AP_inds(postive_data_inds)
        curr_data_widths = [data_AP_end[i] - data_AP_start[i] for i in range(0, min(len(data_AP_start), len(data_AP_end)))]
        data_width_avg = safe_mean(curr_data_widths)
    else:
        curr_data_widths = []
        data_width_avg = 0


    if postive_target_inds or postive_data_inds:
        curr_target_widths, curr_data_widths = zero_pad(curr_target_widths, curr_data_widths)
        target_width_avg, data_width_avg = zero_pad(target_width_avg, data_width_avg)
    else:
        curr_target_widths = []
        curr_data_widths = []
        target_width_avg = 0
        data_width_avg = 0

    result = [sum([(curr_target_widths[i] - curr_data_widths[i])**2 for i in range(0, len(curr_data_widths))]), (target_width_avg - data_width_avg)**2]
    return [result[0], result[1]]

def comp_width(target, data, dt=0.02, stims=None, index=None):
    global comp_width_dict
    if stims and index:
        stim_ind = stims + index
        if stim_ind in comp_width_dict:
            return comp_width_dict[stim_ind][0]
        else:
            comp_width_dict[stim_ind] = comp_width_helper(target, data)
        return comp_width_dict[stim_ind][0]
    else:
        return comp_width_helper(target, data)[0]

def comp_width_avg(target, data, dt=0.02, stims=None, index=None):
    global comp_width_dict
    if stims and index:
        stim_ind = stims + index
        if stim_ind in comp_width_dict:
            return comp_width_dict[stim_ind][1]
        else:
            comp_width_dict[stim_ind] = comp_width_helper(target, data)
        return comp_width_dict[stim_ind][1]
    else:
        return comp_width_helper(target, data)[1]


# comp_height takes one dimensional lists target and data and compares the heights of action potentials
# comp_height_avg does very similar thing but takes average.
def comp_height_helper(target, data):
    if find_positive_inds(target):
        orig_target_peaks, target_peaks_locs = find_peaks(target, 0.1)
    else:
        orig_target_peaks = []
        target_peaks_locs = []
    if find_positive_inds(data):
        orig_data_peaks, data_peaks_locs = find_peaks(data, 0.1)
    else:
        orig_data_peaks = []
        data_peaks_locs = []

    peaks_target, peaks_data = zero_pad(orig_target_peaks, orig_data_peaks)

    #These always follows same scheme where the stims are complete.
    #At the end, it is really close to the rest membrane potential

    v_rest_ind = len(target) - 1
    v_rest_target = target[v_rest_ind]
    v_rest_data = data[v_rest_ind]
    height_target = [peaks_target[i] - v_rest_target for i in range(0, len(peaks_target))]
    height_data = [peaks_data[i] - v_rest_data for i in range(0, len(peaks_data))]
    target_height_avg = 0
    if len(height_target) > 0:
        target_height_avg = safe_mean(np.array(height_target))
    data_height_avg = 0
    if len(height_data) > 0:
        data_height_avg = safe_mean(np.array(height_data))

    result = [sum([(height_target[i] - height_data[i]) ** 2 for i in range(0, len(height_target))]), (target_height_avg - data_height_avg) ** 2]

    return [result[0], result[1]]

def comp_height(target, data, dt=0.02, stims=None, index=None):
    global comp_height_dict
    if stims and index:
        stim_ind = stims + index
        if stim_ind in comp_height_dict:
            return comp_height_dict[stim_ind][0]
        else:
            comp_height_dict[stim_ind] = comp_height_helper(target, data)
        return comp_height_dict[stim_ind][0]
    else:
        return comp_height_helper(target, data)[0]

def comp_height_avg(target, data, dt=0.02, stims=None, index=None):
    global comp_height_dict
    if stims and index:
        stim_ind = stims + index
        if stim_ind in comp_height_dict:
            return comp_height_dict[stim_ind][1]
        else:
            comp_height_dict[stim_ind] = comp_height_helper(target, data)
        return comp_height_dict[stim_ind][1]
    else:
        return comp_height_helper(target, data)[1]

# traj_score takes one dimensional lists target and data and counts the traces of sweep per grid in phase domain.
def traj_score_helper(target, data):
    n_bins = 100
    min_v = -80
    max_v = 70
    min_dv = -6
    max_dv = 40

    v_edges = np.linspace(min_v,max_v,n_bins)
    dv_edges = np.linspace(min_dv,max_dv,n_bins)
    edges = [v_edges, dv_edges]

    target_dvs = diff(target)
    target_hists = np.histogram2d(target[1:], target_dvs, bins = edges)[0]
    #Inserting 2d list in a list so target_hists bocomes 3d list but for now it's 2d list
    c_target_hists = np.cumsum(np.cumsum(target_hists, axis = 0), axis = 1)
    c_target_hists_max = max([max(c_target_hists[j]) for j in range(0, len(c_target_hists))])
    c_target_hists = [[float(c_target_hists[j][k])/c_target_hists_max for k in range(0, len(c_target_hists[j]))] for j in range(0, len(c_target_hists))]
    target_hists_sum = sum([sum(target_hists[j]) for j in range(0, len(target_hists))])
    target_hists = [[float(target_hists[j][k])/target_hists_sum for k in range(0, len(target_hists[j]))] for j in range(0, len(target_hists))]
    #Here, I am assuming that these are 2d arrays

    curr_dvs = diff(data)
    curr_hists =  np.histogram2d(data[1:], curr_dvs, bins = edges)[0]
    curr_hists_sum = sum([sum(curr_hists[k]) for k in range(0, len(curr_hists))])
    curr_hists = [[float(curr_hists[k][l])/curr_hists_sum for l in range(0, len(curr_hists[k]))] for k in range(0, len(curr_hists))]
    t_score = safe_mean([safe_mean([(target_hists[k][l] - curr_hists[k][l])**2 for l in range(0, len(curr_hists[k]))]) for k in range(0, len(curr_hists))])
    c_curr_hists =  np.cumsum(np.cumsum(curr_hists, axis = 0), axis = 1)
    c_curr_hists_max = max([max(c_curr_hists[k]) for k in range(0, len(c_curr_hists))])
    c_curr_hists = [[float(c_curr_hists[k][l])/c_curr_hists_max for l in range(0, len(c_curr_hists[k]))] for k in range(0, len(c_curr_hists))]
    c_diff = [[abs(c_curr_hists[k][l] - c_target_hists[k][l]) for l in range(0, len(c_curr_hists[k]))] for k in range(0, len(c_curr_hists))]
    fast_ks_score = max([max(lis) for lis in c_diff])
    fast_emd_score = safe_mean([safe_mean(lis) for lis in c_diff])


    scores = [(t_score**0.5), fast_ks_score, fast_emd_score]
    return scores

def traj_score_1(target, data, dt=0.02, stims=None, index=None):
    global traj_score_dict
    if stims and index:
        stim_ind = stims + index
        if stim_ind in traj_score_dict:
            return traj_score_dict[stim_ind][0]
        else:
            traj_score_dict[stim_ind] = traj_score_helper(target, data)
        return traj_score_dict[stim_ind][0]
    else:
        return traj_score_helper(target, data)[0]

def traj_score_2(target, data, dt=0.02, stims=None, index=None):
    global traj_score_dict
    if stims and index:
        stim_ind = stims + index
        if stim_ind in traj_score_dict:
            return traj_score_dict[stim_ind][1]
        else:
            traj_score_dict[stim_ind] = traj_score_helper(target, data)
        return traj_score_dict[stim_ind][1]
    else:
        return traj_score_helper(target, data)[1]

def traj_score_3(target, data, dt=0.02, stims=None, index=None):
    global traj_score_dict
    if stims and index:
        stim_ind = stims + index
        if stim_ind in traj_score_dict:
            return traj_score_dict[stim_ind][2]
        else:
            traj_score_dict[stim_ind] = traj_score_helper(target, data)
        return traj_score_dict[stim_ind][2]
    else:
        return traj_score_helper(target, data)[2]

# isi takes one dimensional lists target and data and computes rms of inter spike intervals.
def isi(target, data, dt=0.02, stims=None, index=None):
    times = np.cumsum([dt for i in range(len(target))])

    def get_isi(target, times):
        peak, inds = find_peaks(target, 0)
        isis =  [times[j] for j in inds]
        return isis, inds

    def compare_isi(target, input):
        curr_target, curr_input = target, input
        curr_target, curr_input = zero_pad(curr_target, curr_input)
        curr_score = safe_mean([(curr_target[j] - curr_input[j])**2 for j in range(0, len(curr_target))])**0.5
        norm_factor = safe_mean([elem**2 for elem in diff(curr_target)])**0.5
        if not norm_factor or norm_factor == 0:
            norm_factor = 1
        return float(safe_mean(curr_score))/norm_factor

    target_isi, target_isi_inds = get_isi(target, times)
    curr_isi, curr_isi_inds = get_isi(data, times)
    scores =  compare_isi(target_isi, curr_isi)

    if np.isnan(scores):
        scores = 0

    return scores

# Computing the 1 - dot product of 2 vectors.
def rev_dot_product (target, data, dt=0.02, stims=None, index=None):
    def vectorSize(v):
        return np.sqrt(np.sum(np.square(np.array(v))))

    stimMag = vectorSize(target)
    pSetMag = vectorSize(data)
    dot = np.dot(np.array(target), np.array(data))
    score = 1 - (float(dot) / (stimMag * pSetMag))

    return score

# work if target & data are discrete probability distribution
def KL_divergence (target, data, dt=0.02, stims=None, index=None):
    def shift(v):
        base = np.absolute(np.amin(np.array(v)))
        return np.array(v) + base + 0.1

    def normalize (v):
        return np.array(v)/float(np.sum(np.array(v)))

    def divergence (v1, v2):
        v1_array = np.array(v1)
        v2_array = np.array(v2)
        d = 0
        for i in range(0, len(v1_array)):
            if (v1_array[i] != 0 and v2_array[i] != 0):
                d += float(v2_array[i]) * np.log(float(v2_array[i]) / v1_array[i])
        return d

    score = divergence(normalize(shift(target)), normalize(shift(data)))

    return score

def traj_score_single_peak(target, data, dt=0.02, stims = None, index = None):
    X_size = 100
    Y_size = 100
    M_size = X_size*Y_size

    # initial half width time = 15ms
    half_width_time = 25

    def NaN_pad(list1, list2):
        if len(list1) > len(list2):
            list2 = list2 + [math.nan for i in range(0, len(list1) - len(list2))]
        elif len(list2) > len(list1):
            list1 = list1 + [math.nan for i in range(0, len(list2) - len(list1))]
        return list1, list2

    def pairs_peak_half_width(peak_indices, max_half_width_time, dt):
        pair_index_width = []
        max_half_width = max_half_width_time/dt #25ms/0.1ms = 250
        for i in range(len(peak_indices)):
            # the number of data points of half_width = 15/0.1 = 150
            half_width = max_half_width
            new_width = max_half_width

            if i == 0:
                new_width = (peak_indices[i+1]-peak_indices[i])/2
            elif i == len(peak_indices)-1 or math.isnan(peak_indices[i+1]):
                new_width = (peak_indices[i] - peak_indices[i-1])/2
            else:
                new_width = min((peak_indices[i+1]-peak_indices[i])/2,(peak_indices[i] - peak_indices[i-1])/2)

            if new_width < half_width:
                half_width = new_width

            pair_index_width.append((peak_indices[i], math.floor(half_width)))

        return pair_index_width

    def phase_plane(signal, pair_peak_half_width, dt):
        peak_index, half_width = pair_peak_half_width
        if (math.isnan(peak_index)):
            return [math.nan],[math.nan]
        lowBound = peak_index-half_width
        upBound = peak_index+half_width
        one_peak = signal[lowBound:upBound]

    #     x = [(one_peak[i]+one_peak[i+1])/2 for i in range(len(one_peak)-1)]
        x = one_peak[1:]
        dV = diff(one_peak)
        dT = [dt for i in range(len(dV))]
        y = np.array(dV)/np.array(dT).tolist()
        return x, y

    # find peaks above threshold, corresponding indices
    target_peak_volts, target_peak_indices = find_peaks(target, threshold)
    data_peak_volts, data_peak_indices = find_peaks(data, threshold)

    target_peak_indices, data_peak_indices = NaN_pad(target_peak_indices, data_peak_indices)

    nPeaks = len(target_peak_indices)

    #find half-width that covers only one peak at a time
    target_pairs = pairs_peak_half_width(target_peak_indices, half_width_time, dt)
    data_pairs = pairs_peak_half_width(data_peak_indices, half_width_time, dt)

    total_score = 0

    for i in range(nPeaks):
        target_pair = target_pairs[i]
        target_phase_plane = phase_plane(target, target_pair, dt)
        target_x = target_phase_plane[0]
        target_y = target_phase_plane[1]

        data_pair = data_pairs[i]
        data_phase_plane = phase_plane(data, data_pair, dt)
        data_x = data_phase_plane[0]
        data_y = data_phase_plane[1]


        x_bins = np.linspace(np.nanmin([min(target_x), min(data_x)]),np.nanmax([max(target_x),max(data_x)]), X_size+1)
        y_bins = np.linspace(np.nanmin([min(target_y),min(data_y)]),np.nanmax([max(target_y),max(data_y)]), Y_size+1)

        target_hist2d = np.histogram2d(target_x, target_y, bins=(x_bins, y_bins))[0]
        data_hist2d = np.histogram2d(data_x, data_y, bins=(x_bins, y_bins))[0]

        score = np.sum((target_hist2d-data_hist2d)**2)
        total_score += score
    return (total_score/M_size) ** 0.5

def DTWDistance(target, data, dt=0.02, stims = None, index = None):
   DTW = np.zeros((len(target)+1, len(data)+1))

   for i in range(len(target)+1):
       DTW[i][0] = np.inf

   for i in range(len(data)+1):
       DTW[0][i] = np.inf
   DTW[0][0]=0

   for i in range(1,len(target)+1):
       for j in range(1,len(data)+1):
           cost = abs(target[i-1]-data[j-1])
           DTW[i][j] = cost + min(DTW[i-1][j], DTW[i][j-1], DTW[i-1][j-1])
   return DTW[len(target)-1,len(data)-1]/len(target)

def eval_efel(feature_name, target, data, dt=0.02, stims=None, index=None):
    def diff_lists(lis1, lis2):
        if lis1 is None and lis2 is None:
            return 0
        if lis1 is None:     
            lis1 = [0]
        if lis2 is None:
            lis2 = [0]
        len1, len2 = len(lis1), len(lis2)
        if len1 > len2:
            lis2 = np.concatenate((lis2, np.zeros(len1 - len2)), axis=0)
        if len2 > len1:
            lis1 = np.concatenate((lis1, np.zeros(len2 - len1)), axis=0)
        return np.sqrt(safe_mean((lis1 - lis2)**2))
    all_features = []
    time = np.cumsum([dt for i in range(time_stamps)])
    curr_trace_target, curr_trace_data = {}, {}
    stim_start, stim_end = starting_time_stamp*dt, ending_time_stamp*dt
    curr_trace_target['T'] = time
    curr_trace_target['V'] = target
    curr_trace_target['stim_start'] = [stim_start]
    curr_trace_target['stim_end'] = [stim_end]
    traces = [curr_trace_target]
    nan_inds_bol = np.isnan(data).any(axis=1)
    nan_inds = [i for i, x in enumerate(nan_inds_bol) if x]
    data = np.delete(data,nan_inds,axis=1)
    for i in range(len(data)):
        curr_trace_data = {}
        curr_trace_data['T'] = time
        curr_trace_data['V'] = data[i,:]
        curr_trace_data['stim_start'] = [stim_start]
        curr_trace_data['stim_end'] = [stim_end]
        traces.append(curr_trace_data)
    efelstart = timer.time()
    traces_results = efel.getFeatureValues(traces, [feature_name], raise_warnings=False)
    #print("EFEL eval took: ", timer.time()-efelstart)
    diff_features = []
    for i in range(len(data)): #testing
        diff_features.append(diff_lists(traces_results[0][feature_name], traces_results[i+1][feature_name]))
    return diff_features

