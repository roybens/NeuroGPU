#include "Util.h"
//#include "CudaStuff.cuh"
#define checkCudaErrors(val)           check ( (val), #val, __FILE__, __LINE__ )
MYFTYPE  maxf(MYFTYPE  a, MYFTYPE  b) {
	if (a>b)
		return a;
	return b;
}

MYFTYPE  MaxAbsDiffVec(MYFTYPE * A, MYFTYPE  *B, int n) {
	MYFTYPE  cmax = -1;
	MYFTYPE  curdiff;
	for (int i = 0; i<n; i++) {
		curdiff = abs(A[i] - B[i]);
		cmax = maxf(cmax, curdiff);
	}
	return cmax;
}

void CopyVec(MYFTYPE * A, MYFTYPE  *B, int n) {
	for (int i = 0; i<n; i++) {
		A[i] = B[i];
	}
}
void CopyVecMYSECONDFTYPE(MYSECONDFTYPE* A, MYSECONDFTYPE  *B, int n) {
	for (int i = 0; i<n; i++) {
		A[i] = B[i];
	}
}
void CopyVecTwoTypes(MYSECONDFTYPE *A, MYFTYPE * B, int n) {
	for (int i = 0; i<n; i++) {
		A[i] = B[i];
	}
}
void FlipVec(MYFTYPE * A, MYFTYPE  *B, int n) {
	for (int i = 0; i<n; i++) {
		A[i] = B[n - i];
	}
}
void ReadShortFromCSV(char* line, short *ans, int n) {
	int count = 0;
	char* tok;
	unsigned short tmp;
	if (n == 1) {
		tok = strtok(line, ",");
		//printf("%s\n", tok);
		tmp = atoi(tok);
		*ans = (short)tmp;
	}
	else {
	
		for (tok = strtok(line, ","); tok != NULL; tok = strtok(NULL, ",")){
		if(count<n){
		
			tmp = atoi(tok);
			ans[count++] = (short)tmp;
			//printf("%d-%d,-%s,** %c,%c\n",count,strlen(tok),tok,tok[0],tok[1]);

		}
		}
		//printf("read short %d\n",count);
		}
	

}
void ReadIntFromCSV(char* line, int *ans, int n) {
	int count = 0;
	char* tok;
	int tmp;
	if (n == 1) {
		tok = strtok(line, ",");
		//printf("%s\n", tok);
		tmp = atoi(tok);
		*ans = (int)tmp;
	}
	else {
	     
		for (tok = strtok(line, ","); tok != NULL; tok = strtok(NULL, ","))
		{
			tmp = atoi(tok);
			ans[count++] = (int)tmp;

		}
		}
	
}


void ReadDoubleFromCSV(char* line, double *ans, int n) {
	int count = 0;
	char* tok;
	double tmp;
	if (n == 1) {
		tok = strtok(line, ",");
		tmp = atof(tok);
		*ans = (double)tmp;
	}
	else {

		for (tok = strtok(line, ","); tok != NULL; tok = strtok(NULL, ","))
		{
			if (tok[1] != '\n'){
						tmp = atof(tok);
					//	printf("%d-%d,-%s,** %c,%c\n",count,strlen(tok),tok,tok[0],tok[1]);
						ans[count++] = tmp;
						}

		}
	}
	//printf("\ndone with readdouble\n");
}
void ReadFloatFromCSV(char* line, MYFTYPE *ans, int n) {
	int count = 0;
	char* tok;
	MYFTYPE tmp;
	if (n == 1) {
		tok = strtok(line, ",");
		tmp = atof(tok);
		*ans = (MYFTYPE)tmp;
	}
	else {

		for (tok = strtok(line, ","); tok != NULL; tok = strtok(NULL, ","))
		{
		if (n>count){
			tmp = atof(tok);
			//printf("%d-%d,-%s,** %c,%c",count,strlen(tok),tok,tok[0],tok[1]);
			ans[count++] = tmp;
			}

		}
	}
}
int power(int base, int exp)
{
	int power;
	power = 1;
	while (exp-- > 0)
		power *= base;

	return power;
}
MYFTYPE myatof(char s[])
{
	MYFTYPE val, pow;
	int sign, i, esign, exp;
	int power(int base, int exp);

	for (i = 0; isspace(s[i]); i++)
		;

	sign = (s[i] == '-') ? -1 : 1;

	if (s[i] == '+' || s[i] == '-')
		i++;

	for (val = 0.0; isdigit(s[i]); i++)
		val = 10.0 * val + (s[i] - '0');

	if (s[i] == '.')
		i++;

	for (pow = 1.0; isdigit(s[i]); i++)
	{
		val = 10.0 * val + (s[i] - '0');
		pow *= 10.0;
	}

	if (s[i] == 'e' || s[i] == 'E')
		i++;
	if (s[i] == '+' || s[i] == '-')
	{
		esign = s[i];
		i++;
	}

	for (exp = 0; isdigit(s[i]); i++)
		exp = 10.0 * exp + (s[i] - '0');

	if (esign == '-')
		return sign * (val / pow) / power(10, exp);
	else

		return sign * (val / pow) * power(10, exp);
}

