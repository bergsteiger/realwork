#include "shared/Core/fix/mpcxc.h"
#ifdef WIN32
	#include <windows.h>
	#include <io.h>
	#include <fcntl.h>
	#define ypipe(xxx,yyy,zzz) c_io_open(xxx,yyy,zzz)
#else
	#include <fcntl.h>
	#include <unistd.h>
#ifdef __FreeBSD__ 
	#include <pthread.h>
	#define ypipe(xxx,yyy,zzz) c_io_open(xxx,yyy,zzz)
#else
	#include <thread.h>
	#define ypipe(xxx,yyy,zzz) open64(xxx,yyy,zzz)
#endif
	#include <time.h>
	#define Sleep(xxx) { struct timespec tm_pause= { 0, xxx*1000000 }; nanosleep(&tm_pause, 0); }
#endif

#include <stdio.h>
#include "osdep.h"
#include "MyPipe.h"

void yunlink(char *pPipename)
{
	ace_os_unlink(pPipename);
}

void done_my_pipe(LPTHREAD_CNTX p_Writer, LPTHREAD_CNTX p_Reader)
{
#ifdef AS_PROCESS
	if(p_Reader->h_currPipe)
		CloseHandle(p_Reader->h_currPipe);
	if(p_Writer->h_currPipe)
		CloseHandle(p_Writer->h_currPipe);
#else
	if(p_Writer->p_RealBuf)
		free(p_Writer->p_RealBuf);
#endif
	if(p_Writer)
		free(p_Writer);
	if(p_Reader)
		free(p_Reader);
}

int write_my_pipe(LPTHREAD_CNTX pCntxt, char *pBuff, int wr)
{
#ifdef AS_PROCESS
	if(!pCntxt->h_currPipe){
	  int bNotConnected= 1;
	  while (bNotConnected){
			/* attempt to connect to pipe instance */
			pCntxt->h_currPipe = CreateFile(	*pCntxt->ppPipename,
												//GENERIC_READ | GENERIC_WRITE,
												GENERIC_WRITE,
								0, 0,
								OPEN_EXISTING, 0, 0);
		if (GetLastError() == ERROR_PIPE_BUSY)
		{
			if(WaitNamedPipe(*pCntxt->ppPipename, NMPWAIT_USE_DEFAULT_WAIT)){
				pCntxt->h_currPipe= 0;
				return -1;
			}
		}
		else
		{
			if (pCntxt->h_currPipe == INVALID_HANDLE_VALUE){
				pCntxt->h_currPipe= 0;
#ifdef _DEBUG_OUT
				printf("\n\nError in CreateFile");
#endif
				return -1;
			}
			bNotConnected= 0;
			pCntxt->fConnected= 1;
		}
	  } /* while */
	}
	if (pCntxt->fConnected)
	{ 
		int fSuccess, cbWritten;
		// Write the reply to the pipe. 
		fSuccess = WriteFile(	pCntxt->h_currPipe,	// handle to pipe
								pBuff,				// buffer to write from
								wr,					// number of bytes to ace_os_write
								&cbWritten,			// number of bytes written
								0);				// not overlapped I/O 
		if (!fSuccess || cbWritten != wr) 
			 return 0; 
		return wr;
	}
#else
	int pre= 0, cwr= wr, timeOut= 0;
	if(!pCntxt->h_currPipe){
		if(pCntxt->bStepByStep){
			if(pCntxt->p_RealBuf){
				free(pCntxt->p_RealBuf);
				pCntxt->p_RealBuf= 0;
			}
			pCntxt->bStepByStep=
				ypipe(*pCntxt->ppPipename, ACE_OS_O_CREAT|ACE_OS_O_TRUNC|ACE_OS_O_WRONLY|ACE_OS_O_BINARY, 0664);
			if(pCntxt->bStepByStep == -1)
				pCntxt->bStepByStep= 0;
		}
#ifdef _WIN32
		pCntxt->h_currPipe= GetCurrentThread();
#else
		pCntxt->h_currPipe= (void*)-1;
#endif
	}
	if(pCntxt->bStepByStep){
		cwr= c_io_write(pCntxt->bStepByStep, pBuff, wr);
		if(pCntxt->LastWrite){
			c_io_close(pCntxt->bStepByStep);
			pCntxt->bStepByStep= 0;
			*pCntxt->p_Wr= BUFSIZE;
		}else{
			*pCntxt->p_all_ += (cwr + pCntxt->_all_z)/8;
			pCntxt->_all_z= cwr%8;
		}
		return cwr;
	}
	do{
		if(*pCntxt->p_Wr + wr < BUFSIZE){
			memcpy(pCntxt->p_Bf + *pCntxt->p_Wr, pBuff + pre, wr);
//printf("A");fflush(stdout);//sawa 3bsd
			if(pCntxt->LastWrite)
				*pCntxt->p_Wr= BUFSIZE;
			else
				*pCntxt->p_Wr += wr;
			return cwr;
		}
		pre= BUFSIZE - *pCntxt->p_Wr;
		memcpy(pCntxt->p_Bf + *pCntxt->p_Wr, pBuff, pre);
		wr -= pre;
		if(pCntxt->iSw){
			pCntxt->iSw--;
			pCntxt->p_Bf -= BUFSIZE;
		}else{
			pCntxt->iSw++;
			pCntxt->p_Bf += BUFSIZE;
		}
		*pCntxt->p_Wr= BUFSIZE;
		do{
			timeOut++;
			Sleep(50);
			if(timeOut > 60*60*1000/50){
				printf("\n\n Time out in write !\n\n");
				return 0;
			}
		}while(*pCntxt->p_Wr == BUFSIZE);
	}while(wr);
	if(pCntxt->LastWrite)
		*pCntxt->p_Wr= BUFSIZE;
	return cwr; 
#endif
	return 0; 
}

