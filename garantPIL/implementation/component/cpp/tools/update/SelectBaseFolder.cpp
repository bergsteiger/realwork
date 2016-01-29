// SelectBaseFolder.cpp : implementation file
//

#include "stdafx.h"

#if defined (_GCD_CLIENT) || defined (PILOT)
#include "garantServer/src/Business/GblPilot/Home/Client.h"
#include "garantServer/src/Global/Defines/DefinesC.h"
#endif

#include "Update.h"
#include "Utils.h"
#include "SelectBaseFolder.h"
#include "WaitServerDialog.h"
#include "WaitServer2Dialog.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

extern	char	BasePath[ MAX_PATH ];
extern	char	DataPath[ MAX_PATH ];
extern	bool	space_checked;
extern	__int64	space_for_update();
extern	__int64	base_size();
extern	void	Log(char*);
extern	void	TimeLog( UINT );
extern	BOOL	SilentMode;
extern	bool	update_copy;

extern	CUpdateApp	theApp;

/////////////////////////////////////////////////////////////////////////////
// CSelectBaseFolder dialog


CSelectBaseFolder::CSelectBaseFolder(CWnd* pParent /*=NULL*/)
	: CDialog(CSelectBaseFolder::IDD, pParent)
{
	//{{AFX_DATA_INIT(CSelectBaseFolder)
	//}}AFX_DATA_INIT
}


void CSelectBaseFolder::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CSelectBaseFolder)
	//}}AFX_DATA_MAP
}


BEGIN_MESSAGE_MAP(CSelectBaseFolder, CDialog)
	//{{AFX_MSG_MAP(CSelectBaseFolder)
	ON_BN_CLICKED(ID_HELP, OnHelp)
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CSelectBaseFolder message handlers

BOOL CSelectBaseFolder::OnInitDialog() 
{
	CDialog::OnInitDialog();
	
	HICON m_hIcon = AfxGetApp()->LoadIcon(IDR_MAINFRAME);
	SetIcon(m_hIcon, TRUE);
	SetIcon(m_hIcon, FALSE);

#ifdef	_GCD_CLIENT
	CheckRadioButton (IDC_RADIO1, IDC_RADIO2, IDC_RADIO1);
#endif

	return TRUE;
}

void CSelectBaseFolder::OnCancel() 
{
	if ( YesNoBox( IDS_SUREEXIT, this )) {
		CDialog::OnCancel();
		EndDialog( IDCANCEL );
	}
}

#define	DELETEWAITDIALOG	waitDialog->DestroyWindow(); delete waitDialog; EndWaitCursor();

#if defined (_GCD_CLIENT) || defined (PILOT)
unsigned long __stdcall start_copy ( LPVOID pParam ) {
	DWORD* param = static_cast<DWORD*>(pParam);
	*param = 0;
	try {
		strcpy( BasePath, UpdateRunner::bu->update_start (true) );
	} catch (GCD::NotEnoughRoom&) {
		*param = 1;
	} catch (GCD::CopyProcessFailed&) {
		*param = 2;
	} catch(...) {
		*param = 3;
	}
	return 0;
}

unsigned long __stdcall start_copy_sync ( LPVOID pParam ) {
	DWORD* param = static_cast<DWORD*>(pParam);
	*param = 0;
	try {
		strcpy( BasePath, UpdateRunner::bu->sync_update_start() );
	} catch (GCD::NotEnoughRoom&) {
		*param = 1;
	} catch (GCD::CopyProcessFailed&) {
		*param = 2;
	} catch(...) {
		*param = 3;
	}
	return 0;
}

unsigned long __stdcall start_checkout ( LPVOID pParam ) {
	DWORD* param = static_cast<DWORD*>(pParam);
	*param = 0;
	try {
		//UpdateRunner::bu->base_checkout( BasePath); //ses: old string
		//UpdateRunner::bu->update_comlete (BasePath);
		assert (0);
	} catch (GCD::NotEnoughRoom&) {
		*param = 1;
	} catch (GCD::CopyProcessFailed&) {
		*param = 2;
	} catch(...) {
		*param = 3;
	}
	return 0;
}

