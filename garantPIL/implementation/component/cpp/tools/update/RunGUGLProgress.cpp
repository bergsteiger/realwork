// RunGUGLProgress.cpp : implementation file
//

#include "stdafx.h"
#include "resource.h"
#include "RunGUGLProgress.h"
#include "Update.h"

#include <ace/Thread_Manager.h>
#include <stdexcept>

#if defined (_GCD_CLIENT) || defined (PILOT)
#include "shared/GSI/impl/NotifyService_i/Consumer_i.h"

#include "garantServer/src/Business/GblPilot/Home/Client.h"
#include "garantServer/src/Global/Defines/DefinesC.h"
#include "garantServer/src/Services/GslDataPipe/Server/PipeManager_i.h"
#include "garantServer/src/Services/GslDataPipe/Server/PipeManager_i.h"
#include "ace/Thread_Manager.h"
GslDataPipe::FileReadingSet_var	gugl_fileset;
#endif

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

#include "stdbase.h"
#include "basemask.h"
#include "advlog.h"

extern	char	GUDllFileName[ 12 ];
extern	CUpdateApp	theApp;

#ifndef	RUNGLDLL
extern int garlink(Base *b_, ProgressScreen *screen, int baseType, int bCheckInfo, int bBreeder, int bWWW, int bG6, FILE *el);
#endif

int	iMakeAllDocsParaMax;
long iMakeAllDocsSizeMax;
int iMakeAllDocs;
AdvLogger gllog;

/////////////////////////////////////////////////////////////////////////////
// RunGUGL

bool	local_remote;

#ifdef	_GCD_CLIENT
class WrapperForRemoteNotification {
private:
	class ProgressIndicator_i : public POA_GCD::ProgressIndicator {
	public:
		ProgressIndicator_i (WrapperForRemoteNotification* rn) : m_wrapper (rn) {
		}
	protected:
		//interface impl
		CORBA::Short max_progress_count () {
			return 100;
		}
		void set_current (CORBA::Long cur_count, CORBA::Long arg) {
			m_wrapper->m_progress_screen->SetProgress (cur_count);
		}
	private:
		WrapperForRemoteNotification* m_wrapper;
	};
	
	class NotifyConsumer_i : public GSI::NotifyService_i::Consumer_i {
	public:
		NotifyConsumer_i (WrapperForRemoteNotification* rn) : m_wrapper (rn) {
			this->start_listen_common ();
		}
		~NotifyConsumer_i () {
			this->stop_listen_common ();
		}
	protected:
		//interface impl
		void fire_event (const CORBA::Any& data) {
			ACE_GUARD (ACE_Thread_Mutex, guard, m_mutex);

			GblPilotDef::UserNotify* note = NULL;
			CORBA::Any copy_event (data);
			if((copy_event >>= note)) {
				if (note->m_type == GblPilotDef::unt_BaseUpdateInitProgressScreen) {
					m_wrapper->m_progress_screen->InitScreen (note->m_message);
				} else if (note->m_type == GblPilotDef::unt_BaseUpdateShowProgressMessage) {
					m_wrapper->m_progress_screen->SetMessage (note->m_message);
				} else if (note->m_type == GblPilotDef::unt_BaseUpdateShowSubProgressMessage) {
					m_wrapper->m_progress_screen->SetSubMessage (note->m_message);
				} else if (note->m_type == GblPilotDef::unt_BaseUpdateCloseProgressScreen) {
					m_wrapper->m_progress_screen->CloseScreen ();
				}
			}
		}
	private:
		WrapperForRemoteNotification* m_wrapper;
		ACE_Thread_Mutex m_mutex;
	};

	friend class ProgressIndicator_i;
	friend class NotifyConsumer_i;

public:
	WrapperForRemoteNotification (ProgressScreen* ps)
		: m_progress_screen (ps)
		, m_notify_consumer (new NotifyConsumer_i (this))
		, m_progress_indicator (NULL)
	{
		m_progress_indicator = new ProgressIndicator_i (this);
		m_progress_indicator_var = m_progress_indicator->_this ();
	}

	~WrapperForRemoteNotification () {
		m_notify_consumer = 0;
	}

	const GCD::ProgressIndicator_ptr get_progress_indicator () const {
		return m_progress_indicator_var.in ();
	}

private:
	ProgressScreen* m_progress_screen;
	Core::Var<NotifyConsumer_i> m_notify_consumer;
	ProgressIndicator_i* m_progress_indicator;
	GCD::ProgressIndicator_var m_progress_indicator_var;

};
#endif

