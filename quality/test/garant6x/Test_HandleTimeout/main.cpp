#include <stdlib.h>
#include <stdio.h>
#include <process.h>
#include <windows.h>
#include <string.h>
#include <conio.h>

char cmd[]="loginonly.exe %d %d";

DWORD WINAPI SleepFunc( LPVOID lpParam ) 
{ 
    long* sleep_time = (long*)lpParam;
	Sleep(*sleep_time);
    return 0; 
} 


int main(int argc, char* argv[])
{
	if (argc<3)
	{
		printf("Error! Few parameters in cmdLine");
		_getch();
		return -1;
	}
	int j=0;
	int min = atoi(argv[1]);
	int max = atoi(argv[2]);
	STARTUPINFO si[100];
    PROCESS_INFORMATION pi[100];
	while (!_kbhit()) {
		j=0;
		for (int i=min; i<=max; i++)
		{
			char cmdLine[255] = "";
			ZeroMemory( &si[j], sizeof(si[j]) );
			si[j].cb = sizeof(si[j]);
			ZeroMemory( &pi[j], sizeof(pi[j]) );
			sprintf(cmdLine, cmd, i, i);
			if (!CreateProcess( NULL,// No module name (use command line). 
			cmdLine, // Command line. 
			NULL,             // Process handle not inheritable. 
			NULL,             // Thread handle not inheritable. 
			FALSE,            // Set handle inheritance to FALSE. 
			0,                // No creation flags. 
			NULL,             // Use parent's environment block. 
			NULL,             // Use parent's starting directory. 
			&si[j],              // Pointer to STARTUPINFO structure.
			&pi[j] ))
				
				printf("Can't create process %d\n", j);

			j++;
		}
		HANDLE* lpHandles;
		lpHandles = new HANDLE[j-1];
		j=0;
		for (i=min; i<= max; i++)
		{
			lpHandles[j] = pi[j].hProcess;
			j++;
		}
		WaitForMultipleObjects(j-1, lpHandles, TRUE, INFINITE);
		j = 0;
		for (i=min; i<= max; i++)
		{
			// Close process and thread handles. 
			CloseHandle( pi[j].hProcess );
			CloseHandle( pi[j].hThread );
			j++;
		}
				
		printf("\nProcess Sleep\n");
		HANDLE hThread;
		DWORD dwThreadId, dwThrdParam;

		if (argc>3)
		{
			dwThrdParam = atol(argv[3]);
			hThread = CreateThread( 
									NULL,// default security attributes 
									0,// use default stack size  
									SleepFunc, // thread function 
									&dwThrdParam, // argument to thread function 
									0,// use default creation flags 
									&dwThreadId); 
		}
		else {
				dwThrdParam = (10)*60500;
				hThread = CreateThread( 
									NULL,// default security attributes 
									0,// use default stack size  
									SleepFunc, // thread function 
									&dwThrdParam, // argument to thread function 
									0,// use default creation flags 
									&dwThreadId); 
		}
		if (hThread != NULL) {
			while (WaitForSingleObject( hThread, 10L ) == WAIT_TIMEOUT)
			{
				if (_kbhit())
				{
					CloseHandle(hThread);
					return 0;
				}
			}
			CloseHandle(hThread);
			printf("\nProcess Wake\n");			
		}
		
	}

//	printf("Press any key...\n");
//	_getch();
	return 0;
}