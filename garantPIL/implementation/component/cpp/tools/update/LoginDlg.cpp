// LoginDlg.cpp : implementation file
//

#include "stdafx.h"

#if defined (_GCD_CLIENT) || defined (PILOT)
#include "garantServer/src/Business/GblPilot/Home/Client.h"
#include "garantServer/src/Global/Defines/DefinesC.h"
#endif

#include "update.h"
#include "LoginDlg.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CLoginDlg dialog

extern	BOOL	NoFinalMessage;
extern	CUpdateApp	theApp;
extern	void	Log( char* );
extern	char	*m_llogin;
extern	char	*m_lpwd;

CLoginDlg::CLoginDlg(CWnd* pParent /*=NULL*/)
	: CDialog(CLoginDlg::IDD, pParent)
{
	//{{AFX_DATA_INIT(CLoginDlg)
#ifdef	_GCD_CLIENT
	m_Login = _T("ADMIN");
	m_Password = _T("ADMIN");
#else
	m_Login = _T("");
	m_Password = _T("");
#endif
	//}}AFX_DATA_INIT
}

void CLoginDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CLoginDlg)
	DDX_Text(pDX, IDC_EDIT1, m_Login);
	DDX_Text(pDX, IDC_EDIT2, m_Password);
	//}}AFX_DATA_MAP
}

BEGIN_MESSAGE_MAP(CLoginDlg, CDialog)
	//{{AFX_MSG_MAP(CLoginDlg)
	ON_BN_CLICKED(ID_HELP, OnHelp)
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CLoginDlg message handlers

BOOL CLoginDlg::OnInitDialog() 
{
	CDialog::OnInitDialog();
	HICON m_hIcon = AfxGetApp()->LoadIcon(IDR_MAINFRAME);
	SetIcon(m_hIcon, TRUE);
	SetIcon(m_hIcon, FALSE);
	return TRUE;
}

void CLoginDlg::OnCancel() 
{
	if ( YesNoBox( IDS_SUREEXIT, this )) {
		CDialog::OnCancel();
		EndDialog( IDCANCEL );
	}	
}

void CLoginDlg::OnOK() 
{
	UpdateData(TRUE);
	EndDialog(IDOK);
}

void CLoginDlg::OnHelp() 
{
#ifdef	_GCD_CLIENT
	theApp.Help( "page-upd_order_auth.htm" );
#else
	CDialog::OnHelp();
#endif
}
