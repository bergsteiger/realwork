//
// DownloaderDlg.cpp : implementation file
//

#include "stdafx.h"

#include "Downloader.h"
#include "InternetFileDownload.h"
#include "DownloaderDlg.h"
#include "LogFile.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CDownloaderDlg dialog

CDownloaderDlg::CDownloaderDlg (CWnd* pParent /*=NULL*/)
	: CDialog (CDownloaderDlg::IDD, pParent) 
{
	//{{AFX_DATA_INIT(CDownloaderDlg)
	m_ctBeginDate = COleDateTime::GetCurrentTime ();
	m_ctEndDate = COleDateTime::GetCurrentTime ();
	//}}AFX_DATA_INIT

	// Note that LoadIcon does not require a subsequent DestroyIcon in Win32
	m_hIcon = AfxGetApp ()->LoadIcon (IDR_MAINFRAME);
}

CDownloaderDlg::~CDownloaderDlg () { 
}

void CDownloaderDlg::DoDataExchange (CDataExchange* pDX) {
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CDownloaderDlg)
	DDX_DateTimeCtrl(pDX, IDC_BEGIN_DATE, m_ctBeginDate);
	DDX_DateTimeCtrl(pDX, IDC_END_DATE, m_ctEndDate);
	DDX_Control(pDX, IDC_COMBO_COMPLECT, m_cbComplect);
	DDX_Control(pDX, IDBACK, m_pBack);
	//}}AFX_DATA_MAP
}

BEGIN_MESSAGE_MAP(CDownloaderDlg, CDialog)
	//{{AFX_MSG_MAP(CDownloaderDlg)
	ON_WM_SYSCOMMAND ()
	ON_WM_PAINT ()
	ON_WM_QUERYDRAGICON ()
	ON_WM_SHOWWINDOW ()
	ON_WM_SETFOCUS ()
	ON_WM_ACTIVATE ()
	ON_BN_CLICKED (IDC_BROWSE, OnSetPath)
	ON_BN_CLICKED (IDBACK, OnBack)
	ON_BN_CLICKED (ID_HELP, OnHelp)
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CDownloaderDlg message handlers

BOOL CDownloaderDlg::OnInitDialog () {
	this->init_dates ();

	CDialog::OnInitDialog ();

	SetIcon (m_hIcon, TRUE);

	m_path = GetAppPtr ()->get_path ();

	SetDlgItemText (IDC_PATH, m_path.c_str ()); // initialization of path

	GetDlgItem (IDOK)->SetFocus ();

	return FALSE;  // return TRUE  unless you set the focus to a control
}

void CDownloaderDlg::OnSysCommand (UINT nID, LPARAM lParam) {
	if ((nID & 0xFFF0) == IDM_ABOUTBOX)	{
		// CAboutDlg dlgAbout; 
		// dlgAbout.DoModal (); // About не нужен
	} else {
		CDialog::OnSysCommand (nID, lParam);
	}
}

// If you add a minimize button to your dialog, you will need the code below
// to draw the icon.  For MFC applications using the document/view model,
// this is automatically done for you by the framework.

void CDownloaderDlg::OnPaint () {
	if (IsIconic ()) {
		CPaintDC dc (this); // device context for painting

		SendMessage (WM_ICONERASEBKGND, (WPARAM) dc.GetSafeHdc (), 0);

		// Center icon in client rectangle
		int cxIcon = GetSystemMetrics (SM_CXICON);
		int cyIcon = GetSystemMetrics (SM_CYICON);

		CRect rect;
		GetClientRect (&rect);

		int x = (rect.Width () - cxIcon + 1) / 2;
		int y = (rect.Height () - cyIcon + 1) / 2;

		// Draw the icon
		dc.DrawIcon (x, y, m_hIcon);
	} else {
		CDialog::OnPaint ();
	}
}

// The system calls this to obtain the cursor to display while the user drags the minimized window.
HCURSOR CDownloaderDlg::OnQueryDragIcon () {
	return (HCURSOR) m_hIcon;
}

////////////////////////////////////////////////////////////////////////////////
void CDownloaderDlg::OnShowWindow (BOOL bShow, UINT nStatus) {   
 	CDialog::OnShowWindow (bShow, nStatus);
}

void CDownloaderDlg::OnSetFocus (CWnd* pOldWnd) {
	CDialog::OnSetFocus (pOldWnd);
}

void CDownloaderDlg::OnActivate (UINT nState, CWnd* pWndOther, BOOL bMinimized) {
	CDialog::OnActivate (nState, pWndOther, bMinimized);
}
////////////////////////////////////////////////////////////////////////////////

void CDownloaderDlg::OnSetPath () {
	CString title;
	title.LoadString (IDS_CHOOSE_DIR);

	if (this->choose_dir (title.GetBuffer ())) {
		SetDlgItemText (IDC_PATH, m_path.c_str ());

		if (m_path [m_path.size () - 1] != '\\') { 
			m_path += '\\';
		}
	}
}

