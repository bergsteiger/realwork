// CollectParts.cpp : implementation file
//

#include "stdafx.h"
#include "Update.h"
#include "CollectParts.h"
#include "Utils.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

extern	char	DeltaPath[ MAX_PATH ];
extern	BOOL	SilentMode;
extern	CUpdateApp		theApp;

/////////////////////////////////////////////////////////////////////////////
// CCollectPartsDlg dialog

CCollectPartsDlg::CCollectPartsDlg(CWnd* pParent /*=NULL*/)
	: CDialog(CCollectPartsDlg::IDD, pParent)
{
	//{{AFX_DATA_INIT(CCollectPartsDlg)
	//}}AFX_DATA_INIT
	WasErrors = FALSE;
	ThreadFinished = FALSE;
	WasCanceled = FALSE;
}

void CCollectPartsDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CCollectPartsDlg)
	DDX_Control(pDX, ID_HELP, m_pHelp);
	DDX_Control(pDX, IDC_PARTSCOUNT, m_pPartsCount);
	DDX_Control(pDX, IDC_ARCHIVE, m_pArchive);
	DDX_Control(pDX, IDC_PARTS, m_pParts);
	DDX_Control(pDX, IDC_WASERROR, m_pResult);
	DDX_Control(pDX, IDOK, m_pNext);
	DDX_Control(pDX, IDBACK, m_pBack);
	DDX_Control(pDX, IDC_FILESPROGRESS, m_pFilesProgress);
	DDX_Control(pDX, IDC_FILEPROGRESS, m_pProgress);	
	//}}AFX_DATA_MAP
}


BEGIN_MESSAGE_MAP(CCollectPartsDlg, CDialog)
	//{{AFX_MSG_MAP(CCollectPartsDlg)
	ON_BN_CLICKED(IDBACK, OnBack)
	ON_WM_PAINT()
	ON_BN_CLICKED(ID_HELP, OnHelp)
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CCollectPartsDlg message handlers

BOOL CCollectPartsDlg::OnCommand(WPARAM wParam, LPARAM lParam) 
{
	if ( wParam == IDC_FILE )
	{
		WasErrors = pThread -> WasErrors;
		ThreadFinished = TRUE;
		if ( WasErrors || pThread -> MissingFileNames -> getCount() > 0 )
			Finalize();
		else
			EndDialog( IDOK );
	}

	return CDialog::OnCommand(wParam, lParam);
}

BOOL CCollectPartsDlg::OnInitDialog() 
{
	CDialog::OnInitDialog();

	HICON m_hIcon = AfxGetApp()->LoadIcon(IDR_MAINFRAME);
	SetIcon(m_hIcon, TRUE);
	SetIcon(m_hIcon, FALSE);

	if ( !StartCopying())
	{
		WasErrors = TRUE;
		Finalize();		
	}

	return TRUE;
}

BOOL CCollectPartsDlg::StartCopying()
{	
	pThread = new CCollectParts();
	pThread -> m_pThreadParams = NULL;
	if ( !pThread -> CreateThread( CREATE_SUSPENDED ))
	{
		delete pThread;
		ThreadFinished = TRUE;
		return FALSE;
	}

	short	aFilesCount = 0;
	WIN32_FIND_DATA	findData;
	char	aPartFileMask[ MAX_PATH ];
	MakePath( aPartFileMask, DeltaPath, "*.*" );
	HANDLE	aFindResult = FindFirstFile( aPartFileMask, &findData );
	while( aFindResult != INVALID_HANDLE_VALUE )
	{
		if ( ( findData.dwFileAttributes & FILE_ATTRIBUTE_DIRECTORY ) == 0 )
		{
			char	aPartFileName[ MAX_PATH ];
			MakePath( aPartFileName, DeltaPath, findData.cFileName );
			pThread->AddFileToCheck( aPartFileName );
			aFilesCount++;
		}

		if ( !FindNextFile( aFindResult, &findData ))
			break;
	}
	FindClose( aFindResult );
	m_pFilesProgress.SetRange( 0, aFilesCount );
	CString	aFilesCountString;
	aFilesCountString.Format( IDS_FILESTOCHECK, aFilesCount );
	m_pPartsCount.SetWindowText( aFilesCountString );

	pThread->m_pDlg = this;
	pThread->StartCopying();

	VERIFY(pThread->SetThreadPriority(THREAD_PRIORITY_IDLE));
	pThread->ResumeThread();

	return	TRUE;
}

