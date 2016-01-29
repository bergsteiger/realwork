#include "ACE/ACE.h"
#include "ace/Thread_Manager.h"
#include <string>
#include <windows.h>
#include <conio.h>
#include "ace/Get_Opt.h"
#include <stdio.h>

#include <fstream>
#include "scrshot.h"


#ifdef _PROCESS_WIN9X_
	#ifdef _PROCESS_WINNT_
		#undef _PROCESS_WINNT_
	#endif
#endif

#ifndef _PROCESS_WIN9X_
	#ifndef _PROCESS_WINNT_
		#define _PROCESS_WINNT_
	#endif
#endif

struct AceAutoInit {
	AceAutoInit () {			
		ACE::init ();
	}
	~AceAutoInit () {
		ACE::fini ();

	}
};

struct ThreadParam {
	std::string app_name; //им€ процесса, которому будем слать сообщени€
	std::string shell_name;
	std::string cmd_line;
	std::string fullPathToLog;
	std::string fullPathToScrShots;
	double timeout; // врем€ в течении которого должен прийти ответ в минутах

	ThreadParam () {
		app_name = "";
		cmd_line = "";
		shell_name = "F1Shell.run";
		fullPathToLog = "";
		fullPathToScrShots = "c:/";
		timeout = 0;
	}

	ThreadParam (const char* name, const char* cmd, const char* shell, double time) {
		app_name = name;
		cmd_line = cmd;
		shell_name = shell;
		timeout = time;
	}
};


static ThreadParam g_par; //параметр передаваемый в поток

// Parse the command-line arguments and set options.
static void
parse_args (int argc, ACE_TCHAR *argv[])
{
	ACE_Get_Opt get_opt (argc, argv, ACE_TEXT("e:t:c:f:l:s:"));

	int c;

	while ((c = get_opt ()) != -1)
		switch (c) {
			case 'e':
				g_par.app_name = get_opt.opt_arg ();
				break;
			case 't': {
						std::string tmp_str = get_opt.opt_arg ();
						g_par.timeout = atof (tmp_str.c_str());
					  }
				break;
			case 'c':
				g_par.cmd_line = get_opt.opt_arg ();
				break;
			case 'f':
				g_par.shell_name = get_opt.opt_arg ();
				break;
			case 'l':
				g_par.fullPathToLog = get_opt.opt_arg ();
				break;
			case 's':
				{
					g_par.fullPathToScrShots = get_opt.opt_arg();
					char lastChar = g_par.fullPathToScrShots.at( g_par.fullPathToScrShots.length()-1 );
					if ( ( lastChar == '/' ) || ( lastChar == '\\' ) || ( lastChar == '"' ) )
						g_par.fullPathToScrShots.erase(g_par.fullPathToScrShots.length()-1, 1);
				}
				break;
			default:
				ACE_DEBUG ((LM_DEBUG, "usage:\n"
							"-e <process name>\n"
							"-t <timeout in minutes>\n"
							"-c <cmd line>\n"
							"-f <F1Shell name without extension, e.g: \"F1Shell\">\n"
							"-l <full path to log file (logging to console if empty)>\n"
							"-s <full path to folder, where screenshots will be saved (by default: c:\ )>\n"));
				break;
		}
}

bool test_err_testcomplete () {
	HWND err_handle = FindWindow ("#32770", "TestComplete");
	if (err_handle != 0) {
		HWND err_label_handle = FindWindowEx(err_handle, NULL, "Static", "TestComplete has encountered a problem and needs to close. We are sorry for the inconvenience.");		
		if (err_label_handle != 0) {
			return true;
		}
	}

	return false;
}


DWORD get_process_by_name (const char* process_name);
struct PIDANDHANDLE
{
	DWORD proc_id;
	LPCSTR wnd_class;
	HWND hwnd;

	PIDANDHANDLE() : proc_id(0), hwnd(NULL) {};
};

