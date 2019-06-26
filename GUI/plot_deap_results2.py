import os
import pickle
import numpy
import csv
from scipy import stats 
from deap import base, creator, tools, algorithms
base_folder = 'E:/BBP_new/'
optims_folder = base_folder + 'Data/Optims/'
res_file = optims_folder + 'optim_res2.csv'
params_table = base_folder + '/params/opt_table.csv'
#opts_files =  [f for f in os.listdir(optims_folder) if f.endswith('.pkl')]
nevals = []
mins = []
global mins_min
pop_sizes = [100,500,2000,5000,10000]
creator.create("FitnessMax", base.Fitness, weights=(-1.0,))
creator.create("Individual", list, fitness=creator.FitnessMax)

def plot_results():
    global mins_min
    mins_min = []
    
    mins_min_std = []
    for i in pop_sizes:
        curr_mins_min = []
        for j in range(4):
            opt_f = 'GA_log' + str(i) + '_' +str(j) + '.pkl'
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
                curr_mins = numpy.array(curr_mins)
                non_zeros = curr_mins.nonzero()
                curr_mins = curr_mins[non_zeros]
            curr_mins_min.append(numpy.min(curr_mins))
            
            
        mins_min.append(numpy.mean(numpy.array(curr_mins_min)))
        mins_min_std.append(numpy.std(numpy.array(curr_mins_min)))
    print(mins_min)
    print(mins_min_std)
    counter =0
    matcounter=0
    mat_len = max(len(mins[0]),len(mins[1]))
    res = numpy.zeros((mat_len,100))
    for i in pop_sizes:
        for j in range(4):
            print(counter)
            curr_mins = mins[counter]
            curr_nevals = nevals[counter]
            res[:len(curr_mins),matcounter] = curr_mins
            counter+=1
            matcounter+=1
            res[:len(curr_nevals), matcounter] = numpy.cumsum(curr_nevals)
            matcounter += 1
    
            print(counter)
    numpy.savetxt(res_file,res,delimiter=',')
def get_bestindvs():
    data = numpy.genfromtxt(params_table,delimiter=',',names=True)
    pmin = data[0]
    pmax = data[1]
    all_bests = []
    for i in pop_sizes:
        for j in range(4):
            opt_f = 'GA_log' + str(i) + '_' +str(j) + '.pkl'
            with open(optims_folder + opt_f, "rb") as f:
                
                curr_log = pickle.load(f)
                hof = pickle.load(f)
                curr_best = hof[0]
                all_bests.append(curr_best)
                
    all_bests = numpy.array(all_bests)
    for pind in range(0,len(pmin)):
        min_p = pmin[pind]
        max_p = pmax[pind]
        neg_ind = numpy.where(all_bests[:,pind]<0)
        all_bests[neg_ind,pind] = all_bests[neg_ind,pind] *-1
        p_values = all_bests[:,pind]*(max_p-min_p)+min_p
        all_bests[:,pind] = p_values
    numpy.savetxt('all_bests.csv',all_bests,delimiter=' ')
def calc_times():
    time_table = []
    for i in pop_sizes:
        timeslog = optims_folder + 'GA_runtimes' + str(i) + '.pkl'        
        curr_times =numpy.genfromtxt(timeslog)
        print (curr_times)
        time_table.append([i,numpy.mean(curr_times)])
    numpy.savetxt('all_times.csv',numpy.array(time_table))
plot_results()
