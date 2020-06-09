
#include "Util.h"


int main()
{
	int num_devices;

	cudaGetDeviceCount(&num_devices);
	num_devices = 1;
	for (int i = 0; i < num_devices; i++) {
		cudaDeviceProp prop;
		cudaGetDeviceProperties(&prop, i);
		//printf("Device Number: %d\n", i);
		//printf("  Device name: %s\n", prop.name);
		//printf("  Memory Clock Rate (KHz): %d\n",		prop.memoryClockRate);
		//printf("  Memory Bus Width (bits): %d\n",	prop.memoryBusWidth);
		//printf("  Peak Memory Bandwidth (GB/s): %f\n\n",		2.0*prop.memoryClockRate*(prop.memoryBusWidth / 8) / 1.0e6);
	}
//	printf("done printinig");
//	for (int dev_id = 0; dev_id < num_devices; ++dev_id)
//	{
//	CUDA_RT_CALL(cudaSetDevice(1));
//	int canAccessPeer = 0;
//	CUDA_RT_CALL(cudaDeviceCanAccessPeer(&canAccessPeer, 1, 0));
//	printf("device %d peerdevice %d canaccees %d\n",1,0,canAccessPeer);
//	if (canAccessPeer)
//	{
//		CUDA_RT_CALL(cudaDeviceEnablePeerAccess(0, 0));
//	}




	
	//RunByModelSerial();// FOR ROY!!!!!!!!!!!!!!! // Run, output VHot and look
	/*Add to first kernel
	cudaStatus = cudaSetDevice(0);
	if (cudaStatus != cudaSuccess) {
	fprintf(stderr, "cudaSetDevice failed!  Do you have a CUDA-capable GPU installed?");
	goto Error;
	}
	*/

	//printf("we are in the %s directory\n",_getcwd( NULL, 0 ));
//	printf("1!");
	CUDA_RT_CALL(cudaSetDevice(STIM_IND));
	RunByModelP();

	return 0;
}

