//
// StatusProcessDlg.cpp : implementation file
//

#include "stdafx.h"

#include "LogFile.h"
#include "Downloader.h"
#include "StatusProcessDlg.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CStatusProcessDlg dialog

CStatusProcessDlg::CStatusProcessDlg (CWnd* pParent)
	: CDialog (CStatusProcessDlg::IDD, pParent) 
	//, m_tid (0)
	//, m_thandle (0)
	, m_has_init (0)
	, m_timer_type (tt_None)
	, m_is_cancel (false) 
	, m_is_connect (false)
{
	//{{AFX_DATA_INIT(CStatusProcessDlg)
	//}}AFX_DATA_INIT
}

CStatusProcessDlg::~CStatusProcessDlg () {
}

void CStatusProcessDlg::DoDataExchange (CDataExchange* pDX) {
	CDialog::DoDataExchange(pDX);

	//{{AFX_DATA_MAP(CStatusProcessDlg)
	DDX_Control (pDX, IDC_STATUS_STATIC, m_sStatusText);
	DDX_Control (pDX, IDC_STATIC_COMMENT, m_sComment);
	DDX_Control (pDX, IDC_PROGRESS_STATUS, m_pProgress);
	DDX_Control (pDX, IDC_IMAGE_PROGRESS, m_sImageProgress);
	DDX_Control (pDX, IDCANCEL, m_bCancel);
	//}}AFX_DATA_MAP
}

BEGIN_MESSAGE_MAP(CStatusProcessDlg, CDialog)
	//{{AFX_MSG_MAP(CStatusProcessDlg)
	ON_WM_SHOWWINDOW ()
	ON_WM_TIMER ()
	ON_WM_KEYDOWN ()
	//}}AFX_MSG_MAP
END_MESSAGE_MAP ()

/////////////////////////////////////////////////////////////////////////////
// CStatusProcessDlg message handlers

BOOL CStatusProcessDlg::OnInitDialog () {
	CDialog::OnInitDialog ();
	{
		HICON handle = GetAppPtr ()->LoadIcon (IDR_MAINFRAME);

		if (handle) {
			SetIcon (handle, TRUE);
		}
	}

	m_sComment.SetWindowText ("");
	m_sStatusText.SetWindowText ("");
	m_pProgress.ShowWindow (SW_HIDE);
	m_bCancel.EnableWindow (TRUE);
	m_bCancel.SetFocus ();

	m_animate_icon.SetImageList (IDB_PROGRESS, 4, RGB (255,0,0));

	SetForegroundWindow ();

	m_has_init = 1;

	return FALSE;  // return TRUE  unless you set the focus to a control
}

void CStatusProcessDlg::OnTimer (UINT nIDEvent) {
	if (m_timer_type == tt_Animate) {
		HICON handle = m_sImageProgress.SetIcon (m_animate_icon.GetNextImage ());

		if (handle) {
			::DestroyIcon (handle);
		}
	}

	CDialog::OnTimer (nIDEvent);
}

void CStatusProcessDlg::OnCancel () {
	//ACE_Thread_Manager* manager = ACE_Thread_Manager::instance ();
	//manager->suspend (m_tid);
	::SuspendThread (m_handle);

	CString msg;
	msg.Format (IDS_DOWNLOAD_CANCEL, m_file_name.c_str ());

	CString title;
	title.LoadString (IDS_ATTENTION);

	m_is_cancel = MessageBox (msg, title, MB_YESNO | MB_ICONQUESTION | MB_APPLMODAL) == IDYES;

	if (m_is_connect) {
		if (m_is_cancel) {
			this->terminate ();
			return;
		} 
	} else if (m_is_cancel) {
		m_pProgress.ShowWindow (SW_HIDE);
	} else {
		ACE_OS::sleep (ACE_Time_Value (0, 100000)); // 0.1 секунды
	}

	//manager->resume (m_tid);
	::ResumeThread (m_handle);
}

void CStatusProcessDlg::OnShowWindow (BOOL bShow, UINT nStatus) {   
	CDialog::OnShowWindow (bShow, nStatus);
}

void CStatusProcessDlg::OnKeyDown (UINT nChar, UINT nRepCnt, UINT nFlags) {
	switch (nChar) {
	    case VK_DELETE:	     
		case VK_DOWN:        
		case VK_UP:	         
		case VK_SPACE:       
			break;
	}
}

/////////////////////////////////////////////////////////////////////////////

