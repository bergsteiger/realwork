// SelectBackupFolder.cpp : implementation file
//

#include "stdafx.h"
#include "Update.h"
#include "SelectBackupFolder.h"
#include "Protection.h"
#include "Utils.h"
//#include "stdbase.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

extern	char	BackupPath[ MAX_PATH ];
extern	char	DataPath[ MAX_PATH ];
extern	char	Extensions[5][4];
extern	char	GarantPath[ MAX_PATH ];
extern	COMPLECTINFO*	lpComplectInfo;
extern	int		BasesCount();
extern	char*	BaseName( int );
extern	BOOL	SilentMode;
extern	BOOL	SilentBackup;

/////////////////////////////////////////////////////////////////////////////
// CSelectBackupFolderDlg dialog

CSelectBackupFolderDlg::CSelectBackupFolderDlg(CWnd* pParent /*=NULL*/)
	: CDialog(CSelectBackupFolderDlg::IDD, pParent)
{
	//{{AFX_DATA_INIT(CSelectBackupFolderDlg)
	//}}AFX_DATA_INIT
	isCheck = FALSE;
}


void CSelectBackupFolderDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CSelectBackupFolderDlg)
	DDX_Control(pDX, IDC_DOBACKUP, m_pCheck);
	DDX_Control(pDX, IDC_NODISKS, m_pNoDisks);
	DDX_Control(pDX, IDC_BACKUPPATH, m_pFolder);
	DDX_Control(pDX, IDC_BROWSE, m_pBrowse);
	DDX_Control(pDX, IDC_BACKUPGROUP, m_pGroup);
	DDX_Control(pDX, IDC_STATICHELP, m_pHelp);
	//}}AFX_DATA_MAP
}


BEGIN_MESSAGE_MAP(CSelectBackupFolderDlg, CDialog)
	//{{AFX_MSG_MAP(CSelectBackupFolderDlg)
	ON_BN_CLICKED(IDC_BROWSE, OnBrowse)
	ON_BN_CLICKED(IDC_DOBACKUP, OnDoBackup)
	ON_BN_CLICKED(ID_HELP, OnHelp)
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CSelectBackupFolderDlg message handlers

BOOL CSelectBackupFolderDlg::OnInitDialog() 
{
	return FALSE;
}

void CSelectBackupFolderDlg::OnCancel() 
{
	if ( YesNoBox( IDS_SUREEXIT, this )) {
		CDialog::OnCancel();
		EndDialog( IDCANCEL );
	}
}

void CSelectBackupFolderDlg::OnBrowse() 
{
	LPITEMIDLIST	aBrowse = PidlBrowse( m_hWnd, CSIDL_DRIVES, BackupPath, IDS_SELECTFOLDERFORBACKUP );
	if ( aBrowse && SHGetPathFromIDList( aBrowse, BackupPath ))
		m_pFolder.SetWindowText( BackupPath );	
}

void CSelectBackupFolderDlg::OnOK() 
{
	EndDialog( isCheck ? IDOK : IDNO );
}

void CSelectBackupFolderDlg::OnDoBackup() 
{
	isCheck = m_pCheck.GetCheck();

	m_pHelp.EnableWindow( isCheck );
	m_pGroup.EnableWindow( isCheck );
	m_pFolder.EnableWindow( isCheck );
	m_pBrowse.EnableWindow( isCheck );
	m_pNoDisks.EnableWindow( isCheck );	
}

void CSelectBackupFolderDlg::OnHelp() 
{
	CDialog::OnHelp();
}
