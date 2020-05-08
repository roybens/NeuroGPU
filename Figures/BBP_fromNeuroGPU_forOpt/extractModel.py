import neuron as nrn
import ctypes
import sys
import collections
import glob
import re
import os
import copy
import numpy as np
import re
import subprocess
import csv
import shutil
import glob
import math
import numpy.matlib
from file_io import get_lines, put_lines
from proc_add_param_to_hoc_for_opt import proc_add_param_to_hoc_for_opt
import scipy.io as sio
from collections import OrderedDict
from io import StringIO
from nrn_structs import *
from create_auxilliary_data_3 import create_auxilliary_data_3
import pickle as pkl

# Definitions
ModData = collections.namedtuple('ModData', 'mod_per_seg,available_mechs')
ParsedModel = collections.namedtuple('ParsedModel', 'Writes,Reads')
ModNeuron = collections.namedtuple('ModNeuron', 'Suffix,UseIon,NonspecificCurrent,Reads,Writes,Range,Global')
FTYPESTR = 'MYFTYPE'
WARPSIZE = 32
end_str = '|X|X|'
not_states = ['ica','cai']
global vs_dir
#vs_dir = '../../VS/pyNeuroGPU_win2/NeuroGPU6'
#vs_root = '../../VS/pyNeuroGPU_win2/'
run_dir = 'C:/pyNeuroGPU_win61'
unix_dir = 'C:/pyNeuroGPU_unix'
data_dir = './Data/'
split_flg = 0
baseDir = ''
has_f = 0
ND, NRHS = None, None
global sec_list
# Globals
global ParamStartVal
ParamStartVal = 0
global StateStartVal
StateStartVal = 0
C_SUFFIX = '.c'
modelFile = "./runModel.hoc"
base_p = "./"
ftypestr = 'MYFTYPE'
p_size_set = False
param_set = False
has_kinetics = 0
global kin_helper
kin_helper = []

### Helper functions for loading NEURON C library ###

def nrn_dll(printpath=False):
    """Return a ctypes object corresponding to the NEURON library.
    """
    import ctypes
    import os
    import platform

    # neuron_home = os.path.split(os.path.split(nrn.h.neuronhome())[0])[0]

    success = False
    # base_path = os.path.join(neuron_home, 'lib' , 'python2.7', 'site-packages', 'neuron', 'hoc')
    # base_path = '/home/devloop0/neuron/nrn/lib/python/neuron/hoc'
    base_path = os.path.join(os.path.expanduser('~'), 'neuron', 'nrn', 'lib', 'python', 'neuron', 'hoc')
    for extension in ['', '.dll', '.so', '.dylib']:
        try:
            the_dll = ctypes.cdll[base_path + extension]
            if printpath: print (base_path + extension)
            success = True
        except:
            pass
        if success: break
    else:
        raise Exception('unable to connect to the NEURON library')
    return the_dll


def nrn_dll_sym(name, type=None):
    """return the specified object from the NEURON dlls.

    Parameters
    ----------
    name : string
        the name of the object (function, integer, etc...)
    type : None or ctypes type (e.g. ctypes.c_int)
        the type of the object (if None, assumes function pointer)
    """
    import os
    dll = nrn_dll()
    if type is None:
        return dll.__getattr__(name)
    else:
        return type.in_dll(dll, name)


### Model extraction functions ###

def get_parent_seg(thread):
    parent = []
    for i in range(thread.contents.end):
        x = thread.contents._v_parent_index[i]
        # print i, x
        parent.append(x)
    return parent


def get_parent_seg1():
    #nrn.h.load_file(modelFile)
    nrn.h("MyTopology2()")
    
    parent = []
    ax = './parent.txt'
    with open(ax, 'r') as bx:
        cx = bx.read().replace('\n', '')
    parent = cx.split()
    # parent.insert(0,"0")
    # parent = parent[0:-1]
    parent = [int(i) for i in parent]
    # print parent
    return parent


def get_topo_f_matrix(thread):
    lst = []
    for i in range(thread.contents.end):
        node = thread.contents._v_node[i]
        _a = thread.contents._actual_a[node.contents.v_node_index]
        _b = thread.contents._actual_b[node.contents.v_node_index]

        try:
            _rhs = node.contents._rhs[0]
            lst.append([i, _b, _a, node.contents._d[0], _rhs])
        except ValueError:
            _rhs = 0.0
            lst.append([i, _b, _a, node.contents._d[0], _rhs])
    return lst


def get_topo():
    # print "in topp"
    sections = {}
    nsegs = []
    cms = []
    nrn.h('objref sec_list')
    nrn.h('sec_list = new SectionList()')
    nrn.h('access root.sec')
    nrn.h('sec_list.wholetree()')
    for s in nrn.h.sec_list:
        name = nrn.h.secname()
        #print name
        #topology = [s.nseg, s.L, s.diam, s.Ra, s.cm, nrn.h.dt, nrn.h.st.del,
         #           nrn.h.st.dur, nrn.h.st.amp, s.v, nrn.h.area(.5), nrn.h.parent_connection(), nrn.h.n3d()]
        nsegs.append(int(s.nseg))
        cms.append(float(s.cm))

        #sections[name] = topology
    return [nsegs, cms]


def create_sec_list():
    sec_list = []
    nrn.h('objref sec_list')
    nrn.h('sec_list = new SectionList()')
    nrn.h('access root.sec')
    nrn.h('sec_list.wholetree()')
    parent_comp = []
    for curr_sec in nrn.h.sec_list:
        curr_name = nrn.h.secname(sec=curr_sec)
        sec_list.append(curr_name)
    return sec_list


def create_parent_comp():
    parent_comp = []
    nrn.h('objref sect')
    nrn.h('strdef str1')
    nrn.h('sect = new SectionRef()')
    for sect_name in sec_list[1:]:
        nrn.h('access ' + sect_name)
        nrn.h('sect = new SectionRef()')
        nrn.h('sect.parent {str1 = secname()}')
        p_name = nrn.h.str1
        parent_comp.append(index_containing_substring(sec_list, p_name))
    return [-1] + parent_comp


def get_topo_mdl():
    # TODO: Currently prints out DEFAULT values. Check if this is expected behavior.
    available_mechs = set([])
    sections = {}
    all_params = set([])
    comp_mechs = []
    comp_map = []
    exclude_str = ["_ion","capacitance","morphology"]
    mech_names = get_mech_list()
    for s in nrn.h.allsec():
        mech_params = {}
        name = nrn.h.secname()

        comp_map.append(index_containing_substring(sec_list, name))
        if nrn.h.ismembrane("pas"):
            mech_params['g_pas'] = s.g_pas
            mech_params['e_pas'] = s.e_pas

        curr_comp_mechs = []
        for mech_name in mech_names:
            if not nrn.h.ismembrane(mech_name):
                continue
            ms = nrn.h.MechanismStandard(mech_name, 1)  # contains mechanism parameter names
            notexc = index_containing_string_from_list(exclude_str,mech_name)==-1
            if ms.count() > 0 and notexc:
                available_mechs.add(mech_name)
                curr_comp_mechs.append(mech_name)
                for j in range(int(ms.count())):
                    param = nrn.h.ref('')  # string reference to store parameter name
                    ms.name(param, j)
                    if ( notexc ):
                        all_params.add(param[0])
                        nrn.h('x = {0}'.format(param[0]))
                        mech_params[param[0]] = nrn.h.x

            ms = nrn.h.MechanismStandard(mech_name, -1)  # contains mechanism parameter names
            notexc = index_containing_string_from_list(exclude_str, mech_name) == -1
            if ms.count() > 0 and notexc:
                available_mechs.add(mech_name)
                curr_comp_mechs.append(mech_name)

            for j in range(int(ms.count())):
                param = nrn.h.ref('')  # string reference to store parameter name
                ms.name(param, j)
                if ( notexc ):
                    all_params.add(param[0])
                nrn.h('x = {0}'.format(param[0]))
                mech_params[param[0]] = nrn.h.x
            ms = nrn.h.MechanismStandard(mech_name, 3)  # contains mechanism parameter names
            notexc = index_containing_string_from_list(exclude_str, mech_name) == -1
            if ms.count() > 0 and notexc:
                available_mechs.add(mech_name)
                curr_comp_mechs.append(mech_name)
            for j in range(int(ms.count())):
                param = nrn.h.ref('')  # string reference to store parameter name
                ms.name(param, j)
                if ( notexc ):
                    all_params.add(param[0])
                nrn.h('x = {0}'.format(param[0]))
                mech_params[param[0]] = nrn.h.x
        sections[name] = mech_params
        comp_mechs.append(sorted(set(curr_comp_mechs), key=lambda s: s.lower()))
        output = ModData(mod_per_seg=sections, available_mechs=available_mechs)
    # TODO: fix this hack, 'CO' isn't detected by get_topo_mdl()
    # available_mechs.add('CO')
    return [output, all_params, comp_mechs, available_mechs, comp_map]


def get_topo_mdl2():
    # TODO: Currently prints out DEFAULT values. Check if this is expected behavior.
    available_mechs = set([])
    comp_mechs = []
    mech_params_list = []
    sections = []
    exclude_str = "_ion"
    for s in nrn.h.allsec():
        mech_params = {}
        sections.append(nrn.h.secname())
        if nrn.h.ismembrane("pas"):
            mech_params['g_pas'] = s.g_pas
            mech_params['e_pas'] = s.e_pas
        mech_names = get_mech_list()
        curr_comp_mechs = []
        for mech_name in mech_names:
            if not nrn.h.ismembrane(mech_name):
                continue
            ms = nrn.h.MechanismStandard(mech_name, -1)  # contains mechanism parameter names
            tmpind = mech_name.find(exclude_str)
            if ms.count() > 0 and tmpind == -1:
                available_mechs.add(mech_name)
                curr_comp_mechs.append(mech_name)

        comp_mechs.append(curr_comp_mechs)
        curr_params = []
        for j in range(int(ms.count())):
            param = nrn.h.ref('')  # string reference to store parameter name
            ms.name(param, j)
            nrn.h('x = {0}'.format(param[0]))
            mech_params[param[0]] = nrn.h.x
            curr_params.append(nrn.h.x)
        mech_params_list.append(curr_params)
        # sections[name] = mech_params
    return [sections, comp_mechs, mech_params_list]


def get_fmatrix():
    for s in nrn.h.allsec():
        print (s.fmatrix(0, 1))


def get_recsites():
    sites = []
    for s in nrn.h.recSites:
        sites.append(s.name())
    return sites


def get_bool_model(available_mechs, NX, comp_mechs, comp_map, seg_start, seg_end):#TODO this shoud be reduced to ncomp instead of nx and use the map comp_map in CUDA
    bool_model = []
    for mech_name in available_mechs:
        curr_bool_list = [0] * NX
        for ind in range(len(seg_start)):
            comp = comp_map[ind]
            curr_bool = 1 * (index_containing_substring(comp_mechs[ind], mech_name) > -1)

            for i in range(seg_start[comp], seg_end[comp]):
                curr_bool_list[i] = curr_bool
        curr_bool_list[0] = 0
        bool_model.append(curr_bool_list)
    return bool_model


### Functions for Parsing Mod/C files ###

