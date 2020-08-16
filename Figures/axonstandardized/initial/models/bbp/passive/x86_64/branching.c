/* Created by Language version: 7.5.0 */
/* NOT VECTORIZED */
#define NRN_VECTORIZED 0
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "scoplib_ansi.h"
#undef PI
#define nil 0
#include "md1redef.h"
#include "section.h"
#include "nrniv_mf.h"
#include "md2redef.h"
 
#if METHOD3
extern int _method3;
#endif

#if !NRNGPU
#undef exp
#define exp hoc_Exp
extern double hoc_Exp(double);
#endif
 
#define nrn_init _nrn_init_
#define _nrn_initial _nrn_initial_
#define nrn_cur _nrn_cur_
#define _nrn_current _nrn_current_
#define nrn_jacob _nrn_jacob_
#define nrn_state _nrn_state_
#define _net_receive _net_receive_ 
#define MyPrintMatrix3 MyPrintMatrix3_ 
#define MyPrintMatrix1 MyPrintMatrix1_ 
#define MyTopology1 MyTopology1_ 
#define MyTopology2 MyTopology2_ 
#define MyTopology MyTopology_ 
#define MyAdb MyAdb_ 
#define MyPrintMatrix MyPrintMatrix_ 
#define PrintRHS_D PrintRHS_D_ 
#define init_files init_files_ 
 
#define _threadargscomma_ /**/
#define _threadargsprotocomma_ /**/
#define _threadargs_ /**/
#define _threadargsproto_ /**/
 	/*SUPPRESS 761*/
	/*SUPPRESS 762*/
	/*SUPPRESS 763*/
	/*SUPPRESS 765*/
	 extern double *getarg();
 static double *_p; static Datum *_ppvar;
 
#define t nrn_threads->_t
#define dt nrn_threads->_dt
 
#if MAC
#if !defined(v)
#define v _mlhv
#endif
#if !defined(h)
#define h _mlhh
#endif
#endif
 
