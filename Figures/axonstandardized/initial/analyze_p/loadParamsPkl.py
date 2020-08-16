# @author Matthew Sit

import warnings
import os
import pickle

# Load parameters saved to params.pkl, which should be written by the jupyter
# notebook before calling this script.
# If no such pickle file exists, then use our hard-coded default parameters instead.
print(os.getcwd())
if os.path.exists('analyze_p/params.pkl'):
    with open('analyze_p/params.pkl', 'rb') as f:
        score_path, \
        params_path, \
        score_function_name_ordered_list, \
        obj_comb_vec, \
        param_select_vec, \
        dx, \
        nModelParams, \
        coarseStepSize, \
        fineStepSize \
            = pickle.load(f)
    print('params.pkl successfully loaded.')
else:
    # Default parameters.
    warnings.warn("params.pkl not found, using hard-coded default parameters.", RuntimeWarning)

    # Data Files
    score_path = './scores/'
    score_function_name_ordered_list = [
        'chi_square_normal',
        'abs_cumsum_diff',
        'comp_rest_potential',
        'comp_width',
        'comp_width_avg',
        'comp_height',
        'comp_height_avg',
        'traj_score_1',
        'traj_score_2',
        'traj_score_3',
        'isi',
        'rev_dot_product',
        'KL_divergence'
    ]

    # Weights for optimization.
    # obj_comb_vec is vector of weights for [spearman, mean, standard deviation].
    obj_comb_vec = [1/5, 1, 3]

    # Constants
    dx = 0.01
    nModelParams = 12
    coarseStepSize = 0.1
    fineStepSize = 0.01