/*
void CStatusProcessDlg::execute (ACE_THR_FUNC func, void* obj, bool is_connect) {
	m_is_connect = is_connect;

	ACE_Thread_Manager* manager = ACE_Thread_Manager::instance ();

	if (manager->spawn (func, obj, THR_NEW_LWP | THR_JOINABLE, &m_tid, &m_thandle) < 0) {
		LOGD->out_t ("%s: can't create thread", GDS_CURRENT_FUNCTION);
		throw std::exception ();
	}

	manager->join (m_tid);
}
*/

void CStatusProcessDlg::execute (LPTHREAD_START_ROUTINE func, void* obj, bool is_connect) {
	m_is_connect = is_connect;

	DWORD thr_id = 0;
	m_handle = 0;

	try {
		m_handle = ::CreateThread (NULL, 0, func, obj, CREATE_SUSPENDED, &thr_id);
	} catch (...) {
	}


	if (m_handle) {
		::ResumeThread (m_handle);

		DWORD status;

		VERIFY(::GetExitCodeThread (m_handle, &status));

		if (status == STILL_ACTIVE) {
			if (::WaitForSingleObject (m_handle, INFINITE) == WAIT_OBJECT_0) {
				VERIFY(::GetExitCodeThread (m_handle, &status));
			}
		} 

		if (status != STILL_ACTIVE) { // Completely remove the thread object
			::CloseHandle (m_handle);
		}
	} else {
		DLOG->out_t ("%s: can't create thread", GDS_CURRENT_FUNCTION);
		throw std::exception ();
	}
}

void CStatusProcessDlg::terminate () {
	/*
	ACE_Thread_Manager* manager = ACE_Thread_Manager::instance ();
	*/

	if (::TerminateThread (m_handle, (DWORD) -1)) {}
}

void CStatusProcessDlg::wait () {
	while (m_has_init == 0) {
		ACE_OS::sleep (0);
	}
}

void CStatusProcessDlg::set_status_text (LPCTSTR text) {
	m_sStatusText.SetWindowText (text);
}

void CStatusProcessDlg::set_comment_text (LPCTSTR text) {
	m_sComment.SetWindowText (text);
}

void CStatusProcessDlg::set_position (int pos) {
	m_pProgress.SetPos (pos);

	if (pos >= m_upper) {
		m_pProgress.ShowWindow (SW_HIDE);
	}
}

void CStatusProcessDlg::animate (bool is_begin) { 
	if (is_begin) {
		CString str;
		str.Format (IDS_QUERY_TO_SERVER);
		m_sStatusText.SetWindowText (str.GetBuffer ());

		m_sImageProgress.ShowWindow (SW_SHOW);
		m_timer_id = SetTimer (99, 200, NULL);
		m_timer_type = tt_Animate;
	} else {
		m_sImageProgress.ShowWindow (SW_HIDE);

		if (m_timer_id) {
			KillTimer (m_timer_id); 
		}

		m_timer_id = 0;
		m_timer_type = tt_None;
	}
}

void CStatusProcessDlg::init (UINT format_id, const std::string& file_name, double file_length, int range_val) {
	CString str_info;

	str_info.Format (format_id, file_name.c_str (), file_length);
	m_sStatusText.SetWindowText (str_info.GetBuffer ());

	str_info.Format (IDS_DOWNLOAD_DATA_PROCESS);
	m_sComment.SetWindowText (str_info.GetBuffer ());

	m_file_name = file_name;
	m_is_cancel = false;
	m_upper = range_val;

	m_bCancel.SetFocus ();
	m_pProgress.SetRange32 (0, m_upper);
	m_pProgress.ShowWindow (SW_SHOW);
}

int CStatusProcessDlg::message_box (const char* text, UINT type) {
	CString caption;
	caption.LoadString (IDS_ATTENTION);
	return ::MessageBox (m_hWnd, text, caption.GetBuffer (), type);
}

void CStatusProcessDlg::lock (bool val) {
	GetDlgItem (IDCANCEL)->EnableWindow ((val)? FALSE : TRUE);

	if (val) {
		//ACE_Thread_Manager::instance ()->suspend (m_tid);
		::SuspendThread (m_handle);
	} else {
		//ACE_Thread_Manager::instance ()->resume (m_tid);
		::ResumeThread (m_handle);
	}
}

void CStatusProcessDlg::hide () {
	this->ShowWindow (SW_HIDE);
}

// end of...
