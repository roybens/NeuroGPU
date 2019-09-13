// Automatically generated CUH for C:\Users\Maxwell Chen\Desktop\NeuroGPU\Figures\Figure4_mainen./runModel.hoc

#ifndef __ALLMODELSCU__
#define __ALLMODELSCU__
#include "Util.h"

#include "cuda_runtime.h"
#include "device_launch_parameters.h"

#define NSEG 384
#define NCOMPS 177
#define LOG_N_DEPTH 6
#define N_MODELS 7
#define N_FATHERS 99
#define N_CALL_FOR_FATHER 186
#define COMP_DEPTH 26
#define N_L_REL 24
#define N_F_L_REL 23
#define NILP 12
#define NSTATES 8
#define NPARAMS 34

#define NTRACES 1

__device__ void CuInitModel_ca(MYFTYPE v,MYFTYPE &m,MYFTYPE &h,MYFTYPE gbar_ca,MYFTYPE cao_ca, MYFTYPE cai, MYFTYPE &ica,MYFTYPE &eca);
__device__ void CuInitModel_cad(MYFTYPE v,MYFTYPE &ca, MYFTYPE ica, MYFTYPE &cai,MYFTYPE &eca);
__device__ void CuInitModel_kca(MYFTYPE v,MYFTYPE &n,MYFTYPE gbar_kca,MYFTYPE caix_kca,MYFTYPE Ra_kca,MYFTYPE Rb_kca, MYFTYPE cai,MYFTYPE &eca);
__device__ void CuInitModel_km(MYFTYPE v,MYFTYPE &n,MYFTYPE gbar_km,MYFTYPE tha_km,MYFTYPE qa_km,MYFTYPE Ra_km,MYFTYPE Rb_km);
__device__ void CuInitModel_kv(MYFTYPE v,MYFTYPE &n,MYFTYPE gbar_kv,MYFTYPE tha_kv,MYFTYPE qa_kv,MYFTYPE Ra_kv,MYFTYPE Rb_kv);
__device__ void CuInitModel_na(MYFTYPE v,MYFTYPE &m,MYFTYPE &h,MYFTYPE gbar_na,MYFTYPE tha_na,MYFTYPE qa_na,MYFTYPE Ra_na,MYFTYPE Rb_na,MYFTYPE thi1_na,MYFTYPE thi2_na,MYFTYPE qi_na,MYFTYPE thinf_na,MYFTYPE qinf_na,MYFTYPE Rg_na,MYFTYPE Rd_na);
__device__ void CuInitModel_pas(MYFTYPE v,MYFTYPE g_pas,MYFTYPE e_pas);
__device__ void CuInitModel_pas2(MYFTYPE v,MYFTYPE g_pas2,MYFTYPE e_pas2);
__device__ void CuInitModel_pasx(MYFTYPE v,MYFTYPE g_pasx,MYFTYPE e_pasx);
__device__ void CuDerivModel_ca(MYFTYPE dt, MYFTYPE v,MYFTYPE &m,MYFTYPE &h,MYFTYPE gbar_ca,MYFTYPE cao_ca, MYFTYPE cai, MYFTYPE &ica,MYFTYPE &eca);
__device__ void CuDerivModel_cad(MYFTYPE dt, MYFTYPE v,MYFTYPE &ca, MYFTYPE ica, MYFTYPE &cai,MYFTYPE &eca);
__device__ void CuDerivModel_kca(MYFTYPE dt, MYFTYPE v,MYFTYPE &n,MYFTYPE gbar_kca,MYFTYPE caix_kca,MYFTYPE Ra_kca,MYFTYPE Rb_kca, MYFTYPE cai,MYFTYPE &eca);
__device__ void CuDerivModel_km(MYFTYPE dt, MYFTYPE v,MYFTYPE &n,MYFTYPE gbar_km,MYFTYPE tha_km,MYFTYPE qa_km,MYFTYPE Ra_km,MYFTYPE Rb_km);
__device__ void CuDerivModel_kv(MYFTYPE dt, MYFTYPE v,MYFTYPE &n,MYFTYPE gbar_kv,MYFTYPE tha_kv,MYFTYPE qa_kv,MYFTYPE Ra_kv,MYFTYPE Rb_kv);
__device__ void CuDerivModel_na(MYFTYPE dt, MYFTYPE v,MYFTYPE &m,MYFTYPE &h,MYFTYPE gbar_na,MYFTYPE tha_na,MYFTYPE qa_na,MYFTYPE Ra_na,MYFTYPE Rb_na,MYFTYPE thi1_na,MYFTYPE thi2_na,MYFTYPE qi_na,MYFTYPE thinf_na,MYFTYPE qinf_na,MYFTYPE Rg_na,MYFTYPE Rd_na);
__device__ void CuBreakpointModel_ca(MYSECONDFTYPE &sumCurrents, MYFTYPE &sumConductivity, MYFTYPE v,MYFTYPE &m,MYFTYPE &h,MYFTYPE gbar_ca,MYFTYPE cao_ca, MYFTYPE cai, MYFTYPE &ica,MYFTYPE &eca) ;