void CCollectPartsDlg::OnCancel() 
{
	pThread -> SuspendThread();
	if ( YesNoBox( ThreadFinished ? IDS_SUREEXIT : IDS_SURECANCELCOLLECT, this ))
	{
		if ( ThreadFinished )
		{
			EndDialog( IDCANCEL );
			CDialog::OnCancel();
		}
		else
		{
			ThreadFinished = TRUE;
			WasCanceled = TRUE;
			Finalize();
		}
	}
	else
		pThread -> ResumeThread();
}

#define	PORTION	65536

/////////////////////////////////////////////////////////////////////////////
// CCollectParts

IMPLEMENT_DYNCREATE(CCollectParts, CWinThread)

CCollectParts::CCollectParts()
{
	m_hEventKill = CreateEvent( NULL, TRUE, FALSE, NULL );
	WasErrors = FALSE;
	Buffer = VirtualAlloc( NULL, PORTION, MEM_COMMIT, PAGE_READWRITE );
	CheckedFileNames = new TStringCollection( 5,5 );
	MissingFileNames = new TStringCollection( 5,5 );
	MissingFileDescs = new TStringCollection( 5,5 );
}

CCollectParts::~CCollectParts()
{
	CloseHandle( m_hEventKill );
	delete CheckedFileNames;
	delete MissingFileNames;
	delete MissingFileDescs;
}

BOOL CCollectParts::InitInstance()
{
	while ( WaitForSingleObject( m_hEventKill, 0 ) == WAIT_TIMEOUT )
		Step();

	return FALSE;
}

BEGIN_MESSAGE_MAP(CCollectParts, CWinThread)
	//{{AFX_MSG_MAP(CCollectParts)
		// NOTE - the ClassWizard will add and remove mapping macros here.
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CCollectParts message handlers

void CCollectParts::AddPartFile(CString aPartFileName)
{
	PartFileNames.AddTail( aPartFileName );
}

void CCollectParts::SetDestFile(CString aDestFileName, DWORD aDestFileSize)
{
	DestFileName = aDestFileName;
	DestFileSize = aDestFileSize;
}

void CCollectParts::KillThread()
{
	VERIFY(SetEvent(m_hEventKill));
	SetThreadPriority(THREAD_PRIORITY_ABOVE_NORMAL);
}

void CCollectParts::StartCopying()
{
	FindPhase = TRUE;
	CheckFileNamesPos = FilesToCheck.GetHeadPosition();
}

void CCollectParts::StopCopying()
{
	VirtualFree( Buffer, PORTION, MEM_DECOMMIT );
	PostMessage( m_pDlg->m_hWnd, WM_COMMAND, IDC_FILE, 0 );
	SuspendThread();
}

BOOL CCollectParts::NextFile()
{
	if ( PartFileNamesPos == NULL )
		return FALSE;

	PartFileName = PartFileNames.GetNext( PartFileNamesPos );

cycleOpenRead:
	FileToRead = CreateFile( PartFileName, GENERIC_READ, FILE_SHARE_READ, NULL, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL | FILE_FLAG_SEQUENTIAL_SCAN, NULL );
	if ( FileToRead == INVALID_HANDLE_VALUE )
	{
		if ( YesNoBox( IDS_ERROROPENINGFILE, IDS_CONFIRM, IDI_BEHAND, PartFileName.Mid( PartFileName.ReverseFind( '\\' ) + 1 ), m_pDlg ))
			goto cycleOpenRead;
		else
		{
			WasErrors = TRUE;
			return FALSE;
		}
	}

	DWORD	aBytesRead;	
	ReadFile( FileToRead, Buffer, 24, &aBytesRead, NULL );

	return TRUE;
}

BOOL	IsPartFile( char *aFileName )
{
	FILE	*aFile = fopen( aFileName, "rb" );
	if ( aFile )
	{
		char	aSignature[ 5 ];
		fread( aSignature, 4,1, aFile );
		aSignature[ 4 ] = '\0';
		fclose( aFile );
		return stricmp( aSignature, "DELT" ) == 0;
	}
	else
		return FALSE;
}

