// UnzipDlg.cpp : implementation file
//

#include "stdafx.h"
#include "Update.h"
#include "UnzipDlg.h"
#include "Utils.h"
#include "InfoZip\\InfoZip.h"

#include "unzip60\\windll\\structs.h"
#include "unzip60\\windll\\decs.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

extern	char	DeltaPath[ MAX_PATH ];
extern	BOOL	ZipErrors;
extern	BOOL	SilentMode;
extern	CStringList	Archives;
extern	CUpdateApp	theApp;
extern	void	Log( char* );

/////////////////////////////////////////////////////////////////////////////
// CUnzipDlg dialog

int WINAPI password (LPSTR p, int n, LPCSTR m, LPCSTR name)
{
	return 1;
}

int WINAPI DisplayBuf (LPSTR buf, unsigned long size)
{
	//printf("%s", (char *)buf);
	return (int)(unsigned int) size;
}

int WINAPI GetReplaceDlgRetVal (LPSTR filename, unsigned fnbufsiz)
{
	return 1;
}

typedef const UzpVer * (WINAPI * _DLL_UZVER)(void);
typedef int (WINAPI * _DLL_UNZIP)(int, char **, int, char **, LPDCL, LPUSERFUNCTIONS);

CUnzipDlg::CUnzipDlg(CWnd* pParent /*=NULL*/)
	: CDialog(CUnzipDlg::IDD, pParent)
{
	//{{AFX_DATA_INIT(CUnzipDlg)
		// NOTE: the ClassWizard will add member initialization here
	//}}AFX_DATA_INIT
	WasErrors = FALSE;
	ThreadFinished = FALSE;
	WasCanceled = FALSE;
}


void CUnzipDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CUnzipDlg)
	DDX_Control(pDX, ID_HELP, m_pHelp);
	DDX_Control(pDX, IDC_ZIPSPROGRESS, m_pProgress);
	DDX_Control(pDX, IDC_ZIPSCOUNT, m_pCount);
	DDX_Control(pDX, IDC_WASERROR, m_pError);
	DDX_Control(pDX, IDC_BADZIPS, m_pBadZips);
	DDX_Control(pDX, IDOK, m_pNext);
	DDX_Control(pDX, IDBACK, m_pBack);
	//}}AFX_DATA_MAP
}


BEGIN_MESSAGE_MAP(CUnzipDlg, CDialog)
	//{{AFX_MSG_MAP(CUnzipDlg)
	ON_BN_CLICKED(IDBACK, OnBack)
	ON_WM_PAINT()
	ON_BN_CLICKED(ID_HELP, OnHelp)
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CUnzipDlg message handlers

BOOL CUnzipDlg::OnInitDialog() 
{
	CDialog::OnInitDialog();

	HICON m_hIcon = AfxGetApp()->LoadIcon(IDR_MAINFRAME);
	SetIcon(m_hIcon, TRUE);
	SetIcon(m_hIcon, FALSE);

	if ( !StartUnzip())	{
		WasErrors = TRUE;
		Finalize();		
	}

	return TRUE;
}

void CUnzipDlg::OnCancel() 
{
	pThread -> SuspendThread();
	if ( YesNoBox( ThreadFinished ? IDS_SUREEXIT : IDS_SURECANCELUNZIP, this )) {
		if ( ThreadFinished ) {
			EndDialog( IDCANCEL );
			CDialog::OnCancel();
		} else {
			ThreadFinished = TRUE;
			WasCanceled = TRUE;
			Finalize();
		}
	}
	else
		pThread -> ResumeThread();
}

