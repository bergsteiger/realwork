// WaitServerDialog.cpp : implementation file
//

#include "stdafx.h"
#include "update.h"
#include "WaitServerDialog.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CWaitServerDialog dialog

CWaitServerDialog::CWaitServerDialog(CWnd* pParent /*=NULL*/)
	: CDialog(CWaitServerDialog::IDD, pParent)
{
	//{{AFX_DATA_INIT(CWaitServerDialog)
		// NOTE: the ClassWizard will add member initialization here
	//}}AFX_DATA_INIT
}


void CWaitServerDialog::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CWaitServerDialog)
	DDX_Control (pDX, IDC_IMAGE_PROGRESS, m_sImageProgress);
		// NOTE: the ClassWizard will add DDX and DDV calls here
	//}}AFX_DATA_MAP
}

BEGIN_MESSAGE_MAP(CWaitServerDialog, CDialog)
	//{{AFX_MSG_MAP(CWaitServerDialog)
	ON_WM_TIMER()
	ON_WM_DESTROY()
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

void CWaitServerDialog::OnCancel() 
{
}

void CWaitServerDialog::OnOK() 
{
}

BOOL CWaitServerDialog::Create()
{
	BOOL result = CDialog::Create(CWaitServerDialog::IDD);
	m_animIcon.SetImageList( IDB_PROGRESS, 4, RGB( 255,0,0 ));
	m_timerID = this -> SetTimer( 99, 250, NULL );
	NextIcon();
	return result;
}

BOOL CWaitServerDialog::OnCommand(WPARAM wParam, LPARAM lParam) 
{
	if ( wParam == IDC_FILE ) {
		EndDialog( IDOK );
	}
	
	return CDialog::OnCommand(wParam, lParam);
}

BOOL CWaitServerDialog::OnInitDialog() 
{
	CDialog::OnInitDialog();
	
	m_animIcon.SetImageList( IDB_PROGRESS, 4, RGB( 255,0,0 ));
	m_timerID = this -> SetTimer( 99, 250, NULL );
	NextIcon();

	return TRUE;
}

void CWaitServerDialog::NextIcon()
{
	HICON hCurrentIcon = m_sImageProgress.SetIcon(m_animIcon.GetNextImage());
	if (hCurrentIcon) {
		DestroyIcon (hCurrentIcon);
	}
}

void CWaitServerDialog::OnTimer(UINT nIDEvent) 
{
	NextIcon();
	CDialog::OnTimer(nIDEvent);
}

void CWaitServerDialog::OnDestroy() 
{
	CDialog::OnDestroy();
	if( m_timerID != 0 ) KillTimer( m_timerID );
}



/////////////////////////////////////////////////////////////////////////////
// CWaitServer1Dialog dialog

CWaitServer1Dialog::CWaitServer1Dialog(CWnd* pParent /*=NULL*/)
	: CDialog(CWaitServer1Dialog::IDD, pParent)
{
	//{{AFX_DATA_INIT(CWaitServer1Dialog)
		// NOTE: the ClassWizard will add member initialization here
	//}}AFX_DATA_INIT
}


void CWaitServer1Dialog::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CWaitServer1Dialog)
	DDX_Control (pDX, IDC_IMAGE_PROGRESS, m_sImageProgress);
		// NOTE: the ClassWizard will add DDX and DDV calls here
	//}}AFX_DATA_MAP
}


BEGIN_MESSAGE_MAP(CWaitServer1Dialog, CDialog)
	//{{AFX_MSG_MAP(CWaitServer1Dialog)
	ON_WM_TIMER()
	ON_WM_DESTROY()
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

void CWaitServer1Dialog::OnCancel() 
{
}

void CWaitServer1Dialog::OnOK() 
{
}

BOOL CWaitServer1Dialog::Create()
{
	BOOL aResult = CDialog::Create(CWaitServer1Dialog::IDD);
	m_animIcon.SetImageList( IDB_PROGRESS, 4, RGB( 255,0,0 ));
	m_timerID = this -> SetTimer( 99, 250, NULL );
	NextIcon();
	return aResult;
}

void CWaitServer1Dialog::OnTimer(UINT nIDEvent) 
{
	NextIcon();
	CDialog::OnTimer(nIDEvent);
}

