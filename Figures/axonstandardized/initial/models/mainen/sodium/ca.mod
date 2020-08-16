COMMENT
ca.mod
Uses fixed eca instead of GHK eqn

HVA Ca current
Based on Reuveni, Friedman, Amitai and Gutnick (1993)
J. Neurosci. 13:4609-4621.

Author: Zach Mainen, Salk Institute, 1994, zach@salk.edu

26 Ago 2002 Modification of original channel to allow 
variable time step and to correct an initialization error.
Done by Michael Hines(michael.hines@yale.e) and 
Ruggero Scorcioni(rscorcio@gmu.edu) at EU Advance Course 
in Computational Neuroscience. Obidos, Portugal

20110202 made threadsafe by Ted Carnevale
20120514 fixed singularity in PROCEDURE rates

Special comment:

This mechanism was designed to be run at a single operating 
temperature--37 deg C--which can be specified by the hoc 
assignment statement
celsius = 37
This mechanism is not intended to be used at other temperatures, 
or to investigate the effects of temperature changes.

Zach Mainen created this particular model by adapting conductances 
from lower temperature to run at higher temperature, and found it 
necessary to reduce the temperature sensitivity of spike amplitude 
and time course.  He accomplished this by increasing the net ionic 
conductance through the heuristic of changing the standard HH 
formula
  g = gbar*product_of_gating_variables
to
  g = tadj*gbar*product_of_gating_variables
where
  tadj = q10^((celsius - temp)/10)
  temp is the "reference temperature" (at which the gating variable
    time constants were originally determined)
  celsius is the "operating temperature"

Users should note that this is equivalent to changing the channel 
density from gbar at the "reference temperature" temp (the 
temperature at which the at which the gating variable time 
constants were originally determined) to tadj*gbar at the 
"operating temperature" celsius.
ENDCOMMENT

NEURON {
    THREADSAFE
	SUFFIX ca
	USEION ca READ eca WRITE ica
	RANGE m, h, gca, gbar
	RANGE minf, hinf, mtau, htau
	GLOBAL q10, temp, tadj, vmin, vmax, vshift
}

UNITS {
	(mA) = (milliamp)
	(mV) = (millivolt)
	(pS) = (picosiemens)
	(um) = (micron)
    (mM) = (milli/liter)
	FARADAY = (faraday) (coulomb)
	R = (k-mole) (joule/degC)
	PI	= (pi) (1)
} 

PARAMETER {
	gbar = 0.1   	(pS/um2)	: 0.12 mho/cm2
	vshift = 0	(mV)		: voltage shift (affects all)
	cao  = 2.5	(mM)	        : external ca concentration
	cai		(mM)
	temp = 23	(degC)		: original temp 
	q10  = 2.3			: temperature sensitivity
	vmin = -120	(mV)
	vmax = 100	(mV)
	:"m" calcium activation system
	:a = 0.209*efun(-(27+vm)/3.8)
	mul_a_m = 0.209
	vshift_a_m = 27 
	expdiv_a_m=3.8
	:b = 0.94*exp((-75-vm)/17)
	mul_b_m = 0.94
	vshift_b_m = -75
	expdiv_b_m=17
	:"h" inactivation 
	:a = 0.000457*exp((-13-vm)/50)
	mul_a_h = 0.000457
	vshift_a_h = -13
	expdiv_a_h= 50
	:b = 0.0065/(exp((-vm-15)/28) + 1)
	mul_b_h = 0.0065
	vshift_b_h = -15
	expdiv_b_h= 28
}

ASSIGNED {
	v 		(mV)
	celsius		(degC)
	ica 		(mA/cm2)
	gca		(pS/um2)
	eca		(mV)
	minf 		hinf
	mtau (ms)	htau (ms)
	tadj
}
 
STATE { m h }

INITIAL {
    tadj = q10^((celsius - temp)/(10 (degC))) : make all threads calculate tadj at initialization

	trates(v+vshift)
	m = minf
	h = hinf
}

BREAKPOINT {
    SOLVE states METHOD cnexp
    gca = tadj*gbar*m*m*h
    ica = (1e-4) * gca * (v - eca)
} 

: LOCAL mexp, hexp

:PROCEDURE states() {
:        trates(v+vshift)      
:        m = m + mexp*(minf-m)
:        h = h + hexp*(hinf-h)
:	VERBATIM
:	return 0;
:	ENDVERBATIM
:}

DERIVATIVE states {
        trates(v+vshift)      
        m' =  (minf-m)/mtau
        h' =  (hinf-h)/htau
}

PROCEDURE trates(v (mV)) {  
    TABLE minf, hinf, mtau, htau
    DEPEND celsius, temp
    FROM vmin TO vmax WITH 199

	rates(v): not consistently executed from here if usetable == 1

:        tinc = -dt * tadj
:        mexp = 1 - exp(tinc/mtau)
:        hexp = 1 - exp(tinc/htau)
}


UNITSOFF
PROCEDURE rates(vm (mV)) {  
        LOCAL  a, b

    tadj = q10^((celsius - temp)/(10 (degC)))

:   a = 0.055*(-27 - vm)/(exp((-27-vm)/3.8) - 1)
: singular at vm = -27
:   a = 0.055*3.8*(-27 - vm)/3.8)/(exp((-27-vm)/3.8) - 1)
: let z = (-27 - vm)/3.8
:   a = 0.055*3.8*z/(exp(z) - 1)
	: a = 0.209*efun(-(27+vm)/3.8)
    a = mul_a_m*efun(-(vshift_a_m+vm)/expdiv_a_m)
	:b = 0.94*exp((-75-vm)/17)
	b = mul_b_m*exp((vshift_b_m-vm)/expdiv_b_m)
	mtau = 1/tadj/(a+b)
	minf = a/(a+b)

	:"h" inactivation 
	:a = 0.000457*exp((-13-vm)/50)
	a = mul_a_h*exp((vshift_a_h-vm)/expdiv_a_h)
	:b = 0.0065/(exp((-vm-15)/28) + 1)
	b = mul_b_h/(exp((-vm+vshift_b_h)/expdiv_b_h) + 1)
	htau = 1/tadj/(a+b)
	hinf = a/(a+b)
}
UNITSON

FUNCTION efun(z) {
	if (fabs(z) < 1e-4) {
		efun = 1 - z/2
	}else{
		efun = z/(exp(z) - 1)
	}
}
