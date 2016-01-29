// QCShellWatchdog.cpp : Implementation of CQCShellWatchdog

#include "stdafx.h"
#include "QCShellWatchdog.h"

#include "ProcessWork.h"
#include <script.h>

// CQCShellWatchdog

#define SHELL_PROCESS_NAME (_T("F1Shell.run"))

STDMETHODIMP CQCShellWatchdog::Start(VARIANT_BOOL* result)
{
	// ���������, ����� �� ��� ��������
	if ( WaitForSingleObject(hHasStartedEvent, 0) == WAIT_OBJECT_0)
	{ // �������� - ������� ���������������
		TestCompleteLog(_T("Warning"), _T("���������� ������� ��������� �������� ����� � �� ����� ��� �� ��� ��������. ������� ������� ������������� ���."), isAllowLog);
		Stop();
	}

	SetEvent(hMustStartEvent);
	if ( WaitForSingleObject(hHasStartedEvent, START_STOP_TIMEOUT) == WAIT_TIMEOUT)
	{ // � ������� ����������� �������� ����� �� ������� � ��������� "��������"
		// ��������
		*result = VARIANT_FALSE;
		return Error(_T("������ �������� ��������� ������ � ���������� ���������!"), IID_IQCShellWatchdog, E_FAIL);
	}
	else 
	{ // ������� ���������
		#ifdef DEBUG
		TestCompleteLog(_T("Message"), _T("������� �����������."), isAllowLog);
		#endif
		*result = VARIANT_TRUE;
		return S_OK;
	}
}

STDMETHODIMP CQCShellWatchdog::Stop(void)
{
	ResetEvent(hMustStartEvent);
	SetEvent(hMustStopEvent);
	if ( WaitForSingleObject(hHasStoppedEvent, START_STOP_TIMEOUT) == WAIT_TIMEOUT)
	{ // � ������� ����������� �������� ����� �� ������� � ��������� "�����������"
		// ��������
		return Error(_T("������ �������� ������-�������� � ������������� ���������!"), IID_IQCProcessKiller, E_FAIL);
	}
	else // ������� ����������
	{
		#ifdef DEBUG
		TestCompleteLog(_T("Message"), _T("������� ������������."), isAllowLog); 
		#endif
		return S_OK;	
	}
}

STDMETHODIMP CQCShellWatchdog::get_IsKillShell(VARIANT_BOOL* pVal)
{
	*pVal = isKillShell ? VARIANT_TRUE : VARIANT_FALSE;
	return S_OK;
}

STDMETHODIMP CQCShellWatchdog::put_IsKillShell(VARIANT_BOOL newVal)
{	
	isKillShell = (newVal == VARIANT_TRUE);
	return S_OK;
}

STDMETHODIMP CQCShellWatchdog::get_HangTimeout(ULONG* pVal)
{
	*pVal = dwHangTimeout;
	return S_OK;
}

STDMETHODIMP CQCShellWatchdog::put_HangTimeout(ULONG newVal)
{
	dwHangTimeout = newVal;
	return S_OK;
}

DWORD WINAPI CQCShellWatchdog::WatcherThread(LPVOID lpParam)
{
	CQCShellWatchdog* pSelf = static_cast<CQCShellWatchdog*>(lpParam);
	//
	HANDLE hCheckerThread = NULL;
#pragma warning (disable:4127)
	while (true)
#pragma warning (default:4127)
	{	
		// � ����� ������ ������������� �����-�����
		if (hCheckerThread != NULL)
		{
			TerminateThread(hCheckerThread, 1);
			CloseHandle(hCheckerThread);
		}
		// �������, ��� �� ��������
		ResetEvent(pSelf->hHasStartedEvent);
		SetEvent(pSelf->hHasStoppedEvent);
		// ���������, ����� ��� ���� ��������
		if (pSelf->isThreadMustExit) 
			return 0;
		// ���� ���� �������� ����������
		WaitForSingleObject(pSelf->hMustStartEvent, INFINITE);
		// �������, ��� ��������
		ResetEvent(pSelf->hHasStoppedEvent);
		SetEvent(pSelf->hHasStartedEvent);		
		// ���������, ����� ��� ���� ��������
		if (pSelf->isThreadMustExit) 
			return 0;
		// ��������� �����-�����
		pSelf->dwPID = 0;
		hCheckerThread = CreateThread(NULL, 0, &CheckerThread, (LPVOID)pSelf, 0, NULL);
		DWORD dwExitCode;		
		if (hCheckerThread == NULL) 
			TestCompleteLog(_T("Error"), _T("�� ������� ��������� ����������� �����!"), pSelf->isAllowLog);		
		//
		// � ������ ����, ����� �� ���� ���������
		if ( (pSelf->isThreadMustExit) || (WaitForSingleObject(pSelf->hMustStopEvent, pSelf->dwHangTimeout) == WAIT_OBJECT_0) )
		{ // �� ����
			continue; 
		}	
		// ������ �������, ���� ����� ��� ���, �� �������, ��� ��� ��������� ���������� ���������
		if	( (hCheckerThread != NULL) 
			&& GetExitCodeThread(hCheckerThread, &dwExitCode)
			&& (dwExitCode == STILL_ACTIVE) )
		{			
			if ((pSelf->dwPID != 0) && (pSelf->isKillShell))
			{ // ���� ����� ��������
				// �������� ����� ��������
				HANDLE hShellProc = OpenProcess(PROCESS_TERMINATE, false, pSelf->dwPID);
				if (hShellProc != NULL)
				{ // ��������� ��������
					if ( TerminateProcess(hShellProc, 1) )
						TestCompleteLog(_T("Message"), _T("�������� ������� �������"), pSelf->isAllowLog)
					else
						TestCompleteLog(_T("Warning"), _T("�� ������� ������� ��������"), pSelf->isAllowLog)
					CloseHandle(hShellProc);								
				} // if
			} // if
			TestCompleteLog(_T("Error"), _T("���������� ��������� ��������!"), pSelf->isAllowLog);
		} // if
	} // while
}

DWORD WINAPI CQCShellWatchdog::CheckerThread(LPVOID lpParam)
{
	CQCShellWatchdog* pSelf = static_cast<CQCShellWatchdog*>(lpParam);
	//
	HWND shellWnd;
	pSelf->dwPID = GetProcessIDByName(SHELL_PROCESS_NAME);
	// ������� ���� ������� ���� ��������
	shellWnd = FindWindowFromProcess(SHELL_PROCESS_NAME, _T("TnsMainWindow"));
	// ���� �� �����, �� ���� ����� ������
	if (shellWnd == NULL)
		shellWnd = FindWindowFromProcess(SHELL_PROCESS_NAME, _T("TnsLoginForm"));
	// ���� ���-�� �����, �� �������� ��������� ����
	// ����� � ���, ��� ���� ���������� �����, �� SendMessage �� ������ ����������
	if (shellWnd != NULL)
		SendMessage(shellWnd, WM_USER+1, 0, 0);
	//
	return 0;
}