def parse_models():
    global StateStartVal
    c_parsed_folder = './CParsed/'
    model_name = []
    reads = []
    writes = []
    only_reads = []
    all_states = []
    lines_list = []
    globals = []
    nglobals_c = []
    ions_c = []
    all_state_line = []
    reads_no_reversals = []
    only_reads_no_reversals = []
    write_no_currents = []
    all_state_line_seg = []
    all_assigned = []
    nglobal_list = []
    gs = []
    ranges = []
    non_spec_curr = []
    reversals = []
    all_locals = []
    all_states_names_list = []
    mod_files = list(glob.glob('*.mod')) + list(glob.glob('*.mod2'))
    if 'branching.mod' in mod_files:
        mod_files.remove('branching.mod')
    #if 'passive.mod' in mod_files:
    #    mod_files.remove('passive.mod')
    # if 'pasx.mod' in mod_files:
    #   mod_files.remove('pasx.mod')
    mod_files = sorted(mod_files,key=str.lower)
    for i in range(len(mod_files)):
        mod_f = mod_files[i]
        print ('parsing ' + mod_f)
        lines_list.append(file_to_list_no_comments(mod_f))
        # print 'parsing ' + mod_f + 'i is ' + repr(i)
        output = parse_model(lines_list[i])
        # return [model_name,globals,ions,reads,writes,only_reads,nglobal_c,curr_all_state,all_state_line]
        model_name.append(output[0])
        ions_c.append(output[2])
        currents = ['i' + s for s in ions_c[i] ]+['i']
        reads.append(output[3])
        writes.append(output[4])
        curr_gs = ['g' + s for s in ions_c[i]]
        gs.append(curr_gs)

        only_reads_tmp = output[5]
        only_reads.append(only_reads_tmp)
        curr_all_states = output[7]
        curr_all_states_name = [s + '_' + model_name[i] for s in curr_all_states]
        all_states.append(curr_all_states)
        all_states_names_list.append(curr_all_states_name)
        curr_writes_no_currents = set(writes[i]) - set(currents) - set(curr_all_states)

        write_no_currents.append(curr_writes_no_currents)
        globals.append(output[1])
        nglobals_c.append(output[6])
        all_state_line.append(output[8])
        all_state_line_seg.append(output[9])
        all_assigned.append(output[10])
        ranges.append(output[11])
        non_spec_curr.append(output[12])
        currreversals = set(['e' + v for v in ions_c[i]])
        reversals.append(currreversals)
        tmp = only_reads_tmp - currreversals
        only_reads_no_reversals.append(tmp)
        StateStartVal = StateStartVal + len(curr_all_states)

    ions = set([item for sublist in ions_c for item in sublist])
    all_currents = ['i' + s for s in ions]
    all_reversals = ['e' + s for s in ions]
    all_reads = set([item for sublist in reads for item in sublist])
    all_reads_no_reversals = set(all_reads - set(all_reversals))
    all_writes = set([item for sublist in writes for item in sublist])
    nstates = sum([len(l) for l in all_states])
    nextra_states = len(all_reads_no_reversals)
    nextra_states_trg = []
    extra_states_trg = []
    cntr = 0
    if nextra_states > 0:
        for stt in all_reads_no_reversals:
            if not stt in not_states:
                extra_states_trg.append('StatesM[' + str(cntr + nstates) + ']')
                cntr+=1
    n_total_states = nstates + cntr
    proc_declare_list = []
    proc_declare_cu_list = []
    c_func_lines_list = []
    c_func_lines_cu_list = []
    c_init_lines_list = []
    c_init_lines_cu_list = []
    c_proc_lines_list = []
    c_proc_lines_cu_list = []
    c_deriv_lines_list = []
    c_deriv_lines_cu_list = []
    c_break_lines_list = []
    c_break_lines_cu_list = []
    all_params_line_list = []
    all_params_model_name_list = []
    all_params_non_global_list = []
    all_params_non_global_list_non_flat = []
    all_params_global_list = []
    all_params_list = []
    break_point_declare_list = []
    deriv_declare_list = []
    init_declare_list = []
    c_param_lines_list = []
    call_to_init_list = []
    call_to_deriv_list = []
    call_to_break_list = []
    call_to_break_dv_list = []
    all_kin_states = []
    kin_models_inds = []
    model_name_sorted = sorted(model_name, key=lambda s: s.lower())
    for j in range(len(model_name_sorted)):
        i = model_name.index(model_name_sorted[j])
        print ('parsing ' + model_name[i])
        output = parse_model2(mod_files[i], lines_list[i], globals[i], all_state_line[i], all_state_line_seg[i],
                              model_name[i], only_reads_no_reversals[i], write_no_currents[i], all_reads_no_reversals,
                              writes[i], all_assigned[i], all_states[i], reads[i], gs[i], ranges[i], non_spec_curr[i],
                              ions_c[i], reversals[i], write_no_currents[i], all_writes, extra_states_trg)
        # return [proc_names,func_names,all_params,global_inds,not_global_inds,all_params_line,proc_declare,proc_declare_cu,c_func_lines,c_func_lines_cu,c_init_lines,c_init_lines_cu,c_proc_lines,c_proc_lines_cu,c_deriv_lines,c_deriv_lines_cu,c_break_lines,c_break_lines_cu,break_point_declare,deriv_declare,init_declare]
        # [proc_names, func_names, all_params, global_inds, not_global_inds, all_params_line, proc_declare,proc_declare_cu, c_func_lines, c_func_lines_cu, c_init_lines, c_init_lines_cu, c_proc_lines,c_proc_lines_cu, c_deriv_lines, c_deriv_lines_cu, c_break_lines, c_break_lines_cu, break_point_declare,deriv_declare, init_declare, before_first_line_all, c_param_lines, call_to_init, call_to_deriv,call_to_break, call_to_break_dv, locals, kin_states]
        proc_names = output[0]
        func_names = output[1]
        all_params = output[2]
        global_inds = output[3]
        not_global_inds = output[4]
        all_params_line = output[5]
        proc_declare = output[6]
        proc_declare_cu = output[7]
        c_func_lines = output[8]
        c_func_lines_cu = output[9]
        c_init_lines = output[10]
        c_init_lines_cu = output[11]
        c_proc_lines = output[12]
        c_proc_lines_cu = output[13]
        c_deriv_lines = output[14]
        c_deriv_lines_cu = output[15]
        c_break_lines = output[16]
        c_break_lines_cu = output[17]
        break_point_declare = output[18]
        deriv_declare = output[19]
        init_declare = output[20]
        before_first_line_c = output[21]
        c_param_lines = output[22]
        call_to_init_list.append(output[23])
        call_to_deriv = output[24]
        #if call_to_deriv!='':
        call_to_deriv_list.append(call_to_deriv)
        call_to_break_list.append(output[25])
        call_to_break_dv_list.append(output[26])
        all_locals.append(output[27])
        kin_states = output[28]
        all_kin_states.append(kin_states)
        if kin_states:
            call_to_kinetic_deriv = output[29]
            call_to_deriv_list.append(call_to_kinetic_deriv)
            c_kinetic_deriv_lines = output[30]
            c_kinetic_deriv_lines_cu = output[31]
            kinetic_deriv_declare = output[32]
            kin_models_inds.append(j)
        all_params_model_name_c = []
        src = proc_names + func_names
        src_cu = src + [s + 'Cu' for s in src]
        trg = [s + '_' + model_name[i] for s in src]
        trg_cu = ['Cu' + s for s in trg] + ['Cu' + s for s in trg]
        before_first_line_c = add_model_name_to_function(before_first_line_c, src, trg)

        proc_declare_list.append(
            meta_add_model_name_to_function(proc_declare, proc_names, func_names, model_name[i], all_params, 0))
        proc_declare_cu_list.append(
            meta_add_model_name_to_function(proc_declare_cu, proc_names, func_names, model_name[i], all_params, 1))
        c_func_lines_list.append(
            [meta_add_model_name_to_function(curr_func, proc_names, func_names, model_name[i], all_params, 0) for
             curr_func in c_func_lines])
        c_func_lines_cu_list.append(
            [meta_add_model_name_to_function(curr_func, proc_names, func_names, model_name[i], all_params, 1) for
             curr_func in c_func_lines_cu])
        c_init_lines_list.append(
            meta_add_model_name_to_function(c_init_lines, proc_names, func_names, model_name[i], all_params, 0))
        c_init_lines_cu_list.append(
            meta_add_model_name_to_function(c_init_lines_cu, proc_names, func_names, model_name[i], all_params, 1))

        c_proc_lines_list.append(
            [meta_add_model_name_to_function(curr, proc_names, func_names, model_name[i], all_params, 0) for curr in
             c_proc_lines])
        c_proc_lines_cu_list.append(
            [meta_add_model_name_to_function(curr, proc_names, func_names, model_name[i], all_params, 1) for curr in
             c_proc_lines_cu])
        c_deriv_lines_list.append(meta_add_model_name_to_function(c_deriv_lines, proc_names, func_names, model_name[i], all_params, 0))
        c_deriv_lines_cu_list.append(meta_add_model_name_to_function(c_deriv_lines_cu, proc_names, func_names, model_name[i], all_params, 1))
        if kin_states:
            c_deriv_lines_list.append(meta_add_model_name_to_function(c_kinetic_deriv_lines, proc_names, func_names, model_name[i], all_params, 0))
            c_deriv_lines_cu_list.append(meta_add_model_name_to_function(c_kinetic_deriv_lines_cu, proc_names, func_names, model_name[i], all_params, 1))
        # c_kinetic_lines_list.append(meta_add_model_name_to_function(c_kinetic_lines,proc_names,func_names,model_name[i],all_params))
        # c_kinetic_lines_cu_list.append(meta_add_model_name_to_function(c_kinetic_lines_cu,proc_names,func_names,model_name[i],all_params))
        c_break_lines_list.append(
            meta_add_model_name_to_function(c_break_lines, proc_names, func_names, model_name[i], all_params, 0))
        c_break_lines_cu_list.append(
            meta_add_model_name_to_function(c_break_lines_cu, proc_names, func_names, model_name[i], all_params, 1))
        src = all_params
        trg = [s.strip('\t') + '_' + model_name[i] for s in all_params]
        all_params_model_name_list.append(trg)
        tmp_list = []
        for j in not_global_inds:
            tmp_list.append(trg[j])
            all_params_non_global_list.append(trg[j])
        all_params_non_global_list_non_flat.append(tmp_list)
        for j in global_inds:
            all_params_global_list.append(trg[j])
        c_param_lines_list.append(add_model_name_to_function(c_param_lines, src, trg))

        all_params_list.append(all_params)
        ##declares
        break_point_declare_list.append(add_model_name_to_function(break_point_declare, src, trg))
        if deriv_declare !='':
            deriv_declare_list.append(add_model_name_to_function(deriv_declare, src, trg))
        if has_kinetics:
            deriv_declare_list.append(add_model_name_to_function(kinetic_deriv_declare, src, trg))
        # kinetic_declare_list.append(add_model_name_to_function(kinetic_declare,src,trg))
        init_declare_list.append(add_model_name_to_function(init_declare, src, trg))

        ##starting to write:
        # cpp_file = c_parsed_folder + model_name[i] + '.cpp'
        # write_cpp_file(cpp_file,model_name[i],c_param_lines_list[i],before_first_line_c,proc_declare_list[i],c_func_lines_list[i],c_init_lines_list[i],c_proc_lines_list[i],c_deriv_lines_list[i],c_break_lines_list[i])
        # h_file = c_parsed_folder + model_name[i] + '.h'
        # write_h_file(h_file, model_name[i],all_params_list[i],all_states[i],break_point_declare_list[i],deriv_declare_list[i],init_declare_list[i],call_to_init,call_to_deriv,call_to_break,call_to_break_dv)
        # (fn,model_name,all_params,all_states,break_point_declare,deriv_declare,init_declare,call_to_init,call_to_deriv,call_to_break,call_to_break_dv,):
        # output = get_comp_mechs()
    kin_indices = []
    states_flat = [item for sublist in all_states for item in sublist]
    for curr_kins in all_kin_states:
        for kstate in curr_kins:
            curr_ind = index_containing_substring(states_flat, kstate)
            kin_indices.append(curr_ind)
    output = get_topo_mdl()
    model_name = model_name_sorted
    params_from_neuron = output[1]
    comp_mechs = output[2]
    available_mechs = output[3]
    comp_map = output[4]  # maps from forall call at neuron to sec_list(topology ordered)
    # comp_names = output[5]
    params_from_mods = set()
    all_params_non_global_flat = []
    all_params_global_flat = []
    for ii in range(len(all_params_model_name_list)):
        for s in all_params_model_name_list[ii]:
            params_from_mods.add(s)
    for s in all_params_non_global_list:
        all_params_non_global_flat.append(s)
    for s in all_params_global_list:
        all_params_global_flat.append(s)
    # for mech in available_mechs:
    # vals =
    n_params = len(all_params_non_global_flat)
    diff_alert = set(set(params_from_mods) - set(params_from_neuron))
    all_reversals = []
    for s in reversals:
        all_reversals = all_reversals + list(s)
    all_reversals = set(all_reversals)
    nglobals_flat = []
    for s in nglobals_c:
        nglobals_flat = nglobals_flat + list(s)

    g_globals = ['celsius', 'stoprun', 'clamp_resist', 'secondorder'];
    output = get_actual_params(all_reversals, g_globals, nglobals_flat, comp_mechs, all_params_non_global_flat)

    # [actual_gglobals, actual_reversals, actual_globals, actual_non_globals_names, actual_non_globals_vals]
    actual_gglobals = output[0]
    actual_reversals = output[1]
    neuron_globals_vals = output[2]
    cs_names = []
    for s in nrn.h.allsec():
        cs_names.append(nrn.h.secname())

    # print cs_names
    # print available_mechs
    hocmodel_name = data_dir + os.path.basename(nrn.h.modelFile)[:-3] + 'pkl'
    print (hocmodel_name)
    with open(hocmodel_name, 'wb') as f:  # Python 3: open(..., 'wb')
        pkl.dump([all_params_non_global_list_non_flat, modelFile, base_p, available_mechs, reversals, reversals, cs_names,comp_mechs, g_globals, nglobals_flat, sec_list, ftypestr, p_size_set, param_set, data_dir,all_states_names_list,kin_models_inds], f)


    params_m, runModel_hoc_object = proc_add_param_to_hoc_for_opt(all_params_non_global_list_non_flat, modelFile,base_p, available_mechs, reversals, reversals,cs_names, comp_mechs, g_globals, nglobals_flat,sec_list, ftypestr, p_size_set, param_set, data_dir,all_states_names_list,kin_models_inds)

    # subprocess.call("matlab -nosplash -nodisplay -nodesktop -r \"ProcAddParamToHocForOpt()\"",shell=True);
    # subprocess.call('matlab -nosplash -nodisplay -nodesktop -r \"ProcAddParamToHocForOpt(%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)\"' % (all_params_non_global_flat, modelFile, base_p, available_mechs, reversals,reversals, cs_names, comp_mechs, g_globals, nglobals_flat, sec_list, ftypestr,p_size_set, param_set),shell=True);
    output = write_all_models_cpp(c_parsed_folder, list(all_reversals), actual_reversals, all_writes, all_locals,
                                  all_currents, nglobals_flat, neuron_globals_vals, c_init_lines_list,
                                  c_proc_lines_list, c_deriv_lines_list, c_break_lines_list, proc_declare_list,
                                  c_func_lines_list)
    output = write_all_models_cu(c_parsed_folder, list(all_reversals), actual_reversals, g_globals, actual_gglobals,
                                 nglobals_flat, neuron_globals_vals, c_param_lines_list, c_init_lines_cu_list,
                                 c_proc_lines_cu_list, c_deriv_lines_cu_list, c_break_lines_cu_list,
                                 proc_declare_cu_list, c_func_lines_cu_list)
    output = write_all_models_h(c_parsed_folder, n_total_states, n_params, g_globals, actual_gglobals,
                                break_point_declare_list, deriv_declare_list, init_declare_list, call_to_init_list,
                                call_to_deriv_list, call_to_break_list, call_to_break_dv_list)
    # return [call_to_init_str,call_to_deriv_str,call_to_break_str,call_to_break_dv_str]
    call_to_init_str = output[0]
    call_to_deriv_str = output[1]
    call_to_break_str = output[2]
    call_to_break_dv_str = output[3]
    output = replace_for_cuh(call_to_init_str, call_to_deriv_str, call_to_break_str, call_to_break_dv_str)
    call_to_init_str_cu = output[0]
    call_to_deriv_str_cu = output[1]
    call_to_break_str_cu = output[2]
    call_to_break_dv_str_cu = output[3]
    
    output = get_topo()
    n_segs = output[0]
    n_segs_mat = [x + 1 for x in n_segs]
    n_segs_mat[0] = n_segs_mat[0] + 1
    cm_tmp = output[1]
    cm = []

    for i in range(len(n_segs)):
        cm = cm + [0] + [cm_tmp[i]] * n_segs[i]
    cm.append(0)
    cn = list(np.cumsum(n_segs_mat))
    seg_start = [0] + cn[:-1]
    seg_end = cn
    seg_end = [x - 1 for x in cn]
    nx = np.cumsum(n_segs_mat)
    fmatrix_fn = c_parsed_folder + 'fmatrix.txt'
    parent = create_parent_comp()
    mat = get_matrix(fmatrix_fn, parent, seg_start, seg_end)
    NX = len(mat)
    seg_to_comp = [0] * NX
    for i in range(len(seg_start)):
        seg_to_comp[seg_start[i]:seg_end[i] + 1] = [i] * (1 + seg_end[i] - seg_start[i])

    mat = np.matrix(mat)

    rev_parent = [len(n_segs) - p for p in np.flipud(np.array(parent))]

    available_mechs = list(available_mechs)
    available_mechs = sorted(available_mechs, key=lambda s: s.lower())
    bool_model = get_bool_model(available_mechs, NX, comp_mechs, comp_map, seg_start, seg_end)
    rot_mat = np.rot90(mat, 2)
    n_segs_mat_flipped = np.flipud(np.array(n_segs_mat))
    parent_seg = get_parent_seg1()
    parent_seg = [x + 1 for x in parent_seg]
    parent_seg[0] = 0
    output = create_auxilliary_data_3(rot_mat, NX, n_segs_mat_flipped, rev_parent, cm, parent_seg, bool_model,
                                      seg_start, n_segs, seg_to_comp, data_dir)
    aux = output[3]
    tmp_file_name = output[0]
    # cm_vec = output[4]
    cm_vec = aux.Cms
    # create_auxilliary_data_3(A, N, NSeg, Parent, cmVec,parent_seg,bool_model,seg_start,n_segs,seg_to_comp):
    # NIKHIL add createaux here

    output = write_all_models_cuh(c_parsed_folder, n_total_states, NX, aux, bool_model, n_params, c_init_lines_cu_list,
                                  c_proc_lines_cu_list, c_deriv_lines_cu_list, c_break_lines_cu_list,
                                  ''.join(call_to_init_list), ''.join(call_to_deriv_list), ''.join(call_to_break_list),
                                  ''.join(call_to_break_dv_list),kin_indices,len(comp_mechs))

    # (c_parsed_folder,NX,aux,bool_model,n_params,c_init_lines_cu,c_proc_lines_cu,c_deriv_lines_cu,c_break_lines_cu):

    with open('CParsed/AllModels.cuh', 'a') as fcuh:
        tail_end(fcuh, n_params, call_to_init_str_cu, call_to_deriv_str_cu, call_to_break_str_cu,
                 call_to_break_dv_str_cu, params_m, n_segs_mat, cm_vec, vs_dir, has_f, ND, NRHS, tmp_file_name, nstates,
                 nextra_states,kin_states,kin_indices)


    return [n_params, call_to_init_str_cu, call_to_deriv_str_cu, call_to_break_str_cu, call_to_break_dv_str_cu,
            params_m, n_segs_mat, cm_vec, vs_dir, has_f, ND, NRHS,seg_start,seg_end]


def write_sim():
    sim_csv = data_dir + '/Sim.csv'
    sim_dict = OrderedDict()
    sim_dict['v_init'] = np.double(nrn.h.v_init)
    sim_dict['dt'] = np.double(nrn.h.dt)
    #sim_dict['tfinal'] = np.double(nrn.h.tfinal)
    rec_sites = get_recsites()
    rec_sites_inds = [index_containing_substring(sec_list, name) for name in rec_sites]
    sim_dict['nrecsite'] = np.uint16(len(rec_sites))
    sim_dict['recsite'] = np.array(rec_sites_inds)
    FN_data = ''
    for k in sim_dict:
        s = StringIO()
        #print sim_dict[k]
        np.savetxt(s, sim_dict[k].flatten(), fmt='%.5f', newline=',')
        st = s.getvalue()
        FN_data += st + '\n'
    with open(sim_csv, 'w') as fn_f:
        fn_f.write(FN_data)
    return rec_sites
def write_stim(rec_sites,seg_start,seg_end):
    stim_fn_nrn = nrn.h.stimFile
    ext = stim_fn_nrn[-3:]
    if ext == 'csv':
        stims = np.genfromtxt(stim_fn_nrn,delimiter=' ')
        stims = stims.transpose()
    else:
        tmp = nrn.h.stims
        stims = numpy.zeros(shape=(int(nrn.h.ntraces),int(nrn.h.ntimestep)))
        for i in range(int(nrn.h.ntraces)):
            stims[i] = tmp.getrow(i)
    stim_outfn = data_dir + 'Stim_raw.csv'
    if nrn.h.ntraces ==1 and stims.ndim>1:

        np.savetxt(stim_outfn, stims[0], fmt="%f",delimiter=',',newline=',')
    else:
        np.savetxt(stim_outfn, stims, fmt="%f",delimiter=',',newline=',')
    times_fn_nrn = nrn.h.timesFile
    ext = times_fn_nrn[-3:]
    if ext == 'csv':
        times = np.genfromtxt(times_fn_nrn, delimiter=',')
    else:
        times = np.array(nrn.h.stimtime.getrow(0))

    time_outfn = data_dir + 'times.csv'
    time_str = ','.join(['%.5f' % num for num in times])
    with open(time_outfn, 'w') as fn_f:
        fn_f.write(time_str)
    #writing stim_meta  1 - &stim.NStimuli 2 stim.Nt 3 &stim.comp  4 stim.loc  5 stim.area,
    stim_meta_outfn =  data_dir + 'Stim_meta.csv'
    stim_meta_dict = OrderedDict()
    stim_meta_dict['NStimuli'] = int(nrn.h.ntraces)
    stim_meta_dict['Nt'] = len(times)
    comp_ind = index_containing_substring(sec_list,rec_sites[0])
    stim_meta_dict['comp'] = comp_ind
    st_start = seg_start[comp_ind]
    st_end = seg_end[comp_ind]
    stim_ind =int(math.ceil((st_end - st_start)*nrn.h.stLoc))+1
    stim_meta_dict['loc'] = stim_ind
    nrn.h("access " + rec_sites[0])
    st_area = nrn.h.area(nrn.h.stLoc)
    nrn.h("access root.sec")
    stim_meta_dict['area'] = np.double(st_area)
    FN_data = ''
    for k in stim_meta_dict:
       FN_data += str(stim_meta_dict[k]) + '\n'
    with open(stim_meta_outfn, 'w') as fn_f:
        fn_f.write(FN_data)