__device__ void CuBreakpointModel_cad(MYSECONDFTYPE &sumCurrents, MYFTYPE &sumConductivity, MYFTYPE v,MYFTYPE &ca, MYFTYPE ica, MYFTYPE &cai,MYFTYPE &eca) ;

__device__ void CuBreakpointModel_kca(MYSECONDFTYPE &sumCurrents, MYFTYPE &sumConductivity, MYFTYPE v,MYFTYPE &n,MYFTYPE gbar_kca,MYFTYPE caix_kca,MYFTYPE Ra_kca,MYFTYPE Rb_kca, MYFTYPE cai,MYFTYPE &eca) ;

__device__ void CuBreakpointModel_km(MYSECONDFTYPE &sumCurrents, MYFTYPE &sumConductivity, MYFTYPE v,MYFTYPE &n,MYFTYPE gbar_km,MYFTYPE tha_km,MYFTYPE qa_km,MYFTYPE Ra_km,MYFTYPE Rb_km) ;

__device__ void CuBreakpointModel_kv(MYSECONDFTYPE &sumCurrents, MYFTYPE &sumConductivity, MYFTYPE v,MYFTYPE &n,MYFTYPE gbar_kv,MYFTYPE tha_kv,MYFTYPE qa_kv,MYFTYPE Ra_kv,MYFTYPE Rb_kv) ;

__device__ void CuBreakpointModel_na(MYSECONDFTYPE &sumCurrents, MYFTYPE &sumConductivity, MYFTYPE v,MYFTYPE &m,MYFTYPE &h,MYFTYPE gbar_na,MYFTYPE tha_na,MYFTYPE qa_na,MYFTYPE Ra_na,MYFTYPE Rb_na,MYFTYPE thi1_na,MYFTYPE thi2_na,MYFTYPE qi_na,MYFTYPE thinf_na,MYFTYPE qinf_na,MYFTYPE Rg_na,MYFTYPE Rd_na) ;

__device__ void CuBreakpointModel_pas(MYSECONDFTYPE &sumCurrents, MYFTYPE &sumConductivity, MYFTYPE v,MYFTYPE g_pas,MYFTYPE e_pas) ;

__device__ void CuBreakpointModel_pas2(MYSECONDFTYPE &sumCurrents, MYFTYPE &sumConductivity, MYFTYPE v,MYFTYPE g_pas2,MYFTYPE e_pas2) ;

__device__ void CuBreakpointModel_pasx(MYSECONDFTYPE &sumCurrents, MYFTYPE &sumConductivity, MYFTYPE v,MYFTYPE g_pasx,MYFTYPE e_pasx) ;



#define SET_STATES(VARILP) ModelStates_## VARILP [0]=0; ModelStates_## VARILP [1]=0; ModelStates_## VARILP [2]=0; ModelStates_## VARILP [3]=0; ModelStates_## VARILP [4]=0; ModelStates_## VARILP [5]=0; ModelStates_## VARILP [6]=0; ModelStates_## VARILP [7]=0; ; 


