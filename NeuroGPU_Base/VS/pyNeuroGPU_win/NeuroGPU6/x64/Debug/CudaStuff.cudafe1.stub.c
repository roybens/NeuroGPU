#define __NV_MODULE_ID _17_CudaStuff_cpp1_ii_25c14e70
#define __NV_CUBIN_HANDLE_STORAGE__ extern
#if !defined(__CUDA_INCLUDE_COMPILER_INTERNAL_HEADERS__)
#define __CUDA_INCLUDE_COMPILER_INTERNAL_HEADERS__
#endif
#include "crt/host_runtime.h"
#include "CudaStuff.fatbin.c"
extern void __device_stub__Z14NeuroGPUKernel4StimPdS0_3Sim4HMatS0_S0_ss(Stim&, double *, double *, Sim&, HMat&, double *, double *, short, short);
static void __nv_cudaEntityRegisterCallback(void **);
static void __sti____cudaRegisterAll(void);
#pragma section(".CRT$XCU",read)
__declspec(allocate(".CRT$XCU"))static void (*__dummy_static_init__sti____cudaRegisterAll[])(void) = {__sti____cudaRegisterAll};
void __device_stub__Z14NeuroGPUKernel4StimPdS0_3Sim4HMatS0_S0_ss(
Stim&__par0, 
double *__par1, 
double *__par2, 
Sim&__par3, 
HMat&__par4, 
double *__par5, 
double *__par6, 
short __par7, 
short __par8)
{
__cudaLaunchPrologue(9);
__cudaSetupArg(__par0, 0Ui64);
__cudaSetupArgSimple(__par1, 56Ui64);
__cudaSetupArgSimple(__par2, 64Ui64);
__cudaSetupArg(__par3, 72Ui64);
__cudaSetupArg(__par4, 120Ui64);
__cudaSetupArgSimple(__par5, 328Ui64);
__cudaSetupArgSimple(__par6, 336Ui64);
__cudaSetupArgSimple(__par7, 344Ui64);
__cudaSetupArgSimple(__par8, 346Ui64);
__cudaLaunch(((char *)((void ( *)(Stim, double *, double *, Sim, HMat, double *, double *, short, short))NeuroGPUKernel)));
}
void NeuroGPUKernel( Stim __cuda_0,double *__cuda_1,double *__cuda_2,Sim __cuda_3,HMat __cuda_4,double *__cuda_5,double *__cuda_6,short __cuda_7,short __cuda_8)
{__device_stub__Z14NeuroGPUKernel4StimPdS0_3Sim4HMatS0_S0_ss( __cuda_0,__cuda_1,__cuda_2,__cuda_3,__cuda_4,__cuda_5,__cuda_6,__cuda_7,__cuda_8);
}
#line 1 "x64/Debug/CudaStuff.cudafe1.stub.c"
static void __nv_cudaEntityRegisterCallback(
void **__T3)
{
__nv_dummy_param_ref(__T3);
__nv_save_fatbinhandle_for_managed_rt(__T3);
__cudaRegisterEntry(__T3, ((void ( *)(Stim, double *, double *, Sim, HMat, double *, double *, short, short))NeuroGPUKernel), _Z14NeuroGPUKernel4StimPdS0_3Sim4HMatS0_S0_ss, (-1));
__cudaRegisterVariable(__T3, __shadow_var(cCm,::cCm), 0, 4096Ui64, 1, 0);
__cudaRegisterVariable(__T3, __shadow_var(cE,::cE), 0, 4096Ui64, 1, 0);
__cudaRegisterVariable(__T3, __shadow_var(cF,::cF), 0, 4096Ui64, 1, 0);
__cudaRegisterVariable(__T3, __shadow_var(cFIdxs,::cFIdxs), 0, 6144Ui64, 1, 0);
__cudaRegisterVariable(__T3, __shadow_var(cKs,::cKs), 0, 1024Ui64, 1, 0);
__cudaRegisterVariable(__T3, __shadow_var(cSegToComp,::cSegToComp), 0, 1024Ui64, 1, 0);
__cudaRegisterVariable(__T3, __shadow_var(cBoolModel,::cBoolModel), 0, 13312Ui64, 1, 0);
__cudaRegisterVariable(__T3, __shadow_var(cRelStarts,::cRelStarts), 0, 256Ui64, 1, 0);
__cudaRegisterVariable(__T3, __shadow_var(cRelEnds,::cRelEnds), 0, 256Ui64, 1, 0);
__cudaRegisterVariable(__T3, __shadow_var(cFathers,::cFathers), 0, 256Ui64, 1, 0);
__cudaRegisterVariable(__T3, __shadow_var(cRelVec,::cRelVec), 0, 504Ui64, 1, 0);
__cudaRegisterVariable(__T3, __shadow_var(cSegStartI,::cSegStartI), 0, 506Ui64, 1, 0);
__cudaRegisterVariable(__T3, __shadow_var(cSegEndI,::cSegEndI), 0, 506Ui64, 1, 0);
__cudaRegisterVariable(__T3, __shadow_var(cCompByLevel32,::cCompByLevel32), 0, 1856Ui64, 1, 0);
__cudaRegisterVariable(__T3, __shadow_var(cCompByFLevel32,::cCompByFLevel32), 0, 1856Ui64, 1, 0);
__cudaRegisterVariable(__T3, __shadow_var(cLRelStarts,::cLRelStarts), 0, 50Ui64, 1, 0);
__cudaRegisterVariable(__T3, __shadow_var(cLRelEnds,::cLRelEnds), 0, 50Ui64, 1, 0);
__cudaRegisterVariable(__T3, __shadow_var(cFLRelStarts,::cFLRelStarts), 0, 48Ui64, 1, 0);
__cudaRegisterVariable(__T3, __shadow_var(cFLRelEnds,::cFLRelEnds), 0, 48Ui64, 1, 0);
__cudaRegisterVariable(__T3, __shadow_var(cSonNoVec,::cSonNoVec), 0, 1024Ui64, 1, 0);
}
static void __sti____cudaRegisterAll(void)
{
____cudaRegisterLinkedBinary(__nv_cudaEntityRegisterCallback);
}