namespace {

ACE_THR_FUNC_RETURN run_gl_thread (void* gl_run_param) {
	int ret = 1;
	RunGUGLProgress* m_pDlg = (RunGUGLProgress*)gl_run_param;
	ACE_SHLIB_HANDLE aGLDll = ACE_OS::dlopen ("GL.dll");
	if (aGLDll) {
		DoGL_lFunction aDoGL = (DoGL_lFunction) ACE_OS::dlsym (aGLDll, "DoGL_language");
		if ( aDoGL ) {
			try {
				aDoGL( m_pDlg->Param1.GetBuffer( 0 ), m_pDlg->Param2.GetBuffer( 0 ), m_pDlg->updateScreen, theApp.b_english_face );
			}
			catch (...) {
				; // ret = 0; // original code did not check it
			}
		} else {
			ret = 0;
		}
		ACE_OS::dlclose (aGLDll);
	} else {
		ret = 0;
	}
	return ACE_THR_FUNC_RETURN(ret);
}

int run_gl_starter (void* gl_run_param) {
	unsigned long working_thread = 0;
	int thread_id =
		ACE_Thread_Manager::instance ()->spawn (
			run_gl_thread
			, gl_run_param
			, THR_NEW_LWP | THR_JOINABLE
			, &working_thread
			, 0
			, ACE_DEFAULT_THREAD_PRIORITY
			, -1
			, 0
			, 128*1024*1024 // stack size
		);
	if (thread_id < 0) {
		throw std::logic_error("can not create thread for GL");
	}
	return ACE_Thread_Manager::instance ()->join (working_thread);
}

const char* current_gu_file_name = 0;

ACE_THR_FUNC_RETURN run_gu_thread (void* gu_run_param) {
	int ret = 1;
	RunGUGLProgress* m_pDlg = (RunGUGLProgress*)gu_run_param;
	ACE_SHLIB_HANDLE aGUDll = ACE_OS::dlopen (current_gu_file_name);
	if (aGUDll) {
		DoGUFunction aDoGU = (DoGUFunction) ACE_OS::dlsym (aGUDll, "DoGU");
		if ( aDoGU ) {
			try {
				aDoGU( m_pDlg->Param1.GetBuffer( 0 ), m_pDlg->updateScreen );
			}
			catch (...) {
				; // ret = 0; // original code did not check it
			}
		} else {
			ret = 0;
		}
		ACE_OS::dlclose (aGUDll);
	} else {
		ret = 0;
	}
	return ACE_THR_FUNC_RETURN(ret);
}

int run_gu_starter (void* gu_run_param, const char* gu_file_name) {
	current_gu_file_name = gu_file_name;
	unsigned long working_thread = 0;
	int thread_id =
		ACE_Thread_Manager::instance ()->spawn (
			run_gu_thread
			, gu_run_param
			, THR_NEW_LWP | THR_JOINABLE
			, &working_thread
			, 0
			, ACE_DEFAULT_THREAD_PRIORITY
			, -1
			, 0
			, 64*1024*1024 // stack size
		);
	if (thread_id < 0) {
		throw std::logic_error("can not create thread for GU");
	}
	return ACE_Thread_Manager::instance ()->join (working_thread);
}

} // namespace local

void WINAPI	RunGUGL( RunGUGLProgress* m_pDlg )
{
	if ( local_remote ) {
#ifdef	_GCD_CLIENT
		WrapperForRemoteNotification rn(m_pDlg->updateScreen);
		try {
			if ( m_pDlg->GU ) 
				UpdateRunner::bu->add_delta_files(gugl_fileset.in (), rn.get_progress_indicator ());
			else
				UpdateRunner::bu->remote_delta_complete(rn.get_progress_indicator ());
		}
		catch (GCD::CanNotFindData){
			FatalError( IDS_CANNOTFINDDATA );
		}
		catch (GblPilot::UpdateFailed){
			FatalError( IDS_UPDATEFAILED );
		}
		PostMessage( m_pDlg->m_hWnd, WM_COMMAND, IDC_FILE, 0 );
#endif
	} else {
		if ( m_pDlg->GU ) {
			run_gu_starter(m_pDlg, GUDllFileName);
			PostMessage( m_pDlg->m_hWnd, WM_COMMAND, IDC_FILE, 0 );
		} else {
	#ifdef	RUNGLDLL
			run_gl_starter(m_pDlg);
	#else
			FILE *log_file = fopen( m_pDlg->Param2, "w" );
			Base* aBase = new StdBigBase( m_pDlg->Param1.GetBuffer( 0 ), O_RDWR );
	#ifdef	_GCD_CLIENT
			garlink( aBase, m_pDlg->updateScreen, 0,0,1,0,1,log_file );
	#else
			garlink( aBase, m_pDlg->updateScreen, 0,0,1,0,0,log_file );
	#endif
			fprintf( log_file, "0\n" );
			fclose( log_file );
			aBase -> SetReady( TID_GL );
			delete aBase;
	#endif
			PostMessage( m_pDlg->m_hWnd, WM_COMMAND, IDC_FILE, 0 );
		}
	}
}