void CUnzipDlg::Finalize()
{
	m_pBack.EnableWindow( TRUE );
	m_pNext.EnableWindow( TRUE );
	m_pProgress.ShowWindow( FALSE );
	m_pCount.ShowWindow( FALSE );
	m_pError.ShowWindow( TRUE );
	m_pHelp.EnableWindow( TRUE );

	if ( pThread -> BadZips -> getCount() > 0 ) {
		CString aResultText;
		if ( WasCanceled )
			aResultText.LoadString( IDS_ZIPBADSANDCANCEL );
		else
			aResultText.LoadString( IDS_UNZIPERRORS );

		m_pError.SetWindowText( aResultText );
		Log (aResultText.GetBuffer (0));

		CString	aTitle;
		aTitle.LoadString( IDS_ZIPSTITLE );
		m_pBadZips.InsertColumn( 0, aTitle, LVCFMT_LEFT, 280 );

		for ( short I = 0; I < pThread -> BadZips -> getCount(); I++ ) {
			CString	atI( pThread -> BadZips -> at( I ));
			m_pBadZips.InsertItem( LVIF_TEXT|LVIF_STATE, I, atI, 0, LVIS_SELECTED, 0, 0 );
			Log (atI.GetBuffer (0));
		}
	
		m_pBadZips.ShowWindow( TRUE );
	} else {
		CString aResultText;
		aResultText.LoadString( IDS_UNZIPCANCELED );
		m_pError.SetWindowText( aResultText );
	}

	if ( SilentMode )
		EndDialog( IDOK );
}

BOOL CUnzipDlg::StartUnzip()
{
	pThread = new CUnzipFiles();
	pThread -> m_pThreadParams = NULL;
	if ( !pThread -> CreateThread( CREATE_SUSPENDED )) {
		delete pThread;
		return FALSE;
	}

	m_pProgress.SetRange( 0, 0 );
	if ( CheckForZips()) {
		pThread -> m_pDlg = this;
		pThread -> StartUnzip();

		VERIFY(pThread->SetThreadPriority(THREAD_PRIORITY_IDLE));
		pThread->ResumeThread();
	}
	else
		EndDialog( IDOK );

	return TRUE;
}
/////////////////////////////////////////////////////////////////////////////
// CUnzipFiles

IMPLEMENT_DYNCREATE(CUnzipFiles, CWinThread)

CUnzipFiles::CUnzipFiles()
{
	m_hEventKill = CreateEvent( NULL, TRUE, FALSE, NULL );
	BadZips = new TStringCollection( 5,5 );
	WasErrors = FALSE;
}

CUnzipFiles::~CUnzipFiles()
{
	CloseHandle( m_hEventKill );
	delete BadZips;
}

BOOL CUnzipFiles::InitInstance()
{
	while ( WaitForSingleObject( m_hEventKill, 0 ) == WAIT_TIMEOUT )
		Step();

	return FALSE;
}

BEGIN_MESSAGE_MAP(CUnzipFiles, CWinThread)
	//{{AFX_MSG_MAP(CUnzipFiles)
		// NOTE - the ClassWizard will add and remove mapping macros here.
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CUnzipFiles message handlers

void CUnzipFiles::KillThread()
{
	VERIFY(SetEvent(m_hEventKill));
	SetThreadPriority(THREAD_PRIORITY_ABOVE_NORMAL);
}

void CUnzipFiles::StartUnzip()
{
	ZipsPos = Zips.GetHeadPosition();
}

void CUnzipFiles::StopUnzip()
{
	PostMessage( m_pDlg->m_hWnd, WM_COMMAND, IDC_FILE, 0 );
	SuspendThread();
}

