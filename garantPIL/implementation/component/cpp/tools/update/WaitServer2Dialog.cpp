// WaitServer2Dialog.cpp : implementation file
//

#include "stdafx.h"
#include "update.h"
#include "WaitServer2Dialog.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CWaitServer2Dialog dialog


CWaitServer2Dialog::CWaitServer2Dialog(CWnd* pParent /*=NULL*/)
	: CDialog(CWaitServer2Dialog::IDD, pParent)
{
	//{{AFX_DATA_INIT(CWaitServer2Dialog)
		// NOTE: the ClassWizard will add member initialization here
	//}}AFX_DATA_INIT
}

void CWaitServer2Dialog::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CWaitServer2Dialog)
	DDX_Control (pDX, IDC_IMAGE_PROGRESS, m_sImageProgress);
		// NOTE: the ClassWizard will add DDX and DDV calls here
	//}}AFX_DATA_MAP
}

BEGIN_MESSAGE_MAP(CWaitServer2Dialog, CDialog)
	//{{AFX_MSG_MAP(CWaitServer2Dialog)
	ON_WM_TIMER()
	ON_WM_DESTROY()
		// NOTE: the ClassWizard will add message map macros here
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

void CWaitServer2Dialog::OnCancel() 
{
}

void CWaitServer2Dialog::OnOK() 
{
}

BOOL CWaitServer2Dialog::Create()
{
	BOOL aResult = CDialog::Create(CWaitServer2Dialog::IDD);
	m_animIcon.SetImageList( IDB_PROGRESS, 4, RGB( 255,0,0 ));
	m_timerID = this -> SetTimer( 99, 250, NULL );
	NextIcon();
	return aResult;
}

void	CWaitServer2Dialog::NextIcon()
{
	HICON hCurrentIcon = m_sImageProgress.SetIcon(m_animIcon.GetNextImage());
	if (hCurrentIcon) {
		DestroyIcon (hCurrentIcon);
	}
}

void CWaitServer2Dialog::OnTimer(UINT nIDEvent) 
{
	NextIcon();
	CDialog::OnTimer(nIDEvent);
}

void CWaitServer2Dialog::OnDestroy() 
{
	CDialog::OnDestroy();
	if( m_timerID != 0 ) KillTimer( m_timerID );
}

BOOL CWaitServer2Dialog::OnInitDialog() 
{
	CDialog::OnInitDialog();
	
	m_animIcon.SetImageList( IDB_PROGRESS, 4, RGB( 255,0,0 ));
	m_timerID = this -> SetTimer( 99, 250, NULL );
	NextIcon();

	return TRUE;
}

BOOL CWaitServer2Dialog::OnCommand(WPARAM wParam, LPARAM lParam) 
{
	if ( wParam == IDC_FILE ) {
		EndDialog( IDOK );
	}
	
	return CDialog::OnCommand(wParam, lParam);
}

/////////////////////////////////////////////////////////////////////////////
// CWaitServer2Dialog message handlers
