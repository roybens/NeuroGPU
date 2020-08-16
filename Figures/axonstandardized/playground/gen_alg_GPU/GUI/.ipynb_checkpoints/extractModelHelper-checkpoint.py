working = '../Figures/Figure3_passive'
#working.replace('/', '\\')
base = '../NeuroGPU_Base'
#base.replace('/', '\\')


import ipywidgets as widgets
import shutil



# for Python3

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
    global template
    global working
    text_neurogpu_dir = widgets.Text(description="NeuroGPU location:", style=style, layout=widgets.Layout(width='600px'))
    text_neurogpu_dir.value = 'choose where NeuroGPU is located'
    text_neurogpu_dir.value = '../NeuroGPU_Base'
    
    base = text_neurogpu_dir.value
    base = text_neurogpu_dir.value.replace('/', '\\')
    global template
    template = base + "\\scripts\\template"
    text_neurogpu_dir.width = '50%'
    display(text_neurogpu_dir)

    # button = widgets.Button(description="Select NeurGPU Directory:", layout=Layout(width='300px'))
    button = widgets.Button(description="Select NeuroGPU Directory:", layout=widgets.Layout(width='300px'))

    display(button)

    def on_button_clicked0_1(b):
        global template
        global base
        text_neurogpu_dir.value = test()
        base = text_neurogpu_dir.value.replace('/', '\\')
        template = base + "\\scripts\\template"

    button.on_click(on_button_clicked0_1)
    text = widgets.Text(description="Working Filepath:", style=style, layout=widgets.Layout(width='600px'))
    text.value = 'choose where is the NEURON model'
    text.value = '../Figures/Figure3_passive'
    global working
    

    text.width = '50%'
    display(text)
    button = widgets.Button(description="Select Working Directory:", layout=widgets.Layout(width='300px'))
    working = text.value
    display(button)

    def on_button_clicked_1(b):
        global working
        text.value = test()
        working = text.value

    button.on_click(on_button_clicked_1)

    from distutils.dir_util import copy_tree

    button = widgets.Button(description="Generate/Rest Working Files:", layout=widgets.Layout(width='300px'))
    display(button)

    def on_button_clicked2_1(b):
        global working
        global template
        working = text.value.replace('/', '\\')

        copy_tree(template, working)
        hoctemplate = open(working + '/runModel-template.hoc')
        thefile = open(working + '/runModel.hoc', 'w')
        thefile.write(hoctemplate.read())
        thefile.close()
        print ("Working files generated at: " + working)
        print (working + '/runModel.hoc has been reset')

    button.on_click(on_button_clicked2_1)


def init_compile_mod():
    global working
    global modpath
    text = widgets.Text(description="Mod Filepath::", width="300px")
    text.value = working
    display(text)
    button = widgets.Button(description="Select Mod Directory:", width="100%")
    display(button)

    def on_button_clicked_2(b):
        global modpath
        text.value = test()
        modpath = text.value.replace('/', '\\')

    button.on_click(on_button_clicked_2)
    show_comp_button()


import os
import os.path
from ipywidgets import FloatProgress
from IPython.display import display
from subprocess import Popen, PIPE, STDOUT


def compile():
    global template
    global modpath
    os.chdir(modpath)
    if os.path.exists("pas.mod"):
        os.remove("pas.mod")
    p = Popen('compile.bat', stdout=PIPE, stderr=STDOUT, shell=True)
    f = FloatProgress(min=0, max=100, description='Compiling Mod files...')
    display(f)
    path, dirs, files = os.walk(modpath).next()
    increment = 100 / (len(files))
    for line in iter(p.stdout.readline, ""):
        print (line)
        if line.split(' ', 1)[0] == 'Translating':
            f.value = f.value + increment
    while True:
        if os.path.isfile(modpath + '/nrnmech.dll') == True:
            print ("Compiling Successful")
            break


def show_comp_button():
    button = widgets.Button(description="Compile Mod Files", width="100%")
    display(button)

    def on_button_clicked2_3(b):
        compile()

    button.on_click(on_button_clicked2_3)


# SELECT INPUT FILES

from IPython.display import display
from ipywidgets import *
from shutil import copyfile

global file_values
file_values = ["", "", "", ""]
global time_file
global stim_file
global param_file


def replace_line(file_name, line_num, text):
    lines = open(file_name, 'r').readlines()
    lines[line_num + 1] = text
    out = open(file_name, 'w')
    out.writelines(lines)
    out.close()


