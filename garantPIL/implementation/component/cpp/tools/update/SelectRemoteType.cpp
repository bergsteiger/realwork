// SelectRemoteType.cpp : implementation file
//

#include "stdafx.h"
#include "update.h"
#include "SelectRemoteType.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

extern	CUpdateApp	theApp;

/////////////////////////////////////////////////////////////////////////////
// CSelectRemoteTypeDlg dialog


CSelectRemoteTypeDlg::CSelectRemoteTypeDlg(CWnd* pParent /*=NULL*/)
	: CDialog(CSelectRemoteTypeDlg::IDD, pParent)
{
	//{{AFX_DATA_INIT(CSelectRemoteTypeDlg)
		// NOTE: the ClassWizard will add member initialization here
	//}}AFX_DATA_INIT
}


void CSelectRemoteTypeDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CSelectRemoteTypeDlg)
		// NOTE: the ClassWizard will add DDX and DDV calls here
	//}}AFX_DATA_MAP
}


BEGIN_MESSAGE_MAP(CSelectRemoteTypeDlg, CDialog)
	//{{AFX_MSG_MAP(CSelectRemoteTypeDlg)
	ON_BN_CLICKED(ID_HELP, OnHelp)
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CSelectRemoteTypeDlg message handlers

void CSelectRemoteTypeDlg::OnHelp() 
{
#ifdef	_GCD_CLIENT
	theApp.Help( "page-upd_order_mode.htm" );
#else
	CDialog::OnHelp();
#endif
}

void CSelectRemoteTypeDlg::OnCancel() 
{
	if ( YesNoBox( IDS_SUREEXIT, this )) {
		CDialog::OnCancel();
		EndDialog( IDCANCEL );
	}
}

void CSelectRemoteTypeDlg::OnOK() 
{
	if (IsDlgButtonChecked( IDC_RADIO1 ))
		remoteType = 0;
	else
		remoteType = 1;

	EndDialog(IDOK);
}

BOOL CSelectRemoteTypeDlg::OnInitDialog() 
{
	CDialog::OnInitDialog();
	
	HICON m_hIcon = AfxGetApp()->LoadIcon(IDR_MAINFRAME);
	SetIcon(m_hIcon, TRUE);
	SetIcon(m_hIcon, FALSE);

	CheckRadioButton (IDC_RADIO1, IDC_RADIO2, IDC_RADIO1);

	return TRUE;
}
