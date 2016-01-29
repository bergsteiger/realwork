// FatalError.cpp : implementation file
//

#include "stdafx.h"
#include "Update.h"
#include "FatalError.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

extern	CUpdateApp theApp;

/////////////////////////////////////////////////////////////////////////////
// CFatalErrorDlg dialog

BEGIN_MESSAGE_MAP(CFatalErrorDlg, CDialog)
	//{{AFX_MSG_MAP(CFatalErrorDlg)
	ON_BN_CLICKED(ID_HELP, OnHelp)
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

CFatalErrorDlg::CFatalErrorDlg( UINT aMessageID, CString aAdd, UINT aTitleID, UINT aIconID, CWnd* pParent /*=NULL*/)
	: CDialog(CFatalErrorDlg::IDD, pParent)
{
	Add = aAdd;
	MessageID = aMessageID;
	TitleID = aTitleID;
	IconID = aIconID;
	Message = "";
	//{{AFX_DATA_INIT(CFatalErrorDlg)
	//}}AFX_DATA_INIT
}

CFatalErrorDlg :: CFatalErrorDlg( CString aMessage ) : CDialog( CFatalErrorDlg :: IDD, NULL )
{
	TitleID = IDS_ERROR;
	IconID  = IDI_BESTOP;
	Message = aMessage;
	//{{AFX_DATA_INIT(CFatalErrorDlg)
	//}}AFX_DATA_INIT
}

CFatalErrorDlg :: CFatalErrorDlg( CString aMessage, UINT aTitleID, UINT aIconID ) : CDialog( CFatalErrorDlg :: IDD, NULL )
{
	TitleID = aTitleID;
	IconID  = aIconID;
	Message = aMessage;
	//{{AFX_DATA_INIT(CFatalErrorDlg)
	//}}AFX_DATA_INIT
}

void CFatalErrorDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CFatalErrorDlg)
	DDX_Control(pDX, IDC_BEICON, m_pIcon);
	DDX_Control(pDX, IDC_TEXT, m_pText);
	//}}AFX_DATA_MAP
}

/////////////////////////////////////////////////////////////////////////////
// CFatalErrorDlg message handlers

BOOL CFatalErrorDlg::OnInitDialog() 
{
	CDialog::OnInitDialog();
	
	HICON m_hIcon = AfxGetApp()->LoadIcon(IDR_MAINFRAME);
	SetIcon(m_hIcon, TRUE);
	SetIcon(m_hIcon, FALSE);

	SetForegroundWindow();

	CString	aMessage;
	aMessage.LoadString( TitleID );
	SetWindowText( aMessage );
	if ( Message == "" )
	{
		aMessage.Format( MessageID, Add );
		m_pText.SetWindowText( aMessage );
	}
	else
		m_pText.SetWindowText( Message );

	m_pIcon.SetIcon( theApp.LoadIcon( IconID ));
	
	return TRUE;
}

void CFatalErrorDlg::OnHelp() 
{
	return ;
}
