// WelcomeDlg.cpp : implementation file
//

#include "stdafx.h"
#include "Update.h"
#include "WelcomeDlg.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

extern	CUpdateApp	theApp;

/////////////////////////////////////////////////////////////////////////////
// CWelcomeDlg dialog

CWelcomeDlg::CWelcomeDlg(CWnd* pParent /*=NULL*/)
	: CDialog(CWelcomeDlg::IDD, pParent)
{
	//{{AFX_DATA_INIT(CWelcomeDlg)
		// NOTE: the ClassWizard will add member initialization here
	//}}AFX_DATA_INIT
}

void CWelcomeDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CWelcomeDlg)
		// NOTE: the ClassWizard will add DDX and DDV calls here
	//}}AFX_DATA_MAP
}

BEGIN_MESSAGE_MAP(CWelcomeDlg, CDialog)
	//{{AFX_MSG_MAP(CWelcomeDlg)
	ON_WM_PAINT()
	ON_WM_QUERYDRAGICON()
	ON_BN_CLICKED(ID_HELP, OnHelp)
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CWelcomeDlg message handlers

BOOL CWelcomeDlg::OnInitDialog()
{
	CDialog::OnInitDialog();

	HICON m_hIcon = AfxGetApp()->LoadIcon(IDR_MAINFRAME);
	SetIcon(m_hIcon, TRUE);
	SetIcon(m_hIcon, FALSE);
	
	return TRUE;
}

// If you add a minimize button to your dialog, you will need the code below
//  to draw the icon.  For MFC applications using the document/view model,
//  this is automatically done for you by the framework.

void CWelcomeDlg::OnCancel() 
{
	if ( YesNoBox( IDS_SUREEXIT, this ))
	{
		CDialog::OnCancel();
		EndDialog( IDCANCEL );
	}	
}

void CWelcomeDlg::OnHelp() 
{
#ifdef	_GCD_CLIENT
	theApp.Help( "page-upd_order_auth.htm" );
#else
	CDialog::OnHelp();
#endif
}
