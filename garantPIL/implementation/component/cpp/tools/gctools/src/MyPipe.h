#ifndef INC_MY_PIPE_HEADER
#define INC_MY_PIPE_HEADER

//#define _DEBUG_OUT
 #if defined (AS_PROCESS) && !defined (WIN32)
	#error MultiProcess target in Win32, only !
 #else

#ifdef  __cplusplus
	extern "C" {
#endif

	#define BUFSIZE (80*1024*1024)

	#define END_METAFILE_SIGN "MEnd"
#ifdef AS_PROCESS
	#define EXCT_FROM_MF2GRDB "MF2GRDB_MODULE"
#endif
	typedef struct THREAD_CNTX_TAG
	{
		void *h_currPipe;
		char **ppPipename;
#ifdef AS_PROCESS
		int fConnected;
#else
		int *p_Wr, *p_Rd, iSw;
		char *p_Bf, *p_RealBuf;
#endif
		int LastWrite;
		int l_argc, bGCTX_in_MF2GARDB, bStepByStep, *p_all_, *p_all_R, _all_z;
		char **l_argv;
		void *pWriterCtxt;
		void *pWriterProc;
		void *pTxtCntxt;
		void *pNmeCntxt;
		//
		void *PThreadCompileInfo;
		void *PGCParameters;
		void *PrepWriterProc;
		//
	} THREAD_CNTX, *LPTHREAD_CNTX;

	#define getExit_my_pipe(x) (*((LPTHREAD_CNTX)x)->pExit)

	#define PIPE_TIMEOUT 60000

	extern int init_my_pipe(LPTHREAD_CNTX *, LPTHREAD_CNTX *, void*);
	extern int write_my_pipe(LPTHREAD_CNTX, char *, int);
	extern int read_my_pipe(LPTHREAD_CNTX, char *, int);
	extern void done_my_pipe(LPTHREAD_CNTX, LPTHREAD_CNTX);
	extern void yunlink(char *pPipename);

#ifdef  __cplusplus
	}
#endif
 #endif
#endif
