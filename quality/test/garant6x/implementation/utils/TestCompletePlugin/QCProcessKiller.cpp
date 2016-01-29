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
		return Error(_T("Поток-убивалка не работает!"), GUID_NULL, E_FAIL);
	//
	// проверяем, может мы уже запущены
	if ( WaitForSingleObject(hHasStartedEvent, 0) == WAIT_OBJECT_0)
	{ // запущены - сначала останавливаемся
		TestCompleteLog(_T("Warning"), _T("Обнаружена попытка запустить убивалку процесса в то время как она уже запущена. Поэтому сначала останавливаем ее."), isAllowLog);
		Stop();
	}

	ResetEvent(hMustStopEvent);
	SetEvent(hMustStartEvent);
	if ( WaitForSingleObject(hHasStartedEvent, START_STOP_TIMEOUT) == WAIT_TIMEOUT)
	{ // в течении отведенного таймаута поток не перешел в состояние "запущено"
		// ругаемся
		return Error(_T("Ошибка перевода потока-убивалки в запущенное состояние!"), IID_IQCProcessKiller, E_FAIL);
	}
	else 
	{  // успешно запустили
		#ifdef DEBUG
		TestCompleteLog(_T("Message"), _T("Успешно запустились."), isAllowLog);
		#endif
		return S_OK;
	}
}

STDMETHODIMP CQCProcessKiller::Stop(void)
{
	if (!IsKillingThreadLive())
		return Error(_T("Поток-убивалка не работает!"), GUID_NULL, E_FAIL);
	//
	SetEvent(hMustStopEvent);
	if ( WaitForSingleObject(hHasStoppedEvent, START_STOP_TIMEOUT) == WAIT_TIMEOUT)
	{ // в течении отведенного таймаута поток не перешел в состояние "остановлена"
		// ругаемся
		return Error(_T("Ошибка перевода потока-убивалки в остановленное состояние!"), IID_IQCProcessKiller, E_FAIL);
	}
	else // успешно остановили
	{
		#ifdef DEBUG
		TestCompleteLog(_T("Message"), _T("Успешно остановились."), isAllowLog); 
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
		// говорим, что не запущены
		ResetEvent(pSelf->hHasStartedEvent);
		SetEvent(pSelf->hHasStoppedEvent);
		// проверяем, может нам надо выходить
		if (pSelf->isThreadMustExit) 
			return 0;
		// ждем пока разрещат продолжать
		WaitForSingleObject(pSelf->hMustStartEvent, INFINITE); 
		pSelf->hasKilled = false;
		// говорим, что запущены
		ResetEvent(pSelf->hHasStoppedEvent);		
		SetEvent(pSelf->hHasStartedEvent);		
		// а теперь ждем, может и не надо убивать процесс
		DWORD dwStopWaitStatus;
		if ( (pSelf->isThreadMustExit) || (( dwStopWaitStatus = WaitForSingleObject(pSelf->hMustStopEvent, pSelf->dwDelay)) == WAIT_OBJECT_0) )
		{ // таки да, не надо
			continue; 
		}
		else
			if (dwStopWaitStatus == WAIT_FAILED)
			{
				TestCompleteLog("Message", _T("Ошибка при ожидании на эвенте остановки: ") + GetLastErrorDesc(), pSelf->isAllowLog);
			}
		// надо прибить процесс
		
		TCHAR buf[2048];
		// получаем его хэндл
		HANDLE hProcess = OpenProcess(PROCESS_TERMINATE, false, pSelf->dwPID);
		if (hProcess != NULL)
		{ // успешно получили хэндл процесса
			// прибиваем процесс
			TerminateProcess(hProcess, 1);
			pSelf->hasKilled = true;
			CloseHandle(hProcess);
			// пишем сообщение в лог			
			_sntprintf_s<_countof(buf)>(buf, _TRUNCATE, _T("Процесс с PID %d убит"), pSelf->dwPID);
			TestCompleteLog("Message", buf, pSelf->isAllowLog);
		}
		else
		{ // не удалось получить хэндл процесса
			_sntprintf_s<_countof(buf)>(buf, _TRUNCATE, _T("Не удалось получить хэндл процесса с PID %d потому что произошла ошибка \"%s\"."), pSelf->dwPID, GetLastErrorDesc());
			// сообщаем в лог тесткомплита об этом
			TestCompleteLog("Warning", buf, pSelf->isAllowLog);
		}


	}
}

bool CQCProcessKiller::IsKillingThreadLive(void)
{
	DWORD dwExitCode;
	return ( GetExitCodeThread(hKillingThread, &dwExitCode) && (dwExitCode == STILL_ACTIVE) );
}