/* Created by Language version: 6.2.0 */

#undef DISABLE_OPENACC
#define DISABLE_OPENACC

/* VECTORIZED */
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#undef PI
 
#include "coreneuron/utils/randoms/nrnran123.h"
#include "coreneuron/nrnoc/md1redef.h"
#include "coreneuron/nrnconf.h"
#include "coreneuron/sim/multicore.hpp"
#include "coreneuron/nrniv/nrniv_decl.h"
#include "coreneuron/utils/ivocvect.hpp"
#include "coreneuron/utils/nrnoc_aux.hpp"
#include "coreneuron/gpu/nrn_acc_manager.hpp"
#include "coreneuron/mechanism/mech/cfile/scoplib.h"

#include "coreneuron/sim/scopmath/newton_struct.h"
#include "coreneuron/nrnoc/md2redef.h"
#include "coreneuron/mechanism/register_mech.hpp"
#include "_kinderiv.h"
#if !NRNGPU
#if !defined(DISABLE_HOC_EXP)
#undef exp
#define exp hoc_Exp
#endif
#endif
 #define _threadargsproto_namespace int _iml, int _cntml_padded, double* _p, coreneuron::Datum* _ppvar, coreneuron::ThreadDatum* _thread, coreneuron::NrnThread* _nt, double v
 static void bbcore_read(double *, int*, int*, int*, _threadargsproto_namespace);
 static void bbcore_write(double *, int*, int*, int*, _threadargsproto_namespace);
 namespace coreneuron {
 
#define _thread_present_ /**/ 
 
#if defined(_OPENACC) && !defined(DISABLE_OPENACC)
#include <openacc.h>
#if defined(__PGI)
#include "accelmath.h"
#endif
#if defined(PG_ACC_BUGS)
#define _PRAGMA_FOR_INIT_ACC_LOOP_ _Pragma("acc parallel loop present(_ni[0:_cntml_actual], _nt_data[0:_nt->_ndata], _p[0:_cntml_padded*_psize], _ppvar[0:_cntml_padded*_ppsize], _vec_v[0:_nt->end], nrn_ion_global_map[0:nrn_ion_global_map_size][0:3], _nt[0:1] _thread_present_) if(_nt->compute_gpu)")
#else
#define _PRAGMA_FOR_INIT_ACC_LOOP_ _Pragma("acc parallel loop present(_ni[0:_cntml_actual], _nt_data[0:_nt->_ndata], _p[0:_cntml_padded*_psize], _ppvar[0:_cntml_padded*_ppsize], _vec_v[0:_nt->end], nrn_ion_global_map[0:nrn_ion_global_map_size], _nt[0:1] _thread_present_) if(_nt->compute_gpu)")
#endif
#define _PRAGMA_FOR_STATE_ACC_LOOP_ _Pragma("acc parallel loop present(_ni[0:_cntml_actual], _nt_data[0:_nt->_ndata], _p[0:_cntml_padded*_psize], _ppvar[0:_cntml_padded*_ppsize], _vec_v[0:_nt->end], _nt[0:1], _ml[0:1] _thread_present_) if(_nt->compute_gpu) async(stream_id)")
#define _PRAGMA_FOR_CUR_ACC_LOOP_ _Pragma("acc parallel loop present(_ni[0:_cntml_actual], _nt_data[0:_nt->_ndata], _p[0:_cntml_padded*_psize], _ppvar[0:_cntml_padded*_ppsize], _vec_v[0:_nt->end], _vec_d[0:_nt->end], _vec_rhs[0:_nt->end], _nt[0:1] _thread_present_) if(_nt->compute_gpu) async(stream_id)")
#define _PRAGMA_FOR_CUR_SYN_ACC_LOOP_ _Pragma("acc parallel loop present(_ni[0:_cntml_actual], _nt_data[0:_nt->_ndata], _p[0:_cntml_padded*_psize], _ppvar[0:_cntml_padded*_ppsize], _vec_v[0:_nt->end], _vec_shadow_rhs[0:_nt->shadow_rhs_cnt], _vec_shadow_d[0:_nt->shadow_rhs_cnt], _vec_d[0:_nt->end], _vec_rhs[0:_nt->end], _nt[0:1]) if(_nt->compute_gpu) async(stream_id)")
#define _PRAGMA_FOR_NETRECV_ACC_LOOP_ _Pragma("acc parallel loop present(_pnt[0:_pnt_length], _nrb[0:1], _nt[0:1], nrn_threads[0:nrn_nthread]) if(_nt->compute_gpu) async(stream_id)")
#else
#define _PRAGMA_FOR_INIT_ACC_LOOP_ _Pragma("")
#define _PRAGMA_FOR_STATE_ACC_LOOP_ _Pragma("")
#define _PRAGMA_FOR_CUR_ACC_LOOP_ _Pragma("")
#define _PRAGMA_FOR_CUR_SYN_ACC_LOOP_ _Pragma("")
#define _PRAGMA_FOR_NETRECV_ACC_LOOP_ _Pragma("")
#endif
 
#if defined(__ICC) || defined(__INTEL_COMPILER)
#define _PRAGMA_FOR_VECTOR_LOOP_ _Pragma("ivdep")
#elif defined(__IBMC__) || defined(__IBMCPP__)
#define _PRAGMA_FOR_VECTOR_LOOP_ _Pragma("ibm independent_loop")
#elif defined(__PGI)
#define _PRAGMA_FOR_VECTOR_LOOP_ _Pragma("vector")
#elif defined(_CRAYC)
#define _PRAGMA_FOR_VECTOR_LOOP_ _Pragma("_CRI ivdep")
#elif defined(__clang__)
#define _PRAGMA_FOR_VECTOR_LOOP_ _Pragma("clang loop vectorize(enable)")
#elif defined(__GNUC__) || defined(__GNUG__)
#define _PRAGMA_FOR_VECTOR_LOOP_ _Pragma("GCC ivdep")
#else
#define _PRAGMA_FOR_VECTOR_LOOP_
#endif // _PRAGMA_FOR_VECTOR_LOOP_
 
#if !defined(LAYOUT)
/* 1 means AoS, >1 means AoSoA, <= 0 means SOA */
#define LAYOUT 1
#endif
#if LAYOUT >= 1
#define _STRIDE LAYOUT
#else
#define _STRIDE _cntml_padded + _iml
#endif
 
#define nrn_init _nrn_init__NetStim
#define nrn_cur _nrn_cur__NetStim
#define _nrn_current _nrn_current__NetStim
#define nrn_jacob _nrn_jacob__NetStim
#define nrn_state _nrn_state__NetStim
#define initmodel initmodel__NetStim
#define _net_receive _net_receive__NetStim
#define _net_init _net_init__NetStim
#define nrn_state_launcher nrn_state_NetStim_launcher
#define nrn_cur_launcher nrn_cur_NetStim_launcher
#define nrn_jacob_launcher nrn_jacob_NetStim_launcher 
#define init_sequence init_sequence_NetStim 
#define next_invl next_invl_NetStim 
#define noiseFromRandom123 noiseFromRandom123_NetStim 
#define noiseFromRandom noiseFromRandom_NetStim 
#define seed seed_NetStim 
 
#undef _threadargscomma_
#undef _threadargsprotocomma_
#undef _threadargs_
#undef _threadargsproto_
 
#define _threadargscomma_ _iml, _cntml_padded, _p, _ppvar, _thread, _nt, v,
#define _threadargsprotocomma_ int _iml, int _cntml_padded, double* _p, Datum* _ppvar, ThreadDatum* _thread, NrnThread* _nt, double v,
#define _threadargs_ _iml, _cntml_padded, _p, _ppvar, _thread, _nt, v
#define _threadargsproto_ int _iml, int _cntml_padded, double* _p, Datum* _ppvar, ThreadDatum* _thread, NrnThread* _nt, double v
 	/*SUPPRESS 761*/
	/*SUPPRESS 762*/
	/*SUPPRESS 763*/
	/*SUPPRESS 765*/
	 /* Thread safe. No static _p or _ppvar. */
 
#define t _nt->_t
#define dt _nt->_dt
#define interval _p[0*_STRIDE]
#define number _p[1*_STRIDE]
#define start _p[2*_STRIDE]
#define noise _p[3*_STRIDE]
#define event _p[4*_STRIDE]
#define on _p[5*_STRIDE]
#define ispike _p[6*_STRIDE]
#define _v_unused _p[7*_STRIDE]
#define _tsav _p[8*_STRIDE]
 
#ifndef NRN_PRCELLSTATE
#define NRN_PRCELLSTATE 0
#endif
#if NRN_PRCELLSTATE
#define _PRCELLSTATE_V _v_unused = _v;
#define _PRCELLSTATE_G /**/
#else
#define _PRCELLSTATE_V /**/
#define _PRCELLSTATE_G /**/
#endif
#define _nd_area  _nt_data[_ppvar[0*_STRIDE]]
#define _p_donotuse	_nt->_vdata[_ppvar[2*_STRIDE]]
 
#if MAC
#if !defined(v)
#define v _mlhv
#endif
#if !defined(h)
#define h _mlhh
#endif
#endif
 static int hoc_nrnpointerindex =  2;
 static ThreadDatum* _extcall_thread;
 /* external NEURON variables */
 
#if 0 /*BBCORE*/
 /* declaration of user functions */
 static double _hoc_erand();
 static double _hoc_init_sequence();
 static double _hoc_invl();
 static double _hoc_next_invl();
 static double _hoc_noiseFromRandom123();
 static double _hoc_noiseFromRandom();
 static double _hoc_seed();
 
#endif /*BBCORE*/
 static int _mechtype;
 static int _pointtype;
 
#if 0 /*BBCORE*/
 static void* _hoc_create_pnt(_ho) Object* _ho; { void* create_point_process();
 return create_point_process(_pointtype, _ho);
}
 static void _hoc_destroy_pnt();
 static double _hoc_loc_pnt(_vptr) void* _vptr; {double loc_point_process();
 return loc_point_process(_pointtype, _vptr);
}
 static double _hoc_has_loc(_vptr) void* _vptr; {double has_loc_point();
 return has_loc_point(_vptr);
}
 static double _hoc_get_loc_pnt(_vptr)void* _vptr; {
 double get_loc_point_process(); return (get_loc_point_process(_vptr));
}
 
#endif /*BBCORE*/
 
#if 0 /*BBCORE*/
 /* connect user functions to hoc names */
 static VoidFunc hoc_intfunc[] = {
 0,0
};
 static Member_func _member_func[] = {
 "loc", _hoc_loc_pnt,
 "has_loc", _hoc_has_loc,
 "get_loc", _hoc_get_loc_pnt,
 "erand", _hoc_erand,
 "init_sequence", _hoc_init_sequence,
 "invl", _hoc_invl,
 "next_invl", _hoc_next_invl,
 "noiseFromRandom123", _hoc_noiseFromRandom123,
 "noiseFromRandom", _hoc_noiseFromRandom,
 "seed", _hoc_seed,
 0, 0
};
 
#endif /*BBCORE*/
#define erand erand_NetStim
#define invl invl_NetStim
 inline double erand( _threadargsproto_ );
 inline double invl( _threadargsprotocomma_ double );
 /* declare global and static user variables */
 
static void _acc_globals_update() {
 }

 
#if 0 /*BBCORE*/
 /* some parameters have upper and lower limits */
 static HocParmLimits _hoc_parm_limits[] = {
 "interval", 1e-09, 1e+09,
 "noise", 0, 1,
 "number", 0, 1e+09,
 0,0,0
};
 static HocParmUnits _hoc_parm_units[] = {
 "interval", "ms",
 "start", "ms",
 0,0
};
 
#endif /*BBCORE*/
 /* connect global user variables to hoc */
 static DoubScal hoc_scdoub[] = {
 0,0
};
 static DoubVec hoc_vdoub[] = {
 0,0,0
};
 static double _sav_indep;
 static void nrn_alloc(double*, Datum*, int);
void nrn_init(NrnThread*, Memb_list*, int);
void nrn_state(NrnThread*, Memb_list*, int);
 
#if 0 /*BBCORE*/
 static void _hoc_destroy_pnt(_vptr) void* _vptr; {
   destroy_point_process(_vptr);
}
 
#endif /*BBCORE*/
 /* connect range variables in _p that hoc is supposed to know about */
 static const char *_mechanism[] = {
 "6.2.0",
"NetStim",
 "interval",
 "number",
 "start",
 "noise",
 0,
 0,
 0,
 "donotuse",
 0};
 
static void nrn_alloc(double* _p, Datum* _ppvar, int _type) {
 
#if 0 /*BBCORE*/
 	/*initialize range parameters*/
 	interval = 10;
 	number = 10;
 	start = 50;
 	noise = 0;
 
#endif /* BBCORE */
 
}
 static void _initlists();
 
#define _tqitem &(_nt->_vdata[_ppvar[3*_STRIDE]])
 void _net_receive(Point_process*, int, double);
 
#define _psize 9
#define _ppsize 4
 void _netstim_reg() {
	int _vectorized = 1;
  _initlists();
 _mechtype = nrn_get_mechtype(_mechanism[1]);
 if (_mechtype == -1) return;
 _nrn_layout_reg(_mechtype, LAYOUT);
 
#if 0 /*BBCORE*/
 
#endif /*BBCORE*/
 	_pointtype = point_register_mech(_mechanism,
	 nrn_alloc,NULL, NULL, NULL, nrn_init,
	 hoc_nrnpointerindex,
	 NULL/*_hoc_create_pnt*/, NULL/*_hoc_destroy_pnt*/, /*_member_func,*/
	 1);
   hoc_reg_bbcore_read(_mechtype, bbcore_read);
   hoc_reg_bbcore_write(_mechtype, bbcore_write);
  hoc_register_prop_size(_mechtype, _psize, _ppsize);
  hoc_register_dparam_semantics(_mechtype, 0, "area");
  hoc_register_dparam_semantics(_mechtype, 1, "pntproc");
  hoc_register_dparam_semantics(_mechtype, 2, "bbcorepointer");
  hoc_register_dparam_semantics(_mechtype, 3, "netsend");
 add_nrn_artcell(_mechtype, 3);
 add_nrn_has_net_event(_mechtype);
 set_pnt_receive(_mechtype, _net_receive, nullptr, 1);
 	hoc_register_var(hoc_scdoub, hoc_vdoub, NULL);
 }
static const char *modelname = "";

static int error;
static int _ninits = 0;
static int _match_recurse=1;
static void _modl_cleanup(){ _match_recurse=1;}
static inline int init_sequence(_threadargsprotocomma_ double);
static inline int next_invl(_threadargsproto_);
static inline int noiseFromRandom123(_threadargsproto_);
static inline int noiseFromRandom(_threadargsproto_);
static inline int seed(_threadargsprotocomma_ double);
 } using namespace coreneuron; 
