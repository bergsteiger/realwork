// PartUpdate.cpp : implementation file
//

#include <locale.h>

#include "stdafx.h"
#include "Update.h"
#include "PartUpdate.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

extern	TDeltaManager*	DeltaManager;
extern	BOOL			SilentMode;
extern	CUpdateApp		theApp;

/////////////////////////////////////////////////////////////////////////////
// CPartUpdateDlg dialog

CPartUpdateDlg::CPartUpdateDlg(CWnd* pParent /*=NULL*/)
	: CDialog(CPartUpdateDlg::IDD, pParent)
{
	//{{AFX_DATA_INIT(CPartUpdateDlg)
		// NOTE: the ClassWizard will add member initialization here
	//}}AFX_DATA_INIT
}


void CPartUpdateDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CPartUpdateDlg)
	DDX_Control(pDX, IDC_E, m_pE);
	DDX_Control(pDX, IDC_PARTUPDATETEXT, m_pText);
	DDX_Control(pDX, IDC_MORE, m_pDeltas);
	//}}AFX_DATA_MAP
}


BEGIN_MESSAGE_MAP(CPartUpdateDlg, CDialog)
	//{{AFX_MSG_MAP(CPartUpdateDlg)
	ON_BN_CLICKED(IDBACK, OnBack)
	ON_BN_CLICKED(IDC_E, OnE)
	ON_WM_PAINT()
	ON_BN_CLICKED(ID_HELP, OnHelp)
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CPartUpdateDlg message handlers

BOOL CPartUpdateDlg::OnInitDialog() 
{
	CDialog::OnInitDialog();
	
	HICON m_hIcon = AfxGetApp()->LoadIcon(IDR_MAINFRAME);
	SetIcon(m_hIcon, TRUE);
	SetIcon(m_hIcon, FALSE);

	CString	aTitle;
	aTitle.LoadString( IDS_PARTDELTALISTTITLE );
	m_pDeltas.InsertColumn( 0, aTitle, LVCFMT_LEFT, 290 );

	for ( short I = 0; I < DeltaManager -> Absents -> getCount(); I++ )
	{
		CString	atI( DeltaManager -> Absents -> at( I ));
		m_pDeltas.InsertItem( LVIF_TEXT|LVIF_STATE, I, atI, 0, LVIS_SELECTED, 0, 0 );
	}

	aTitle.Format( IDS_PARTUPDATETEXT, DeltaManager->From.RevisionDate.da_day, DeltaManager->From.RevisionDate.da_mon, DeltaManager->From.RevisionDate.da_year, DeltaManager->MinRevision.RevisionDate.da_day, DeltaManager->MinRevision.RevisionDate.da_mon, DeltaManager->MinRevision.RevisionDate.da_year );
	m_pText.SetWindowText( aTitle );

	HICON m_bIcon = AfxGetApp()->LoadIcon(IDI_E);
	::SendMessage(m_pE.m_hWnd,BM_SETIMAGE,IMAGE_ICON,(long)m_bIcon);

	if ( SilentMode )
		EndDialog( IDOK );

	m_tooltip.Create( this );
	m_tooltip.Activate( TRUE );
	m_tooltip.AddTool( GetDlgItem( IDC_E ), IDS_DOWNLOADDELTA );

	SetForegroundWindow();

	return TRUE;
}

void CPartUpdateDlg::OnBack() 
{
	EndDialog( IDBACK );	
}

void CPartUpdateDlg::OnCancel() 
{
	if ( YesNoBox( IDS_SUREEXIT, this ))
	{
		CDialog::OnCancel();
		EndDialog( IDCANCEL );
	}
}

void CPartUpdateDlg::OnE() 
{
	RunDownload( DeltaManager->MinRevision );
}

BOOL CPartUpdateDlg::PreTranslateMessage(MSG* pMsg)
{
	m_tooltip.RelayEvent(pMsg);
	return CDialog::PreTranslateMessage(pMsg);
}

void CPartUpdateDlg::OnHelp() 
{
#ifdef	_GCD_CLIENT
	theApp.Help( "page-upd_order_detect.htm" );
#else
	CDialog::OnHelp();
#endif
}