void ReadFloatWithEFromCSV(char* line, MYFTYPE *ans, int n) {
	int count = 0;
	char* tok;
	MYFTYPE tmp;
	if (n == 1) {
		tok = strtok(line, ",");
		tmp = atof(tok);
		*ans = (MYFTYPE)tmp;
	}
	else {

		for (tok = strtok(line, ","); (tok != NULL && tok[0] != '\n'); tok = strtok(NULL, ","))
		{
			if (n>count){
			tmp = myatof(tok);
			ans[count++] = tmp;
			}

		}
	}
}


MYFTYPE* ReadAllParams(const char* FN, MYDTYPE NParams, MYDTYPE Nx, int  &nSets) {
	MYFTYPE* ans;
	//printf("readingggg params %s\n",FN);
	FILE *fl = fopen(FN, "r"); // YYY add FILE*
	if (!fl) {
		printf("Failed to read allparmas.csv\n");
		return NULL;
	}
	char line[1009600];
	fgets(line, sizeof(line), fl);
	ReadIntFromCSV(line, &nSets, 1);
	//printf("reading params nsets is %d\n",nSets);
	ans = (MYFTYPE *)malloc(Nx * NParams * nSets * sizeof(MYFTYPE));
	//printf("Nx %d nparams %d,nSets%d\n",Nx,NParams,nSets);
	//printf("malloc size is %d\n",Nx*NParams*nSets*sizeof(MYFTYPE));
	for (int i = 0; i<nSets; i++) {
		fgets(line, sizeof(line), fl);
		//printf("a%d.adreess is %d",i,i*Nx*NParams);
		ReadFloatWithEFromCSV(line, &ans[i*Nx*NParams], Nx*NParams);
		//printf("\n");
	}
	//printf("done filling params");
	fclose(fl);
	return ans;
}
MYFTYPE* ReadInitStates(const char *FN, MYDTYPE NStates, MYDTYPE Nx, MYDTYPE  nSets) {
	/* TODO: edit this file opening stuff based on how the init states file is named */
	MYFTYPE* ans;
	MYDTYPE nsetsFromFile;
	FILE *fl = fopen(FN, "r"); // YYY add FILE*
	if (!fl) {
		printf("Failed to read allStates.csv\n");
		return NULL;
	}
	char line[1009600];
	fgets(line, sizeof(line), fl);
	ReadShortFromCSV(line, &nsetsFromFile, 1);
	//printf("nsetsfrom file is %d", nsetsFromFile);
	if (nsetsFromFile != nSets)
		printf("we have a problem nsets from params does not much states");
	ans = (MYFTYPE *)malloc(Nx * NStates * nSets * sizeof(MYFTYPE));
	for (int i = 0; i<nSets; i++) {
		fgets(line, sizeof(line), fl);
		ReadFloatWithEFromCSV(line, &ans[i*Nx*NStates], Nx*NStates);
	}
	fclose(fl);
	return ans;
}