void	CCollectParts::CheckPartFile( char *aFileName )
{
	if ( !IsPartFile( aFileName ))
		return ;

	CString	aDesc;			

	bool	aBadName = FALSE;
	char	aShortName[ MAX_PATH ];
	strcpy( aShortName, strrchr( aFileName, '\\' ) + 1 );
	char* aDotPos = strchr( aShortName, '.' );
	if ( !aDotPos )
		aBadName = TRUE;
	else {
		aDotPos = strchr( aDotPos + 1, '.' );
		if ( aDotPos )
			aBadName = TRUE;
	}
	
	if ( aBadName ) {
		MissingFileNames->add(newStr(strrchr(aFileName,'\\')+1));
		aDesc.LoadString( IDS_BADTOMFILE );
		MissingFileDescs->add(newStr( aDesc.GetBuffer( 0 )));
		return ;
	}

	long	aNextPart;
	long	aPrevPart;
	long	aPart;
	DWORD	aPartSize;
	FILE	*aFile = fopen( aFileName, "rb" );
	if ( aFile ) {
		fread( &aNextPart, sizeof( long ),1, aFile ); // skip signature
		fread( &aNextPart, sizeof( long ),1, aFile );
		fread( &aPrevPart, sizeof( long ),1, aFile );
		fread( &aPart,     sizeof( long ),1, aFile );
		fread( &aPartSize, sizeof( long ),1, aFile );
		fclose( aFile );

		if ( aNextPart != -1 && NeededExtensions -> indexOf( aNextPart ) == -1 && CheckedExtensions -> indexOf( aNextPart ) == -1 ) {
			NeededExtensions -> add( newLong( aNextPart ));
			aDesc.LoadString( IDS_PARTABSENT );
			NeededDescs -> add( newStr( aDesc.GetBuffer( 0 )));
		}
		if ( aPrevPart != -1 && NeededExtensions -> indexOf( aPrevPart ) == -1 && CheckedExtensions -> indexOf( aPrevPart ) == -1 ) {
			NeededExtensions -> add( newLong( aPrevPart ));
			aDesc.LoadString( IDS_PARTABSENT );
			NeededDescs -> add( newStr( aDesc.GetBuffer( 0 )));
		}
		if ( FileSize( aFileName ) - 24l == aPartSize ) {
			countCheckedFiles++;
			CheckedExtensions -> add( newLong( aPart ));
			short aIndex = NeededExtensions -> indexOf( aPart );
			if ( aIndex != -1 ) {
				NeededExtensions -> atFree( aIndex );
				NeededDescs -> atFree( aIndex );
			}
		} else {
			short	aIndex = NeededExtensions -> indexOf( aPart );
			if ( aIndex != -1 ) {
				NeededExtensions -> atFree( aIndex );
				NeededDescs -> atFree( aIndex );
			}
			NeededExtensions -> add( newLong( aPart ));
			aDesc.LoadString( IDS_PARTNOTFULL );
			NeededDescs -> add( newStr( aDesc.GetBuffer( 0 )));
		}
	}
}

