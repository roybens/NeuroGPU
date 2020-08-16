
#import neuron as nrn
import numpy as np
import ipywidgets as widgets
import shutil
import matplotlib.pyplot as plt
import struct

global base
global all_volts
global times
global stim
dt = 0.1
from tkinter import *

from tkinter.filedialog import askopenfilename
from tkinter.filedialog import askdirectory
from ipywidgets import *
def test():
    root = Tk()
    root.withdraw()
    root.call('wm', 'attributes', '.', '-topmost', True)
    infiles = askdirectory()
    return infiles


style = {'description_width': 'initial'}


def init_working_dir():
    global base
    text_neurogpu_dir = widgets.Text(description="location:", style=style, layout=Layout(width='600px'))
    text_neurogpu_dir.value = 'choose where simulation output is located'
    text_neurogpu_dir.value = '../Data/'
    base = text_neurogpu_dir.value
    base = text_neurogpu_dir.value.replace('/', '\\')
    text_neurogpu_dir.width = '50%'
    display(text_neurogpu_dir)
    button = widgets.Button(description="Select Directory:", layout=Layout(width='300px'))
    display(button)

    def on_button_clicked0_1(b):
        text_neurogpu_dir.value = test()
        base = text_neurogpu_dir.value.replace('/', '\\')

    button.on_click(on_button_clicked0_1)


def nrnMread(fileName):
    f = open(fileName, "rb")
    nparam = struct.unpack('i', f.read(4))[0]
    print(nparam)
    typeFlg = struct.unpack('i', f.read(4))[0]
    return np.fromfile(f, np.double)


def plotModel(model_ind, stim_ind):
    volts = all_volts[int(model_ind), :]
    print(max(np.array(volts,dtype=float)), "INDV. MODEL MAX")
    print(max(np.array(all_volts.flatten(), dtype=float)),"ALL VOLT MAX")
    plt.xlabel('timestep')
    plt.ylabel('Volts [mV]')
    plt.title('Stimulation')
    print(len(times), "time len")
    plt.plot(times, volts)
    plt.show()
def saveModel(model_ind, stim_ind,folder):
    volts = all_volts[int(model_ind), :]
    fn = folder + 'traces_' + str(model_ind) + '.csv'
    fndvdt = folder + 'dvdt_' + str(model_ind) + '.csv'
    dvdt = np.diff(volts)
    dvdt = dvdt/dt
    print(fn)
    volts = np.array(volts)
    np.savetxt(fn,volts,delimiter='\n')
    np.savetxt(fndvdt,dvdt,delimiter='\n')


button = widgets.Button(description="Read Output:", layout=Layout(width='300px'))
display(button)


def on_button_clicked0_1(b):
    button.on_click(on_button_clicked0_1)


def readOutput(folder):
    global base
    global all_volts
    global times
    global stim
    timesFN = folder + 'times1.csv'
    time_steps = np.genfromtxt(timesFN, delimiter=',')
    times = np.cumsum(time_steps)
    Nt = time_steps.size
    print("NT", Nt)
    stimFN = folder + 'Stim_raw1.csv'
    stim = np.genfromtxt(stimFN, delimiter=',')
    # nrn_volt = nrn.h.Vector()
    all_volts = nrnMread(folder + 'VHotP1.dat')
    # nrn_fn = nrn.h.File(folder + 'VHotP.dat')
    # nrn_fn.wopen(folder + 'VHotP.dat')
    # nrn_volt.vread(nrn_fn)
    # print nrn_volt
    # all_volts = nrn_volt.to_python()
    all_volts = np.array(all_volts)
    print(stim.ndim, "NDIM")
    if stim.ndim == 2:
        Nstim = params.shape[0]
    else:
        Nstim = 1
        psize = int(len(all_volts) / Nt)
        
        all_volts = np.reshape(all_volts, [psize, Nt])
        stim = stim[:Nt]

    text_nmodels = widgets.Text(description="#Models:", style=style, layout=Layout(width='600px'), disabled=True)
    text_nmodels.value = str(psize)
    display(text_nmodels)
    text_nstims = widgets.Text(description="#Stims:", style=style, layout=Layout(width='600px'), disabled=True)
    text_nstims.value = str(Nstim)
    display(text_nstims)
    text_chooseModel = widgets.Text(description="Choose Model:", style=style, layout=Layout(width='600px'))
    text_chooseModel.value = str(1)
    display(text_chooseModel)
    text_chooseStim = widgets.Text(description="Choose Stim:", style=style, layout=Layout(width='600px'))
    text_chooseStim.value = str(1)
    display(text_chooseStim)
    plotbutton = widgets.Button(description="plot model:", layout=Layout(width='300px'))
    display(plotbutton)
    def on_button_clicked0_1(b):
        plotModel(text_chooseModel.value, text_chooseStim.value)
    savebutton = widgets.Button(description="save volts:", layout=Layout(width='300px'))
    display(savebutton)
    def on_button_clicked0_2(b):
        saveModel(text_chooseModel.value, text_chooseStim.value,folder)
    plotbutton.on_click(on_button_clicked0_1)
    savebutton.on_click(on_button_clicked0_2)

