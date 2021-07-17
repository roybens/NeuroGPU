from json import load, dumps, dump
from csv import reader, writer
import numpy as np
from os.path import exists


# DEFINE
data_dir =          '../Data/'                                          # data directory (folder)
params_dir =        'params'                                        # params directory (folder)

params_file =       f'./{params_dir}/params2.csv'                    # 12 parameters
param_map =         f'./{data_dir}/ParamMappings.txt'               # mappings from new extractModel
# allparam_map =      f'{data_dir}/params_to_allparams.json'        # mapping from 12 params to allparams
allparam_map =      f'./{data_dir}/params_to_allparams_bbp.json'    # mapping from 12 params to allparams
template =          f'./{data_dir}/ParamTemplate.csv'               # template for allparams
model_data =        f'./{data_dir}/64MDL.csv'                       # the model data to be extracted and placed into allparams
corrections =       f'./{data_dir}/correction_mappings.json'        # corrections made after initial model runs

reference =         'reference/AllParams.csv'                       # reference .csv file to compare results with
run_model_file =    './runModel.hoc'                                # runModel.hoc

reversed_mappings = None
'''
categorize_key(key)
--------------------------------------------------
description:
    - determine which category each key belongs to
input[1]:
    - 'key' = key
output[1]:
    - category that 'key' belongs to
'''
def categorize_key(key):
    if 'apic' in key:
        return 'apical'
    elif 'axon' in key:
        return 'axonal'
    elif 'soma' in key:
        return 'somatic'

'''
flatten_dict(dct)
--------------------------------------------------
description:
    - flatten a dictionary of dictionaries for easier processing
input[1]:
    - 'dct' = dictionary to be flattened
output[1]:
    - 'dct' as a flattened dictionary i.e. a list
'''
def flatten_dict(dct):
    for k, v in list(dct.items()):
        if type(v) == dict:
            for key, val in list(v.items()):
                dct[f'{k}.{key}'] = val
            del dct[k]
    return dct

'''
format_value(num)
--------------------------------------------------
description:
    - converts 'num' to a floating point value
input[1]:
    - 'num' = value to be converted
output[1]:
    - 'num' formatted as a floating point value
'''
def format_value(num):
    if type(num) == str:
        return format_value(float(num))
    else:
        return '%.5E' % num

'''
check_allparams(allparams_file, reference_file)
--------------------------------------------------
description:
    - Test function to verify that 'allparams_file' created from our mapping/template is accurate to 'reference_file'
input[2]:
    - 'allparams_file' = allparams.csv created using our template mapping
    - 'reference_file' = original allparams.csv used as a reference
output:
    - terminal text listing mismatches between 'allparams_file' and 'reference_file'
'''
def check_allparams(allparams_file, reference_file):
    # open allparams_file as "allparams_matrix"
    with open(allparams_file, 'r') as af:
        allparams_matrix = list(reader(af))
    # open reference_file as "reference_matrix"
    with open(reference_file, 'r') as rf:
        reference_matrix = list(reader(rf))
    
    # initialize dictionary to collect errors in our mapping
    error_mapping = dict()

    # iterate over corresponding rows in allparams_file and reference_file
    for row_a, row_r in zip(allparams_matrix, reference_matrix):
        print('-----------------------------------------------')
        index = 0
        correct = 0
        wrong = 0
        # pairwise iteration over elements in the corresponding rows
        for elem_a, elem_r in zip(row_a, row_r):
            if float(elem_a) != float(elem_r):
                wrong += 1
                if index in reversed_mappings:
                    print(index, reversed_mappings[index], f'Got {elem_a}, but expected {elem_r}')
                    error_mapping[reversed_mappings[index]] = index
                else:
                    print(index, f'Got {elem_a}, but expected {elem_r}')
                # print(f'Got {elem_a}, but expected {elem_r}')       # Value mismatch found; diagnostic print statement
                if float(elem_a) == 8 * 10 ** (-5):
                    error_mapping[index] = float(elem_r)
            else:
                correct += 1
            index += 1
        print("correct: ", correct)
        print("wrong: ", wrong)
    return error_mapping

'''
parse_model(model_file)
--------------------------------------------------
description:
    - open 64MDL.csv and extract mappings
input[1]:
    - 'model_file' = '64MDL.csv'
output[1]:
    - model_mappings
'''
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

'''
assemble_allparams(allparams_template, params, param_to_allparam, param_mappings, model_mappings)
--------------------------------------------------
description:
    - uses templates, mappings, and values to generate new .csv file that *should* match with allparams.csv
input[5]:
    - 'allparams_template'  = ParamTemplate.csv
    - 'params'              = params.csv
    - 'param_to_allparam'   = params_to_allparams_bbp.json
    - 'param_mappings'      = paramMappings.txt
    - 'model_mappings'      = mappings from '64MDL.csv' from 'parse_model' output
output[1]:
    - 'template' file that used our mappings and template to generate new models (what we want)
'''
def assemble_allparams(allparams_template, params, param_to_allparam, param_mappings, model_mappings):
    # create a map of indices to values in the model
    global reversed_mappings
    model_mappings_flat = flatten_dict(model_mappings)
    param_mappings_flat = flatten_dict(param_mappings)
    reversed_mappings = {int(v): k for k, v in param_mappings_flat.items()}

    index_map = dict()

    unused_keys = list()

    #-----------------------------------------------------------------------------------------------------
    # experimental
    with open(f'{data_dir}/biophysics_mapping.json', 'r') as bph:
        bphm = load(bph)
    #-----------------------------------------------------------------------------------------------------

    # iterate over param mappings generated in 'proc_add_param_to_hoc_for_opt.py'
    for p in param_mappings_flat:
        # iterate over parameters in model (?)
        if p in model_mappings_flat:
            index_map[ param_mappings_flat[p] ] = model_mappings_flat[p]
        else:
            new_p = p.split('.')[-1]
            new_key = f'{categorize_key(p)}.{new_p}'
            if new_key in bphm:
                index_map[ param_mappings_flat[p] ] = bphm[new_key]

    # create the template to fill with values
    template = [allparams_template[:] for _ in range(len(params))]

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
    
    # correct incorrect values
    fl = f'{data_dir}/correction_mappings.json'
    if exists(fl):
        with open(fl) as jf:
            '''
            dct:
                index |-> value
            '''
            dct = load(jf)
            for i in range(len(params)):
                for k, v in dct.items():
                    template[i][int(k)] = v
    return template