int read_my_pipe(LPTHREAD_CNTX pCntxt, char *bff, int rd)
{
#ifdef AS_PROCESS
  if(!pCntxt->h_currPipe){
	  STARTUPINFO si;
	  PROCESS_INFORMATION pi;
	  SECURITY_ATTRIBUTES saPipe;
	  OVERLAPPED ol;
	  DWORD dwRead;

	  BOOL notExecute= FALSE, notPrior= FALSE;
	  // set up a 0 DACL in our pipe security descriptor to allow anyone to
	  // connect to the pipe server
	  saPipe.lpSecurityDescriptor =
		  (PSECURITY_DESCRIPTOR) malloc(SECURITY_DESCRIPTOR_MIN_LENGTH);
	  InitializeSecurityDescriptor(saPipe.lpSecurityDescriptor,
										SECURITY_DESCRIPTOR_REVISION);
	  SetSecurityDescriptorDacl(saPipe.lpSecurityDescriptor, TRUE, (PACL) 0, FALSE);
	  saPipe.nLength = sizeof(saPipe);
	  saPipe.bInheritHandle = TRUE;

   while(!pCntxt->h_currPipe){
	  if(!notPrior++)
#ifndef _DEBUG
	  SetThreadPriority(GetCurrentThread(), THREAD_PRIORITY_ABOVE_NORMAL);
#endif
      pCntxt->h_currPipe = CreateNamedPipe( 
		  *pCntxt->ppPipename,        // pipe name 
	  //PIPE_ACCESS_DUPLEX,       // read/write access 
	  PIPE_ACCESS_INBOUND,
		  PIPE_TYPE_BYTE |			// message type pipe 
		  PIPE_READMODE_BYTE |		// message-read mode 
		  PIPE_WAIT,                // blocking mode 
		  1,//PIPE_UNLIMITED_INSTANCES, // max. instances  
		  BUFSIZE,                  // output buffer size 
		  BUFSIZE,                  // input buffer size 
		  60000,					// client time-out 
		  // security attribute
		  &saPipe );

      if (pCntxt->h_currPipe == INVALID_HANDLE_VALUE){
		  pCntxt->h_currPipe= 0;
          return 0;
	  }
	  if(!notExecute++){
		  ZeroMemory( &si, sizeof(si) );
		  si.cb = sizeof(si);
		  ZeroMemory( &pi, sizeof(pi) );
		  // Start the child process.
		  if( !CreateProcess(	0,		// No module name (use command line).
								(char*)pCntxt->pWriterProc,		// Command line.
								0,			// Process handle not inheritable.
								0,			// Thread handle not inheritable.
								FALSE,			// Set handle inheritance to FALSE.
								0,				// No creation flags.
								0,			// Use parent's environment block.
								0,			// Use parent's starting directory.
								&si,			// Pointer to STARTUPINFO structure.
								&pi )			// Pointer to PROCESS_INFORMATION structure.
			){
				puts("\n\nError: Not find compiler module !\n\n");
				CloseHandle(pCntxt->h_currPipe);
				exit(-1);
				return 0;
		  }
	  }
      pCntxt->fConnected = ConnectNamedPipe(pCntxt->h_currPipe, 0) ? 
         TRUE : (GetLastError() == ERROR_PIPE_CONNECTED); 
      if (!pCntxt->fConnected && GetLastError() == ERROR_IO_PENDING)
        pCntxt->fConnected = GetOverlappedResult(pCntxt->h_currPipe, &ol, &dwRead, TRUE);
      if (!pCntxt->fConnected && GetLastError() != ERROR_PIPE_CONNECTED)
	  {
		  // something went wrong, report error, close instance and try again
		  CloseHandle(pCntxt->h_currPipe);
		  pCntxt->h_currPipe= 0;
		  continue;
	  }
   } // end while
  }
	if (pCntxt->fConnected)
	{ 
	  int fSuccess, cbBytesRead, currRD= rd, offset= 0;
	  // Read client requests from the pipe.
	  do{
		fSuccess = ReadFile(	pCntxt->h_currPipe,	// handle to pipe
								bff+offset,			// buffer to receive data
								currRD,				// size of buffer
								&cbBytesRead,		// number of bytes ace_os_read
								0);				// not overlapped I/O 

		if (!fSuccess || cbBytesRead == 0)
			return 0;
		currRD -= cbBytesRead;
		offset += cbBytesRead;
	  }while(currRD);
	  return rd;
	}
#else
	int crd= rd, pre= 0, timeOut= 0;

	if(!pCntxt->h_currPipe){
#ifdef _WIN32
	  HANDLE hInstllThread0;
	  DWORD m_ThreadID0;

	  pCntxt->h_currPipe= GetCurrentThread();

	  SetThreadPriority(pCntxt->h_currPipe, THREAD_PRIORITY_ABOVE_NORMAL);

	  hInstllThread0 = CreateThread(	0, 0,
									(LPTHREAD_START_ROUTINE)pCntxt->pWriterProc,
									pCntxt->pWriterCtxt, CREATE_SUSPENDED,(LPDWORD)&m_ThreadID0);
	  if(hInstllThread0 == 0){
		  pCntxt->h_currPipe= 0;
          return 0;
	  }
	  SetThreadPriority(hInstllThread0, THREAD_PRIORITY_ABOVE_NORMAL);
	  ResumeThread(hInstllThread0);

#elif defined (unix)
	  pthread_t tid;
#ifndef __FreeBSD__ 
	  thr_create(0, 0, pCntxt->pWriterProc, pCntxt->pWriterCtxt, 0, &tid);
#else
#ifndef	__FreeBSD_SingleThread__
	  pthread_create(&tid, 0, pCntxt->pWriterProc, pCntxt->pWriterCtxt);
#endif
#endif
	  if(tid == 0){
		printf("\n\nthr_create(...) - Error 2!");
	  	pCntxt->h_currPipe= 0;
		return 0;
	  }
	  pCntxt->h_currPipe= (void*)-1;
#else
	#error not defined Thread Interface !!!
#endif
	}
	do{
		if(!*pCntxt->p_Rd){
			while(*pCntxt->p_Wr != BUFSIZE){
				timeOut++;
#ifdef _WIN32
				if(pCntxt->bStepByStep)
					Sleep(1000);
				else
#endif
					Sleep(50);
				if(timeOut > 
#ifdef _WIN32
						60*60*1000/50
#else
						60*60*1000
#endif
								){
					printf("\n\n Time out in read !\n\n");
					return 0;
				}
			}
			if(pCntxt->iSw){
				if(pCntxt->bStepByStep){
					crd= c_io_read(pCntxt->iSw, bff, rd);
					if(!memcmp(bff, END_METAFILE_SIGN, sizeof(long))){
						c_io_close(pCntxt->iSw);
						yunlink(*pCntxt->ppPipename);
						fprintf(stdout, "\rReading meta-temp (100%%)... Ok.\n\n");
						pCntxt->iSw= 0;
					}else{
						*pCntxt->p_all_R += (crd + pCntxt->_all_z)/8;
						pCntxt->_all_z= crd%8;
						pre= (int)((((u_int64_t)(*pCntxt->p_all_R))*100) / *pCntxt->p_all_);
						if(pre > pCntxt->l_argc){
							fprintf(stdout, "\rReading meta-pipe-file (%d%%)...",
								(pCntxt->l_argc= pre));
							fflush(stdout);
						}
					}
					return crd;
				}
				pCntxt->iSw--;
				pCntxt->p_Bf += BUFSIZE;
			}else if(pCntxt->bStepByStep){
				pCntxt->iSw= ypipe(*pCntxt->ppPipename, ACE_OS_O_RDONLY|ACE_OS_O_BINARY, 0664);
				if(pCntxt->iSw == -1)
					return 0;
				crd= c_io_read(pCntxt->iSw, bff, rd);
				*pCntxt->p_all_R += (crd + pCntxt->_all_z)/8;
				pCntxt->_all_z= crd%8;
				pCntxt->l_argc= 0;
				fprintf(stdout, "\nReading meta-pipe-file (0%%)...");
				fflush(stdout);
				return crd;
			}else{
				pCntxt->iSw++;
				pCntxt->p_Bf -= BUFSIZE;
			}
			*pCntxt->p_Wr= 0;
		}
		if(*pCntxt->p_Rd + rd < BUFSIZE){
			memcpy(bff+pre, pCntxt->p_Bf + *pCntxt->p_Rd, rd);
//printf("B");fflush(stdout);//sawa 3bsd
			*pCntxt->p_Rd += rd;
			return crd;
		}
		pre= BUFSIZE - *pCntxt->p_Rd;
		memcpy(bff, pCntxt->p_Bf + *pCntxt->p_Rd, pre);
		rd -= pre;
		*pCntxt->p_Rd= 0;
	}while(rd);
	return crd;
#endif
	return 0;
}