bool start_copy_thread (LPTHREAD_START_ROUTINE func, LPVOID pParam) {
	DWORD dwThreadId; 
	HANDLE hThread; 
	hThread = CreateThread(NULL,0, func, pParam,0, &dwThreadId);  

	// The message loop lasts until we get a WM_QUIT message,
	// upon which we shall return from the function.
	while (TRUE)
	{
		// block-local variable 
		DWORD result ; 
		MSG msg ; 

		// Read all of the messages in this next loop, 
		// removing each message as we read it.
		while (PeekMessage(&msg, NULL, 0, 0, PM_REMOVE)) 
		{ 
			// If it's a quit message, we're out of here.
			if (msg.message == WM_QUIT)  {
				::CloseHandle ( hThread );
				return true;
			}
			// Otherwise, dispatch the message.
			DispatchMessage(&msg); 
		} // End of PeekMessage while loop.

		// Wait for any message sent or posted to this queue 
		// or for one of the passed handles be set to signaled.
		result = MsgWaitForMultipleObjects(1, &hThread, 
				 FALSE, INFINITE, QS_ALLINPUT); 

		// The result tells us the type of event we have.
		if (result == (WAIT_OBJECT_0 + 1))
		{
			// New messages have arrived. 
			// Continue to the top of the always while loop to 
			// dispatch them and resume waiting.
			continue;
		} 
		else {
			::CloseHandle ( hThread );
			return true;
		}
	} // End of the always while loop. 
}
#endif

