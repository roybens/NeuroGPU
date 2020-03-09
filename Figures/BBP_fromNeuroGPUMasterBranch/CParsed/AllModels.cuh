// Automatically generated H for E:\GitHub\NeuroGPU\Figures\BBP_fromNeuroGPUMasterBranch./runModel.hoc

#ifndef __ALLMODELS__
#define __ALLMODELS__
#include "Util.h"

#define NSTATES 19
#define NPARAMS 19
// GGlobals
#define celsius (34.0)
#define stoprun (0.0)
#define clamp_resist (0.001)
#define secondorder (0.0)

// Kinetic Helper code
void BreakpointModel_Ca_HVA(MYSECONDFTYPE &sumCurrents, MYFTYPE &sumConductivity, MYFTYPE v,MYFTYPE &m,MYFTYPE &h,MYFTYPE gCa_HVAbar_Ca_HVA, MYFTYPE &ica,MYFTYPE &eca, MYFTYPE &cai) ;
void BreakpointModel_Ca_LVAst(MYSECONDFTYPE &sumCurrents, MYFTYPE &sumConductivity, MYFTYPE v,MYFTYPE &m,MYFTYPE &h,MYFTYPE gCa_LVAstbar_Ca_LVAst, MYFTYPE &ica,MYFTYPE &eca, MYFTYPE &cai) ;
void BreakpointModel_CaDynamics_E2(MYSECONDFTYPE &sumCurrents, MYFTYPE &sumConductivity, MYFTYPE v,MYFTYPE &cai,MYFTYPE gamma_CaDynamics_E2,MYFTYPE decay_CaDynamics_E2,MYFTYPE depth_CaDynamics_E2,MYFTYPE minCai_CaDynamics_E2, MYFTYPE ica,MYFTYPE &eca) ;
void BreakpointModel_Ih(MYSECONDFTYPE &sumCurrents, MYFTYPE &sumConductivity, MYFTYPE v,MYFTYPE &m,MYFTYPE gIhbar_Ih,MYFTYPE ehcn_Ih) ;
void BreakpointModel_Im(MYSECONDFTYPE &sumCurrents, MYFTYPE &sumConductivity, MYFTYPE v,MYFTYPE &m,MYFTYPE gImbar_Im) ;
void BreakpointModel_K_Pst(MYSECONDFTYPE &sumCurrents, MYFTYPE &sumConductivity, MYFTYPE v,MYFTYPE &m,MYFTYPE &h,MYFTYPE gK_Pstbar_K_Pst) ;
void BreakpointModel_K_Tst(MYSECONDFTYPE &sumCurrents, MYFTYPE &sumConductivity, MYFTYPE v,MYFTYPE &m,MYFTYPE &h,MYFTYPE gK_Tstbar_K_Tst) ;
void BreakpointModel_Nap_Et2(MYSECONDFTYPE &sumCurrents, MYFTYPE &sumConductivity, MYFTYPE v,MYFTYPE &m,MYFTYPE &h,MYFTYPE gNap_Et2bar_Nap_Et2) ;
void BreakpointModel_NaTa_t(MYSECONDFTYPE &sumCurrents, MYFTYPE &sumConductivity, MYFTYPE v,MYFTYPE &m,MYFTYPE &h,MYFTYPE gNaTa_tbar_NaTa_t) ;
void BreakpointModel_NaTs2_t(MYSECONDFTYPE &sumCurrents, MYFTYPE &sumConductivity, MYFTYPE v,MYFTYPE &m,MYFTYPE &h,MYFTYPE gNaTs2_tbar_NaTs2_t) ;
void BreakpointModel_pas(MYSECONDFTYPE &sumCurrents, MYFTYPE &sumConductivity, MYFTYPE v,MYFTYPE g_pas,MYFTYPE e_pas) ;
void BreakpointModel_SK_E2(MYSECONDFTYPE &sumCurrents, MYFTYPE &sumConductivity, MYFTYPE v,MYFTYPE &z,MYFTYPE gSK_E2bar_SK_E2,MYFTYPE zTau_SK_E2, MYFTYPE cai,MYFTYPE &eca) ;
void BreakpointModel_SKv3_1(MYSECONDFTYPE &sumCurrents, MYFTYPE &sumConductivity, MYFTYPE v,MYFTYPE &m,MYFTYPE gSKv3_1bar_SKv3_1) ;
void DerivModel_Ca_HVA(MYFTYPE dt, MYFTYPE v,MYFTYPE &m,MYFTYPE &h,MYFTYPE gCa_HVAbar_Ca_HVA, MYFTYPE &ica);
void DerivModel_Ca_LVAst(MYFTYPE dt, MYFTYPE v,MYFTYPE &m,MYFTYPE &h,MYFTYPE gCa_LVAstbar_Ca_LVAst, MYFTYPE &ica);
void DerivModel_CaDynamics_E2(MYFTYPE dt, MYFTYPE v,MYFTYPE &cai,MYFTYPE gamma_CaDynamics_E2,MYFTYPE decay_CaDynamics_E2,MYFTYPE depth_CaDynamics_E2,MYFTYPE minCai_CaDynamics_E2, MYFTYPE ica,MYFTYPE &eca);
void DerivModel_Ih(MYFTYPE dt, MYFTYPE v,MYFTYPE &m,MYFTYPE gIhbar_Ih,MYFTYPE ehcn_Ih);
void DerivModel_Im(MYFTYPE dt, MYFTYPE v,MYFTYPE &m,MYFTYPE gImbar_Im);
void DerivModel_K_Pst(MYFTYPE dt, MYFTYPE v,MYFTYPE &m,MYFTYPE &h,MYFTYPE gK_Pstbar_K_Pst);
void DerivModel_K_Tst(MYFTYPE dt, MYFTYPE v,MYFTYPE &m,MYFTYPE &h,MYFTYPE gK_Tstbar_K_Tst);
void DerivModel_Nap_Et2(MYFTYPE dt, MYFTYPE v,MYFTYPE &m,MYFTYPE &h,MYFTYPE gNap_Et2bar_Nap_Et2);
void DerivModel_NaTa_t(MYFTYPE dt, MYFTYPE v,MYFTYPE &m,MYFTYPE &h,MYFTYPE gNaTa_tbar_NaTa_t);
void DerivModel_NaTs2_t(MYFTYPE dt, MYFTYPE v,MYFTYPE &m,MYFTYPE &h,MYFTYPE gNaTs2_tbar_NaTs2_t);
void DerivModel_SK_E2(MYFTYPE dt, MYFTYPE v,MYFTYPE &z,MYFTYPE gSK_E2bar_SK_E2,MYFTYPE zTau_SK_E2, MYFTYPE cai,MYFTYPE &eca);
void DerivModel_SKv3_1(MYFTYPE dt, MYFTYPE v,MYFTYPE &m,MYFTYPE gSKv3_1bar_SKv3_1);
void InitModel_Ca_HVA(MYFTYPE v,MYFTYPE &m,MYFTYPE &h,MYFTYPE gCa_HVAbar_Ca_HVA, MYFTYPE &ica,MYFTYPE &eca, MYFTYPE &cai);