void	CCollectParts::CheckPartFiles( char *aFileName )
{
	if ( !IsPartFile( aFileName ))
	{
		FindPhase = TRUE;
		return ;
	}

	char	aShortFileName[ 13 ];
	strcpy( aShortFileName, strrchr( aFileName, '\\' ) + 1 );
	if ( strrchr( aShortFileName, '.' ) != NULL ) *strrchr( aShortFileName, '.' ) = '\0';

	if ( CheckedFileNames -> indexOf( aShortFileName ) != -1 )
	{
		FindPhase = TRUE;
		return ;
	}

	// проверяем цепочку файлов с именем aShortFileName
	CheckedFileNames -> add( newStr( aShortFileName ));
	strcat( aShortFileName, ".*" );

	NeededExtensions = new TLongCollection( 5,5 );
	NeededDescs = new TStringCollection( 5, 5 );
	CheckedExtensions = new TLongCollection( 5,5 );
	countCheckedFiles = 0;

	char	aPartFileMask[ MAX_PATH ];
	WIN32_FIND_DATA	findData;
	MakePath( aPartFileMask, DeltaPath, aShortFileName );
	HANDLE	aFindResult = FindFirstFile( aPartFileMask, &findData );
	while( aFindResult != INVALID_HANDLE_VALUE )
	{
		if ( ( findData.dwFileAttributes & FILE_ATTRIBUTE_DIRECTORY ) == 0 )
		{
			char	aPartFileName[ MAX_PATH ];
			MakePath( aPartFileName, DeltaPath, findData.cFileName );
			CheckPartFile( aPartFileName );	
		}

		if ( !FindNextFile( aFindResult, &findData ))
			break;
	}
	FindClose( aFindResult );

	if ( countCheckedFiles && !NeededExtensions -> getCount())
	{
		char	aDestFileName[ MAX_PATH ];
		ForceExt( MakePath( aDestFileName, DeltaPath, CheckedFileNames -> at( CheckedFileNames -> getCount() - 1 )), "ZIP" );

		PartFileNames.RemoveAll();
		DestFileSize = 0;
		for ( long aFile = 0l; aFile < countCheckedFiles; aFile++ )
		{
			char	aPartFileName[ MAX_PATH ], aExt[ 4 ];
			MakePath( aPartFileName, DeltaPath, aShortFileName );
			ForceExt( aPartFileName, ltoa( aFile, aExt, 10 ));
			AddPartFile( aPartFileName );
			DestFileSize += FileSize( aPartFileName ) - 24;
		}
		DestFileName = aDestFileName;
		m_pDlg->m_pProgress.SetRange32( 0, DestFileSize );
		m_pDlg->m_pProgress.SetPos( 0 );
	}
	else
	{
		for ( short I = 0; I < NeededExtensions -> getCount(); I++ )
		{
			char	aAbsentFileName[ 13 ];
			sprintf( aAbsentFileName, "%s.%d", CheckedFileNames -> at( CheckedFileNames -> getCount() - 1 ), NeededExtensions -> at( I ));
			MissingFileNames -> add( newStr( aAbsentFileName ));
			MissingFileDescs -> add( newStr( NeededDescs -> at( I )));			
		}
		FindPhase = TRUE;
	}

	delete NeededExtensions;
	delete CheckedExtensions;
	delete NeededDescs;
}

void CCollectParts::Step()
{
	if ( FindPhase )
	{		
		if ( !CheckFileNamesPos )
		{
			StopCopying();
			return ;
		}

		m_pDlg->m_pProgress.ShowWindow( FALSE );
		m_pDlg->m_pArchive.ShowWindow( FALSE );

		CString	FileToCheckName = FilesToCheck.GetNext( CheckFileNamesPos );
		m_pDlg->m_pFilesProgress.SetPos( m_pDlg->m_pFilesProgress.GetPos()+1 );

		FindPhase = FALSE;
		CheckPartFiles( FileToCheckName.GetBuffer( 0 ));
		if ( !FindPhase )
		{
			m_pDlg->m_pProgress.ShowWindow( TRUE );
			m_pDlg->m_pArchive.ShowWindow( TRUE );

			PartFileNamesPos = PartFileNames.GetHeadPosition();

		cycleOpenWrite:
			FileToWrite = CreateFile( DestFileName, GENERIC_WRITE, FILE_SHARE_WRITE, NULL, CREATE_ALWAYS, 0, NULL );
			if ( FileToWrite == INVALID_HANDLE_VALUE )
			{
				if ( YesNoBox( IDS_ERRORCREATINGFILE, IDS_CONFIRM, IDI_BEHAND, DestFileName.Mid( DestFileName.ReverseFind( '\\' ) + 1 ), m_pDlg ))
					goto cycleOpenWrite;
				else
				{
					WasErrors = TRUE;
					FindPhase = TRUE;
				}
			}
			else
			if ( !NextFile() )
				FindPhase = TRUE;
		}
	}
	else
	{
		DWORD	aBytesRead, aBytesWrite;
	cycleRead:
		if ( !ReadFile( FileToRead, Buffer, PORTION, &aBytesRead, NULL ))
			if ( YesNoBox( IDS_ERROROPENINGFILE, IDS_CONFIRM, IDI_BEHAND, PartFileName.Mid( PartFileName.ReverseFind( '\\' ) + 1 ), m_pDlg ))
				goto cycleRead;
			else
			{
				CloseHandle( FileToRead );
				CloseHandle( FileToWrite );
				MyDeleteFile( DestFileName );
				WasErrors = TRUE;
				FindPhase = TRUE;
				return;
			}

		if ( aBytesRead )
		{
	cycleWrite:
			if ( !WriteFile( FileToWrite, Buffer, aBytesRead, &aBytesWrite, NULL ))
			{
				if ( YesNoBox( IDS_ERRORWRITINGFILE, IDS_CONFIRM, IDI_BEHAND, DestFileName.Mid( DestFileName.ReverseFind( '\\' ) + 1 ), m_pDlg ))
					goto cycleWrite;
				else
				{
					CloseHandle( FileToRead );
					CloseHandle( FileToWrite );
					MyDeleteFile( DestFileName );
					WasErrors = TRUE;
					FindPhase = TRUE;
					return ;
				}
			}

			m_pDlg -> m_pProgress.SetPos( m_pDlg -> m_pProgress.GetPos() + aBytesWrite );
			CString	aText;
			aText.Format( IDS_COLLECTPROGRESSTEXT, DestFileName.Mid( DestFileName.ReverseFind( '\\' ) + 1 ), (float)m_pDlg->m_pProgress.GetPos() / 1048576.0, (float)DestFileSize / 1048576.0 );
			m_pDlg->m_pArchive.SetWindowText( aText );
		}
		else
		{
			CloseHandle( FileToRead );
			if ( !NextFile() )
			{
				CloseHandle( FileToWrite );

				PartFileNamesPos = PartFileNames.GetHeadPosition();
				while ( PartFileNamesPos )
				{
					PartFileName = PartFileNames.GetNext( PartFileNamesPos );
					MyDeleteFile( PartFileName );

					/*
					char aNewPartFileName[ MAX_PATH ];
					MakePath( aNewPartFileName, DeltaPath, "Parts" );
					CreateDirectory( aNewPartFileName, NULL );
					strcat( strcat( aNewPartFileName, "\\" ), strrchr( PartFileName, '\\' ) + 1 );
					MyDeleteFile( aNewPartFileName );
					MoveFile( PartFileName, aNewPartFileName );
					*/
				}

				FindPhase = TRUE;
			}
		}
	}
}

