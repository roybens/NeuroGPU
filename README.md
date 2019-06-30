# NeuroGPU - software for NEURON modeling in GPU-based hardware


Goals
=====

Give a broad overview of the NeuroGPU code and what it does.
Show how one would be able run NeuroGPU with their own parameters.
Provide some example of the code and data files for reference.

Support
=======
We are providing support using a chat channel on [Gitter](https://gitter.im/BlueBrain/BluePyOpt).
# Introduction

## Goals 
* Give a broad overview of the NeuroGPU code and what it does.
* Show how one would be able run NeuroGPU with their own parameters.
* Provide some example of the code and data files for reference.

##Installation

## Overview


## Structure
Here are the pertinent files that need to be modified in order to run your own simulations.
1. **runModel.hoc** - This runs the simulation of your model neuron with your experimental stimulations in the Hoc interpreter.
2. **Model File** - This is your main hoc file that represents your neuron and its different parameters/characteristics.
3. **Stimulation Files** - These are the stimulation files (.DAT) that are going to be used to inject current into the neuron.

# Walkthrough
## 1. Stimulation Files
This will be your files that contain your point processes that will simulate an injection of current into your model neuron. They should be in the format of a data frame contained in a data file (.DAT). The file will be used later in the runModel.py script.

## 2. Hoc Model
This is the file that contains your neuron compartmental model, where each parameter and variable of the neuron is programmed in HOC. The scripts are designed around the [Mainen Pyramidal Neuron (1996)](https://senselab.med.yale.edu/modeldb/showModel.cshtml?model=2488). However, the scripts should be able to work with any hoc model that runs correctly using the Neuron API. 

