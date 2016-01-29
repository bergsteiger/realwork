// CopyFiles.cpp : implementation file
//

#include "stdafx.h"
#include "Update.h"
#include "Utils.h"
#include "CopyFiles.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CCopyFilesDlg dialog


CCopyFilesDlg::CCopyFilesDlg( int aTitleID, CWnd* pParent /*=NULL*/)
	: CDialog(CCopyFilesDlg::IDD, pParent)
{
	//{{AFX_DATA_INIT(CCopyFilesDlg)
	//}}AFX_DATA_INIT
	TitleID = aTitleID;
}

void CCopyFilesDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CCopyFilesDlg)
	DDX_Control(pDX, IDC_FILEPROGRESS, m_pProgress);
	//}}AFX_DATA_MAP
}


BEGIN_MESSAGE_MAP(CCopyFilesDlg, CDialog)
	//{{AFX_MSG_MAP(CCopyFilesDlg)
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CCopyFilesDlg message handlers

BOOL CCopyFilesDlg::OnInitDialog() 
{
	CDialog::OnInitDialog();

	HICON m_hIcon = AfxGetApp()->LoadIcon(IDR_MAINFRAME);
	SetIcon(m_hIcon, TRUE);
	SetIcon(m_hIcon, FALSE);

	if ( StartCopying())
		return TRUE;
	else
	{
		EndDialog( IDCANCEL );
		return FALSE;
	}
}

BOOL CCopyFilesDlg::OnCommand(WPARAM wParam, LPARAM lParam) 
{
	if ( wParam == IDC_FILE )
		EndDialog( pThread -> WasErrors ? IDCANCEL : IDOK );
	
	return CDialog::OnCommand(wParam, lParam);
}


void CCopyFilesDlg::OnCancel() 
{
	pThread -> SuspendThread();
	if ( YesNoBox( IDS_SURECANCELCOPY ))
	{
		pThread -> WasErrors=TRUE;
		pThread -> ResumeThread();
		pThread -> StopCopying();
	}
	else
		pThread -> ResumeThread();
}


void CCopyFilesDlg::AddSourceFile( CString aFileName )
{
	SourceFileNames.AddTail( aFileName );
}

void CCopyFilesDlg::AddDestFile( CString aFileName )
{
	DestFileNames.AddTail( aFileName );
}

void CCopyFilesDlg::AddCanBeNewFile( CString aFileName )
{
	CanBeNewFiles.AddTail( aFileName );
}

BOOL	CCopyFilesDlg::StartCopying()
{
	pThread = new CCopyFiles();
	pThread -> m_pThreadParams = NULL;
	if ( !pThread -> CreateThread( CREATE_SUSPENDED ))
	{
		delete pThread;
		return FALSE;
	}

	LONGLONG	aTotalLen = 0;
	POSITION	aPos;
	for( aPos = SourceFileNames.GetHeadPosition(); aPos != NULL; )   
		aTotalLen += FileSize( SourceFileNames.GetNext( aPos ));

	for( aPos = SourceFileNames.GetHeadPosition(); aPos != NULL; )   
		pThread -> AddSourceFile( SourceFileNames.GetNext( aPos ));
	for( aPos = DestFileNames.GetHeadPosition(); aPos != NULL; )   
		pThread -> AddDestFile( DestFileNames.GetNext( aPos ));

	m_pProgress.SetRange32( 0, (int)( aTotalLen / 1024l ));
	pThread->m_pDlg = this;
	pThread->TitleID = TitleID;

	pThread -> StartCopying();

	VERIFY(pThread->SetThreadPriority(THREAD_PRIORITY_IDLE));
	pThread->ResumeThread();

	return	TRUE;
}

#define	PORTION	65536

/////////////////////////////////////////////////////////////////////////////
// CCopyFiles

IMPLEMENT_DYNCREATE(CCopyFiles, CWinThread)

