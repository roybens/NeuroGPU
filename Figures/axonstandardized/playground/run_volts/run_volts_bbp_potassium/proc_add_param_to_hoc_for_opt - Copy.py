from file_io import get_lines, put_lines
import os
import neuron as nrn
import numpy as np
from cell import cell_numel
import subprocess

def get_comp_index(types, compt_name):
    ind = []
    for i in range(1, len(types) + 1):
        if(compt_name in types[i - 1] and types[i - 1][len(compt_name)] == '('):
            ind.append(i)
    return ind

def proc_add_param_to_hoc_for_opt(all_parameters_non_global_c, hoc_base_fn, base_p, available_mechanisms, neuron_sc, reversals, comp_names, comp_mechanisms, g_globals, n_globals, neuron_types, ftypestr, p_size_set, param_set):
    available_mechanisms = list(available_mechanisms)
    print available_mechanisms
    print all_parameters_non_global_c
    print neuron_types
  #  all_parameters_non_global_c_d = {}
  #  for m in available_mechanisms:
  #      all_parameters_non_global_c_d[m] = []
  #  for p in all_parameters_non_global_c:
  #      ind = p.find('_') + 1
  #      all_parameters_non_global_c_d[p[ind:]].append(p)
  #  all_parameters_non_global_c = []
  #  for k, v in all_parameters_non_global_c_d.iteritems():
  #      all_parameters_non_global_c.append(v)
    neuron_sc = [list(i) for i in neuron_sc]
    reversals = []
    for i in neuron_sc:
        for j in i:
            if j not in reversals:
                reversals.append(j)
    comp_names = ['#' + i for i in comp_names]
    neuron_types = [i + '(0-1)' for i in neuron_types]
    comp_mechanisms = [list(i) for i in comp_mechanisms]
    # all_parameters_non_global_c = [['gbar_ca', 'cao_ca'], [], ['gbar_kca', 'caix_kca', 'Ra_kca', 'Rb_kca'], ['gbar_km', 'tha_km', 'qa_km', 'Ra_km', 'Rb_km'], ['gbar_kv', 'tha_kv', 'qa_kv', 'Ra_kv', 'Rb_kv'], ['gbar_na', 'tha_na', 'qa_na', 'Ra_na', 'Rb_na', 'thi1_na', 'thi2_na', 'qi_na', 'thinf_na', 'qinf_na', 'Rg_na', 'Rd_na']]
    # available_mechanisms = ['ca', 'cad', 'kca', 'km', 'kv', 'na']
    # neuron_sc = [['eca'], ['eca'], ['ek', 'eca'], ['ek'], ['ek'], ['ena']]
    # reversals = ['eca', 'ek', 'ena']
    #neuron_types = ['soma(0-1)', 'Exts[0](0-1)', 'dend11[0](0-1)', 'dend10[0](0-1)', 'dend9[0](0-1)', 'dend8[0](0-1)', 'dend7[0](0-1)', 'dend6[0](0-1)', 'dend5[0](0-1)', 'dend4[0](0-1)', 'dend3[0](0-1)', 'dend2[0](0-1)', 'dend1[0](0-1)', 'hill(0-1)', 'dend11[4](0-1)', 'dend11[1](0-1)', 'dend10[2](0-1)', 'dend10[1](0-1)', 'dend9[2](0-1)', 'dend9[1](0-1)', 'dend8[2](0-1)', 'dend8[1](0-1)', 'dend7[6](0-1)', 'dend7[1](0-1)', 'dend6[2](0-1)', 'dend6[1](0-1)', 'dend4[4](0-1)', 'dend4[1](0-1)', 'dend3[2](0-1)', 'dend3[1](0-1)', 'dend2[4](0-1)', 'dend2[1](0-1)', 'dend1[6](0-1)', 'dend1[1](0-1)', 'iseg(0-1)', 'dend11[10](0-1)', 'dend11[5](0-1)', 'dend11[3](0-1)', 'dend11[2](0-1)', 'dend10[6](0-1)', 'dend10[3](0-1)', 'dend9[4](0-1)', 'dend9[3](0-1)', 'dend8[4](0-1)', 'dend8[3](0-1)', 'dend7[10](0-1)', 'dend7[7](0-1)', 'dend7[3](0-1)', 'dend7[2](0-1)', 'dend6[6](0-1)', 'dend6[3](0-1)', 'dend4[6](0-1)', 'dend4[5](0-1)', 'dend4[3](0-1)', 'dend4[2](0-1)', 'dend3[4](0-1)', 'dend3[3](0-1)', 'dend2[10](0-1)', 'dend2[5](0-1)', 'dend2[3](0-1)', 'dend2[2](0-1)', 'dend1[8](0-1)', 'dend1[7](0-1)', 'dend1[3](0-1)', 'dend1[2](0-1)', 'myelin[0](0-1)', 'dend11[16](0-1)', 'dend11[11](0-1)', 'dend11[9](0-1)', 'dend11[6](0-1)', 'dend10[8](0-1)', 'dend10[7](0-1)', 'dend10[5](0-1)', 'dend10[4](0-1)', 'dend7[12](0-1)', 'dend7[11](0-1)', 'dend7[9](0-1)', 'dend7[8](0-1)', 'dend7[5](0-1)', 'dend7[4](0-1)', 'dend6[8](0-1)', 'dend6[7](0-1)', 'dend6[5](0-1)', 'dend6[4](0-1)', 'dend2[12](0-1)', 'dend2[11](0-1)', 'dend2[7](0-1)', 'dend2[6](0-1)', 'dend1[5](0-1)', 'dend1[4](0-1)', 'node[0](0-1)', 'dend11[18](0-1)', 'dend11[17](0-1)', 'dend11[15](0-1)', 'dend11[12](0-1)', 'dend11[8](0-1)', 'dend11[7](0-1)', 'dend10[10](0-1)', 'dend10[9](0-1)', 'dend6[10](0-1)', 'dend6[9](0-1)', 'dend2[9](0-1)', 'dend2[8](0-1)', 'myelin[1](0-1)', 'dend11[20](0-1)', 'dend11[19](0-1)', 'dend11[14](0-1)', 'dend11[13](0-1)', 'node[1](0-1)', 'dend11[22](0-1)', 'dend11[21](0-1)', 'myelin[2](0-1)', 'dend11[58](0-1)', 'dend11[23](0-1)', 'node[2](0-1)', 'dend11[70](0-1)', 'dend11[59](0-1)', 'dend11[39](0-1)', 'dend11[24](0-1)', 'myelin[3](0-1)', 'dend11[78](0-1)', 'dend11[71](0-1)', 'dend11[61](0-1)', 'dend11[60](0-1)', 'dend11[51](0-1)', 'dend11[40](0-1)', 'dend11[32](0-1)', 'dend11[25](0-1)', 'node[3](0-1)', 'dend11[80](0-1)', 'dend11[79](0-1)', 'dend11[77](0-1)', 'dend11[72](0-1)', 'dend11[63](0-1)', 'dend11[62](0-1)', 'dend11[55](0-1)', 'dend11[52](0-1)', 'dend11[48](0-1)', 'dend11[41](0-1)', 'dend11[34](0-1)', 'dend11[33](0-1)', 'dend11[27](0-1)', 'dend11[26](0-1)', 'myelin[4](0-1)', 'dend11[82](0-1)', 'dend11[81](0-1)', 'dend11[74](0-1)', 'dend11[73](0-1)', 'dend11[65](0-1)', 'dend11[64](0-1)', 'dend11[57](0-1)', 'dend11[56](0-1)', 'dend11[54](0-1)', 'dend11[53](0-1)', 'dend11[50](0-1)', 'dend11[49](0-1)', 'dend11[43](0-1)', 'dend11[42](0-1)', 'dend11[36](0-1)', 'dend11[35](0-1)', 'dend11[29](0-1)', 'dend11[28](0-1)', 'node[4](0-1)', 'dend11[76](0-1)', 'dend11[75](0-1)', 'dend11[69](0-1)', 'dend11[66](0-1)', 'dend11[45](0-1)', 'dend11[44](0-1)', 'dend11[38](0-1)', 'dend11[37](0-1)', 'dend11[31](0-1)', 'dend11[30](0-1)', 'dend11[68](0-1)', 'dend11[67](0-1)', 'dend11[47](0-1)', 'dend11[46](0-1)'] 
    # n_globals = ['q10_ca', 'temp_ca', 'tadj_ca', 'vmin_ca', 'vmax_ca', 'vshift_ca', 'depth_cad', 'cainf_cad', 'taur_cad', 'q10_kca', 'temp_kca', 'tadj_kca', 'vmin_kca', 'vmax_kca', 'q10_km', 'temp_km', 'tadj_km', 'vmin_km', 'vmax_km', 'q10_kv', 'temp_kv', 'tadj_kv', 'vmin_kv', 'vmax_kv', 'q10_na', 'temp_na', 'tadj_na', 'vmin_na', 'vmax_na', 'vshift_na'] 
    # comp_names = ['#soma', '#dend1[0]', '#dend1[1]', '#dend1[2]', '#dend1[3]', '#dend1[4]', '#dend1[5]', '#dend1[6]', '#dend1[7]', '#dend1[8]', '#dend2[0]', '#dend2[1]', '#dend2[2]', '#dend2[3]', '#dend2[4]', '#dend2[5]', '#dend2[6]', '#dend2[7]', '#dend2[8]', '#dend2[9]', '#dend2[10]', '#dend2[11]', '#dend2[12]', '#dend3[0]', '#dend3[1]', '#dend3[2]', '#dend3[3]', '#dend3[4]', '#dend4[0]', '#dend4[1]', '#dend4[2]', '#dend4[3]', '#dend4[4]', '#dend4[5]', '#dend4[6]', '#dend5[0]', '#dend6[0]', '#dend6[1]', '#dend6[2]', '#dend6[3]', '#dend6[4]', '#dend6[5]', '#dend6[6]', '#dend6[7]', '#dend6[8]', '#dend6[9]', '#dend6[10]', '#dend7[0]', '#dend7[1]', '#dend7[2]', '#dend7[3]', '#dend7[4]', '#dend7[5]', '#dend7[6]', '#dend7[7]', '#dend7[8]', '#dend7[9]', '#dend7[10]', '#dend7[11]', '#dend7[12]', '#dend8[0]', '#dend8[1]', '#dend8[2]', '#dend8[3]', '#dend8[4]', '#dend9[0]', '#dend9[1]', '#dend9[2]', '#dend9[3]', '#dend9[4]', '#dend10[0]', '#dend10[1]', '#dend10[2]', '#dend10[3]', '#dend10[4]', '#dend10[5]', '#dend10[6]', '#dend10[7]', '#dend10[8]', '#dend10[9]', '#dend10[10]', '#dend11[0]', '#dend11[1]', '#dend11[2]', '#dend11[3]', '#dend11[4]', '#dend11[5]', '#dend11[6]', '#dend11[7]', '#dend11[8]', '#dend11[9]', '#dend11[10]', '#dend11[11]', '#dend11[12]', '#dend11[13]', '#dend11[14]', '#dend11[15]', '#dend11[16]', '#dend11[17]', '#dend11[18]', '#dend11[19]', '#dend11[20]', '#dend11[21]', '#dend11[22]', '#dend11[23]', '#dend11[24]', '#dend11[25]', '#dend11[26]', '#dend11[27]', '#dend11[28]', '#dend11[29]', '#dend11[30]', '#dend11[31]', '#dend11[32]', '#dend11[33]', '#dend11[34]', '#dend11[35]', '#dend11[36]', '#dend11[37]', '#dend11[38]', '#dend11[39]', '#dend11[40]', '#dend11[41]', '#dend11[42]', '#dend11[43]', '#dend11[44]', '#dend11[45]', '#dend11[46]', '#dend11[47]', '#dend11[48]', '#dend11[49]', '#dend11[50]', '#dend11[51]', '#dend11[52]', '#dend11[53]', '#dend11[54]', '#dend11[55]', '#dend11[56]', '#dend11[57]', '#dend11[58]', '#dend11[59]', '#dend11[60]', '#dend11[61]', '#dend11[62]', '#dend11[63]', '#dend11[64]', '#dend11[65]', '#dend11[66]', '#dend11[67]', '#dend11[68]', '#dend11[69]', '#dend11[70]', '#dend11[71]', '#dend11[72]', '#dend11[73]', '#dend11[74]', '#dend11[75]', '#dend11[76]', '#dend11[77]', '#dend11[78]', '#dend11[79]', '#dend11[80]', '#dend11[81]', '#dend11[82]', '#iseg', '#hill', '#myelin[0]', '#myelin[1]', '#myelin[2]', '#myelin[3]', '#myelin[4]', '#node[0]', '#node[1]', '#node[2]', '#node[3]', '#node[4]', '#Exts[0]'] 
    # comp_mechanisms = [['ca','cad','kca','km','kv','na'], ['ca','cad','kca','km','na'], ['ca','cad','kca','km','na'], ['ca','cad','kca','km','na'], ['ca','cad','kca','km','na'], ['ca','cad','kca','km','na'], ['ca','cad','kca','km','na'], ['ca','cad','kca','km','na'], ['ca','cad','kca','km','na'], ['ca','cad','kca','km','na'], ['ca','cad','kca','km','na'], ['ca','cad','kca','km','na'], ['ca','cad','kca','km','na'], ['ca','cad','kca','km','na'], ['ca','cad','kca','km','na'], ['ca','cad','kca','km','na'], ['ca','cad','kca','km','na'], ['ca','cad','kca','km','na'], ['ca','cad','kca','km','na'], ['ca','cad','kca','km','na'], ['ca','cad','kca','km','na'], ['ca','cad','kca','km','na'], ['ca','cad','kca','km','na'], ['ca','cad','kca','km','na'], ['ca','cad','kca','km','na'], ['ca','cad','kca','km','na'], ['ca','cad','kca','km','na'], ['ca','cad','kca','km','na'], ['ca','cad','kca','km','na'], ['ca','cad','kca','km','na'], ['ca','cad','kca','km','na'], ['ca','cad','kca','km','na'], ['ca','cad','kca','km','na'], ['ca','cad','kca','km','na'], ['ca','cad','kca','km','na'], ['ca','cad','kca','km','na'], ['ca','cad','kca','km','na'], ['ca','cad','kca','km','na'], ['ca','cad','kca','km','na'], ['ca','cad','kca','km','na'], ['ca','cad','kca','km','na'], ['ca','cad','kca','km','na'], ['ca','cad','kca','km','na'], ['ca','cad','kca','km','na'], ['ca','cad','kca','km','na'], ['ca','cad','kca','km','na'], ['ca','cad','kca','km','na'], ['ca','cad','kca','km','na'], ['ca','cad','kca','km','na'], ['ca','cad','kca','km','na'], ['ca','cad','kca','km','na'], ['ca','cad','kca','km','na'], ['ca','cad','kca','km','na'], ['ca','cad','kca','km','na'], ['ca','cad','kca','km','na'], ['ca','cad','kca','km','na'], ['ca','cad','kca','km','na'], ['ca','cad','kca','km','na'], ['ca','cad','kca','km','na'], ['ca','cad','kca','km','na'], ['ca','cad','kca','km','na'], ['ca','cad','kca','km','na'], ['ca','cad','kca','km','na'], ['ca','cad','kca','km','na'], ['ca','cad','kca','km','na'], ['ca','cad','kca','km','na'], ['ca','cad','kca','km','na'], ['ca','cad','kca','km','na'], ['ca','cad','kca','km','na'], ['ca','cad','kca','km','na'], ['ca','cad','kca','km','na'], ['ca','cad','kca','km','na'], ['ca','cad','kca','km','na'], ['ca','cad','kca','km','na'], ['ca','cad','kca','km','na'], ['ca','cad','kca','km','na'], ['ca','cad','kca','km','na'], ['ca','cad','kca','km','na'], ['ca','cad','kca','km','na'], ['ca','cad','kca','km','na'], ['ca','cad','kca','km','na'], ['ca','cad','kca','km','na'], ['ca','cad','kca','km','na'], ['ca','cad','kca','km','na'], ['ca','cad','kca','km','na'], ['ca','cad','kca','km','na'], ['ca','cad','kca','km','na'], ['ca','cad','kca','km','na'], ['ca','cad','kca','km','na'], ['ca','cad','kca','km','na'], ['ca','cad','kca','km','na'], ['ca','cad','kca','km','na'], ['ca','cad','kca','km','na'], ['ca','cad','kca','km','na'], ['ca','cad','kca','km','na'], ['ca','cad','kca','km','na'], ['ca','cad','kca','km','na'], ['ca','cad','kca','km','na'], ['ca','cad','kca','km','na'], ['ca','cad','kca','km','na'], ['ca','cad','kca','km','na'], ['ca','cad','kca','km','na'], ['ca','cad','kca','km','na'], ['ca','cad','kca','km','na'], ['ca','cad','kca','km','na'], ['ca','cad','kca','km','na'], ['ca','cad','kca','km','na'], ['ca','cad','kca','km','na'], ['ca','cad','kca','km','na'], ['ca','cad','kca','km','na'], ['ca','cad','kca','km','na'], ['ca','cad','kca','km','na'], ['ca','cad','kca','km','na'], ['ca','cad','kca','km','na'], ['ca','cad','kca','km','na'], ['ca','cad','kca','km','na'], ['ca','cad','kca','km','na'], ['ca','cad','kca','km','na'], ['ca','cad','kca','km','na'], ['ca','cad','kca','km','na'], ['ca','cad','kca','km','na'], ['ca','cad','kca','km','na'], ['ca','cad','kca','km','na'], ['ca','cad','kca','km','na'], ['ca','cad','kca','km','na'], ['ca','cad','kca','km','na'], ['ca','cad','kca','km','na'], ['ca','cad','kca','km','na'], ['ca','cad','kca','km','na'], ['ca','cad','kca','km','na'], ['ca','cad','kca','km','na'], ['ca','cad','kca','km','na'], ['ca','cad','kca','km','na'], ['ca','cad','kca','km','na'], ['ca','cad','kca','km','na'], ['ca','cad','kca','km','na'], ['ca','cad','kca','km','na'], ['ca','cad','kca','km','na'], ['ca','cad','kca','km','na'], ['ca','cad','kca','km','na'], ['ca','cad','kca','km','na'], ['ca','cad','kca','km','na'], ['ca','cad','kca','km','na'], ['ca','cad','kca','km','na'], ['ca','cad','kca','km','na'], ['ca','cad','kca','km','na'], ['ca','cad','kca','km','na'], ['ca','cad','kca','km','na'], ['ca','cad','kca','km','na'], ['ca','cad','kca','km','na'], ['ca','cad','kca','km','na'], ['ca','cad','kca','km','na'], ['ca','cad','kca','km','na'], ['ca','cad','kca','km','na'], ['ca','cad','kca','km','na'], ['ca','cad','kca','km','na'], ['ca','cad','kca','km','na'], ['ca','cad','kca','km','na'], ['ca','cad','kca','km','na'], ['ca','cad','kca','km','na'], ['ca','cad','kca','km','na'], ['ca','cad','kca','km','na'], ['ca','cad','kca','km','na'], ['ca','cad','kca','km','na'], ['kv','na'], ['kv','na'], ['na'], ['na'], ['na'], ['na'], ['na'], ['na'], ['na'], ['na'], ['na'], ['na'], ['na']] 
    # param_set = "opt_params.dat"

    param_start_i = [0]
    if len(all_parameters_non_global_c) == 1:
        param_start_i += [len(all_parameters_non_global_c[0])]
    else:
        param_start_i += list(np.cumsum(cell_numel(np.array(all_parameters_non_global_c))))
    param_start_i = np.array(param_start_i)
    fn = hoc_base_fn
    fn_with_topo = fn[:-4] + '_topo.hoc'
    fn_with_param = fn[:-4] + '_param.hoc'
    file_sep = '/'
    fn_param_m = base_p + file_sep + '..' + file_sep + '..' + file_sep + 'Neuron' + file_sep + 'printCell' + file_sep + 'Amit' + file_sep + 'output' + file_sep + 'ParamM.dat'
    fn_mat = base_p + file_sep + '..' + file_sep + '..' + file_sep + 'Neuron' + file_sep + 'printCell' + file_sep + 'Amit' + file_sep + 'output' + file_sep + 'Mat.dat'
    lines = get_lines(fn_with_topo)
    add_line_i = np.where(np.array(['End point processess mechanisms output' in i for i in lines]))[0]
    if add_line_i.size != 1:
        raise RuntimeError('Problem with finding place to add code: End point processes mechanisms output')
    if p_size_set:
        p_size_line = np.where(np.array(['psize =' in i for i in lines]))
        if p_size_line[0].size != 0:
            for i in p_size_line[0]:
                lines[i] = lines[i][0:7] + str(p_size_set)
    time_steps_line = np.where(np.array(['ntimestep =' in i for i in lines]))
    n_sets = []
    for i in p_size_line[0]:
        n_sets.append(int(lines[i][7:]))
    nt = []
    for i in time_steps_line[0]:
        nt.append(int(lines[i][11:]))
    params_set_line = np.where(np.array(['paramsFile =' in i for i in lines]))
    if param_set:
        if params_set_line[0].size != 0:
            for i in params_set_line[0]:
                lines[i] = lines[i][:16] + param_set + '"'
    param_name = lines[params_set_line[0][0]][16:-5]
    reversals_c = [None for i in range(len(available_mechanisms))]
    for cur_mod_i in range(1, len(available_mechanisms) + 1):
        reversals_c[cur_mod_i - 1] = neuron_sc[cur_mod_i - 1]
    reversals_c = np.array(reversals_c)
    rep_comp = [None for i in range(len(reversals))]
    for i in range(1, len(reversals) + 1):
        found_rep_comp = False
        while not found_rep_comp:
            for c in range(1, len(comp_names) + 1):
                cur_mech_f = []
                for k in available_mechanisms:
                    cur_mech_f.append(k in comp_mechanisms[c - 1])
                cur_mech_f = np.where(np.array(cur_mech_f))
                tmp = reversals_c[cur_mech_f[0]]
                cur_reversals = []
                for j in range(1, len(tmp) + 1):
                    curr_temp = list(tmp[j - 1])
                    for jj in range(1, len(curr_temp) + 1):
                        cur_reversals.append(curr_temp[jj - 1])
                cur_reversals = np.array(cur_reversals)
                if reversals[i - 1] in cur_reversals:
                    rep_comp[i - 1] = c
                    found_rep_comp = True
                    break
    added_lines = []
    added_lines.append('// Start params output')
    added_lines.append('proc writeReversals(){')
    for i in range(1, len(reversals) + 1):
        added_lines.append('access ' + comp_names[rep_comp[i - 1] - 1][1:])
        added_lines.append('a=' + str(reversals[i - 1]))
        added_lines.append('fn.vwrite(&a)')
    added_lines.append('}')
    added_lines.append('proc writeGGlobals(){')
    for i in range(1, len(g_globals) + 1):
        added_lines.append('a=' + str(g_globals[i - 1]))
        added_lines.append('fn.vwrite(&a)')
    added_lines.append('}')
    added_lines.append('proc writeNGlobals(){')
    for i in range(1, len(n_globals) + 1):
        added_lines.append('a=' + str(n_globals[i - 1]))
        added_lines.append('fn.vwrite(&a)')
    added_lines.append('}')
    funcs_index = len(added_lines)
    added_lines.append('proc printParams(){')
    added_lines.append('fn.wopen("' + fn_param_m + '")')
    added_lines.append('writeReversals()')
    added_lines.append('writeGGlobals()')
    added_lines.append('writeNGlobals()')
    added_lines.append('for (ii=0;ii<pmat.nrow();ii+=1){')
    added_lines.append('transvec = pmat.getrow(ii)')
    added_lines.append('tfunc()')
    added_lines.append('finitialize()')
    proc_counter, counter = 0, 0
    funcs = []
    func_name = 'proc' + str(proc_counter) + '()'
    added_lines.append(func_name)
    funcs.append('proc ' + func_name + '{')
    for c in range(1, len(comp_names) + 1):
        if counter > 50:
            funcs.append('}')
            proc_counter += 1
            counter = 0
            func_name = 'proc' + str(proc_counter) + '()'
            added_lines.append(func_name)
            funcs.append('proc ' + func_name + '{')
        F = []
        for i in available_mechanisms:
            F.append(i in comp_mechanisms[c - 1])
        F = np.where(np.array(F))
        funcs.append('access ' + comp_names[c - 1][1:])
        counter += 1
        for m in range(1, len(F[0]) + 1):
            cur_mech_params = all_parameters_non_global_c[F[0][m - 1]]
            for p in range(1, len(cur_mech_params) + 1):
                funcs.append('a=' + cur_mech_params[p - 1])
                funcs.append('fn.vwrite(&a)')
                counter += 2
    if counter > 0:
        funcs.append('}')
    added_lines_temp = []
    added_lines_temp.extend([added_lines[i] for i in range(funcs_index)])
    added_lines_temp.extend(funcs)
    added_lines_temp.extend([added_lines[i] for i in range(funcs_index, len(added_lines))])
    added_lines = added_lines_temp
    added_lines.append('}')
    added_lines.append('fn.close()')
    added_lines.append('}')
    added_lines.append('printParams()')
    added_lines.append('// End params output')
    added_lines.append('// Start Mat Output')
    added_lines.append('fcurrent()')
    #added_lines.append('hoc_stdout("' + fn_mat + '")')
    added_lines.append('MyPrintMatrix3()')
    #added_lines.append('hoc_stdout()')
    added_lines.append('// endMat Output')
    out_lines = []
    out_lines.extend([lines[i] for i in range(int(add_line_i[0]) + 1)])
    out_lines.extend(added_lines)
    out_lines.extend([lines[i] for i in range(int(add_line_i[0]) + 1, len(lines))])
    # put_lines(fn_with_param, out_lines)

    runModel_hoc_object = nrn.hoc.HocObject()
    runModel_hoc_object.execute('~' + '\n'.join(out_lines))
    # runModel_hoc_object.load_file(1, fn_with_param)
    # subprocess.call(["nrniv", "runModel_param.hoc"])
    f = open(fn_param_m, 'rb')
    reversals_v, g_globals_v, n_globals_v = [0 for i in range(len(reversals))], [0 for i in range(len(g_globals))], [0 for i in range(len(n_globals))]
    for i in range(len(reversals)):
        reversals_v[i] = np.fromfile(f, dtype=np.float64, count=1)[0]
    for i in range(len(g_globals)):
        g_globals_v[i] = np.fromfile(f, dtype=np.float64, count=1)[0]
    for i in range(len(n_globals)):
        n_globals_v[i] = np.fromfile(f, dtype=np.float64, count=1)[0]
    comp_topology_map = [None for i in range(len(comp_names))]
    all_params = np.zeros((n_sets[0], len(comp_names) * int(param_start_i[-1])))
    
    for kk in range(1, n_sets[0] + 1):
        param_m = np.zeros((len(comp_names), int(param_start_i[-1])))
        for c in range(1, len(comp_names) + 1):
            comp_name = comp_names[c - 1]
            comp_ind = get_comp_index(neuron_types, comp_name[1:])
            comp_topology_map[c - 1] = comp_ind
            F = []
            for i in available_mechanisms:
                F.append(i in comp_mechanisms[c - 1])
            F = np.where(np.array(F))
            for m in range(1, F[0].size + 1):
                cur_mech_params = all_parameters_non_global_c[F[0][m - 1]]
                for p in range(1, len(cur_mech_params) + 1):
                    Tmp = np.fromfile(f, dtype=np.float64, count=1)
                    param_m[[i - 1 for i in comp_ind], int(param_start_i[F[0][m - 1]] + p - 1)] = Tmp
        tmp = param_m.flatten(order='F')
        all_params[kk - 1,:] = tmp
    print param_m
    f.close()
    all_params = all_params.reshape((all_params.shape[0] * all_params.shape[1],))
    np.set_printoptions(threshold='nan')
    f = open('../../Data/AllParams.dat', 'wb')
    print np.array(n_sets).astype(np.uint16)
    f.write(np.array(n_sets).astype(np.uint16))
    f.write(all_params.astype(np.float32))
    print all_params.astype(np.float32)
    f.close()
    return param_m, runModel_hoc_object
