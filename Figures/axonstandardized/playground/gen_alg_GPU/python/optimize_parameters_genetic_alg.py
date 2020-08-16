import bluepyopt as bpop
import bluepyopt.deapext.algorithms as algo
import pickle
import time
import numpy as np
from datetime import datetime
import argparse
import sys
import argparse
import textwrap
import logging
import os
from mpi4py import MPI

# set up environment variables for MPI
comm = MPI.COMM_WORLD
global_rank = comm.Get_rank()
size = comm.Get_size()

if size > 1:
    import hoc_evaluatorGPU_allen_MPI as hoc_ev
else:
    import hoc_evaluatorGPU_allen_par as hoc_ev
    nGpus = len([devicenum for devicenum in os.environ['CUDA_VISIBLE_DEVICES'] if devicenum != ","])
    #assert nGpus == 8 # this only works if you have 8 gpus, if you are using 6 run the the tests instead


logger = logging.getLogger()
gen_counter = 0
best_indvs = []
cp_freq = 1
old_update = algo._update_history_and_hof


def get_parser():
    parser = argparse.ArgumentParser(
        formatter_class=argparse.RawDescriptionHelpFormatter,
        description='L5PC example',
        epilog=textwrap.dedent('''\
The folling environment variables are considered:
    L5PCBENCHMARK_USEIPYP: if set, will use ipyparallel
    IPYTHON_PROFILE: if set, used as the path to the ipython profile
    BLUEPYOPT_SEED: The seed used for initial randomization
        '''))
    parser.add_argument('--start', action="store_true")
    parser.add_argument('--continu', action="store_false", default=False)
    parser.add_argument('--checkpoint', required=False, default=None,
                        help='Checkpoint pickle to avoid recalculation')
    parser.add_argument('--offspring_size', type=int, required=False, default=2,
                        help='number of individuals in offspring')
    parser.add_argument('--max_ngen', type=int, required=False, default=2,
                        help='maximum number of generations')
    parser.add_argument('--responses', required=False, default=None,
                        help='Response pickle file to avoid recalculation')
    parser.add_argument('--analyse', action="store_true")
    parser.add_argument('--compile', action="store_true")
    parser.add_argument('--hocanalyse', action="store_true")
    parser.add_argument('--seed', type=int, default=42,
                        help='Seed to use for optimization')
    parser.add_argument('--ipyparallel', action="store_true", default=False,
                        help='Use ipyparallel')
    parser.add_argument(
        '--diversity',
        help='plot the diversity of parameters from checkpoint pickle file')
    parser.add_argument('-v', '--verbose', action='count', dest='verbose',
                        default=0, help='-v for INFO, -vv for DEBUG')

    return parser

def my_update(halloffame, history, population):
    global gen_counter, cp_freq
    old_update(halloffame, history, population)
    best_indvs.append(halloffame[0])
    gen_counter = gen_counter+1
    print("Current generation: ", gen_counter)

    if gen_counter%cp_freq == 0:
        fn = '.pkl'
        save_logs(fn, best_indvs, population)

def save_logs(fn, best_indvs, population):
    output = open("./best_indv_logs/best_indvs_gen_"+str(gen_counter)+fn, 'wb')
    pickle.dump(best_indvs, output)
    output.close()
    
def my_record_stats(stats, logbook, gen, population, invalid_count):
    '''Update the statistics with the new population'''
    record = stats.compile(population) if stats is not None else {}
    logbook.record(gen=gen, nevals=invalid_count, **record)
    logbook = comm.bcast(logbook, root=0)
    if global_rank == 0:
        print('log: ', logbook, '\n')
        output = open("log.pkl", 'wb')
        pickle.dump(logbook, output)
        output.close()

def main():
    args = get_parser().parse_args()
    algo._update_history_and_hof = my_update
    algo._record_stats = my_record_stats

    logging.basicConfig(level=(logging.WARNING,
                                logging.INFO,
                                logging.DEBUG)[args.verbose],
                                stream=sys.stdout)
    #opt = create_optimizer(args)
    evaluator = hoc_ev.hoc_evaluator()
    seed = os.getenv('BLUEPYOPT_SEED', args.seed)
    opt = bpop.optimisations.DEAPOptimisation(
        evaluator=evaluator,
        #map_function=map_function,
        seed=seed,
        eta=20,
        mutpb=0.3,
        cxpb=0.7)
    pop, hof, log, hst = opt.run(max_ngen=args.max_ngen,
        offspring_size=args.offspring_size,
        continue_cp=args.continu,
        cp_filename=args.checkpoint,
        cp_frequency=1)
    if global_rank == 0: # only record root process
        fn = time.strftime("_%d_%b_%Y")
        fn = fn + ".pkl"
        output = open("best_indvs_final"+fn, 'wb')
        pickle.dump(best_indvs, output)
        output.close()
        output = open("log"+fn, 'wb')
        pickle.dump(log, output)
        output.close()
        output = open("hst"+fn, 'wb')
        pickle.dump(hst, output)
        output.close()
        output = open("hof"+fn, 'wb')
        pickle.dump(hof, output)
        output.close()
        print ('Hall of fame: ', hof, '\n')
        print ('last log: ', log, '\n')
        print ('History: ', hst, '\n')
        print ('Best individuals: ', best_indvs, '\n')
if __name__ == '__main__':
    main()