CCopyFiles::CCopyFiles()
{
	m_hEventKill = CreateEvent( NULL, TRUE, FALSE, NULL );
	WasErrors = FALSE;
}

CCopyFiles::~CCopyFiles()
{
	CloseHandle( m_hEventKill );
}

BOOL CCopyFiles::InitInstance()
{
	while ( WaitForSingleObject( m_hEventKill, 0 ) == WAIT_TIMEOUT )
		Step();

	return FALSE;
}

BEGIN_MESSAGE_MAP(CCopyFiles, CWinThread)
	//{{AFX_MSG_MAP(CCopyFiles)
		// NOTE - the ClassWizard will add and remove mapping macros here.
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CCopyFiles message handlers

void	CCopyFiles :: KillThread()
{
	VERIFY(SetEvent(m_hEventKill));
	SetThreadPriority(THREAD_PRIORITY_ABOVE_NORMAL);
}

void CCopyFiles::AddSourceFile( CString aFileName )
{
	SourceFileNames.AddTail( aFileName );
}

void CCopyFiles::AddDestFile(CString aFileName)
{
	DestFileNames.AddTail( aFileName );
}

void CCopyFiles::StartCopying()
{
	SourceFileNamesPos = SourceFileNames.GetHeadPosition();
	DestFileNamesPos = DestFileNames.GetHeadPosition();
	Buffer = VirtualAlloc( NULL, PORTION, MEM_COMMIT, PAGE_READWRITE );

	if ( !NextFile() )
		StopCopying();
}

void	CCopyFiles :: Step()
{
	if ( WasErrors )
		return ;
	// наверно, не надо, поскольку это на случай, если в диалоге нажали Cancel,
	// после чего ResumeThread() и сразу CancelCopying(). Вопрос, успеет ли
	// вызваться Step или он по определению после этого не вызывается?

	DWORD	aBytesRead, aBytesWrite;
cycleRead:
	if ( !ReadFile( FileToRead, Buffer, PORTION, &aBytesRead, NULL ))
		if ( YesNoBox( IDS_ERROROPENINGFILE, IDS_CONFIRM, IDI_BEHAND, SourceFileName.Mid( SourceFileName.ReverseFind( '\\' ) + 1 )))
			goto cycleRead;
		else
		{
			CloseHandle( FileToRead );
			CloseHandle( FileToWrite );
			FileToRead = FileToWrite = 0;
			MyDeleteFile( DestFileName );
			WasErrors = TRUE;
			StopCopying();
			return;
		}

	if ( aBytesRead )
	{
cycleWrite:
		if ( !WriteFile( FileToWrite, Buffer, aBytesRead, &aBytesWrite, NULL ))
			if ( YesNoBox( IDS_ERRORWRITINGFILE, IDS_CONFIRM, IDI_BEHAND, DestFileName.Mid( DestFileName.ReverseFind( '\\' ) + 1 )))
				goto cycleWrite;
			else
			{
				CloseHandle( FileToRead );
				CloseHandle( FileToWrite );
				FileToRead = FileToWrite = 0;
				MyDeleteFile( DestFileName );
				WasErrors = TRUE;
				StopCopying();
				return;
			}

		m_pDlg->m_pProgress.SetPos( m_pDlg->m_pProgress.GetPos() + aBytesWrite / 1024l );
	}
	else
	{
		CloseHandle( FileToRead );
		CloseHandle( FileToWrite );
		m_pDlg->OkFiles.AddTail( SourceFileName );
		if ( !NextFile() )
			StopCopying();
	}
}