void InitModel_Ca_LVAst(MYFTYPE v,MYFTYPE &m,MYFTYPE &h,MYFTYPE gCa_LVAstbar_Ca_LVAst, MYFTYPE &ica,MYFTYPE &eca, MYFTYPE &cai);

void InitModel_CaDynamics_E2(MYFTYPE v,MYFTYPE &cai,MYFTYPE gamma_CaDynamics_E2,MYFTYPE decay_CaDynamics_E2,MYFTYPE depth_CaDynamics_E2,MYFTYPE minCai_CaDynamics_E2, MYFTYPE ica,MYFTYPE &eca);

void InitModel_Ih(MYFTYPE v,MYFTYPE &m,MYFTYPE gIhbar_Ih,MYFTYPE ehcn_Ih);

void InitModel_Im(MYFTYPE v,MYFTYPE &m,MYFTYPE gImbar_Im);

void InitModel_K_Pst(MYFTYPE v,MYFTYPE &m,MYFTYPE &h,MYFTYPE gK_Pstbar_K_Pst);

void InitModel_K_Tst(MYFTYPE v,MYFTYPE &m,MYFTYPE &h,MYFTYPE gK_Tstbar_K_Tst);

void InitModel_Nap_Et2(MYFTYPE v,MYFTYPE &m,MYFTYPE &h,MYFTYPE gNap_Et2bar_Nap_Et2);

void InitModel_NaTa_t(MYFTYPE v,MYFTYPE &m,MYFTYPE &h,MYFTYPE gNaTa_tbar_NaTa_t);

void InitModel_NaTs2_t(MYFTYPE v,MYFTYPE &m,MYFTYPE &h,MYFTYPE gNaTs2_tbar_NaTs2_t);

