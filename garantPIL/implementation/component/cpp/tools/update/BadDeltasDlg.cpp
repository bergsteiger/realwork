// BadDeltasDlg.cpp : implementation file
//

#include "stdafx.h"
#include "Update.h"
#include "Utils.h"
#include "BadDeltasDlg.h"
#include "UpdateDHReader.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

extern	TDeltaManager*	DeltaManager;
extern	char			DeltaPath[ MAX_PATH ];
extern	BOOL			SilentMode;
extern	CUpdateApp		theApp;

extern	void	TimeLog( UINT );
extern	void	Log( char* );
extern	int		global_return_code;

/////////////////////////////////////////////////////////////////////////////
// CBadDeltasDlg dialog


CBadDeltasDlg::CBadDeltasDlg(CWnd* pParent /*=NULL*/)
	: CDialog(CBadDeltasDlg::IDD, pParent)
{
	//{{AFX_DATA_INIT(CBadDeltasDlg)
		// NOTE: the ClassWizard will add member initialization here
	//}}AFX_DATA_INIT
}


void CBadDeltasDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CBadDeltasDlg)
	DDX_Control(pDX, ID_HELP, m_pHelp);
	DDX_Control(pDX, IDBACK, m_pBack);
	DDX_Control(pDX, IDOK, m_pNext);
	DDX_Control(pDX, IDC_RESULT, m_pResult);
	DDX_Control(pDX, IDC_DELTACOUNT, m_pCount);
	DDX_Control(pDX, IDC_DELTAPROGRESS, m_pProgress);
	DDX_Control(pDX, IDC_BADDELTAS, m_pDeltas);
	//}}AFX_DATA_MAP
}


BEGIN_MESSAGE_MAP(CBadDeltasDlg, CDialog)
	//{{AFX_MSG_MAP(CBadDeltasDlg)
	ON_BN_CLICKED(IDBACK, OnBack)
	ON_WM_PAINT()
	ON_BN_CLICKED(ID_HELP, OnHelp)
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CBadDeltasDlg message handlers

BOOL CBadDeltasDlg::OnInitDialog() 
{
	CDialog::OnInitDialog();
	
	HICON m_hIcon = AfxGetApp()->LoadIcon(IDR_MAINFRAME);
	SetIcon(m_hIcon, TRUE);
	SetIcon(m_hIcon, FALSE);

	if ( StartChecking())
		return TRUE;
	else
		return FALSE;
}

void CBadDeltasDlg::OnCancel() 
{
	pThread -> SuspendThread();
	if ( YesNoBox( IDS_SUREEXIT, this )) {
		CDialog::OnCancel();
		EndDialog( IDCANCEL );
	}
	else
		pThread -> ResumeThread();
}

void CBadDeltasDlg::OnBack() 
{
	EndDialog( IDBACK );	
}

/////////////////////////////////////////////////////////////////////////////
// CCheckDeltas

IMPLEMENT_DYNCREATE(CCheckDeltas, CWinThread)

CCheckDeltas::CCheckDeltas()
{
	m_hEventKill = CreateEvent( NULL, TRUE, FALSE, NULL );
}

CCheckDeltas::~CCheckDeltas()
{
	CloseHandle( m_hEventKill );
}

BOOL CCheckDeltas::InitInstance()
{
	while ( WaitForSingleObject( m_hEventKill, 0 ) == WAIT_TIMEOUT )
		Step();

	return FALSE;
}

BEGIN_MESSAGE_MAP(CCheckDeltas, CWinThread)
	//{{AFX_MSG_MAP(CCheckDeltas)
		// NOTE - the ClassWizard will add and remove mapping macros here.
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CCheckDeltas message handlers

void CCheckDeltas::KillThread()
{
	VERIFY(SetEvent(m_hEventKill));
	SetThreadPriority(THREAD_PRIORITY_ABOVE_NORMAL);
}

void CCheckDeltas::Step()
{
	if ( !DeltasToCheckPos )
	{
		StopChecking();
		return ;
	}

	CString	DeltaFileName = DeltasToCheck.GetNext( DeltasToCheckPos );
	UpdateDHReader *dhReader = new UpdateDHReader( DeltaFileName.GetBuffer( 0 ));
	CString	aDesc;
	switch ( dhReader->IsOK() )
	{
		case DHRS_OK:
			DeltaManager -> AddDelta( DeltaFileName.GetBuffer( 0 ), dhReader );
			break;
		case DHRS_BADVER:
			DeltaManager -> BadDeltas -> add( newStr( DeltaFileName ));
			aDesc.LoadString( IDS_DELTABADVER );
			DeltaManager -> BadDescs -> add( newStr( aDesc.GetBuffer( 0 )));
			break;
		case DHRS_BADSIZE:
			DeltaManager -> BadDeltas -> add( newStr( DeltaFileName ));
			aDesc.LoadString( IDS_DELTABADSIZE );
			DeltaManager -> BadDescs -> add( newStr( aDesc.GetBuffer( 0 )));
			break;
	}
	delete dhReader;
	m_pDlg->m_pProgress.SetPos( m_pDlg->m_pProgress.GetPos() + 1 );
	
	if ( !NextDelta() )
		StopChecking();
}

