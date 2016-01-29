// FullUpdate.cpp : implementation file
//

#include "stdafx.h"
#include "Update.h"
#include "FullUpdate.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

extern	BOOL	SilentMode;
extern	CUpdateApp		theApp;

/////////////////////////////////////////////////////////////////////////////
// CFullUpdateDlg dialog


CFullUpdateDlg::CFullUpdateDlg(CWnd* pParent /*=NULL*/)
	: CDialog(CFullUpdateDlg::IDD, pParent)
{
	//{{AFX_DATA_INIT(CFullUpdateDlg)
		// NOTE: the ClassWizard will add member initialization here
	//}}AFX_DATA_INIT
}


void CFullUpdateDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CFullUpdateDlg)
		// NOTE: the ClassWizard will add DDX and DDV calls here
	//}}AFX_DATA_MAP
}


BEGIN_MESSAGE_MAP(CFullUpdateDlg, CDialog)
	//{{AFX_MSG_MAP(CFullUpdateDlg)
	ON_BN_CLICKED(IDBACK, OnBack)
	ON_WM_PAINT()
	ON_BN_CLICKED(ID_HELP, OnHelp)
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CFullUpdateDlg message handlers

void CFullUpdateDlg::OnCancel() 
{
	if ( YesNoBox( IDS_SUREEXIT, this ))
	{
		CDialog::OnCancel();
		EndDialog( IDCANCEL );
	}
}

void CFullUpdateDlg::OnBack() 
{
	EndDialog( IDBACK );	
}

BOOL CFullUpdateDlg::OnInitDialog() 
{
	CDialog::OnInitDialog();
	
	HICON m_hIcon = AfxGetApp()->LoadIcon(IDR_MAINFRAME);
	SetIcon(m_hIcon, TRUE);
	SetIcon(m_hIcon, FALSE);
	
	if ( SilentMode )
		EndDialog( IDOK );
	
	SetForegroundWindow();

	return TRUE;
}

void CFullUpdateDlg::OnHelp() 
{
#ifdef	GCD_CLIENT
	theApp.Help( "page-upd_order_detect.htm" );
#else
	CDialog::OnHelp();
#endif
}