/*VERBATIM*/
#if NRNBBCORE /* running in CoreNEURON */

#define IFNEWSTYLE(arg) arg

#else /* running in NEURON */

/*
   1 means noiseFromRandom was called when _ran_compat was previously 0 .
   2 means noiseFromRandom123 was called when _ran_compart was previously 0.
*/
static int _ran_compat; /* specifies the noise style for all instances */
#define IFNEWSTYLE(arg) if(_ran_compat == 2) { arg }

#endif /* running in NEURON */
 namespace coreneuron { 
static int  seed ( _threadargsprotocomma_ double _lx ) {
   
/*VERBATIM*/
#if !NRNBBCORE
 set_seed ( _lx ) ;
   
/*VERBATIM*/
#endif
  return 0; }
 
#if 0 /*BBCORE*/
 
static double _hoc_seed(void* _vptr) {
 double _r;
   double* _p; Datum* _ppvar; ThreadDatum* _thread; NrnThread* _nt;
   _p = ((Point_process*)_vptr)->_prop->param;
  _ppvar = ((Point_process*)_vptr)->_prop->dparam;
  _thread = _extcall_thread;
  _nt = (NrnThread*)((Point_process*)_vptr)->_vnt;
 _r = 1.;
 seed ( _threadargs_, *getarg(1) );
 return(_r);
}
 
#endif /*BBCORE*/
 
static int  init_sequence ( _threadargsprotocomma_ double _lt ) {
   if ( number > 0.0 ) {
     on = 1.0 ;
     event = 0.0 ;
     ispike = 0.0 ;
     }
    return 0; }
 
#if 0 /*BBCORE*/
 
static double _hoc_init_sequence(void* _vptr) {
 double _r;
   double* _p; Datum* _ppvar; ThreadDatum* _thread; NrnThread* _nt;
   _p = ((Point_process*)_vptr)->_prop->param;
  _ppvar = ((Point_process*)_vptr)->_prop->dparam;
  _thread = _extcall_thread;
  _nt = (NrnThread*)((Point_process*)_vptr)->_vnt;
 _r = 1.;
 init_sequence ( _threadargs_, *getarg(1) );
 return(_r);
}
 
#endif /*BBCORE*/
 
double invl ( _threadargsprotocomma_ double _lmean ) {
   double _linvl;
 if ( _lmean <= 0. ) {
     _lmean = .01 ;
     }
   if ( noise  == 0.0 ) {
     _linvl = _lmean ;
     }
   else {
     _linvl = ( 1. - noise ) * _lmean + noise * _lmean * erand ( _threadargs_ ) ;
     }
   
return _linvl;
 }
 
#if 0 /*BBCORE*/
 
static double _hoc_invl(void* _vptr) {
 double _r;
   double* _p; Datum* _ppvar; ThreadDatum* _thread; NrnThread* _nt;
   _p = ((Point_process*)_vptr)->_prop->param;
  _ppvar = ((Point_process*)_vptr)->_prop->dparam;
  _thread = _extcall_thread;
  _nt = (NrnThread*)((Point_process*)_vptr)->_vnt;
 _r =  invl ( _threadargs_, *getarg(1) );
 return(_r);
}
 
#endif /*BBCORE*/
 } using namespace coreneuron; 
