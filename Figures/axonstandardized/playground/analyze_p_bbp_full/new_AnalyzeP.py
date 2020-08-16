# @author Kyung Geun Kim

import numpy as np
import scipy.stats as stat
import os
from noisyopt import minimizeCompass
from scipy.optimize import minimize
from heapq import heappush, heappop
from importlib import reload
import loadParamsPkl
reload(loadParamsPkl)
from loadParamsPkl import *
import warnings
import h5py

eta = 1e-100

def construct_stim_score_function_list(scores_path):
    stim_list = []
    file_list = os.listdir(scores_path)
    for file_name in file_list:
        if '.hdf5' in file_name:
            curr_scores = h5py.File(scores_path + file_name, 'r')
            stim_list.append(curr_scores['stim_name'][0].decode('ascii'))
            score_function_list = [e.decode('ascii') for e in curr_scores['score_function_names'][:]]
    return sorted(stim_list), sorted(score_function_list)

def construct_score_sensitivity_dict(ordered_stim_list, ordered_score_function_list):
    norm_score_prefix = 'norm_pin_scores_'
    pin_score_dict = {}
    for stim in ordered_stim_list:
        score_file_name = stim + '_scores.hdf5'
        score_file = h5py.File(scores_path + score_file_name, 'r')
        curr_pin_list = []
        for function_name in ordered_score_function_list:
            curr_pin_score = score_file[norm_score_prefix+function_name][:].T[0]
            pin_len = len(curr_pin_score)
            curr_pin_list.append(curr_pin_score)
        pin_score_dict[stim] = curr_pin_list
    return pin_score_dict

# Returns an objective for the optimization problem.
# obj_comb_vec is vector of weights for [spearman, mean, standard deviation].
def construct_objective(score_mat):
    perfect_distribution = np.arange(np.shape(score_mat)[1])
    def obj(x):
       # Vector x is the weight vector where dot product with score vector and
       # argmin of objective will be the optimal linear combination
        x = x[np.newaxis]
        spearman = (stat.spearmanr(np.dot(x, score_mat).reshape((len(perfect_distribution))), perfect_distribution))[0]
        #print('Spearman: ', spearman/8)
        #print('Mean: ', mean)
        #print('Standard Deviation: ', 3*std)
        #print('Total: ', -spearman/8 - mean + 3*std, '\n')
        return -spearman
    return obj

# Runs optimization algorithm with the stim list and maximum bound as an input
# Can be used for both single stim and multi stim optimization.
# @argument stim_name_list can be either the name of a single stim,
# or a list of stim names if multi-stim optimization desired.
def optimize(stim_name_list, subset_list=None, min_bound = 0, max_bound = 100):
    if isinstance(stim_name_list, str):
        # Single stim optimization.
        stim_name_list = [stim_name_list]
    else:
        # Multi stim optimization.
        # Already a list, nothing to be done to stim_name_list.
        pass

    score_mat = np.concatenate(tuple([pin_score_dict[n] for n in stim_name_list]), axis=0)
    # Use only a subset of the data points if provided.
    # Otherwise, use all of the data points still.
    if subset_list is not None:
        score_mat = np.take(score_mat,subset_list,1)

    optimizer_len = np.shape(score_mat)[0]
    bound = [[min_bound, max_bound] for _ in range(optimizer_len)]
    np.random.seed(0)
    initial_guess = np.array([np.random.random_sample()*100 for _ in range(optimizer_len)])
    obj = construct_objective(score_mat)

    return minimizeCompass(obj, bounds=bound, x0=initial_guess, deltainit = 100, deltatol=0.01, paired=False), score_mat, obj
    #return minimize(obj, bounds=bound, x0=initial_guess), score_mat, obj

def greedy_multistim_optimize(single_opt_sorted, num_stims):
    stim_name_list = [single_opt_sorted[i][0] for i in range(num_stims)]
    return optimize(stim_name_list)

try:
    ordered_stim_list, ordered_score_function_list = construct_stim_score_function_list(scores_path)
    pin_score_dict = construct_score_sensitivity_dict(ordered_stim_list, ordered_score_function_list)

except FileNotFoundError:
    warnings.warn("Warning: Dictionaries not created because required files not found.\nSee the `~/analyzeP` directory for sample required files.",
        RuntimeWarning)
def main():
    return ordered_stim_list, ordered_score_function_list, pin_score_dict
