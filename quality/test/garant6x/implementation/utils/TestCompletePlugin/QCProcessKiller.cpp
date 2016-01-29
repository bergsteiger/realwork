// QCProcessKiller.cpp : Implementation of CQCProcessKiller

#include "stdafx.h"
#include "QCProcessKiller.h"

#include <Windows.h>

#include <script.h>


// CQCProcessKiller

STDMETHODIMP CQCProcessKiller::InterfaceSupportsErrorInfo(REFIID riid)
{
	static const IID* arr[] = 
	{
		&IID_IQCProcessKiller
	};

	for (int i=0; i < sizeof(arr) / sizeof(arr[0]); i++)
	{
		if (InlineIsEqualGUID(*arr[i],riid))
			return S_OK;
	}
	return S_FALSE;
}

STDMETHODIMP CQCProcessKiller::Start(void)
{
	if (!IsKillingThreadLive())
		return Error(_T("�����-�������� �� ��������!"), GUID_NULL, E_FAIL);
	//
	// ���������, ����� �� ��� ��������
	if ( WaitForSingleObject(hHasStartedEvent, 0) == WAIT_OBJECT_0)
	{ // �������� - ������� ���������������
		TestCompleteLog(_T("Warning"), _T("���������� ������� ��������� �������� �������� � �� ����� ��� ��� ��� ��������. ������� ������� ������������� ��."), isAllowLog);
		Stop();
	}

	ResetEvent(hMustStopEvent);
	SetEvent(hMustStartEvent);
	if ( WaitForSingleObject(hHasStartedEvent, START_STOP_TIMEOUT) == WAIT_TIMEOUT)
	{ // � ������� ����������� �������� ����� �� ������� � ��������� "��������"
		// ��������
		return Error(_T("������ �������� ������-�������� � ���������� ���������!"), IID_IQCProcessKiller, E_FAIL);
	}
	else 
	{  // ������� ���������
		#ifdef DEBUG
		TestCompleteLog(_T("Message"), _T("������� �����������."), isAllowLog);
		#endif
		return S_OK;
	}
}

STDMETHODIMP CQCProcessKiller::Stop(void)
{
	if (!IsKillingThreadLive())
		return Error(_T("�����-�������� �� ��������!"), GUID_NULL, E_FAIL);
	//
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

STDMETHODIMP CQCProcessKiller::get_HasKilled(VARIANT_BOOL* pVal)
{
	*pVal = hasKilled ? VARIANT_TRUE : VARIANT_FALSE;
	return S_OK;
}

STDMETHODIMP CQCProcessKiller::get_PID(ULONG* pVal)
{
	*pVal = dwPID;
	return S_OK;
}

STDMETHODIMP CQCProcessKiller::put_PID(ULONG newVal)
{
	dwPID = newVal;
	return S_OK;
}

STDMETHODIMP CQCProcessKiller::get_Delay(ULONG* pVal)
{
	*pVal = dwDelay;
	return S_OK;
}

STDMETHODIMP CQCProcessKiller::put_Delay(ULONG newVal)
{
	dwDelay = newVal;
	return S_OK;
}

DWORD WINAPI CQCProcessKiller::KillngThread(LPVOID lpParam)
{
	CQCProcessKiller* pSelf = static_cast<CQCProcessKiller*>(lpParam);
#pragma warning (disable:4127)
	while (true)
#pragma warning (default:4127)
	{
		// �������, ��� �� ��������
		ResetEvent(pSelf->hHasStartedEvent);
		SetEvent(pSelf->hHasStoppedEvent);
		// ���������, ����� ��� ���� ��������
		if (pSelf->isThreadMustExit) 
			return 0;
		// ���� ���� �������� ����������
		WaitForSingleObject(pSelf->hMustStartEvent, INFINITE); 
		pSelf->hasKilled = false;
		// �������, ��� ��������
		ResetEvent(pSelf->hHasStoppedEvent);		
		SetEvent(pSelf->hHasStartedEvent);		
		// � ������ ����, ����� � �� ���� ������� �������
		DWORD dwStopWaitStatus;
		if ( (pSelf->isThreadMustExit) || (( dwStopWaitStatus = WaitForSingleObject(pSelf->hMustStopEvent, pSelf->dwDelay)) == WAIT_OBJECT_0) )
		{ // ���� ��, �� ����
			continue; 
		}
		else
			if (dwStopWaitStatus == WAIT_FAILED)
			{
				TestCompleteLog("Message", _T("������ ��� �������� �� ������ ���������: ") + GetLastErrorDesc(), pSelf->isAllowLog);
			}
		// ���� ������� �������
		
		TCHAR buf[2048];
		// �������� ��� �����
		HANDLE hProcess = OpenProcess(PROCESS_TERMINATE, false, pSelf->dwPID);
		if (hProcess != NULL)
		{ // ������� �������� ����� ��������
			// ��������� �������
			TerminateProcess(hProcess, 1);
			pSelf->hasKilled = true;
			CloseHandle(hProcess);
			// ����� ��������� � ���			
			_sntprintf_s<_countof(buf)>(buf, _TRUNCATE, _T("������� � PID %d ����"), pSelf->dwPID);
			TestCompleteLog("Message", buf, pSelf->isAllowLog);
		}
		else
		{ // �� ������� �������� ����� ��������
			_sntprintf_s<_countof(buf)>(buf, _TRUNCATE, _T("�� ������� �������� ����� �������� � PID %d ������ ��� ��������� ������ \"%s\"."), pSelf->dwPID, GetLastErrorDesc());
			// �������� � ��� ������������ �� ����
			TestCompleteLog("Warning", buf, pSelf->isAllowLog);
		}


	}
}

bool CQCProcessKiller::IsKillingThreadLive(void)
{
	DWORD dwExitCode;
	return ( GetExitCodeThread(hKillingThread, &dwExitCode) && (dwExitCode == STILL_ACTIVE) );
}