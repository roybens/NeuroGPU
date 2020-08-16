# @author Matthew Sit

import warnings
import os
import pickle

# Load parameters saved to np_vars.pkl, which should be written by the jupyter
# notebook before calling this script.
# If no such pickle file exists, then use our hard-coded default parameters instead.
if os.path.exists('nb_vars.pkl'):
    with open('nb_vars.pkl', 'rb') as f:
        stims_to_examine, \
        inDebuggingMode \
            = pickle.load(f)
    print('nb_vars.pkl successfully loaded.')
else:
    # Default parameters.
    warnings.warn("nb_vars.pkl not found, using hard-coded default parameters.", RuntimeWarning)

    # Used with the /scores/ directory for debugging on a smaller data set.
    stims_to_examine = ['HE16i_4_7600ver__', 'chirp_mean_1_freq_0_to_0.1_amp_0_to_3_lin_', 'sinsSTD5_7__']

    inDebuggingMode = True