int init_my_pipe(LPTHREAD_CNTX *pp_Writer, LPTHREAD_CNTX *pp_Reader,
					void *pWriter)
{
	LPTHREAD_CNTX p_cntxt0, p_cntxt1;
	static char *lpszPipename = 
#ifdef WITH_DBL_THREAD
		"./gc30on1pipe.bn"
#else
		"\\\\.\\pipe\\gc30on1pipe"
#endif
		, **ppName= &lpszPipename;
#ifndef AS_PROCESS
	static int isRead= 0, isWrite= 0, _all_= 0, _all_R= 0;
#endif
 	if((p_cntxt0 = (LPTHREAD_CNTX)malloc(sizeof(THREAD_CNTX))) == 0){
		return -5;
	}
	if((p_cntxt1 = (LPTHREAD_CNTX)malloc(sizeof(THREAD_CNTX))) == 0){
		free(p_cntxt0);
		return -5;
	}
	*pp_Writer= p_cntxt0;
	*pp_Reader= p_cntxt1;

	p_cntxt0->bGCTX_in_MF2GARDB= p_cntxt1->bGCTX_in_MF2GARDB= 
	p_cntxt0->bStepByStep= p_cntxt1->bStepByStep= 
	p_cntxt0->LastWrite= p_cntxt1->LastWrite= 0;

	p_cntxt0->ppPipename= p_cntxt1->ppPipename= ppName;

#ifndef AS_PROCESS
	p_cntxt1->p_Wr= p_cntxt0->p_Wr= &isWrite;
	p_cntxt1->p_Rd= p_cntxt0->p_Rd= &isRead;

	p_cntxt1->p_all_= p_cntxt0->p_all_= &_all_,
	p_cntxt1->p_all_R= p_cntxt0->p_all_R= &_all_R,
#endif

	p_cntxt1->_all_z= p_cntxt0->_all_z= 0;

#ifndef AS_PROCESS
	p_cntxt1->p_Bf= p_cntxt0->p_Bf= (char*)malloc(BUFSIZE+BUFSIZE);
	p_cntxt1->p_RealBuf= p_cntxt0->p_RealBuf= p_cntxt1->p_Bf;
#endif
	p_cntxt1->LastWrite= p_cntxt0->LastWrite= 0;
#ifndef AS_PROCESS
	p_cntxt1->iSw= p_cntxt0->iSw= 0;
	p_cntxt1->p_Bf += BUFSIZE;
#endif

	p_cntxt0->h_currPipe= p_cntxt1->h_currPipe= 0;

	p_cntxt1->pWriterCtxt= p_cntxt0;
	p_cntxt1->pWriterProc= pWriter;

	return 0;
}

