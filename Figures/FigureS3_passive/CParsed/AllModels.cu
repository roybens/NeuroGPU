// Automatically generated CU for E:\GitHub\NeuroGPU\Figures\FigureS3_passive_mew./runModel.hoc
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "cuda_runtime.h"
#include "device_launch_parameters.h"
#include "AllModels.cuh"

// Universals:
#define PI (3.1415927f)
#define R (8.31441f)
#define FARADAY (96485.309f)
#define ktf (1000.*8.3134*(celsius + 273.15)/FARADAY)
#define DEF_vrest	-65.
#define DEF_nai 10.
#define DEF_nao 140.
#define DEF_ena (115. + DEF_vrest)
#define DEF_ki	54.4
#define DEF_ko 2.5
#define DEF_ek (-12. + DEF_vrest)
#include <math.h>
#define DEF_cai	5.e-5
#define DEF_cao	2.
#define	DEF_eca		12.5 *log(DEF_cao / DEF_cai)

// GGlobals:
#define celsius (6.3)
#define stoprun (0.0)
#define clamp_resist (0.001)
#define secondorder (0.0)

// NGlobals:

// Declarations:
float Cunernst(float ci,float co, float z) {
	if (z == 0) {
		return 0.;
	}
	if (ci <= 0.) {
		return 1e6;
	}else if (co <= 0.) {
		return -1e6;
	}else{
		return ktf/z*log(co/ci);
	}	
}

// Functions:

// Procedures:

// Inits:


__device__ void CuInitModel_pas(MYFTYPE v,MYFTYPE g_pas,MYFTYPE e_pas){
};

// Derivs:

// Breaks:


__device__ void CuBreakpointModel_pas(MYSECONDFTYPE &sumCurrents, MYFTYPE &sumConductivity, MYFTYPE v,MYFTYPE g_pas,MYFTYPE e_pas) {
MYFTYPE;
MYFTYPE i;
   i = g_pas * ( v - e_pas ) ;
i = i;

sumCurrents+= i;
sumConductivity+= g_pas;
};
