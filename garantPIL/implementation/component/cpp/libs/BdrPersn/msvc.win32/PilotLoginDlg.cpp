// PilotLoginDlg.cpp : implementation file
//

#include "stdafx.h"

#if defined (_GCD_CLIENT) || defined (PILOT)
#include "garantServer/src/Business/GblPilot/Home/Client.h"
#include "garantServer/src/Global/Defines/DefinesC.h"

#endif

#include "TestBreeder32.h"
#include "TestBreeder32Dlg.h"
#include "PilotLoginDlg.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CPilotLoginDlg dialog

extern	bool	autoLogin;

CPilotLoginDlg::CPilotLoginDlg(CWnd* pParent /*=NULL*/)
	: CDialog(CPilotLoginDlg::IDD, pParent)
{
	//{{AFX_DATA_INIT(CPilotLoginDlg)
#ifdef	_GCD_CLIENT
	m_Login = _T("ADMIN");
	m_Password = _T("ADMIN");
#else
	m_Login = _T("");
	m_Password = _T("");
#endif
	//}}AFX_DATA_INIT
}


void CPilotLoginDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CPilotLoginDlg)
	DDX_Text(pDX, IDC_EDIT1, m_Login);
	DDX_Text(pDX, IDC_EDIT2, m_Password);
	//}}AFX_DATA_MAP
}


BEGIN_MESSAGE_MAP(CPilotLoginDlg, CDialog)
	//{{AFX_MSG_MAP(CPilotLoginDlg)
	ON_BN_CLICKED(ID_NEXT, OnNext)
	ON_BN_CLICKED(ID_HELP, OnHelp)
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CPilotLoginDlg message handlers

void CPilotLoginDlg::OnCancel() 
{
	CString titl, emsg;

	titl.LoadString(IDS_EXIT_TITLE);
	emsg.LoadString(IDS_EXIT_MSG);

	if(MessageBox(emsg, titl, MB_ICONQUESTION | MB_YESNO | MB_DEFBUTTON2 ) == IDYES)
		EndDialog( IDCANCEL );
}

void CPilotLoginDlg::OnNext() 
{
	UpdateData(TRUE);
	EndDialog(IDOK);
}

void CPilotLoginDlg::OnHelp() 
{
#ifdef	_GCD_CLIENT
	((CTestBreeder32Dlg*)m_pParentWnd)->Help( "page-brd_order_auth.htm" );
#else
	CDialog::OnHelp();
#endif	
}

BOOL CPilotLoginDlg::OnInitDialog() 
{
	CDialog::OnInitDialog();

#ifdef	_GCD_CLIENT
	if ( autoLogin )
		OnNext();
#endif

	return TRUE;
}
