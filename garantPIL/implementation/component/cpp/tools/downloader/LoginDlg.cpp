//
// LoginDlg.cpp : implementation file
//

#include "stdafx.h"

#include "LoginDlg.h"
#include "Downloader.h"
#include "InetAccessSettings.h"
#include "ServerConnect.h"
#include "LogFile.h"
#include "Config.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CLoginDlg dialog

CLoginDlg::CLoginDlg (CWnd* pParent /*=NULL*/)
	: CDialog (CLoginDlg::IDD, pParent) {
	//{{AFX_DATA_INIT(CLoginDlg)
	//}}AFX_DATA_INIT
}

CLoginDlg::~CLoginDlg () { }

void CLoginDlg::DoDataExchange (CDataExchange* pDX) {
	CDialog::DoDataExchange (pDX);
	//{{AFX_DATA_MAP(CLoginDlg)
	DDX_Control (pDX, IDC_LOGIN, m_edtLogin);
	DDX_Control (pDX, IDC_PASSWORD, m_edtPassword);
	//}}AFX_DATA_MAP
}

BEGIN_MESSAGE_MAP (CLoginDlg, CDialog)
	//{{AFX_MSG_MAP(CLoginDlg)
    ON_BN_CLICKED (IDC_INET_SETTINGS, OnInetSettings)
	ON_BN_CLICKED(ID_HELP, OnHelp)
	//}}AFX_MSG_MAP
END_MESSAGE_MAP ()

/////////////////////////////////////////////////////////////////////////////
// CLoginDlg message handlers

BOOL CLoginDlg::OnInitDialog () {
	CDialog::OnInitDialog ();

	SetIcon (GetAppPtr ()->LoadIcon (IDR_MAINFRAME), TRUE);

	std::string l_str = DConfigManager::instance ()->get ("Login");
	std::string p_str = DConfigManager::instance ()->get_crypt ("Pswd");

	SetDlgItemText (IDC_LOGIN, l_str.c_str ());
	SetDlgItemText (IDC_PASSWORD, p_str.c_str ());

	if (l_str.empty ()) {
		m_edtLogin.SetFocus ();
	} else if (p_str.empty ()) {
		m_edtPassword.SetFocus ();
	} else { 
		GetDlgItem (IDOK)->SetFocus ();
	}

	return FALSE;
}

void CLoginDlg::OnOK () {
	UpdateWindow ();

	CString login, password;

	GetDlgItemText (IDC_LOGIN, login);
	GetDlgItemText (IDC_PASSWORD, password);

	if (login.IsEmpty () || password.IsEmpty ()) {
		CString err, title;
		title.LoadString (IDS_ATTENTION);
		err.LoadString (IDS_ERROR_NOT_INIT_LOGIN_OR_PASSWORD);
		MessageBox (err.GetBuffer (), title.GetBuffer (), MB_ICONEXCLAMATION | MB_OK);

		if (login.IsEmpty ()) {
			m_edtLogin.SetFocus ();
		} else if (password.IsEmpty ()) {
			m_edtPassword.SetFocus ();
		}
	} else {
		try {
			this->authorization (login.GetBuffer (), password.GetBuffer ());
		} catch (...) {
			DLOG->out_t (" %s: authorization: exception handled", GDS_CURRENT_FUNCTION);
		}
	}
}

void CLoginDlg::authorization (const char* login, const char* password) {
	CWaitCursor wait;

	CStatic* static_item = (CStatic*) GetDlgItem (IDC_STATIC_CHECK_REGISTRATION);
	{
		CString str;
		str.LoadString (IDS_MSG_CHECK_REGISTRATION);

		static_item->ShowWindow (SW_SHOW);
		static_item->SetWindowText (str.GetBuffer ());
	}

	CString err;

	switch (GetAppPtr ()->authorization (login, password, false)) {
		case as_Succesful:
			CDialog::OnOK ();
			break;
		case as_InvalidLogin:
			err.Format (IDS_ERROR_INCORRECT_LOGIN);
			break;
		case as_InvalidData:
			err.Format (IDS_ERROR_USERS_AUTHORIZATION);
			break;
		case as_Error:
			err.Format (IDS_ERROR_HTTP_ERROR);
			break;
	}

	wait.Restore ();

	if (err.GetLength ()) {
		CString title;
		title.LoadString (IDS_ATTENTION);
		MessageBox (err.GetBuffer (), title.GetBuffer ());
		static_item->ShowWindow (SW_HIDE);
	} else {
		DConfigManager::instance ()->set ("Login", login);
		DConfigManager::instance ()->set_crypt ("Pswd", password);
	}
}

void CLoginDlg::OnCancel () {
	CString msg, title;
	title.LoadString (IDS_ATTENTION);
	msg.LoadString (IDS_QUEST_EXIT_FROM_PROGAM);
	
	if (MessageBox (msg.GetBuffer (), title.GetBuffer (), MB_YESNO | MB_ICONQUESTION | MB_APPLMODAL) == IDYES) {
		CDialog::OnCancel ();
	}
}

void CLoginDlg::OnInetSettings () {
	ShowWindow (SW_HIDE);

	Internet::InternetAccessInfo& info = GetAppPtr ()->get_internet_access_info ();

	CInetAccessSettingsDlg dlg;

	dlg.set_settings (info);
	dlg.DoModal ();
	dlg.get_settings (info);

	GetAppPtr ()->write_inet_settings (info); // write new settings

	Internet::ConnectManager::instance ()->init (info, true); // reconnect

	ShowWindow (SW_SHOW);
	SetForegroundWindow ();
}

void CLoginDlg::OnHelp () {
#ifdef _GCD_CLIENT
	GetAppPtr ()->show_help ("page-downloader_order_connect.htm");
#else
	CDialog::OnHelp ();
#endif
}

// end of...
