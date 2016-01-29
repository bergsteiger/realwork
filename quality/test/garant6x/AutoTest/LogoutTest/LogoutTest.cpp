#include "ace/ACE.h"
#include "Garant/GblAdapter/GblAdapter.h"
#include "Garant/GblAdapter/ApplicationHelper.h"
#include "helpers/logs.h"
#include <map>
#include <conio.h>
#include <stdexcept>
#include <time.h>
#include <TLHELP32.H>
#include <process.h>
#include <string.h>
#include <windows.h>
#include <tlhelp32.h>


#include "LogoutTest.h"
#include "autotest.h"


HANDLE  hRunMutex;
HANDLE  hThreadMutex;
int     ThreadNr = 0; 
bool flag = false;

BOOL GetProcessList () 
{ 
    HANDLE         hProcessSnap = NULL; 
    BOOL           bRet      = FALSE; 
    THREADENTRY32 pe32      = {0}; 
 
    //  Take a snapshot of all processes in the system. 

    hProcessSnap = CreateToolhelp32Snapshot(TH32CS_SNAPTHREAD, 0); 

    if (hProcessSnap == INVALID_HANDLE_VALUE) 
        return (FALSE); 
 
    //  Fill in the size of the structure before using it. 

    pe32.dwSize = sizeof(THREADENTRY32); 
 
    //  Walk the snapshot of the processes, and for each process, 
    //  display information. 

    if (Thread32First(hProcessSnap, &pe32)) 
    { 
        while (Thread32Next(hProcessSnap, &pe32)); 
        { 
            
        } 
         
        bRet = TRUE; 
    } 
    else 
        bRet = FALSE;    // could not walk the list of processes 
 
    // Do not forget to clean up the snapshot object. 

    CloseHandle (hProcessSnap); 
    return (bRet); 
} 

DWORD WINAPI ThrdFunc(LPVOID param)
{
	WaitForSingleObject( hThreadMutex, INFINITE );
	LOG_D(("Start thread"));
	ThreadParam* par = (ThreadParam*)param;
	AutoTest* test= new AutoTest;
	test->SetLogin(par->user_login);
	test->SetPass(par->user_pass);
	test->init_common();
	flag = test->TryConnect();
	unsigned long counter=0;
	LOG_D(("Terminate thread"));
	ReleaseMutex(hThreadMutex);
	TerminateThread(GetCurrentThread(), -1);
	while( WaitForSingleObject( hRunMutex, 50L ) == WAIT_TIMEOUT)
	{
		LOG_D(("Wait, %d ms", (counter++)*50L));
	}
	ReleaseMutex(hThreadMutex);
	delete test;
	return 0;
}

void ShutDown( void )                  /* Shut down threads */
{
    while ( ThreadNr > 0 )
    {
            /* Tell thread to die and record its death. */
            ReleaseMutex( hRunMutex );
            ThreadNr--;   
    }
    WaitForSingleObject( hThreadMutex, INFINITE );
}

int main(int argc, char* argv[])
{	
	GblAdapter::ApplicationHelper::send_keep_alive = true;
	if (argc<3)
		return-1;
	DWORD dwThreadId;
	hThreadMutex = CreateMutex( NULL, FALSE, NULL );
	hRunMutex = CreateMutex( NULL, TRUE, NULL );  
	ThreadParam par(argv[1], argv[2]);
	gbladapter_init();
	while (!_kbhit())
	{
		ThreadNr++;
		flag = false;
		HANDLE ThreadHandle = CreateThread( 
			NULL,                        // default security attributes 
			0,                           // use default stack size  
			ThrdFunc,                  // thread function 
			&par,                // argument to thread function 
			0,                           // use default creation flags 
			&dwThreadId);  
		//_beginthread(ThrdFunc, 0, &par);
		while ((flag == false) && !_kbhit());
		ThreadNr--;
		for (int i=0;i<12200;i++)
		{
			if (_kbhit())
			{
				ShutDown();
				CloseHandle(hRunMutex);
				return 0;
			}
			Sleep(1);
		}

	}
	ShutDown();
	CloseHandle(hRunMutex);
	gbladapter_done();
	return 0;
}