#define CALL_TO_INIT_STATES_CU(VARILP) if(cBoolModel[PIdx[count] +0*NSEG]){CuInitModel_ca(v[count],state_macro(0,count) ,state_macro(1,count) ,param_macro(0, PIdx[count]) ,param_macro(1, PIdx[count]) , cai[count] , ica[count] ,eca[count] );}if(cBoolModel[PIdx[count] +1*NSEG]){CuInitModel_cad(v[count],state_macro(2,count) , ica[count] , cai[count] ,eca[count] );}if(cBoolModel[PIdx[count] +2*NSEG]){CuInitModel_kca(v[count],state_macro(3,count) ,param_macro(2, PIdx[count]) ,param_macro(3, PIdx[count]) ,param_macro(4, PIdx[count]) ,param_macro(5, PIdx[count]) , cai[count] ,eca[count] );}if(cBoolModel[PIdx[count] +3*NSEG]){CuInitModel_km(v[count],state_macro(4,count) ,param_macro(6, PIdx[count]) ,param_macro(7, PIdx[count]) ,param_macro(8, PIdx[count]) ,param_macro(9, PIdx[count]) ,param_macro(10, PIdx[count]) );}if(cBoolModel[PIdx[count] +4*NSEG]){CuInitModel_kv(v[count],state_macro(5,count) ,param_macro(11, PIdx[count]) ,param_macro(12, PIdx[count]) ,param_macro(13, PIdx[count]) ,param_macro(14, PIdx[count]) ,param_macro(15, PIdx[count]) );}if(cBoolModel[PIdx[count] +5*NSEG]){CuInitModel_na(v[count],state_macro(6,count) ,state_macro(7,count) ,param_macro(16, PIdx[count]) ,param_macro(17, PIdx[count]) ,param_macro(18, PIdx[count]) ,param_macro(19, PIdx[count]) ,param_macro(20, PIdx[count]) ,param_macro(21, PIdx[count]) ,param_macro(22, PIdx[count]) ,param_macro(23, PIdx[count]) ,param_macro(24, PIdx[count]) ,param_macro(25, PIdx[count]) ,param_macro(26, PIdx[count]) ,param_macro(27, PIdx[count]) );}if(cBoolModel[PIdx[count] +6*NSEG]){CuInitModel_pas(v[count],param_macro(28, PIdx[count]) ,param_macro(29, PIdx[count]) );}if(cBoolModel[PIdx[count] +7*NSEG]){CuInitModel_pas2(v[count],param_macro(30, PIdx[count]) ,param_macro(31, PIdx[count]) );}if(cBoolModel[PIdx[count] +8*NSEG]){CuInitModel_pasx(v[count],param_macro(32, PIdx[count]) ,param_macro(33, PIdx[count]) );}