void CUnzipFiles::Step()
{
	if (!ZipsPos) {
		StopUnzip();
		return ;
	}

	CString	ZipFileName = Zips.GetNext (ZipsPos);

	/*
	CInfoZip InfoZip;

	if (!InfoZip.InitializeUnzip()) {
		EndWaitCursor();
		WasErrors = TRUE;
		BadZips -> add( newStr( strrchr( ZipFileName.GetBuffer( 0 ), '\\' ) + 1 ));
		return;
	}

	if (!InfoZip.ExtractFiles( ZipFileName, DeltaPath )) {
		EndWaitCursor();
		WasErrors = TRUE;
		BadZips -> add( newStr( strrchr( ZipFileName.GetBuffer( 0 ), '\\' ) + 1 ));
		return;
	}

	if (!InfoZip.FinalizeUnzip()) {
		EndWaitCursor();
		WasErrors = TRUE;
		BadZips -> add( newStr( strrchr( ZipFileName.GetBuffer( 0 ), '\\' ) + 1 ));
		return;
	}
	*/
	HINSTANCE hUnzipDll = LoadLibrary ("unzdll.dll");	
	if (hUnzipDll) {
		_DLL_UNZIP pWiz_SingleEntryUnzip = (_DLL_UNZIP) GetProcAddress (hUnzipDll, "Wiz_SingleEntryUnzip");
		if (pWiz_SingleEntryUnzip) {
			int infc = 0, exfc = 0;
			char **infv = 0, **exfv = 0;

			HANDLE hDCL = GlobalAlloc (GPTR, (DWORD) sizeof (DCL));
			LPDCL lpDCL = (LPDCL) GlobalLock (hDCL);
			lpDCL->StructVersID = UZ_DCL_STRUCTVER; /* version of this structure */
			lpDCL->ncflag = 0;              /* write to stdout if true */
			lpDCL->fQuiet = 2;              /* we want all messagesm, 1 = fewer messages, 2 = no messages */
			lpDCL->ntflag = 0;              /* test zip file if true */
			lpDCL->nvflag = 0;              /* give a verbose listing if true */
			lpDCL->nzflag = 0;              /* display zip file comment if true */
			lpDCL->ndflag = 1;              /* recreate directories != 0, skip "../" if < 2 */
			lpDCL->naflag = 0;              /* do not convert CR to CRLF */
			lpDCL->nfflag = 0;              /* do not freshen existing files only */
			lpDCL->noflag = 1;              /* over-write all files if true */
			lpDCL->nZIflag = 0;             /* no ZipInfo output mode */
			lpDCL->B_flag = 0;              /* do not backup existing files */
			lpDCL->C_flag = 0;              /* do not match case-insensitive */
			lpDCL->D_flag = 0;              /* restore all timestamps */
			lpDCL->U_flag = 0;              /* do not disable UTF-8 support */
			lpDCL->ExtractOnlyNewer = 0;    /* do not extract only newer */
			lpDCL->SpaceToUnderscore = 0;   /* do not convert space to '_' in filenames */
			lpDCL->PromptToOverwrite = 0;   /* "overwrite all" selected -> no query mode */
			lpDCL->lpszZipFN = ZipFileName.GetBuffer (0);
			lpDCL->lpszExtractDir = DeltaPath;

			HANDLE hUF = GlobalAlloc (GPTR, (DWORD) sizeof (USERFUNCTIONS));
			LPUSERFUNCTIONS lpUserFunctions = (LPUSERFUNCTIONS) GlobalLock (hUF);
			lpUserFunctions->password = password;
			lpUserFunctions->print = DisplayBuf;
			lpUserFunctions->sound = 0;
			lpUserFunctions->replace = GetReplaceDlgRetVal;
			lpUserFunctions->SendApplicationMessage = 0;

			int unzip_result = (*pWiz_SingleEntryUnzip)(infc, infv, exfc, exfv, lpDCL, lpUserFunctions);

			GlobalUnlock (lpUserFunctions);
			GlobalFree (hUF);
			GlobalUnlock (lpDCL);
			GlobalFree (hDCL);
			FreeLibrary (hUnzipDll);

			if (unzip_result != 0) {
				EndWaitCursor();
				WasErrors = TRUE;
				BadZips -> add( newStr( strrchr( ZipFileName.GetBuffer( 0 ), '\\' ) + 1 ));
			}
		} else {
			EndWaitCursor();
			WasErrors = TRUE;
			BadZips -> add( newStr( strrchr( ZipFileName.GetBuffer( 0 ), '\\' ) + 1 ));
		}
	} else {
		EndWaitCursor();
		WasErrors = TRUE;
		BadZips -> add( newStr( strrchr( ZipFileName.GetBuffer( 0 ), '\\' ) + 1 ));
	}

	if ( ZipErrors ) {
		WasErrors = TRUE;
		BadZips -> add( newStr( strrchr( ZipFileName.GetBuffer( 0 ), '\\' ) + 1 ));
	} else {
		char	aArchive[ MAX_PATH ];
		MakePath( aArchive, DeltaPath, "Archive" );
		CreateDirectory( aArchive, NULL );
		strcat( strcat( aArchive, "\\" ), strrchr( ZipFileName, '\\' ) + 1 );
		MyDeleteFile( aArchive );
		MoveFile( ZipFileName, aArchive );
		Archives.AddTail( aArchive );
		/*
		char	aBakFileName[ MAX_PATH ];		
		ForceExt( strcpy( aBakFileName, ZipFileName ), "BAK" );
		TRY {
			CFile::Rename( ZipFileName, aBakFileName );
			Archives.AddTail( aBakFileName );
		}
		CATCH( CFileException, e ){}
		END_CATCH
		*/
	}

	m_pDlg->CheckForZips();
	ZipsPos = Zips.Find( ZipFileName );
	Zips.GetNext( ZipsPos );

	m_pDlg->m_pProgress.SetPos( m_pDlg->m_pProgress.GetPos() + 1 );

	if ( !ZipsPos )
		StopUnzip();
}