void CCollectParts::AddFileToCheck(CString aFileToCheck)
{
	FilesToCheck.AddTail( aFileToCheck );
}

void CCollectPartsDlg::OnBack() 
{
	EndDialog( IDBACK );	
}

void CCollectPartsDlg::Finalize()
{
	m_pBack.EnableWindow( TRUE );
	m_pNext.EnableWindow( TRUE );
	m_pHelp.EnableWindow( TRUE );
	m_pFilesProgress.ShowWindow( FALSE );
	m_pPartsCount.ShowWindow( FALSE );
	m_pResult.ShowWindow( TRUE );
	m_pProgress.ShowWindow( FALSE );
	m_pArchive.ShowWindow( FALSE );

	if ( WasErrors )
	{
		CString	aResultText;
		aResultText.LoadString( IDS_COLLECTERRORS );
		m_pResult.SetWindowText( aResultText );
	}
	if ( pThread -> MissingFileNames -> getCount() > 0 )
	{
		CString aResultText;
		if ( WasErrors )
			aResultText.LoadString( IDS_COLLECTBADSANDERRORS );
		else
		if ( WasCanceled )
			aResultText.LoadString( IDS_COLLECTBADSANDCANCEL );
		else
			aResultText.LoadString( IDS_COLLECTBADS );

		m_pResult.SetWindowText( aResultText );
		CString	aTitle;
		aTitle.LoadString( IDS_PARTTITLE );
		m_pParts.InsertColumn( 0, aTitle, LVCFMT_LEFT, 100 );
		aTitle.LoadString( IDS_PARTDESC );		
		m_pParts.InsertColumn( 1, aTitle, LVCFMT_LEFT, 180 );

		for ( short I = 0; I < pThread -> MissingFileNames -> getCount(); I++ )
		{
			CString	atI( pThread -> MissingFileNames -> at( I ));
			m_pParts.InsertItem( LVIF_TEXT|LVIF_STATE, I, atI, 0, LVIS_SELECTED, 0, 0 );
			CString aDesc( pThread -> MissingFileDescs -> at( I ));
			m_pParts.SetItemText( I, 1, aDesc );
		}

		m_pParts.ShowWindow( TRUE );
	}
	else
	{
		CString aResultText;
		aResultText.LoadString( IDS_COLLECTCANCELED );
		m_pResult.SetWindowText( aResultText );
	}

	if ( SilentMode )
		EndDialog( IDOK );
}


void CCollectPartsDlg::OnHelp() 
{
#ifdef	GCD_CLIENT
	theApp.Help( "page-upd_order_detect.htm" );
#else
	CDialog::OnHelp();
#endif
}