BOOL CALLBACK MyEnumWindowsFunc(HWND hwnd, LPARAM lParam)
{
	PIDANDHANDLE *pS = reinterpret_cast<PIDANDHANDLE*>(lParam);
	DWORD proc_id;
	GetWindowThreadProcessId(hwnd, &proc_id);

	char buf[1024];

	bool notFounded = !(
		(proc_id == pS->proc_id) 
		&& (GetClassName(hwnd, buf, 1024) != 0) 
		&& (strcmp(buf, pS->wnd_class) == 0) 
	);

	if ( !notFounded ) pS->hwnd = hwnd;

	return notFounded;
};


//static DWORD WINAPI test_app(void* param) {	
static ACE_THR_FUNC_RETURN test_app(void* param) {
	
	ThreadParam* par = static_cast<ThreadParam*> (param);
	HWND app_handle = FindWindow ("TnsMainWindow", NULL);
	if (test_err_testcomplete ()) {
		ACE_DEBUG((LM_DEBUG, "%D - TestComplete crashed!!!\n"));
		ACE_OS::sleep (ACE_Time_Value ((long)par->timeout*60*2));
	}

	if (app_handle != 0) {
		SendMessage ((HWND)app_handle, WM_USER+1, 0, 0);
	}

	// находим процесс тесткомплита
	DWORD tc_proc_id = get_process_by_name("testcomplete");
	if (tc_proc_id != NULL)
	{	
		PIDANDHANDLE p;
		p.proc_id = tc_proc_id;
		
		// находим окно тесткомплита с часиками
		p.hwnd = NULL;
		p.wnd_class = "TFormIndicator";
		EnumWindows(&MyEnumWindowsFunc, (LPARAM)&p);
		if ( p.hwnd != NULL )
		{
			ACE_DEBUG ((LM_DEBUG, "%D - FormIndicator founded. Sending message.\n"));
			// посылаем ему сообщение
			DWORD startTime = GetTickCount();
			SendMessage(p.hwnd, WM_USER+1, 0, 0);
			DWORD timeDiff = GetTickCount() - startTime;
			//
			char buf[1024];
			sprintf(buf, "%%D - SendMessage returned after %u milliseconds.\n\n", timeDiff);
			ACE_DEBUG((LM_DEBUG, buf ));
		}

		// находим главное окно тесткомплита
		p.hwnd = NULL;
		p.wnd_class = "TMainForm";		
		EnumWindows(&MyEnumWindowsFunc, (LPARAM)&p);
		if ( p.hwnd != NULL )
		{
			ACE_DEBUG ((LM_DEBUG, "%D - MainForm founded. Sending message.\n"));
			// посылаем ему сообщение
			DWORD startTime = GetTickCount();
			SendMessage(p.hwnd, WM_USER+1, 0, 0);
			DWORD timeDiff = GetTickCount() - startTime;
			//
			char buf[1024];
			sprintf(buf, "%%D - SendMessage returned after %u milliseconds.\n\n", timeDiff);
			ACE_DEBUG((LM_DEBUG, buf ));
		}

	}

	ExitThread (0);
}

std::string generate_cmdline (const char* app, const char* cmd) {
	std::string tmp = "\""; 
	tmp.append (app);
	tmp += "\" ";
	tmp.append (cmd);
	return std::string (tmp);
}

#ifdef _PROCESS_WIN9X_
	#include <tlhelp32.h>
	DWORD get_process_by_name (const char* process_name) {

		HANDLE         hProcessSnap = NULL; 
		BOOL           bRet      = FALSE; 
		PROCESSENTRY32 pe32      = {0}; 
		DWORD ret_handle = 0;
	 
		//  Take a snapshot of all processes in the system. 

		hProcessSnap = CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0); 

		if (hProcessSnap == INVALID_HANDLE_VALUE) 
			return 0; 
	 
		//  Fill in the size of the structure before using it. 

		pe32.dwSize = sizeof(PROCESSENTRY32); 
	 
		//  Walk the snapshot of the processes, and for each process, 
		//  display information. 

		if (Process32First(hProcessSnap, &pe32)) 
		{ 
			BOOL          bGotModule = FALSE; 
			MODULEENTRY32 me32       = {0}; 
	 
			do 
			{ 
				if (strstr (pe32.szExeFile, process_name) != NULL) {					
					ret_handle = pe32.th32ProcessID;

					//CloseHandle (hProcess);
					break;
				}
			} 
			while (Process32Next(hProcessSnap, &pe32)); 
		} 
		else 
			ret_handle = NULL;    // could not walk the list of processes 
	 
		// Do not forget to clean up the snapshot object. 

		CloseHandle (hProcessSnap);
		return ret_handle;
	}