void InitModel_pas(MYFTYPE v,MYFTYPE g_pas,MYFTYPE e_pas);

void InitModel_SK_E2(MYFTYPE v,MYFTYPE &z,MYFTYPE gSK_E2bar_SK_E2,MYFTYPE zTau_SK_E2, MYFTYPE cai,MYFTYPE &eca);

void InitModel_SKv3_1(MYFTYPE v,MYFTYPE &m,MYFTYPE gSKv3_1bar_SKv3_1);

#define CALL_TO_INIT_STATES  if(TheMMat.boolModel[seg+0*NSEG]){InitModel_Ca_HVA(V[seg],StatesM[0][seg] ,StatesM[1][seg] ,ParamsMSerial[0][comp], ica [ seg ],eca [ seg ],cai [ seg ]);}if(TheMMat.boolModel[seg+1*NSEG]){InitModel_Ca_LVAst(V[seg],StatesM[2][seg] ,StatesM[3][seg] ,ParamsMSerial[1][comp], ica [ seg ],eca [ seg ],cai [ seg ]);}if(TheMMat.boolModel[seg+2*NSEG]){InitModel_CaDynamics_E2(V[seg],cai [ seg ] ,ParamsMSerial[2][comp],ParamsMSerial[3][comp],ParamsMSerial[4][comp],ParamsMSerial[5][comp], ica [ seg ],eca [ seg ]);}if(TheMMat.boolModel[seg+3*NSEG]){InitModel_Ih(V[seg],StatesM[5][seg] ,ParamsMSerial[6][comp],ParamsMSerial[7][comp]);}if(TheMMat.boolModel[seg+4*NSEG]){InitModel_Im(V[seg],StatesM[6][seg] ,ParamsMSerial[8][comp]);}if(TheMMat.boolModel[seg+5*NSEG]){InitModel_K_Pst(V[seg],StatesM[7][seg] ,StatesM[8][seg] ,ParamsMSerial[9][comp]);}if(TheMMat.boolModel[seg+6*NSEG]){InitModel_K_Tst(V[seg],StatesM[9][seg] ,StatesM[10][seg] ,ParamsMSerial[10][comp]);}if(TheMMat.boolModel[seg+7*NSEG]){InitModel_Nap_Et2(V[seg],StatesM[11][seg] ,StatesM[12][seg] ,ParamsMSerial[11][comp]);}if(TheMMat.boolModel[seg+8*NSEG]){InitModel_NaTa_t(V[seg],StatesM[13][seg] ,StatesM[14][seg] ,ParamsMSerial[12][comp]);}if(TheMMat.boolModel[seg+9*NSEG]){InitModel_NaTs2_t(V[seg],StatesM[15][seg] ,StatesM[16][seg] ,ParamsMSerial[13][comp]);}if(TheMMat.boolModel[seg+10*NSEG]){InitModel_pas(V[seg],ParamsMSerial[14][comp],ParamsMSerial[15][comp]);}if(TheMMat.boolModel[seg+11*NSEG]){InitModel_SK_E2(V[seg],StatesM[17][seg] ,ParamsMSerial[16][comp],ParamsMSerial[17][comp], cai [ seg ],eca [ seg ]);}if(TheMMat.boolModel[seg+12*NSEG]){InitModel_SKv3_1(V[seg],StatesM[18][seg] ,ParamsMSerial[18][comp]);}

