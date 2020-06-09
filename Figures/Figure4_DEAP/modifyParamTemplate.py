from file_io import get_lines, put_lines
from io import StringIO
import os
import sys
import neuron as nrn
import numpy as np
from cell import cell_numel
import subprocess

import csv
import json

data_dir = './Data/'
param_list = ['gna_dend', 'gna_node', 'gna_soma', 'gkv_axon',
                'gkv_soma', 'gca_dend', 'gkm_dend', 'gkca_dend',
                    'gca_soma', 'gkm_soma', 'gkca_soma', 'depth_cad']


def main():
    f = open(data_dir + '/ParamMappings.txt', 'r')
    param_mappings = json.load(f)
    f.close()

    param_name = "pas"
    indices = find_indices_in_template(data_dir, param_name, param_mappings)
    # print(indices)
    print("Num indices found for", param_name, ":", len(indices))
    new_value = 3
    insert_values(data_dir, indices, new_value, param_mappings)

def find_indices_in_template(data_dir, param, param_mappings):
    indices = []
    for i in param_mappings.keys():
        for j in param_mappings[i].keys():
            if j.find(param) != -1:
                indices.append(param_mappings[i][j])
    return indices

def insert_values(data_dir, indices, new_value, param_mappings):
        f = open(data_dir + 'ParamTemplate.csv', 'r')
        if f.mode != "r":
            print("Error: Could not read file.");
            return;
        template = list(csv.reader(f))[1];
        print(list(np.where(template == "2")))
        index = template.index("2031");
        for i in range(10):
            print("val", i,":\"", template[i], "\"");

        f.close()
        indices = []
        for i in range(len(template)):
            if template[i] == param:
                template[i] == "CHANGED"
                print("Changed val at ", i)
                indices.append(i)

        return indices

if __name__ == '__main__':
    main()
