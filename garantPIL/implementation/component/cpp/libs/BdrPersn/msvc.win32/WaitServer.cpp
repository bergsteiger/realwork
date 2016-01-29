// WaitServer.cpp : implementation file
//

#include "stdafx.h"
#include "testbreeder32.h"

#ifdef	_GCD_CLIENT
#include "WaitServer.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CWaitServer dialog


CWaitServer::CWaitServer(CWnd* pParent /*=NULL*/)
	: CDialog(CWaitServer::IDD, pParent)
{
	//{{AFX_DATA_INIT(CWaitServer)
		// NOTE: the ClassWizard will add member initialization here
	//}}AFX_DATA_INIT
}


void CWaitServer::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CWaitServer)
	DDX_Control (pDX, IDC_IMAGE_PROGRESS, m_sImageProgress);
		// NOTE: the ClassWizard will add DDX and DDV calls here
	//}}AFX_DATA_MAP
}


BEGIN_MESSAGE_MAP(CWaitServer, CDialog)
	//{{AFX_MSG_MAP(CWaitServer)
	ON_WM_TIMER()
	ON_WM_DESTROY()
		// NOTE: the ClassWizard will add message map macros here
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CWaitServer message handlers

void CWaitServer::OnCancel() 
{
}

void CWaitServer::OnOK() 
{
}

BOOL CWaitServer::Create()
{
	BOOL aResult = CDialog::Create(CWaitServer::IDD);
	m_animIcon.SetImageList( IDB_PROGRESS, 4, RGB( 255,0,0 ));
	m_timerID = this -> SetTimer( 99, 250, NULL );
	NextIcon();
	return aResult;
}

void CWaitServer::OnTimer(UINT nIDEvent) 
{
	NextIcon();
	CDialog::OnTimer(nIDEvent);
}

void CWaitServer::NextIcon()
{
	HICON hCurrentIcon = m_sImageProgress.SetIcon(m_animIcon.GetNextImage());
	if (hCurrentIcon) {
		DestroyIcon (hCurrentIcon);
	}
}

void CWaitServer::OnDestroy() 
{
	CDialog::OnDestroy();
	if( m_timerID != 0 ) KillTimer( m_timerID );
}

BOOL CWaitServer::OnInitDialog() 
{
	CDialog::OnInitDialog();
	
	m_animIcon.SetImageList( IDB_PROGRESS, 4, RGB( 255,0,0 ));
	m_timerID = this -> SetTimer( 99, 250, NULL );
	NextIcon();

	return TRUE;
}

BOOL CWaitServer::OnCommand(WPARAM wParam, LPARAM lParam) 
{
	if ( wParam == IDC_FILE ) {
		EndDialog( IDOK );
	}
	
	return CDialog::OnCommand(wParam, lParam);
}

/////////////////////////////////////////////////////////////////////////////
// CUpdateComplete dialog


CUpdateComplete::CUpdateComplete(CWnd* pParent /*=NULL*/)
	: CDialog(CUpdateComplete::IDD, pParent)
{
	//{{AFX_DATA_INIT(CUpdateComplete)
		// NOTE: the ClassWizard will add member initialization here
	//}}AFX_DATA_INIT
}


void CUpdateComplete::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CWaitServer)
		// NOTE: the ClassWizard will add DDX and DDV calls here
	//}}AFX_DATA_MAP
}


BEGIN_MESSAGE_MAP(CUpdateComplete, CDialog)
	//{{AFX_MSG_MAP(CUpdateComplete)
		// NOTE: the ClassWizard will add message map macros here
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

void CUpdateComplete::OnCancel() 
{
}

void CUpdateComplete::OnOK() 
{
}

BOOL CUpdateComplete::Create()
{
	return CDialog::Create(CUpdateComplete::IDD);
}


/////////////////////////////////////////////////////////////////////////////
// CWaitDatasetupGarantRu dialog

CWaitDatasetupGarantRu::CWaitDatasetupGarantRu(CWnd* pParent /*=NULL*/)
	: CDialog(CWaitDatasetupGarantRu::IDD, pParent)
{
	//{{AFX_DATA_INIT(CWaitDatasetupGarantRu)
		// NOTE: the ClassWizard will add member initialization here
	//}}AFX_DATA_INIT
}


void CWaitDatasetupGarantRu::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CWaitDatasetupGarantRu)
		// NOTE: the ClassWizard will add DDX and DDV calls here
	//}}AFX_DATA_MAP
}


BEGIN_MESSAGE_MAP(CWaitDatasetupGarantRu, CDialog)
	//{{AFX_MSG_MAP(CWaitDatasetupGarantRu)
		// NOTE: the ClassWizard will add message map macros here
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

void CWaitDatasetupGarantRu::OnCancel() 
{
}

void CWaitDatasetupGarantRu::OnOK() 
{
}

BOOL CWaitDatasetupGarantRu::Create()
{
	return CDialog::Create(CWaitDatasetupGarantRu::IDD);
}

/////////////////////////////////////////////////////////////////////////////
// CWaitUsers dialog