void CDownloaderDlg::OnOK () {
	UpdateWindow ();

	DConfigManager::instance ()->set ("Path", m_path);
	DConfigManager::instance ()->set ("IdComplect", this->get_complect_id ());

	if (this->is_valid ()) {
	 	ShowWindow (SW_HIDE);
		DestroyIcon (m_hIcon);

		DownloadState res = this->download ();

		if (res == ds_Close) {
			CDialog::OnCancel ();
		} else if (res == ds_Repeat || res == ds_NoUpdate || res == ds_Cancel || res == ds_Error) {
			ShowWindow (SW_SHOWNORMAL);
			SetForegroundWindow ();
			
			if (res == ds_NoUpdate) {
				CString str;
				m_cbComplect.GetLBText (m_cbComplect.GetCurSel (), str);

				CString err, title;
				title.Format (IDS_ATTENTION);

				err.Format (
					IDS_ERROR_NO_UPDATE
					, str.GetBuffer ()
					, m_ctBeginDate.Format (_T ("%d-%m-%Y")).GetBuffer ()
					, m_ctEndDate.Format (_T ("%d-%m-%Y")).GetBuffer ()
				);

				MessageBox (err, title, MB_OK | MB_APPLMODAL);

				DLOG->out_t (err);
			} 
		} else {
			GetAppPtr ()->set_state (res);
			m_cbComplect.set_init_flag (false);
			CDialog::OnOK (); 
		}
	} else {
		CString err, title;
		title.Format (IDS_ATTENTION);
		err.Format (IDS_ERROR_INCORRECT_UPDATE_PERIOD);
		MessageBox (err, title, MB_OK | MB_APPLMODAL);
	}
}

void CDownloaderDlg::OnCancel () {
	CString err, title;
	title.LoadString (IDS_ATTENTION);
	err.LoadString (IDS_QUEST_EXIT_FROM_PROGAM);

	if (MessageBox (err.GetBuffer (), title.GetBuffer (), MB_YESNO | MB_ICONQUESTION | MB_APPLMODAL) == IDYES) {
		DConfigManager::instance ()->set ("IdComplect", this->get_complect_id ());
		CDialog::OnCancel ();
	}
}

void CDownloaderDlg::OnBack () {
	EndDialog (IDBACK);
	m_cbComplect.set_init_flag (false);
}

void CDownloaderDlg::UpdateWindow () {
	CDialog::UpdateWindow ();
}

bool CDownloaderDlg::is_valid () {
	COleDateTime current_date = COleDateTime::GetCurrentTime ();

	((CDateTimeCtrl*) GetDlgItem (IDC_BEGIN_DATE))->GetTime (m_ctBeginDate);
	((CDateTimeCtrl*) GetDlgItem (IDC_END_DATE))->GetTime (m_ctEndDate);

	return (m_ctBeginDate < m_ctEndDate && m_ctEndDate <= current_date);
}

bool CDownloaderDlg::choose_dir (const char* title) {
	char buffer [MAX_PATH]; // Variable for holding path information
	memset (buffer, 0, sizeof (buffer));

	CWnd* pWnd = AfxGetApp ()->GetMainWnd ();

	ASSERT (pWnd);
	ASSERT (pWnd->m_hWnd);

	BROWSEINFO bi;    // Browse information

	bi.hwndOwner      = pWnd->m_hWnd;
	bi.pidlRoot       = NULL;
	bi.lpszTitle      = title;
	bi.ulFlags        = BIF_RETURNONLYFSDIRS | 0x0040;	// A little hack to get 'New Folder' button under W2K
	bi.lpfn           = NULL;
	bi.lParam         = 0;
	bi.pszDisplayName = buffer;

	CWaitCursor wait_cursor;
	LPITEMIDLIST pidlBrowse;

	bool is_init_directory = false;

    while (!is_init_directory)	{
		// Get Browsy. Returns PIDL selected by user.
		pidlBrowse = SHBrowseForFolder (&bi);

		if (pidlBrowse) {
			SHGetPathFromIDList (pidlBrowse, buffer);
			is_init_directory = true;
		} else { 
			break;
		}
	}

	if (is_init_directory) {
		// Free the PIDL returned by SHBrowseForFolder. 
		LPMALLOC pMalloc;
		
		if (SUCCEEDED (SHGetMalloc (&pMalloc))) {
			pMalloc->Free (pidlBrowse);
		}
		if (strlen (buffer)) {
			m_path = buffer;
		}
	}

	return is_init_directory;
}

void CDownloaderDlg::init_dates () {
	const std::string& date_from = GetAppPtr ()->get_date_from ();

	if (date_from.empty ()) {
		m_ctBeginDate = GetAppPtr ()->get_revision ();
	} else {
		m_ctBeginDate.ParseDateTime (date_from.c_str (), VAR_DATEVALUEONLY);
	}

	const std::string& date_to = GetAppPtr ()->get_date_to ();

	if (date_to.empty ()) {
		time_t tt = ACE_OS::time ();
		tm* local_time = ACE_OS::localtime (&tt);
		m_ctEndDate.SetDate (local_time->tm_year, local_time->tm_mon, local_time->tm_mday);
	} else {
		m_ctEndDate.ParseDateTime (date_to.c_str (), VAR_DATEVALUEONLY);
	}
}

DownloadState CDownloaderDlg::download () {
	if (GetAppPtr ()->server_connect ()) { // to make reconnection and to start downloading
		try {
			DownloadManager obj (m_path);
			return obj.execute (
				this->get_complect_id ()
				, m_ctBeginDate.Format (_T ("%m-%d-%Y")).GetBuffer ()
				, m_ctEndDate.Format (_T ("%m-%d-%Y")).GetBuffer ()
			);
		} catch (...) {
			DLOG->out_t ("%s: unknown exception", GDS_CURRENT_FUNCTION);
		}
	}

	return ds_Error;
}

unsigned CDownloaderDlg::get_complect_id () {
	const Complects& complects = GetAppPtr ()->get_complects ();
	return complects [m_cbComplect.GetCurSel ()].id;
}

void CDownloaderDlg::OnHelp () {
#ifdef _GCD_CLIENT
	GetAppPtr ()->show_help ("page-downloader_order_config.htm");
#else
	CDialog::OnHelp ();
#endif
}

// end of...
