// TryToOpenBases.cpp : implementation file
//

#include "stdafx.h"

#include "Utils.h"

BOOL IsFileOk(CString *pFileNameToCheck)
{
	char	aBuffer[ 100 ];
	BOOL	aRead = FALSE;
	DWORD	aBytes = 0;

	if ( !FileExist( pFileNameToCheck->GetBuffer( 0 )))
		return TRUE;

	HANDLE	aFile = CreateFile( *pFileNameToCheck, GENERIC_READ | GENERIC_WRITE, 0, NULL, OPEN_ALWAYS, FILE_ATTRIBUTE_ARCHIVE, NULL );
	if ( aFile != INVALID_HANDLE_VALUE )
	{
		DWORD	aSize = GetFileSize( aFile, NULL ); 
		aRead = ReadFile( aFile, aBuffer, 100, &aBytes, NULL );
		SetFilePointer( aFile, aSize, NULL, FILE_BEGIN );
		CloseHandle( aFile );
	}
	else
	{
		if ( stricmp( strrchr( *pFileNameToCheck, '.' ), ".NDT" ))
		{
			char aFileName[ MAX_PATH ];
			ForceExt( strcpy( aFileName, *pFileNameToCheck ), "$$$" );
			aRead = TRUE;
			TRY
			{
				CFile::Rename( *pFileNameToCheck, aFileName );
			}
			CATCH( CFileException, e )
			{
				aRead = FALSE;
			}
			END_CATCH
			if ( aRead )
			{
				TRY
				{
					CFile::Rename( aFileName, *pFileNameToCheck );
				}
				CATCH( CFileException, e )
				{
					CopyFile( aFileName, *pFileNameToCheck, FALSE );
				}
				END_CATCH	
			}
		}
	}
	return aRead;
}

#ifndef BRDR32
	#include "Update.h"
	#include "Protection.h"
	#include "TryToOpenBases.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

extern	COMPLECTINFO*	lpComplectInfo;
extern	char	DataPath[ MAX_PATH ];
extern	int	BasesCount();
extern	char*	BaseName( int );

/////////////////////////////////////////////////////////////////////////////
// CTryToOpenBasesDlg dialog


CTryToOpenBasesDlg::CTryToOpenBasesDlg(CWnd* pParent /*=NULL*/)
	: CDialog(CTryToOpenBasesDlg::IDD, pParent)
{
	//{{AFX_DATA_INIT(CTryToOpenBasesDlg)
		// NOTE: the ClassWizard will add member initialization here
	//}}AFX_DATA_INIT
	Success = FALSE;
}


void CTryToOpenBasesDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CTryToOpenBasesDlg)
	DDX_Control(pDX, IDC_PROGRESS, m_pProgress);
	//}}AFX_DATA_MAP
}


BEGIN_MESSAGE_MAP(CTryToOpenBasesDlg, CDialog)
	//{{AFX_MSG_MAP(CTryToOpenBasesDlg)
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CTryToOpenBasesDlg message handlers
/////////////////////////////////////////////////////////////////////////////
// CTryToOpenBases

IMPLEMENT_DYNCREATE(CTryToOpenBases, CWinThread)

CTryToOpenBases::CTryToOpenBases()
{
	m_hEventKill = CreateEvent( NULL, TRUE, FALSE, NULL );
	Success = FALSE;
}

CTryToOpenBases::~CTryToOpenBases()
{
	CloseHandle( m_hEventKill );
}

BOOL CTryToOpenBases::InitInstance()
{
	while ( WaitForSingleObject( m_hEventKill, 0 ) == WAIT_TIMEOUT )
		Step();

	return FALSE;
}

BEGIN_MESSAGE_MAP(CTryToOpenBases, CWinThread)
	//{{AFX_MSG_MAP(CTryToOpenBases)
		// NOTE - the ClassWizard will add and remove mapping macros here.
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CTryToOpenBases message handlers

void CTryToOpenBases::Step()
{
	if ( IsWaiting )
	{
		CTimeSpan aDelta = CTime::GetCurrentTime() - LastCheckTime;
		CTimeSpan aFromBegin = CTime::GetCurrentTime() - StartTime;
		m_pDlg->m_pProgress.SetPos( aFromBegin.GetTotalSeconds());
		if ( aDelta.GetTotalSeconds() > 20 )
		{
			if ( IsFileOk())
			{
				IsWaiting = FALSE;
				if ( !NextFile())
				{
					Success = TRUE;
					StopChecking();
				}
			}
			else
			{
				LastCheckTime = CTime::GetCurrentTime();
				if ( aFromBegin.GetTotalSeconds() > 300 )
					StopChecking();
			}
		}
	}
	else
	{
		if ( IsFileOk())
		{
			IsWaiting = FALSE;
			if ( !NextFile())
			{
				Success = TRUE;
				StopChecking();
			}
		}
		else
		{
			IsWaiting = TRUE;
			LastCheckTime = CTime::GetCurrentTime();
		}
	}
}

