# -*- coding: utf-8 -*-
"""
Created on Mon Oct  5 13:44:17 2020

@author: bensr
"""

import sys
from neuron import h, gui
import numpy as np
import matplotlib.pyplot as plt

h.load_file("runModel.hoc")
param_list = np.loadtxt('./params/params.csv')

pc = h.ParallelContext()
h.dt = 0.1
ntimesteps = 5000
tstop = ntimesteps*h.dt
pc.set_maxstep(10)
root_name = h.secname(sec=h.cell.soma[0])
class Cell():
  def __init__(self, gid):
    print(root_name)
    self.gid = gid
    pc.set_gid2node(gid, pc.id())
    curr_p = param_list[gid]*gid
    h.transvec = h.Vector(curr_p)
    h.tfunc()
    #ic = h.IClamp(h.cell.soma[0](.5))
    h.st.delay = 100
    h.st.dur = 100
    h.st.amp = 0.5
    self.v = h.Vector()
    self.v.record(h.cell.soma[0](.5)._ref_v,sec = h.cell.soma[0])


ncell = len(param_list)
ncell = 100
gids = range(pc.id(), ncell) # round robin
cells = [Cell(gid) for gid in gids]

# make sure to enable cache efficiency
h.cvode.cache_efficient(1)
#print(pc.dt())
def prun():
    
    h.finitialize(-65)
    h.tstop = tstop
    pc.psolve(tstop)
prun()
allvs = []
for curr_cell in cells:
    curr_vs = curr_cell.v.to_python()
    allvs.append(curr_vs)
    plt.plot(curr_vs)
vsstd = np.mean(allvs,0)
max(vsstd)
# #myobj = h.NetCon(h.soma(0.5)._ref_v, None, sec=h.soma)
# #pc.cell(pc.id()+1, myobj)

# # First run NEURON and record spikes

# h.run()

# # copy vector as numpy array

# nrn_spike_t = nrn_spike_t.to_python()
# nrn_spike_gids = nrn_spike_gids.to_python()

# # now run CoreNEURON
# from neuron import coreneuron
# coreneuron.enable = True
# coreneuron.verbose = 0
# h.stdinit()
# corenrn_all_spike_t = h.Vector()
# corenrn_all_spike_gids = h.Vector()
# pc.spike_record(-1, corenrn_all_spike_t, corenrn_all_spike_gids )
# pc.psolve(h.tstop)

# # copy vector as numpy array
# corenrn_all_spike_t = corenrn_all_spike_t.to_python()
# corenrn_all_spike_gids = corenrn_all_spike_gids.to_python()

# # check spikes match between NEURON and CoreNEURON
# assert(nrn_spike_t == corenrn_all_spike_t)
# assert(nrn_spike_gids == corenrn_all_spike_gids)

# h.quit()