// QCProcessKiller.h : Declaration of the CQCProcessKiller

#pragma once
#include "resource.h"       // main symbols

#include "QCObjectLib.h"
#include <Windows.h>

#include "commonForObjects.h"


#if defined(_WIN32_WCE) && !defined(_CE_DCOM) && !defined(_CE_ALLOW_SINGLE_THREADED_OBJECTS_IN_MTA)
#error "Single-threaded COM objects are not properly supported on Windows CE platform, such as the Windows Mobile platforms that do not include full DCOM support. Define _CE_ALLOW_SINGLE_THREADED_OBJECTS_IN_MTA to force ATL to support creating single-thread COM object's and allow use of it's single-threaded COM object implementations. The threading model in your rgs file was set to 'Free' as that is the only threading model supported in non DCOM Windows CE platforms."
#endif

// CQCProcessKiller

class ATL_NO_VTABLE CQCProcessKiller :
	public CComObjectRootEx<CComSingleThreadModel>,
	public CComCoClass<CQCProcessKiller, &CLSID_QCProcessKiller>,
	public ISupportErrorInfo,
	public IDispatchImpl<IQCProcessKiller, &IID_IQCProcessKiller, &LIBID_QCObjectLib, /*wMajor =*/ 1, /*wMinor =*/ 0>
{
public:
	CQCProcessKiller()
	{
	}

DECLARE_NOT_AGGREGATABLE(CQCProcessKiller)

BEGIN_COM_MAP(CQCProcessKiller)
	COM_INTERFACE_ENTRY(IQCProcessKiller)
	COM_INTERFACE_ENTRY(IDispatch)
	COM_INTERFACE_ENTRY(ISupportErrorInfo)
END_COM_MAP()

// ISupportsErrorInfo
	STDMETHOD(InterfaceSupportsErrorInfo)(REFIID riid);


	DECLARE_PROTECT_FINAL_CONSTRUCT()

	HRESULT FinalConstruct()
	{
		InitTypeInfo(IID_IQCProcessKiller);
		//
		dwPID = NULL;
		dwDelay = 0;
		// теперь инициализируем эвенты
		hMustStartEvent = CreateEvent(NULL, false, false, NULL);
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
		hKillingThread = CreateThread(NULL, 0, &KillngThread, this, 0, NULL);
		if (hKillingThread == NULL) 
			return Error(_T("Не удается создать поток!"), GUID_NULL, E_HANDLE);

		return S_OK;
	}

	void FinalRelease()
	{
		isAllowLog = false;
		isThreadMustExit = true;
		Start();
		Stop();
		// теперь ждем корректного завершения потока
		const int MAX_RETRIES = 15;
		bool isNeedTerminateThread = true;
		for (int i=0; i < MAX_RETRIES; i++)
		{
			DWORD dwExitCode;
			if ( GetExitCodeThread(hKillingThread, &dwExitCode) && (dwExitCode != STILL_ACTIVE) )
			{
				isNeedTerminateThread = false;
				break;
			}
			else
				Sleep(START_STOP_TIMEOUT/MAX_RETRIES);
		}
		// корректного завершения потока не дождались, поэтому убиваем поток
		if (isNeedTerminateThread) 
			TerminateThread(hKillingThread, 1);
		CloseHandle(hKillingThread);
		// закрываем оставшиеся хендлы		
		CloseHandle(hMustStartEvent);
		CloseHandle(hHasStartedEvent);
		CloseHandle(hMustStopEvent);
		CloseHandle(hHasStoppedEvent);
	}

public:

	STDMETHOD(Start)(void);
	STDMETHOD(Stop)(void);
	STDMETHOD(get_HasKilled)(VARIANT_BOOL* pVal);
	STDMETHOD(get_PID)(ULONG* pVal);
	STDMETHOD(put_PID)(ULONG newVal);
	STDMETHOD(get_Delay)(ULONG* pVal);
	STDMETHOD(put_Delay)(ULONG newVal);
private:
	volatile DWORD dwPID;
	DWORD dwDelay;
	bool hasKilled;
	//
	HANDLE hMustStartEvent;
	HANDLE hHasStartedEvent;
	HANDLE hMustStopEvent;
	HANDLE hHasStoppedEvent;
	HANDLE hKillingThread;
	static const DWORD START_STOP_TIMEOUT = 5000;
	bool isThreadMustExit;
	bool isAllowLog;
	//
	bool IsKillingThreadLive(void);
	//
	static DWORD WINAPI KillngThread(LPVOID lpParam);
};