void CCheckDeltas::StartChecking()
{
	DeltasToCheckPos = DeltasToCheck.GetHeadPosition();
}

void CCheckDeltas::StopChecking()
{
	PostMessage( m_pDlg->m_hWnd, WM_COMMAND, IDC_FILE, 0 );
	SuspendThread();
}

BOOL CCheckDeltas::NextDelta()
{
	if ( DeltasToCheckPos == NULL )
		return FALSE;

	return TRUE;
}

BOOL CBadDeltasDlg::OnCommand(WPARAM wParam, LPARAM lParam) 
{
	if ( wParam == IDC_FILE ) {
		DeltaManager -> Check();

		if ( DeltaManager -> BadDeltas -> getCount()) {
			CString	aTitle;
			aTitle.LoadString( IDS_DELTATITLEHEADER );
			m_pDeltas.InsertColumn( 0, aTitle, LVCFMT_LEFT, 100 );
			aTitle.LoadString( IDS_PARTDESC );
			m_pDeltas.InsertColumn( 1, aTitle, LVCFMT_LEFT, 180 );

			if ( true )
				TimeLog( IDS_BADDELTASLOG );

			for ( short I = 0; I < DeltaManager -> BadDeltas -> getCount(); I++ ) {
				CString	atI( DeltaManager -> BadDeltas -> at( I ));
				atI = atI.Mid( atI.ReverseFind( '\\' ) + 1 );
				m_pDeltas.InsertItem( LVIF_TEXT|LVIF_STATE, I, atI, 0, LVIS_SELECTED, 0, 0 );
				CString aDesc( DeltaManager -> BadDescs -> at( I ));
				m_pDeltas.SetItemText( I, 1, aDesc );

				if ( true ) {
					CString aLogString = atI;
					aLogString += ": ";
					aLogString += aDesc;
					aLogString += "\n";
					Log( aLogString.GetBuffer( 0 ));
				}
			}
			Log( "\n" );
			m_pProgress.ShowWindow( FALSE );
			m_pCount.ShowWindow( FALSE );
			m_pResult.ShowWindow( TRUE );
			m_pDeltas.ShowWindow( TRUE );
			m_pBack.EnableWindow( TRUE );
			m_pNext.EnableWindow( TRUE );
			m_pHelp.EnableWindow( TRUE );

			if ( SilentMode ) {
				global_return_code = 2;
				EndDialog( IDOK );
			}
		}
		else
			EndDialog( IDOK );
	}

	return CDialog::OnCommand(wParam, lParam);
}

BOOL CBadDeltasDlg::StartChecking()
{
	pThread = new CCheckDeltas();
	pThread -> m_pThreadParams = NULL;
	if ( !pThread -> CreateThread( CREATE_SUSPENDED ))
	{
		delete pThread;
		return FALSE;
	}

	WORD	aDeltaFiles = 0;
	char	aDeltaFileMask[ MAX_PATH ];
	MakePath( aDeltaFileMask, DeltaPath, "*.D*" );
	WIN32_FIND_DATA	findData;
	HANDLE	aFindResult = FindFirstFile( aDeltaFileMask, &findData );
	while ( aFindResult != INVALID_HANDLE_VALUE )
	{
		if ( ( findData.dwFileAttributes & FILE_ATTRIBUTE_DIRECTORY ) == 0 )
		{
			aDeltaFiles++;
			char	aDeltaFileName[ MAX_PATH ];
			MakePath( aDeltaFileName, DeltaPath, findData.cFileName );
			pThread -> AddDeltaToCheck( aDeltaFileName );
		}

		if ( !FindNextFile( aFindResult, &findData ))
			break;
	}
	FindClose( aFindResult );	

	CString	aCount;
	aCount.Format( IDS_DELTASTOCHECK, aDeltaFiles );
	m_pCount.SetWindowText( aCount );	
	m_pProgress.SetRange( 0, aDeltaFiles );

	pThread -> m_pDlg = this;
	pThread -> StartChecking();

	VERIFY(pThread->SetThreadPriority(THREAD_PRIORITY_IDLE));
	pThread->ResumeThread();

	return	TRUE;
}

void CCheckDeltas::AddDeltaToCheck(CString aDeltaFileName)
{
	DeltasToCheck.AddTail( aDeltaFileName );	
}

void CBadDeltasDlg::OnHelp() 
{
#ifdef	_GCD_CLIENT
	theApp.Help( "page-upd_order_detect.htm" );
#else
	CDialog::OnHelp();
#endif
}
