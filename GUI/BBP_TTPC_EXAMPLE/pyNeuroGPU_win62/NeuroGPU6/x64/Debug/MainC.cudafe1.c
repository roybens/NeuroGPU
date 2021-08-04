#line 1 "E:/Workspace/SinglePrec/pyNeuroGPU_win2/NeuroGPU6/MainC.cu"
#line 22 "E:/Workspace/SinglePrec/pyNeuroGPU_win2/NeuroGPU6/MainC.cu"
HMat TheMMat = {0};
Stim stim = {0};
Sim sim = {0};
extern char debugFN[10];
FILE *fdebug = 0;
#line 26 "E:/Workspace/SinglePrec/pyNeuroGPU_win2/NeuroGPU6/MainC.cu"
FILE *fdebug2 = 0;
#line 26 "E:/Workspace/SinglePrec/pyNeuroGPU_win2/NeuroGPU6/MainC.cu"
FILE *fdebug3 = 0;
double **ParamsMSerial = 0;
double *ParamsM = 0;
double *InitStatesM = 0;
int NSets = 0;
short FParams = 0;
short comp = 0;
double *V = 0;

double *VV = 0;
double **StatesM = 0;
#line 87 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.17763.0\\ucrt\\corecrt_stdio_config.h"
 /* COMDAT group: _ZZ28__local_stdio_printf_optionsE15_OptionsStorage */ unsigned __int64 _ZZ28__local_stdio_printf_optionsE15_OptionsStorage;
#line 119 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2017\\Community\\VC\\Tools\\MSVC\\14.16.27023\\include\\xlocnum"
extern __declspec( dllimport ) struct _ZNSt6locale2idE _ZNSt8numpunctIcE2idE;
#line 119 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2017\\Community\\VC\\Tools\\MSVC\\14.16.27023\\include\\xlocnum"
extern __declspec( dllimport ) struct _ZNSt6locale2idE _ZNSt8numpunctIwE2idE;
#line 25 "E:/Workspace/SinglePrec/pyNeuroGPU_win2/NeuroGPU6/MainC.cu"
char debugFN[10] = "Debug.dat";
