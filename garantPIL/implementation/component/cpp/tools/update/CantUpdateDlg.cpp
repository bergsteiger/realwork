// CantUpdateDlg.cpp : implementation file
//

#include "stdafx.h"
#include "Update.h"
#include "CantUpdateDlg.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

extern	TDeltaManager*	DeltaManager;
extern	CUpdateApp		theApp;

/////////////////////////////////////////////////////////////////////////////
// CCantUpdateDlg dialog


CCantUpdateDlg::CCantUpdateDlg(CWnd* pParent /*=NULL*/)
	: CDialog(CCantUpdateDlg::IDD, pParent)
{
	//{{AFX_DATA_INIT(CCantUpdateDlg)
		// NOTE: the ClassWizard will add member initialization here
	//}}AFX_DATA_INIT
}


void CCantUpdateDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CCantUpdateDlg)
	DDX_Control(pDX, IDC_E, m_pE);
	DDX_Control(pDX, IDC_MORE, m_pDeltas);
	//}}AFX_DATA_MAP
}


BEGIN_MESSAGE_MAP(CCantUpdateDlg, CDialog)
	//{{AFX_MSG_MAP(CCantUpdateDlg)
	ON_BN_CLICKED(IDBACK, OnBack)
	ON_BN_CLICKED(IDC_E, OnE)
	ON_WM_PAINT()
	ON_BN_CLICKED(ID_HELP, OnHelp)
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CCantUpdateDlg message handlers


BOOL CCantUpdateDlg::OnInitDialog() 
{
	CDialog::OnInitDialog();
	
	HICON m_hIcon = AfxGetApp()->LoadIcon(IDR_MAINFRAME);
	SetIcon(m_hIcon, TRUE);
	SetIcon(m_hIcon, FALSE);

	CString	aTitle;
	aTitle.LoadString( IDS_PARTDELTALISTTITLE );
	m_pDeltas.InsertColumn( 0, aTitle, LVCFMT_LEFT, 285 );

	for ( short I = 0; I < DeltaManager -> Absents -> getCount(); I++ ) {
		CString	atI( DeltaManager -> Absents -> at( I ));
		m_pDeltas.InsertItem( LVIF_TEXT|LVIF_STATE, I, atI, 0, LVIS_SELECTED, 0, 0 );
	}

	HICON m_bIcon = AfxGetApp()->LoadIcon(IDI_E);
	::SendMessage(m_pE.m_hWnd,BM_SETIMAGE,IMAGE_ICON,(long)m_bIcon);

	if ( DeltaManager -> Deltas -> getCount() )
		m_pE.ShowWindow( SW_HIDE );

	m_tooltip.Create(this);
	m_tooltip.Activate(TRUE);
	m_tooltip.AddTool( GetDlgItem( IDC_E ), IDS_DOWNLOADDELTA );

	SetForegroundWindow();

	return TRUE;
}

void CCantUpdateDlg::OnCancel() 
{
	if ( YesNoBox( IDS_SUREEXIT, this )) {
		CDialog::OnCancel();
		EndDialog( IDCANCEL );
	}
}

void CCantUpdateDlg::OnBack() 
{
	EndDialog( IDBACK );	
}

void CCantUpdateDlg::OnE() 
{
	RunDownload( DeltaManager->From );
}

BOOL CCantUpdateDlg::PreTranslateMessage(MSG* pMsg)
{
	m_tooltip.RelayEvent(pMsg);
	return CDialog::PreTranslateMessage(pMsg);
}

void CCantUpdateDlg::OnHelp() 
{
#ifdef	_GCD_CLIENT
	theApp.Help( "page-upd_order_detect.htm" );
#else
	CDialog::OnHelp();
#endif	
}