'''
allparams_from_mapping()
--------------------------------------------------
description:
    - wrapper function for 'assemble_allparams'
input[0]:
    - n/a
output[1]:
    - 'allparams', the output from 'assemble_allparams'
'''

def allparams_from_mapping(params_input=None):
    global template, params_file, allparam_map, model_data, data_dir
    # get raw allparams template
    with open(template, 'r') as ap:
        allparams_template = list(map(lambda x: int(float(x)), list(reader(ap))[1][:-1]))
    # get parameters
    if params_input is None:
        with open(params_file, 'r') as p:
            params = [list(map(float, p[0].split(' '))) for p in list(reader(p))]
    else:
            params = params_input
    # get all param mappings from json
    with open(param_map, 'r') as pm:
        param_mappings = load(pm)
    # get the mappings from extraneous params to allparams
    with open(allparam_map, 'r') as tm:
        param_to_allparam = load(tm)

    model_mappings = parse_model(model_data)

    # collect allparams using function above
    allparams = assemble_allparams(
        allparams_template, 
        params, 
        param_to_allparam, 
        param_mappings, 
        model_mappings
    )

    # write allparams to .csv file
    with open(f'{data_dir}/AllParams.csv', 'w', newline='') as ap:
        wr = writer(ap)
        wr.writerow([str(len(params))])
        for row in allparams:
            wr.writerow(list(map(format_value, row)))
    return allparams



def query_neuron_3(lst, model_file):
    dct = {
        'cADpyr232_L5_TTPC1_0fb1ca4724[0].apic[71].gIhbar_Ih':              10**(-1),
        'cADpyr232_L5_TTPC1_0fb1ca4724[0].apic[72].gSKv3_1bar_SKv3_1':      10**(-1),
        'cADpyr232_L5_TTPC1_0fb1ca4724[0].apic[76].ehcn_Ih':                10**(-1),
        'cADpyr232_L5_TTPC1_0fb1ca4724[0].apic[105].gNaTs2_tbar_NaTs2_t':   10**(-4),
        'cADpyr232_L5_TTPC1_0fb1ca4724[0].apic[107].gImbar_Im':             10**(-4),
        'cADpyr232_L5_TTPC1_0fb1ca4724[0].apic[110].g_pas':                 10**(-4)
    }
    return [dct[l] for l in lst]


def create_params_and_validate(params_mat):
    params_mat = list(params_mat)
    print(params_mat)
    print("\n")
    print(list(params_mat[4]))
    allparams = allparams_from_mapping(params_input=params_mat)
    # check allparams 
    # get reference for correct output
    error_mapping = check_allparams(f'{data_dir}/AllParams.csv', f'{data_dir}/AllParams_reference.csv')
    # get real values from neuron
    if len(error_mapping) > 0:
        lst = list(error_mapping.keys())
        # ===============================================================================================
        # neuron query, change to query_neuron, query_neuron_2, or query_neuron_3
        #values = query_neuron_3(lst, run_model_file)
        # ===============================================================================================
        new_dct = dict()
        for name, value in zip(lst, values):
            key = error_mapping[name]
            new_dct[key] = value
        with open(f'{data_dir}/correction_mappings.json', 'w') as jf:
            dump(new_dct, jf)
        allparams = allparams_from_mapping()
        # NO NEED TO CHECK AFTER IN REAL ONE
        check_allparams(f'{data_dir}/AllParams.csv', f'{data_dir}/AllParams_reference.csv')
    # need to fill this in, need to go but will fill in later -Matthew

if __name__ == "__main__":
    allparams = allparams_from_mapping()
    # check allparams 
    # get reference for correct output
    error_mapping = check_allparams(f'{data_dir}/AllParams.csv', f'{data_dir}/AllParams_reference.csv')
    # get real values from neuron
    if len(error_mapping) > 0:
        lst = list(error_mapping.keys())
        # ===============================================================================================
        # neuron query, change to query_neuron, query_neuron_2, or query_neuron_3
        #values = query_neuron_3(lst, run_model_file)
        # ===============================================================================================
        new_dct = dict()
        for name, value in zip(lst, values):
            key = error_mapping[name]
            new_dct[key] = value
        with open(f'{data_dir}/correction_mappings.json', 'w') as jf:
            dump(new_dct, jf)
        allparams = allparams_from_mapping()
        # NO NEED TO CHECK AFTER IN REAL ONE
        check_allparams(f'{data_dir}/AllParams.csv', f'{data_dir}/AllParams_reference.csv')
    # need to fill this in, need to go but will fill in later -Matthew