BOOL CCopyFiles::NextFile()
{
	FileToRead = FileToWrite = 0;

	if ( SourceFileNamesPos == NULL )
		return FALSE;

	SourceFileName = SourceFileNames.GetNext( SourceFileNamesPos );
	DestFileName = DestFileNames.GetNext( DestFileNamesPos );
	MyCreateDirectory( DestFileName.GetBuffer( 0 ));

cycleOpenRead:
	FileToRead = CreateFile( SourceFileName, GENERIC_READ, FILE_SHARE_READ, NULL, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL | FILE_FLAG_SEQUENTIAL_SCAN, NULL );
	if ( FileToRead == INVALID_HANDLE_VALUE )
	{
		if ( YesNoBox( IDS_ERROROPENINGFILE, IDS_CONFIRM, IDI_BEHAND, SourceFileName.Mid( SourceFileName.ReverseFind( '\\' ) + 1 )))
			goto cycleOpenRead;
		else
		{
			WasErrors = TRUE;
			return FALSE;
		}
	}

	BOOL	aRenamed = FALSE;
	BOOL	aNewFile = FALSE;
	CString	copyDestFileName = DestFileName;
cycleOpenWrite:
	FileToWrite = CreateFile( DestFileName, GENERIC_WRITE, FILE_SHARE_WRITE, NULL, CREATE_ALWAYS, 0, NULL );
	if ( FileToWrite == INVALID_HANDLE_VALUE )
	{
		if ( !aRenamed )
		{
			char	aOldFileName[ MAX_PATH ];
			ForceExt( strcpy( aOldFileName, DestFileName.GetBuffer( 0 )), "OLD" );
			if ( FileExist( aOldFileName ))
			{
				UINT	aFile = 0;
				do
				{
					char	aExt[ 16 ];
					sprintf( aExt, "OLD%d", aFile++ );
					ForceExt( aOldFileName, aExt );
				} while ( FileExist( aOldFileName ));
			}
			TRY
			{
				CFile::Rename( DestFileName, aOldFileName );
			}				
			CATCH( CFileException, e )
			{
				if ( m_pDlg->CanBeNewFiles.Find( DestFileName ))
				{
					aNewFile = TRUE;
					ForceExt( aOldFileName, "NEW" );
					DestFileName = aOldFileName;

					DWORD	aAttrib = GetFileAttributes( DestFileName );
					if ( aAttrib & FILE_ATTRIBUTE_READONLY )
						SetFileAttributes( DestFileName, aAttrib & !FILE_ATTRIBUTE_READONLY );

					MyDeleteFile( DestFileName );
				}
				aRenamed = TRUE;
				goto cycleOpenWrite;
			}
			END_CATCH
			aRenamed = TRUE;
			m_pDlg->RenamedFiles.AddTail( aOldFileName );
			goto cycleOpenWrite;
		}

		if ( YesNoBox( IDS_ERRORCREATINGFILE, IDS_CONFIRM, IDI_BEHAND, DestFileName.Mid( DestFileName.ReverseFind( '\\' ) + 1 )))
			goto cycleOpenWrite;
		else
		{
			WasErrors = TRUE;
			return FALSE;
		}
	}

	if ( aNewFile && aRenamed )
		m_pDlg->CanBeNewFiles.RemoveAt( m_pDlg->CanBeNewFiles.Find( copyDestFileName ));

	CString aTitle;
	aTitle.Format( TitleID, SourceFileName.Mid( SourceFileName.ReverseFind( '\\' ) + 1 ));
	m_pDlg->SetWindowText( aTitle );
	ProgressPos = m_pDlg->m_pProgress.GetPos();

	return TRUE;
}

void CCopyFiles::StopCopying()
{
	if ( FileToRead ) CloseHandle( FileToRead );
	if ( FileToWrite ) CloseHandle( FileToWrite );
	VirtualFree( Buffer, PORTION, MEM_DECOMMIT );
	PostMessage( m_pDlg->m_hWnd, WM_COMMAND, IDC_FILE, 0 );
	SuspendThread();
}

BOOL CCopyFiles::YesNoBox( UINT aMessageID, UINT aTitleID, UINT aIconID, CString aAdd )
{
	m_pDlg->EnableWindow( FALSE );
	BOOL aResult = ::YesNoBox( aMessageID, aTitleID, aIconID, aAdd );
	m_pDlg->EnableWindow();
	return aResult;
}