void ReadStimData(const char* FN, Stim &stim, MYDTYPE Nx) {
	char FileName[300];
	//sprintf(FileName,"%s%d.dat",FN,MUL32*32);
    
	printf("Start reading file - %s ReadStimData() \n",FileName);

	FILE *fl;
	fl = fopen(FileName, "rb");
	if (!fl)
	{
		printf("Failed to read StimData\n");
		return;
	}
	//fread(&stim.NStimuli, sizeof(MYDTYPE),1, fl);
	stim.NStimuli = 1;
	stim.dels = (MYFTYPE*)malloc(stim.NStimuli * sizeof(MYFTYPE));
	fread(stim.dels, sizeof(MYFTYPE), stim.NStimuli, fl);
	stim.durs = (MYFTYPE*)malloc(stim.NStimuli * sizeof(MYFTYPE));
	fread(stim.durs, sizeof(MYFTYPE), stim.NStimuli, fl);
	stim.amps = (MYFTYPE*)malloc(stim.NStimuli * sizeof(MYFTYPE));
	fread(stim.amps, sizeof(MYFTYPE), stim.NStimuli, fl);
	fread(&stim.comp, sizeof(MYDTYPE), 1, fl);
	fread(&stim.area, sizeof(MYFTYPE), 1, fl);
	fread(&stim.loc, sizeof(MYDTYPE), 1, fl);
	//stim.loc = stim.loc - 1;
	fclose(fl);
	return;
}




void CreateStimData(Stim &stim) {
	stim.NStimuli = NSTIM;
	stim.dels = (MYFTYPE*)malloc(stim.NStimuli * sizeof(MYFTYPE));
	stim.durs = (MYFTYPE*)malloc(stim.NStimuli * sizeof(MYFTYPE));
	stim.amps = (MYFTYPE*)malloc(stim.NStimuli * sizeof(MYFTYPE));
	stim.comp = 1;
	stim.area = 28.3771;
	stim.loc = 2;
	MYFTYPE  initAmp = -1;
	for (int i = 0; i<stim.NStimuli; i++) {
		stim.durs[i] = 20.0;
		stim.dels[i] = 10.0;
		stim.amps[i] = initAmp + 1 * i;
	}
	return;
}

