from file_io import get_lines, put_lines
from cStringIO import StringIO
import os
import sys
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
def write_fn_topo(out_fn,hoc_base_fn):
    out = StringIO.StringIO()
    nrn.h.hoc_stdout()
    sys.stdout = out
    nrn.h.MyTopology()
    my_topology = out.getvalue().split()
    sys.stdout = sys.__stdout__
 


def proc_add_param_to_hoc_for_opt(all_parameters_non_global_c, hoc_base_fn, base_p, available_mechanisms, neuron_sc, reversals, comp_names, comp_mechanisms, g_globals, n_globals, neuron_types, ftypestr, p_size_set, param_set,data_dir,all_states = None,kin_mod_inds = None):
    nrn.h("access root.sec")
    print "in procadd"
    KINFLG = True
    if kin_mod_inds == None or len(kin_mod_inds)==0:
        KINFLG = False

    if KINFLG:
        kin_mod_inds = [x+1 for x in kin_mod_inds]
    available_mechanisms = sorted(available_mechanisms,  key=lambda s: s.lower())
    all_parameters_non_global_c_d = {}
    tmp = []
    for i in neuron_sc:
        #if len(i)>0:
        tmp.append(list(i))
    #neuron_sc = [list(i) for i in neuron_sc]
    neuron_sc = tmp
    reversals = []
    for i in neuron_sc:
        for j in i:
            if j not in reversals:
                reversals.append(j)
    comp_names = ['#' + i for i in comp_names]
    neuron_types = [i + '(0-1)' for i in neuron_types]
    comp_mechanisms = [list(i) for i in comp_mechanisms]
   

    param_start_i = [0]
    if len(all_parameters_non_global_c) == 1:
        param_start_i += [len(all_parameters_non_global_c[0])]
    else:
        param_start_i += list(np.cumsum(cell_numel(np.array(all_parameters_non_global_c))))
    if len(all_parameters_non_global_c) == 0:
        param_start_i = [0]
    param_start_i = np.array(param_start_i)

    state_start_i = [0]
    if KINFLG:
        if len(kin_mod_inds) == 1:
            state_start_i += [len(all_states[kin_mod_inds[0]-1])]
        else:
            all_kin_states = [all_states[x] for x in kin_mod_inds ]
            state_start_i += list(np.cumsum(cell_numel(np.array(all_kin_states))))
        if len(kin_mod_inds) == 0:
            state_start_i = [0]
        state_start_i = np.array(state_start_i)

    fn = hoc_base_fn
    fn_with_topo = fn[:-4] + '_topo.hoc'
    #write_fn_topo(fn_with_topo,hoc_base_fn)
    fn_with_param = fn[:-4] + '_param.hoc'
    file_sep = "/"
    fn_param_m ='ParamM.dat'
    fn_kinetic_states_init = 'KinStates.dat'
    fn_mat =   'Mat.dat'
    lines = get_lines(fn_with_topo)
    add_line_i = np.where(np.array(['End point processess mechanisms output' in i for i in lines]))[0]
    if add_line_i.size != 1:
        raise RuntimeError('Problem with finding place to add code: End point processes mechanisms output')
    p_size_line = np.where(np.array(['psize =' in i for i in lines]))
    if p_size_set:
        #p_size_line = np.where(np.array(['psize =' in i for i in lines]))
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
    if neuron_sc:
        for cur_mod_i in range(1, len(available_mechanisms) + 1):
            reversals_c[cur_mod_i - 1] = neuron_sc[cur_mod_i - 1]
        reversals_c = np.array(reversals_c)
    rep_comp = [None for i in range(len(reversals))]
    for i in range(0, len(reversals)):
        found_rep_comp = False
        while not found_rep_comp:
           
            for c in range(0, len(comp_names)):
               
                cur_mech_f = []
                for k in available_mechanisms:
                    cur_mech_f.append(k in comp_mechanisms[c])
                cur_mech_f = np.where(np.array(cur_mech_f))[0]
                tmp = reversals_c[cur_mech_f]
                cur_reversals = []
                for j in range(0, len(tmp)):
                    curr_temp = list(tmp[j])
                    for jj in range(0, len(curr_temp)):
                        cur_reversals.append(curr_temp[jj])
                cur_reversals = np.array(cur_reversals)
                if reversals[i] in cur_reversals:
                    rep_comp[i] = c
                    found_rep_comp = True
                    break
    added_lines = []
    added_lines.append('// Start params output')
    added_lines.append('objref fn2')
    added_lines.append('fn2 = new File()')
    added_lines.append('proc writeReversals(){')
    for i in range(1, len(reversals) + 1):
        added_lines.append('access ' + comp_names[rep_comp[i - 1] ][1:])
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
    added_lines.append('fn2.wopen("' + fn_kinetic_states_init + '")')
    added_lines.append('writeReversals()')
    added_lines.append('writeGGlobals()')
    added_lines.append('writeNGlobals()')
    added_lines.append('for (ii=0;ii<pmat.nrow();ii+=1){')
    added_lines.append('transvec = pmat.getrow(ii)')
    added_lines.append('tfunc()')
    added_lines.append('finitialize()')
    if (not all_states== None):
        added_lines.append('fadvance()')
        added_lines.append('fcurrent()')
	
	
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
            curr_mech_states = all_states[F[0][m-1]]
            for p in range(1, len(cur_mech_params) + 1):
                funcs.append('a=' + cur_mech_params[p - 1])
                funcs.append('fn.vwrite(&a)')
                counter += 2
            if KINFLG:
                if m in kin_mod_inds:
                    for p in range(1, len(curr_mech_states) + 1):
                        funcs.append('a=' + curr_mech_states[p - 1])
                        funcs.append('fn2.vwrite(&a)')
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
#     put_lines(fn_with_param, out_lines)
    runmodelparam_file = open('runModel_param.hoc', 'w')
    runmodelparam_file.write("%s\n" % '\n'.join(out_lines))
    runmodelparam_file.close()

    runModel_hoc_object = nrn.hoc.HocObject()
    subprocess.call(["nrniv", "runModel_param.hoc"])
    print "running runmodel_param"
    #runModel_hoc_object.execute('~' + '\n'.join(out_lines))
    #runModel_hoc_object.load_file(1, fn_with_param)
    
    # subprocess.call(["nrniv", "runModel_param.hoc"])
    f = open(fn_param_m, 'rb')
    f2 = open(fn_kinetic_states_init, 'rb')
    reversals_v, g_globals_v, n_globals_v = [0 for i in range(len(reversals))], [0 for i in range(len(g_globals))], [0 for i in range(len(n_globals))]
    for i in range(len(reversals)):
        reversals_v[i] = np.fromfile(f, dtype=np.float64, count=1)[0]
    for i in range(len(g_globals)):
        g_globals_v[i] = np.fromfile(f, dtype=np.float64, count=1)[0]
    for i in range(len(n_globals)):
        n_globals_v[i] = np.fromfile(f, dtype=np.float64, count=1)[0]
    comp_topology_map = [None for i in range(len(comp_names))]

    all_params = np.zeros((n_sets[0], len(comp_names) * int(param_start_i[-1])))
    all_states_vals = np.zeros((n_sets[0], len(comp_names) * int(state_start_i[-1])))
    first_param_m = None
    for kk in range(1, n_sets[0] + 1):
        param_m = np.zeros((len(comp_names), int(param_start_i[-1])))
        states_vals = np.zeros((len(comp_names), int(state_start_i[-1])))
        for c in range(1, len(comp_names) + 1):
            comp_name = comp_names[c - 1]
            comp_ind = get_comp_index(neuron_types, comp_name[1:])
            comp_topology_map[c - 1] = comp_ind
            kin_ind = -1
            F = []
            for i in available_mechanisms:
                F.append(i in comp_mechanisms[c - 1])
            F = np.where(np.array(F))
            for m in range(1, F[0].size + 1):
                cur_mech_params = all_parameters_non_global_c[F[0][m - 1]]
                curr_mech_states = all_states[F[0][m - 1]]
                for p in range(1, len(cur_mech_params) + 1):
                    Tmp = np.fromfile(f, dtype=np.float64, count=1)
                    param_m[[i - 1 for i in comp_ind], int(param_start_i[F[0][m - 1]] + p - 1)] = Tmp
                if KINFLG:
                    if m in kin_mod_inds:
                        kin_ind += 1
                        curr_mech_states = all_states[F[0][m - 1]]
                        for p in range(1, len(curr_mech_states) + 1):
                            Tmp = np.fromfile(f2, dtype=np.float64, count=1)
                            states_vals[[i - 1 for i in comp_ind],state_start_i[kin_ind] + p-1] = Tmp
        tmp = param_m.flatten(order='F')
        all_params[kk - 1, :] = tmp
        tmp2 = states_vals.flatten(order='F')
        all_states_vals[kk - 1, :] = tmp2
        if kk == 1:
            first_param_m = param_m  # Store only the first param_m for templating purposes
    param_m = None
    # print param_m

    # all_params = all_params.reshape((all_params.shape[0] * all_params.shape[1],))
    f.close()
    f2.close()
    f = open(data_dir + '/AllParams.csv', 'w')

    n_sets_s = StringIO()
    np.savetxt(n_sets_s, np.array(n_sets), fmt='%5.d', newline=',')
    n_sets_st = n_sets_s.getvalue()
    all_params_s = StringIO()
    np.savetxt(all_params_s, all_params, fmt='%.5e,', newline='\n')
    all_params_st = all_params_s.getvalue()
    f.write('%s\n%s\n' % (n_sets_st, all_params_st))
    f.close()
    f2 = open(data_dir + '/AllStates.csv', 'w')
    all_states_s = StringIO()
    np.savetxt(all_states_s, all_states_vals, fmt='%.5e,', newline='\n')
    all_states_st = all_states_s.getvalue()
    f2.write('%s\n%s\n' % (n_sets_st, all_states_st))
    f = open(data_dir + '/AllParams.dat', 'w')
    f.write(np.array(n_sets).astype(np.uint16))
    f.write(all_params.astype(np.float32))
    f.close()
    f = open(data_dir + '/ParamsM.csv', 'w')
    first_param_m_s = StringIO()
    np.savetxt(first_param_m_s, first_param_m.reshape((first_param_m.shape[0] * first_param_m.shape[1],)), fmt='%f',
               newline=',')
    first_param_m_st = first_param_m_s.getvalue()
    f.write('%s\n' % first_param_m_st)
    f.close()
    return first_param_m, runModel_hoc_object