#if defined (_DEBUG) && defined (WIN32)
/*
	void *malloc( size_t size ){
		return (void*)LocalAlloc(LMEM_FIXED, size);
	}
	void *realloc( void *memblock, size_t size ){
		if(memblock)
			return (void*)LocalReAlloc((HANDLE)memblock, size, LMEM_MOVEABLE);
		return (void*)LocalAlloc(LMEM_FIXED, size);
	}
	void free( void *memblock )
	{
		LocalFree((HANDLE)memblock);
	}
	void *calloc( size_t num, size_t size )
	{
		void *pMem= (void*)LocalAlloc(LMEM_FIXED, size*num);
		if(pMem)
			return memset(pMem, 0, size*num);
		return 0;
	}
*/
	void put_stat(void *pThread, int Write)
	{
		FILE *pFile= 0;

		if(Write){
			FILE *pfh= mpcxc_fopen("./write.stat", "w+");
			if(pfh){
				FILETIME t0, t1, t2, t3;
				SYSTEMTIME s0, s1;
				GetThreadTimes(pThread, &t0, &t1, &t2, &t3);
				FileTimeToSystemTime(&t2, &s0);
				FileTimeToSystemTime(&t3, &s1);
				fprintf(pfh, "\nKernel time %d:%d:%d:%d",
									s0.wHour, s0.wMinute, s0.wSecond, s0.wMilliseconds);
				fprintf(pfh, "\nUser time %d:%d:%d:%d",
									s1.wHour, s1.wMinute, s1.wSecond, s1.wMilliseconds);
				fclose(pfh);
			}
		}else{
			FILE *pfh= mpcxc_fopen("./read.stat", "w+");
			if(pfh){
				FILETIME t0, t1, t2, t3;
				SYSTEMTIME s0, s1;
				GetThreadTimes(pThread, &t0, &t1, &t2, &t3);
				FileTimeToSystemTime(&t2, &s0);
				FileTimeToSystemTime(&t3, &s1);
				fprintf(pfh, "\nKernel time %d:%d:%d:%d",
									s0.wHour, s0.wMinute, s0.wSecond, s0.wMilliseconds);
				fprintf(pfh, "\nUser time %d:%d:%d:%d",
									s1.wHour, s1.wMinute, s1.wSecond, s1.wMilliseconds);
				fclose(pfh);
			}
		}
	}
#endif