/*VERBATIM*/
#include "nrnran123.h"

#if !NRNBBCORE
/* backward compatibility */
double nrn_random_pick(void* r);
void* nrn_random_arg(int argpos);
int nrn_random_isran123(void* r, uint32_t* id1, uint32_t* id2, uint32_t* id3);
#endif
 namespace coreneuron { 
double erand ( _threadargsproto_ ) {
   double _lerand;
 
/*VERBATIM*/
	if (_p_donotuse) {
		/*
		:Supports separate independent but reproducible streams for
		: each instance. However, the corresponding hoc Random
		: distribution MUST be set to Random.negexp(1)
		*/
#if !NRNBBCORE
		if (_ran_compat == 2) {
			_lerand = nrnran123_negexp((nrnran123_State*)_p_donotuse);
		}else{
			_lerand = nrn_random_pick(_p_donotuse);
		}
#else
		_lerand = nrnran123_negexp((nrnran123_State*)_p_donotuse);
#endif
		return _lerand;
	}else{
#if NRNBBCORE
		assert(0);
#else
		/*
		: the old standby. Cannot use if reproducible parallel sim
		: independent of nhost or which host this instance is on
		: is desired, since each instance on this cpu draws from
		: the same stream
		*/
#endif
	}
#if !NRNBBCORE
 _lerand = exprand ( 1.0 ) ;
   
/*VERBATIM*/
#endif
 
return _lerand;
 }
 
#if 0 /*BBCORE*/
 
static double _hoc_erand(void* _vptr) {
 double _r;
   double* _p; Datum* _ppvar; ThreadDatum* _thread; NrnThread* _nt;
   _p = ((Point_process*)_vptr)->_prop->param;
  _ppvar = ((Point_process*)_vptr)->_prop->dparam;
  _thread = _extcall_thread;
  _nt = (NrnThread*)((Point_process*)_vptr)->_vnt;
 _r =  erand ( _threadargs_ );
 return(_r);
}
 
#endif /*BBCORE*/
 
static int  noiseFromRandom ( _threadargsproto_ ) {
   
/*VERBATIM*/
#if !NRNBBCORE
 {
	void** pv = (void**)(&_p_donotuse);
	if (_ran_compat == 2) {
		fprintf(stderr, "NetStim.noiseFromRandom123 was previously called\n");
		assert(0);
	}
	_ran_compat = 1;
	if (ifarg(1)) {
		*pv = nrn_random_arg(1);
	}else{
		*pv = nullptr;
	}
 }
#endif
  return 0; }
 
#if 0 /*BBCORE*/
 
static double _hoc_noiseFromRandom(void* _vptr) {
 double _r;
   double* _p; Datum* _ppvar; ThreadDatum* _thread; NrnThread* _nt;
   _p = ((Point_process*)_vptr)->_prop->param;
  _ppvar = ((Point_process*)_vptr)->_prop->dparam;
  _thread = _extcall_thread;
  _nt = (NrnThread*)((Point_process*)_vptr)->_vnt;
 _r = 1.;
 noiseFromRandom ( _threadargs_ );
 return(_r);
}
 
#endif /*BBCORE*/
 
static int  noiseFromRandom123 ( _threadargsproto_ ) {
   
/*VERBATIM*/
#if !NRNBBCORE
 {
	nrnran123_State** pv = (nrnran123_State**)(&_p_donotuse);
	if (_ran_compat == 1) {
		fprintf(stderr, "NetStim.noiseFromRandom was previously called\n");
		assert(0);
	}
	_ran_compat = 2;
	if (*pv) {
		nrnran123_deletestream(*pv);
		*pv = nullptr;
	}
	if (ifarg(3)) {
		*pv = nrnran123_newstream3((uint32_t)*getarg(1), (uint32_t)*getarg(2), (uint32_t)*getarg(3));
	}else if (ifarg(2)) {
		*pv = nrnran123_newstream((uint32_t)*getarg(1), (uint32_t)*getarg(2));
	}
 }
#endif
  return 0; }
 
#if 0 /*BBCORE*/
 
static double _hoc_noiseFromRandom123(void* _vptr) {
 double _r;
   double* _p; Datum* _ppvar; ThreadDatum* _thread; NrnThread* _nt;
   _p = ((Point_process*)_vptr)->_prop->param;
  _ppvar = ((Point_process*)_vptr)->_prop->dparam;
  _thread = _extcall_thread;
  _nt = (NrnThread*)((Point_process*)_vptr)->_vnt;
 _r = 1.;
 noiseFromRandom123 ( _threadargs_ );
 return(_r);
}
 
#endif /*BBCORE*/
 } using namespace coreneuron; 
