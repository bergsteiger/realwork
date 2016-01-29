// SelectDeltasFolder.cpp : implementation file
//

#include "stdafx.h"
#include "Update.h"
#include "SelectDeltasFolder.h"
#include "Utils.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

extern	char	DeltaPath[ MAX_PATH ];

extern	CUpdateApp	theApp;

/////////////////////////////////////////////////////////////////////////////
// CSelectDeltasFolderDlg dialog


CSelectDeltasFolderDlg::CSelectDeltasFolderDlg(CWnd* pParent /*=NULL*/)
	: CDialog(CSelectDeltasFolderDlg::IDD, pParent)
{
	//{{AFX_DATA_INIT(CSelectDeltasFolderDlg)
		// NOTE: the ClassWizard will add member initialization here
	//}}AFX_DATA_INIT
}


void CSelectDeltasFolderDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CSelectDeltasFolderDlg)
	DDX_Control(pDX, IDOK, m_pOk);
	DDX_Control(pDX, IDC_DELTAPATH, m_pDeltasFolder);
	//}}AFX_DATA_MAP
}


BEGIN_MESSAGE_MAP(CSelectDeltasFolderDlg, CDialog)
	//{{AFX_MSG_MAP(CSelectDeltasFolderDlg)
	ON_BN_CLICKED(IDBACK, OnBack)
	ON_BN_CLICKED(IDC_BROWSE, OnBrowse)
	ON_WM_PAINT()
	ON_WM_QUERYDRAGICON()
	ON_BN_CLICKED(ID_HELP, OnHelp)
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CSelectDeltasFolderDlg message handlers

BOOL CSelectDeltasFolderDlg::OnInitDialog() 
{
	CDialog::OnInitDialog();
	
	HICON m_hIcon = AfxGetApp()->LoadIcon(IDR_MAINFRAME);
	SetIcon(m_hIcon, TRUE);
	SetIcon(m_hIcon, FALSE);

	m_pDeltasFolder.SetWindowText( DeltaPath );

	return TRUE;
}

void CSelectDeltasFolderDlg::OnBack()
{
	EndDialog( IDBACK );	
}

void CSelectDeltasFolderDlg::OnBrowse()
{
	char copyDeltaPath [MAX_PATH];
	strcpy (copyDeltaPath, DeltaPath);
	LPITEMIDLIST	aBrowse = PidlBrowse( m_hWnd, CSIDL_DRIVES, copyDeltaPath, IDS_SELECTFOLDERWITHDELTAS );
	if ( aBrowse && SHGetPathFromIDList( aBrowse, copyDeltaPath )) {
		m_pDeltasFolder.SetWindowText( copyDeltaPath );
		strcpy (DeltaPath, copyDeltaPath);
	}
}

void CSelectDeltasFolderDlg::OnCancel() 
{
	if ( YesNoBox( IDS_SUREEXIT, this )) {
		CDialog::OnCancel();
		EndDialog( IDCANCEL );
	}
}

void CSelectDeltasFolderDlg::OnHelp() 
{
#ifdef	_GCD_CLIENT
	theApp.Help( "page-upd_order_where.htm" );
#else
	CDialog::OnHelp();
#endif
}
