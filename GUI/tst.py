from DEAP_helper import *
from new_score_functions_normalizer_ver import *
import random
from deap import base, creator, tools, algorithms
# init_nrngpu()
origs = [3.137968,0.983955,0.089259]
mins = [0,0,0]
maxs = [5,5,5]
volts = getVolts(origs)