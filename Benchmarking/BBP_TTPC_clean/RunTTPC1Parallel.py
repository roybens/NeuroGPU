# -*- coding: utf-8 -*-
"""
Created on Mon Oct  5 14:10:54 2020

@author: bensr
"""
from neuron import h
from neuron.units import ms, mV
import matplotlib.pyplot as plt
from TTPC1 import Cell
import sys

#print("\n".join(sys.argv))
import numpy as np
cell_to_plot = 0
param_list = np.loadtxt('./params/params.csv')
#ncell = len(param_list)
ncell = int(sys.argv[1])
pc = h.ParallelContext()
gids = range(pc.id(), ncell,pc.nhost()) # round robin
#print(f'the mpi_id is {pc.id()} and gids are {gids}')
cells = [Cell(gid) for gid in gids]

h.dt = 0.1
ntimesteps = 5000
tstop = ntimesteps*h.dt
pc.set_maxstep(10 * ms)
# make sure to enable cache efficiency
h.cvode.cache_efficient(True)


#print(pc.dt())
def prun():    
    h.finitialize(-65)
    h.tstop = tstop
    pc.psolve(tstop)
prun()
pc.barrier()
if pc.gid_exists(cell_to_plot):
    plt.figure()
    plt.plot(pc.gid2cell(cell_to_plot).soma_v)
    plt.show()
