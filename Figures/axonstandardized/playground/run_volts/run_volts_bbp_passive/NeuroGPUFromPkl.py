from proc_add_param_to_hoc_for_opt import proc_add_param_to_hoc_for_opt
import cPickle as pkl


def replace_line(file_name, line_num, text):
    lines = open(file_name, 'r').readlines()
    lines[line_num + 1] = text
    out = open(file_name, 'w')
    out.writelines(lines)
    out.close()


def run_params_with_pkl(hocmodel_name,new_params_fn,psize):
    with open(hocmodel_name) as f:
        all_params_non_global_list_non_flat, modelFile, base_p, available_mechs, reversals, reversals, cs_names,comp_mechs, g_globals, nglobals_flat, sec_list, ftypestr, p_size_set, param_set, data_dir ,all_states_names_list,kin_model_inds= pkl.load(f)
    param_set = new_params_fn
    #replace_line('runModel_topo.hoc', 2, 'psize = ' +str(psize) + '\n')
    p_size_set = psize
    params_m, runModel_hoc_object = proc_add_param_to_hoc_for_opt(all_params_non_global_list_non_flat, modelFile, base_p,available_mechs, reversals, reversals, cs_names, comp_mechs, g_globals, nglobals_flat, sec_list, ftypestr,p_size_set, param_set, data_dir,all_states_names_list)
