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
from scipy.signal import find_peaks 
import os
NPARAMS = 6
HIGH_NUMBER = 10000
model_dir = 'E:/Workspace/BBP_new_PE/'
data_dir = model_dir + 'Data/'
param_file = model_dir + 'params/gen.csv'
run_dir = 'C:/Users/bensr/Documents/NeuroGPUBackups/paramexplor/pyNeuroGPU_win2/'
vs_fn = run_dir + 'Data/VHotP.dat'
orig_volts = model_dir + 'volts/orig_step_cADpyr232_L5_TTPC1_0fb1ca4724[0].soma[0].dat'
nbins = 100
psize = nbins * nbins
modelFile = model_dir + "runModel.hoc"
dt = 0.1

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

orig_volts = nrnMread(orig_volts,numpy.float32)
print (orig_volts)

def calc_scores(vs_fn):
    global all_volts
    volts = nrnMread(vs_fn,numpy.double)
    map_2d = []
    #volts = volts[3168*200:3168*400]
    Nt = int(len(volts) / psize)
    all_volts = numpy.reshape(volts, [psize, Nt])
    scores = numpy.ndarray(shape=(nbins,nbins))
    curr_ind = 0
    for p1 in range(nbins):
        for p2 in range(nbins):
            dvdt = numpy.diff(all_volts[curr_ind])
            dvdt = dvdt/dt
        #temp = chi_square_normal(orig_volts, all_volts[curr_ind])
            temp = find_peaks(dvdt,15,distance=5)
            temp = len(temp[0])
            if math.isnan(temp):
                temp = HIGH_NUMBER
            scores[p1,p2] = temp
            curr_ind = curr_ind+1
            map_2d.append([p1,p2])
            
    map_2d = numpy.array(map_2d)
    numpy.savetxt('map2d.csv',map_2d)
    return scores


def plot_scores(scores):
    fig = plt.figure()
    ax = fig.gca(projection='3d')
    #scores = numpy.reshape(scores, [100, 100])
    param1 = numpy.linspace(0, 7, nbins)
    param2 = numpy.linspace(0, 7, nbins)
    X,Y = numpy.meshgrid(param1,param2)
    #surf = ax.plot_surface(X, Y, scores, cmap=cm.coolwarm,linewidth=0, antialiased=False)
    #surf = ax.scatter(X, Y, scores, marker='o')
    surf = ax.imshow(scores)
    #plt.gca().invert_xaxis()
    # Customize the z axis.
   # ax.set_zlim(-1.01, 1.01)
    #ax.zaxis.set_major_locator(LinearLocator(10))
    #ax.zaxis.set_major_formatter(FormatStrFormatter('%.02f'))

    # Add a color bar which maps values to colors.
    #fig.colorbar(surf, shrink=0.5, aspect=5)

    return [scores,X,Y]

def plot_volts(param1_index,param2_index):
    times = numpy.genfromtxt(run_dir + 'Data/times.csv',delimiter=',')
    times = numpy.cumsum(times)
    volts_ind = param1_index*10 + param2_index
    fig = plt.figure(2)
    ax = fig.gca()
    ans = ax.plot(times,all_volts[volts_ind])
    return fig
