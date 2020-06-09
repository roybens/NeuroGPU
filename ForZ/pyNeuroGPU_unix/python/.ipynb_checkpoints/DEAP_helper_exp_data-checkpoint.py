
import os
import subprocess
import shutil
import time
import neuron as nrn
import random
import numpy
import struct
import pickle
import matplotlib.pyplot as plt
import math
from deap import base, creator, tools, algorithms
from score_functions import *
from NeuroGPUFromPkl import run_params_with_pkl
import efel_ext
global pmax
global pmin
global ptarget
global orig_volts
global gen_counter
gen_counter = 0
NPARAMS = 4
HIGH_NUMBER = 10000
POP_SIZE = 2000
model_dir = 'E:/Workspace/BBP_scn2a/BBP_new_50amp'
data_dir = model_dir+'/Data/'
param_file = model_dir + '/params/gen.csv'
run_dir = 'C:/pyNeuroGPU_win2/'
vs_fn = run_dir + 'Data/VHotP.dat'
params_table = './params/opt_table.csv'
orig_volts_fn = data_dir + './030117J_50_wt.txt'
def nrnMread(fileName):
    f = open(fileName, "rb")
    nparam = struct.unpack('i', f.read(4))[0]
    typeFlg = struct.unpack('i', f.read(4))[0]
    return numpy.fromfile(f,numpy.double)
def nrnMreadOrig(fileName):
    f = open(fileName, "rb")
    nparam = struct.unpack('i', f.read(4))[0]
    typeFlg = struct.unpack('i', f.read(4))[0]
    return numpy.fromfile(f,numpy.float32)


def getOrig(fileName):

    nrn.h.paramsFile = fileName
    nrn.h.psize=1
    nrn.h("pmat = new Matrix(psize, nparams)")
    nrn.h("readMatrix(paramsFile, pmat)")
    nrn.h("runMatrix(pmat,stims)")
    nrn.h("print matOut")
    nrn.h("matOut = matOut.to_vector()")
    orig_volts = nrn.h.matOut.to_python()
    return orig_volts
def similiar(indv1,indv2):
    ans = 0
    for ind in range(len(indv1)):
        ans = ans + abs(indv1[ind] - indv2[ind])
    if(ans<0.01):
        return True
    return False


def init_nrngpu():
    global pmin
    global pmax
    global ptarget
    global orig_volts
    modelFile = "./runModel.hoc"
    nrn.h.load_file(modelFile)
    data = numpy.genfromtxt(params_table,delimiter=',',names=True)
    pmin = data[0]
    pmax = data[1]
    ptarget = data[2]
    orig_volts = [numpy.genfromtxt(orig_volts_fn)]

init_nrngpu()



hocmodel_name =  data_dir + os.path.basename(nrn.h.modelFile)[:-3] + 'pkl'
#creator.create("FitnessMulti", base.Fitness, weights=(-1,-1.0,-1.0,-1.0,-1.0,-1.0,-1.0,-1.0,-1.0,-1.0,-1.0,-10.0,-1.0))
creator.create("FitnessMax", base.Fitness, weights=(-1.0,-1.0,-1.0)) #-1.0,-1.0,-1.0 -1.0,-1.0,-1.0,-1.0,-1.0,-1.0
creator.create("Individual", list, fitness=creator.FitnessMax)
#my_weights = (-10,-5.0,-1.0,-1.0,-5.0,-1.0,-10.0,-1.0,-1.0,-1.0,-1.0,-500.0,-20.0)
my_weights=(1.0,1.0,100,1.0,1.0,1.0,1.0)
toolbox = base.Toolbox()
toolbox.register("attr_float", random.random)
toolbox.register("individual", tools.initRepeat, creator.Individual,
                 toolbox.attr_float, n=NPARAMS)
toolbox.register("population", tools.initRepeat, list, toolbox.individual)
toolbox.register("mate", tools.cxTwoPoint)
toolbox.register("mutate", tools.mutGaussian, mu=0, sigma=1, indpb=0.2)
toolbox.register("select", tools.selNSGA2)


def evaluate(population):
    global orig_volts
    param_mat = numpy.array(population)
    for pind in range(0,NPARAMS):
        min_p = pmin[pind]
        max_p = pmax[pind]
        neg_ind = numpy.where(param_mat[:,pind]<0)
        param_mat[neg_ind,pind] = param_mat[neg_ind,pind] *-1
        p_values = param_mat[:,pind]*(max_p-min_p)+min_p
        too_low_ind = numpy.where(param_mat[:,pind]<min_p)
        param_mat[too_low_ind,pind] = min_p
        too_big_ind = numpy.where(param_mat[:,pind]<max_p)
        param_mat[too_big_ind,pind] = max_p
        if(min(p_values)<0):
            print("we have a serious error")
        param_mat[:,pind] = p_values

    if os.path.exists(vs_fn):
        os.remove(vs_fn)
    numpy.savetxt(param_file,param_mat,delimiter=' ')
    os.chdir(model_dir)
    curr_psize = len(population)
    run_params_with_pkl(hocmodel_name, param_file, curr_psize)
    shutil.move(data_dir + 'AllParams.csv', run_dir + "/Data/AllParams.csv")
    time.sleep(1)
    os.chdir(run_dir + '/x64/')
    print("call neurogpu6")
    subprocess.call('NeuroGPU6.exe')
    while not os.path.exists(vs_fn):
        time.sleep(10)
        subprocess.call('NeuroGPU6.exe')
        print("call neurogpu6 again")
    #file exists
    volts = nrnMread(vs_fn)
    Nt = int(len(volts)/curr_psize)
    all_volts = numpy.reshape(volts, [curr_psize, Nt])
    plt.plot(all_volts[0],'r')
    plt.plot(orig_volts[0],'b')
    
    plt.show()
    #scores = [None]*len(all_volts)
    print ("not exited before efel")
    score = efel_ext.eval(['step350'], orig_volts,all_volts,my_weights)
    print ("not exited after efel")
    return tuple(score)