void ReadStimFromFile(const char* FN, Stim &stim) {//deprecated
	FILE *fl;
	fl = fopen(FN, "rb");
	printf("reading stimfromfile - %s", FN);
	if (!fl)
	{
		printf("Failed to read StimData\n");
		return;
	}
	MYDTYPE Nt;
	fread(&stim.NStimuli, sizeof(MYDTYPE), 1, fl);
	fread(&Nt, sizeof(MYDTYPE), 1, fl);
	stim.Nt = MYDTYPE(ceil(MYFTYPE(Nt) / WARPSIZE)*WARPSIZE);
	fread(&stim.comp, sizeof(MYDTYPE), 1, fl);
	fread(&stim.loc, sizeof(MYDTYPE), 1, fl);
	stim.loc -= 1;
	fread(&stim.area, sizeof(MYFTYPE), 1, fl);
	fread(&stim.numofdts, sizeof(MYDTYPE), 1, fl);
	stim.dtInds = (MYDTYPE*)malloc(stim.numofdts * sizeof(MYDTYPE));//dont need it now
	stim.durs = (MYFTYPE*)malloc(stim.numofdts * sizeof(MYFTYPE));//acts as dts.
	stim.amps = (MYFTYPE*)malloc(Nt*stim.NStimuli * sizeof(MYFTYPE));
	fread(stim.dtInds, sizeof(MYDTYPE), stim.numofdts, fl);
	fread(stim.durs, sizeof(MYFTYPE), stim.numofdts, fl);
	fread(stim.amps, sizeof(MYFTYPE), Nt*stim.NStimuli, fl);
	fclose(fl);

}
void ReadCSVStim(Stim &stim,int argc) {
	char FileName[300];
	sprintf(FileName, "%s", Stim_csv_meta);
	//sprintf(FileName,"%s%d.dat",FN,MUL32*32);
	FILE *fl = fopen(FileName, "r"); // YYY add FILE*
	if (!fl) {
		printf("Failed to read metaStimData1\n");

	}
	char line[160000];
	fgets(line, sizeof(line), fl);
	ReadShortFromCSV(line, &stim.NStimuli, 1);
	fgets(line, sizeof(line), fl);
	ReadFloatFromCSV(line, &stim.Nt, 1);
	fgets(line, sizeof(line), fl);
	ReadShortFromCSV(line, &stim.comp, 1);//this is not currently used.
	fgets(line, sizeof(line), fl);
	ReadShortFromCSV(line, &stim.loc, 1);
	stim.loc -= 1;
	fgets(line, sizeof(line), fl);
	ReadFloatFromCSV(line, &stim.area, 1);
    int stim_ind;
    cudaGetDevice(&stim_ind);
	if (argc > 1) {
		sprintf(FileName, "%s%d.csv", Stim_csv_raw, stim_ind);
	}
	else {
		sprintf(FileName, "%s.csv", Stim_csv_raw);
	}
	FILE *f2 = fopen(FileName, "r");
	if (!f2) {
		printf("Failed to read StimRaw Data2 - %s\n",FileName);

	}

	stim.amps = (MYFTYPE*)malloc(stim.Nt*stim.NStimuli * sizeof(MYFTYPE));
	for (int i = 0; i < stim.NStimuli; i++) {

		fgets(line, sizeof(line), f2);
		ReadFloatFromCSV(line, &stim.amps[i*int(stim.Nt)], stim.Nt);
	}

	sprintf(FileName, "%s", Time_steps_FN);
	//sprintf(FileName,"%s%d.dat",FN,MUL32*32);
	FILE *f3 = fopen(FileName, "r"); // YYY add FILE*
	if (!f3) {
		printf("Failed to read SimData3\n");

	}
	stim.durs = (MYFTYPE*)malloc(stim.Nt * sizeof(MYFTYPE));
	fgets(line, sizeof(line), f3);

	ReadFloatFromCSV(line, stim.durs, stim.Nt);
}
void FreeStimData(Stim &stim) {
	printf("Still need to implement FreeStimData()\n");
}
void ReadSimData(const char* FN, MYDTYPE N, Sim &sim) {
	char FileName[300];
	sprintf(FileName, "%s.csv", FN);
	//sprintf(FileName,"%s%d.dat",FN,MUL32*32);
	FILE *fl = fopen(FileName, "r"); // YYY add FILE*
	if (!fl) {
		printf("Failed to read SimData4\n");

	}

	char line[1009600];


	printf("Start reading file - ReadSimData()\n");
	MYFTYPE v_init;
	fgets(line, sizeof(line), fl);
	ReadFloatFromCSV(line, &v_init, 1);

	sim.Vs = (MYFTYPE*)malloc(N * sizeof(MYFTYPE));
	for (int i = 0; i < N; i += 1) {
		sim.Vs[i] = v_init;
	}
	fgets(line, sizeof(line), fl);
	ReadFloatFromCSV(line, &sim.dt, 1);
	//fgets(line, sizeof(line), fl);
	//ReadFloatFromCSV(line, &sim.TFinal, 1);
	//MYDTYPE Nt = ceil(sim.TFinal / sim.dt);
	//MYDTYPE to32 = 32 - Nt % 32;
	//sim.TFinal = sim.TFinal + (to32 + 1)*sim.dt;
	fgets(line, sizeof(line), fl);
	ReadShortFromCSV(line, &sim.NRecSites, 1);
	sim.RecSites = (MYDTYPE*)malloc(sim.NRecSites * sizeof(MYDTYPE));
	fread(sim.RecSites, sizeof(MYDTYPE), sim.NRecSites, fl);
	//fread(&sim.Celsius, sizeof(MYFTYPE),1, fl);
	fgets(line, sizeof(line), fl);
	ReadShortFromCSV(line, sim.RecSites, sim.NRecSites);
	fclose(fl);
	return;
}
void FreeSimData(Sim &sim) {
	printf("Still need to implement FreeStimData()\n");
}
double diffclock(clock_t clock1, clock_t clock2)
{
	double diffticks = clock1 - clock2;
	double diffms = (diffticks) / CLOCKS_PER_SEC;
	return diffms;
}