CWaitUsers::CWaitUsers(CWnd* pParent /*=NULL*/)
	: CDialog(CWaitUsers::IDD, pParent)
{
	//{{AFX_DATA_INIT(CWaitUsers)
		// NOTE: the ClassWizard will add member initialization here
	//}}AFX_DATA_INIT
}


void CWaitUsers::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CWaitUsers)
	DDX_Control (pDX, IDC_IMAGE_PROGRESS, m_sImageProgress);
		// NOTE: the ClassWizard will add DDX and DDV calls here
	//}}AFX_DATA_MAP
}


BEGIN_MESSAGE_MAP(CWaitUsers, CDialog)
	//{{AFX_MSG_MAP(CWaitUsers)
	ON_WM_TIMER()
	ON_WM_DESTROY()
		// NOTE: the ClassWizard will add message map macros here
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CWaitUsers message handlers

void CWaitUsers::OnCancel() 
{
}

void CWaitUsers::OnOK() 
{
}

BOOL CWaitUsers::Create()
{
	BOOL aResult = CDialog::Create(CWaitUsers::IDD);
	m_animIcon.SetImageList( IDB_PROGRESS, 4, RGB( 255,0,0 ));
	m_timerID = this -> SetTimer( 99, 250, NULL );
	NextIcon();
	return aResult;
}

void CWaitUsers::OnTimer(UINT nIDEvent) 
{
	NextIcon();
	CDialog::OnTimer(nIDEvent);
}

void CWaitUsers::NextIcon()
{
	HICON hCurrentIcon = m_sImageProgress.SetIcon(m_animIcon.GetNextImage());
	if (hCurrentIcon) {
		DestroyIcon (hCurrentIcon);
	}
}

void CWaitUsers::OnDestroy() 
{
	CDialog::OnDestroy();
	if( m_timerID != 0 ) KillTimer( m_timerID );
}

BOOL CWaitUsers::OnInitDialog() 
{
	CDialog::OnInitDialog();
	
	m_animIcon.SetImageList( IDB_PROGRESS, 4, RGB( 255,0,0 ));
	m_timerID = this -> SetTimer( 99, 250, NULL );
	NextIcon();

	return TRUE;
}

BOOL CWaitUsers::OnCommand(WPARAM wParam, LPARAM lParam) 
{
	if ( wParam == IDC_FILE ) {
		EndDialog( IDOK );
	}
	
	return CDialog::OnCommand(wParam, lParam);
}

/////////////////////////////////////////////////////////////////////////////
// CWaitXml dialog

CWaitXml::CWaitXml(CWnd* pParent /*=NULL*/)
	: CDialog(CWaitXml::IDD, pParent)
{
	//{{AFX_DATA_INIT(CWaitXml)
		// NOTE: the ClassWizard will add member initialization here
	//}}AFX_DATA_INIT
}


void CWaitXml::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CWaitXml)
	DDX_Control (pDX, IDC_IMAGE_PROGRESS, m_sImageProgress);
		// NOTE: the ClassWizard will add DDX and DDV calls here
	//}}AFX_DATA_MAP
}


BEGIN_MESSAGE_MAP(CWaitXml, CDialog)
	//{{AFX_MSG_MAP(CWaitXml)
	ON_WM_TIMER()
	ON_WM_DESTROY()
		// NOTE: the ClassWizard will add message map macros here
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CWaitXml message handlers

void CWaitXml::OnCancel() 
{
}

void CWaitXml::OnOK() 
{
}

BOOL CWaitXml::Create()
{
	BOOL aResult = CDialog::Create(CWaitXml::IDD);
	m_animIcon.SetImageList( IDB_PROGRESS, 4, RGB( 255,0,0 ));
	m_timerID = this -> SetTimer (99, 250, NULL);
	sleep_time = 3;
	m_timerIDXml = this -> SetTimer (98, sleep_time * 1000, NULL);
	NextIcon();
	return aResult;
}

void CWaitXml::OnTimer(UINT nIDEvent) 
{
	if (nIDEvent == 98) {
		KillTimer (m_timerIDXml);
		try {
			update_runner->um->login((LPCTSTR)m_Login, (LPCTSTR)m_Password);
			update_runner->m_logged = true;
			EndDialog (IDOK);
		}
		catch (GCD::XMLImportRunning) {
			if (sleep_time < 30)
				sleep_time += 3;
		}
		catch (...) {
			EndDialog(IDOK);
		}
		m_timerIDXml = this -> SetTimer (98, sleep_time * 1000, NULL);
	}
	NextIcon();
	CDialog::OnTimer(nIDEvent);
}

void CWaitXml::NextIcon()
{
	HICON hCurrentIcon = m_sImageProgress.SetIcon(m_animIcon.GetNextImage());
	if (hCurrentIcon) {
		DestroyIcon (hCurrentIcon);
	}
}

void CWaitXml::OnDestroy() 
{
	CDialog::OnDestroy();
	if (m_timerID != 0) KillTimer( m_timerID );
	if (m_timerIDXml != 0) KillTimer (m_timerIDXml);
}