void CWaitServer1Dialog::NextIcon()
{
	HICON hCurrentIcon = m_sImageProgress.SetIcon(m_animIcon.GetNextImage());
	if (hCurrentIcon) {
		DestroyIcon (hCurrentIcon);
	}
}

void CWaitServer1Dialog::OnDestroy() 
{
	CDialog::OnDestroy();
	if( m_timerID != 0 ) KillTimer( m_timerID );
}

BOOL CWaitServer1Dialog::OnInitDialog() 
{
	CDialog::OnInitDialog();
	
	m_animIcon.SetImageList( IDB_PROGRESS, 4, RGB( 255,0,0 ));
	m_timerID = this -> SetTimer( 99, 250, NULL );
	NextIcon();

	return TRUE;
}

BOOL CWaitServer1Dialog::OnCommand(WPARAM wParam, LPARAM lParam) 
{
	if ( wParam == IDC_FILE ) {
		EndDialog( IDOK );
	}
	
	return CDialog::OnCommand(wParam, lParam);
}

CWaitXmlDialog::CWaitXmlDialog(CWnd* pParent /*=NULL*/)
	: CDialog(CWaitXmlDialog::IDD, pParent)
{
	//{{AFX_DATA_INIT(CWaitXmlDialog)
		// NOTE: the ClassWizard will add member initialization here
	//}}AFX_DATA_INIT
}


void CWaitXmlDialog::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CWaitXmlDialog)
	DDX_Control (pDX, IDC_IMAGE_PROGRESS, m_sImageProgress);
		// NOTE: the ClassWizard will add DDX and DDV calls here
	//}}AFX_DATA_MAP
}

BEGIN_MESSAGE_MAP(CWaitXmlDialog, CDialog)
	//{{AFX_MSG_MAP(CWaitXmlDialog)
	ON_WM_TIMER()
	ON_WM_DESTROY()
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

void CWaitXmlDialog::OnCancel() 
{
}

void CWaitXmlDialog::OnOK() 
{
}

BOOL CWaitXmlDialog::Create()
{
	BOOL result = CDialog::Create(CWaitXmlDialog::IDD);
	m_animIcon.SetImageList( IDB_PROGRESS, 4, RGB( 255,0,0 ));
	m_timerID = this -> SetTimer( 99, 250, NULL );
	sleep_time = 3;
	m_timerIDXml = this -> SetTimer (98, sleep_time * 1000, NULL);
	NextIcon();
	return result;
}

BOOL CWaitXmlDialog::OnCommand(WPARAM wParam, LPARAM lParam) 
{
	if ( wParam == IDC_FILE ) {
		EndDialog( IDOK );
	}
	
	return CDialog::OnCommand(wParam, lParam);
}

BOOL CWaitXmlDialog::OnInitDialog() 
{
	CDialog::OnInitDialog();
	
	m_animIcon.SetImageList( IDB_PROGRESS, 4, RGB( 255,0,0 ));
	m_timerID = this -> SetTimer( 99, 250, NULL );
	sleep_time = 3;
	m_timerIDXml = this -> SetTimer (98, sleep_time * 1000, NULL);
	NextIcon();

	return TRUE;
}

void CWaitXmlDialog::NextIcon()
{
	HICON hCurrentIcon = m_sImageProgress.SetIcon(m_animIcon.GetNextImage());
	if (hCurrentIcon) {
		DestroyIcon (hCurrentIcon);
	}
}

void CWaitXmlDialog::OnTimer(UINT nIDEvent) 
{
	if (nIDEvent == 98) {
		KillTimer (m_timerIDXml);
		try {
			update_runner->um->login((LPCTSTR)m_Login, (LPCTSTR)m_Password);
			EndDialog (IDOK);
		}
		catch (GCD::XMLImportRunning) {
			if (sleep_time < 30)
				sleep_time += 3;
		}
		catch(GslUserManager::LoginFailed&) {
			EndDialog(IDYES);
		}
		catch (...) {
			EndDialog(IDYES);
		}
		m_timerIDXml = this -> SetTimer (98, sleep_time * 1000, NULL);
	}
	NextIcon();
	CDialog::OnTimer(nIDEvent);
}

void CWaitXmlDialog::OnDestroy() 
{
	CDialog::OnDestroy();
	if( m_timerID != 0 ) KillTimer( m_timerID );
	if (m_timerIDXml != 0) KillTimer (m_timerIDXml);
}
