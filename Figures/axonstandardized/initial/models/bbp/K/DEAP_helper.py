
import os
import neuron as nrn
import random
from deap import base, creator, tools, algorithms



def init_nrngpu():
    modelFile = "./runModel.hoc"
    nrn.h.load_file( modelFile)
    from NeuroGPUFromPkl import run_params_with_pkl
    data_dir = '/Data/'
    hocmodel_name = data_dir + os.path.basename(nrn.h.modelFile)[:-3] + 'pkl'


def initIndv(nparams,mins,maxs):
    indv = [random.uniform(mins[i],maxs[i]) for i in xrange(nparams)]
    return indv
def getVolts(params):
    nrn.h.transvec.from_python(params)
    nrn.h.psize = 1
    nrn.h("initialize(v_init)")
    nrn.h("pmat = new Matrix(1,nparams)")
    nrn.h("pmat.setrow(0,transvec)")
    nrn.h("runMatrix(pmat, stims)")

    return nrn.h.matOut.getrow(0).to_python()