// PathMsgDlg.cpp : implementation file
//

#include "stdafx.h"
#include "TestBreeder32.h"
#include "PathMsgDlg.h"

extern LPITEMIDLIST	PidlBrowse( HWND hwnd, int nCSIDL, LPSTR pszDisplayName, int aTitleID );

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CPathMsgDlg dialog


CPathMsgDlg::CPathMsgDlg(CWnd* pParent /*=NULL*/)
	: CDialog(CPathMsgDlg::IDD, pParent)
{
	//{{AFX_DATA_INIT(CPathMsgDlg)
	m_Message = _T("");
	//}}AFX_DATA_INIT
}


void CPathMsgDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CPathMsgDlg)
	DDX_Text(pDX, IDC_STATIC_AD0, m_Message);
	//}}AFX_DATA_MAP
}


BEGIN_MESSAGE_MAP(CPathMsgDlg, CDialog)
	//{{AFX_MSG_MAP(CPathMsgDlg)
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CPathMsgDlg message handlers

void CPathMsgDlg::OnOK() 
{
	ShowWindow(SW_HIDE);
	char SelectedPath[MAX_PATH+MAX_PATH];
	LPITEMIDLIST	aBrowse = PidlBrowse( m_hWnd, CSIDL_DRIVES, SelectedPath, IDS_SELECT_FOLDER );
	if ( aBrowse && SHGetPathFromIDList( aBrowse, SelectedPath )){
		m_NewPath= SelectedPath;
		EndDialog(IDOK);
		return;
	}
	ShowWindow(SW_SHOWNORMAL);
}

BOOL CPathMsgDlg::OnCmdMsg(UINT nID, int nCode, void* pExtra, AFX_CMDHANDLERINFO* pHandlerInfo) 
{
	if(nID == IDCANCEL){
	 if(m_Message[0] != '\x20'){
		CString titl, emsg;

		titl.LoadString(IDS_EXIT_TITLE);
		emsg.LoadString(IDS_EXIT_MSG);

		ShowWindow(SW_HIDE);
		if(MessageBox(emsg, titl, MB_ICONQUESTION | MB_YESNO | MB_DEFBUTTON2) != IDYES){
			ShowWindow(SW_SHOWNORMAL);
			return FALSE;
		}else{
			EndDialog(IDCANCEL);
		}
	 }else{
		 EndDialog(IDCANCEL);
	 }
	}
	return CDialog::OnCmdMsg(nID, nCode, pExtra, pHandlerInfo);
}