#endif

#ifdef _PROCESS_WINNT_

	#include "psapi.h"

	DWORD get_process_by_name (const char* process_name) {
			// Get the list of process identifiers.

			DWORD aProcesses[1024], cbNeeded, cProcesses;
			unsigned int i;
			DWORD ret_handle = 0;

			if ( !EnumProcesses( aProcesses, sizeof(aProcesses), &cbNeeded ) )
				return 0;

			// Calculate how many process identifiers were returned.

			cProcesses = cbNeeded / sizeof(DWORD);

			// Print the name and process identifier for each process.

			for ( i = 0; i < cProcesses; i++ ) {
				char szProcessName[MAX_PATH] = "unknown";
				DWORD processID = aProcesses[i];

				// Get a handle to the process.

				HANDLE hProcess = OpenProcess( PROCESS_QUERY_INFORMATION |
											PROCESS_VM_READ,
											FALSE, processID );

				// Get the process name.

				if (NULL != hProcess )
				{
					HMODULE hMod;
					DWORD cbNeeded;

					if ( EnumProcessModules( hProcess, &hMod, sizeof(hMod), 
						&cbNeeded) )
					{
						GetModuleBaseName( hProcess, hMod, szProcessName, 
										sizeof(szProcessName) );
					
					//printf( "%s (Process ID: %u)\n", szProcessName, processID );
						if (strstr (szProcessName, process_name) != NULL) {
							ret_handle = processID;
							CloseHandle( hProcess );
							break;
						}

					CloseHandle( hProcess );

					}
				}
			}
		return ret_handle;
	}

#endif

void TerminateShell (const char* name) {

	for (DWORD pid = get_process_by_name (name); pid > 0; pid = get_process_by_name (name)) {
		HANDLE process_handle = OpenProcess (PROCESS_ALL_ACCESS, FALSE, pid);
		TerminateProcess (process_handle, 0);
		CloseHandle (process_handle); 	
	} 
	
}

static ACE_Thread_Manager aceThreadManager;

ofstream* logFileStream;

