// SelectBaseFolderEx.cpp : implementation file
//

#include "stdafx.h"
#include "update.h"
#include "SelectBaseFolderEx.h"
#include "Utils.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

extern	CUpdateApp	theApp;
extern	char	DataPath[ MAX_PATH ];
extern	__int64	space_for_update();
extern	__int64	base_size();
extern	void	Log( char* );

/////////////////////////////////////////////////////////////////////////////
// CSelectBaseFolderEx dialog


CSelectBaseFolderEx::CSelectBaseFolderEx(CWnd* pParent /*=NULL*/)
	: CDialog(CSelectBaseFolderEx::IDD, pParent)
{
	//{{AFX_DATA_INIT(CSelectBaseFolderEx)
		// NOTE: the ClassWizard will add member initialization here
	//}}AFX_DATA_INIT
}


void CSelectBaseFolderEx::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CSelectBaseFolderEx)
	DDX_Control(pDX, IDC_BASEPATH, m_pBasePath);
	DDX_Control(pDX, IDC_BASESIZE, m_pSize);
	//}}AFX_DATA_MAP
}


BEGIN_MESSAGE_MAP(CSelectBaseFolderEx, CDialog)
	//{{AFX_MSG_MAP(CSelectBaseFolderEx)
	ON_BN_CLICKED(ID_HELP, OnHelp)
	ON_BN_CLICKED(IDC_BROWSE, OnBrowse)
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CSelectBaseFolderEx message handlers

void CSelectBaseFolderEx::OnHelp()
{
#ifdef	_GCD_CLIENT
	theApp.Help( "page-upd_order_localpath.htm" );
#else
	CDialog::OnHelp();
#endif
}

BOOL CSelectBaseFolderEx::OnInitDialog() 
{
	CDialog::OnInitDialog();

	CString	aText;
	char aLogString[128];
	Log( "\nПроверка свободного места, требуемого для обновления:\n" );
	sprintf( aLogString, "  надо: %I64d + %I64d\n", (__int64)base_size(), (__int64)space_for_update() );
	Log( aLogString );
	aText.Format( IDS_BASEEXSIZE, (long)( (base_size() + space_for_update()) / (__int64)1024) + 1 );
	m_pSize.SetWindowText( aText );

	return TRUE;
}

void CSelectBaseFolderEx::OnCancel() 
{
	if ( YesNoBox( IDS_SUREEXIT, this )) {
		CDialog::OnCancel();
		EndDialog( IDCANCEL );
	}
}

void CSelectBaseFolderEx::OnBrowse() 
{
	char	aPath[ MAX_PATH ];
	m_pBasePath.GetWindowText( aPath, MAX_PATH );
	LPITEMIDLIST	aBrowse = PidlBrowse( m_hWnd, CSIDL_DRIVES, aPath, IDS_SELECTFOLDERFORBASEEX );
	if ( aBrowse && SHGetPathFromIDList( aBrowse, aPath ))
		m_pBasePath.SetWindowText( aPath );
}

void CSelectBaseFolderEx::OnOK() 
{
	m_pBasePath.GetWindowText( DataPath, MAX_PATH );
	char aLogString[128];
	sprintf( aLogString, "  есть: %I64d МБайт на %s\n", (__int64)MyGetDiskFreeSpace( DataPath ) / (1024*1024), DataPath );
	Log( aLogString );
	if ( MyGetDiskFreeSpace( DataPath ) / 1024 < (LONGLONG)( base_size() + space_for_update())) {
		if ( YesNoBox( IDS_SMALLFREESPACE, this ))
			EndDialog(IDOK);
	} else {
		EndDialog(IDOK);
	}
}
