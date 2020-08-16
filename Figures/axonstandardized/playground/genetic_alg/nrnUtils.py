import struct
import numpy
import pandas as pd
nrnTypes = {
    2: numpy.short,
    3: numpy.float32,
    4: numpy.double,
    5: numpy.int,
}

def nrnMread(fileName):
    f = open(fileName, "rb") 
    nparam = struct.unpack('i', f.read(4))[0]
    typeFlg = struct.unpack('i', f.read(4))[0]
    return numpy.fromfile(f,nrnTypes[typeFlg])

def readParamsCSV(fileName):
    fields = ['Param name', 'Lower bound', 'Upper bound']
    df = pd.read_csv(fileName,skipinitialspace=True, usecols=fields)
    
    paramsList = [tuple(x) for x in df.values]
    return paramsList
    
def readCSV(fileName):
    df = pd.read_csv(fileName,header=None)
    paramsList = [tuple(x) for x in df.values]
    return paramsList