def get_matrix(FN, parent, seg_start, last_seg):
    # FN = '../../Neuron/printCell/Amit/output/Mat.dat'
    FN = 'Fmatrix.csv'
    data = open(FN).read()
    lines = data.split('\n')
    # print lines
    # ATTENTION I REMOVED THE NEXT LINE SINCE I AM NOT SURE WHERE IT COMES FROM FOR SOME REASON MAINENPY2 DID WORKED
    # lines = lines[1:-1]
    NX = len(lines)
    table = []
    for line in lines:
        tmp = line.strip().split(' ')
        table.append([x.replace('1.#INF00000000000', str(1e23)) for x in tmp[1:]])
    # table = table[1:]
    mat = [[0 for x in range(NX - 1)] for y in range(NX - 1)]
    tmp = lines[0].split(' ')
    mat[0][0] = float(table[0][2])
    for i in range(1, len(table) - 1):
        # tmp = lines[i].split(' ')
        # mat[i][i] = float(tmp[3])
        # mat[i-1][i] = float(tmp[2])
        # mat[i][i-1] = float(tmp[1])
        mat[i][i] = float(table[i][2])
        mat[i][i - 1] = float(table[i][0])
        mat[i - 1][i] = float(table[i][1])
    # print 'get_matrix'
    # print seg_start
    # print len(seg_start)
    # print last_seg
    # print len(last_seg)
    # print parent
    # print len(parent)
    for i in range(len(parent)):
        # print 'i is' +str(i) + ','+str(parent[i])
        if parent[i] != i - 1:
            mat_ind = seg_start[i]
            parent_ind = last_seg[parent[i]]
            # print str(mat_ind)+','+str(parent_ind)+','+str(i)
            mat[mat_ind][mat_ind - 1] = float(0)
            mat[mat_ind - 1][mat_ind] = float(0)
            mat[mat_ind][parent_ind] = float(table[mat_ind][0])
            mat[parent_ind][mat_ind] = float(table[mat_ind][1])
    # with open("output.csv", "wb") as f:
    # writer = csv.writer(f)
    # writer.writerows(mat)
    return mat


def write_all_models_cuh(c_parsed_folder, n_total_states, NX, aux, bool_model, n_params, c_init_lines_cu,
                         c_proc_lines_cu, c_deriv_lines_cu, c_break_lines_cu, call_to_init, call_to_deriv,
                         call_to_break, call_to_break_dv,kin_indices,ncomps):
    FN = c_parsed_folder + 'AllModels.cuh'
    if (not os.path.exists(c_parsed_folder)):
        os.makedirs(c_parsed_folder)
    f = open(FN, 'w')
    f.write('// Automatically generated CUH for ' + os.getcwd() + modelFile + '\n')
    f.write('\n#ifndef __' 'ALLMODELSCU' '__\n#define __' 'ALLMODELSCU' '__\n#include "Util.h"\n\n')
    f.write('#include "cuda_runtime.h"\n#include "device_launch_parameters.h"\n\n')
    f.write('#define NSEG ' + str(NX) + '\n')
    f.write('#define NCOMPS ' + str(ncomps) + '\n')
    f.write('#define LOG_N_DEPTH ' + str(aux.LognDepth) + '\n')
    if (len(bool_model) > 0):
        f.write('#define N_MODELS ' + str(len(bool_model)) + '\n')
    else:
        f.write('#define N_MODELS ' + str(1) + '//actually zero\n')
    f.write('#define N_FATHERS ' + str(len(aux.Fathers)) + '\n')
    f.write('#define N_CALL_FOR_FATHER ' + str(aux.nCallForFather) + '\n')
    f.write('#define COMP_DEPTH ' + str(aux.CompDepth32) + '\n')
    f.write('#define N_L_REL ' + str(len(aux.LRelStarts)) + '\n')
    f.write('#define N_F_L_REL ' + str(len(aux.FLRelStarts)) + '\n')
    nilp_str = str(int(math.ceil(NX/WARPSIZE)))
    f.write('#define NILP ' + nilp_str + '\n')
    if (n_total_states > 0):
        f.write('#define NSTATES ' + str(n_total_states) + '\n')
    else:
        f.write('#define NSTATES ' + str(1) + '//actually zero\n')

    if (n_params > 0):
        f.write('#define NPARAMS ' + str(n_params) + '\n\n')
    else:
        f.write('#define NPARAMS ' + str(0) + '//actually zero\n\n')
    f.write('#define NTRACES ' + str(int(nrn.h.ntraces)) + '\n')
    # kinetics
    if has_kinetics:
        f.write('#define NKIN_STATES ' + str(len(kin_indices)) + '\n')
        #f.write('#define mat_1d(i,j,mat,dim) mat[i+dim*j]\n')
        f.write('__device__ MYFTYPE rhs(MYFTYPE* y, MYFTYPE* dydx, MYFTYPE* q);\n')
        f.write('__device__ void Cubackwards_euler(MYFTYPE dt, MYDTYPE N, MYDTYPE nkinStates, MYFTYPE *y, MYFTYPE* matq, MYFTYPE *yout);\n')
        #f.write('MYFTYPE kin_indices[] = {' + ','.join([str(x) for x in kin_indices]) + '};\n')
    f.write('\n')

    c_init_lines_cu = [x for x in c_init_lines_cu if x != []]
    for cur_mod_i in range(len(c_init_lines_cu)):
        if c_init_lines_cu[cur_mod_i] != '':
            f.write(c_init_lines_cu[cur_mod_i][0][:-1] + ';\n')
    c_deriv_lines_cu = [x for x in c_deriv_lines_cu if x !=[]]
    for cur_mod_i in range(len(c_deriv_lines_cu)):
        if len(c_deriv_lines_cu[cur_mod_i]) > 0:
            f.write(c_deriv_lines_cu[cur_mod_i].splitlines()[0][:-1] + ';\n')
    for cur_mod_i in range(len(c_break_lines_cu)):
        if c_break_lines_cu[cur_mod_i] != '':
            f.write(c_break_lines_cu[cur_mod_i][0].splitlines()[0][:-1] + ';\n')
        f.write('\n')


def write_all_models_h(c_parsed_folder, n_total_states, n_params, gglobals_flat, gglobals_vals, break_point_declare,
                       deriv_declare, init_declare, call_to_init, call_to_deriv, call_to_break, call_to_break_dv):
    FN = c_parsed_folder + 'AllModels.cuh'
    f = open(FN, 'w')
    f.write('// Automatically generated H for ' + os.getcwd() + modelFile + '\n')
    f.write('\n#ifndef __' 'ALLMODELS' '__\n#define __' 'ALLMODELS' '__\n#include "Util.h"\n\n')
    f.write('#define NSTATES ' + str(n_total_states) + '\n')
    f.write('#define NPARAMS ' + str(n_params) + '\n')
    f.write('// GGlobals\n')
    for n, v in zip(gglobals_flat, gglobals_vals):
        f.write('#define ' + n + ' (' + str(v) + ')\n')
    f.write('\n')
    f.write('// Kinetic Helper code\n')
    for i in range(len(kin_helper)):
        f.write(kin_helper[i])
    for i in range(len(break_point_declare)):
        f.write(break_point_declare[i] + '\n')
    for i in range(len(deriv_declare)):
        f.write(deriv_declare[i] + '\n')
    for i in range(len(init_declare)):
        f.write(init_declare[i] + '\n\n')
        # KINETIC
    call_to_init_str = ''
    call_to_deriv_str = ''
    
    call_to_break_str = ''
    call_to_break_dv_str = ''
    for i in range(len(call_to_init)):
        call_to_init_str = call_to_init_str + 'if(TheMMat.boolModel[seg+' + str(i) + '*NSEG]){' + call_to_init[
            i] + '}'
    for i in range(len(call_to_deriv)):
        call_to_deriv_str = call_to_deriv_str + 'if(TheMMat.boolModel[seg+' + str(i) + '*NSEG]){' + call_to_deriv[
            i] + '}'

    for i in range(len(call_to_break)):
        call_to_break_str = call_to_break_str + 'if(TheMMat.boolModel[seg+' + str(i) + '*NSEG]){' + call_to_break[
            i] + '}'
        call_to_break_dv_str = call_to_break_dv_str + 'if(TheMMat.boolModel[seg+' + str(i) + '*NSEG]){' + \
                               call_to_break_dv[i] + '}'
        # KINETIC
    f.write('#define CALL_TO_INIT_STATES  ' + call_to_init_str.replace('ParamsM[', 'ParamsMSerial[') + '\n\n')
    f.write('#define CALL_TO_DERIV  ' + call_to_deriv_str.replace('ParamsM[', 'ParamsMSerial[') + '\n\n')
    f.write('#define CALL_TO_BREAK  ' + call_to_break_str.replace('ParamsM[', 'ParamsMSerial[') + '\n\n')
    f.write('#define CALL_TO_BREAK_DV  ' + call_to_break_dv_str.replace('ParamsM[', 'ParamsMSerial[') + '\n\n')
    # KINETIC
    f.write('\n#endif')
    f.close()
    return [call_to_init_str, call_to_deriv_str, call_to_break_str, call_to_break_dv_str]


def replace_for_cuh(call_to_init_str, call_to_deriv_str, call_to_break_str, call_to_break_dv_str):
    call_to_init_str_cu = call_to_init_str.replace('InitModel', 'CuInitModel')
    call_to_deriv_str_cu = call_to_deriv_str.replace('DerivModel', 'CuDerivModel')
    call_to_break_str_cu = call_to_break_str.replace('BreakpointModel', 'CuBreakpointModel')
    call_to_break_dv_str_cu = call_to_break_dv_str.replace('BreakpointModel', 'CuBreakpointModel')

    call_to_init_str_cu = call_to_init_str_cu.replace('TheMMat', 'InMat')
    call_to_deriv_str_cu = call_to_deriv_str_cu.replace('TheMMat', 'InMat')
    call_to_break_str_cu = call_to_break_str_cu.replace('TheMMat', 'InMat')
    call_to_break_dv_str_cu = call_to_break_dv_str_cu.replace('TheMMat', 'InMat')

    call_to_init_str_cu = call_to_init_str_cu.replace('InMat.boolModel', 'cBoolModel')
    call_to_deriv_str_cu = call_to_deriv_str_cu.replace('InMat.boolModel', 'cBoolModel')
    call_to_break_str_cu = call_to_break_str_cu.replace('InMat.boolModel', 'cBoolModel')
    call_to_break_dv_str_cu = call_to_break_dv_str_cu.replace('InMat.boolModel', 'cBoolModel')

    call_to_init_str_cu = call_to_init_str_cu.replace('seg+', 'PIdx[count] +')
    call_to_deriv_str_cu = call_to_deriv_str_cu.replace('seg+', 'PIdx[count] +')
    call_to_break_str_cu = call_to_break_str_cu.replace('seg+', 'PIdx[count] +')
    call_to_break_dv_str_cu = call_to_break_dv_str_cu.replace('seg+', 'PIdx[count] +')

    call_to_init_str_cu = call_to_init_str_cu.replace('V[seg]', 'v[count]')
    call_to_deriv_str_cu = call_to_deriv_str_cu.replace('dt, V[seg]', 'dt, v[count]')
    call_to_break_str_cu = call_to_break_str_cu.replace('sumCurrents, sumConductivity, V[seg]',
                                                        'sumCurrents[count] , sumConductivity[count],v[count] ')
    call_to_break_dv_str_cu = call_to_break_dv_str_cu.replace('sumCurrentsDv, sumConductivityDv, V[seg]+0.001',
                                                              'sumCurrentsDv[count] , sumConductivityDv[count] ,v[count] +0.001')

    call_to_init_str_cu = call_to_init_str_cu.replace('StatesM[', 'state_macro(')
    call_to_deriv_str_cu = call_to_deriv_str_cu.replace('StatesM[', 'state_macro(')
    call_to_break_str_cu = call_to_break_str_cu.replace('StatesM[', 'state_macro(')
    call_to_break_dv_str_cu = call_to_break_dv_str_cu.replace('StatesM[', 'state_macro(')
    not_states.append('eca')
    if split_flg:
        for stt in not_states:
            call_to_init_str_cu = call_to_init_str_cu.replace(stt, 'ca_macro(count,' + stt +')')
            call_to_deriv_str_cu = call_to_deriv_str_cu.replace(stt, 'ca_macro(count,' + stt +')')
            call_to_break_str_cu = call_to_break_str_cu.replace(stt, 'ca_macro(count,' + stt +')')
            call_to_break_dv_str_cu = call_to_break_dv_str_cu.replace(stt, 'ca_macro(count,' + stt +')')

    else:
        for stt in not_states:
            call_to_init_str_cu = call_to_init_str_cu.replace(stt, stt +'[count]')
            call_to_deriv_str_cu = call_to_deriv_str_cu.replace(stt, stt +'[count]')
            call_to_break_str_cu = call_to_break_str_cu.replace(stt, stt +'[count]')
            call_to_break_dv_str_cu = call_to_break_dv_str_cu.replace(stt, stt +'[count]')

    call_to_init_str_cu = call_to_init_str_cu.replace('ParamsM[', 'p')
    call_to_deriv_str_cu = call_to_deriv_str_cu.replace('ParamsM[', 'p')
    call_to_break_str_cu = call_to_break_str_cu.replace('ParamsM[', 'p')
    call_to_break_dv_str_cu = call_to_break_dv_str_cu.replace('ParamsM[', 'p')

    call_to_init_str_cu = call_to_init_str_cu.replace('[comp] ', '')
    call_to_deriv_str_cu = call_to_deriv_str_cu.replace('[comp] ', '')
    call_to_break_str_cu = call_to_break_str_cu.replace('[comp] ', '')
    call_to_break_dv_str_cu = call_to_break_dv_str_cu.replace('[comp] ', '')


    call_to_init_str_cu = call_to_init_str_cu.replace('][seg]', ',count)')
    call_to_deriv_str_cu = call_to_deriv_str_cu.replace('][seg]',  ',count)')
    call_to_break_str_cu = call_to_break_str_cu.replace('][seg]',  ',count)')
    call_to_break_dv_str_cu = call_to_break_dv_str_cu.replace('][seg]',  ',count)')

    call_to_init_str_cu = call_to_init_str_cu.replace('[seg] ', '')
    call_to_deriv_str_cu = call_to_deriv_str_cu.replace('[seg] ', '')
    call_to_break_str_cu = call_to_break_str_cu.replace('[seg] ', '')
    call_to_break_dv_str_cu = call_to_break_dv_str_cu.replace('[seg] ', '')



    call_to_init_str_cu = call_to_init_str_cu.replace('][comp]', '_ ## VARILP ')
    call_to_deriv_str_cu = call_to_deriv_str_cu.replace('][comp]', '_ ## VARILP ')
    call_to_break_str_cu = call_to_break_str_cu.replace('][comp]', '_ ## VARILP ')
    call_to_break_dv_str_cu = call_to_break_dv_str_cu.replace('][comp]', '_ ## VARILP ')

    call_to_init_str_cu = call_to_init_str_cu.replace('[ comp ]', '')
    call_to_deriv_str_cu = call_to_deriv_str_cu.replace('[ comp ]', '')
    call_to_break_str_cu = call_to_break_str_cu.replace('[ comp ]', '')
    call_to_break_dv_str_cu = call_to_break_dv_str_cu.replace('[ comp ]', '')

    call_to_init_str_cu = call_to_init_str_cu.replace('[ seg ]', '')
    call_to_deriv_str_cu = call_to_deriv_str_cu.replace('[ seg ]', '')
    call_to_break_str_cu = call_to_break_str_cu.replace('[ seg ]', '')
    call_to_break_dv_str_cu = call_to_break_dv_str_cu.replace('[ seg ]', '')
    # if not call_to_init_str_cu:
    #    call_to_init_str_cu = "#define CALL_TO_INIT_STATES_CU(VARILP)\n"
    # if not call_to_deriv_str_cu:
    #    call_to_deriv_str_cu = "#define CALL_TO_DERIV_CU(VARILP) \n"
    # if not call_to_break_str_cu:
    #    call_to_break_str_cu = "#define CALL_TO_BREAK_CU(VARILP)\n"
    # if not call_to_break_dv_str_cu:
    #    call_to_break_dv_str_cu = "#define CALL_TO_BREAK_DV_CU(VARILP)\n"

    return call_to_init_str_cu, call_to_deriv_str_cu, call_to_break_str_cu, call_to_break_dv_str_cu


def set_states_for_cuh(f, n_basic_states, n_extra_states):
    state_set_str = ''
    for curr_state in range(1, n_basic_states  + 1):
        curr_state_str = 'ModelStates_## VARILP [' + str(curr_state - 1) + ']=0; '
        state_set_str += curr_state_str
    f.write('\n\n#define SET_STATES(VARILP) ' + state_set_str + '; \n')


def init_kin_states(f, states_kin,kin_indices):
    kin_str = '#define   SET_KINETIC_STATE (VARILP) '
    for i in range(len(kin_indices)):
        kin_ind = kin_indices[i]
        kin_str = kin_str + 'ModelStates_## VARILP[{:d}] = init_state_macro({:d},PIdx_## VARILP );'.format(kin_ind, i)
    f.write('\n'+kin_str+'\n');

def expand_ilp_macros(file_name, other_file_names, ilpn, out_file_name):
    #print file_name
    #print other_file_names
    #print ilpn
    #print out_file_name
    lines = get_lines(file_name)
    all_lines = list(lines)
    for fn in other_file_names:
        with open(fn, 'r') as f:
            all_lines.extend([l[:-1] if l[-1] == '\n' else l for l in f])
    calls = []
    for line in lines:
        if 'SUPERILPMACRO(' in line:
            calls.append(line)
    matches = []
    for call in calls:
        matches.append(re.findall(r'SUPERILPMACRO\((.*?)\)', call)[0])
    all_in_macros = list(set(matches) - set(['x']))
    for i in range(1, len(all_in_macros) + 1):
        curr_line_i_tmp = [1 if re.search('#define.*' + all_in_macros[i - 1], line) else 0 for line in all_lines]
        #print 'tmp'

        tmp1 = list(filter(lambda x: x != 0, curr_line_i_tmp))
        if (len(tmp1) > 0):
            tmp2 = curr_line_i_tmp.index(tmp1[0])
            curr_line_i = tmp2
            #print curr_line_i

            # I changed her cur_line to curr_line Maybe it was wrong
            curr_line = all_lines[curr_line_i]
            base_command = curr_line[curr_line.find('VARILP)') + 8:]
            expanded = ''
            j=1
            rep_str = '[' + str(j) + ']';
            Tmp = base_command.replace('_ ## VARILP', rep_str)
            Tmp = Tmp.replace('_## VARILP', rep_str)
            Tmp = Tmp.replace('## VARILP', rep_str)
            expanded += Tmp
            curr_call_i = []
            for k in range(len(lines)):
                if 'SUPERILPMACRO(' + all_in_macros[i - 1] + ')' in lines[k]:
                    curr_call_i.append(k)
            for j in range(1, len(curr_call_i) + 1):
                lines[curr_call_i[j - 1]] = lines[curr_call_i[j - 1]][
                                            :lines[curr_call_i[j - 1]].find('SUPERILPMACRO') - 1] + expanded
        else:
            print("what to do?")
    put_lines(out_file_name, lines)