BOOL CWaitXml::OnInitDialog() 
{
	CDialog::OnInitDialog();
	
	m_animIcon.SetImageList( IDB_PROGRESS, 4, RGB( 255,0,0 ));
	m_timerID = this -> SetTimer( 99, 250, NULL );
	sleep_time = 3;
	m_timerIDXml = this -> SetTimer (98, sleep_time * 1000, NULL);
	NextIcon();

	return TRUE;
}

BOOL CWaitXml::OnCommand(WPARAM wParam, LPARAM lParam) 
{
	if ( wParam == IDC_FILE ) {
		EndDialog( IDOK );
	}
	
	return CDialog::OnCommand(wParam, lParam);
}

/////////////////////////////////////////////////////////////////////////////
// CWaitServerStart dialog

CWaitServerStart::CWaitServerStart(CWnd* pParent /*=NULL*/)
	: CDialog(CWaitServerStart::IDD, pParent)
{
	//{{AFX_DATA_INIT(CWaitServerStart)
		// NOTE: the ClassWizard will add member initialization here
	//}}AFX_DATA_INIT
}


void CWaitServerStart::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CWaitXml)
	DDX_Control (pDX, IDC_IMAGE_PROGRESS, m_sImageProgress);
		// NOTE: the ClassWizard will add DDX and DDV calls here
	//}}AFX_DATA_MAP
}


BEGIN_MESSAGE_MAP(CWaitServerStart, CDialog)
	//{{AFX_MSG_MAP(CWaitServerStart)
	ON_WM_TIMER()
	ON_WM_DESTROY()
		// NOTE: the ClassWizard will add message map macros here
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

void CWaitServerStart::OnCancel() 
{
}

void CWaitServerStart::OnOK() 
{
}

BOOL CWaitServerStart::Create()
{
	BOOL aResult = CDialog::Create(CWaitServerStart::IDD);
	m_animIcon.SetImageList( IDB_PROGRESS, 4, RGB( 255,0,0 ));
	m_timerID = this -> SetTimer (99, 250, NULL);
	sleep_time = 3;
	m_timerIDServerStart = this -> SetTimer (98, sleep_time * 1000, NULL);
	NextIcon();
	return aResult;
}

void CWaitServerStart::OnTimer(UINT nIDEvent) 
{
	if (nIDEvent == 98) {
		KillTimer (m_timerIDServerStart);
		try {
			update_runner->um->login((LPCTSTR)m_Login, (LPCTSTR)m_Password);
			update_runner->m_logged = true;
			EndDialog (IDOK);
		}
		catch (GCM::ServerIsStarting) {
			if (sleep_time < 30)
				sleep_time += 3;
		}
		catch (...) {
			EndDialog(IDOK);
		}
		m_timerIDServerStart = this -> SetTimer (98, sleep_time * 1000, NULL);
	}
	NextIcon();
	CDialog::OnTimer(nIDEvent);
}

void CWaitServerStart::NextIcon()
{
	HICON hCurrentIcon = m_sImageProgress.SetIcon(m_animIcon.GetNextImage());
	if (hCurrentIcon) {
		DestroyIcon (hCurrentIcon);
	}
}

void CWaitServerStart::OnDestroy() 
{
	CDialog::OnDestroy();
	if (m_timerID != 0) KillTimer( m_timerID );
	if (m_timerIDServerStart != 0) KillTimer (m_timerIDServerStart);
}

BOOL CWaitServerStart::OnInitDialog() 
{
	CDialog::OnInitDialog();
	
	m_animIcon.SetImageList( IDB_PROGRESS, 4, RGB( 255,0,0 ));
	m_timerID = this -> SetTimer( 99, 250, NULL );
	sleep_time = 3;
	m_timerIDServerStart = this -> SetTimer (98, sleep_time * 1000, NULL);
	NextIcon();

	return TRUE;
}

BOOL CWaitServerStart::OnCommand(WPARAM wParam, LPARAM lParam) 
{
	if ( wParam == IDC_FILE ) {
		EndDialog( IDOK );
	}
	
	return CDialog::OnCommand(wParam, lParam);
}

/////////////////////////////////////////////////////////////////////////////
// CWaitServerStart2 dialog

CWaitServerStart2::CWaitServerStart2(CWnd* pParent /*=NULL*/)
	: CDialog(CWaitServerStart2::IDD, pParent)
{
	//{{AFX_DATA_INIT(CWaitServerStart2)
		// NOTE: the ClassWizard will add member initialization here
	//}}AFX_DATA_INIT
}


void CWaitServerStart2::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CWaitServerStart2)
		// NOTE: the ClassWizard will add DDX and DDV calls here
	//}}AFX_DATA_MAP
}

BEGIN_MESSAGE_MAP(CWaitServerStart2, CDialog)
	//{{AFX_MSG_MAP(CWaitServerStart2)
		// NOTE: the ClassWizard will add message map macros here
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

void CWaitServerStart2::OnCancel() 
{
}

void CWaitServerStart2::OnOK() 
{
}

BOOL CWaitServerStart2::Create()
{
	return CDialog::Create(CWaitServerStart2::IDD);
}

#endif
