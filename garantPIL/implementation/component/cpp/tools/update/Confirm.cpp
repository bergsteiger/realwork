// Confirm.cpp : implementation file
//

#include "stdafx.h"
#include "Update.h"
#include "Confirm.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

extern	CUpdateApp theApp;

/////////////////////////////////////////////////////////////////////////////
// CConfirmDlg dialog


CConfirmDlg::CConfirmDlg( UINT aMessageID, UINT aTitleID, UINT aIconID, CString aAdd, CWnd* pParent /*=NULL*/)
	: CDialog(CConfirmDlg::IDD, pParent)
{
	MessageID = aMessageID;
	TitleID = aTitleID;
	IconID = aIconID;
	Add = aAdd;
	//{{AFX_DATA_INIT(CConfirmDlg)
		// NOTE: the ClassWizard will add member initialization here
	//}}AFX_DATA_INIT
}


void CConfirmDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CConfirmDlg)
	DDX_Control(pDX, IDC_TEXT, m_pText);
	DDX_Control(pDX, IDC_BEICON, m_pIcon);
	//}}AFX_DATA_MAP
}


BEGIN_MESSAGE_MAP(CConfirmDlg, CDialog)
	//{{AFX_MSG_MAP(CConfirmDlg)
	ON_BN_CLICKED(IDYES, OnYes)
	ON_BN_CLICKED(IDNO, OnNo)
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CConfirmDlg message handlers

BOOL CConfirmDlg::OnInitDialog() 
{
	CDialog::OnInitDialog();
	
	CString	aMessage;
	aMessage.LoadString( TitleID );
	SetWindowText( aMessage );
	aMessage.Format( MessageID, Add );	
	m_pText.SetWindowText( aMessage );
	m_pIcon.SetIcon( theApp.LoadIcon( IconID ));

	//SetForegroundWindow();

	return TRUE;
}

void CConfirmDlg::OnYes() 
{
	EndDialog( IDYES );
}

void CConfirmDlg::OnNo() 
{
	EndDialog( IDNO );	
}
