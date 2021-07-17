import numpy as np
import ipywidgets as widgets
import shutil
import matplotlib.pyplot as plt
import struct
import os


global base
global all_volts
global times
global stim
dt = 0.1

def y_or_n_input(text):
    y_or_n = False
    while not y_or_n:
        result = input(text)
        if result == 'y' or result == 'n':
            y_or_n = True
        else:
            print("please enter y or n")
    return result

def input_file(text, default=None):
    y_or_n = False
    while not y_or_n:
        if default:
            print("If you hit enter then you will use default file: {}".format(default))
            result = input(text)
        else:
            result = input(text)
        if not result or result == '' and default:
            result = default
            y_or_n = True
        if os.path.isfile(result):
            y_or_n = True
        else:
            print("please enter a valid file")
    return result

def input_dir(text, default=None):
    y_or_n = False
    while not y_or_n:
        if default:
            print("If you hit enter then you will use default file: {}".format(default))
            result = input(text)
        else:
            result = input(text)
        if not result or result == '' and default:
            result = default
            y_or_n = True
        if os.path.isdir(result):
            y_or_n = True
        else:
            print("please enter a valid file")
    return result


def input_var(text, default=None):
    if default:
        print("If you hit enter then you will use default value: {}".format(default))
        result = input(text)
    else:
        result = input(text)
        
    if not result or result == '' and default:
        result = default
        
    return result



def init_working_dir():
    global base
    neuroGPU_dir_text = 'choose where simulation output is located'
    default_dir = 'pyNeuroGPU_unix/Data/'
    
    base = input_dir(neuroGPU_dir_text, default_dir)
# def init_working_dir():
#     global base
#     text_neurogpu_dir = widgets.Text(description="location:", style=style, layout=Layout(width='600px'))
#     text_neurogpu_dir.value = 'choose where simulation output is located'
#     text_neurogpu_dir.value = 'C:/BBP_new/Data/'
#     base = text_neurogpu_dir.value
#     base = text_neurogpu_dir.value.replace('/', '\\')
#     text_neurogpu_dir.width = '50%'
#     display(text_neurogpu_dir)
#     button = widgets.Button(description="Select Directory:", layout=Layout(width='300px'))
#     display(button)

#     def on_button_clicked0_1(b):
#         try:
#             text_neurogpu_dir.value = test()
#         except TclError:
#             text_neurogpu_dir.value = input("Tkinter does not work on this platform \n type directory here : " )
#         base = text_neurogpu_dir.value.replace('/', '\\')

#     button.on_click(on_button_clicked0_1)


def nrnMread(fileName):
    f = open(fileName, "rb")
    nparam = struct.unpack('i', f.read(4))[0]
    print(nparam)
    typeFlg = struct.unpack('i', f.read(4))[0]
    return np.fromfile(f, np.double)

def plotModel(model_ind, stim_ind):
    volts = all_volts[int(model_ind), :]
    plt.xlabel('timestep')
    plt.ylabel('Volts [mV]')
    plt.title('Stimulation')
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




def on_button_clicked0_1(b):
    button.on_click(on_button_clicked0_1)


def readOutput(folder,vhot_fn):
    global base
    global all_volts
    global times
    global stim
    timesFN = folder + 'times.csv'
    time_steps = np.genfromtxt(timesFN, delimiter=',')
    times = np.cumsum(time_steps)
    Nt = time_steps.size
    stimFN = folder + 'Stim_raw.csv'
    stim = np.genfromtxt(stimFN, delimiter=',')
    all_volts = nrnMread(folder + vhot_fn)
    all_volts = np.array(all_volts)
    if stim.ndim == 2:
        Nstim = params.shape[0]
    else:
        Nstim = 1
        psize = int(len(all_volts) / Nt)
        
        all_volts = np.reshape(all_volts, [psize, Nt])
        stim = stim[:Nt]

        plotModel(0,0)
#         saveModel(1e,folder)


#     text_nmodels = widgets.Text(description="#Models:", style=style, layout=Layout(width='600px'), disabled=True)
#     text_nmodels.value = str(psize)
#     display(text_nmodels)
#     text_nstims = widgets.Text(description="#Stims:", style=style, layout=Layout(width='600px'), disabled=True)
#     text_nstims.value = str(Nstim)
#     display(text_nstims)
#     text_chooseModel = widgets.Text(description="Choose Model:", style=style, layout=Layout(width='600px'))
#     text_chooseModel.value = str(1)
#     display(text_chooseModel)
#     text_chooseStim = widgets.Text(description="Choose Stim:", style=style, layout=Layout(width='600px'))
#     text_chooseStim.value = str(1)
#     display(text_chooseStim)
#     plotbutton = widgets.Button(description="plot model:", layout=Layout(width='300px'))
#     display(plotbutton)

#     def on_button_clicked0_1(b):
#         plotModel(text_chooseModel.value, text_chooseStim.value)
#     savebutton = widgets.Button(description="save volts:", layout=Layout(width='300px'))
#     display(savebutton)
#     def on_button_clicked0_2(b):
#         saveModel(text_chooseModel.value, text_chooseStim.value,folder)
#     plotbutton.on_click(on_button_clicked0_1)
#     savebutton.on_click(on_button_clicked0_2)