#define CALL_TO_DERIV  if(TheMMat.boolModel[seg+0*NSEG]){DerivModel_Ca_HVA(dt, V[seg],StatesM[0][seg] ,StatesM[1][seg] ,ParamsMSerial[0][comp], ica [ seg ]);}if(TheMMat.boolModel[seg+1*NSEG]){DerivModel_Ca_LVAst(dt, V[seg],StatesM[2][seg] ,StatesM[3][seg] ,ParamsMSerial[1][comp], ica [ seg ]);}if(TheMMat.boolModel[seg+2*NSEG]){DerivModel_CaDynamics_E2(dt, V[seg],cai [ seg ] ,ParamsMSerial[2][comp],ParamsMSerial[3][comp],ParamsMSerial[4][comp],ParamsMSerial[5][comp], ica [ seg ],eca [ seg ]);}if(TheMMat.boolModel[seg+3*NSEG]){DerivModel_Ih(dt, V[seg],StatesM[5][seg] ,ParamsMSerial[6][comp],ParamsMSerial[7][comp]);}if(TheMMat.boolModel[seg+4*NSEG]){DerivModel_Im(dt, V[seg],StatesM[6][seg] ,ParamsMSerial[8][comp]);}if(TheMMat.boolModel[seg+5*NSEG]){DerivModel_K_Pst(dt, V[seg],StatesM[7][seg] ,StatesM[8][seg] ,ParamsMSerial[9][comp]);}if(TheMMat.boolModel[seg+6*NSEG]){DerivModel_K_Tst(dt, V[seg],StatesM[9][seg] ,StatesM[10][seg] ,ParamsMSerial[10][comp]);}if(TheMMat.boolModel[seg+7*NSEG]){DerivModel_Nap_Et2(dt, V[seg],StatesM[11][seg] ,StatesM[12][seg] ,ParamsMSerial[11][comp]);}if(TheMMat.boolModel[seg+8*NSEG]){DerivModel_NaTa_t(dt, V[seg],StatesM[13][seg] ,StatesM[14][seg] ,ParamsMSerial[12][comp]);}if(TheMMat.boolModel[seg+9*NSEG]){DerivModel_NaTs2_t(dt, V[seg],StatesM[15][seg] ,StatesM[16][seg] ,ParamsMSerial[13][comp]);}if(TheMMat.boolModel[seg+10*NSEG]){}if(TheMMat.boolModel[seg+11*NSEG]){DerivModel_SK_E2(dt, V[seg],StatesM[17][seg] ,ParamsMSerial[16][comp],ParamsMSerial[17][comp], cai [ seg ],eca [ seg ]);}if(TheMMat.boolModel[seg+12*NSEG]){DerivModel_SKv3_1(dt, V[seg],StatesM[18][seg] ,ParamsMSerial[18][comp]);}

#define CALL_TO_BREAK  if(TheMMat.boolModel[seg+0*NSEG]){BreakpointModel_Ca_HVA(sumCurrents, sumConductivity, V[seg],StatesM[0][seg] ,StatesM[1][seg] ,ParamsMSerial[0][comp], ica [ seg ],eca [ seg ],cai [ seg ]);}if(TheMMat.boolModel[seg+1*NSEG]){BreakpointModel_Ca_LVAst(sumCurrents, sumConductivity, V[seg],StatesM[2][seg] ,StatesM[3][seg] ,ParamsMSerial[1][comp], ica [ seg ],eca [ seg ],cai [ seg ]);}if(TheMMat.boolModel[seg+2*NSEG]){BreakpointModel_CaDynamics_E2(sumCurrents, sumConductivity, V[seg],cai [ seg ] ,ParamsMSerial[2][comp],ParamsMSerial[3][comp],ParamsMSerial[4][comp],ParamsMSerial[5][comp], ica [ seg ],eca [ seg ]);}if(TheMMat.boolModel[seg+3*NSEG]){BreakpointModel_Ih(sumCurrents, sumConductivity, V[seg],StatesM[5][seg] ,ParamsMSerial[6][comp],ParamsMSerial[7][comp]);}if(TheMMat.boolModel[seg+4*NSEG]){BreakpointModel_Im(sumCurrents, sumConductivity, V[seg],StatesM[6][seg] ,ParamsMSerial[8][comp]);}if(TheMMat.boolModel[seg+5*NSEG]){BreakpointModel_K_Pst(sumCurrents, sumConductivity, V[seg],StatesM[7][seg] ,StatesM[8][seg] ,ParamsMSerial[9][comp]);}if(TheMMat.boolModel[seg+6*NSEG]){BreakpointModel_K_Tst(sumCurrents, sumConductivity, V[seg],StatesM[9][seg] ,StatesM[10][seg] ,ParamsMSerial[10][comp]);}if(TheMMat.boolModel[seg+7*NSEG]){BreakpointModel_Nap_Et2(sumCurrents, sumConductivity, V[seg],StatesM[11][seg] ,StatesM[12][seg] ,ParamsMSerial[11][comp]);}if(TheMMat.boolModel[seg+8*NSEG]){BreakpointModel_NaTa_t(sumCurrents, sumConductivity, V[seg],StatesM[13][seg] ,StatesM[14][seg] ,ParamsMSerial[12][comp]);}if(TheMMat.boolModel[seg+9*NSEG]){BreakpointModel_NaTs2_t(sumCurrents, sumConductivity, V[seg],StatesM[15][seg] ,StatesM[16][seg] ,ParamsMSerial[13][comp]);}if(TheMMat.boolModel[seg+10*NSEG]){BreakpointModel_pas(sumCurrents, sumConductivity, V[seg],ParamsMSerial[14][comp],ParamsMSerial[15][comp]);}if(TheMMat.boolModel[seg+11*NSEG]){BreakpointModel_SK_E2(sumCurrents, sumConductivity, V[seg],StatesM[17][seg] ,ParamsMSerial[16][comp],ParamsMSerial[17][comp], cai [ seg ],eca [ seg ]);}if(TheMMat.boolModel[seg+12*NSEG]){BreakpointModel_SKv3_1(sumCurrents, sumConductivity, V[seg],StatesM[18][seg] ,ParamsMSerial[18][comp]);}