/*VERBATIM*/
static void bbcore_write(double* x, int* d, int* xx, int *offset, _threadargsproto_) {
	if (!noise) { return; }
	/* error if using the legacy scop_exprand */
	if (!_p_donotuse) {
		fprintf(stderr, "NetStim: cannot use the legacy scop_negexp generator for the random stream.\n");
		assert(0);
	}
	if (d) {
        unsigned char which;
		uint32_t* di = ((uint32_t*)d) + *offset;
#if !NRNBBCORE
		if (_ran_compat == 1) {
			void** pv = (void**)(&_p_donotuse);
			/* error if not using Random123 generator */
			if (!nrn_random_isran123(*pv, di, di+1, di+2)) {
				fprintf(stderr, "NetStim: Random123 generator is required\n");
				assert(0);
			}
                        // Assume an unpicked stream.
			di[3] = 0;
			di[4] = 0;
		}else{
#else
    {
#endif
			nrnran123_State** pv = (nrnran123_State**)(&_p_donotuse);
			nrnran123_getids3(*pv, di, di+1, di+2);
			nrnran123_getseq(*pv, di+3, &which);
			di[4] = (int)which;
		}
		/*printf("Netstim bbcore_write %d %d %d\n", di[0], di[1], di[3]);*/
	}
	*offset += 5;
}

static void bbcore_read(double* x, int* d, int* xx, int* offset, _threadargsproto_) {
	assert(!_p_donotuse);
	if (noise) {
		uint32_t* di = ((uint32_t*)d) + *offset;
		nrnran123_State** pv = (nrnran123_State**)(&_p_donotuse);
		*pv = nrnran123_newstream3(di[0], di[1], di[2]);
		nrnran123_setseq(*pv, di[3], (char)di[4]);
	}else{
		return;
	}
	*offset += 5;
}
 namespace coreneuron { 
static int  next_invl ( _threadargsproto_ ) {
   if ( number > 0.0 ) {
     event = invl ( _threadargscomma_ interval ) ;
     }
   if ( ispike >= number ) {
     on = 0.0 ;
     }
    return 0; }
 
#if 0 /*BBCORE*/
 
static double _hoc_next_invl(void* _vptr) {
 double _r;
   double* _p; Datum* _ppvar; ThreadDatum* _thread; NrnThread* _nt;
   _p = ((Point_process*)_vptr)->_prop->param;
  _ppvar = ((Point_process*)_vptr)->_prop->dparam;
  _thread = _extcall_thread;
  _nt = (NrnThread*)((Point_process*)_vptr)->_vnt;
 _r = 1.;
 next_invl ( _threadargs_ );
 return(_r);
}
 
#endif /*BBCORE*/
 
void _net_receive (Point_process* _pnt, int _weight_index, double _lflag) 
{  double* _p; Datum* _ppvar; ThreadDatum* _thread; double v = 0;
   Memb_list* _ml; int _cntml_padded, _cntml_actual; int _iml; double* _args;
 
   NrnThread* _nt;
   int _tid = _pnt->_tid; 
   _nt = nrn_threads + _tid;
   _thread = (ThreadDatum*)0; 
   double *_weights = _nt->_weights;
   _args = _weights + _weight_index;
   _ml = _nt->_ml_list[_pnt->_type];
   _cntml_actual = _ml->_nodecount;
   _cntml_padded = _ml->_nodecount_padded;
   _iml = _pnt->_i_instance;
#if LAYOUT == 1 /*AoS*/
   _p = _ml->_data + _iml*_psize; _ppvar = _ml->_pdata + _iml*_ppsize;
#endif
#if LAYOUT == 0 /*SoA*/
   _p = _ml->_data; _ppvar = _ml->_pdata;
#endif
#if LAYOUT > 1 /*AoSoA*/
#error AoSoA not implemented.
#endif
  #if !defined(_OPENACC) 
 assert(_tsav <= t); 
 #endif 
 _tsav = t; 
#if !NET_RECEIVE_BUFFERING
  if (_lflag == 1. ) {*(_tqitem) = 0;}
#endif
 {
   if ( _lflag  == 0.0 ) {
     if ( _args[0] > 0.0  && on  == 0.0 ) {
       init_sequence ( _threadargscomma_ t ) ;
       next_invl ( _threadargs_ ) ;
       event = event - interval * ( 1. - noise ) ;
       artcell_net_send ( _tqitem, _weight_index, _pnt, t +  event , 1.0 ) ;
       }
     else if ( _args[0] < 0.0 ) {
       on = 0.0 ;
       }
     }
   if ( _lflag  == 3.0 ) {
     if ( on  == 1.0 ) {
       init_sequence ( _threadargscomma_ t ) ;
       artcell_net_send ( _tqitem, _weight_index, _pnt, t +  0.0 , 1.0 ) ;
       }
     }
   if ( _lflag  == 1.0  && on  == 1.0 ) {
     ispike = ispike + 1.0 ;
     net_event ( _pnt, t ) ;
     next_invl ( _threadargs_ ) ;
     if ( on  == 1.0 ) {
       artcell_net_send ( _tqitem, _weight_index, _pnt, t +  event , 1.0 ) ;
       }
     }
   } 
#if NET_RECEIVE_BUFFERING
#undef t
#define t _nt->_t
#endif
 }

static inline void initmodel(_threadargsproto_) {
  int _i; double _save;{
 {
   
/*VERBATIM*/
	  if (_p_donotuse) {
	    /* only this style initializes the stream on finitialize */
	    IFNEWSTYLE(nrnran123_setseq((nrnran123_State*)_p_donotuse, 0, 0);)
	  }
 on = 0.0 ;
   ispike = 0.0 ;
   if ( noise < 0.0 ) {
     noise = 0.0 ;
     }
   if ( noise > 1.0 ) {
     noise = 1.0 ;
     }
   if ( start >= 0.0  && number > 0.0 ) {
     on = 1.0 ;
     event = start + invl ( _threadargscomma_ interval ) - interval * ( 1. - noise ) ;
     if ( event < 0.0 ) {
       event = 0.0 ;
       }
     artcell_net_send ( _tqitem, -1, (Point_process*) _nt->_vdata[_ppvar[1*_STRIDE]], t +  event , 3.0 ) ;
     }
   }

}
}

void nrn_init(NrnThread* _nt, Memb_list* _ml, int _type){
double* _p; Datum* _ppvar; ThreadDatum* _thread;
double _v, v; int* _ni; int _iml, _cntml_padded, _cntml_actual;
    _ni = _ml->_nodeindices;
_cntml_actual = _ml->_nodecount;
_cntml_padded = _ml->_nodecount_padded;
_thread = _ml->_thread;
_acc_globals_update();
double * _nt_data = _nt->_data;
double * _vec_v = _nt->_actual_v;
int stream_id = _nt->stream_id;
  if (_nrn_skip_initmodel == 0) {
#if LAYOUT == 1 /*AoS*/
for (_iml = 0; _iml < _cntml_actual; ++_iml) {
 _p = _ml->_data + _iml*_psize; _ppvar = _ml->_pdata + _iml*_ppsize;
#elif LAYOUT == 0 /*SoA*/
 _p = _ml->_data; _ppvar = _ml->_pdata;
_PRAGMA_FOR_INIT_ACC_LOOP_
for (_iml = 0; _iml < _cntml_actual; ++_iml) {
#else /* LAYOUT > 1 */ /*AoSoA*/
#error AoSoA not implemented.
for (;;) { /* help clang-format properly indent */
#endif
 _tsav = -1e20;
 initmodel(_threadargs_);
}
  }
}

static double _nrn_current(_threadargsproto_, double _v){double _current=0.;v=_v;{
} return _current;
}

#if defined(ENABLE_CUDA_INTERFACE) && defined(_OPENACC)
  void nrn_state_launcher(NrnThread*, Memb_list*, int, int);
  void nrn_jacob_launcher(NrnThread*, Memb_list*, int, int);
  void nrn_cur_launcher(NrnThread*, Memb_list*, int, int);
#endif


void nrn_state(NrnThread* _nt, Memb_list* _ml, int _type) {
double* _p; Datum* _ppvar; ThreadDatum* _thread;
double v, _v = 0.0; int* _ni; int _iml, _cntml_padded, _cntml_actual;
    _ni = _ml->_nodeindices;
_cntml_actual = _ml->_nodecount;
_cntml_padded = _ml->_nodecount_padded;
_thread = _ml->_thread;

#if defined(ENABLE_CUDA_INTERFACE) && defined(_OPENACC) && !defined(DISABLE_OPENACC)
  NrnThread* d_nt = acc_deviceptr(_nt);
  Memb_list* d_ml = acc_deviceptr(_ml);
  nrn_state_launcher(d_nt, d_ml, _type, _cntml_actual);
  return;
#endif

double * _nt_data = _nt->_data;
double * _vec_v = _nt->_actual_v;
int stream_id = _nt->stream_id;
#if LAYOUT == 1 /*AoS*/
for (_iml = 0; _iml < _cntml_actual; ++_iml) {
 _p = _ml->_data + _iml*_psize; _ppvar = _ml->_pdata + _iml*_ppsize;
#elif LAYOUT == 0 /*SoA*/
 _p = _ml->_data; _ppvar = _ml->_pdata;
/* insert compiler dependent ivdep like pragma */
_PRAGMA_FOR_VECTOR_LOOP_
_PRAGMA_FOR_STATE_ACC_LOOP_
for (_iml = 0; _iml < _cntml_actual; ++_iml) {
#else /* LAYOUT > 1 */ /*AoSoA*/
#error AoSoA not implemented.
for (;;) { /* help clang-format properly indent */
#endif
 v=_v;
{
}}

}

static void terminal(){}

static void _initlists(){
 double _x; double* _p = &_x;
 int _i; static int _first = 1;
 int _cntml_actual=1;
 int _cntml_padded=1;
 int _iml=0;
  if (!_first) return;
_first = 0;
}
} // namespace coreneuron_lib
