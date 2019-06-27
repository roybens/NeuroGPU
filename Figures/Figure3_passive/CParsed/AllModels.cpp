// Automatically generated C for E:\GitHub\NeuroGPU\Figures\Figure3_passive./runModel.hoc
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "AllModels.h"

// Universals:
#define PI (3.1415927f)
#define R (8.31441f)
#define FARADAY (96485.309f)
#define ktf (1000.*8.3134*(celsius + 273.15)/FARADAY)


// Locals:
MYFTYPE ;

// Ion currents as Locals:
MYFTYPE ;

// NGlobals:

// Declarations:

// Functions:

// Inits:


void InitModel_pas(MYFTYPE v,MYFTYPE g_pas,MYFTYPE e_pas){
};

// Procedures:

// Derivs:

// Breaks:


void BreakpointModel_pas(MYSECONDFTYPE &sumCurrents, MYFTYPE &sumConductivity, MYFTYPE v,MYFTYPE g_pas,MYFTYPE e_pas) {
   i = g_pas * ( v - e_pas ) ;
i = i;

sumCurrents+= i;
sumConductivity+= g_pas;
};