BOOL CUnzipFiles::AddZip(CString aZipFileName)
{
	if ( !Zips.Find( aZipFileName )) {
		Zips.AddTail( aZipFileName );
		return TRUE;
	}
	else
		return FALSE;
}

BOOL CUnzipDlg::OnCommand(WPARAM wParam, LPARAM lParam) 
{
	if ( wParam == IDC_FILE ) {
		WasErrors = pThread -> WasErrors;
		ThreadFinished = TRUE;
		if ( WasErrors || pThread -> BadZips -> getCount() > 0 )
			Finalize();
		else
			EndDialog( IDOK );
	}

	return CDialog::OnCommand(wParam, lParam);
}

void CUnzipDlg::OnBack() 
{
	EndDialog( IDBACK );	
}

BOOL CUnzipDlg::CheckForZips()
{
	WORD	aNewZips  = 0;
	char	aZipFileMask[ MAX_PATH ];
	MakePath( aZipFileMask, DeltaPath, "*.ZIP" );
	WIN32_FIND_DATA	findData;
	HANDLE	aFindResult = FindFirstFile( aZipFileMask, &findData );
	while ( aFindResult != INVALID_HANDLE_VALUE ) {
		if ( ( findData.dwFileAttributes & FILE_ATTRIBUTE_DIRECTORY ) == 0 ) {
			char	aZipFileName[ MAX_PATH ];
			MakePath( aZipFileName, DeltaPath, findData.cFileName );
			if ( pThread->AddZip( aZipFileName ))
				aNewZips++;
		}

		if ( !FindNextFile( aFindResult, &findData ))
			break;
	}
	FindClose( aFindResult );

	if ( aNewZips ) {
		CString	aCount;
		int	nLower, nCount;
		m_pProgress.GetRange( nLower, nCount );
		nCount += aNewZips;
		aCount.Format( IDS_ZIPSTOUNZIP, nCount );
		m_pCount.SetWindowText( aCount );
		m_pProgress.SetRange( 0, nCount );
		return TRUE;
	}

	return FALSE;
}

void CUnzipDlg::OnHelp() 
{
#ifdef	_GCD_CLIENT
	theApp.Help( "page-upd_order_detect.htm" );
#else
	CDialog::OnHelp();
#endif

}
