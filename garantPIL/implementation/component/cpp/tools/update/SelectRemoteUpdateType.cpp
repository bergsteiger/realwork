// SelectRemoteUpdateType.cpp : implementation file
//

#include "stdafx.h"
#include "update.h"
#include "SelectRemoteUpdateType.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CSelectRemoteUpdateTypeDlg dialog

extern	CUpdateApp	theApp;

CSelectRemoteUpdateTypeDlg::CSelectRemoteUpdateTypeDlg(CWnd* pParent /*=NULL*/)
	: CDialog(CSelectRemoteUpdateTypeDlg::IDD, pParent)
{
	//{{AFX_DATA_INIT(CSelectRemoteUpdateTypeDlg)
		// NOTE: the ClassWizard will add member initialization here
	//}}AFX_DATA_INIT
}


void CSelectRemoteUpdateTypeDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CSelectRemoteUpdateTypeDlg)
		// NOTE: the ClassWizard will add DDX and DDV calls here
	//}}AFX_DATA_MAP
}


BEGIN_MESSAGE_MAP(CSelectRemoteUpdateTypeDlg, CDialog)
	//{{AFX_MSG_MAP(CSelectRemoteUpdateTypeDlg)
	ON_BN_CLICKED(ID_HELP, OnHelp)
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CSelectRemoteUpdateTypeDlg message handlers

void CSelectRemoteUpdateTypeDlg::OnOK() 
{
	if (IsDlgButtonChecked( IDC_RADIO1 ))
		updateType = 0;
	else
		updateType = 1;
	EndDialog(IDOK);
}

void CSelectRemoteUpdateTypeDlg::OnHelp() 
{
#ifdef	_GCD_CLIENT
	theApp.Help( "page-upd_order_backup.htm" );
#else
	CDialog::OnHelp();
#endif
}

void CSelectRemoteUpdateTypeDlg::OnCancel() 
{
	if ( YesNoBox( IDS_SUREEXIT, this )) {
		CDialog::OnCancel();
		EndDialog( IDCANCEL );
	}
}

BOOL CSelectRemoteUpdateTypeDlg::OnInitDialog() 
{
	CDialog::OnInitDialog();
	
	HICON m_hIcon = AfxGetApp()->LoadIcon(IDR_MAINFRAME);
	SetIcon(m_hIcon, TRUE);
	SetIcon(m_hIcon, FALSE);

	CheckRadioButton (IDC_RADIO1, IDC_RADIO2, IDC_RADIO1);

	return TRUE;
}
