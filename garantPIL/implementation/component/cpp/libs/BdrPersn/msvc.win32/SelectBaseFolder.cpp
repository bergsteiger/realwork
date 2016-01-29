// SelectBaseFolder.cpp : implementation file
//

#include "stdafx.h"
#include "testbreeder32.h"
#include "TestBreeder32Dlg.h"
#include "SelectBaseFolder.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CSelectBaseFolder dialog

extern	LPITEMIDLIST	PidlBrowse( HWND hwnd, int nCSIDL, LPSTR pszDisplayName, int aTitleID );
extern	LONGLONG	MyGetDiskFreeSpace( LPCTSTR );

CSelectBaseFolder::CSelectBaseFolder(long aSplit, long aPacked, long aUnpacked, CWnd* pParent /*=NULL*/)
	: CDialog(CSelectBaseFolder::IDD, pParent)
{
	split = aSplit;
	packed = aPacked;
	unpacked = aUnpacked;
	//{{AFX_DATA_INIT(CSelectBaseFolder)
		// NOTE: the ClassWizard will add member initialization here
	//}}AFX_DATA_INIT
}


void CSelectBaseFolder::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CSelectBaseFolder)
	DDX_Control(pDX, IDC_FREE, m_pFree);
	DDX_Control(pDX, IDC_NEED, m_pNeed);
	DDX_Control(pDX, IDC_PATH, m_pPath);
	//}}AFX_DATA_MAP
}


BEGIN_MESSAGE_MAP(CSelectBaseFolder, CDialog)
	//{{AFX_MSG_MAP(CSelectBaseFolder)
	ON_BN_CLICKED(ID_HELP, OnHelp)
	ON_BN_CLICKED(ID_NEXT, OnNext)
	ON_BN_CLICKED(IDC_BROWSE, OnBrowse)
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CSelectBaseFolder message handlers

void CSelectBaseFolder::OnHelp() 
{
#ifdef	_GCD_CLIENT
	((CTestBreeder32Dlg*)m_pParentWnd)->Help( "page-brd_order_backup.htm" );
#endif
}

void CSelectBaseFolder::OnCancel() 
{
	CString title, message;
	title.LoadString(IDS_EXIT_TITLE);
	message.LoadString(IDS_EXIT_MSG);

	if ( MessageBox(message, title, MB_ICONQUESTION | MB_YESNO | MB_DEFBUTTON2 ) == IDYES )
		EndDialog( IDCANCEL );
}

void CSelectBaseFolder::OnNext() 
{
	EndDialog(IDOK);
}

void CSelectBaseFolder::OnBrowse() 
{
	char	aPath[ MAX_PATH ];
	LPITEMIDLIST	aBrowse = PidlBrowse( m_hWnd, CSIDL_DRIVES, selectedPath, IDS_SELECT_FOLDER );
	if ( aBrowse && SHGetPathFromIDList( aBrowse, aPath )) {
		strcpy( selectedPath, aPath );
		m_pPath.SetWindowText( selectedPath );
		ShowFree();
	}
}

BOOL CSelectBaseFolder::OnInitDialog () {
	CDialog::OnInitDialog ();

	ACE_OS::strcpy (selectedPath, "C:\\");
	ShowFree ();

	CString str;

	if (split) {
		str.Format (IDS_NEED_BYTES_SPLIT, packed, unpacked);
	} else {
		str.LoadString (IDS_NEED_BYTES);
	}

	m_pNeed.SetWindowText (str.GetBuffer ());
	return TRUE;
}

void CSelectBaseFolder::ShowFree () {
	CString str;
	str.Format (IDS_FREE_SPACE, MyGetDiskFreeSpace (selectedPath) / (long)(1024*1024));
	m_pFree.SetWindowText (str.GetBuffer ());
}