/////////////////////////////////////////////////////////////////////////////
// RunGUGLProgress dialog

BEGIN_MESSAGE_MAP(RunGUGLProgress, CDialog)
	//{{AFX_MSG_MAP(RunGUGLProgress)
	ON_WM_TIMER()
	ON_WM_DESTROY()
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

RunGUGLProgress::RunGUGLProgress(bool aRemote, BOOL aGU, char* aParam1, char* aParam2, CWnd* pParent )
	: CDialog(RunGUGLProgress::IDD, pParent)
{
	remote = aRemote;
	GU = aGU;
	Param1 = aParam1;
	Param2 = aParam2;

	updateScreen = new UpdateScreen( GU ? cd_win : ( remote ? cd_win : cd_koi ), cd_win );
	updateScreen->m_pDlg = this;

	//{{AFX_DATA_INIT(RunGUGLProgress)
		// NOTE: the ClassWizard will add member initialization here
	//}}AFX_DATA_INIT
}

void RunGUGLProgress::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(RunGUGLProgress)
	DDX_Control(pDX, IDC_MESSAGE2, m_pMessage2);
	DDX_Control(pDX, IDC_MESSAGE, m_pMessage);
	DDX_Control(pDX, IDC_PROGRESS, m_pProgress);
	//}}AFX_DATA_MAP
}

BOOL RunGUGLProgress::OnInitDialog() 
{
	CDialog::OnInitDialog();

	HICON m_hIcon = AfxGetApp()->LoadIcon(IDR_MAINFRAME);
	SetIcon(m_hIcon, TRUE);
	SetIcon(m_hIcon, FALSE);

	local_remote = remote;
	DWORD	threadID;
	hThread = CreateThread( NULL, 0, (LPTHREAD_START_ROUTINE) RunGUGL, (LPVOID)this, CREATE_SUSPENDED, &threadID );
	if ( hThread ) {
		SetThreadPriority( hThread, THREAD_PRIORITY_NORMAL );
		ResumeThread( hThread );
	}
	
/*
	m_animIcon.SetImageList( IDB_PROGRESS, 4, RGB( 255,0,0 ));
	m_timerID = this -> SetTimer( 99, 250, NULL );
*/

	return TRUE;
}

BOOL RunGUGLProgress::OnCommand(WPARAM wParam, LPARAM lParam) 
{
	if ( wParam == IDC_FILE ) {
		CloseHandle( hThread );
		EndDialog( IDOK );
	}
	
	return CDialog::OnCommand(wParam, lParam);
}

void RunGUGLProgress::OnTimer(UINT nIDEvent) 
{
/*
	m_animIcon.ShowNextImage();
*/
	CDialog::OnTimer(nIDEvent);
}

void RunGUGLProgress::OnDestroy() 
{
	CDialog::OnDestroy();
/*
	if( m_timerID != 0 ) KillTimer( m_timerID );
*/
}

BOOL RunGUGLProgress::OnCmdMsg(UINT nID, int nCode, void* pExtra, AFX_CMDHANDLERINFO* pHandlerInfo) 
{
	if ( nID == IDCANCEL || nID == IDOK )
		return FALSE;
	else
		return CDialog::OnCmdMsg(nID, nCode, pExtra, pHandlerInfo);
}

BOOL RunGUGLProgress::Create()
{
	return CDialog::Create(RunGUGLProgress::IDD);
}

/////////////////////////////////////////////////////////////////////////////
// UpdateScreen

void	UpdateScreen :: RealInitScreen( const char* aTitle )
{
	if ( !m_pDlg )
		return;
	m_pDlg -> SetWindowText( aTitle );
	m_pDlg -> ShowWindow( SW_SHOW );
}

void	UpdateScreen :: CloseScreen()
{
}

void	UpdateScreen :: ShowMessage( const char* aMessage, int sub )
{
	if ( !m_pDlg )
		return;
	if ( sub )
		m_pDlg->m_pMessage2.SetWindowText( aMessage );
	else
		m_pDlg->m_pMessage.SetWindowText( aMessage );
}

void	UpdateScreen :: ShowProgress()
{
	if ( !m_pDlg )
		return;
	m_pDlg->m_pProgress.SetPos( progress );
}

