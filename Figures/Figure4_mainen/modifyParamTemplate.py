from file_io import get_lines, put_lines
from io import StringIO
import os
import sys
import neuron as nrn
import numpy as np
from cell import cell_numel
import subprocess

data_dir = './Data/'

def main():
    print(find_indices_in_template(data_dir, 200))

def find_indices_in_template(data_dir,  param):
    f = open(data_dir + 'ParamTemplate.csv', 'r')
    if f.mode != "r":
        print("Error: Could not read file.");
        return;

    contents = f.readlines()
    # print("length:", len(contents))                                          # 1st line = # models
    # for i in contents:                                                       # 2nd line = symbols
    #     print("line:", i)                                                    # 3rd line = empty \n
    print(contents[1])

    print(contents[1].index("2031"))
    print(list(np.where(contents[1] == "2")))
    index = contents.index("2031");
    for i in range(10):
        print("val", i,":\"", contents[i], "\"");

    f.close()
    indices = []
    for i in range(len(contents)):
        if contents[i] == param:
            contents[i] == "CHANGED"
            print("Changed val at ", i)
            indices.append(i)

    # f2 = open(data_dir + 'ParamTemplate.csv', 'wb')
    # f2.write(contents)
    # f2.close()

    # f = open(data_dir + '/AllParams.dat', 'w')
    # symbol = param_mappings.get(section).get(param)
    return indices


def insert_values(data_dir, indices, param):
    f = open(data_dir + '/AllParams.dat', 'rb')
    contents = f.read()
    for i in indices:
        contents[i] = param
    f = open(data_dir + '/AllParams.dat', 'wb')
    f.write(contents)

    # need to access/loop through all sections and find indices that have parameter value; record index and return list


if __name__ == '__main__':
    main()
