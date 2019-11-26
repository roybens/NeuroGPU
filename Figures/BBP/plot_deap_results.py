import os
import pickle
import numpy
import csv
from deap import base, creator, tools, algorithms
base_folder = 'C:/BBP_new/'
optims_folder = base_folder + 'Data/Optims/'
res_file = optims_folder + 'optim_res.csv'
#opts_files =  [f for f in os.listdir(optims_folder) if f.endswith('.pkl')]
nevals = []
mins = []
creator.create("FitnessMax", base.Fitness, weights=(-1.0,))
creator.create("Individual", list, fitness=creator.FitnessMax)

for i in xrange(5,13):
    for j in xrange(2):
        opt_f = 'GA_log' + str(2**i) + '_' +str(j) + '.pkl'
        with open(optims_folder + opt_f, "rb") as f:
            curr_log = pickle.load(f)
            hof= pickle.load(f)
            curr_mins = []
            curr_nevals = []
            for curr_dict in curr_log:
                curr_mins.append(curr_dict["min"])
                curr_nevals.append(curr_dict["nevals"])
            nevals.append(curr_nevals)
            mins.append(curr_mins)
counter =0
matcounter=0
mat_len = max(len(mins[0]),len(mins[1]))
res = numpy.zeros((mat_len,100))
for i in xrange(5,13):
    for j in xrange(2):
        curr_mins = mins[counter]
        curr_nevals = nevals[counter]
        res[:len(curr_mins),matcounter] = curr_mins
        counter+=1
        matcounter+=1
        res[:len(curr_nevals), matcounter] = numpy.cumsum(curr_nevals)
        matcounter += 1

        print counter
numpy.savetxt(res_file,res,delimiter=',')