toolbox.register("evaluate", evaluate)


def getVolts(params):

    nrn.h.transvec.from_python(params)
    nrn.h.psize = 1
    nrn.h("initialize(v_init)")
    nrn.h("pmat = new Matrix(1,nparams)")
    nrn.h("pmat.setrow(0,transvec)")
    nrn.h("runMatrix(pmat, stims)")

    return nrn.h.matOut.getrow(0).to_python()


def varOr(population, toolbox, lambda_, cxpb, mutpb):
    """Part of an evolutionary algorithm applying only the variation part
    (crossover, mutation **or** reproduction). The modified individuals have
    their fitness invalidated. The individuals are cloned so returned
    population is independent of the input population.

    :param population: A list of individuals to vary.
    :param toolbox: A :class:`~deap.base.Toolbox` that contains the evolution
                    operators.
    :param lambda\_: The number of children to produce
    :param cxpb: The probability of mating two individuals.
    :param mutpb: The probability of mutating an individual.
    :returns: The final population
    :returns: A class:`~deap.tools.Logbook` with the statistics of the
              evolution

    The variation goes as follow. On each of the *lambda_* iteration, it
    selects one of the three operations; crossover, mutation or reproduction.
    In the case of a crossover, two individuals are selected at random from
    the parental population :math:`P_\mathrm{p}`, those individuals are cloned
    using the :meth:`toolbox.clone` method and then mated using the
    :meth:`toolbox.mate` method. Only the first child is appended to the
    offspring population :math:`P_\mathrm{o}`, the second child is discarded.
    In the case of a mutation, one individual is selected at random from
    :math:`P_\mathrm{p}`, it is cloned and then mutated using using the
    :meth:`toolbox.mutate` method. The resulting mutant is appended to
    :math:`P_\mathrm{o}`. In the case of a reproduction, one individual is
    selected at random from :math:`P_\mathrm{p}`, cloned and appended to
    :math:`P_\mathrm{o}`.

    This variation is named *Or* beceause an offspring will never result from
    both operations crossover and mutation. The sum of both probabilities
    shall be in :math:`[0, 1]`, the reproduction probability is
    1 - *cxpb* - *mutpb*.
    """
    assert (cxpb + mutpb) <= 1.0, (
        "The sum of the crossover and mutation probabilities must be smaller "
        "or equal to 1.0.")

    offspring = []
    for _ in list(range(lambda_)):
        op_choice = random.random()
        if op_choice < cxpb:            # Apply crossover
            ind1, ind2 = map(toolbox.clone, random.sample(population, 2))
            ind1, ind2 = toolbox.mate(ind1, ind2)
            del ind1.fitness.values
            offspring.append(ind1)
        elif op_choice < cxpb + mutpb:  # Apply mutation
            ind = toolbox.clone(random.choice(population))
            ind, = toolbox.mutate(ind)
            del ind.fitness.values
            offspring.append(ind)
        else:                           # Apply reproduction
            offspring.append(random.choice(population))

    return offspring