void SaveArrayToFile(const char* FN, const int N, const double* Arr) {
	printf("printing %s size is %d\n", FN, N);
	const int prec = 3;
	
	FILE *file = fopen(FN, "wb");
	if (file) {
		fwrite(&N, sizeof(int), 1, file);
		fwrite(&prec, sizeof(int), 1, file);
		fwrite(Arr, sizeof(double), N, file);
	}
	else {
		printf("ERR SaveArrayToFile %s %d\n", FN, N);
	}
	fclose(file);
}
void SaveArrayToFile(const char* FN, const int N, const float* Arr) {
	printf("\nprinting %s size is %d\n", FN, N);
	double* arr_dbl;
	arr_dbl =(double*) malloc(N * sizeof(double));
	const int prec = 3;
	for (int i = 0; i < N; i++) {
		arr_dbl[i] = (double)Arr[i];
	}
	FILE *file = fopen(FN, "wb");
	if (file) {
		fwrite(&N, sizeof(int), 1, file);
		fwrite(&prec, sizeof(int), 1, file);
		fwrite(arr_dbl, sizeof(double), N, file);
	}
	else {
		printf("ERR SaveArrayToFile %s %d\n", FN, N);
	}
	fclose(file);
}

MYFTYPE* transposeMat(MYFTYPE* Arr, MYDTYPE width, MYDTYPE length) {
	MYFTYPE* ans = (MYFTYPE*)malloc(width*length * sizeof(MYFTYPE));
	for (int row = 0; row < length; row++) {
		for (int col = 0; col < width; col++) {
			ans[col*length + row] = Arr[row*width + col];
		}
	}
	return ans;
}

void CompareArrays(const MYFTYPE * App, const MYFTYPE  *Real, int n, char* Prefix) {
	MYFTYPE MaxDiff = 0, CurDiff, MaxRDiff = 0;
	for (int i = 0; i<n; i++) {
		CurDiff = abs(App[i] - Real[i]);
		MaxDiff = maxf(MaxDiff, CurDiff);
		MaxRDiff = maxf(MaxRDiff, CurDiff / abs(Real[i]));
	}
	printf("Comparing %s,%d: MaxD=%f, MaxRD=%f\n", Prefix, n, MaxDiff, MaxRDiff);
}
void SaveVHots(const char* FN, MYFTYPE** VHotsHost, MYDTYPE Nt, MYDTYPE NStimuli) {
	FILE *file = fopen(FN, "wb");
	if (file) {
		for (int i = 0; i<NStimuli; i++) {
			fwrite(VHotsHost[i], sizeof(MYFTYPE), Nt, file);
		}
	}
	else {
		printf("ERR SaveArrayToFile %s %d\n", FN);
	}
	fclose(file);
}
/*
void ReadDebugData(const char* FN, MYFTYPE** DebugData, MYDTYPE Nsegs, MYDTYPE Nt){
FILE *fl;
MYDTYPE NP;
fl = fopen(FN, "rb");

for (int i = 0; i<NSTATES; i++){
DebugData[i] = (MYFTYPE*)malloc((Nsegs*Nt)*sizeof(MYFTYPE));
fread(DebugData[i], sizeof(MYFTYPE), Nsegs*Nt, fl);
}
}

void SetStatesFromDebug(MYFTYPE** StatesM, MYFTYPE** DebugData, MYDTYPE iter, MYDTYPE Nseg){
MYDTYPE debugIter;
if (iter>0){
iter -= 1;
debugIter = iter*Nseg;
for (int currSeg = 0; currSeg<Nseg; currSeg++){
for (int currState = 0; currState<NSTATES; currState++){
StatesM[currState][currSeg] = DebugData[currState][debugIter + currSeg];
}
}
}
}
*/
void ReadRHSData(const char* FN, MYFTYPE** DebugData, MYDTYPE Nsegs, MYDTYPE Nt) {
	FILE *fl;
	fl = fopen(FN, "rb");
	for (int i = 0; i<Nt; i++) {
		DebugData[i] = (MYFTYPE*)malloc((Nsegs) * sizeof(MYFTYPE));
		fread(DebugData[i], sizeof(MYFTYPE), Nsegs, fl);
	}
}