def tail_end(f, n_params, call_to_init_str_cu, call_to_deriv_str_cu, call_to_break_str_cu, call_to_break_dv_str_cu,
             params_m, n_segs_mat, cm_vec, vs_dir, has_f, nd, nrhs, FN, nstates, nextra_states,states_kin,kin_indices):
    declare_str, parameter_set_str = '', ''
    #for curr_param in range(1, n_params + 1):
    #    curr_parameter_str = '#define   SET_PARAMS{:03d}(VARILP) MYFTYPE p{:d}_ ## VARILP =ParamsM[NeuronID*perThreadMSize + {:d}*InMat.NComps+cSegToComp[PIdx_ ## VARILP] ];\n'.format(curr_param, curr_param - 1, curr_param - 1)
    #    f.write(curr_parameter_str)
    set_states_for_cuh(f, nstates, nextra_states)
    if has_kinetics:
        init_kin_states(f, states_kin,kin_indices)
    call_to_init_str_cu = re.sub('p([0-9]*)_ ## VARILP', r'param_macro(\1, PIdx[count])', call_to_init_str_cu)
    call_to_deriv_str_cu = re.sub('p([0-9]*)_ ## VARILP', r'param_macro(\1, PIdx[count])', call_to_deriv_str_cu)
    call_to_break_str_cu = re.sub('p([0-9]*)_ ## VARILP', r'param_macro(\1, PIdx[count])', call_to_break_str_cu)
    call_to_break_dv_str_cu = re.sub('p([0-9]*)_ ## VARILP', r'param_macro(\1, PIdx[count])',call_to_break_dv_str_cu)

    f.write('\n\n#define CALL_TO_INIT_STATES_CU(VARILP) {}\n\n'.format(call_to_init_str_cu))
    f.write('#define CALL_TO_DERIV_CU(VARILP)   {}\n\n'.format(call_to_deriv_str_cu))
    f.write('#define CALL_TO_BREAK_CU(VARILP)   {}\n\n'.format(call_to_break_str_cu))
    f.write('#define CALL_TO_BREAK_DV_CU(VARILP)    {}\n\n'.format(call_to_break_dv_str_cu))

    f.write('\n#endif')
    f.close()

    print('Finished writing AllModels.h,cpp,cu,cuh')

    params_m_per_seg = []
    params_m = np.array(params_m)

    n_segs_mat = np.array(n_segs_mat)
    for i in range(1, params_m.shape[0] + 1):
        temp = np.matlib.repmat(params_m[i - 1, :], n_segs_mat[i - 1], 1);
        params_m_per_seg.extend(list(temp))
    params_m_per_seg = np.array(params_m_per_seg)
    cm_vec = np.array(cm_vec)
    cm_zeros = np.where(cm_vec == 0)
    params_m_per_seg[cm_zeros, :] = np.zeros(params_m_per_seg[cm_zeros, :].shape)
    all_segs = np.sum(n_segs_mat)
    if np.floor(all_segs / WARPSIZE) != all_segs / WARPSIZE:
        print('we have a non WARPSIZE multiple number of segs')
        exit(12345)
    nilp = all_segs / WARPSIZE
    if (split_flg==0):
        tmp = np.array(get_lines(vs_dir + '/CudaStuffBase.cu'))
    else:
        tmp = np.array(get_lines(vs_dir + '/CudaStuffBaseSplit.cu'))
    set_params_line_i = np.where(np.array(['SET_PARAMS' in i for i in tmp]))
    if set_params_line_i[0].size != 0:
        tmp2 = ['SUPERILPMACRO(SET_PARAMS{:03d})'.format(i) for i in range(1, n_params + 1)]
        tmp3 = tmp[:set_params_line_i[-1]] + tmp2 + tmp[set_params_line_i[-1] + 1:]
    else:
        tmp3 = tmp
        tmp3[3] = '#define ILP' + str(int(nilp))
    put_lines(vs_dir + '/CudaStuffBasex.cu', tmp3)
    expand_ilp_macros(vs_dir + '/CudaStuffBasex.cu', ['./CParsed/AllModels.cuh'], nilp,
                      vs_dir + '/CudaStuff.cu')  # for some reason it was using allmodels.cuh which we should not anymore
    #params_m_mat = sio.loadmat(baseDir + '/Data/ParamsMForC.mat')
    #params_m_mat['param_m'] = params_m.astype(float)
    #sio.savemat(baseDir + '/Data/ParamsMForC.mat', params_m_mat)
    if has_f:
        fn = baseDir + '/Data/rhsFromNeuron.dat'
        f = open(fn, 'w')
        f.write(nrhs.astype(float))
        f.close()
        fn = baseDir + '/Data/DFromNeuron.dat'
        f = open(fn, 'w')
        f.write(nd.astype(float))
        f.close()

    print ('Finished NMODLtoC_Main.')


def write_all_models_cu(c_parsed_folder, reversals_names, reversals_vals, gglobals_flat, gglobals_vals, nglobals_flat,
                        neuron_globals_vals, c_param_lines_list, c_init_lines_cu, c_proc_lines_cu, c_deriv_lines_cu,
                        c_break_lines_cu, proc_declare_cu, c_func_lines_cu):
    global kin_helper
    reversals_vals = reversals_vals[0]

    FN = c_parsed_folder + 'AllModels.cu'
    f = open(FN, 'w')
    f.write('// Automatically generated CU for ' + os.getcwd() + modelFile + '\n')
    f.write(
        '#include <stdio.h>\n#include <stdlib.h>\n#include <math.h>\n#include "cuda_runtime.h"\n#include "device_launch_parameters.h"\n#include "AllModels.cuh"\n\n')
    f.write(
        '// Universals:\n#define PI (3.1415927f)\n#define R (8.31441f)\n#define FARADAY (96485.309f)\n#define ktf (1000.*8.3134*(celsius + 273.15)/FARADAY)\n#define DEF_vrest	-65.\n#define DEF_nai 10.\n#define DEF_nao 140.\n#define DEF_ena (115. + DEF_vrest)\n#define DEF_ki	54.4\n#define DEF_ko 2.5\n#define DEF_ek (-12. + DEF_vrest)\n#include <math.h>\n#define DEF_cai	5.e-5\n#define DEF_cao	2.\n#define	DEF_eca		12.5 *log(DEF_cao / DEF_cai)\n')
    ##YOUR HERE
    f.write('\n// GGlobals:\n')
    for n, v in zip(gglobals_flat, gglobals_vals):
        f.write('#define ' + n + ' (' + str(v) + ')\n')

    f.write('\n// NGlobals:\n')
    for n, v in zip(nglobals_flat, neuron_globals_vals):
        f.write('#define ' + n + ' (' + str(v) + ')\n')

    if reversals_names:
        f.write('// Reversals:\n')
        for r_n, r_v in zip(reversals_names, reversals_vals):
            if r_n == 'eca':
                r_n = 'DEF_eca2'
            f.write('#define ' + r_n + ' (' + str(r_v) + 'f)\n')
    cu_param_lines_list = []
    for l in c_param_lines_list:
        if l:
            cu_param_lines_list.append([s for s in l if '=' in s])

    c_init_lines_cu = remove_globals_recalculation(replace_pow(c_init_lines_cu), nglobals_flat)
    c_proc_lines_cu = remove_globals_recalculation(replace_pow(c_proc_lines_cu), nglobals_flat)
    c_deriv_lines_cu = remove_globals_recalculation(replace_pow(c_deriv_lines_cu), nglobals_flat)
    c_break_lines_cu = remove_globals_recalculation(replace_pow(c_break_lines_cu), nglobals_flat)
    # KINETIC c_break_lines_c = remove_globals_recalculation(replace_pow(c_break_lines_c), nglobals_flat)
    # CInitLinesCuC = removeGlobalsRecalculation(ReplacePow(CInitLinesCuC), NGlobals);
    f.write('\n// Declarations:\n')
    proc_declare_cu_flat = []
    for l in proc_declare_cu:
        proc_declare_cu_flat = proc_declare_cu_flat + l
    proc_declare_cu_flat = [s + '\n' for s in proc_declare_cu_flat]
    proc_declare_cu_flat = ''.join(proc_declare_cu_flat)
    f.write(proc_declare_cu_flat)
    f.write(
        'float Cunernst(float ci,float co, float z) {\n\tif (z == 0) {\n\t\treturn 0.;\n\t}\n\tif (ci <= 0.) {\n\t\treturn 1e6;\n\t}else if (co <= 0.) {\n\t\treturn -1e6;\n\t}else{\n\t\treturn ktf/z*log(co/ci);\n\t}\t\n}\n')
    if has_kinetics:
        f.write('\n// Kinetic helper functions:\n')
        kin_helper = '\n'.join(kin_helper)
        f.write(kin_helper)
    f.write('\n// Functions:\n')
    cu_func_flat = []
    for l in c_func_lines_cu:
        for ll in l:
            cu_func_flat = cu_func_flat + ll
    cu_func_flat = [s + '\n' for s in cu_func_flat]
    cu_func_flat = ''.join(cu_func_flat)
    f.write(cu_func_flat)
    f.write('\n// Procedures:\n')
    cu_proc_lines_flat = []
    for l in c_proc_lines_cu:
        for ll in l:
            cu_proc_lines_flat = cu_proc_lines_flat + ll
    cu_proc_lines_flat = [s + '\n' for s in cu_proc_lines_flat]
    cu_proc_lines_flat = ''.join(cu_proc_lines_flat)
    f.write(cu_proc_lines_flat)

    f.write('\n// Inits:\n')
    cu_init_lines_flat = []
    for l in c_init_lines_cu:
        cu_init_lines_flat = cu_init_lines_flat + ['\n'] + l
    cu_init_lines_flat = [s + '\n' for s in cu_init_lines_flat]
    cu_init_lines_flat = ''.join(cu_init_lines_flat)
    f.write(cu_init_lines_flat)
    # KINETIC
    f.write('\n// Derivs:\n')
    c_deriv_lines_cu = [x for x in c_deriv_lines_cu if x != []]
   # cu_deriv_lines_flat = []
 #   for l in c_deriv_lines_cu:
  #      cu_deriv_lines_flat = cu_deriv_lines_flat + ['\n'] + l
   # cu_deriv_lines_flat = ''.join(cu_deriv_lines_flat)

    #f.write(cu_deriv_lines_flat)
    c_deriv_lines_cu = ''.join(c_deriv_lines_cu)
    f.write(c_deriv_lines_cu)
    f.write('\n// Breaks:\n')
    cu_break_lines_flat = []
    for l in c_break_lines_cu:
        cu_break_lines_flat = cu_break_lines_flat + ['\n'] + l
    cu_break_lines_flat = [s + '\n' for s in cu_break_lines_flat]
    cu_break_lines_flat = ''.join(cu_break_lines_flat)
    f.write(cu_break_lines_flat)
    f.close()
    return []


def write_all_models_cpp(c_parsed_folder, reversals_names, reversals_vals, all_writes, all_locals, currents,
                         nglobals_flat, neuron_globals_vals, c_init_lines_c, c_proc_lines_c, c_deriv_lines_c,
                         c_break_lines_c, proc_declare, c_func_lines_c):
    reversals_vals = reversals_vals[0]
    FN = c_parsed_folder + 'AllModels.cpp'
    if (not os.path.exists(c_parsed_folder)):
        os.makedirs(c_parsed_folder)
    f = open(FN, 'w')
    f.write('// Automatically generated C for ' + os.getcwd() + modelFile + '\n')
    f.write('#include <stdio.h>\n#include <stdlib.h>\n#include <math.h>\n#include "AllModels.h"\n\n')
    f.write(
        '// Universals:\n#define PI (3.1415927f)\n#define R (8.31441f)\n#define FARADAY (96485.309f)\n#define ktf (1000.*8.3134*(celsius + 273.15)/FARADAY)\n\n')
    membdef = 'membdef.h'
    with open(membdef) as fr:
        membdef_c = fr.read().splitlines()
    if reversals_names:
        f.write('// Reversals:\n')
        for r_n, r_v in zip(reversals_names, reversals_vals):

            rev_in = r_n[1:] + 'i'
            rev_out = r_n[1:] + 'o'
            if r_n == 'eca':
                r_n = 'eca_def'
            if index_containing_substring(all_writes, rev_in) > -1 or index_containing_substring(all_writes,
                                                                                                 rev_out) > -1:
                rev_in_ind = index_containing_substring(membdef_c, '#define DEF_' + rev_in)
                rev_out_ind = index_containing_substring(membdef_c, '#define DEF_' + rev_out)
                f.write(membdef_c[rev_in_ind] + '\n')
                f.write(membdef_c[rev_out_ind] + '\n')
            else:
                f.write('#define ' + r_n + ' (' + str(r_v) + 'f)\n')

    if all_locals:
        all_locals_flat = list(set.union(*all_locals))
        f.write('\n// Locals:\n')
        tmp = set(all_locals_flat) - set(reversals_names).union(currents)
        tmp = list(tmp)
        tmp.sort()
        tmp = ''.join([s + ',' for s in tmp])
        f.write(FTYPESTR + ' ' + tmp[:-1] + ';\n')
    f.write('\n// Ion currents as Locals:\n')
    currents = [s + ',' for s in currents]
    f.write(FTYPESTR + ' ' + ''.join(currents)[:-1] + ';\n')
    f.write('\n// NGlobals:\n')
    for n, v in zip(nglobals_flat, neuron_globals_vals):
        f.write('#define ' + n + ' (' + str(v) + ')\n')
    c_init_lines_c = remove_globals_recalculation(replace_pow(c_init_lines_c), nglobals_flat)
    c_proc_lines_c = remove_globals_recalculation(replace_pow(c_proc_lines_c), nglobals_flat)
    c_deriv_lines_c = remove_globals_recalculation(replace_pow(c_deriv_lines_c), nglobals_flat)
    c_break_lines_c = remove_globals_recalculation(replace_pow(c_break_lines_c), nglobals_flat)
    # KINETIC c_break_lines_c = remove_globals_recalculation(replace_pow(c_break_lines_c), nglobals_flat)
    # CInitLinesCuC = removeGlobalsRecalculation(ReplacePow(CInitLinesCuC), NGlobals);
    f.write('\n// Declarations:\n')
    proc_declare_flat = []
    for l in proc_declare:
        proc_declare_flat = proc_declare_flat + l
    proc_declare_flat = [s + '\n' for s in proc_declare_flat]
    proc_declare_flat = ''.join(proc_declare_flat)
    f.write(proc_declare_flat)
    f.write('\n// Functions:\n')
    c_func_flat = []
    for l in c_func_lines_c:
        for ll in l:
            c_func_flat = c_func_flat + ll
    c_func_flat = [s + '\n' for s in c_func_flat]
    c_func_flat = ''.join(c_func_flat)
    f.write(c_func_flat)
    f.write('\n// Inits:\n')
    c_init_lines_flat = []
    for l in c_init_lines_c:
        c_init_lines_flat = c_init_lines_flat + ['\n'] + l
    c_init_lines_flat = [s + '\n' for s in c_init_lines_flat]
    c_init_lines_flat = ''.join(c_init_lines_flat)
    f.write(c_init_lines_flat)
    f.write('\n// Procedures:\n')
    c_proc_lines_flat = []
    for l in c_proc_lines_c:
        for ll in l:
            c_proc_lines_flat = c_proc_lines_flat + ll
    c_proc_lines_flat = [s + '\n' for s in c_proc_lines_flat]
    c_proc_lines_flat = ''.join(c_proc_lines_flat)
    f.write(c_proc_lines_flat)
    # KINETIC
    f.write('\n// Derivs:\n')
    c_deriv_lines_flat = []
   # for l in c_deriv_lines_c:
    #    c_deriv_lines_flat = c_deriv_lines_flat + ['\n'] + l
    c_deriv_lines_flat = [s + '\n' for s in c_deriv_lines_flat]
    c_deriv_lines_flat = ''.join(c_deriv_lines_flat)
    f.write(c_deriv_lines_flat)
    f.write('\n// Breaks:\n')
    c_break_lines_flat = []
    for l in c_break_lines_c:
        c_break_lines_flat = c_break_lines_flat + ['\n'] + l
    c_break_lines_flat = [s + '\n' for s in c_break_lines_flat]
    c_break_lines_flat = ''.join(c_break_lines_flat)
    f.write(c_break_lines_flat)
    f.close()