#define CALL_TO_DERIV_CU(VARILP)   if(cBoolModel[PIdx[count] +0*NSEG]){CuDerivModel_ca(dt, v[count],state_macro(0,count) ,state_macro(1,count) ,param_macro(0, PIdx[count]) ,param_macro(1, PIdx[count]) , cai[count] , ica[count] ,eca[count] );}if(cBoolModel[PIdx[count] +1*NSEG]){CuDerivModel_cad(dt, v[count],state_macro(2,count) , ica[count] , cai[count] ,eca[count] );}if(cBoolModel[PIdx[count] +2*NSEG]){CuDerivModel_kca(dt, v[count],state_macro(3,count) ,param_macro(2, PIdx[count]) ,param_macro(3, PIdx[count]) ,param_macro(4, PIdx[count]) ,param_macro(5, PIdx[count]) , cai[count] ,eca[count] );}if(cBoolModel[PIdx[count] +3*NSEG]){CuDerivModel_km(dt, v[count],state_macro(4,count) ,param_macro(6, PIdx[count]) ,param_macro(7, PIdx[count]) ,param_macro(8, PIdx[count]) ,param_macro(9, PIdx[count]) ,param_macro(10, PIdx[count]) );}if(cBoolModel[PIdx[count] +4*NSEG]){CuDerivModel_kv(dt, v[count],state_macro(5,count) ,param_macro(11, PIdx[count]) ,param_macro(12, PIdx[count]) ,param_macro(13, PIdx[count]) ,param_macro(14, PIdx[count]) ,param_macro(15, PIdx[count]) );}if(cBoolModel[PIdx[count] +5*NSEG]){CuDerivModel_na(dt, v[count],state_macro(6,count) ,state_macro(7,count) ,param_macro(16, PIdx[count]) ,param_macro(17, PIdx[count]) ,param_macro(18, PIdx[count]) ,param_macro(19, PIdx[count]) ,param_macro(20, PIdx[count]) ,param_macro(21, PIdx[count]) ,param_macro(22, PIdx[count]) ,param_macro(23, PIdx[count]) ,param_macro(24, PIdx[count]) ,param_macro(25, PIdx[count]) ,param_macro(26, PIdx[count]) ,param_macro(27, PIdx[count]) );}if(cBoolModel[PIdx[count] +6*NSEG]){}if(cBoolModel[PIdx[count] +7*NSEG]){}if(cBoolModel[PIdx[count] +8*NSEG]){}

#define CALL_TO_BREAK_CU(VARILP)   if(cBoolModel[PIdx[count] +0*NSEG]){CuBreakpointModel_ca(sumCurrents[count] , sumConductivity[count],v[count] ,state_macro(0,count) ,state_macro(1,count) ,param_macro(0, PIdx[count]) ,param_macro(1, PIdx[count]) , cai[count] , ica[count] ,eca[count] );}if(cBoolModel[PIdx[count] +1*NSEG]){CuBreakpointModel_cad(sumCurrents[count] , sumConductivity[count],v[count] ,state_macro(2,count) , ica[count] , cai[count] ,eca[count] );}if(cBoolModel[PIdx[count] +2*NSEG]){CuBreakpointModel_kca(sumCurrents[count] , sumConductivity[count],v[count] ,state_macro(3,count) ,param_macro(2, PIdx[count]) ,param_macro(3, PIdx[count]) ,param_macro(4, PIdx[count]) ,param_macro(5, PIdx[count]) , cai[count] ,eca[count] );}if(cBoolModel[PIdx[count] +3*NSEG]){CuBreakpointModel_km(sumCurrents[count] , sumConductivity[count],v[count] ,state_macro(4,count) ,param_macro(6, PIdx[count]) ,param_macro(7, PIdx[count]) ,param_macro(8, PIdx[count]) ,param_macro(9, PIdx[count]) ,param_macro(10, PIdx[count]) );}if(cBoolModel[PIdx[count] +4*NSEG]){CuBreakpointModel_kv(sumCurrents[count] , sumConductivity[count],v[count] ,state_macro(5,count) ,param_macro(11, PIdx[count]) ,param_macro(12, PIdx[count]) ,param_macro(13, PIdx[count]) ,param_macro(14, PIdx[count]) ,param_macro(15, PIdx[count]) );}if(cBoolModel[PIdx[count] +5*NSEG]){CuBreakpointModel_na(sumCurrents[count] , sumConductivity[count],v[count] ,state_macro(6,count) ,state_macro(7,count) ,param_macro(16, PIdx[count]) ,param_macro(17, PIdx[count]) ,param_macro(18, PIdx[count]) ,param_macro(19, PIdx[count]) ,param_macro(20, PIdx[count]) ,param_macro(21, PIdx[count]) ,param_macro(22, PIdx[count]) ,param_macro(23, PIdx[count]) ,param_macro(24, PIdx[count]) ,param_macro(25, PIdx[count]) ,param_macro(26, PIdx[count]) ,param_macro(27, PIdx[count]) );}if(cBoolModel[PIdx[count] +6*NSEG]){CuBreakpointModel_pas(sumCurrents[count] , sumConductivity[count],v[count] ,param_macro(28, PIdx[count]) ,param_macro(29, PIdx[count]) );}if(cBoolModel[PIdx[count] +7*NSEG]){CuBreakpointModel_pas2(sumCurrents[count] , sumConductivity[count],v[count] ,param_macro(30, PIdx[count]) ,param_macro(31, PIdx[count]) );}if(cBoolModel[PIdx[count] +8*NSEG]){CuBreakpointModel_pasx(sumCurrents[count] , sumConductivity[count],v[count] ,param_macro(32, PIdx[count]) ,param_macro(33, PIdx[count]) );}

