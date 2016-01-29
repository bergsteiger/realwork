// QCShellWatchdog.cpp : Implementation of CQCShellWatchdog

#include "stdafx.h"
#include "QCShellWatchdog.h"

#include "ProcessWork.h"
#include <script.h>

// CQCShellWatchdog

#define SHELL_PROCESS_NAME (_T("F1Shell.run"))

STDMETHODIMP CQCShellWatchdog::Start(VARIANT_BOOL* result)
{
	// проверяем, может мы уже запущены
	if ( WaitForSingleObject(hHasStartedEvent, 0) == WAIT_OBJECT_0)
	{ // запущены - сначала останавливаемся
		TestCompleteLog(_T("Warning"), _T("Обнаружена попытка запустить следящий поток в то время как он уже запущена. Поэтому сначала останавливаем его."), isAllowLog);
		Stop();
	}

	SetEvent(hMustStartEvent);
	if ( WaitForSingleObject(hHasStartedEvent, START_STOP_TIMEOUT) == WAIT_TIMEOUT)
	{ // в течении отведенного таймаута поток не перешел в состояние "запущено"
		// ругаемся
		*result = VARIANT_FALSE;
		return Error(_T("Ошибка перевода следящего потока в запущенное состояние!"), IID_IQCShellWatchdog, E_FAIL);
	}
	else 
	{ // успешно запустили
		#ifdef DEBUG
		TestCompleteLog(_T("Message"), _T("Успешно запустились."), isAllowLog);
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
		// в любом случае останавливаем поток-чекер
		if (hCheckerThread != NULL)
		{
			TerminateThread(hCheckerThread, 1);
			CloseHandle(hCheckerThread);
		}
		// говорим, что не запущены
		ResetEvent(pSelf->hHasStartedEvent);
		SetEvent(pSelf->hHasStoppedEvent);
		// проверяем, может нам надо выходить
		if (pSelf->isThreadMustExit) 
			return 0;
		// ждем пока разрещат продолжать
		WaitForSingleObject(pSelf->hMustStartEvent, INFINITE);
		// говорим, что запущены
		ResetEvent(pSelf->hHasStoppedEvent);
		SetEvent(pSelf->hHasStartedEvent);		
		// проверяем, может нам надо выходить
		if (pSelf->isThreadMustExit) 
			return 0;
		// порождаем поток-чекер
		pSelf->dwPID = 0;
		hCheckerThread = CreateThread(NULL, 0, &CheckerThread, (LPVOID)pSelf, 0, NULL);
		DWORD dwExitCode;		
		if (hCheckerThread == NULL) 
			TestCompleteLog(_T("Error"), _T("Не удалось запустить проверяющий поток!"), pSelf->isAllowLog);		
		//
		// а теперь ждем, может не надо проверять
		if ( (pSelf->isThreadMustExit) || (WaitForSingleObject(pSelf->hMustStopEvent, pSelf->dwHangTimeout) == WAIT_OBJECT_0) )
		{ // не надо
			continue; 
		}	
		// теперь смотрим, если поток еще жив, то считаем, что это произошло вследствие зависания
		if	( (hCheckerThread != NULL) 
			&& GetExitCodeThread(hCheckerThread, &dwExitCode)
			&& (dwExitCode == STILL_ACTIVE) )
		{			
			if ((pSelf->dwPID != 0) && (pSelf->isKillShell))
			{ // надо убить оболочку
				// получаем хэндл процесса
				HANDLE hShellProc = OpenProcess(PROCESS_TERMINATE, false, pSelf->dwPID);
				if (hShellProc != NULL)
				{ // прибиваем оболочку
					if ( TerminateProcess(hShellProc, 1) )
						TestCompleteLog(_T("Message"), _T("Оболочку успешно прибили"), pSelf->isAllowLog)
					else
						TestCompleteLog(_T("Warning"), _T("Не удалось прибить оболочку"), pSelf->isAllowLog)
					CloseHandle(hShellProc);								
				} // if
			} // if
			TestCompleteLog(_T("Error"), _T("Обнаружено зависание оболочки!"), pSelf->isAllowLog);
		} // if
	} // while
}

DWORD WINAPI CQCShellWatchdog::CheckerThread(LPVOID lpParam)
{
	CQCShellWatchdog* pSelf = static_cast<CQCShellWatchdog*>(lpParam);
	//
	HWND shellWnd;
	pSelf->dwPID = GetProcessIDByName(SHELL_PROCESS_NAME);
	// сначала ищем главное окно оболочки
	shellWnd = FindWindowFromProcess(SHELL_PROCESS_NAME, _T("TnsMainWindow"));
	// если не нашли, то ищем форму логина
	if (shellWnd == NULL)
		shellWnd = FindWindowFromProcess(SHELL_PROCESS_NAME, _T("TnsLoginForm"));
	// если что-то нашли, то посылаем сообщение окну
	// смысл в том, что если приложение висит, то SendMessage не вернет управление
	if (shellWnd != NULL)
		SendMessage(shellWnd, WM_USER+1, 0, 0);
	//
	return 0;
}