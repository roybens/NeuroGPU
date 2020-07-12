import ctypes

class Prop(ctypes.Structure):
    pass 

Prop._fields_ = [("next", ctypes.POINTER(Prop)),
                ("type", ctypes.c_short),
                ("unused1", ctypes.c_short),
                ("param_size", ctypes.c_int),
                ("param", ctypes.POINTER(ctypes.c_double)),
                ("dparam", ctypes.c_void_p), # should be Datum*
                ("_alloc_seq", ctypes.c_long),
                ("ob", ctypes.c_void_p), # should be Object*
                ]

class Node(ctypes.Structure):
    pass

Node._fields_ = [("_v", ctypes.c_double),
                ("_area", ctypes.c_double),
                ("_a", ctypes.c_double),
                ("_b", ctypes.c_double), # first 4 fields may be different based on CACHEVEC
                ("_d", ctypes.POINTER(ctypes.c_double)),
                ("_rhs", ctypes.POINTER(ctypes.c_double)),
                ("_a_matelm", ctypes.POINTER(ctypes.c_double)),
                ("_b_matelm", ctypes.POINTER(ctypes.c_double)),
                ("eqn_index_", ctypes.c_int),
                ("prop", ctypes.POINTER(Prop)), # should be Prop*
                ("child", ctypes.c_void_p), # should be Section*
                ("sec", ctypes.c_void_p), # should be Section*
                # fields further down in the struct may or may not exist depending on macro conditionals
                ("_classical_parent", ctypes.c_void_p), # should be Node*
                ("_nt", ctypes.c_void_p), # should be NrnThread*
                ("extnode", ctypes.c_void_p), # should be Extnode*
                ("v_node_index", ctypes.c_int)
                ]

"""
hocdec.h
"""
class Datum(ctypes.Union):
    pass

Datum._fields_ = [("val", ctypes.c_double),
                    ("sym", ctypes.c_void_p), # should be Symbol*
                    ("i", ctypes.c_int),
                    ("pval", ctypes.POINTER(ctypes.c_double)),
                    ("pobj", ctypes.c_void_p), # should be HocStruct Object **
                    ("obj", ctypes.c_void_p), # should be HocStruct Object *
                    ("pstr", ctypes.POINTER(ctypes.c_char_p)),
                    ("itm", ctypes.c_void_p), # should be HocStruct hoc_Item*
                    ("lst", ctypes.c_void_p), # should be hoc_List*
                    ("_pvoid", ctypes.c_void_p)]
"""
nrnoc_ml.h
"""
class Memb_list(ctypes.Structure):
    pass

Memb_list._fields_ = [("nodelist", ctypes.POINTER(ctypes.POINTER(Node))), 
                        ("nodeindices", ctypes.POINTER(ctypes.c_int)), # inside an if directive, might not actually exist
                        ("data", ctypes.POINTER(ctypes.POINTER(ctypes.c_double))),
                        ("pdata", ctypes.POINTER(ctypes.POINTER(Datum))), 
                        ("prop", ctypes.POINTER(ctypes.POINTER(Prop))),
                        ("_thread", ctypes.POINTER(Datum)), 
                        ("nodecount", ctypes.c_int)]
"""
multicore.h
"""
class NrnThreadMembList(ctypes.Structure):
    pass

NrnThreadMembList._fields_ = [("next", ctypes.POINTER(NrnThreadMembList)),
                                ("ml", ctypes.POINTER(Memb_list)), 
                                ("index", ctypes.c_int)]

"""
multicore.h
"""
class NrnThread(ctypes.Structure):
    pass 

NrnThread._fields_ = [("_t", ctypes.c_double),
                ("_dt", ctypes.c_double),
                ("cj", ctypes.c_double),
                ("tml", ctypes.POINTER(NrnThreadMembList)), # should be NrnThreadMembList*
                ("ncell", ctypes.c_int),
                ("end", ctypes.c_int), # 1 + position of last node in v_node array
                ("id", ctypes.c_int),
                ("_stop_stepping", ctypes.c_int),
                ("_actual_rhs", ctypes.POINTER(ctypes.c_double)),
                ("_actual_d", ctypes.POINTER(ctypes.c_double)),
                ("_actual_a", ctypes.POINTER(ctypes.c_double)),
                ("_actual_b", ctypes.POINTER(ctypes.c_double)),
                ("_actual_v", ctypes.POINTER(ctypes.c_double)),
                ("_actual_area", ctypes.POINTER(ctypes.c_double)),
                ("_v_parent_index", ctypes.POINTER(ctypes.c_int)),
                ("_v_node", ctypes.POINTER(ctypes.POINTER(Node))), # Node**
                ("_v_parent", ctypes.POINTER(ctypes.POINTER(Node))), # Node**
                ("_sp13mat", ctypes.c_char_p),
                ("_ecell_memb_list", ctypes.c_void_p), # should be Memb_list*
                ("_nrn_fast_imem", ctypes.c_void_p), # should be _nrn_Fast_Imem*
                ("_vcv", ctypes.c_void_p)
                ]