#define CALL_TO_BREAK_DV_CU(VARILP)    if(cBoolModel[PIdx[count] +0*NSEG]){CuBreakpointModel_ca(sumCurrentsDv[count] , sumConductivityDv[count] ,v[count] +0.001,state_macro(0,count) ,state_macro(1,count) ,param_macro(0, PIdx[count]) ,param_macro(1, PIdx[count]) , cai[count] , temp,eca[count] );}if(cBoolModel[PIdx[count] +1*NSEG]){CuBreakpointModel_cad(sumCurrentsDv[count] , sumConductivityDv[count] ,v[count] +0.001,state_macro(2,count) , temp, cai[count] ,eca[count] );}if(cBoolModel[PIdx[count] +2*NSEG]){CuBreakpointModel_kca(sumCurrentsDv[count] , sumConductivityDv[count] ,v[count] +0.001,state_macro(3,count) ,param_macro(2, PIdx[count]) ,param_macro(3, PIdx[count]) ,param_macro(4, PIdx[count]) ,param_macro(5, PIdx[count]) , cai[count] ,eca[count] );}if(cBoolModel[PIdx[count] +3*NSEG]){CuBreakpointModel_km(sumCurrentsDv[count] , sumConductivityDv[count] ,v[count] +0.001,state_macro(4,count) ,param_macro(6, PIdx[count]) ,param_macro(7, PIdx[count]) ,param_macro(8, PIdx[count]) ,param_macro(9, PIdx[count]) ,param_macro(10, PIdx[count]) );}if(cBoolModel[PIdx[count] +4*NSEG]){CuBreakpointModel_kv(sumCurrentsDv[count] , sumConductivityDv[count] ,v[count] +0.001,state_macro(5,count) ,param_macro(11, PIdx[count]) ,param_macro(12, PIdx[count]) ,param_macro(13, PIdx[count]) ,param_macro(14, PIdx[count]) ,param_macro(15, PIdx[count]) );}if(cBoolModel[PIdx[count] +5*NSEG]){CuBreakpointModel_na(sumCurrentsDv[count] , sumConductivityDv[count] ,v[count] +0.001,state_macro(6,count) ,state_macro(7,count) ,param_macro(16, PIdx[count]) ,param_macro(17, PIdx[count]) ,param_macro(18, PIdx[count]) ,param_macro(19, PIdx[count]) ,param_macro(20, PIdx[count]) ,param_macro(21, PIdx[count]) ,param_macro(22, PIdx[count]) ,param_macro(23, PIdx[count]) ,param_macro(24, PIdx[count]) ,param_macro(25, PIdx[count]) ,param_macro(26, PIdx[count]) ,param_macro(27, PIdx[count]) );}if(cBoolModel[PIdx[count] +6*NSEG]){CuBreakpointModel_pas(sumCurrentsDv[count] , sumConductivityDv[count] ,v[count] +0.001,param_macro(28, PIdx[count]) ,param_macro(29, PIdx[count]) );}if(cBoolModel[PIdx[count] +7*NSEG]){CuBreakpointModel_pas2(sumCurrentsDv[count] , sumConductivityDv[count] ,v[count] +0.001,param_macro(30, PIdx[count]) ,param_macro(31, PIdx[count]) );}if(cBoolModel[PIdx[count] +8*NSEG]){CuBreakpointModel_pasx(sumCurrentsDv[count] , sumConductivityDv[count] ,v[count] +0.001,param_macro(32, PIdx[count]) ,param_macro(33, PIdx[count]) );}


#endif