def get_actual_params(all_reversals, g_globals, nglobals_flat, comp_mechs, all_params_non_global_flat):
    # print all_params_global_flat
    # param = nrn.h.ref(0)  # string reference to store parameter name
    nrn.h('tfunc()')
    actual_reversals = []
    actual_gglobals = []
    actual_globals = []
    actual_non_globals_vals = []
    actual_non_globals_names = []
    nrn.h('access root.sec')
    for g in g_globals:
        nrn.h('x = ' + g)
        actual_gglobals.append(nrn.h.x)
    for g in nglobals_flat:
        nrn.h('x = ' + g)
        actual_globals.append(nrn.h.x)
    # for g in all_params_global_flat:
    #    nrn.h('x = ' + g)
    #    actual_globals.append(nrn.h.x)
    counter = 0
    for s in nrn.h.allsec():
        curr_reversal = []
        curr_not_globals_vals = []
        curr_not_globals_names = []
        for r in all_reversals:
            ion_str = r[1:] + '_ion'
            flg = nrn.h.ion_style(ion_str)
            if flg == -1:
                curr_reversal.append([])
            else:
                nrn.h('x = ' + r)
                curr_reversal.append(nrn.h.x)
        actual_reversals.append(curr_reversal)
        curr_mechs = comp_mechs[counter]

        for mech in curr_mechs:
            params_query = [p for p in all_params_non_global_flat if p.endswith(mech)]
            for s in params_query:
                nrn.h('x = ' + s)
                curr_not_globals_vals.append(nrn.h.x)
                curr_not_globals_names.append(s)
        actual_non_globals_vals.append(curr_not_globals_vals)
        actual_non_globals_names.append(curr_not_globals_names)
        counter = counter + 1
    return [actual_gglobals, actual_reversals, actual_globals, actual_non_globals_names, actual_non_globals_vals]


def write_cpp_file(cpp_file, model_name, c_param_lines, before_first_line, proc_declare, c_func_line, c_init_lines,
                   c_proc_lines, c_deriv_lines, c_break_lines):
    f = open(cpp_file, 'w')
    f.write('#include "' + model_name + '.h"\n')
    f.write('#include <math.h>\n\n')
    for line in c_param_lines:
        f.write(line + '\n')
    f.write('\n')
    f.write(before_first_line + '\n')
    for line in proc_declare:
        f.write(line + '\n')
    f.write('\n')
    for list in c_func_line:
        for line in list:
            f.write(line + '\n')
        f.write('\n')
    for line in c_init_lines:
        f.write(line + '\n')
    f.write('\n')
    for list in c_proc_lines:
        for line in list:
            f.write(line + '\n')
        f.write('\n')
    f.write('\n')
    for line in c_deriv_lines:
        f.write(line + '\n')
    f.write('\n')
    for line in c_break_lines:
        f.write(line + '\n')
    f.write('\n')
    #    for line in c_kinetic_lines:
    #        f.write(line + '\n' )
    f.write('\n')
    f.close()


def write_h_file(fn, model_name, all_params, all_states, break_point_declare, deriv_declare, init_declare, call_to_init,
                 call_to_deriv, call_to_break, call_to_break_dv, nkin_states):
    f = open(fn, 'w')
    f.write('#ifndef __' + model_name + '__\n#define __' + model_name + '__\n\n')
    all_params_line = ''.join([s + ' ' for s in all_params])
    f.write('#define celsius 6.3\n')
    f.write('#define ena 56\n')
    f.write('#define ek -77\n\n')
    f.write('// ' + all_params_line + '\n')
    f.write('#define NPARAMS ' + str(len(all_params)) + '\n')
    f.write('#define NSTATES ' + str(len(all_states)) + '\n')
    if has_kinetics:
        f.write('#define NKIN_STATES ' + nkin_states + '\n')
    f.write(break_point_declare + '\n')
    if deriv_declare:
        f.write(deriv_declare + '\n')
    f.write(init_declare + '\n')
    f.write('#define CALL_TO_INIT_STATES ' + call_to_init + '\n\n')
    f.write('#define CALL_TO_DERIV ' + call_to_deriv + '\n\n')
    f.write('#define CALL_TO_BREAK ' + call_to_break + '\n\n')
    f.write('#define CALL_TO_BREAK_DV ' + call_to_break_dv + '\n\n')
    # f.write('#define CALL_TO_Kinetic ' + call_to_kinetic + '\n\n')
    f.write('\n#endif')
    f.write('\n')
    f.close()


def meta_add_model_name_to_function(curr_list, proc_names, func_names, model_name, all_params, flg):
    src = proc_names + func_names
    if flg == 1:
        src = src + [s + 'Cu' for s in src]
    trg = [s + '_' + model_name for s in src]
    if flg == 1:
        trg = ['Cu' + s for s in trg] + ['Cu' + s for s in trg]
    curr_list = add_model_name_to_function(curr_list, src, trg)
    src = all_params
    trg = [s + '_' + model_name for s in all_params]
    return add_model_name_to_function(curr_list, src, trg)


def parse_model(lines):
    all_states_names_list = []
    writes = []
    reads = []
    ions = []
    nglobal_c = []
    only_reads = []
    output = handle_neuron_block(lines)
    # TODO
    # return [suffix, currglobal, Useion, NSC, reads, writes, Range]
    model_name = output[0]
    globals = output[1]
    ions = output[2]
    non_spec_current = output[3]
    reads = output[4]
    writes = output[5]
    ranges = output[6]
    only_reads = set(set(reads) - set(writes))
    nglobal_c = [v + '_' + model_name for v in globals]
    all_assigned = handle_assigned_block(lines)
    output = handle_state_block(lines,writes)
    if not output:
        output = ['', [], [], []]
    all_state_line = output[0]
    all_state_line_seg = output[1]
    curr_all_state = output[2]

    return [model_name, globals, ions, reads, writes, only_reads, nglobal_c, curr_all_state, all_state_line,
            all_state_line_seg, all_assigned, ranges, non_spec_current]


def parse_model2(mod_fn, lines, globals, all_state_line, all_state_line_seg, model_name, only_reads_no_reversals,
                 writes_no_currents, all_reads_no_reversals, writes, all_assigned, all_states, reads, gs, ranges,
                 non_spec_curr, ions, reversals, write_no_currents, all_writes, extra_states_trg):
    global ParamStartVal
    output = handle_params_block(lines, globals)
    # return [all_params_line, all_params_line_seg, c_param_lines, all_param_line_declare, all_params_line_call,all_params, global_inds, not_global_inds]
    all_params_line = output[0]
    all_params_line_seg = output[1]
    c_param_lines = output[2]
    all_params = output[5]
    all_param_line_declare = output[3]
    all_params_line_call = output[4]
    global_inds = output[6]
    not_global_inds = output[7]

    ParamStartVal = ParamStartVal + len(not_global_inds)
    # MIGHT need to pass this to parse model
    output = create_states_param_str(all_state_line, all_state_line_seg, all_params_line, all_params_line_seg,
                                     only_reads_no_reversals, writes_no_currents, all_reads_no_reversals, writes,
                                     extra_states_trg)
    states_params_str = output[0]
    states_params_str_seg = output[1]
    additional_writes = output[2]
    output = handle_mod_function(lines, model_name)
    # return [func_names,c_func_lines,input_vars]

    func_names = output[0]
    c_func_lines = output[1]
    input_vars_func = output[2]
    c_func_lines_cu = output[3]
    output = handle_mod_procedures(mod_fn,lines, model_name, all_param_line_declare, globals, all_params_line_call)
    # return [str_of_out_vars,before_first_line_all,all_c_proc_lines,all_c_proc_lines_cu,func_names,input_vars_c,all_out_vars,proc_declare,proc_declare_cu,all_param_line_call_all]
    before_first_line_all = output[1]
    c_proc_lines = output[2]
    c_proc_lines_cu = output[3]
    proc_names = output[4]
    input_vars_proc = output[5]
    all_out_vars = output[6]
    proc_declare = output[7]
    proc_declare_cu = output[8]
    all_params_line_call_all = output[9]
    tmpset = set(['celsius', 'v'] + all_states + all_params + reads + writes)
    locals = set(all_assigned) - tmpset
    states_params_str_seg = states_params_str_seg.replace('cai[seg]', 'cai [ seg ]')
    output = handle_initial_block(lines, model_name, states_params_str, states_params_str_seg, proc_names,
                                  input_vars_proc, all_params_line_call, before_first_line_all,
                                  all_params_line_call_all,writes)
    c_init_lines = output[0]
    c_init_lines_cu = output[1]
    init_declare = output[2]
    call_to_init = output[3]
    # return [c_init_lines, c_init_lines_cu, init_declare, call_to_init]
    # handle_initial_block(lines,model_name,states_params_str,func_names,input_vars_c,all_param_li
    output = handle_deriv_block(mod_fn, lines, model_name, states_params_str, all_states, locals, all_params,
                                all_out_vars, gs, proc_names, input_vars_proc, all_params_line_call,
                                states_params_str_seg, before_first_line_all, all_params_line_call_all)
    # return [call_to_deriv, c_deriv_lines, c_deriv_lines_cu, deriv_declare]
    call_to_deriv = output[0]
    c_deriv_lines = output[1]
    c_deriv_lines_cu = output[2]
    deriv_declare = output[3]

    output = handle_breakpoint_block(mod_fn, lines, model_name, states_params_str, ranges, all_states, all_params, gs,
                                     non_spec_curr, writes, additional_writes, write_no_currents, ions, reversals,
                                     reads, all_writes, all_assigned, states_params_str_seg, func_names,
                                     input_vars_proc, all_params_line_call)
    # return [break_point_declare,c_break_lines,c_break_lines_cu,call_to_break,call_to_break_dv]
    break_point_declare = output[0]
    c_break_lines = output[1]
    c_break_lines_cu = output[2]
    call_to_break = output[3]
    call_to_break_dv = output[4]

    # kinetics
    output = handle_state_block(lines,writes)
    if not output:
        output = ['', [], [], []]
    all_state_line = output[0]
    all_state_line_seg = output[1]
    curr_all_state = output[2]
    rates_lines = []
    for i in range(len(lines)):
        l = lines[i]
        if l.startswith('PROCEDURE rates'):
            for j in range(i + 1, len(lines)):
                l2 = lines[j].strip()
                if len(l2) != 0 and l2 != '}':
                    rates_lines.append(l2)
                if l2 == '}':
                    break
            break
    start = index_containing_substring(lines, 'KINETIC')

    global has_kinetics
    if start >= 0:
        has_kinetics = True
        kin_states = all_states
        init_body_ind = c_init_lines_cu[0].find('){')
        c_init_lines_cu = [c_init_lines_cu[0][:init_body_ind+2]]+['\n}']#we hacked the init with reading it from neuron.
        output2 = handle_kinetic_deriv_block(mod_fn, lines, model_name, states_params_str, all_states, locals, all_params,
                                all_out_vars, gs, proc_names, input_vars_proc, all_params_line_call,
                                states_params_str_seg, before_first_line_all, all_params_line_call_all,rates_lines)
        [call_to_kinetic_deriv, c_kinetic_deriv_lines, c_kinetic_deriv_lines_cu, kinetic_deriv_declare] = output2

    else:
        kin_states = []
        call_to_kinetic_deriv=''
        c_kinetic_deriv_lines=''
        c_kinetic_deriv_lines_cu=''
        kinetic_deriv_declare=''
    return [proc_names, func_names, all_params, global_inds, not_global_inds, all_params_line, proc_declare,
            proc_declare_cu, c_func_lines, c_func_lines_cu, c_init_lines, c_init_lines_cu, c_proc_lines,
            c_proc_lines_cu, c_deriv_lines, c_deriv_lines_cu, c_break_lines, c_break_lines_cu, break_point_declare,
            deriv_declare, init_declare, before_first_line_all, c_param_lines, call_to_init, call_to_deriv,
            call_to_break, call_to_break_dv, locals, kin_states, call_to_kinetic_deriv, c_kinetic_deriv_lines,
            c_kinetic_deriv_lines_cu, kinetic_deriv_declare]

def create_states_param_str(all_state_line, all_state_line_seg, all_params_line, all_params_line_seg,
                            only_reads_no_reversals, writes_no_currents, all_reads_no_reversals, writes,
                            extra_states_trg):
    additional_writes_c = set(set(v for v in writes) & all_reads_no_reversals) - set(writes_no_currents)


    additional_writes_out = additional_writes_c
    only_reads_no_reversals = [v for v in only_reads_no_reversals]
    additional_writes_c = [v for v in additional_writes_c]
    for curr in additional_writes_c:
        tmp = '&' + curr
        if tmp in all_state_line:
            additional_writes_c.remove(curr)
    state_param_sep = ''
    param_global_sep = ''
    if all_state_line:
        state_param_sep = ','
    if all_params_line:
        param_global_sep = ','
    only_read = ''
    only_read_seg = ''

    if only_reads_no_reversals:
        only_read = [', MYFTYPE ' + s for s in only_reads_no_reversals]
        only_read = ''.join(only_read)
        only_read_seg = [', ' + s + ' [ seg ]' for s in only_reads_no_reversals]
        only_read_seg = ''.join(only_read_seg)

    write_no_current = ''
    write_no_current_seg = ''
    if writes_no_currents:
        write_no_current = [', MYFTYPE &' + s if s != '' else s for s in writes_no_currents]
        write_no_current_seg = [', ' + s + ' [ seg ]' for s in writes_no_currents]
        write_no_current = ''.join(write_no_current)
        write_no_current_seg = ''.join(write_no_current_seg)
    if additional_writes_c:
        additional_writes = [', MYFTYPE &' + s if s != '' else s for s in additional_writes_c]
        additional_writes_seg = [', ' + s + ' [ seg ]' for s in additional_writes_c]
        additional_writes = ''.join(additional_writes)
        additional_writes_seg = ''.join(additional_writes_seg)
    else:
        additional_writes = ''
        additional_writes_seg = ''

    states_params_str = state_param_sep + all_state_line + param_global_sep + all_params_line + only_read + write_no_current + additional_writes

    states_params_str_seg = state_param_sep + all_state_line_seg + param_global_sep + all_params_line_seg + only_read_seg + write_no_current_seg + additional_writes_seg
    all_reads_no_reversals = list(all_reads_no_reversals)
    for x in range(len(all_reads_no_reversals)-1,-1,-1):
        if all_reads_no_reversals[x] in not_states:

            del(all_reads_no_reversals[x])


    if 'cai' in states_params_str:
        if states_params_str.find(' eca') == -1:
            states_params_str = states_params_str + ',MYFTYPE &eca'
            states_params_str_seg = states_params_str_seg + ',eca [ seg ]'
        else:
            states_params_str = states_params_str.replace(' eca', ' &eca')
    states_params_str_seg = add_model_name_to_function(states_params_str_seg, all_reads_no_reversals,
                                                       extra_states_trg)
    return [states_params_str, states_params_str_seg, additional_writes_out]


"""
PARAMETERS:
    lines: all the lines in the mod file  
    model_name: name of the model
    states: a string, of all the states used in the kinetic model. Gotten from handle_state_block
    rates_lines: The lines of code in the rates block. This is used during the calculation of the Q matrix. NOTE: this must be of a particular form, with no comments 

RETURNS:
    c_kinetic_helper_lines: basically a giant string of helper functions
    c_kinetic_deriv_lines: c function lines that should be used in CuDerivModel in the kinetic case
    c_kinetic_init_lines: c function lines that should be used in CuInitModel in the kinetic case
    call_to_kinetic_deriv: how to call the CuDerivModel function for this particular instance (should be the same as all other deriv calls, besides the model name)
    declare: the function declaration for this (should be the same as all other deriv declares)

Only supports kinetic equations with one state on each side of the equation, so far. 
Also assumes that the conserve statement at the bottom of the kinetic block is essentially sum(all states) = 1
"""

def get_tranistion(lines,states):
    trans_inds = all_indices_containing_substring(lines,'<->')
    ans = []
    for ind in trans_inds:
        curr_line = lines[ind]
        matches = re.search("~(.*)<->(.*)\((.*),(.*)\)",curr_line)
        left_state = matches.group(1).strip(' ')
        right_state = matches.group(2).strip(' ')
        lr_trans = matches.group(3).strip(' ')
        rl_trans = matches.group(4).strip(' ')
        tmp = [index_containing_substring(states,left_state),index_containing_substring(states,right_state),lr_trans,rl_trans]
        ans.append(tmp)
    for ind in trans_inds:
        del lines[ind]
    return ans

