// SyncUpdate.cpp : implementation file
//

#include "stdafx.h"
#include "TestBreeder32.h"
#include "TestBreeder32Dlg.h"
#include "SyncUpdate.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CSyncUpdate dialog


CSyncUpdate::CSyncUpdate(CWnd* pParent /*=NULL*/)
	: CDialog(CSyncUpdate::IDD, pParent)
{
	//{{AFX_DATA_INIT(CSyncUpdate)
		// NOTE: the ClassWizard will add member initialization here
	//}}AFX_DATA_INIT
	bSync = 0;
}


void CSyncUpdate::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CSyncUpdate)
		// NOTE: the ClassWizard will add DDX and DDV calls here
	//}}AFX_DATA_MAP
}


BEGIN_MESSAGE_MAP(CSyncUpdate, CDialog)
	//{{AFX_MSG_MAP(CSyncUpdate)
	ON_BN_CLICKED(ID_HELP, OnHelp)
	ON_BN_CLICKED(ID_NEXT, OnNext)
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CSyncUpdate message handlers

void CSyncUpdate::OnHelp() 
{
#ifdef	_GCD_CLIENT
	((CTestBreeder32Dlg*)m_pParentWnd)->Help( "page-brd_order_backup.htm" );
#endif
}

void CSyncUpdate::OnCancel() 
{
	CString title, message;
	title.LoadString(IDS_EXIT_TITLE);
	message.LoadString(IDS_EXIT_MSG);

	if ( MessageBox(message, title, MB_ICONQUESTION | MB_YESNO | MB_DEFBUTTON2 ) == IDYES )
		EndDialog( IDCANCEL );
}

BOOL CSyncUpdate::OnInitDialog () {
	CDialog::OnInitDialog ();

#ifdef	_GCD_CLIENT
	CheckRadioButton (IDC_RADIONO, IDC_RADIOYES, IDC_RADIONO);
#endif

	return TRUE;
}

void CSyncUpdate::OnNext() 
{
	bSync = IsDlgButtonChecked( IDC_RADIOYES );
	EndDialog(IDOK);
}
