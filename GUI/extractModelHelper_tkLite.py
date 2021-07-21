working = 'BBP_TTPC_EXAMPLE_DEMO'
#working.replace('/', '\\')
base = '../NeuroGPU_Base'
#base.replace('/', '\\')


import ipywidgets as widgets
import shutil

import sys
import io
import time
# for Python3
import shutil
from tkinter import *
import numpy as np
from tkinter.filedialog import askopenfilename
from tkinter.filedialog import askdirectory
from ipywidgets import *
from distutils.dir_util import copy_tree
import os
import os.path
from ipywidgets import FloatProgress
from IPython.display import display
import re
#from subprocess import Popen, PIPE, STDOUT, run
import subprocess

def test():
    root = Tk()
    root.withdraw()
    root.call('wm', 'attributes', '.', '-topmost', True)
    infiles = askdirectory()
    return infiles


style = {'description_width': 'initial'}



def make_wrkdir():
    global working
    global template
#         working = text.value.replace('/', '\\')
    copy_tree(template, working)
    hoctemplate = open(working + '/runModel-template.hoc')
    thefile = open(working + '/runModel.hoc', 'w')
    thefile.write(hoctemplate.read())
    thefile.close()
    print ("Working files generated at: " + working)
    print (working + '/runModel.hoc has been reset')


def init_working_dir():
    global template
    global working
    global template
    global base

    base_text = " Enter NeuroGPU location or enter nothing to use default location ../NeuroGPU_Base"\
                 "\n NeuroGPU location: "
    base_passed = False
    
    working_text = "Enter working directory or use default location BBP_TTPC_EXAMPLE_DEMO" \
                   "\n Working directory location: "
    working_passed = False
    
    
    while not base_passed:
        base = input(base_text)
        if not base: # nothing passed in
            base = "../NeuroGPU_Base"
            base_passed = True
        elif not os.path.isdir(base): # directory structure is wrong
            print(("Please enter a valid path to NeuroGPU Base directory \n"))
        elif not os.path.isdir(os.path.join(base,'scripts','template')):
            print("\n You entered a valid directory but it does not have the correct file structure "\
                         "this prompt is because we expect to see NeuroGPU_base/scripts/template \n ")
        else: # valid input provided
            base_passed = True
    base = os.path.abspath(os.path.normpath(base))
    assert os.path.isdir(base), "not a valid path for base: {}".format(base)
    template = os.path.abspath(os.path.join(base,'scripts','template'))
    assert os.path.isdir(base), "not a valid path for template: {}".format(template)
    
    
    while not working_passed:
        working = input(working_text)
        if not working:
            working = "BBP_TTPC_EXAMPLE_DEMO"
            working_passed = True
        elif not os.path.isdir(working):
            print("Please enter a valid working directory \n ")
        else:
            working_passed = True
            
    working = os.path.abspath(working)
    assert os.path.isdir(working), "not valid path for working directory: {}".format(working)
        
    generate = input("\n Generate rest of working directory? y/n ?: ")
    while generate != 'y' and generate != 'n':
        generate = input("Please choose y or n. Generate rest of working directory? y/n ?: ")
    
    if generate == 'y':
        make_wrkdir()
    else:
        print("You've chosen not to generate the rest of working directory, this can cause issues."\
             "\n If you decide to generate working directory, just call make_wrkdir().")
        
    return working




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


def compile():
    global template
    global modpath
    os.chdir(modpath)
    if os.path.exists("pas.mod"):
        os.remove("pas.mod")
    p = subprocess.Popen('compile.bat', stdout=subprocess.PIPE, stderr=subprocess.STDOUT, shell=True)
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




# SELECT INPUT FILES


global time_file
global stim_file
global param_file


def replace_line(file_name, line_num, text):
    lines = open(file_name, 'r').readlines()
    lines[line_num + 1] = text
    out = open(file_name, 'w')
    out.writelines(lines)
    out.close()






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

def input_var(text, default=None):
    if default:
        print("If you hit enter then you will use default value: {}".format(default))
        result = input(text)
    else:
        result = input(text)
        
    if not result or result == '' and default:
        result = default
        
    return result

        

def show_input_file_panel():
    global time_file
    global stim_file
    global param_file
    global model_file
    # set defaults
    param_file = os.path.join(template,'params','params.csv')
    stim_file = os.path.join(template,'Stims', 'Step_8_.csv')
    model_file = os.path.join(template,'mosinit.hoc')
    time_file = os.path.join(template,'Stims','times.csv')
    use_custom_files = y_or_n_input("would you like to use custom input? y/n: ")
    while use_custom_files != 'y' and  use_custom_files != 'n':
        print("please type y or n")
        use_custom_files = y_or_n_input("would you like to use custom input? y/n: ")
    if use_custom_files == "y":
        param_file = input_file("Parameter filepath: ", param_file)
        stim_file = input_file("Stimulation filepath:  ", stim_file)
        model_file = input_file("Model filepath", model_file)
        time_file = input_file("Times filepath", time_file)

    print("making", os.path.join(working, 'params'))
    os.makedirs(os.path.join(working, 'params'), exist_ok=True)
    os.makedirs(os.path.join(working, 'Stims'), exist_ok=True)
    
    param_dest =  os.path.join(working, 'params', os.path.basename(param_file))
    stim_dest = os.path.join(working, 'Stims', os.path.basename(stim_file))
    time_dest = os.path.join(working, 'Stims', os.path.basename(time_file))
    model_dest = os.path.join(working, os.path.basename(model_file))
    
    shutil.copyfile(param_file, param_dest)
    shutil.copyfile(stim_file, stim_dest)
    shutil.copyfile(time_file, time_dest)
    shutil.copyfile(model_file, model_dest)

    file_values = [os.path.abspath(param_dest), os.path.abspath(stim_dest), \
                   os.path.abspath(model_dest), os.path.abspath(time_dest)]
    integrate1(file_values)



