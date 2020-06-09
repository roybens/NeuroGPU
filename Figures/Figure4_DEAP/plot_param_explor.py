global orig_volts
global all_volts
import neuron as nrn
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D
import matplotlib.pyplot as plt
from matplotlib import cm
from matplotlib.ticker import LinearLocator, FormatStrFormatter
import numpy
import struct
import math
from score_functions import chi_square_normal
import os
NPARAMS = 6
HIGH_NUMBER = 10000
model_dir = 'C:/BBP_new/'
data_dir = 'C:/BBP_new/Data/'
param_file = 'C:/BBP_new/params/gen.csv'
run_dir = 'C:/pyNeuroGPU_win2/'
vs_fn = run_dir + 'Data/VHotP2.dat'
orig_volts = data_dir + '../volts/orig_step_cADpyr232_L5_TTPC1_0fb1ca4724[0].soma[0].dat'
psize = 100 * 100
modelFile = "./runModelOrig.hoc"
nrn.h.load_file(modelFile)

def nrnMread(fileName,type):
    f = open(fileName, "rb")
    nparam = struct.unpack('i', f.read(4))[0]
    typeFlg = struct.unpack('i', f.read(4))[0]
    return numpy.fromfile(f, type)


def getOrig(fileName):
    nrn.h.paramsFile = fileName
    nrn.h.psize = 1
    nrn.h("pmat = new Matrix(psize, nparams)")
    nrn.h("readMatrix(paramsFile, pmat)")
    nrn.h("runMatrix(pmat,stims)")
    nrn.h("print matOut")
    nrn.h("matOut = matOut.to_vector()")
    orig_volts = nrn.h.matOut.to_python()
    return orig_volts


hocmodel_name = data_dir + os.path.basename(nrn.h.modelFile)[:-3] + 'pkl'
orig_volts = nrnMread(orig_volts,numpy.float32)
print (orig_volts)

def calc_scores(vs_fn):
    global all_volts
    volts = nrnMread(vs_fn,numpy.double)
    Nt = int(len(volts) / 10000)
    all_volts = numpy.reshape(volts, [10000, Nt])
    scores = [None] * len(all_volts)
    for curr_ind in xrange(len(all_volts)):
        temp = chi_square_normal(orig_volts, all_volts[curr_ind])
        if math.isnan(temp):
            temp = HIGH_NUMBER
        scores[curr_ind] = [temp]
    return scores


def plot_scores(scores):
    fig = plt.figure()
    ax = fig.gca(projection='3d')
    scores = numpy.reshape(scores, [100, 100])
    param1 = numpy.linspace(0, 5, 100)
    param2 = numpy.linspace(0, 0.1, 100)
    X,Y = numpy.meshgrid(param1,param2)
    surf = ax.plot_surface(X, Y, scores, cmap=cm.coolwarm,
                           linewidth=0, antialiased=False)
    plt.gca().invert_xaxis()
    # Customize the z axis.
   # ax.set_zlim(-1.01, 1.01)
    ax.zaxis.set_major_locator(LinearLocator(10))
    ax.zaxis.set_major_formatter(FormatStrFormatter('%.02f'))

    # Add a color bar which maps values to colors.
    fig.colorbar(surf, shrink=0.5, aspect=5)

    return plt

def plot_volts(param1_index,param2_index):
    times = numpy.genfromtxt(run_dir + 'Data/times.csv',delimiter=',')
    times = numpy.cumsum(times)
    volts_ind = param1_index*100 + param2_index
    fig = plt.figure(2)
    ax = fig.gca()
    ans = ax.plot(times,all_volts[volts_ind])
    return fig
scores = calc_scores(vs_fn)
res_plot = plot_scores(scores)

v0_0plot= plot_volts(31,0)
res_plot.show()