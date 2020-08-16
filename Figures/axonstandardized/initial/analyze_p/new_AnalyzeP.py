# @author Kyung Geun Kim

import numpy as np
import scipy.stats as stat
import os
from noisyopt import minimizeCompass
from scipy.optimize import minimize
from heapq import heappush, heappop
from importlib import reload
#import loadParamsPkl
#reload(loadParamsPkl)
from loadParamsPkl import *
import warnings
import h5py

eta = 1e-100

def construct_stim_score_function_list(score_path):
    stim_list = []
    file_list = os.listdir(score_path)
    for file_name in file_list:
        if '.hdf5' in file_name:
            curr_scores = h5py.File(score_path + file_name, 'r')
            stim_list.append(curr_scores['stim_name'][0].decode('ascii'))
            score_function_list = [e.decode('ascii') for e in curr_scores['score_function_names'][:]]
    return sorted(stim_list), sorted(score_function_list)

def collapse(mat):
    collapsed = []
    row_size = np.shape(mat)[1]
    for row in mat:
        collapsed.append(sum(row)/float(row_size))
    return np.array(collapsed)

def filter_nan(score_list):
    for i in range(len(score_list)):
        if np.isnan(score_list[i]):
            score_list[i] = 1
    return score_list

# Normalizing every matrix by the top 0.1% of all the sensitivity value.
def normalize_dict(sensitivity_dictionary):
    as_list = []
    for mat in sensitivity_dictionary.values():
        as_list.append(mat)
    as_list_flattened = np.reshape(np.concatenate(as_list, axis=1), (np.size(as_list), ))
    sorted_list = sorted(as_list_flattened, reverse=True)
    mean_top = np.mean(np.array(sorted_list[0:int(len(sorted_list)*0.01)]))

    print('Normalizing sensitivity dictionary')

    for key in sensitivity_dictionary.keys():
        curr_mat = sensitivity_dictionary[key]
        curr_mat = np.array(curr_mat)/float(mean_top)
        for i in range(len(curr_mat)):
            for j in range(len(curr_mat[i])):
                if curr_mat[i][j] > 1:
                    curr_mat[i][j] = 1
                if np.isnan(curr_mat[i][j]):
                    curr_mat[i][j] = 1
        sensitivity_dictionary[key] = curr_mat
    return sensitivity_dictionary

def construct_score_sensitivity_dict(ordered_stim_list, ordered_score_function_list):
    norm_score_prefix = 'norm_pin_scores_'
    sensitivity_mat_prefix = 'sensitivity_mat_'
    pin_score_dict = {}
    sensitivity_dict = {}
    collapsed_sensitivity_dict = {}
    number_of_params = h5py.File(params_path, 'r')['param_num'][:][0]
    for stim in ordered_stim_list:
        score_file_name = stim + '_scores.hdf5'
        score_file = h5py.File(score_path + score_file_name, 'r')
        curr_pin_list = []
        curr_sensitivity_list_collapesed = []
        curr_sensitivity_list = []
        for function_name in ordered_score_function_list:
            curr_pin_score = filter_nan(score_file[norm_score_prefix+function_name][:].T[0])
            #curr_sensitivity = score_file[sensitivity_mat_prefix+function_name][:].T[0]
            pin_len = len(curr_pin_score)
            #sensitivity_len = len(curr_sensitivity)
            #curr_sensitivity = np.reshape(curr_sensitivity, (sensitivity_len//number_of_params, number_of_params)).T
            #curr_sensitivity_list.append(curr_sensitivity)
            #curr_sensitivity_collapsed = collapse(curr_sensitivity)
            curr_pin_list.append(curr_pin_score)
            #curr_sensitivity_list_collapesed.append(curr_sensitivity_collapsed)
        pin_score_dict[stim] = curr_pin_list
        #sensitivity_dict[stim] = curr_sensitivity_list
        #collapsed_sensitivity_dict[stim] = curr_sensitivity_list_collapesed
    return pin_score_dict#, sensitivity_dict, normalize_dict(collapsed_sensitivity_dict)

# Returns an objective for the optimization problem.
# obj_comb_vec is vector of weights for [spearman, mean, standard deviation].
def construct_objective(score_mat, param_select_vec, obj_comb_vec = obj_comb_vec):
    perfect_distribution = np.arange(np.shape(score_mat)[1])
    def obj(x):
       # Vector x is the weight vector where dot product with score vector and
       # argmin of objective will be the optimal linear combination
        x = x[np.newaxis]
        spearman = (stat.spearmanr(np.dot(x, score_mat).reshape((len(perfect_distribution))), perfect_distribution))[0]
#         if param_select_vec:
#             selected_sensitivity_mat = [[vec[ind] for ind in param_select_vec] for vec in sensitivity_mat]
#             mean = np.mean(np.dot(x/(float(np.linalg.norm(x)+eta)), selected_sensitivity_mat))
#         else:
#             mean = np.mean(np.dot(x/(float(np.linalg.norm(x)+eta)), sensitivity_mat))
        #print('Spearman: ', spearman/8)
        #print('Mean: ', mean)
        #print('Standard Deviation: ', 3*std)
        #print('Total: ', -spearman/8 - mean + 3*std, '\n')
        return -spearman #np.dot([-spearman, -mean], obj_comb_vec)
    return obj

# Runs optimization algorithm with the stim list and maximum bound as an input
# Can be used for both single stim and multi stim optimization.
# @argument stim_name_list can be either the name of a single stim,
# or a list of stim names if multi-stim optimization desired.
def optimize(stim_name_list, pin_score_dict, subset_list=None, min_bound = 0, max_bound = 100, obj_comb_vec = obj_comb_vec):
    if isinstance(stim_name_list, str):
        # Single stim optimization.
        stim_name_list = [stim_name_list]
    else:
        # Multi stim optimization.
        # Already a list, nothing to be done to stim_name_list.
        pass
    score_mat = np.concatenate(tuple([pin_score_dict[n] for n in stim_name_list]), axis=0)
    #sensitivity_mat = np.concatenate(tuple([collapsed_sensitivity_dict[n] for n in stim_name_list]), axis=0)
    # Use only a subset of the data points if provided.
    # Otherwise, use all of the data points still.
    if subset_list is not None:
        score_mat = np.take(score_mat,subset_list,1)

    optimizer_len = np.shape(score_mat)[0]
    bound = [[min_bound, max_bound] for _ in range(optimizer_len)]
    np.random.seed(0)
    initial_guess = np.array([np.random.random_sample()*100 for _ in range(optimizer_len)])
    obj = construct_objective(score_mat, obj_comb_vec)

    return minimizeCompass(obj, bounds=bound, x0=initial_guess, deltainit = 100, deltatol=90, paired=False), score_mat, obj
    #return minimize(obj, bounds=bound, x0=initial_guess), score_mat, obj

def greedy_multistim_optimize(single_opt_sorted, num_stims):
    stim_name_list = [single_opt_sorted[i][0] for i in range(num_stims)]
    return optimize(stim_name_list)

def main():
    try:
        ordered_stim_list, ordered_score_function_list = construct_stim_score_function_list(score_path)
        pin_score_dict = construct_score_sensitivity_dict(ordered_stim_list, ordered_score_function_list)

    except FileNotFoundError:
        warnings.warn("Warning: Dictionaries not created because required files not found.\nSee the `~/analyzeP` directory for sample required files.",
            RuntimeWarning)
    return ordered_stim_list, ordered_score_function_list, pin_score_dict
