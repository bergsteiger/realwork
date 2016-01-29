// QCShellWatchdog.h : Declaration of the CQCShellWatchdog

#pragma once
#include "resource.h"       // main symbols

#include "QCObjectLib.h"

#include "commonForObjects.h"


#if defined(_WIN32_WCE) && !defined(_CE_DCOM) && !defined(_CE_ALLOW_SINGLE_THREADED_OBJECTS_IN_MTA)
#error "Single-threaded COM objects are not properly supported on Windows CE platform, such as the Windows Mobile platforms that do not include full DCOM support. Define _CE_ALLOW_SINGLE_THREADED_OBJECTS_IN_MTA to force ATL to support creating single-thread COM object's and allow use of it's single-threaded COM object implementations. The threading model in your rgs file was set to 'Free' as that is the only threading model supported in non DCOM Windows CE platforms."
#endif



// CQCShellWatchdog

class ATL_NO_VTABLE CQCShellWatchdog :
	public CComObjectRootEx<CComSingleThreadModel>,
	public CComCoClass<CQCShellWatchdog, &CLSID_QCShellWatchdog>,
	public IDispatchImpl<IQCShellWatchdog, &IID_IQCShellWatchdog, &LIBID_QCObjectLib, /*wMajor =*/ 1, /*wMinor =*/ 0>
{
public:
	CQCShellWatchdog()
	{
	}

DECLARE_NOT_AGGREGATABLE(CQCShellWatchdog)

BEGIN_COM_MAP(CQCShellWatchdog)
	COM_INTERFACE_ENTRY(IQCShellWatchdog)
	COM_INTERFACE_ENTRY(IDispatch)
END_COM_MAP()

	DECLARE_PROTECT_FINAL_CONSTRUCT()

	HRESULT FinalConstruct()
	{
		InitTypeInfo(IID_IQCShellWatchdog);

		// теперь инициализируем эвенты
		hMustStartEvent = CreateEvent(NULL, true, false, NULL);
		if (hMustStartEvent == NULL)
			return Error(_T("Не могу создать эвент старта!"), GUID_NULL, E_HANDLE);
		hMustStopEvent = CreateEvent(NULL, false, false, NULL);
		if (hMustStopEvent == NULL)
			return Error(_T("Не могу создать эвент остановки!"), GUID_NULL, E_HANDLE);
		hHasStartedEvent = CreateEvent(NULL, true, false, NULL);
		if (hHasStartedEvent == NULL)
			return Error(_T("Не могу создать эвент-флаг запуска!"), GUID_NULL, E_HANDLE);
		hHasStoppedEvent = CreateEvent(NULL, true, true, NULL);
		if (hHasStoppedEvent == NULL)
			return Error(_T("Не могу создать эвент-флаг останова!"), GUID_NULL, E_HANDLE);
		// флаги
		isThreadMustExit = false;
		isAllowLog = true;
		// создаем поток
		hWatcherThread = CreateThread(NULL, 0, &WatcherThread, this, 0, NULL);
		if (hWatcherThread == NULL) 
			return Error(_T("Не удается создать поток!"), GUID_NULL, E_HANDLE);

		return S_OK;
	}

	void FinalRelease()
	{
		isAllowLog = false;
		isThreadMustExit = true;
		VARIANT_BOOL tmp;
		Start(&tmp);
		Stop();
		// теперь ждем корректного завершения потока
		const int MAX_RETRIES = 15;
		bool isNeedTerminateThread = true;
		for (int i=0; i < MAX_RETRIES; i++)
		{
			DWORD dwExitCode;
			if ( GetExitCodeThread(hWatcherThread, &dwExitCode) && (dwExitCode != STILL_ACTIVE) )
			{
				isNeedTerminateThread = false;
				break;
			}
			else
				Sleep(START_STOP_TIMEOUT/MAX_RETRIES);
		}
		// корректного завершения потока не дождались, поэтому убиваем поток
		if (isNeedTerminateThread) 
			TerminateThread(hWatcherThread, 1);
		CloseHandle(hWatcherThread);
		// закрываем оставшиеся хендлы		
		CloseHandle(hMustStartEvent);
		CloseHandle(hHasStartedEvent);
		CloseHandle(hMustStopEvent);
		CloseHandle(hHasStoppedEvent);
	}

public:

	STDMETHOD(Start)(VARIANT_BOOL* result);
	STDMETHOD(Stop)(void);
	STDMETHOD(get_IsKillShell)(VARIANT_BOOL* pVal);
	STDMETHOD(put_IsKillShell)(VARIANT_BOOL newVal);
	STDMETHOD(get_HangTimeout)(ULONG* pVal);
	STDMETHOD(put_HangTimeout)(ULONG newVal);

private:
	DWORD dwHangTimeout;
	bool isKillShell;
	//
	HANDLE hWatcherThread;
	HANDLE hMustStartEvent;
	HANDLE hHasStartedEvent;
	HANDLE hMustStopEvent;
	HANDLE hHasStoppedEvent;
	bool isThreadMustExit;
	bool isAllowLog;
	static const DWORD START_STOP_TIMEOUT = 5000;
	volatile DWORD dwPID;
	//
	static DWORD WINAPI WatcherThread(LPVOID lpParam);
	static DWORD WINAPI CheckerThread(LPVOID lpParam);
};