#if defined(__cplusplus)
extern "C" {
#endif
 static int hoc_nrnpointerindex =  -1;
 /* external NEURON variables */
 /* declaration of user functions */
 static void _hoc_GetB(void);
 static void _hoc_GetA(void);
 static void _hoc_MyPrintMatrix3(void);
 static void _hoc_MyPrintMatrix1(void);
 static void _hoc_MyTopology1(void);
 static void _hoc_MyTopology2(void);
 static void _hoc_MyTopology(void);
 static void _hoc_MyAdb(void);
 static void _hoc_MyPrintMatrix(void);
 static void _hoc_PrintRHS_D(void);
 static void _hoc_SetB(void);
 static void _hoc_SetA(void);
 static void _hoc_init_files(void);
 static int _mechtype;
extern void _nrn_cacheloop_reg(int, int);
extern void hoc_register_prop_size(int, int, int);
extern void hoc_register_limits(int, HocParmLimits*);
extern void hoc_register_units(int, HocParmUnits*);
extern void nrn_promote(Prop*, int, int);
extern Memb_func* memb_func;
 extern void _nrn_setdata_reg(int, void(*)(Prop*));
 static void _setdata(Prop* _prop) {
 _p = _prop->param; _ppvar = _prop->dparam;
 }
 static void _hoc_setdata() {
 Prop *_prop, *hoc_getdata_range(int);
 _prop = hoc_getdata_range(_mechtype);
   _setdata(_prop);
 hoc_retpushx(1.);
}
 /* connect user functions to hoc names */
 static VoidFunc hoc_intfunc[] = {
 "setdata_branching", _hoc_setdata,
 "GetB", _hoc_GetB,
 "GetA", _hoc_GetA,
 "MyPrintMatrix3", _hoc_MyPrintMatrix3,
 "MyPrintMatrix1", _hoc_MyPrintMatrix1,
 "MyTopology1", _hoc_MyTopology1,
 "MyTopology2", _hoc_MyTopology2,
 "MyTopology", _hoc_MyTopology,
 "MyAdb", _hoc_MyAdb,
 "MyPrintMatrix", _hoc_MyPrintMatrix,
 "PrintRHS_D", _hoc_PrintRHS_D,
 "SetB", _hoc_SetB,
 "SetA", _hoc_SetA,
 "init_files", _hoc_init_files,
 0, 0
};
 extern double GetB( double );
 extern double GetA( double );
 extern double SetB( double , double );
 extern double SetA( double , double );
 /* declare global and static user variables */
 /* some parameters have upper and lower limits */
 static HocParmLimits _hoc_parm_limits[] = {
 0,0,0
};
 static HocParmUnits _hoc_parm_units[] = {
 0,0
};
 static double v = 0;
 /* connect global user variables to hoc */
 static DoubScal hoc_scdoub[] = {
 0,0
};
 static DoubVec hoc_vdoub[] = {
 0,0,0
};
 static double _sav_indep;
 static void nrn_alloc(Prop*);
static void  nrn_init(_NrnThread*, _Memb_list*, int);
static void nrn_state(_NrnThread*, _Memb_list*, int);
 /* connect range variables in _p that hoc is supposed to know about */
 static const char *_mechanism[] = {
 "7.5.0",
"branching",
 0,
 0,
 0,
 0};
 
extern Prop* need_memb(Symbol*);

static void nrn_alloc(Prop* _prop) {
	Prop *prop_ion;
	double *_p; Datum *_ppvar;
 	_p = nrn_prop_data_alloc(_mechtype, 0, _prop);
 	/*initialize range parameters*/
 	_prop->param = _p;
 	_prop->param_size = 0;
 
}
 static void _initlists();
 extern Symbol* hoc_lookup(const char*);
extern void _nrn_thread_reg(int, int, void(*)(Datum*));
extern void _nrn_thread_table_reg(int, void(*)(double*, Datum*, Datum*, _NrnThread*, int));
extern void hoc_register_tolerance(int, HocStateTolerance*, Symbol***);
extern void _cvode_abstol( Symbol**, double*, int);

 void _branching_reg() {
	int _vectorized = 0;
  _initlists();
 	hoc_register_var(hoc_scdoub, hoc_vdoub, hoc_intfunc);
 	ivoc_help("help ?1 branching /global/cscratch1/sd/kyoungh/paper-sp19/sandbox/run_model_BBP_passive/x86_64/branching.mod\n");
 }
static int _reset;
static char *modelname = "";

static int error;
static int _ninits = 0;
static int _match_recurse=1;
static void _modl_cleanup(){ _match_recurse=1;}
static int MyPrintMatrix3();
static int MyPrintMatrix1();
static int MyTopology1();
static int MyTopology2();
static int MyTopology();
static int MyAdb();
static int MyPrintMatrix();
static int PrintRHS_D();
static int init_files();
 
/*VERBATIM*/

 
static int  init_files (  ) {
   
/*VERBATIM*/
{
		
		
	}
  return 0; }
 
static void _hoc_init_files(void) {
  double _r;
   _r = 1.;
 init_files (  );
 hoc_retpushx(_r);
}
 
double GetA (  double _lx ) {
   double _lGetA;
 
/*VERBATIM*/
{
#if defined(t)
	_NrnThread* _nt = nrn_threads;
#endif
Section* sec;
	Node* nd;
	sec = chk_access();
	if (_lx < 0. || _lx > 1.) {
	//printf("_lx is %f and _lx*(double)(sec->nnode-1) is %f\n",_lx,_lx*(double)(sec->nnode-1));
		hoc_execerror("out of range, must be 0 < x <= 1", (char*)0);
	}
	if (_lx == 1.) {
		nd = sec->pnode[sec->nnode-1];
	}else{
		nd = sec->pnode[(int) (_lx*(double)(sec->nnode-1))];
	}
	return NODEA(nd);
}
 
return _lGetA;
 }
 
static void _hoc_GetA(void) {
  double _r;
   _r =  GetA (  *getarg(1) );
 hoc_retpushx(_r);
}
 
double GetB (  double _lx ) {
   double _lGetB;
 
/*VERBATIM*/
{
#if defined(t)
	_NrnThread* _nt = nrn_threads;
#endif
Section* sec;
	Node* nd;
	sec = chk_access();
	if (_lx < 0. || _lx > 1.) {
		//printf("_lx is %f and _lx*(double)(sec->nnode-1) is %f\n",_lx,_lx*(double)(sec->nnode-1));
		hoc_execerror("out of range, must be 0 < x <= 1", (char*)0);
	}
	if (_lx == 1.) {
		nd = sec->pnode[sec->nnode-1];
	}else{
		nd = sec->pnode[(int) (_lx*(double)(sec->nnode-1))];
	}
	return NODEB(nd);
}
 
return _lGetB;
 }
 
static void _hoc_GetB(void) {
  double _r;
   _r =  GetB (  *getarg(1) );
 hoc_retpushx(_r);
}
 
double SetA (  double _lx , double _la ) {
   double _lSetA;
 
/*VERBATIM*/
{
#if defined(t)
	_NrnThread* _nt = nrn_threads;
#endif
Section* sec;
	Node* nd;
	sec = chk_access();
	if (_lx < 0. || _lx > 1.) {
		hoc_execerror("out of range, must be 0 < x <= 1", (char*)0);
	}
	if (_lx == 1.) {
		nd = sec->pnode[sec->nnode-1];
	}else{
		nd = sec->pnode[(int) (_lx*(double)(sec->nnode-1))];
	}
	//printf("index is %d,NODEA(nd) is %f _la is %f\n",nd->v_node_index,NODEA(nd),_la);
	NODEA(nd) = _la;
}
 
return _lSetA;
 }
 
static void _hoc_SetA(void) {
  double _r;
   _r =  SetA (  *getarg(1) , *getarg(2) );
 hoc_retpushx(_r);
}
 
double SetB (  double _lx , double _lb ) {
   double _lSetB;
 
/*VERBATIM*/
{
#if defined(t)
	_NrnThread* _nt = nrn_threads;
#endif
Section* sec;
	Node* nd;
	sec = chk_access();
	if (_lx < 0. || _lx > 1.) {
		hoc_execerror("out of range, must be 0 < x <= 1", (char*)0);
	}
	if (_lx == 1.) {
		nd = sec->pnode[sec->nnode-1];
	}else{
		nd = sec->pnode[(int) (_lx*(double)(sec->nnode-1))];
	}
	//printf("index is %d,NODEB(nd) is %f _lb is %f\n",nd->v_node_index,NODEB(nd),_lb);
	NODEB(nd) = _lb;
}
 
return _lSetB;
 }
 
static void _hoc_SetB(void) {
  double _r;
   _r =  SetB (  *getarg(1) , *getarg(2) );
 hoc_retpushx(_r);
}
 
static int  MyPrintMatrix (  ) {
   
/*VERBATIM*/
{
	Section* sec;
	FILE* fm;
	fm= fopen("C:\fmatrix.dat", "wb");
	Node* nd;
	int ii;
#if defined(t)
	_NrnThread* _nt = nrn_threads;
#endif
for(ii=0;ii<_nt->end;ii++){
nd=_nt->_v_node[ii];
fprintf(fm,"%d %1.15f %1.15f %1.15f %1.15f\n", ii, NODEB(nd), NODEA(nd), NODED(nd), NODERHS(nd));
}
fclose(fm);
}
  return 0; }
 
static void _hoc_MyPrintMatrix(void) {
  double _r;
   _r = 1.;
 MyPrintMatrix (  );
 hoc_retpushx(_r);
}
 
static int  MyAdb (  ) {
   
/*VERBATIM*/
{
	int ii;
#if defined(t)
	_NrnThread* _nt = nrn_threads;
#endif
for(ii=0;ii<_nt->end;ii++){

printf("%d,%1.15f %1.15f %1.15f %1.15f\n",ii, _nt->_actual_a[ii],_nt->_actual_d[ii],_nt->_actual_b[ii],_nt->_actual_rhs[ii]);
}
}
  return 0; }
 
static void _hoc_MyAdb(void) {
  double _r;
   _r = 1.;
 MyAdb (  );
 hoc_retpushx(_r);
}
 
static int  PrintRHS_D (  ) {
   
/*VERBATIM*/
{
	int ii;
#if defined(t)
	_NrnThread* _nt = nrn_threads;
#endif
Node* nd;
for(ii=0;ii<_nt->end;ii++){
nd=_nt->_v_node[ii];
printf("%d,%1.15f %1.15f \n",ii,  NODED(nd), NODERHS(nd));
}
}
  return 0; }
 
static void _hoc_PrintRHS_D(void) {
  double _r;
   _r = 1.;
 PrintRHS_D (  );
 hoc_retpushx(_r);
}
 
static int  MyTopology (  ) {
   
/*VERBATIM*/
{
	int ii;
#if defined(t)
	_NrnThread* _nt = nrn_threads;
#endif
for(ii=0;ii<_nt->end;ii++){

printf("%d %d\n", ii, _nt->_v_parent_index[ii]);
}
}
  return 0; }
 
static void _hoc_MyTopology(void) {
  double _r;
   _r = 1.;
 MyTopology (  );
 hoc_retpushx(_r);
}
 
static int  MyTopology2 (  ) {
   
/*VERBATIM*/
{
	FILE * pFile;
	int ii;
#if defined(t)
	_NrnThread* _nt = nrn_threads;
#endif
pFile = fopen ("parent.txt","w");
for(ii=0;ii<_nt->end;ii++){

fprintf(pFile,"%d ", _nt->_v_parent_index[ii]);
}
fclose (pFile);
}
  return 0; }
 
static void _hoc_MyTopology2(void) {
  double _r;
   _r = 1.;
 MyTopology2 (  );
 hoc_retpushx(_r);
}
 
static int  MyTopology1 (  ) {
   
/*VERBATIM*/
{
	FILE * pFile;
	int ii;
#if defined(t)
	_NrnThread* _nt = nrn_threads;
#endif
pFile = fopen ("64TL.csv","w");
for(ii=0;ii<_nt->end;ii++){

fprintf(pFile,"%d %d\n", ii, _nt->_v_parent_index[ii]);
}
fclose (pFile);
}
  return 0; }
 
static void _hoc_MyTopology1(void) {
  double _r;
   _r = 1.;
 MyTopology1 (  );
 hoc_retpushx(_r);
}
 
static int  MyPrintMatrix1 (  ) {
   
/*VERBATIM*/
{
	Section* sec;
	FILE* fm;
	fm= fopen("64TL.csv", "w");
	Node* nd;
	int ii;
#if defined(t)
	_NrnThread* _nt = nrn_threads;
#endif
for(ii=0;ii<_nt->end;ii++){
nd=_nt->_v_node[ii];
fprintf(fm,"%d %1.15f %1.15f %1.15f %1.15f\n", ii, NODEB(nd), NODEA(nd), NODED(nd), NODERHS(nd));
}
fclose (fm);
}
  return 0; }
 
static void _hoc_MyPrintMatrix1(void) {
  double _r;
   _r = 1.;
 MyPrintMatrix1 (  );
 hoc_retpushx(_r);
}
 
static int  MyPrintMatrix3 (  ) {
   
/*VERBATIM*/
{
	Section* sec;
	FILE* fm;
	fm= fopen("Fmatrix.csv", "w");
	Node* nd;
	int ii;
#if defined(t)
	_NrnThread* _nt = nrn_threads;
#endif
for(ii=0;ii<_nt->end;ii++){
nd=_nt->_v_node[ii];
fprintf(fm,"%d %1.15f %1.15f %1.15f %1.15f\n", ii, NODEB(nd), NODEA(nd), NODED(nd), NODERHS(nd));
}
fclose (fm);
}
  return 0; }
 
static void _hoc_MyPrintMatrix3(void) {
  double _r;
   _r = 1.;
 MyPrintMatrix3 (  );
 hoc_retpushx(_r);
}

static void initmodel() {
  int _i; double _save;_ninits++;
{

}
}

static void nrn_init(_NrnThread* _nt, _Memb_list* _ml, int _type){
Node *_nd; double _v; int* _ni; int _iml, _cntml;
#if CACHEVEC
    _ni = _ml->_nodeindices;
#endif
_cntml = _ml->_nodecount;
for (_iml = 0; _iml < _cntml; ++_iml) {
 _p = _ml->_data[_iml]; _ppvar = _ml->_pdata[_iml];
#if CACHEVEC
  if (use_cachevec) {
    _v = VEC_V(_ni[_iml]);
  }else
#endif
  {
    _nd = _ml->_nodelist[_iml];
    _v = NODEV(_nd);
  }
 v = _v;
 initmodel();
}}

static double _nrn_current(double _v){double _current=0.;v=_v;{
} return _current;
}

static void nrn_state(_NrnThread* _nt, _Memb_list* _ml, int _type){
Node *_nd; double _v = 0.0; int* _ni; int _iml, _cntml;
#if CACHEVEC
    _ni = _ml->_nodeindices;
#endif
_cntml = _ml->_nodecount;
for (_iml = 0; _iml < _cntml; ++_iml) {
 _p = _ml->_data[_iml]; _ppvar = _ml->_pdata[_iml];
 _nd = _ml->_nodelist[_iml];
#if CACHEVEC
  if (use_cachevec) {
    _v = VEC_V(_ni[_iml]);
  }else
#endif
  {
    _nd = _ml->_nodelist[_iml];
    _v = NODEV(_nd);
  }
 v=_v;
{
}}

}

static void terminal(){}

static void _initlists() {
 int _i; static int _first = 1;
  if (!_first) return;
_first = 0;
}
