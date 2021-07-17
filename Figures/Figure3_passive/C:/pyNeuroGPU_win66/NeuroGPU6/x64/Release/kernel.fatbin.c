#include "fatBinaryCtl.h"
#define __CUDAFATBINSECTION  ".nvFatBinSegment"
#define __CUDAFATBINDATASECTION  ".nv_fatbin"
#ifdef __cplusplus
extern "C" {
#endif

#pragma data_seg(__CUDAFATBINDATASECTION)
static const __declspec(allocate(__CUDAFATBINDATASECTION)) unsigned long long fatbinData[]= {
0x00100001ba55ed50,0x0000000000000338,0x0000004001010002,0x0000000000000268,
0x0000000000000000,0x0000002300010007,0x0000000000000000,0x0000000000000045,
0x0000000000000000,0x0000000000000000,0x33010102464c457f,0x0000000000000007,
0x0000005000be0002,0x0000000000000000,0x00000000000001c0,0x00000000000000c0,
0x0038004000230523,0x0001000400400003,0x7472747368732e00,0x747274732e006261,
0x746d79732e006261,0x746d79732e006261,0x78646e68735f6261,0x666e692e766e2e00,
0x747368732e00006f,0x74732e0062617472,0x79732e0062617472,0x79732e006261746d,
0x6e68735f6261746d,0x692e766e2e007864,0x00000000006f666e,0x0000000000000000,
0x0000000000000000,0x0000000000000000,0x0000000000000000,0x0000000000000000,
0x0000000000000000,0x0000000000000000,0x0000000000000000,0x0000000000000000,
0x0000000000000000,0x0000000000000000,0x0000000300000001,0x0000000000000000,
0x0000000000000000,0x0000000000000040,0x0000000000000032,0x0000000000000000,
0x0000000000000001,0x0000000000000000,0x000000030000000b,0x0000000000000000,
0x0000000000000000,0x0000000000000072,0x0000000000000032,0x0000000000000000,
0x0000000000000001,0x0000000000000000,0x0000000200000013,0x0000000000000000,
0x0000000000000000,0x00000000000000a8,0x0000000000000018,0x0000000000000002,
0x0000000000000008,0x0000000000000018,0x0000000500000006,0x00000000000001c0,
0x0000000000000000,0x0000000000000000,0x00000000000000a8,0x00000000000000a8,
0x0000000000000008,0x0000000500000001,0x0000000000000000,0x0000000000000000,
0x0000000000000000,0x0000000000000000,0x0000000000000000,0x0000000000000008,
0x0000000600000001,0x0000000000000000,0x0000000000000000,0x0000000000000000,
0x0000000000000000,0x0000000000000000,0x0000000000000008,0x0000005001010001,
0x0000000000000040,0x000000400000003c,0x0000002300050000,0x0000000000000000,
0x0000000000002045,0x0000000000000000,0x0000000000000045,0x0000000000000048,
0xffffffff00000000,0x2e26f000020a0d2a,0x206e6f6973726576,0x61742e0a0d302e35,
0x5f6d732074656772,0x6464612e0a0d3533,0x7a69735f73736572,0x0a0d0a0d34362065,
0x000000000a0d0a0d
};
#pragma data_seg()

#ifdef __cplusplus
}
#endif

#ifdef __cplusplus
extern "C" {
#endif
#pragma data_seg(".nvFatBinSegment")
__declspec(allocate(__CUDAFATBINSECTION)) __declspec(align(8)) static const __fatBinC_Wrapper_t __fatDeviceText= 
	{ 0x466243b1, 1, fatbinData, 0 };
#pragma data_seg()
#ifdef __cplusplus
}
#endif