def get_file_dialog():
    global working
    root = Tk()
    root.withdraw()
    root.call('wm', 'attributes', '.', '-topmost', True)
    infiles = askopenfilename(initialdir=working, multiple=False)
    return infiles


def init_input_files(label, fill, index):
    global time_file
    global stim_file
    global param_file
    global working
    file_values[index] = widgets.Text(description=label + ":", layout=widgets.Layout(width='400px'))
    file_values[index].value = fill
    display(file_values[index])
    button3_1 = widgets.Button(description="Select " + label + "File:", style=style, layout=widgets.Layout(width='50%'))
    display(button3_1)
    if index == 0:
        param_file = fill
    if index == 1:
        stim_file = fill
    if index == 3:
        time_file = fill

    def on_button_clicked(b):
        global working
        tmpfile= get_file_dialog()
        tmpfile= tmpfile.replace(working.replace('\\','/'),'./')
        file_values[index].value = tmpfile

    button3_1.on_click(on_button_clicked)


def show_input_file_panel():
    global time_file
    global stim_file
    global param_file
    init_input_files("Parameter ", './params/params.csv', 0)
    init_input_files("Stimulation ", './Stims/Step_8_.csv', 1)
    init_input_files("Model ", './mosinit.hoc', 2)
    init_input_files("Times ", './Stims/times.csv', 3)
    button3_2 = widgets.Button(description="Integrate Files", layout=widgets.Layout(width='50%'))
    display(button3_2)
    def on_button_clicked2(b):
        integrate1()

    button3_2.on_click(on_button_clicked2)

    param_file = file_values[0].value
    stim_file = file_values[1].value
    time_file = file_values[3].value


def integrate1():
    os.chdir(working)
    global base
    replace_line('runModel.hoc', 11, 'base = "%s" \n' % base.replace('\\','/'))
    replace_line('runModel.hoc', 12, 'paramsFile = "%s" \n' % (file_values[0].value))
    replace_line('runModel.hoc', 13, 'stimFile = "%s" \n' % (file_values[1].value))
    replace_line('runModel.hoc', 14, 'modelFile = "%s" \n' % (file_values[2].value))
    replace_line('runModel.hoc', 15, 'timesFile = "%s" \n' % (file_values[3].value))
    replace_line('runModel_topo.hoc', 11, 'base = "%s" \n' % base.replace('\\','/'))
    replace_line('runModel_topo.hoc', 12, 'paramsFile = "%s" \n' % (file_values[0].value))
    replace_line('runModel_topo.hoc', 13, 'stimFile = "%s" \n' % (file_values[1].value))
    replace_line('runModel_topo.hoc', 14, 'modelFile = "%s" \n' % (file_values[2].value))
    replace_line('runModel_topo.hoc', 15, 'timesFile = "%s" \n' % (file_values[3].value))
    global time_file
    global stim_file
    global param_file
    param_file = file_values[0].value
    stim_file = file_values[1].value
    time_file = file_values[3].value
    print ("time file is " + time_file)

    print("Input files successfully integrated")


import numpy as np
from IPython.display import display
from ipywidgets import *

global run_var_values
run_var_values = ["", "", "", "", "", ""]


def init_vals(label, fill, index):
    run_var_values[index] = widgets.Text(description=label, width="600px")
    run_var_values[index].value = fill

    display(run_var_values[index])


def show_run_var_panel():
    global time_file
    global stim_file
    global param_file
    if (time_file.find('csv') !=-1):
        times = np.genfromtxt(time_file)
        timeSteps = len(times)
    else:
        timeSteps =0
    if (stim_file.find('csv') != -1):
        stims = np.genfromtxt(stim_file)
        if stims.ndim == 2:
            nstims = stims.shape[1]
        else:
            nstims = 1
    else:
        nstims = 1;
    if (param_file.find('csv') != -1):
        params = np.genfromtxt(param_file,delimiter=" ")
        if params.ndim == 2:
            nmodels = params.shape[0]
            nparams = np.shape(params)[1]
        else:
            nmodels = 1
            nparams = len(params)
    else:
        nmodels=1
        nparams = 1

    init_vals("# Timestep ", str(timeSteps), 0)
    init_vals("# Parameters", str(nparams), 1)
    init_vals("# Models", str(nmodels), 2)
    init_vals("# Traces ", str(nstims), 3)
    init_vals("V_init ", str(-80), 4)
    init_vals("Recalculate ECa? ", str(1), 5)
    button = widgets.Button(description="Integrate Running Variables", layout=widgets.Layout(width='500px'))
    display(button)

    def on_button_clicked2_5(b):
        integrate2()

    button.on_click(on_button_clicked2_5)