void SetRHSFromNeuron(MYFTYPE* rhs, MYFTYPE** DebugData, MYDTYPE i, MYDTYPE N) {

	for (int currSeg = 0; currSeg<N; currSeg++) {
		rhs[currSeg] = DebugData[i][currSeg];
	}


}
void ReadDData(const char* FN, MYFTYPE** DebugData, MYDTYPE Nsegs, MYDTYPE Nt) {
	FILE *fl;
	fl = fopen(FN, "rb");
	for (int i = 0; i<Nt; i++) {
		DebugData[i] = (MYFTYPE*)malloc((Nsegs) * sizeof(MYFTYPE));
		fread(DebugData[i], sizeof(MYFTYPE), Nsegs, fl);
	}
}

void SetDFromNeuron(MYFTYPE* D, MYFTYPE** DebugData, MYDTYPE i, MYDTYPE N) {

	for (int currSeg = 0; currSeg<N; currSeg++) {
		D[currSeg] = DebugData[i][currSeg];

	}

}
void ReadVData(const char* FN, MYFTYPE** DebugData, MYDTYPE Nsegs, MYDTYPE Nt) {
	FILE *fl;
	fl = fopen(FN, "rb");
	for (int i = 0; i<Nt; i++) {
		DebugData[i] = (MYFTYPE*)malloc((Nsegs) * sizeof(MYFTYPE));
		fread(DebugData[i], sizeof(MYFTYPE), Nsegs, fl);
	}
}
void SetVFromNeuron(MYFTYPE* vs, MYFTYPE** DebugData, MYDTYPE i, MYDTYPE N) {
	if (i>0) {
		for (int currSeg = 0; currSeg<N; currSeg++) {
			vs[currSeg] = DebugData[i - 1][currSeg];
		}
	}

}
void debugPrintMYFTYPE(MYFTYPE* A, MYDTYPE N, FILE* fdebug) {
	fwrite(&N, sizeof(MYDTYPE), 1, fdebug);
	fwrite(A, sizeof(MYFTYPE), N, fdebug);
}
void debugPrintMYSECONDFTYPE(MYSECONDFTYPE* A, MYDTYPE N, FILE* fdebug) {
	fwrite(&N, sizeof(MYDTYPE), 1, fdebug);
	fwrite(A, sizeof(MYSECONDFTYPE), N, fdebug);
}
bool IsGPUCapableP2P(cudaDeviceProp *pProp) {
#ifdef _WIN32
	return (bool)(pProp->tccDriver ? true : false);
#else
	return (bool)(pProp->major >= 2);
#endif
}