int main (int argc, char* argv []) {
	AceAutoInit ai;
	DWORD err = 0;
	
	parse_args (argc, argv);
	
	if (g_par.fullPathToLog != "")
	{ // включаем вывод лога в файл
		logFileStream = new ofstream();
		logFileStream->open(g_par.fullPathToLog.c_str(), ios::out | ios::app);
		if (!logFileStream->bad ()) {
			ACE_LOG_MSG->msg_ostream (logFileStream);		
		} else {
			delete logFileStream;
		}
		ACE_LOG_MSG->clr_flags (ACE_Log_Msg::STDERR | ACE_Log_Msg::LOGGER);
		ACE_LOG_MSG->set_flags (ACE_Log_Msg::OSTREAM);
	};
	ACE_DEBUG ((LM_DEBUG, "\n-----------------------------------------------\n%D - Yeah! We are started!!!\n"));

	//g_par.app_name.insert(0, "start ");
	STARTUPINFO si;
    PROCESS_INFORMATION pi;

    ZeroMemory( &si, sizeof(si) );
    si.cb = sizeof(si);
    ZeroMemory( &pi, sizeof(pi) );
	
	std::string cmd_line = generate_cmdline (g_par.app_name.c_str (), g_par.cmd_line.c_str ());
	LPSTR cmd = (LPSTR)cmd_line.c_str ();
	CreateProcess ( NULL, // No module name (use command line). 
					cmd, // Command line. 
					NULL,             // Process handle not inheritable. 
					NULL,             // Thread handle not inheritable. 
					FALSE,            // Set handle inheritance to FALSE. 
					0,                // No creation flags. 
					NULL,             // Use parent's environment block. 
					NULL,             // Use parent's starting directory. 
					&si,              // Pointer to STARTUPINFO structure.
					&pi );             // Pointer to PROCESS_INFORMATION structure.

	if (pi.hProcess != 0) {
		while (!_kbhit()) {

			ACE_OS::sleep (ACE_Time_Value (20));

			HANDLE hThread; 
			char szMsg[80];
			DWORD dwThreadId;

			aceThreadManager.spawn(test_app, &g_par, 0, 0, &hThread); 

			/*hThread = CreateThread( 
				NULL,                        // default security attributes 
				0,                           // use default stack size  
				test_app,                  // thread function 
				&g_par,						// argument to thread function 
				0,                           // use default creation flags 
				&dwThreadId);                // returns the thread identifier 
		    */
			if (hThread == NULL) {
				wsprintf( szMsg, "CreateThread failed." ); 
				MessageBox( NULL, szMsg, "main", MB_OK );
				break;
			}
			ACE_OS::sleep (ACE_Time_Value (5));// ждЄм пока 5 секунд, чтобы запустилс€ поток
			//засыпаем на g_par.timeout минут
			ACE_OS::sleep (ACE_Time_Value ((long)g_par.timeout*60));
			DWORD thread_exit_code = 0;
			DWORD process_exit_code = 0;
			if (GetExitCodeThread (hThread, &thread_exit_code) == TRUE &&
				GetExitCodeProcess (pi.hProcess, &process_exit_code) == TRUE) {
				if (thread_exit_code == STILL_ACTIVE) {
					ACE_DEBUG ((LM_DEBUG, "%D - Time is out, thread will be terminated\n"));
					TerminateThread (hThread, 0);

					if (process_exit_code == STILL_ACTIVE) {

						ACE_DEBUG ((LM_DEBUG, "%D - Time is out, process will be terminated\n"));
						// снимаем скриншот
						char buf[1024];						
						time_t timer;
						time(&timer);
						strftime(buf, 1024, "%Y-%m-%d %H-%M-%S.ScreenShot.bmp", localtime(&timer) );
						DoScreenShot((g_par.fullPathToScrShots + '\\' + buf).c_str() );

						TerminateProcess (pi.hProcess, 0);
						TerminateShell (g_par.shell_name.c_str ());

						ACE_OS::sleep (ACE_Time_Value (20));

						
						ZeroMemory( &si, sizeof(si) );
						si.cb = sizeof(si);
						ZeroMemory( &pi, sizeof(pi) );

						// Start the child process. 
						CreateProcess( NULL, // No module name (use command line). 
										cmd, // Command line. 
										NULL,             // Process handle not inheritable. 
										NULL,             // Thread handle not inheritable. 
										FALSE,            // Set handle inheritance to FALSE. 
										0,                // No creation flags. 
										NULL,             // Use parent's environment block. 
										NULL,             // Use parent's starting directory. 
										&si,              // Pointer to STARTUPINFO structure.
										&pi );             // Pointer to PROCESS_INFORMATION structure.
						if (pi.hProcess == 0){
							ACE_DEBUG ((LM_DEBUG, "%D - Can't start application\n"));
							break;
						}
					}
					
				}
				
			}
			/*
			while (!_kbhit()) {
				//ждЄм может поток уже завершилс€, если да, то выходим
				ACE_Time_Value time_end (ACE_OS::gettimeofday ());
				ACE_Time_Value timeout = time_end - time_start;
				time_end += 1;
				//если прошло врем€ ожидани€, то выходим
				if (g_par.timeout != 0 && timeout.msec() >= g_par.timeout*(60*1000)) {
					ACE_DEBUG ((LM_DEBUG, "Time is out, thred will be terminated:\n"));
					//int res = ACE_Thread_Manager::instance ()->kill_all (SIGINT);
					bool res = TerminateThread (hThread, 0);
					break;
				}
			}*/
			CloseHandle (hThread);
		}
	} else {
		ACE_DEBUG ((LM_DEBUG, "%D - Can't start application\n"));
	}

	CloseHandle( pi.hProcess );
    CloseHandle( pi.hThread );
	return 0;
}