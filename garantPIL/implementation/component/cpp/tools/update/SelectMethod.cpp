// SelectMethod.cpp : implementation file
//

#include "stdafx.h"
#include "update.h"
#include "SelectMethod.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

extern	CUpdateApp	theApp;

/////////////////////////////////////////////////////////////////////////////
// CSelectMethodDlg dialog

CSelectMethodDlg::CSelectMethodDlg(CWnd* pParent /*=NULL*/)
	: CDialog(CSelectMethodDlg::IDD, pParent)
{
	//{{AFX_DATA_INIT(CSelectMethodDlg)
		// NOTE: the ClassWizard will add member initialization here
	//}}AFX_DATA_INIT
	bExtended = false;
}

void CSelectMethodDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CSelectMethodDlg)
		// NOTE: the ClassWizard will add DDX and DDV calls here
	//}}AFX_DATA_MAP
}


BEGIN_MESSAGE_MAP(CSelectMethodDlg, CDialog)
	//{{AFX_MSG_MAP(CSelectMethodDlg)
	ON_BN_CLICKED(ID_HELP, OnHelp)
	ON_BN_CLICKED(IDBACK, OnBack)
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CSelectMethodDlg message handlers

void CSelectMethodDlg::OnOK() 
{
	if ( IsDlgButtonChecked( IDC_RADIO2 ))
		bExtended = true;
	else
		bExtended = false;
	CDialog::OnOK();
}

void CSelectMethodDlg::OnHelp() 
{
#ifdef	_GCD_CLIENT
	theApp.Help( "page-upd_order_type.htm" );
#else
	CDialog::OnHelp();
#endif	
}

BOOL CSelectMethodDlg::OnInitDialog() 
{
	CDialog::OnInitDialog();

	HICON m_hIcon = AfxGetApp()->LoadIcon(IDR_MAINFRAME);
	SetIcon(m_hIcon, TRUE);
	SetIcon(m_hIcon, FALSE);

	CheckRadioButton (IDC_RADIO1, IDC_RADIO2, bExtended ? IDC_RADIO2 : IDC_RADIO1);

	return TRUE;
}

void CSelectMethodDlg::OnCancel() 
{
	if ( YesNoBox( IDS_SUREEXIT, this )) {
		CDialog::OnCancel();
		EndDialog( IDCANCEL );
	}	
}

void CSelectMethodDlg::OnBack() 
{
	EndDialog( IDBACK );
}