def handle_kinetic_deriv_block(mod_fn, lines, model_name, states_params_str, states, locals, all_parameters, all_out_vars,
                       conductances, func_names, input_vars_c, all_param_line_call, states_params_str_seg,
                       before_first_line_all, all_param_line_call_all,rates_lines):
    start = index_containing_substring(lines, 'KINETIC')
    global kin_helper
    if start < 0:
        call_to_kinetic_deriv = ''
        c_kinetic_deriv_lines = ['']
        c_kinetic_deriv_lines_cu = []
        kinetic_deriv_declare = ''
        return [call_to_kinetic_deriv, c_kinetic_deriv_lines, c_kinetic_deriv_lines_cu, kinetic_deriv_declare]

    sumP = lines[start].count('{') - lines[start].count('}')
    currInd = start + 1
    while (sumP > 0):
        sumP = sumP + lines[currInd].count('{') - lines[currInd].count('}')
        currInd += 1
    end = currInd
    tmp = lines[start].find('}')
    lines = lines[start + 1:end]

    first_line = 'void DerivModel_' + model_name + '(MYFTYPE dt, MYFTYPE v' + states_params_str + '){'
    #derivs = [s + '_d,' for s in states]
    #derivs[-1] = derivs[-1][:-1]
    #second_line_x = FTYPESTR + ' '.join(derivs) + ';'
    tmp_vars = set(locals - set(all_parameters)) - set(set(all_out_vars) | set(conductances))
    locals_line = ''
    if tmp_vars:
        locals_line = [s + ',' for s in tmp_vars]
        locals_line = FTYPESTR + ' ' + ''.join(locals_line)
        locals_line = locals_line[:-1] + ';'
    deriv_declare = first_line[:-1] + ';'
    f = open('kinetic_template.txt', 'r')
    template_lines = [tline.strip('\n') for tline in f.readlines()]
    rates_lhs = []
    for line in rates_lines:
        temp_line = line.split()
        var = temp_line[0]
        if var not in rates_lhs:
            rates_lhs.append(var)

    # replace "NSTATES" in the template lines with the actual number of states
    for i in range(0, len(template_lines)):
        template_lines[i] = template_lines[i].replace("MOD_STATES", str(len(states)))
    # creating c_kinetic_helper_lines
    if  len(kin_helper)==0:
        kin_helper = template_lines[index_containing_substring(template_lines,'//HELPER CODE') + 1:index_containing_substring(template_lines, '//END HELPER CODE')]
    # creating c_kinetic_deriv_lines
    kinetic_deriv_declares = template_lines[index_containing_substring(template_lines, '//DECLARES') + 1:index_containing_substring(template_lines, '//END DECLARES')]
    kin_body = template_lines[index_containing_substring(template_lines, '//KINBODY') + 1:index_containing_substring(template_lines, '//END KINBODY')]
    # c_kinetic_deriv_lines.insert(len(c_kinetic_deriv_lines)+3,'}')
    c_kinetic_beuler_lines = template_lines[index_containing_substring(template_lines,'//BEULER BLOCK') + 1:index_containing_substring(template_lines, '//END BEULER')]
    rates_declare = '\tMYFTYPE ' + ','.join(rates_lhs) + ';'
    y_declare = '\tMYFTYPE y[] = {' + ','.join(states) + '};'
    tmp_lines_cu = []
    transitions = get_tranistion(lines,states)
    conserve_ind = index_containing_substring(lines,'CONSERVE')

    if conserve_ind != -1:
        del lines[conserve_ind]
    trans_lines = []
    for trans in transitions:
        trans_lines.append('\tmat_1d({}, {}, ks, {}) = {};'.format(trans[0],trans[1],len(states),trans[2]))
        trans_lines.append('\tmat_1d({}, {}, ks, {}) = {};\n'.format(trans[1],trans[0],len(states),trans[3]))

    kin_tail = []
    for state,i in zip(states,range(len(states))):
        kin_tail.append('\t{} = yout[{}]/sum;'.format(state,i))

#FIND FUNC CALLS AND CALL THEM
    has_any_func_call = False
    for i in range(len(lines)):
        for j in range(len(func_names)):
            func_call_i = lines[i].find(' ' + func_names[j])
            if func_call_i > -1:
                has_any_func_call = True
                tmp_line = lines[i][:lines[i].rfind(')')]
                lines[i] = tmp_line + ',' + all_param_line_call_all + ');'
        lines = [s + '\n' for s in lines]
    close_brack_ind = index_containing_substring(lines,'}')
    if close_brack_ind>-1:
        del lines[close_brack_ind]
    c_kinetic_deriv_lines = first_line + '\n' + y_declare + '\n' + rates_declare+ '\n' + '\n'.join(kinetic_deriv_declares) + '\n'.join(lines) + '\n'.join(trans_lines) +'\n'.join(kin_body) + '\n'.join(kin_tail)+'}'
    tmp_lines = [re.sub("'", '_d', s) + ';' for s in lines]
    #add_deriv_lines = [s + '+=' + s + '_d*dt;' for s in states]
# Here above instead of <type 'list'>: ['c1+=c1_d*dt;', 'o+=o_d*dt;'] we need something like: 	y[0] = c1; y[1] = o;
    #c_deriv_lines = []
    #c_kinetic_deriv_lines = add_params_to_func_call(c_kinetic_deriv_lines, func_names, input_vars_c, all_param_line_call)
    tmp_line = ''
    # add_params_to_func_call(input,func_names,input_vars_c,all_param_line_call):
    call_to_deriv = 'DerivModel_' + model_name + '(dt, V[seg]' + states_params_str_seg + ');'

    #tmp_lines_cu = [re.sub('\t', '   ', s) for s in tmp_lines_cu]

#    if has_any_func_call:
#        c_deriv_lines_cu = first_line + '\n' + locals_line + '\n' + before_first_line_all + '\n' + ''.join(tmp_lines_cu)
#    else:
#        c_deriv_lines_cu = first_line + '\n' + locals_line + '\n' + ''.join(tmp_lines_cu)
    c_kinetic_deriv_lines_cu = c_kinetic_deriv_lines
    ind = c_kinetic_deriv_lines_cu.index('{')
    c_kinetic_deriv_lines_cu = '__device__ ' + re.sub('void\W*', 'void Cu', c_kinetic_deriv_lines_cu[0:ind+1]) + c_kinetic_deriv_lines_cu[ind + 1:]

    #return [c_kinetic_helper_lines, c_kinetic_deriv_lines, c_kinetic_init_lines, states, '']
    return [call_to_deriv, c_kinetic_deriv_lines, c_kinetic_deriv_lines_cu, deriv_declare]




def scan_kinetic_equation(equation):
    i = 0
    equation = equation.strip()
    lhs_end = equation.find('<')
    rhs_end = equation.find('(')
    param1_end = equation.find(',')
    param2_end = equation.find(')')
    state1 = equation[1:lhs_end].strip()
    state2 = equation[lhs_end + 3:rhs_end].strip()
    param1 = equation[rhs_end + 1:param1_end].strip()
    param2 = equation[param1_end + 1:param2_end].strip()
    return state1, state2, param1, param2


def handle_initial_block(lines, model_name, states_params_str, states_params_str_seg, proc_names, input_vars_c,all_param_line_call, before_first_line_all, all_param_line_call_all,writes):
    start = index_containing_substring(lines, 'INITIAL')
    [einit,eadvance] = get_ion_style()
    if start < -1:
        return []
    sumP = lines[start].count('{') - lines[start].count('}')
    currInd = start + 1
    while (sumP > 0):
        sumP = sumP + lines[currInd].count('{') - lines[currInd].count('}')
        currInd += 1
    end = currInd
    tmp = lines[start].find('}')
    if tmp > -1:
        lines = lines[start][tmp:].split(' ')
    else:
        lines = lines[start + 1:end]

    if 'eca' in states_params_str and 'cai' not in writes:
        if einit == 1:
            #lines.insert(0, 'eca = ktf/2 *log(DEF_cao / cai)')
            lines.insert(0, 'eca = ktf/2 *log(DEF_cao / cai)')
        else:
            lines.insert(0, 'eca =DEF_eca2')

    if 'cai' in writes:
        lines.insert(0,'eca = ktf/2 *log(DEF_cao / cai)')
        lines.insert(0,'cai = DEF_cai')

    if 'ica' in writes:
       if states_params_str.find('&eca') == -1:
            states_params_str = states_params_str + ',MYFTYPE &eca'
            states_params_str_seg = states_params_str_seg + ',eca [ seg ]'
       if states_params_str.find('cai') == -1:
            states_params_str = states_params_str + ', MYFTYPE &cai'
            states_params_str_seg = states_params_str_seg + ',cai [ seg ]'
       if einit == 1:
            #lines.insert(0,'eca = ktf/2 *log(DEF_cao / cai)')
            #lines.insert(0,'cai = DEF_cai')
            lines.insert(0,'eca = ktf/2 *log(DEF_cao / cai)')
            #lines.insert(0,'cai = DEF_cai')
       else:
           lines.insert(0, 'eca = DEF_eca2')
    states_params_str_seg = states_params_str_seg.replace('cai[seg]', 'cai [ seg ]')
    first_line = 'void InitModel_' + model_name + '(MYFTYPE v' + states_params_str + '){'
    init_declare = first_line[:-1] + ';'
    tmp_lines = [s + ';' for s in lines]

    tmp_ind = index_containing_substring(tmp_lines, 'SOLVE')
    if tmp_ind > -1:
        tmp_lines[tmp_ind] = '}'
    c_init_lines = [first_line] + tmp_lines
    c_init_lines = add_params_to_func_call(c_init_lines, proc_names, input_vars_c, all_param_line_call)
    call_to_init = 'InitModel_' + model_name + '(V[seg]' + states_params_str_seg + ');'
    tmp_lines_cu = tmp_lines
    var_def_line = ''
    has_proc_call = False
    tmp_lines_cu = [re.sub('\t', '   ', s) for s in tmp_lines_cu]
    for proc in proc_names:
        proc_ind = proc_names.index(proc)
        proc_ind_line = index_containing_substring(tmp_lines_cu, ' ' + proc)
        if proc_ind_line > -1:
            has_proc_call = True
            tmp_line = tmp_lines_cu[proc_ind_line][:tmp_lines_cu[proc_ind_line].rfind(')')]
            tmp_line = tmp_line.strip(' ')
            if tmp_line[-1] == '(':
                tmp_line =  tmp_line + ','.join(input_vars_c[proc_ind])
            tmp_lines_cu[proc_ind_line] = tmp_line + ',' + all_param_line_call_all + ');'

    tmpp = first_line[4:].strip(' ')
    tmpp = '__device__' + ' void Cu' + tmpp

    if has_proc_call:
        c_init_lines_cu = [tmpp] + [before_first_line_all] + tmp_lines_cu
    else:
        c_init_lines_cu = [tmpp] + tmp_lines_cu

    return [c_init_lines, c_init_lines_cu, init_declare, call_to_init]

def handle_deriv_block(mod_fn, lines, model_name, states_params_str, states, locals, all_parameters, all_out_vars,
                       conductances, func_names, input_vars_c, all_param_line_call, states_params_str_seg,
                       before_first_line_all, all_param_line_call_all):
    [einit, eadvance] = get_ion_style()
    start = index_containing_substring(lines, 'DERIVATIVE')
    if start < 0:
        call_to_deriv = ''
        c_deriv_lines = ['']
        c_deriv_lines_cu = []
        deriv_declare = ''
        return [call_to_deriv, c_deriv_lines, c_deriv_lines_cu, deriv_declare]

    sumP = lines[start].count('{') - lines[start].count('}')
    currInd = start + 1
    while (sumP > 0):
        sumP = sumP + lines[currInd].count('{') - lines[currInd].count('}')
        currInd += 1
    end = currInd
    tmp = lines[start].find('}')
    lines = lines[start + 1:end]

    first_line = 'void DerivModel_' + model_name + '(MYFTYPE dt, MYFTYPE v' + states_params_str + '){'
    derivs = [s + '_d,' for s in states]
    derivs[-1] = derivs[-1][:-1]
    second_line_x = FTYPESTR + ' '.join(derivs) + ';'
    tmp_vars = set(locals - set(all_parameters)) - set(set(all_out_vars) | set(conductances))
    locals_line = ''
    if tmp_vars:
        locals_line = [s + ',' for s in tmp_vars]
        locals_line = FTYPESTR + ' ' + ''.join(locals_line)
        locals_line = locals_line[:-1] + ';'
    deriv_declare = first_line[:-1] + ';'
    tmp_lines = [re.sub("'", '_d', s) + ';' for s in lines]
    add_deriv_lines = [s + '+=' + s + '_d*dt;' for s in states]

    c_file = './' + mod_fn[:-4] + C_SUFFIX
    with open(c_file) as f:
        lines_c = f.read().splitlines()
    c_start_line = index_containing_substring(lines_c, 'static int states (')
    if c_start_line == -1:
        c_start_line = index_containing_substring(lines_c, 'static int state (')
    for i, x in enumerate(lines_c):
        lines_c[i] = re.sub('_threadargscomma_', ' ', x)
        x = lines_c[i]
        lines_c[i] = re.sub('_threadargs_', '', x)

        if (i > c_start_line) & (x.find('return 0;') > -1):
            break

        c_end_line = i
    lines_c = lines_c[c_start_line:c_end_line]
    if not lines_c:
        lines_c = ['}']
    c_deriv_lines = []

    if len(lines_c) == 1:

        c_deriv_lines = [first_line] + lines_c
        tmp_lines_cu = [lines_c]
    else:
        c_deriv_lines = [first_line] + lines_c[1:] + ['}']
        tmp_lines_cu = lines_c[1:] + ['}']
    c_deriv_lines = add_params_to_func_call(c_deriv_lines, func_names, input_vars_c, all_param_line_call)
    tmp_line = ''
    # add_params_to_func_call(input,func_names,input_vars_c,all_param_line_call):
    call_to_deriv = 'DerivModel_' + model_name + '(dt, V[seg]' + states_params_str_seg + ');';
    tmp_lines_cu = [re.sub('\t', '   ', s) for s in tmp_lines_cu]
    has_any_func_call = False
    for i in range(len(tmp_lines_cu)):
        for j in range(len(func_names)):
            func_call_i = tmp_lines_cu[i].find(' ' + func_names[j])
            if func_call_i > -1:
                has_any_func_call = True
                tmp_line = tmp_lines_cu[i][:tmp_lines_cu[i].rfind(')')]
                tmp_line = tmp_line.strip(' ')
                if tmp_line[-1] == '(':
                    tmp_line = tmp_line + ','.join(input_vars_c[i])
                tmp_lines_cu[i] = tmp_line + ',' + all_param_line_call_all + ');'
        states_params_str_seg=states_params_str_seg.replace('cai[seg]', 'cai [ seg ]')
    cai_ind = states_params_str_seg.find('cai [ seg ]')
    if (cai_ind != -1):
        if eadvance == 1:
            #tmp_lines_cu.insert((len(tmp_lines_cu)-1) ,'eca = ktf/2 *log(DEF_cao / cai);')
            tmp_lines_cu.insert((len(tmp_lines_cu) - 1), 'eca = ktf/2 *log(DEF_cao / cai);')
        else:
            tmp_lines_cu.insert((len(tmp_lines_cu) - 1), 'eca = DEF_eca2;')
    tmp_lines_cu = [s + '\n' for s in tmp_lines_cu]
    if has_any_func_call:
        c_deriv_lines_cu = first_line + '\n' + locals_line + '\n' + before_first_line_all + '\n' + ''.join(tmp_lines_cu)
    else:
        c_deriv_lines_cu = first_line + '\n' + locals_line + '\n' + ''.join(tmp_lines_cu)
    ind = c_deriv_lines_cu.index('{')
    c_deriv_lines_cu = '__device__ ' + re.sub('void\W*', 'void Cu', c_deriv_lines[0]) + c_deriv_lines_cu[ind + 1:]
    return [call_to_deriv, c_deriv_lines, c_deriv_lines_cu, deriv_declare]


