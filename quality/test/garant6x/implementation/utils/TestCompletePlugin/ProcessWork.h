#pragma once

#include <psapi.h>
#include <windows.h>
#include <tchar.h>

struct PIDANDHANDLE
{
	DWORD procID;
	LPCTSTR wndClass;
	HWND hwnd;

	PIDANDHANDLE() : procID(0), hwnd(NULL), wndClass(_T("")) {};
};

BOOL CALLBACK EnumWindowsFunc(HWND hwnd, LPARAM lParam)
{
	PIDANDHANDLE *pS = reinterpret_cast<PIDANDHANDLE*>(lParam);
	DWORD procID;
	GetWindowThreadProcessId(hwnd, &procID);

	TCHAR buf[1024];

	bool isFounded = (
		(procID == pS->procID) 
		&& (GetClassName(hwnd, buf, sizeof(buf)/sizeof(TCHAR)) != 0) 
		&& (_tcscmp(buf, pS->wndClass) == 0) 
	);

	if ( isFounded ) pS->hwnd = hwnd;

	return !isFounded;
};

DWORD GetProcessIDByName (LPCTSTR lpszProcessName) 
{
	// Get the list of process identifiers.
	DWORD aProcesses[1024], cbNeeded, cProcesses;
	DWORD ret_handle = 0;

	if ( !EnumProcesses( aProcesses, sizeof(aProcesses), &cbNeeded ) )
		return 0;

	// Calculate how many process identifiers were returned.
	cProcesses = cbNeeded/sizeof(DWORD);

	// Print the name and process identifier for each process.
	for (DWORD i = 0; i < cProcesses; i++ ) {
		TCHAR szProcessName[MAX_PATH] = _T("unknown");
		const DWORD processID = aProcesses[i];

		// Get a handle to the process.
		const HANDLE hProcess = OpenProcess( PROCESS_QUERY_INFORMATION | PROCESS_VM_READ,	FALSE, processID );

		// Get the process name.
		if (NULL != hProcess )
		{
			HMODULE hMod;
			DWORD cbNeeded;
			if ( EnumProcessModules( hProcess, &hMod, sizeof(hMod), &cbNeeded) )
			{
				GetModuleBaseName( hProcess, hMod, szProcessName, sizeof(szProcessName)/sizeof(TCHAR) );			
				if (_tcsstr(szProcessName, lpszProcessName) != NULL) {
					ret_handle = processID;
					CloseHandle(hProcess);
					break;
				}		
			}
			CloseHandle(hProcess);
		}
	}
	return ret_handle;	
}

HWND FindWindowFromProcess(
	LPCTSTR lpszProcessName,
	LPCTSTR wndClass
)
{
	HWND result = NULL;
	//
	const DWORD dwPID = GetProcessIDByName(lpszProcessName);
	if (dwPID != 0)
	{
		PIDANDHANDLE pah;
		pah.procID = dwPID;
		pah.wndClass = wndClass;
		//
		EnumWindows(&EnumWindowsFunc, (LPARAM)&pah);
		if (pah.hwnd != NULL)
			result = pah.hwnd;
	}
	return result;
}