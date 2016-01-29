// SelectServerUpdateType.cpp : implementation file
//

#include "stdafx.h"
#include "update.h"
#include "SelectServerUpdateType.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

extern	CUpdateApp	theApp;

/////////////////////////////////////////////////////////////////////////////
// CSelectServerUpdateTypeDlg dialog


CSelectServerUpdateTypeDlg::CSelectServerUpdateTypeDlg(CWnd* pParent /*=NULL*/)
	: CDialog(CSelectServerUpdateTypeDlg::IDD, pParent)
{
	//{{AFX_DATA_INIT(CSelectServerUpdateTypeDlg)
		// NOTE: the ClassWizard will add member initialization here
	//}}AFX_DATA_INIT
}


void CSelectServerUpdateTypeDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CSelectServerUpdateTypeDlg)
		// NOTE: the ClassWizard will add DDX and DDV calls here
	//}}AFX_DATA_MAP
}


BEGIN_MESSAGE_MAP(CSelectServerUpdateTypeDlg, CDialog)
	//{{AFX_MSG_MAP(CSelectServerUpdateTypeDlg)
	ON_BN_CLICKED(ID_HELP, OnHelp)
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CSelectServerUpdateTypeDlg message handlers

void CSelectServerUpdateTypeDlg::OnOK() 
{
	if (IsDlgButtonChecked( IDC_RADIO1 ))
		remoteType = 0;
	else
		remoteType = 1;

	EndDialog(IDOK);
}

void CSelectServerUpdateTypeDlg::OnCancel() 
{
	if ( YesNoBox( IDS_SUREEXIT, this )) {
		CDialog::OnCancel();
		EndDialog( IDCANCEL );
	}
}

void CSelectServerUpdateTypeDlg::OnHelp() 
{
#ifdef	_GCD_CLIENT
	theApp.Help( "page-upd_order_backup.htm" );
#else
	CDialog::OnHelp();
#endif
}

BOOL CSelectServerUpdateTypeDlg::OnInitDialog() 
{
	CDialog::OnInitDialog();
	
	HICON m_hIcon = AfxGetApp()->LoadIcon(IDR_MAINFRAME);
	SetIcon(m_hIcon, TRUE);
	SetIcon(m_hIcon, FALSE);

	CheckRadioButton (IDC_RADIO1, IDC_RADIO2, IDC_RADIO1);

	return TRUE;
}
