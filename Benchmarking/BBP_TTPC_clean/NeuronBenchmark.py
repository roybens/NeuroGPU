# -*- coding: utf-8 -*-
"""
Created on Mon Oct  5 13:44:17 2020

@author: bensr
"""

import sys
from neuron import h, gui
import numpy as np

h.load_file("runModel.hoc")
param_list = np.loadtxt('./params/params.csv')
pc = h.ParallelContext()
h.dt = 0.001
ntimesteps = 5000
tstop = ntimesteps*h.dt
class Cell():
  def __init__(self, gid):
    self.soma = h.Section(name="soma", cell=self)
    self.gid = gid
    pc.set_gid2node(gid, pc.id())
    h.transvec = h.Vector(param_list[gid])
    h.tfunc()

ncell = len(param_list)
gids = range(pc.id(), ncell) # round robin
cells = [Cell(gid) for gid in gids]

# make sure to enable cache efficiency
h.cvode.cache_efficient(1)
def prun():
    h.finitialize(h.v_init)
    h.tstop = tstop
    pc.psolve(tstop)
prun()
    
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