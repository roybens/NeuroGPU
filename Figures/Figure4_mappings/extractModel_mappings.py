from json import load
from csv import reader, writer
import numpy as np


# DEFINE
data_dir =          'data'                                      # data directory

params_file =       f'{data_dir}/params.csv'                    # 12 parameters
param_map =         f'{data_dir}/ParamMappings.json'            # mappings from new extractModel
allparam_map =      f'{data_dir}/params_to_allparams.json'      # mapping from 12 params to allparams
template =          f'{data_dir}/AllParams.csv'                 # template for allparams
model_data =        f'{data_dir}/64MDL.csv'                     # the model data to be extracted and placed into allparams

reference =         'reference/AllParams.csv'                   # check the results against reference result


def flatten_dict(dct):
    for k, v in list(dct.items()):
        if type(v) == dict:
            for key, val in list(v.items()):
                dct[f'{k}.{key}'] = val
            del dct[k]
    return dct


def format_value(num):
    if type(num) == str:
        return format_value(float(num))
    else:
        return '%.5E' % num


def parse_model(model_file):
    with open(model_file, 'r') as mdl:
        model_raw = [m[0] for m in list(reader(mdl))]
        # initialize dictionary
        model_mappings = dict()
        current_key = None
        for s in model_raw:
            if '#' in s:
                current_key = s.replace('#', '')
            else:
                kv_pair = [c.replace(' ', '') for c in s.split(' = ')]
                key, value = kv_pair[0], float(kv_pair[1])
                if current_key not in model_mappings:
                    model_mappings[current_key] = {
                        key: value
                    }
                else:
                    model_mappings[current_key][key] = value
    return model_mappings


def assemble_allparams(allparams_template, params, param_to_allparam, param_mappings, model_mappings):
    # create a map of indices to values in the model
    model_mappings_flat = flatten_dict(model_mappings)
    param_mappings_flat = flatten_dict(param_mappings)

    index_map = dict()

    for p in model_mappings_flat:
        if p in param_mappings_flat:
            index_map[ param_mappings_flat[p] ] = model_mappings_flat[p]

    # create the template to fill with values
    template = [allparams_template[:] for _ in range(1023)]

    # use index map to fill template initially
    for row in template:
        for i in range(len(row)):
            if row[i] in index_map:
                row[i] = index_map[row[i]]
    
    # apply params
    for i in range(len(params)):
        for k, v in list(param_to_allparam.items()):
            for j in v:
                template[i][j] = params[i][int(k)]
    
    # replace specific value
    for i in range(len(params)):
        template[i][2833] = 1000
    
    return template


def main():
    global template, params_file, allparam_map, model_data
    # get raw allparams template
    with open(template, 'r') as ap:
        allparams_template = list(map(lambda x: int(float(x)), list(reader(ap))[1][:-1]))
    # get parameters
    with open(params_file, 'r') as p:
        params = [list(map(float, p[0].split(' '))) for p in list(reader(p))]
    # get all param mappings from json
    with open(param_map, 'r') as pm:
        param_mappings = load(pm)
    # get the mappings from extraneous params to allparams
    with open(allparam_map, 'r') as tm:
        param_to_allparam = load(tm)
    
    model_mappings = parse_model(model_data)

    # get allparams
    allparams = assemble_allparams(
        allparams_template, 
        params, 
        param_to_allparam, 
        param_mappings, 
        model_mappings
    )

    # write allparams to csv
    with open('AllParams.csv', 'w', newline='') as ap:
        wr = writer(ap)
        wr.writerow(['1023'])
        for row in allparams:
            wr.writerow(list(map(format_value, row)))
    
    return allparams


if __name__ == "__main__":
    allparams = main()
    # check allparams 
    # get reference for correct output
    with open(reference, 'r') as ap:
        allparams_ref = [list(map(float, p[:-1])) for p in list(reader(ap))][1:-1]
    # need to fill this in, need to go but will fill in later