def eaMuPlusLambda(population, toolbox, mu, lambda_, cxpb, mutpb, ngen,
                   stats=None, halloffame=None, verbose=__debug__):
    best_indvs = []
    """This is the :math:`(\mu + \lambda)` evolutionary algorithm.

    :param population: A list of individuals.
    :param toolbox: A :class:`~deap.base.Toolbox` that contains the evolution
                    operators.
    :param mu: The number of individuals to select for the next generation.
    :param lambda\_: The number of children to produce at each generation.
    :param cxpb: The probability that an offspring is produced by crossover.
    :param mutpb: The probability that an offspring is produced by mutation.
    :param ngen: The number of generation.
    :param stats: A :class:`~deap.tools.Statistics` object that is updated
                  inplace, optional.
    :param halloffame: A :class:`~deap.tools.HallOfFame` object that will
                       contain the best individuals, optional.
    :param verbose: Whether or not to log the statistics.
    :returns: The final population
    :returns: A class:`~deap.tools.Logbook` with the statistics of the
              evolution.

    The algorithm takes in a population and evolves it in place using the
    :func:`varOr` function. It returns the optimized population and a
    :class:`~deap.tools.Logbook` with the statistics of the evolution. The
    logbook will contain the generation number, the number of evalutions for
    each generation and the statistics if a :class:`~deap.tools.Statistics` is
    given as argument. The *cxpb* and *mutpb* arguments are passed to the
    :func:`varOr` function. The pseudocode goes as follow ::

        evaluate(population)
        for g in range(ngen):
            offspring = varOr(population, toolbox, lambda_, cxpb, mutpb)
            evaluate(offspring)
            population = select(population + offspring, mu)

    First, the individuals having an invalid fitness are evaluated. Second,
    the evolutionary loop begins by producing *lambda_* offspring from the
    population, the offspring are generated by the :func:`varOr` function. The
    offspring are then evaluated and the next generation population is
    selected from both the offspring **and** the population. Finally, when
    *ngen* generations are done, the algorithm returns a tuple with the final
    population and a :class:`~deap.tools.Logbook` of the evolution.

    This function expects :meth:`toolbox.mate`, :meth:`toolbox.mutate`,
    :meth:`toolbox.select` and :meth:`toolbox.evaluate` aliases to be
    registered in the toolbox. This algorithm uses the :func:`varOr`
    variation.
    """
    logbook = tools.Logbook()
    logbook.header = ['gen', 'nevals'] + (stats.fields if stats else [])

    # Evaluate the individuals with an invalid fitness
    invalid_ind = [ind for ind in population if not ind.fitness.valid]
    fitnesses = evaluate(invalid_ind)

    for ind, fit in zip(invalid_ind, fitnesses):
        ind.fitness.values = fit

    if halloffame is not None:
        halloffame.update(population)

    record = stats.compile(population) if stats is not None else {}
    logbook.record(gen=0, nevals=len(invalid_ind), **record)
    if verbose:
        print(logbook.stream)
    which_one = 0
    # Begin the generational process
    for gen in range(1, ngen + 1):
        # Vary the population
        offspring = varOr(population, toolbox, lambda_, cxpb, mutpb)
        
        #offspring[0] = halloffame[0]
        #offspring.insert(0,halloffame[0])
        # Evaluate the individuals with an invalid fitness
        invalid_ind = [ind for ind in offspring if not ind.fitness.valid]
        best_one = halloffame[0]
        invalid_ind =[best_one] + invalid_ind
        
        fitnesses = evaluate(invalid_ind)
        for ind, fit in zip(invalid_ind, fitnesses):
            ind.fitness.values = fit

        # Update the hall of fame with the generated individuals
        if halloffame is not None:
            halloffame.update(offspring)
            
        # Select the next generation population
        population[:] = toolbox.select(population + offspring, mu)
        
        #population[0] = halloffame[-1]
        
        # Update the statistics with the new population
        record = stats.compile(population) if stats is not None else {}
        logbook.record(gen=gen, nevals=len(invalid_ind), **record)
        if verbose:
            best_indvs.append(halloffame[0])
            if gen%5==0:
                pickle.dump( best_indvs, open('best_inds' + str(gen) + '.pkl', "wb" ) )
                pickle.dump( halloffame, open('hof' + str(gen) + '.pkl', "wb" ) )
                pickle.dump( logbook, open('logs' + str(gen) + '.pkl', "wb" ) )
                print (logbook.stream)
                print (logbook)
                
            print(halloffame[0].fitness)
            print(halloffame[0])
        print ("not exited yet gen is " + str(gen))
    print('exiting for somw reason')
    return population, logbook

def main():
    pop=[]
    log=[]
    hof=[]
   #for i2 in list(range(1,10)):
    popsizes = [5000]
    for POP_SIZE in popsizes:
        corrected_pop_size = int(POP_SIZE*1.2)
        for trial in list(range(2)):
            random.seed(64*trial)
            pop = toolbox.population(n=int(corrected_pop_size))
            hof = tools.ParetoFront(similiar)
            stats = tools.Statistics(lambda ind: ind.fitness.values)
           # stats.register("avg", numpy.mean,axis=0)
            
            stats.register("min", numpy.min,axis=0)
            
            pop, log = eaMuPlusLambda(pop, toolbox,mu=int(corrected_pop_size/3),lambda_=corrected_pop_size+int(corrected_pop_size/3)
                                      ,cxpb=0.2, mutpb=0.2, ngen=500,                          stats=stats, halloffame=hof, verbose=True)
            print (log)
            print (pop)
            savelog = data_dir + 'Optims/GA_log' + str(POP_SIZE) + '_'+ str(trial) + '.pkl'
            with open(savelog, 'wb') as output:
                pickle.dump(log, output, pickle.HIGHEST_PROTOCOL)
                pickle.dump(hof, output, pickle.HIGHEST_PROTOCOL)
    return pop, log, hof


if __name__ == "__main__":
    main()
#fn = 'C:/pyNeuroGPU_win2/x64/best_inds.pkl'
#f = open(fn, 'rb') 
#best_indvs = pickle.load(f)
#print (best_indvs)
#numpy.savetxt(param_file,best_indvs,delimiter=' ')
#f.close()