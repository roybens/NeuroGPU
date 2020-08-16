// Automatically generated CUH for E:\GitHub\NeuroGPU\Figures\FigureS3_passive_mew./runModel.hoc

#ifndef __ALLMODELSCU__
#define __ALLMODELSCU__
#include "Util.h"

#include "cuda_runtime.h"
#include "device_launch_parameters.h"

#define NSEG 384
#define NCOMPS 177
#define LOG_N_DEPTH 6
#define N_MODELS 1
#define N_FATHERS 99
#define N_CALL_FOR_FATHER 186
#define COMP_DEPTH 18
#define N_L_REL 16
#define N_F_L_REL 15
#define NILP 12
#define NSTATES 1//actually zero
#define NPARAMS 2

#define NTRACES 1

__device__ void CuInitModel_pas(MYFTYPE v,MYFTYPE g_pas,MYFTYPE e_pas);
__device__ void CuBreakpointModel_pas(MYSECONDFTYPE &sumCurrents, MYFTYPE &sumConductivity, MYFTYPE v,MYFTYPE g_pas,MYFTYPE e_pas) ;



#define SET_STATES(VARILP) ; 


#define CALL_TO_INIT_STATES_CU(VARILP) if(cBoolModel[PIdx[count] +0*NSEG]){CuInitModel_pas(v[count],param_macro(0, PIdx[count]) ,param_macro(1, PIdx[count]) );}

#define CALL_TO_DERIV_CU(VARILP)   if(cBoolModel[PIdx[count] +0*NSEG]){}

#define CALL_TO_BREAK_CU(VARILP)   if(cBoolModel[PIdx[count] +0*NSEG]){CuBreakpointModel_pas(sumCurrents[count] , sumConductivity[count],v[count] ,param_macro(0, PIdx[count]) ,param_macro(1, PIdx[count]) );}

#define CALL_TO_BREAK_DV_CU(VARILP)    if(cBoolModel[PIdx[count] +0*NSEG]){CuBreakpointModel_pas(sumCurrentsDv[count] , sumConductivityDv[count] ,v[count] +0.001,param_macro(0, PIdx[count]) ,param_macro(1, PIdx[count]) );}


#endif