void CTryToOpenBases::KillThread()
{
	VERIFY(SetEvent(m_hEventKill));
	SetThreadPriority(THREAD_PRIORITY_ABOVE_NORMAL);
}

void CTryToOpenBases::AddFileToCheck(CString aFileToCheck)
{
	FilesToCheck.AddTail( aFileToCheck );
}

void CTryToOpenBases::StartChecking()
{
	FilesToCheckPos = FilesToCheck.GetHeadPosition();
	NextFile();
	StartTime = CTime::GetCurrentTime();
	IsWaiting = FALSE;
}

BOOL CTryToOpenBases::NextFile()
{
	if ( FilesToCheckPos == NULL )
		FileNameToCheck = "";
	else
		FileNameToCheck = FilesToCheck.GetNext( FilesToCheckPos );

	return !FileNameToCheck.IsEmpty();
}

void CTryToOpenBases::StopChecking()
{
	PostMessage( m_pDlg->m_hWnd, WM_COMMAND, IDC_FILE, 0 );
	SuspendThread();
}

BOOL CTryToOpenBasesDlg::StartChecking()
{
	pThread = new CTryToOpenBases();
	pThread -> m_pThreadParams = NULL;
	if ( !pThread -> CreateThread( CREATE_SUSPENDED ))
	{
		delete pThread;
		pThread = NULL;
		return FALSE;
	}

	char aBaseFileName[ MAX_PATH ];
	if ( lpComplectInfo -> ComplectSet )
	{
		MakePath( aBaseFileName, DataPath, lpComplectInfo -> ComplectName );
		ForceExt( aBaseFileName, "NDT" );
		pThread -> AddFileToCheck( aBaseFileName );
	}
	else for ( int I = 0; I < BasesCount(); I++ )
	{
		MakePath( aBaseFileName, DataPath, BaseName( I ));
		ForceExt( aBaseFileName, "NDT" );
		pThread -> AddFileToCheck( aBaseFileName );
	}

	POSITION aPos = MoreFilesToCheck.GetHeadPosition();
	while ( aPos != NULL )
		pThread -> AddFileToCheck( MoreFilesToCheck.GetNext( aPos ));

	m_pProgress.SetRange( 0, 300 );
	pThread -> m_pDlg = this;
	pThread -> StartChecking();

	VERIFY(pThread->SetThreadPriority(THREAD_PRIORITY_IDLE));
	pThread->ResumeThread();

	return	TRUE;
}

BOOL CTryToOpenBasesDlg::OnInitDialog() 
{
	CDialog::OnInitDialog();

	HICON m_hIcon = AfxGetApp()->LoadIcon(IDR_MAINFRAME);
	SetIcon(m_hIcon, TRUE);
	SetIcon(m_hIcon, FALSE);

	if ( !StartChecking())
	{
		EndDialog( IDCANCEL );
		return FALSE;
	}

	return TRUE;
}

BOOL CTryToOpenBasesDlg::OnCommand(WPARAM wParam, LPARAM lParam) 
{
	if ( wParam == IDC_FILE )
	{
		Success = pThread -> Success;
		EndDialog( Success ? IDOK : IDCANCEL );
	}

	return CDialog::OnCommand(wParam, lParam);
}

void CTryToOpenBasesDlg::OnCancel() 
{
	pThread -> SuspendThread();
	if ( YesNoBox( IDS_SURECANCELTRYEXIT, this ))
	{
		EndDialog( IDCANCEL );
		CDialog::OnCancel();
	}
	else
		pThread -> ResumeThread();
}

BOOL TryToOpenBases( CStringList* aMoreFiles )
{
	CTryToOpenBasesDlg tryToOpenBasesDlg;
	if ( aMoreFiles )
	{
		POSITION aPos = aMoreFiles->GetHeadPosition();
		while ( aPos )
			tryToOpenBasesDlg.AddFileToCheck( aMoreFiles->GetNext( aPos ));
	}
	return ( tryToOpenBasesDlg.DoModal() == IDOK );
}


void CTryToOpenBasesDlg::AddFileToCheck(CString aFileName)
{
	MoreFilesToCheck.AddTail( aFileName );
}

BOOL CTryToOpenBases::IsFileOk()
{
	return ::IsFileOk(&FileNameToCheck);
}
#endif