#define CALL_TO_BREAK_DV  if(TheMMat.boolModel[seg+0*NSEG]){BreakpointModel_Ca_HVA(sumCurrentsDv, sumConductivityDv, V[seg]+0.001,StatesM[0][seg] ,StatesM[1][seg] ,ParamsMSerial[0][comp], temp,eca [ seg ],cai [ seg ]);}if(TheMMat.boolModel[seg+1*NSEG]){BreakpointModel_Ca_LVAst(sumCurrentsDv, sumConductivityDv, V[seg]+0.001,StatesM[2][seg] ,StatesM[3][seg] ,ParamsMSerial[1][comp], temp,eca [ seg ],cai [ seg ]);}if(TheMMat.boolModel[seg+2*NSEG]){BreakpointModel_CaDynamics_E2(sumCurrentsDv, sumConductivityDv, V[seg]+0.001,cai [ seg ] ,ParamsMSerial[2][comp],ParamsMSerial[3][comp],ParamsMSerial[4][comp],ParamsMSerial[5][comp], temp,eca [ seg ]);}if(TheMMat.boolModel[seg+3*NSEG]){BreakpointModel_Ih(sumCurrentsDv, sumConductivityDv, V[seg]+0.001,StatesM[5][seg] ,ParamsMSerial[6][comp],ParamsMSerial[7][comp]);}if(TheMMat.boolModel[seg+4*NSEG]){BreakpointModel_Im(sumCurrentsDv, sumConductivityDv, V[seg]+0.001,StatesM[6][seg] ,ParamsMSerial[8][comp]);}if(TheMMat.boolModel[seg+5*NSEG]){BreakpointModel_K_Pst(sumCurrentsDv, sumConductivityDv, V[seg]+0.001,StatesM[7][seg] ,StatesM[8][seg] ,ParamsMSerial[9][comp]);}if(TheMMat.boolModel[seg+6*NSEG]){BreakpointModel_K_Tst(sumCurrentsDv, sumConductivityDv, V[seg]+0.001,StatesM[9][seg] ,StatesM[10][seg] ,ParamsMSerial[10][comp]);}if(TheMMat.boolModel[seg+7*NSEG]){BreakpointModel_Nap_Et2(sumCurrentsDv, sumConductivityDv, V[seg]+0.001,StatesM[11][seg] ,StatesM[12][seg] ,ParamsMSerial[11][comp]);}if(TheMMat.boolModel[seg+8*NSEG]){BreakpointModel_NaTa_t(sumCurrentsDv, sumConductivityDv, V[seg]+0.001,StatesM[13][seg] ,StatesM[14][seg] ,ParamsMSerial[12][comp]);}if(TheMMat.boolModel[seg+9*NSEG]){BreakpointModel_NaTs2_t(sumCurrentsDv, sumConductivityDv, V[seg]+0.001,StatesM[15][seg] ,StatesM[16][seg] ,ParamsMSerial[13][comp]);}if(TheMMat.boolModel[seg+10*NSEG]){BreakpointModel_pas(sumCurrentsDv, sumConductivityDv, V[seg]+0.001,ParamsMSerial[14][comp],ParamsMSerial[15][comp]);}if(TheMMat.boolModel[seg+11*NSEG]){BreakpointModel_SK_E2(sumCurrentsDv, sumConductivityDv, V[seg]+0.001,StatesM[17][seg] ,ParamsMSerial[16][comp],ParamsMSerial[17][comp], cai [ seg ],eca [ seg ]);}if(TheMMat.boolModel[seg+12*NSEG]){BreakpointModel_SKv3_1(sumCurrentsDv, sumConductivityDv, V[seg]+0.001,StatesM[18][seg] ,ParamsMSerial[18][comp]);}


#endif