# -*- coding: utf-8 -*-
"""
Created on Mon Oct  5 13:44:17 2020

@author: bensr
"""

import sys
from neuron import h, gui
import numpy as np
import matplotlib.pyplot as plt
h.nrnmpi_init()
pc = h.ParallelContext()
print(f'First: the mpi_id is {pc.id()} ')
h.load_file("runModel.hoc")
param_list = np.loadtxt('./params/params.csv')
h.dt = 0.1
ntimesteps = 5000
tstop = ntimesteps*h.dt
pc.set_maxstep(10)
#root_name = h.secname(sec=h.cell.soma[0])
class Cell:
    def __init__(self, gid):
        print(f'BEGIN: the mpi_id is {pc.id()} and gid is {gid}')
        self.hoc_cell = h.cADpyr232_L5_TTPC1_0fb1ca4724()
        self.gid = gid
        pc.set_gid2node(gid, pc.id())
        curr_p = param_list[gid]*gid
        self.update_params(curr_p)
        self.ic = h.IClamp(self.soma[0](.5))
        self.ic.delay = 100
        self.ic.dur = 100
        self.ic.amp = 0.5
        self.v = h.Vector().record(self.soma[0](.5)._ref_v,sec=self.soma[0])
        print(f'INITIALIZE END: the mpi_id is {pc.id()} and gid is {gid}')
    
    def __getattr__(self, name):
        # we don't have it, see if the hoc_cell has it?
        return getattr(self.hoc_cell, name)
    def update_params(self,p):
        for curr_sec in self.hoc_cell.axonal:
            curr_sec.gNaTa_tbar_NaTa_t = p[0]
            curr_sec.gK_Tstbar_K_Tst = p[2]
            curr_sec.gSKv3_1bar_SKv3_1 = p[5]
        for curr_sec in self.hoc_cell.somatic:
            curr_sec.gNaTs2_tbar_NaTs2_t = p[1]
        for curr_sec in self.hoc_cell.apical:
            curr_sec.gIhbar_Ih = p[3]
            curr_sec.gImbar_Im = p[4]
        
            

ncell = len(param_list)
ncell = 10
gids = range(pc.id(), ncell,pc.nhost()) # round robin
#print(f'the mpi_id is {pc.id()} and gids are {gids}')
cells = [Cell(gid) for gid in gids]
# make sure to enable cache efficiency
h.cvode.cache_efficient(True)
#print(pc.dt())
def prun():
    
    h.finitialize(-65)
    h.tstop = tstop
    pc.psolve(tstop)

prun()
pc.barrier()
print (f'after prun  pc.id() is {pc.id()}')
if pc.id() ==1:
    print("**************************************************")
    allvs = []
    allvs = [None]*ncell
    for gid in range(ncell):
        #curr_cell = cells[gid]
        print("**************************************************")
        curr_cell = pc.gid2cell(gid)
        curr_vs = curr_cell.v.to_python()
        print(f'gid is {gid}')
        #print(curr_vs)
        allvs[gid] = curr_vs
    print(allvs)
    np.savetxt('allvs.csv',allvs)