def integrate1(file_values):
    prev_dir = os.getcwd()
    os.chdir(working)
    global base
    print("base is : ",base)
    replace_line('runModel.hoc', 11, 'base = "%s" \n' % base.replace('\\','/'))
    replace_line('runModel.hoc', 12, 'paramsFile = "%s" \n' % (file_values[0]))
    replace_line('runModel.hoc', 13, 'stimFile = "%s" \n' % (file_values[1]))
    replace_line('runModel.hoc', 14, 'modelFile = "%s" \n' % (file_values[2]))
    replace_line('runModel.hoc', 15, 'timesFile = "%s" \n' % (file_values[3]))
    replace_line('runModel_topo.hoc', 11, 'base = "%s" \n' % base.replace('\\','/'))
    replace_line('runModel_topo.hoc', 12, 'paramsFile = "%s" \n' % (file_values[0]))
    replace_line('runModel_topo.hoc', 13, 'stimFile = "%s" \n' % (file_values[1]))
    replace_line('runModel_topo.hoc', 14, 'modelFile = "%s" \n' % (file_values[2]))
    replace_line('runModel_topo.hoc', 15, 'timesFile = "%s" \n' % (file_values[3]))
    global time_file
    global stim_file
    global param_file
    param_file = file_values[0]
    stim_file = file_values[1]
    time_file = file_values[3]
    print ("time file is " + time_file)
    print ("stim_file is " + stim_file)
    print ("param_file is " + param_file)

    print("Input files successfully integrated")
    # lets not stay in workdir, it's really confusing to change file paths like this
    os.chdir(prev_dir)





    

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
        
    run_var_values = ["", "", "", "", "", ""]

    run_var_values[0] = input_var("# Timestep ", str(timeSteps))
    run_var_values[1] = input_var("# Parameters", str(nparams))
    run_var_values[2] = input_var("# Models", str(nmodels))
    run_var_values[3] = input_var("# Traces ", str(nstims))
    run_var_values[4] = input_var("V_init ", str(-80))
    run_var_values[5] = input_var("Recalculate ECa? If not, press enter. If so type value here:", str(1))

    integrate2(run_var_values)



def integrate2(run_var_values):
    prev_dir = os.getcwd()
    # go into working dir
    os.chdir(working)
    replace_line('runModel.hoc', 2, 'ntimestep = %s \n' % run_var_values[0])
    replace_line('runModel.hoc', 3, 'nparams = %s \n' % run_var_values[1])
    replace_line('runModel.hoc', 4, 'psize = %s \n' % run_var_values[2])
    replace_line('runModel.hoc', 5, 'ntraces = %s \n' % run_var_values[3])
    replace_line('runModel.hoc', 6, 'v_init = %s \n' % run_var_values[4])
    replace_line('runModel.hoc', 7, 'calc_eca = %s \n' % run_var_values[5])
    replace_line('runModel_topo.hoc', 2, 'ntimestep = %s \n' % run_var_values[0])
    replace_line('runModel_topo.hoc', 3, 'nparams = %s \n' % run_var_values[1])
    replace_line('runModel_topo.hoc', 4, 'psize = %s \n' % run_var_values[2])
    replace_line('runModel_topo.hoc', 5, 'ntraces = %s \n' % run_var_values[3])
    replace_line('runModel_topo.hoc', 6, 'v_init = %s \n' % run_var_values[4])
    replace_line('runModel_topo.hoc', 7, 'calc_eca = %s \n' % run_var_values[5])
    print("Input files successfully integrated")
    # change back to previous dir
    os.chdir(prev_dir)


    
def select_inj_site():
    global working
    working.replace('/', '\\')
    prev_dir = os.getcwd()
    # check that we are in the right spot
    if not os.path.basename(os.getcwd()) ==  os.path.basename(os.path.abspath(working)):
        os.chdir(working)
    sys.path.insert(0,os.getcwd())
    
#     import test2
#     test2.main()
    p = subprocess.Popen("python test2.py", stdout=subprocess.PIPE, stderr=None, shell=True)
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

#     button = widgets.Button(description="Create Injection Site", width="100%")
    def on_button_clicked2_7(b):
        os.chdir(working)
        print("adding st loc at", os.getcwd())
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
    os.chdir(prev_dir)


def run_trans_script_gui():
    global working
    global base
    prev_dir = os.getcwd()
    
    
    def translate():
        global template
        template = base + "/scripts/pyscripts/"
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
        print(os.getcwd())
        print(os.listdir())
        print(os.path.isfile('extractModel.py'))
        # result = run(['python','extractModel.py'], stdout=PIPE)
        
        command = 'python extractModel.py'
        filename = 'test.log'
        with io.open(filename, 'wb') as writer, io.open(filename, 'rb', 1) as reader:
            process = subprocess.Popen(['python', 'extractModel.py'], stdout=writer, stderr=writer)
            while process.poll() is None:
                line = reader.read()
                sys.stdout.write(line)
                time.sleep(0.5)
    # Read the remaining
            line = reader.read()
            sys.stdout.write(line)
            process.wait()
            print("SUCESSFULLY CREATED MODEL")
        # line = result.stdout.readline()
        # while line:
        #     print(line)
        #     line = result.stdout.readline()
            
        # p = Popen("python extractModel.py", stdout=PIPE, stderr=STDOUT, shell=True)
        # for line in iter(p.stdout.readline, ""):
        #     print (line)
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
   
    os.chdir(prev_dir)
        
if __name__ == "__main__":
    init_working_dir()