void CSelectBaseFolder::OnOK() 
{
	BeginWaitCursor();

	unsigned int err_code = 0;
	if ( IsDlgButtonChecked( IDC_RADIO1 )) {
#if defined (_GCD_CLIENT) || defined (PILOT)
		//проверить, хватит ли места для копирования базы
		space_checked = true;
		Log( "\nПроверка свободного места, требуемого для обновления:\n" );
		char aLogString[128];
		__int64 space_for_async = 0;
		try {
			space_for_async = (__int64)UpdateRunner::bu->get_free_space_for_async() / 1024;
		}
		catch (GCD::CanNotFindData) {
			Log( "Не удается получить размер требуемого для обновления места. Возможно, нет прав на запись.\n" );
			FatalError( IDS_CANTWRITE, "", IDS_ERROR, this );
		}
		catch (...) {
			Log( "Не удается получить размер требуемого для обновления места. Возможно, нет прав на запись.\n" );
			FatalError( IDS_CANTWRITE, "", IDS_ERROR, this );
		}
		if ( !base_size()) {
			Log( "Не удается получить размер требуемого для обновления места. Возможно, нет прав на запись.\n" );
			FatalError( IDS_CANTWRITE, "", IDS_ERROR, this );
		}
		sprintf( aLogString, "  есть: %I64d МБайт\n", space_for_async );
		Log( aLogString );
		sprintf( aLogString, "  надо: %I64d МБайт + %I64d МБайт, итого: %I64d МБайт\n", (__int64)space_for_update() / 1024, (__int64)base_size() / 1024, ((__int64)space_for_update() + (__int64)base_size())/1024 );
		Log( aLogString );
		if ( space_for_async < ( space_for_update() + base_size()) / 1024 ) {
			Log( "Возможно, места недостаточно!\n");
			if ( !SilentMode && !YesNoBox( IDS_FREESPACE, this ))
				FatalError( IDS_BASELOCKED );
		}
#endif
		updateType = 0;
		TimeLog (IDS_STARTBACKUPLOG);
		CWaitServerDialog* waitDialog = new CWaitServerDialog();
		waitDialog->Create();
		waitDialog->SetWindowPos ( &CWnd::wndTop, 0,0,0,0, SWP_NOSIZE|SWP_NOMOVE );
		EnableWindow(false);
#if defined (_GCD_CLIENT) || defined (PILOT)
		try {
			if ( start_copy_thread (start_copy, &err_code) ) {
				update_copy = true;
				DELETEWAITDIALOG
				EndDialog(IDOK);
			}
			switch (err_code) {
			case 1: throw GCD::NotEnoughRoom ();
			case 2:
			case 3: throw GCD::CopyProcessFailed ();
			}
		}
		catch(GCD::NotEnoughRoom&) {
			ShowWindow(SW_SHOW);
			FatalMessage( IDS_NOTENOUGHROOM);
			ShowWindow(SW_SHOW);
			throw;
		}
		catch(GCD::CopyProcessFailed&) {
			ShowWindow(SW_SHOW);
			FatalMessage( IDS_SERVERCOPYFAILED );
			ShowWindow(SW_SHOW);
			throw;
		}
		catch(...) {
			ShowWindow(SW_SHOW);
			FatalMessage( IDS_SERVERCOPYFAILED );
			ShowWindow(SW_SHOW);
			throw GCD::CopyProcessFailed ();
		}
		TimeLog (IDS_ENDBACKUPLOG);
		EnableWindow();
	} else {
		if ( !base_size()) {
			Log( "Не удается получить размер информационного банка. Возможно, нет прав на запись.\n" );
			FatalError( IDS_CANTWRITE2, "", IDS_ERROR, this );
		}

		space_checked = true;
		Log( "\nПроверка свободного места, требуемого для обновления:\n" );
		char aLogString[128];
		sprintf( aLogString, "  есть: %I64d МБайт\n", (__int64)UpdateRunner::bu->get_free_space_for_sync() / 1024 );
		Log( aLogString );
		sprintf( aLogString, "  надо: %I64d МБайт\n", (__int64)space_for_update() / 1024 );
		Log( aLogString );

		if ( UpdateRunner::bu->get_free_space_for_sync() < space_for_update() ) {
			if ( !SilentMode && !YesNoBox( IDS_SMALLFREESPACE, this ))
				FatalError( IDS_BASELOCKED );
		}

		TimeLog (IDS_BACKUPREFUSAL);
		updateType = 1;
		CWaitServer2Dialog* waitDialog = new CWaitServer2Dialog();
		waitDialog->Create();
		waitDialog->SetWindowPos ( &CWnd::wndTop, 0,0,0,0, SWP_NOSIZE|SWP_NOMOVE );
		EnableWindow(false);
		try {
			if ( start_copy_thread (start_copy_sync, &err_code) ) {
				DELETEWAITDIALOG
				EndDialog(IDOK);
			}
			switch (err_code) {
			case 1: throw GCD::NotEnoughRoom ();
			case 2:
			case 3: throw GCD::CopyProcessFailed ();
			}
		}
		catch(GCD::NotEnoughRoom&) {
			ShowWindow(SW_SHOW);
			FatalMessage( IDS_NOTENOUGHROOM );
			ShowWindow(SW_SHOW);
			throw;
		}
		catch(GCD::CopyProcessFailed&) {
			ShowWindow(SW_SHOW);
			FatalMessage( IDS_SERVERCOPY2FAILED );
			ShowWindow(SW_SHOW);
			throw;
		}
		catch(...) {
			ShowWindow(SW_SHOW);
			FatalMessage( IDS_SERVERCOPY2FAILED );
			ShowWindow(SW_SHOW);
			throw GCD::CopyProcessFailed ();
		}
		EnableWindow();
#endif
	}
}

void CSelectBaseFolder::OnHelp()
{
#ifdef	_GCD_CLIENT
	theApp.Help( "page-upd_order_backup.htm" );
#else
	CDialog::OnHelp();
#endif
}