def integrate2():
    replace_line('runModel.hoc', 2, 'ntimestep = %s \n' % run_var_values[0].value)
    replace_line('runModel.hoc', 3, 'nparams = %s \n' % run_var_values[1].value)
    replace_line('runModel.hoc', 4, 'psize = %s \n' % run_var_values[2].value)
    replace_line('runModel.hoc', 5, 'ntraces = %s \n' % run_var_values[3].value)
    replace_line('runModel.hoc', 6, 'v_init = %s \n' % run_var_values[4].value)
    replace_line('runModel.hoc', 7, 'calc_eca = %s \n' % run_var_values[5].value)
    replace_line('runModel_topo.hoc', 2, 'ntimestep = %s \n' % run_var_values[0].value)
    replace_line('runModel_topo.hoc', 3, 'nparams = %s \n' % run_var_values[1].value)
    replace_line('runModel_topo.hoc', 4, 'psize = %s \n' % run_var_values[2].value)
    replace_line('runModel_topo.hoc', 5, 'ntraces = %s \n' % run_var_values[3].value)
    replace_line('runModel_topo.hoc', 6, 'v_init = %s \n' % run_var_values[4].value)
    replace_line('runModel_topo.hoc', 7, 'calc_eca = %s \n' % run_var_values[5].value)
    print("Input files successfully integrated")
import re

def select_inj_site():
    global working
    working.replace('/', '\\')
    os.chdir(working)
    aa = ''
    p = Popen("python test2.py", stdout=PIPE, stderr=None, shell=True)
    for line in iter(p.stdout.readline, ""):
        #print(line)
        if "PRINTING COMPARTMENT" in str(line):
            break
    line = p.stdout.readline()
    #print(line)
    line = eval(line)
    x = line
    #print(line)
    result = []
    prefix = ''
    import re

    dot_ind = x[0].find('.')
    if dot_ind != -1:
        prefix = x[0][:dot_ind] + '.'

    for e in x:
        if e.find('.') != -1:
            e = e[e.find('.') + 1:]
        p = re.compile(r'\[\d+\]')
        test_str = e
        result.append([e for e in p.split(test_str) if e])
    result = [l[0] for l in result]

    newx = {i: result.count(i) for i in result}
    n = list(newx.keys())

    e = (widgets.FloatSlider(min=0, max=1, step=.01, value=0, description="Section Location (0-1)"));
    button = widgets.Button(description="Create Injection Site", width="100%")
    display(button)
    display(e);

    def f(c):
        global a, pop, has_subset;
        has_subset = False;
        try:
            po = a.close();
        except:
            pass

        pop = c
        if newx[c] - 1 != 0:
            a = (widgets.IntSlider(min=0, max=newx[c] - 1, description="Section subset", step=1, value=0));
            po = display(a);
            has_subset = True;

    o = widgets.interact(f, c=widgets.Dropdown(options=n, value=n[0], description='Section:', disabled=False));

    # button = widgets.Button(description="Create Injection Site", width="100%")
    def on_button_clicked2_7(b):
        linex = 'access %s' % (prefix + pop)

        if has_subset == True:
            linex = linex + ('[%s]' % a.value)
        replace_line('runModel.hoc', 29, linex + '\n')
        replace_line('runModel.hoc', 10, '   stLoc = %s \n' % e.value)
        # thefile.write(template.read())
        # thefile.close()
        print("Injection site successfully integrated")
        # print a.value, pop, e.value, has_subset

    button.on_click(on_button_clicked2_7)


def run_trans_script_gui():
    global working
    global base
    
    def translate():
        global template
        template = base + "/scripts/pyscripts"
        template.replace('/', '\\')
        working
        src_files = os.listdir(template)
        for file_name in src_files:

            full_file_name = os.path.join(template, file_name)
            if (os.path.isfile(full_file_name)):
                print (full_file_name)
                shutil.copy(full_file_name, working)
        create_topo()
        os.chdir(working)
        p = Popen("python extractModel.py", stdout=PIPE, stderr=STDOUT, shell=True)
        for line in iter(p.stdout.readline, ""):
            print (line)
    button = widgets.Button(description="Translate to CUDA Code", width="100%")
    display(button)

    def on_button_clicked2_8(b):
        translate()

    button.on_click(on_button_clicked2_8)

    def create_topo():
        global working
        template = open(working + '/topo_code.hoc')
        template1 = open(working + '/runModel.hoc')
        thefile = open(working + '/runModel_topo.hoc', 'w')
        thefile.write(template1.read())
        thefile.write(template.read())
        thefile.close()