def handle_breakpoint_block(mod_fn, lines, model_name, states_params_str, ranges, all_states, all_params, gs,
                            non_spec_curr, writes, additional_writes, writes_no_current, ions, reversals, reads,
                            all_writes, all_assigned, states_params_str_seg, func_names, input_vars_c,
                            all_param_line_call):
    #Making sure gs are case sensitive
    for i in range(len(gs)):
        g = gs[i].lower()
        for curr_assigned in all_assigned:
            if curr_assigned.lower() == g:
                gs[i] = curr_assigned
    start = index_containing_substring(lines, 'BREAKPOINT')
    if start < 0:
        return []
    sumP = lines[start].count('{') - lines[start].count('}')
    if (sumP == 0):
        lines = [lines[start]]
    else:
        currInd = start + 1
        while (sumP > 0):
            sumP = sumP + lines[currInd].count('{') - lines[currInd].count('}')
            currInd += 1
        end = currInd

        lines = lines[start + 1:end]
    solve_line_ind = index_containing_substring(lines, 'SOLVE')
    if solve_line_ind < 0:
        print('no solve in breakpoint')
    else:
        [first, rest] = lines[solve_line_ind].strip(' \t').split(' ', 1)
        if "METHOD" in rest:
            [solve_what, rest] = rest.split(' ', 1)
            [tmp, rest] = rest.split(' ', 1)
            solve_method = rest.split(' ', 1)[0]
        else:
            solve_what = rest
            solve_method = "None"
        if (solve_method != 'cnexp') | (solve_method != 'sparse'):
            print ('Solve method not cnexp/sparse! in ' + model_name)
        del lines[solve_line_ind]
    lines = [re.sub('\s*', '', s) for s in lines]
    if 'eca' in states_params_str and 'cai' not in writes:
        lines.insert(0, 'eca = ktf/2 *log(DEF_cao / cai)')
    if 'ica' in writes:
        if states_params_str.find('&eca') == -1:
            states_params_str = states_params_str + ',MYFTYPE &eca'
            states_params_str_seg = states_params_str_seg + ',eca [ seg ]'
        if states_params_str.find('cai') == -1:
            states_params_str = states_params_str + ', MYFTYPE &cai'
            states_params_str_seg = states_params_str_seg + ',cai [ seg ]'
        lines.insert(0,'eca = ktf/2 *log(DEF_cao / cai)')
        lines.insert(0,'cai = DEF_cai')
    first_line = 'void BreakpointModel_' + model_name + '(MYSECONDFTYPE &sumCurrents, MYFTYPE &sumConductivity, MYFTYPE v' + states_params_str + ') {\n'
    break_point_declare = first_line[:-2] + ';'
    tmp_lines = [s + ';' for s in lines]


    c_file = './' + mod_fn[:-4] + C_SUFFIX
    with open(c_file) as f:
        lines_c = f.read().splitlines()
    c_start_line = index_containing_substring(lines_c, 'static double _nrn_current')
    if c_start_line == -1:
        print ("cant find a function in .c file")
    for i, x in enumerate(lines_c):
        lines_c[i] = re.sub('_threadargsproto_', ' ', x)
        lines_c[i] = re.sub('_threadargs_', ' ', x)
        lines_c[i] = re.sub('_threadargscomma_', ' ', x)
        if (i > c_start_line) & (x.find('current') > -1):
            break
        c_end_line = i
    lines_c = lines_c[c_start_line+1:c_end_line] + ['}']
    open_p = 0
    close_p = 0
    for ln in lines_c:
        open_p += ln.count('{')
        close_p += ln.count('}')
    if (close_p-open_p<1):
        lines_c.append(';\n}')
    dbl_inds = all_indices_containing_substring(lines_c,'double')
    for ind in dbl_inds:
        lines_c[ind] =lines_c[ind].replace('double',FTYPESTR)
    _l_inds = all_indices_containing_substring(lines_c, '_l')
    for ind in _l_inds:
        lines_c[ind] = lines_c[ind].replace('_l', '')
    if 'ica' in writes:
        ica_inds = all_indices_containing_substring(lines_c,'ica')
        for ind in ica_inds:
            lines_c[ind] = lines_c[ind].replace('ica', 'ica_'+ model_name)
        lines_c.insert(0, 'MYFTYPE ica_' + model_name + ';\n')

    if not lines_c:
        lines_c = ['}']
    else:
        tmp_lines = lines_c


    all_states = [s.strip('\t') for s in all_states]
    tmp_vars = (set(ranges) - set(all_params).union(all_states))
    tmp_vars = list(tmp_vars.union(set(gs)))
    #making sure none of the tmp_vars is in the signature
    for t in tmp_vars:
        t2 = 'MYFTYPE &'+ t
        if t2 in states_params_str:
            tmp_vars.remove(t)
    break_out_vars = set(writes)
    if (non_spec_curr):
        break_out_vars.add(non_spec_curr)
    break_out_vars = list(set(break_out_vars - set(additional_writes.union(writes_no_current))) )
    for var in break_out_vars:
        if var in tmp_vars:
            break_out_vars.remove(var)
    third_line = ''
    tmp_vars = [s + ',' for s in tmp_vars]
    second_line = FTYPESTR + ' ' + ' '.join(tmp_vars)
    second_line = second_line[:-1] + ';'
    if break_out_vars:
        third_line = [s + ',' for s in break_out_vars]
    third_line = FTYPESTR + ' ' + ' '.join(third_line)[:-1] + ';'
    current_names = list(set(['i' + s for s in ions]+['i']) & set(writes))
    if 'ica' in writes:
        ica_ind = index_containing_substring(current_names, 'ica')
        current_names[ica_ind] = current_names[ica_ind].replace('ica', 'ica_' + model_name)
    before_last_line = ''

    if current_names:
        before_last_line = 'sumCurrents+= ' + current_names[0] + ';'
        if (non_spec_curr):
            before_last_line = current_names[0] + ' = ' +non_spec_curr +';\n'+ before_last_line
        if 'ica' in writes:
            before_last_line = before_last_line + '\n ica += ica_' + model_name + ';'
    gs_set = set(['g' + s for s in ions]+ ['g' + s[0].upper() + s[1:] for s in ions] + ['g' + model_name])

    gs_set2 = all_assigned
    gs_set2.append('g')

    gs_names = []
    for s in gs_set:
        tmp_ind = index_containing_substring(gs_set2,s)
        if tmp_ind >-1:
            gs_names.append(gs_set2[tmp_ind])
    if model_name == 'pas':
        gs_names.append('g_pas')
    before_last_line2 = ''
    if gs_names:
        before_last_line2 = 'sumConductivity+= ' + gs_names[0] + ';'
    reads = set(reads)
    read_reversal = list(set(reversals) & reads)
    read_reversal_write = []

    if read_reversal:
        tmp = [s[1:] + 'i' for s in read_reversal]
        tmp = set(tmp).union(set([s[1:] + 'o' for s in read_reversal]))
        read_reversal_write = tmp & set(all_writes)
    nernst_line = []
    read_reversal_write = list(read_reversal_write)
    i_str = ''
    o_str = ''

    if read_reversal_write:
        nernst_line = [FTYPESTR + ' ' + read_reversal[0] + ';']
        i_str = read_reversal[0][1:] + 'i'
        o_str = read_reversal[0][1:] + 'o'
        if not set(i_str) & reads:
            i_str = 'DEF_' + i_str
        if not set(o_str) & reads:
            o_str = 'DEF_' + o_str
        z_str = '1.'
        if read_reversal[0][1:] == 'ca':
            z_str = '2.'

        nernst_line.append(read_reversal[0] + ' = nernst(' + i_str + ',' + o_str + ' ,' + z_str + ');')
    # for now removing nenrnst
    nernst_line = []
    if tmp_lines:
        c_break_lines = first_line + ''.join(nernst_line + tmp_lines[:-1]) + before_last_line + before_last_line2 + tmp_lines[-1]
        c_break_lines_cu = first_line + ''.join(
            re.sub('nernst', 'Cunernst', ''.join(nernst_line))) + second_line + third_line + ''.join(
            tmp_lines[:-1]) + before_last_line + before_last_line2 + tmp_lines[-1]
    else:
        c_break_lines = first_line + ''.join(nernst_line) + before_last_line + before_last_line2
        c_break_lines_cu = first_line + ''.join(re.sub('nernst', 'Cunernst', ''.join(nernst_line))) + second_line + third_line  + before_last_line + before_last_line2
    c_break_lines = [s + ';' for s in c_break_lines.split(';')]
    c_break_lines_cu = [s + ';' for s in c_break_lines_cu.split(';')]
    c_break_lines = add_params_to_func_call(c_break_lines, func_names, input_vars_c, all_param_line_call)
    c_break_lines_cu = add_params_to_func_call(c_break_lines_cu, func_names, input_vars_c, all_param_line_call)
    c_break_lines_cu[0] = '__device__ ' + re.sub('void\W*', 'void Cu', c_break_lines_cu[0])
    call_to_break = 'BreakpointModel_' + model_name + '(sumCurrents, sumConductivity, V[seg]' + states_params_str_seg + ');'

    call_to_break_dv = 'BreakpointModel_' + model_name + '(sumCurrentsDv, sumConductivityDv, V[seg]+0.001' + states_params_str_seg + ');'
    call_to_break_dv = call_to_break_dv.replace('ica [ seg ]','temp')

    return [break_point_declare, c_break_lines, c_break_lines_cu, call_to_break, call_to_break_dv]


def handle_neuron_block(lines):
    writes = []
    reads = []
    NSC = ''
    Useion = []
    range = []
    currglobal = ''
    start = index_containing_substring(lines, 'NEURON')
    end = index_containing_substring(lines[start:], '}')
    neuron_lines = lines[start + 1:(start + end)]
    for currline in neuron_lines:
        if len(currline.strip().split(' ', 1)) == 1:
            first = currline.strip().split(' ')[0]
            rest = ''
        else:
            [first, rest] = currline.strip().split(' ', 1)
        if first.find('SUFFIX') >= 0:
            suffix = rest.strip(' ')
        elif first.find('USEION') >= 0:
            [ion_name, rest] = rest.split(' ', 1)
            Useion.append(ion_name)
            Tmp = re.findall('.*WRITE(.*)', rest)
            if Tmp:
                writes = Tmp[0].split(',')
                writes = [x.strip(' ') for x in writes]
                Writes = writes
            Tmp = re.findall('READ(.*)WRITE.*', rest)
            if not Tmp:
                Tmp = re.findall('READ(.*)', rest)
            if Tmp:
                reads = Tmp[0].split(',')
                reads = [x.strip(' ') for x in reads]
            else:
                reads = []
        elif first.find('NONSPECIFIC_CURRENT') >= 0:

            NSC = rest.strip(' ')
            Writes = ['i']
            writes = Writes
            Reads = []
            Useion = ''
        elif first.find('RANGE') >= 0:

            Tmp = rest.split(',')
            currrange = [x.strip(' ') for x in Tmp]
            ranges = currrange
            # print currrange
        elif first.find('GLOBAL') >= 0:

            Tmp = rest.split(',')
            currglobal = [x.strip(' ') for x in Tmp]

            # print currglobal
        else:
            print('unknown' + currline)
    return [suffix, currglobal, Useion, NSC, reads, writes, ranges]


def handle_assigned_block(lines):
    start = index_containing_substring(lines, 'ASSIGNED')

    end = index_containing_substring(lines[start:], '}')
    assigned_lines = lines[start + 1:(start + end)]
    all_assigned = []
    for line in assigned_lines:
        line = re.sub(r'\([^)]*\)', '', line)
        tmp = line.split(' \t')
        for s in tmp:
            s = re.sub('\s+', '', s)
            if len(s) > 0:
                all_assigned.append(s)
    return all_assigned


def handle_state_block(lines,writes):
    # print lines
    states = []
    all_states = []
    all_state_line = ''
    all_state_line_seg = ''
    start = index_containing_substring(lines, 'STATE')
    if start == -1:
        return [all_state_line, all_state_line_seg, states]
    end = index_containing_substring(lines[start:], '}')
    if end == 0:
        states_line = lines[start:(start + end + 1)][0]
        all_states = re.search('\{(.*?)\}', states_line).group(1)
        all_states = all_states.strip(' ')
        states = all_states.split(' ')
        states = [x.strip(' ') for x in states]
    else:
        states_line = lines[(start + 1):(start + end)]
        states_line = [re.sub(r'\([^)]*\)', '', line) for line in states_line]
        states_line = [line.strip(' ') for line in states_line]
        states_line = [line.strip('\t') for line in states_line]
        states_line = [line.split(' ')[0] for line in states_line]
        states = [x.strip(' ') for x in states_line]
    states = [s for s  in states if len(s)>0]
    #for w in writes:
    #    if w in states:
     #       states.remove(w)
    if len(states) > 0:
        all_state_line = ['MYFTYPE &' + s + ',' for s in states]
        all_state_line = ''.join(all_state_line)
        all_state_line = all_state_line[:-1]
        all_state_line_seg = ''
        for x in range(0, len(states)):
            if states[x] in not_states:
                all_state_line_seg = all_state_line_seg + states[x] + '[seg] ,'
            else:
                all_state_line_seg = all_state_line_seg + 'StatesM[' + str(x + StateStartVal) + '][seg] ,'

        all_state_line_seg = all_state_line_seg[:-1]
    return [all_state_line, all_state_line_seg, states]


def handle_params_block(lines, globals):
    params = []
    new_params_lines = []
    new_params_lines_with_values = []
    all_params_line = str(0)
    all_params_line_seg = []
    c_param_lines = []
    all_param_line_declare = ''
    all_params_line_call = ''
    start = index_containing_substring(lines, 'PARAMETER')
    if start == -1:
        return params
    end = index_containing_substring(lines[start:], '}')
    if end == 0:
        params_line = lines[start:(start + end + 1)][0]
        all_params = re.search('\{(.*?)\}', params_line).group(1)
        all_params = all_params.strip(' ')
        params = all_params.split(' ')
        params = [x.strip(' ') for x in params]
    else:

        params_line = lines[(start + 1):(start + end)]
        params_line = [re.sub(r'\([^)]*\)|<[^)]*\>', '', line) for line in params_line]
        indices = [i for i, x in enumerate(params_line) if re.search('.*=.*', x)]
        for i in indices:
            params_line[i] = params_line[i].strip(' \t')
            new_params_lines.append(params_line[i].split('=', 1)[0])
            new_params_lines_with_values.append(params_line[i])
        new_params_lines = [line.split(' ')[0] for line in new_params_lines]
        params = [x.strip(' \t') for x in new_params_lines]

        global_inds = []
        not_global_inds = []
        for i in range(len(params)):
            if params[i] in globals:
                global_inds.append(i)
                c_param_lines.append(FTYPESTR + ' ' + new_params_lines_with_values[i] + ';')
            else:
                not_global_inds.append(i)

        c_globals_not_predefined = list(set(globals) - set(params))
        for e in c_globals_not_predefined:
            c_param_lines.append(FTYPESTR + ' ' + e + ';')
        all_params = params + c_globals_not_predefined

        if params:
            all_params_line = [FTYPESTR + ' ' + params[i] + ',' for i in not_global_inds]
            all_params_line = ''.join(all_params_line)[:-1]
            for x in range(0, len(not_global_inds)):
                all_params_line_seg.append('ParamsM[' + str(x + ParamStartVal) + '][comp],')
            all_params_line_seg = ''.join(all_params_line_seg)[:-1]
            all_param_line_declare = ',' + all_params_line
            all_params_line_call = [params[i] + ',' for i in not_global_inds]
            all_params_line_call = ''.join(all_params_line_call)[:-1]
    return [all_params_line, all_params_line_seg, c_param_lines, all_param_line_declare, all_params_line_call,
            all_params, global_inds, not_global_inds]


def handle_mod_function(lines, model_name):
    func_names = []
    func_names_cu = []
    c_func_lines = []
    c_func_lines_cu = []
    input_vars = []
    indices = [i for i, x in enumerate(lines) if "FUNCTION" in x]
    for start in indices:
        sumP = lines[start].count('{') - lines[start].count('}')
        currInd = start + 1
        while (sumP > 0):
            sumP = sumP + lines[currInd].count('{') - lines[currInd].count('}')
            currInd += 1
        end = currInd
        output = parse_mod_function(lines[start:end])
        func_names.append(output[0])
        func_names_cu.append('Cu' + output[0])
        c_func_lines.append(output[1])
        input_vars.append(output[2])
        c_func_lines_cu.append(copy.deepcopy(output[1]))

        for i in range(len(c_func_lines_cu)):
            c_func_lines_cu[i][0] = (
                        '__device__ ' + re.sub(output[0], 'Cu' + output[0] + '_' + model_name, output[1][0]))
    return [func_names, c_func_lines, input_vars, c_func_lines_cu]


def parse_mod_function(lines):
    p_ind = lines[0].find('(')
    func_name = lines[0][9:p_ind]
    input_vars = re.search('\((.*?)\)', lines[0]).group(1)
    input_vars = input_vars.split(',')
    input_vars = ['MYFTYPE ' + s + ',' for s in input_vars]
    input_vars = ''.join(input_vars)
    input_vars = input_vars[:-1]
    c_func_lines = [FTYPESTR + ' ' + func_name + '(' + input_vars + '){']
    for line in lines[1:]:
        c_func_lines.append(re.sub(func_name + '\W*=', 'return ', line.strip(' ')) + ';')

    # print c_func_lines
    return [func_name, c_func_lines, input_vars]


def handle_mod_procedures(mod_fn,lines, model_name, all_param_line_declare, globals, all_params_line_call):
    indices = [i for i, x in enumerate(lines) if "PROCEDURE" in x]
    out_vars_c = []
    func_names = []
    input_vars_c = []
    list_of_out_vars = []
    proc_declare = []
    all_c_proc_lines = []
    proc_declare_cu = []
    all_c_proc_lines_cu = []
    all_params_line_call_c = []
    all_out_vars = set()
    out_vars = []
    local_vars = []
    for start in indices:
        sumP = lines[start].count('{') - lines[start].count('}')
        currInd = start + 1
        while (sumP > 0):
            sumP = sumP + lines[currInd].count('{') - lines[currInd].count('}')
            currInd += 1
        end = currInd
        output = parse_mod_proc(mod_fn,lines[start: end + 1], all_param_line_declare, globals, all_params_line_call)
        # out_vars, func_name, input_vars, before_first_line, first_line, c_local_line, f_lines, params_line_call_c,local_vars)
        out_vars = output[0]
        out_vars_c.append(output[0])
        func_names.append(output[1])
        input_vars = output[2]
        input_vars_c.append(input_vars)
        list_of_out_vars.append(output[3])
        first_line = output[4]
        c_local_line = output[5]
        f_lines = output[6]
        all_params_line_call_c.append(output[7])
        # local_vars.append(output[8])
        flat_f_lines = [v for v in f_lines]
        # flat_f_lines = ''.join(flat_f_lines)
        c_proc_lines = [first_line]
        for v in flat_f_lines:
            c_proc_lines.append(v)
        all_c_proc_lines.append(c_proc_lines)
        curr_proc_declare = first_line[:-2] + ';'
        proc_declare.append(curr_proc_declare)
        proc_declare_cu.append(curr_proc_declare[:curr_proc_declare.find(')')] + end_str + ');')
        first_line_cu = proc_declare_cu[-1][:-1] + ' {'
        c_proc_lines_cu = [first_line_cu]
        for v in flat_f_lines:
            c_proc_lines_cu.append(v)
        all_c_proc_lines_cu.append(c_proc_lines_cu)
    all_out_vars = all_out_vars.union(out_vars)
    all_out_vars = all_out_vars.difference(globals)
    all_out_vars = list(all_out_vars)
    all_out_vars.sort()
    tmp_str = ''
    # tmp = [FTYPESTR + ' &' + v +',' for v in all_out_vars]
    # tmp = tmp[:-1]
    tmp = ''
    tmp2 = ''
    before_first_line_all = ''
    for s in all_out_vars:
        tmp2 = tmp2 + s + ','
        tmp_str = tmp_str + FTYPESTR + ' &' + s + ','
        before_first_line_all = before_first_line_all + tmp + s
        tmp = ','
    tmp_str = tmp_str[:-1]
    str_of_out_vars = before_first_line_all
    before_first_line_all = FTYPESTR + ' ' + before_first_line_all + ';'
    seperator = ','
    if not all_out_vars:
        seperator = ''
    all_param_line_call_all = all_params_line_call + seperator + tmp2[:-1]
    for i in range(len(indices)):
        c_proc_lines = all_c_proc_lines[i]
        proc_declare_cu[i] = '__device__ ' + proc_declare_cu[i].replace(end_str, seperator + tmp_str)
        proc_declare_cu[i] = re.sub('void\W*', 'void Cu', proc_declare_cu[i])
        proc_declare_cu[i] = re.sub('\W*\(', '_' + model_name + '(', proc_declare_cu[i])

        out = add_params_to_func_call(c_proc_lines[1:], func_names, input_vars_c, all_params_line_call)
        # print 'out is'
        # print out
        c_proc_lines = [c_proc_lines[0]]
        for s in out:
            c_proc_lines.append(s)
        all_c_proc_lines[i] = c_proc_lines
        curr_c_proc_cu = all_c_proc_lines_cu[i][0]
        curr_c_proc_cu = '__device__ ' + curr_c_proc_cu.replace(end_str, seperator + tmp_str)
        curr_c_proc_cu = re.sub('void\W*', 'void Cu', curr_c_proc_cu)
        curr_c_proc_cu = re.sub('\W*\(', '_' + model_name + '(', curr_c_proc_cu)
        all_c_proc_lines_cu[i][0] = curr_c_proc_cu
    for k in range(len(indices)):
        tmp_lines_cu = all_c_proc_lines_cu[k][1:]
        for i in range(len(tmp_lines_cu)):
            for j in range(len(func_names)):
                func_call_i = tmp_lines_cu[i].find(func_names[j])
                if func_call_i > -1:
                    tmp_line = tmp_lines_cu[i][:tmp_lines_cu[i].rfind(')')]

                    tmp_lines_cu[i] = tmp_line + ',' + all_params_line_call_c[j] + ');'

        all_c_proc_lines_cu[k][1:] = tmp_lines_cu

    return [str_of_out_vars, before_first_line_all, all_c_proc_lines, all_c_proc_lines_cu, func_names, input_vars_c,
            all_out_vars, proc_declare, proc_declare_cu, all_param_line_call_all]
    # return [out_vars_c,func_names,input_vars_c,list_of_out_vars,proc_declare,all_c_proc_lines,proc_declare_cu,c_proc_lines_cu ]


