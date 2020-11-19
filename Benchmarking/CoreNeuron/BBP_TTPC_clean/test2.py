# -*- coding: utf-8 -*-
"""
Created on Thu Oct  8 11:40:29 2020

@author: bensr
"""

from neuron import h
h.nrnmpi_init()       # initialize MPI
pc = h.ParallelContext()
print('I am {} of {}'.format(pc.id(), pc.nhost()))
h.quit()              # necessary to avoid a warning message on parallel exit on some systems