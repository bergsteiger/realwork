//
// CEndDownloadDlg.cpp : implementation file
//

#include "stdafx.h"

#include "LogFile.h"
#include "Downloader.h"
#include "EndDownloadDlg.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CEndDownloadDlg dialog

CEndDownloadDlg::CEndDownloadDlg (CWnd* pParent /*=NULL*/)
	: CDialog (CEndDownloadDlg::IDD, pParent) {
	//{{AFX_DATA_INIT(CEndDownloadDlg)
	//}}AFX_DATA_INIT
}

void CEndDownloadDlg::DoDataExchange (CDataExchange* pDX) {
	CDialog::DoDataExchange (pDX);
	//{{AFX_DATA_MAP(CEndDownloadDlg)
	DDX_Control(pDX, IDCANCEL, m_bCancel);
	DDX_Control(pDX, IDC_FINAL_MESSAGE_TEXT, m_sFinalMessageText);
	//}}AFX_DATA_MAP
}

BEGIN_MESSAGE_MAP(CEndDownloadDlg, CDialog)
	//{{AFX_MSG_MAP(CEndDownloadDlg)
	ON_BN_CLICKED(ID_HELP, OnHelp)
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CEndDownloadDlg message handlers

BOOL CEndDownloadDlg::OnInitDialog () {
	CDialog::OnInitDialog ();

	SetIcon (GetAppPtr ()->LoadIcon (IDR_MAINFRAME), TRUE);

	CString str;

	switch (GetAppPtr ()->get_state ()) {
	case ds_Success:
		str.Format (IDS_STATIC_DOWNLOAD_NORMAL);
		break;
	case ds_Abort:
		str.Format (IDS_STATIC_DOWNLOAD_ABORTED);
		break;
	case ds_Cancel:
		str.Format (IDS_STATIC_DOWNLOAD_CANCELED);
		break;
	}

	m_sFinalMessageText.SetWindowText (str);

	if (str.IsEmpty () == false) {
		DLOG->out_t (str);
	}

	SetForegroundWindow ();

	GetDlgItem (IDCANCEL)->SetFocus ();

	return FALSE;  // return TRUE  unless you set the focus to a control
}

void CEndDownloadDlg::OnCancel () {
	CDialog::OnCancel ();
}

void CEndDownloadDlg::OnHelp () {
#ifdef _GCD_CLIENT
	GetAppPtr ()->show_help ("page-downloader_order_ending.htm");
#else
	CDialog::OnHelp ();
#endif
}

// end of...