bool IsAppBuiltAs64()
{
	return sizeof(void*) == 8;
}
int* checkPeerAccess(int &n_p2p) {
	n_p2p = 0;
	//printf("[%s] - Starting...\n");
	if (!IsAppBuiltAs64())
	{
	//	printf("%s is only supported with on 64-bit OSs and the application must be built as a 64-bit target.  Test is being waived.\n");
	}
	// Number of GPUs
	//printf("Checking for multiple GPUs...\n");
	int gpu_n;
	CUDA_RT_CALL(cudaGetDeviceCount(&gpu_n));
	printf("CUDA-capable device count: %i\n", gpu_n);
	if (gpu_n < 2)
	{
		printf("Two or more GPUs with SM 2.0 or higher capability are required for %s.\n");
		printf("Waiving test.\n");

	}
	// Query device properties
	cudaDeviceProp prop[64];
	int gpuid[64]; // we want to find the first two GPU's that can support P2P
	int gpu_count = 0;   // GPUs that meet the criteria
	for (int i = 0; i < gpu_n; i++)
	{
		CUDA_RT_CALL(cudaGetDeviceProperties(&prop[i], i));

		// Only boards based on Fermi can support P2P
		if ((prop[i].major >= 2)
#ifdef _WIN32
			// on Windows (64-bit), the Tesla Compute Cluster driver for windows must be enabled
			&& prop[i].tccDriver
#endif
			)
		{
			// This is an array of P2P capable GPUs
			gpuid[gpu_count++] = i;
		}

	//	printf("> GPU%d = \"%15s\" %s capable of Peer-to-Peer (P2P)\n", i, prop[i].name, (IsGPUCapableP2P(&prop[i]) ? "IS " : "NOT"));
	}

	// Check for TCC for Windows
	if (gpu_count < 2)
	{
		printf("\nTwo or more GPUs with SM 2.0 or higher capability are required for %s.\n");
#ifdef _WIN32
		printf("\nAlso, a TCC driver must be installed and enabled to run %s.\n");
#endif
		CUDA_RT_CALL(cudaSetDevice(0));


	}
	// Check possibility for peer access
	//printf("\nChecking GPU(s) for support of peer to peer memory access...\n");
	int can_access_peer;
	int* p2pCapableGPUs; // We take only 1 pair of P2P capable GPUs
	p2pCapableGPUs = (int*)malloc(gpu_n * sizeof(int));


	p2pCapableGPUs[0] = 0; //checking who has access to 0 and 0 has peeracces to himself
						   // Show all the combinations of supported P2P GPUs
	for (int i = 1; i < gpu_count; i++)
	{
		p2pCapableGPUs[i] = -1;
		CUDA_RT_CALL(cudaDeviceCanAccessPeer(&can_access_peer, gpuid[i], 0));
	//	printf("> Peer access from %s (GPU%d) -> %s (GPU%d) : %s\n", prop[gpuid[i]].name, gpuid[i],prop[0].name, gpuid[0],can_access_peer ? "Yes" : "No");
		if (can_access_peer)
		{
			p2pCapableGPUs[i] = gpuid[i];
			n_p2p += 1;

		}
	}



	return p2pCapableGPUs;
}

void enablePeerAccess(int* p2pCapableGPUs, int np2p) {
	cudaDeviceProp prop[64];
	int gpuid[64];
	// Use all  of p2p to 0 capable GPUs detected.
	int gpu_n;
	//int index = 0;
	CUDA_RT_CALL(cudaGetDeviceCount(&gpu_n));
	for (int i = 1; i < np2p; i++) {
	//	printf("in enablep2p i is %d p2p is %d\n", i, np2p);
		gpuid[i] = p2pCapableGPUs[i];
		CUDA_RT_CALL(cudaGetDeviceProperties(&prop[i], gpuid[i]));
	//	printf("Enabling peer access from GPU%d to GPU%d...\n", gpuid[i], 0);
		CUDA_RT_CALL(cudaSetDevice(gpuid[i]));
		CUDA_RT_CALL(cudaDeviceEnablePeerAccess(0, 0));
	//	printf("Checking GPU%d and GPU%d for UVA capabilities...\n", gpuid[0], gpuid[i]);
		const bool has_uva = (prop[gpuid[0]].unifiedAddressing && prop[gpuid[i]].unifiedAddressing);
	//	printf("> %s (GPU%d) supports UVA: %s\n", prop[gpuid[i]].name, gpuid[i], (prop[gpuid[i]].unifiedAddressing ? "Yes" : "No"));
	}

	//printf("leaving enablepeeraccess");
}
int char2int(char* str){
return atoi(str);
}