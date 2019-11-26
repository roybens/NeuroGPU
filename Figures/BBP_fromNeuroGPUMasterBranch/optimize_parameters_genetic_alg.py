import bluepyopt as bpop
import bluepyopt.deapext.algorithms as algo
import neurogpu_evaluator as hoc_ev
import pickle
import time
import numpy as np
from deap import tools

gen_counter = 0
best_indvs = []
cp_freq = 1
old_update = algo._update_history_and_hof

def my_update(halloffame, history, population):
    global gen_counter,cp_freq
    #old_update(halloffame, history, population)
    if halloffame:
        best_indvs.append(halloffame[0])
    gen_counter = gen_counter+1
    print("Current generation: ", gen_counter)
    
    if gen_counter%cp_freq == 0:
        fn = '.pkl'
        save_logs(fn,best_indvs,population)
def my_record_stats(stats, logbook, gen, population, invalid_count):
    '''Update the statistics with the new population'''
    record = stats.compile(population) if stats is not None else {}
    logbook.record(gen=gen, nevals=invalid_count, **record)
    print('log: ', logbook, '\n')
    output = open("log.pkl", 'wb')
    pickle.dump(logbook, output)
    output.close()

def save_logs(fn, best_indvs, hof):
    output = open("indv"+fn, 'wb')
    pickle.dump(best_indvs, output)
    output.close()
    output = open("hof"+fn, 'wb')
    pickle.dump(hof, output)
    output.close()
        
def main():
    print("*****")
    #pool = multiprocessing.Pool(processes=64)
    print('Init evaluator')
    evaluator = hoc_ev.neurogpu_evaluator()
    algo._update_history_and_hof = my_update
    algo._record_stats = my_record_stats
    opt = bpop.optimisations.DEAPOptimisation(evaluator,seed=1178, offspring_size=5000,  eta=20, mutpb=0.3, cxpb=0.7, hof = tools.ParetoFront())
    pop, hof, log, hst = opt.run(max_ngen=1000, cp_filename='cp.pkl', cp_frequency=1)
    fn = time.strftime("%d_%m_%Y_%H_%M")
    #scipy.io.savemat(fn+'.mat',mdict={'hof':hof})
    fn = fn + ".pkl"
    save_logs(fn, best_indvs, hof)
    output = open("indv" + fn, 'wb')
    pickle.dump(best_indvs, output)
    output.close()
    output = open("log"+fn, 'wb')
    pickle.dump(log,output)
    output.close()
    output = open("hst"+fn, 'wb')
    pickle.dump(hst,output)
    output.close()
    print('Hall of fame: ', hof, '\n')
    print('log: ', log, '\n')
    print('History: ', hst, '\n')
    print('Best individuals: ', best_indvs, '\n')
if __name__ == '__main__':
    main()