def parse_mod_proc(mod_fn,lines, all_param_line_declare, globals, all_params_line_call):
    c_local_line = ''
    before_first_line = ''
    local_vars = []

    local_line_ind = index_containing_substring(lines, 'LOCAL')
    if local_line_ind > -1:
        local_var_line = lines[local_line_ind]
        local_var_line = local_var_line[local_var_line.index('LOCAL') + 6:]
        local_vars = local_var_line.strip(' ').split(',')
        local_vars = [x.strip(' ') for x in local_vars]
        c_local_line = FTYPESTR + ' ' + local_var_line + ';'
    assign_lines_ind = [i for i, x in enumerate(lines) if "=" in x]
    bool_checks_inds = all_indices_containing_substring(lines,'==')
    for i in bool_checks_inds:
        assign_lines_ind.remove(i)
    updated_var = []
    updated_var = [lines[i].strip(' \t').split('=')[0].strip(' ') for i in assign_lines_ind]
    updated_var = set(updated_var)
    out_vars = list(set(updated_var) - set(local_vars))
    proc_line = lines[0][lines[0].index('PROCEDURE') + 10:]
    func_name = proc_line.replace('(', ' ').split()[0]
    c_file = './' + mod_fn[:-4] + C_SUFFIX
    with open(c_file) as f:
        lines_c = f.read().splitlines()
    c_lines = all_indices_containing_substring(lines_c, func_name)
    for start_ind in c_lines:
        tmp = lines_c[start_ind]
        if 'static int' in tmp:
            c_start_line = start_ind
    if c_start_line == -1:
        print ("cant find a function in .c file")
    for i, x in enumerate(lines_c):
        lines_c[i] = re.sub('_threadargsproto_', ' ', x)
        lines_c[i] = re.sub('_threadargs_', ' ', x)
        lines_c[i] = re.sub('_threadargscomma_', ' ', x)

        if (i > c_start_line) & (x.find('return 0;') > -1):
            break

        c_end_line = i
    lines_c = lines_c[c_start_line + 1:c_end_line + 1] + ['}']
    rest_line = proc_line[proc_line.index('(') + 1:]
    rest_line = re.sub('\(.*?\)', '', rest_line)
    rest_line = rest_line[:rest_line.index(')')]
    input_vars = rest_line.split(',')
    input_vars = [x for x in input_vars if x ]
    v_index = index_containing_substring(input_vars, 'v')
    is_v_in_proc = index_containing_substring(lines_c,' v ') > -1
    if (v_index == -1 and is_v_in_proc ):
        input_vars.append('v')
    if 'v' in out_vars:
        out_vars.remove('v')
    for var in input_vars:
        if var in out_vars:
            #input_vars.remove(var) trying something elsr
            out_vars.remove(var)

    first_line = 'void ' + func_name + '('
    for i in range(len(input_vars)):
        tmp = ''
        if i > 0:
            tmp = ','
        first_line = first_line + tmp + FTYPESTR + ' ' + input_vars[i]
    first_line = first_line + all_param_line_declare + ') {'
    before_first_line = ''
    for i in range(len(out_vars)):
        tmp = ''
        if i > 0:
            tmp = ','
            before_first_line = before_first_line + tmp + out_vars[i]
    before_first_line = FTYPESTR + ' ' + before_first_line + ';'
    lines = lines[1:]
    indices = [i for i, x in enumerate(lines) if re.search('UNITSOFF|LOCAL|TABLE', x)]

    dbl_inds = all_indices_containing_substring(lines_c,'double')
    for ind in dbl_inds:
        lines_c[ind] =lines_c[ind].replace('double',FTYPESTR)
    _l_inds = all_indices_containing_substring(lines_c, '_l')
    for ind in _l_inds:
        lines_c[ind] = lines_c[ind].replace('_l', '')
    if not lines_c:
        lines_c = ['}']
    f_lines = [v.strip(' ') + ';' for i, v in enumerate(lines) if i not in indices]
    if local_line_ind > -1:
        local_lines = lines[local_line_ind]
    out_vars_no_globals = list(set(out_vars) - set(globals))
    out_vars_no_globals.sort()
    tmp = ''
    out_vars_no_globals = [tmp.join(v.strip(' /t')) + ',' for v in out_vars_no_globals]
    out_vars_no_globals = ''.join(out_vars_no_globals)

    separtor = ','
    if not out_vars_no_globals:
        separtor = ''
    params_line_call_c = all_params_line_call + separtor + out_vars_no_globals[:-1]

    return (out_vars, func_name, input_vars, before_first_line, first_line, c_local_line, lines_c, params_line_call_c,
            local_vars)

    ### Helpers ###


def printMatrix(testMatrix):
    for row in testMatrix:
        print (row)


def add_model_name_to_function(input, src, trg):
    output = input
    if isinstance(input, str):
        for j in range(len(src)):
            output = re.sub(r'(^|\W)(' + src[j] + ')(\W)', r'\1' + trg[j] + r'\3', output)
    else:
        for i in range(len(input)):
            for j in range(len(src)):
                output[i] = re.sub(r'(^|\W)(' + src[j] + ')(\W)', r'\1' + trg[j] + r'\3', output[i])
    return output


def remove_globals_recalculation(input, nglobals):
    output = input
    for i in range(len(input)):

        if output[i]:
            if isinstance(input[i], str):
                for g in nglobals:
                    output[i] = re.sub('(^|\W)' + g + '\W*=.*?;', '/* removed ' + g + ' recalculation */', output[i])
            else:
                output[i] = remove_globals_recalculation(output[i], nglobals)
    return output

def replace_pow(input):
    output = input
    for i in range(len(input)):
        curr_str = input[i]
        if isinstance(curr_str, str):
            output[i] = curr_str.replace('pow','powf')
            ind = curr_str.find('^')
            input[i].replace('}', ';}')
            if ind > -1:
                f2 = curr_str.find('=')
                f3 = curr_str.find(';')
                output[i] = curr_str[:f2 + 1] + 'pow((MYFTYPE)' + curr_str[f2 + 1:ind] + ',(MYFTYPE)' + curr_str[
                                                                                                        ind + 1:f3] + ');'

        else:
            replace_pow(input[i])
    return output



def file_to_list_no_comments(FN):
    with open(FN) as f:
        lines = f.read().splitlines()
    indices = [i for i, x in enumerate(lines) if re.search('.*:.*', x)]
    for i in indices:
        lines[i] = lines[i].split(':', 1)[0]
    lines = list(filter(lambda a: a.find(':') == -1, lines))
    comment_block_start = index_containing_substring(lines, 'COMMENT')
    comment_block_end = index_containing_substring(lines, 'ENDCOMMENT')
    if comment_block_start != -1:
        del lines[comment_block_start:comment_block_end + 1]
    indices = [i for i, x in enumerate(lines) if re.search('.*FROM.*TO.*', x)]
    for i in indices:
        from_ind = lines[i].find('FROM')
        lines[i] = lines[i][:from_ind]
    indices = [i for i, x in enumerate(lines) if re.search('.*DEPEND.*', x)]
    lines = [v for i, v in enumerate(lines) if i not in indices]
    indices = [i for i, x in enumerate(lines) if re.search('.*UNITSON.*', x)]
    lines = [v for i, v in enumerate(lines) if i not in indices]
    indices = [i for i, x in enumerate(lines) if re.search('.*UNITSOFF.', x)]
    lines = [v for i, v in enumerate(lines) if i not in indices]
    lines = [v for i, v in enumerate(lines) if not v == '']
    units_start = index_containing_substring(lines, 'UNITS')  # Removing for now can't see why we need them
    units_end = index_containing_substring(lines[units_start:], '}') + units_start
    units_strs = []
    for line in lines[units_start:units_end + 1]:

        tmp = re.findall('\W*(\(.*\))\W*=.*', line)
        if tmp:
            units_strs.append(tmp[0])
    units_strs.append('(degC)')
    del lines[units_start:units_end + 1]
    for unit in units_strs:
        lines = [x.replace(unit, '') for x in lines]
    # lines = [re.sub(r'\([^)]*\)', '', line) for line in lines]# get rid of (**)
    return lines


def get_ion_style():
    eadvance = int(nrn.h.calc_eca)
    einit=int(nrn.h.calc_eca)
    return [einit,eadvance]


def get_mech_list():
    mech_names = []
    mechlist = nrn.h.MechanismType(0)  # object that contains all mechanism names not sure we need this
    for i in range(int(mechlist.count())):
        s = nrn.h.ref('')  # string reference to store mechanism name
        mechlist.select(i)
        mechlist.selected(s)
        mech_names.append(s[0])
    return mech_names

def all_indices_containing_substring(the_list, substring):
    ans = []
    for i, s in enumerate(the_list):
        if substring in s:
            ans.append(i)
    return ans

def index_containing_substring(the_list, substring):
    for i, s in enumerate(the_list):
        if substring in s:
            return i
    return -1
def index_containing_string_from_list(the_list, string):
    for i, s in enumerate(the_list):
        if s in string:
            return i
    return -1

def add_params_to_func_call(input, func_names, input_vars_c, all_param_line_call):
    out = input
    end_i = 0
    seperator = ''
    for i in range(len(input)):
        curr_line = out[i]
        for j in range(len(func_names)):
            func_call_i = curr_line.find(' ' + func_names[j])
            if func_call_i == -1:
                func_call_i = curr_line.find('\t' + func_names[j])
                if func_call_i == -1:
                    continue

            cur_ends_i = [m.start() for m in re.finditer('\\)', curr_line)]
            end_i = -1
            for k in cur_ends_i:
                if k > func_call_i:
                    end_i = k
                    break
            seperator = ','
            if not input_vars_c:
                seperator = ''
            new_curr_line = curr_line[:end_i] + seperator + all_param_line_call + curr_line[end_i:]
            curr_line = new_curr_line
        out[i] = curr_line
    return out


def runPyNeuroGPU():
    if (os.path.exists(run_dir)):
        shutil.rmtree(run_dir + '/')
    print (vs_root)
    print (run_dir)
    shutil.copytree(vs_root, run_dir)
    if (os.path.exists(run_dir + "/Data")):
        shutil.rmtree(run_dir + "/Data")
    os.makedirs(run_dir + "/Data")
    temp = data_dir + 'BasicConst*.csv'
    print (temp)
    for file in glob.glob(temp):
        print(file)
        shutil.copy(file, run_dir + "/Data/")
    shutil.copy(data_dir + 'AllParams.csv', run_dir + "/Data/")
    shutil.copy(data_dir + 'AllStates.csv', run_dir + "/Data/")

    shutil.copy(data_dir + "/Sim.csv", run_dir + "/Data/")
    # shutil.copy(data_dir+'Stim.dat',run_dir +"/Data/")
    #shutil.copy(data_dir + 'StimF.dat', run_dir + "/Data/")
    shutil.copy(data_dir + 'Stim_raw.csv', run_dir + "/Data/")
    shutil.copy(data_dir + 'times.csv', run_dir + "/Data/")
    shutil.copy(data_dir + 'Stim_meta.csv', run_dir + "/Data/")

    for filename in glob.glob(os.path.join('./CParsed/', '*.*')):
        shutil.copy(filename, run_dir + "/NeuroGPU6/")
#    shutil.copy(data_dir + 'try.bat', run_dir)
def linux_packing():
    file_for_linux = ['kernel.cu','MainC.cu','Makefile','Util.cu','Util.h','CudaStuff.cu','CudaStuff.cuh']
    if (os.path.exists(unix_dir)):
        shutil.rmtree(unix_dir)
    os.makedirs(unix_dir)
    src_loc = unix_dir + "/src"
    os.makedirs(src_loc)
    for fn in file_for_linux:
        fn = vs_root + '/NeuroGPU6/' +fn
        print(fn)
        shutil.copy(fn, src_loc)
    if (os.path.exists(unix_dir + "/Data")):
        shutil.rmtree(unix_dir + "/Data")
    os.makedirs(unix_dir + "/Data")
    temp = data_dir + 'BasicConst*.csv'
    print (temp)
    for file in glob.glob(temp):
        print(file)
        shutil.copy(file, unix_dir + "/Data/")
    shutil.copy(data_dir + 'AllParams.csv', unix_dir + "/Data/")
    shutil.copy(data_dir + 'AllStates.csv', unix_dir + "/Data/")

    shutil.copy(data_dir + "/Sim.csv", unix_dir + "/Data/")
    # shutil.copy(data_dir+'Stim.dat',run_dir +"/Data/")
    #shutil.copy(data_dir + 'StimF.dat', unix_dir + "/Data/")
    shutil.copy(data_dir + 'Stim_raw.csv', unix_dir + "/Data/")
    shutil.copy(data_dir + 'times.csv', unix_dir + "/Data/")
    shutil.copy(data_dir + 'Stim_meta.csv', unix_dir + "/Data/")
    for filename in glob.glob(os.path.join('./CParsed/', '*.*')):
        shutil.copy(filename, src_loc)


# ========================================================================
# AllParams_refence.csv generation utility function
def make_allparams_reference():
    ref_file = data_dir + '/AllParams_reference.csv'
    allparams = data_dir + '/AllParams.csv'
    old_ref_exists = os.path.exists(ref_file)
    new_ref_exists = os.path.exists(allparams)
    if old_ref_exists and new_ref_exists:
        os.system('rm ' + ref_file)
        os.system('cp ' + allparams + ' ' + ref_file)
# ========================================================================


def main():
    global sec_list
    global baseDir
    global vs_dir
    global vs_root
    nrn.h.load_file(1, modelFile)
    if not os.path.exists(data_dir):
        os.makedirs(data_dir)

    vs_dir = nrn.h.base + '/VS/pyNeuroGPU_win/NeuroGPU6'
    vs_root = nrn.h.base + '/VS/pyNeuroGPU_win/'
    baseDir = nrn.h.base
    vs_root = baseDir + '/VS/pyNeuroGPU_win/'

    # -----------------------------------------------------------------------------------------
    # nrn.h.base = "C:/Users/mdera/OneDrive/Desktop/Neuro/NeuroGPU_Base"
    #nrn.h.base = "C:/Users/Maxwell Chen/Desktop/NeuroGPU/NeuroGPU_Base"
    vs_dir = nrn.h.base + '/VS/pyNeuroGPU_win/NeuroGPU6'
    vs_root = nrn.h.base + '/VS/pyNeuroGPU_win/'
    baseDir = nrn.h.base
    vs_root = baseDir + '/VS/pyNeuroGPU_win/'
    # -----------------------------------------------------------------------------------------

    # thread = nrn_dll_sym('nrn_threads', ctypes.POINTER(NrnThread))
    sec_list = create_sec_list()
    rec_sites = write_sim()

    # topo = get_topo()  # dictionary whose keys are section names
    # output = get_topo_mdl()  # dictionary whose keys are section names, and available mechanisms
    # topo_mdl = output[0]
    p_size_set = nrn.h.psize
    param_set = nrn.h.paramsFile
    # recsites = get_recsites()  # list of section names
    # mod_file_map = get_mod_file_map(topo_mdl.available_mechs) # dictionary whose keys are mechanisms suffixs and values are their .mod file name=
    mechanisms = parse_models()
    seg_start = mechanisms[-2]
    seg_end = mechanisms[-1]


    write_stim(rec_sites,seg_start,seg_end)
    print ("done with parse_models")
    
    # def tail_end(f, n_params, call_to_init_str_cu, call_to_deriv_str_cu, call_to_break_str_cu, call_to_break_dv_str_cu,params_m, n_segs_mat, cm_vec, vs_dir, has_f, nd, nrhs):
    runPyNeuroGPU()
    linux_packing()
    make_allparams_reference()
    print('created new reference file')



if __name__ == '__main__':
    main()
