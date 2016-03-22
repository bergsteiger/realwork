#include "stdafx.h"
#include "recode.h"

#if defined (_GCD_CLIENT) || defined (PILOT)
#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/Core/sys/start_stop.h"
#include "shared/Core/fix/wine.h"

#include "shared/Core/Params/Params.h"
#include "shared/Core/ParamsHelper/ParamConvert.h"

#include "garantServer/src/Global/Core/Common/GCMManagerHome.h"
#include "garantServer/src/Global/Core/Common/ParamManagerReg.h"
#include "garantServer/src/Business/GblPilot/Home/Client.h"
#include "garantServer/src/Services/GslHeartbeatManager/Home/Client.h"
#include "garantServer/src/Global/Defines/DefinesC.h"
#include "garantServer/src/Global/Defines/Common/ProjectConsts.h"
#include "garantServer/src/Global/Core/Common/AutoIPConfig.h"
#include "garantServer/src/Services/GslUserManager/Client/UserManagerClientHome.h"
#endif

//#include "stdbase.h"

#include <io.h>
#include <sys/stat.h>
#include <wininet.h>

#include "Utils.h"
#include "Update.h"
#include "LoginDlg.h"
#include "WelcomeDlg.h"
#include "FatalError.h"
#include "SelectDeltasFolder.h"
#include "Confirm.h"
#include "CopyFiles.h"
#include "Protection.h"
#include "DHReader.h"
#include "Collection.h"
#include "PartUpdate.h"
#include "CantUpdateDlg.h"
#include "FullUpdate.h"
#include "CollectParts.h"
#include "BadDeltasDlg.h"
#include "UnzipDlg.h"
#include "RunGUGLProgress.h"
#include "TryToOpenBases.h"
#include "SelectBackupFolder.h"

#if defined (_GCD_CLIENT)
#include "htmlhelp.h"
#include "SelectBaseFolder.h"
#include "SelectBaseFolderEx.h"
#include "SelectRemoteUpdateType.h"
#include "WaitServerDialog.h"
#include "WaitServer2Dialog.h"
#include "SelectRemoteType.h"
#include "SelectServerUpdateType.h"
#include "SelectMethod.h"
#include "garantServer/src/Services/GslDataPipe/Server/PipeManager_i.h"
#include "garantServer/src/Services/GslDataPipe/Server/Stream.h"

#include "shared/Internet/impl/Inet_i/Connect_i_factory.h"
#include "shared/Internet/impl/Inet_i/Connection_i_factory.h"
#include "shared/Internet/Manage/ConnectManager.h"
#include "shared/Internet/Inet/Inet.h"
#include "shared/GCL/alg/cryptography.h"

#include <shlwapi.h>

#define	SERVERNOTONTHISMACHINE	(false == GCM::is_server_running_on_that_mashine())
#endif

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

BEGIN_MESSAGE_MAP(CUpdateApp, CWinApp)
	//{{AFX_MSG_MAP(CUpdateApp)
	//}}AFX_MSG
	ON_COMMAND(ID_HELP, CWinApp::OnHelp)
END_MESSAGE_MAP()

CUpdateApp		theApp;
TDeltaManager	*DeltaManager = NULL;
PROTINFO        *lpProtInfo = NULL;
COMPLECTINFO    *lpComplectInfo = NULL;

bool	enable_gu_7tr_optimization = false;
bool	enable_gu_merge_optimization = false;
bool	extended_log = false;

char	GarantPath[ MAX_PATH ];
char	BasePath[ MAX_PATH ];
char	DeltaPath[ MAX_PATH ];
char	BackupPath[ MAX_PATH ];
char	DataPath[ MAX_PATH ];
char	GarantIni[ MAX_PATH ];
char	ResultFile[ MAX_PATH ];
HANDLE	UpdateHandle = 0;
BOOL	ZipErrors;
BOOL	BaseUpdated = FALSE;
char	Extensions[5][4] = { "NDT", "KEY", "STR", "ND0", "ST0" };
BOOL	MakeBackup = FALSE;
BOOL	SilentMode = FALSE;
BOOL	SilentBackup = FALSE;
BOOL	SilentDelta = FALSE;
BOOL	SkipMode = FALSE;
BOOL	FromDownload = FALSE;
BOOL	DeleteBackup = FALSE;
BOOL	DeleteZips = FALSE;
BOOL	NoDeleteBackup = FALSE;
BOOL	NoFinalMessage = FALSE;
BOOL	RestoreMode = FALSE;
BOOL	SkipWarning = FALSE;

bool	SyncBackup = false;
bool	RemoteUpdate = false;
bool	update_copy = false;

bool	bExtended = false;
bool	space_checked = false;
bool	b_isetalon = false;

UINT	UpdateRun = 1;
CString	GarantVersion;
CString	UpdateExe;
CStringList	Archives;

TShortCollection	baseInfoIds( 500, 50 );
TStringCollection	baseInfoNames( 500, 50 );

int	global_return_code = 1;
//0 - все хорошо, дельта применилась
//1 - пользователь вышел
//2 - вышел, но были плохие дельты
//3 - упало все нафик
//4 - не смогли скопировать базу или переключиться

#ifdef	_GCD_CLIENT
char	*m_llogin = NULL, *m_lpwd = NULL;
extern	GslDataPipe::FileReadingSet_var	gugl_fileset;

namespace FilesCoping {

class CopyProcessFailed {
};

class NotEnoughRoom {
};

}

volatile	bool	startWorking;
volatile	bool	endWorking;
volatile	int		write_files_to_disk_result = 0;
CWaitServerDialog*	waitDialog;
CWaitServer2Dialog*	wait2Dialog;
GslDataPipe::FileReadingSet_var	file_set;

DWORD write_files_to_disk (
		void* params /*const GslDataPipe::FileReadingSet& file_set, const std::string& data_path*/
	) throw (FilesCoping::CopyProcessFailed, FilesCoping::NotEnoughRoom)
{
#define TEST_FOR_ERROR(A)																					\
	if (!file) {																							\
		DWORD error_code = ::GetLastError ();																\
		if (112 == error_code) {																			\
			LOG_E (("::Write_file_to_disk: disk full!"));													\
			write_files_to_disk_result = 2;                                                                 \
			PostMessage( waitDialog->m_hWnd, WM_COMMAND, IDC_FILE, 0 );										\
			endWorking = true;																				\
			return 2;                                                                                       \
			/*throw FilesCoping::NotEnoughRoom ();*/														\
		} else {																							\
			LPVOID lpMsgBuf;																				\
			FormatMessage (																					\
				FORMAT_MESSAGE_ALLOCATE_BUFFER | FORMAT_MESSAGE_FROM_SYSTEM | FORMAT_MESSAGE_IGNORE_INSERTS	\
				, NULL																						\
				, error_code																				\
				, MAKELANGID(LANG_NEUTRAL, SUBLANG_DEFAULT)													\
				, (LPTSTR) &lpMsgBuf																		\
				, 0																							\
				, NULL																						\
			);																								\
			LOG_E (("::Write_file_to_disk: error in operation with %s %s", A, (LPCTSTR)lpMsgBuf));		\
			LocalFree (lpMsgBuf);																			\
			write_files_to_disk_result = 1;                                                                 \
			PostMessage( waitDialog->m_hWnd, WM_COMMAND, IDC_FILE, 0 );										\
			endWorking = true;																				\
			return 1;                                                                                       \
			/*throw FilesCoping::CopyProcessFailed ();*/													\
		}																									\
	}

	startWorking = true;
	endWorking = false;

	GCD::LifeCycleManager_var lcm = UpdateRunner::m_func_manager->get_life_cycle_manager ();
	for (CORBA::ULong i = 0; i < file_set->length (); i++) {
		char file_name[ MAX_PATH ];
		MakePath (file_name, DataPath, (char*)file_set[i].m_name.in ());
		std::ofstream file (file_name, std::ios_base::trunc | std::ios_base::out | std::ios_base::binary);
		TEST_FOR_ERROR(file_name);
		const CORBA::ULong PIPE_DATA_BLOCK_SIZE = 1024*1024;
		LOG_D (("::Write_file_to_disk: write to %s", file_name));
		__int64	file_size = file_set[i].m_data_reading->get_cur_data_size ();
		__int64 ok_write = 0;
		while (true) {
			GslDataPipe::PipeData_var pipe_data = file_set[i].m_data_reading->get_data (PIPE_DATA_BLOCK_SIZE);
			file.write ((const char*)pipe_data->get_buffer (), pipe_data->length ());
			TEST_FOR_ERROR(file_name);

			ok_write += pipe_data->length ();
			if ( ok_write == file_size ) {
				break;
			}

			if (PIPE_DATA_BLOCK_SIZE > pipe_data->length ()) {
				break;
			}

			ACE_OS::sleep (0);
		}
		file.close ();
		lcm->release_object (file_set[i].m_data_reading.in ());
	}

	write_files_to_disk_result = 0;
	PostMessage( waitDialog->m_hWnd, WM_COMMAND, IDC_FILE, 0 );
	endWorking = true;																				\
	return 1;
}

GslDataPipe::FileReadingSet* get_file_set (const std::string& base_path) {
	typedef std::pair<std::string, GslDataPipe::PipeManager_var> FileData;
	typedef std::vector<FileData> FileDataVector;

	_finddata_t find_data;
	char aMask[ MAX_PATH ];
	MakePath( aMask, (char*)base_path.c_str(), "data.*" );
	std::string mask (aMask);
	long find_file_handle = _findfirst (mask.c_str (), &find_data);
	FileDataVector pipe_managers;
	FileData fd;
	char file_name[ MAX_PATH ];
	for (long i = find_file_handle; i != -1; i = _findnext (find_file_handle, &find_data)) {
		if (strcmp (find_data.name, ".") == 0
				|| strcmp (find_data.name, "..") == 0
				|| stricmp (find_data.name, "data.lic") == 0
				|| find_data.attrib == _A_SUBDIR
			) {
			continue;
		}
		MakePath (file_name, (char*)base_path.c_str (), find_data.name);
		GslDataPipeServer::Stream* str = new GslDataPipeServer::FileStream (file_name);
		if (false == str->is_open ()) {
			for (FileDataVector::size_type j = 0; j < pipe_managers.size (); j++) {
				pipe_managers[j].second->close_pipe ();
			}
			delete str;
			printf ("::get_file_set: can't open %s\n", file_name);
			return NULL;
		}
		GslDataPipeServer::PipeManager_i* manager = new GslDataPipeServer::PipeManager_i (str, true);
		PortableServer::ObjectId_var oid = GCM::get_cached_root_poa()->activate_object (manager);
		CORBA::Object_var obj = GCM::get_cached_root_poa()->id_to_reference (oid);
		fd.second = GslDataPipe::PipeManager::_narrow (obj);
		fd.first = find_data.name;
		pipe_managers.push_back (fd);	
	}
	if (-1 != find_file_handle) {
		_findclose (find_file_handle);
	}
	if (0 == pipe_managers.size ()) {
		printf ("::get_file_set: no files in %s\n", base_path.c_str ());
		return NULL;
	}
	//
	static const char* DEALER_INF_FILE = "dealer.inf";
	MakePath (file_name, (char*)base_path.c_str (), (char*)DEALER_INF_FILE);
	GslDataPipeServer::Stream* str = new GslDataPipeServer::FileStream (file_name);
	if (true == str->is_open ()) {
		GslDataPipeServer::PipeManager_i* manager = new GslDataPipeServer::PipeManager_i (str, true);
		PortableServer::ObjectId_var oid = GCM::get_cached_root_poa()->activate_object (manager);
		CORBA::Object_var obj = GCM::get_cached_root_poa()->id_to_reference (oid);
		fd.second = GslDataPipe::PipeManager::_narrow (obj);
		fd.first = DEALER_INF_FILE;
		pipe_managers.push_back (fd);	
	} else {
		delete str;
	}
	//
	GslDataPipe::FileReadingSet_var file_set = new GslDataPipe::FileReadingSet ();
	file_set->length (pipe_managers.size ());
	for (FileDataVector::size_type j = 0; j < pipe_managers.size (); j++) {
		file_set[j].m_name = pipe_managers[j].first.c_str ();
		file_set[j].m_data_reading = pipe_managers[j].second->get_reading_interface ();
		file_set[j].m_data_reading->add_reference ();
	}
	return file_set._retn ();
}
#endif

__int64	space_for_update()
{
	__int64 result = 0;
	__int64 morpho_size = 0;
	__int64 size_for_tmp = 0;
	try {
		GCD::LifeCycleManager_var lcm = UpdateRunner::m_func_manager->get_life_cycle_manager ();
		GslDataPipe::FileReadingSet_var real_file_set = UpdateRunner::bu->get_base_files ();
		bool hasMorpho = false;
		for (CORBA::ULong i = 0; i < real_file_set->length (); i++) {
			char *ext = strrchr ((char*)real_file_set[i].m_name.in(), '.');
			if (ext) {
				ext++;
				if ((enable_gu_7tr_optimization && (*ext == '7' || *ext == '2')) || (!enable_gu_7tr_optimization && (*ext == '6' || *ext == '3' || *ext == '4' || *ext == '5')))
					morpho_size += real_file_set[i].m_data_reading->get_cur_data_size ();
				if (*ext == '6')
					size_for_tmp += real_file_set[i].m_data_reading->get_cur_data_size ();
			}			
			lcm->release_object (real_file_set[i].m_data_reading.in ());
		}
		real_file_set = 0;
		result = (morpho_size + (size_for_tmp / 10)) / 1024; //под tmp берем 10 процентов от размер турбоиндекса; для Супера это 8гб
	}
	catch(...){
	}
	return result;
}

__int64	base_size()
{
	__int64 result = 0;
	try {
		GCD::LifeCycleManager_var lcm = UpdateRunner::m_func_manager->get_life_cycle_manager ();
		GslDataPipe::FileReadingSet_var real_file_set = UpdateRunner::bu->get_base_files ();
		for (CORBA::ULong i = 0; i < real_file_set->length (); i++) {
			result += real_file_set[i].m_data_reading->get_cur_data_size ();
			lcm->release_object (real_file_set[i].m_data_reading.in ());
		}
		real_file_set = 0;
	}
	catch(...) {
	}
	result /= 1024;
	return result;
}

char*	BaseIdName( short aId )
{
	for ( short I = 0; I < baseInfoIds.getCount(); I++ )
		if ( baseInfoIds.at( I ) == aId )
			return baseInfoNames.at( I );
	baseInfoIds.add( newShort( aId ));
	char	sId[ 8 ]; ltoa( aId, sId, 10 );
	baseInfoNames.add( newStr( sId ));
	return baseInfoNames.at( baseInfoNames.getCount() - 1 );
}

char	GUDllFileName[ 12 ];

BOOL	PatchPresent()
{
	char	aPatchFileMask[ MAX_PATH ];
	MakePath( aPatchFileMask, DeltaPath, "PATCH*.INI" );
	return FileExist( aPatchFileMask );
}

#if defined (_GCD_CLIENT) || defined (PILOT)
UpdateRunner* aUpdateRunner = 0;
GslUserManager::UserManager_var UpdateRunner::um = 0;
GblPilot::BaseUpdate_var UpdateRunner::bu = 0;
GblPilot::FunctionMng_var UpdateRunner::m_func_manager = 0;
bool UpdateRunner::logged = false;

volatile	int		bu_remote_update_result;
CWaitServer1Dialog*	wait1Dialog;

DWORD	bu_remote_update( void* params )
{
	startWorking = true;
	endWorking = false;
	try {
		int updateType = *(int*)params;
		if ( updateType == 0 )
			UpdateRunner::bu->remote_update(file_set);
		else
			UpdateRunner::bu->remote_sync_update(file_set);
	}
	catch(GCD::AccessDenied) {
		bu_remote_update_result = 1;
		PostMessage( wait1Dialog->m_hWnd, WM_COMMAND, IDC_FILE, 0 );
		endWorking = true;
		return bu_remote_update_result;
	}
	catch(GCD::CopyProcessFailed) {
		bu_remote_update_result = 2;
		PostMessage( wait1Dialog->m_hWnd, WM_COMMAND, IDC_FILE, 0 );
		endWorking = true;
		return bu_remote_update_result;
	}
	catch(GCD::NotEnoughRoom) {
		bu_remote_update_result = 3;
		PostMessage( wait1Dialog->m_hWnd, WM_COMMAND, IDC_FILE, 0 );
		endWorking = true;
		return bu_remote_update_result;
	}
	catch(...) {
		bu_remote_update_result = 4;
		PostMessage( wait1Dialog->m_hWnd, WM_COMMAND, IDC_FILE, 0 );
		endWorking = true;
		return bu_remote_update_result;
	}

	bu_remote_update_result = 0;
	PostMessage( wait1Dialog->m_hWnd, WM_COMMAND, IDC_FILE, 0 );
	endWorking = true;
	return 0;
}

volatile	int		bu_update_start_result = 0;
volatile	int		bu_update_complete_result = 0;

DWORD	bu_update_complete( void* params )
{
	startWorking = true;
	endWorking = false;
	try {
		UpdateRunner::bu->update_complete ();
	}
	catch(GCD::InvalidDatastoreKey&) {
		global_return_code = 4;
		bu_update_complete_result = 4;
		PostMessage( wait2Dialog->m_hWnd, WM_COMMAND, IDC_FILE, 0 );
		endWorking = true;
		CString str = "Неизвестная ошибка";
		str.LoadString(IDS_MSG_94);
		FatalMessage( str );
		return bu_update_complete_result;
	}
	catch(CORBA::Exception& ex) {
		global_return_code = 4;
		bu_update_complete_result = 4;
		PostMessage( wait2Dialog->m_hWnd, WM_COMMAND, IDC_FILE, 0 );
		endWorking = true;
		CString str;
		str = CString("CORBA::Исключение ") + ex._rep_id();
		FatalMessage( str );
		return bu_update_complete_result;
	}
	catch(...) {
		global_return_code = 4;
		bu_update_complete_result = 4;
		PostMessage( wait2Dialog->m_hWnd, WM_COMMAND, IDC_FILE, 0 );
		endWorking = true;
		FatalMessage( "update_complete(): неизвестное исключение" );
		return bu_update_complete_result;
	}

	bu_update_complete_result = 0;
	global_return_code = 0;
	PostMessage( wait2Dialog->m_hWnd, WM_COMMAND, IDC_FILE, 0 );
	endWorking = true;
	return 0;
}

DWORD	bu_update_start( void* params )
{
	startWorking = true;
	endWorking = false;
	try {
		strcpy( BasePath, UpdateRunner::bu->update_start(true));
	}
	catch(GblPilot::UpdateAlreadyStarted&) {
		bu_update_start_result = 1;
		PostMessage( waitDialog->m_hWnd, WM_COMMAND, IDC_FILE, 0 );
		endWorking = true;
		return bu_update_start_result;
	}
	catch(GCD::NotEnoughRoom&){
		bu_update_start_result = 2;
		PostMessage( waitDialog->m_hWnd, WM_COMMAND, IDC_FILE, 0 );
		endWorking = true;
		return bu_update_start_result;
	}
	catch(...) {
		bu_update_start_result = 4;
		PostMessage( waitDialog->m_hWnd, WM_COMMAND, IDC_FILE, 0 );
		endWorking = true;
		return bu_update_start_result;
	}

	update_copy = true;
	bu_update_start_result = 0;
	PostMessage( waitDialog->m_hWnd, WM_COMMAND, IDC_FILE, 0 );
	endWorking = true;
	return 0;
}

#endif

void	DeleteGarbage()
{
#if defined (_GCD_CLIENT) || defined (PILOT)
	if ( UpdateRunner::um.ptr() != NULL && UpdateRunner::logged) UpdateRunner::um->logout_current();
	if ( aUpdateRunner) aUpdateRunner->status (GCM::cs_exit_requested);
#endif
	if ( DeltaManager ) delete DeltaManager;
	if ( lpProtInfo ) free( lpProtInfo );
	if ( lpComplectInfo ) free( lpComplectInfo );

	if ( strlen( GarantIni ) && !UpdateRun ) {
		WritePrivateProfileString( "Environment", "Run", "0", GarantIni );
		WritePrivateProfileString( NULL, NULL, NULL, GarantIni );
	}
}

int		BasesCount()
{
	return	lpComplectInfo -> ComplectCount / 2;
}

char*	BaseName( int aBase )
{
	return lpComplectInfo -> Bases[ aBase + BasesCount() ];
}

void    TuneProtInfo()
{
	char	aBaseFileName[ MAX_PATH ];
	
	if ( strlen( BasePath )) {
		strcpy( pathBasesOrigin, BasePath );
		ForceExt( pathBasesOrigin, "ORG" );

		PROTINFO protInfo;
		StrUpr( strcpy( aBaseFileName, BasePath ));

		ReadProtInfo( &protInfo, aBaseFileName );
		unsigned short hardwareID = protInfo.HardwareID;
		GetProtInfo( &protInfo, aBaseFileName, protInfo.VerType );
		if ( RemoteUpdate ) protInfo.HardwareID = hardwareID;
		WriteProtInfo( &protInfo );
	}
}

BOOL	DoBackup()
{
	return FALSE;
}

BOOL	DoRestore( BOOL& aBadBackup )
{
	char	aBaseFileName[ MAX_PATH ];
	MakePath( aBaseFileName, BackupPath, lpComplectInfo -> ComplectSet ? lpComplectInfo -> ComplectName : BaseName( 0 ));
/*	YBase* aBase = new YBase( aBaseFileName, O_RDONLY );
	if ( !aBase->IsOk()) {
		delete aBase;
		aBadBackup = TRUE;
		return FALSE;
	}*/
	aBadBackup = FALSE;
	//delete aBase;

	CreateDirectory( DataPath, NULL );
	char	aSourceFile[ MAX_PATH ], aDestFile[ MAX_PATH ];
	CCopyFilesDlg copyDlg( IDS_RESTORINGFILE );

	if ( lpComplectInfo -> ComplectSet ) {
		WIN32_FIND_DATA	findData;
		char	aBaseFileMask[ MAX_PATH ];
		MakePath( aBaseFileMask, BackupPath, lpComplectInfo -> ComplectName );
		strcat( aBaseFileMask, ".*" );

		HANDLE	aFindResult = FindFirstFile( aBaseFileMask, &findData );
		while( aFindResult != INVALID_HANDLE_VALUE ) {
			if ( ( findData.dwFileAttributes & FILE_ATTRIBUTE_DIRECTORY ) == 0 ) {
				if ( stricmp( strrchr( findData.cFileName, '.' ), ".LOG" )) {
					MakePath( aSourceFile, BackupPath, findData.cFileName );
					MakePath( aDestFile, DataPath, findData.cFileName );
					copyDlg.AddSourceFile( aSourceFile );
					copyDlg.AddDestFile( aDestFile );
				}
			}

			if ( !FindNextFile( aFindResult, &findData ))
				break;
		}
		FindClose( aFindResult );
	} else for ( int I = 0; I < BasesCount(); I++ ) {
		WIN32_FIND_DATA	findData;
		char	aBaseFileMask[ MAX_PATH ];
		MakePath( aBaseFileMask, BackupPath, BaseName( I ));
		strcat( aBaseFileMask, ".*" );

		HANDLE	aFindResult = FindFirstFile( aBaseFileMask, &findData );
		while( aFindResult != INVALID_HANDLE_VALUE ) {
			if ( ( findData.dwFileAttributes & FILE_ATTRIBUTE_DIRECTORY ) == 0 ) {
				if ( stricmp( strrchr( findData.cFileName, '.' ), ".LOG" )) {
					MakePath( aSourceFile, BackupPath, findData.cFileName );
					MakePath( aDestFile, DataPath, findData.cFileName );
					copyDlg.AddSourceFile( aSourceFile );
					copyDlg.AddDestFile( aDestFile );
				}
			}

			if ( !FindNextFile( aFindResult, &findData ))
				break;
		}
		FindClose( aFindResult );
	}
	copyDlg.AddSourceFile( MakePath( aSourceFile, BackupPath, "BASES.ORG" ));
	copyDlg.AddDestFile( MakePath( aDestFile, GarantPath, "BASES.ORG" ));

	return ( copyDlg.DoModal() == IDOK );
}

void	DeleteData( BOOL aDeleteBackup )
{
	char	aFileName[ MAX_PATH ];

	if ( lpComplectInfo -> ComplectSet ) {
		WIN32_FIND_DATA	findData;
		char	aBaseFileMask[ MAX_PATH ];
		MakePath( aBaseFileMask, aDeleteBackup ? BackupPath : DataPath, lpComplectInfo -> ComplectName );
		strcat( aBaseFileMask, ".*" );

		HANDLE	aFindResult = FindFirstFile( aBaseFileMask, &findData );
		while( aFindResult != INVALID_HANDLE_VALUE ) {
			if ( ( findData.dwFileAttributes & FILE_ATTRIBUTE_DIRECTORY ) == 0 ) {
				if ( stricmp( strrchr( findData.cFileName, '.' ), ".LOG" )) {
					MakePath( aFileName, aDeleteBackup ? BackupPath : DataPath, findData.cFileName );
					MyDeleteFile( aFileName );
				}
			}

			if ( !FindNextFile( aFindResult, &findData ))
				break;
		}
		FindClose( aFindResult );
	} else for ( int I = 0; I < BasesCount(); I++ ) {
		WIN32_FIND_DATA	findData;
		char	aBaseFileMask[ MAX_PATH ];
		MakePath( aBaseFileMask, aDeleteBackup ? BackupPath : DataPath, BaseName( I ));
		strcat( aBaseFileMask, ".*" );

		HANDLE	aFindResult = FindFirstFile( aBaseFileMask, &findData );
		while( aFindResult != INVALID_HANDLE_VALUE ) {
			if ( ( findData.dwFileAttributes & FILE_ATTRIBUTE_DIRECTORY ) == 0 ) {
				if ( stricmp( strrchr( findData.cFileName, '.' ), ".LOG" )) {
					MakePath( aFileName, aDeleteBackup ? BackupPath : DataPath, findData.cFileName );
					MyDeleteFile( aFileName );
				}
			}

			if ( !FindNextFile( aFindResult, &findData ))
				break;
		}
		FindClose( aFindResult );
	}

	if ( aDeleteBackup ) {
		MyDeleteFile( MakePath( aFileName, BackupPath, "BASES.ORG" ));
		WritePrivateProfileString( "Environment", "Backup", NULL, GarantIni );
		WritePrivateProfileString( NULL, NULL, NULL, GarantIni );
	}
}

CUpdateApp::CUpdateApp()
{
	GarantIni[  0 ] = '\0';
	BackupPath[ 0 ] = '\0';
	update_seconds = 0;
	b_result_send = false;
}

void CUpdateApp::set_local_resource (const char* dll_name) {
	HMODULE language_handle = (HMODULE) NULL;

	m_res_loader = new GCL::DllLoader (dll_name);

	if (m_res_loader.ptr ()) {
		language_handle = static_cast <HMODULE> (m_res_loader->get_handle ());
	} 

	if (language_handle) {
		AfxSetResourceHandle (language_handle);
	} else {
		std::string str = dll_name;
		str += std::string (".dll not loaded");
		::MessageBox (NULL, str.c_str (), AfxGetAppName (), MB_OK | MB_ICONEXCLAMATION);
	}
}

void CUpdateApp::CheckArgs()
{
	int argc = __argc;
	char** argv = __argv;
	cmdLine = NULL;

	for ( int I = 0; I < argc; I++ ) {
		if ( !cmdLine )
			cmdLine = strdup( argv[ I ] );
		else {
			cmdLine = (char*)realloc( cmdLine, strlen( cmdLine ) + strlen( argv[ I ] ) + 2 );
			strcat( cmdLine, " " );
			strcat( cmdLine, argv[ I ] );
		}
		if ( SilentMode && ( !stricmp( argv[ I ], "NOFINALMESSAGE" ) || !stricmp (argv[I], "-nofinalmessage" )))
			NoFinalMessage = TRUE;
		else
		if ( SilentMode && ( !stricmp( argv[ I ], "SKIPWARNING" ) || !stricmp (argv[I], "-skipwarning" )))
			SkipWarning = TRUE;
		else
		if ( !stricmp( argv[ I ], "AUTO" ) || !stricmp( argv[I], "-auto" )) {
			SilentMode = TRUE;
			if ( I + 1 < argc && IsPath( argv[ I + 1 ] )) {
				SilentDelta = TRUE;
				strcpy( DeltaPath, argv[ I + 1 ] );
			}
		}
		if ( !stricmp (argv[I],"-path") || !stricmp (argv[I],"path") ) {
			if ( I + 1 < argc && IsPath( argv[ I + 1 ] )) {
				SilentDelta = TRUE;
				strcpy( DeltaPath, argv[I+1] );
			}
		}
		else
		if ( !stricmp( argv[ I ], "NOBACKUP" ) || !stricmp (argv[I],"-nobackup") ) {
			SyncBackup = TRUE;
		} else
		if ( !stricmp( argv[ I ], "SKIP" ) || !stricmp (argv[I],"-skip") ) {
			SkipMode = TRUE;
			if ( I + 1 < argc && IsPath( argv[ I + 1 ] )) {
				SilentDelta = TRUE;
				strcpy( DeltaPath, argv[ I + 1 ] );
			}
		}
		else
		if ( !stricmp( argv[ I ], "DELETEZIPS" ) || !stricmp (argv[I],"-deletezips") )
			DeleteZips = TRUE;
		else
		if ( SilentBackup && !NoDeleteBackup && ( !stricmp( argv[ I ], "DELETE" ) || !stricmp (argv[I],"-delete") ))
			DeleteBackup = TRUE;
		else
		if ( SilentBackup && !DeleteBackup && ( !stricmp( argv[ I ], "NODELETE" ) || !stricmp (argv[I],"-nodelete" )))
			NoDeleteBackup = TRUE;
		else
		if ( !stricmp( argv[ I ], "UNDO" ) || !stricmp (argv[I],"-undo") ) {
			RestoreMode = TRUE;
			SilentBackup = FALSE;
		}
		else
		if ( !stricmp( argv[ I ], "FROMDOWNLOAD" ) || !stricmp (argv[I],"-fromdownload") ) {
			FromDownload = TRUE;
			if ( I + 1 < argc && IsPath( argv[ I + 1 ] )) {
				SilentDelta = TRUE;
				strcpy( DeltaPath, argv[ I + 1 ] );
			}
		}
		else
		if( !stricmp( argv[ I ], "-login" ) || !stricmp( argv[ I ], "/login")) {
			if( I+1 < argc ) {
				m_llogin = ACE_OS_String::strdup( argv[I+1] );
			}
		}
		else
		if( !stricmp( argv[ I ], "-pwd") || !stricmp( argv[ I ], "/pwd")) {
			if( I+1 < argc ) {
				m_lpwd = ACE_OS_String::strdup( argv[I+1] );
			}
		}
	}

	if (!m_lpwd)
		m_lpwd = ACE_OS_String::strdup("");

	if ( !SilentMode ) {
		SilentBackup = FALSE;
		SyncBackup = FALSE;
	}
	/*
	delete argv;
	strcpy( m_lpCmdLine, aCmdLineCopy.GetBuffer( 0 ));
	*/
}

void	RemovePatch( CString aPatchIni, BOOL aDeleteFiles = FALSE )
{
	char	aPatchDir[ MAX_PATH ];
	GetPrivateProfileString( "Patch", "Dir", "", aPatchDir, MAX_PATH, aPatchIni );
	if ( strlen( aPatchDir ))
	{
		char	aPatchPath[ MAX_PATH ];
		MakePath( aPatchPath, DeltaPath, aPatchDir );
		if ( aDeleteFiles ) RemoveDirectoryWithFiles( aPatchPath );
		RemoveDirectoryEx( aPatchPath );
	}
	MyDeleteFile( aPatchIni );
}

void	DeleteOldFiles()
{
	char	aDeletesIni[ MAX_PATH ];
	MakePath( aDeletesIni, GarantPath, "TODELETE.INI" );
	UINT	aFiles = GetPrivateProfileInt( "Delete", "Count", 0, aDeletesIni );
	UINT	aSuccess = 0;
	for ( UINT I = 0; I < aFiles; I++ )
	{
		char	aEntry[ 16 ];
		sprintf( aEntry, "File%d", I );
		char	aFileName[ MAX_PATH ];
		GetPrivateProfileString( "Delete", aEntry, "", aFileName, MAX_PATH, aDeletesIni );
		if ( !strlen( aFileName ) || !FileExist( aFileName ) || MyDeleteFile( aFileName ))
		{
			WritePrivateProfileString( "Delete", aEntry, NULL, aDeletesIni );
			aSuccess++;
		}
	}
	WritePrivateProfileString( NULL, NULL, NULL, aDeletesIni );

	if ( aSuccess == aFiles )
		MyDeleteFile( aDeletesIni );
}

BOOL	AddToken( char* aFiles, char* aFile )
{
	char*	aBuffer = new char[ strlen( aFiles ) + 1 ];
	strcpy( aBuffer, aFiles );

	char	*aToken = strtok( aBuffer, "," );
	BOOL	aFound = FALSE;
	while ( aToken != NULL )
	{
		if ( !strcmp( aToken, aFile ))
		{
			aFound = TRUE;
			break;
		}
		aToken = strtok( NULL, "," );
	}

	delete aBuffer;

	if ( !aFound )
	{
		if ( strlen( aFiles )) strcat( aFiles, "," );
		strcat( aFiles, aFile );
		return TRUE;
	}
	else
		return FALSE;
}

void	RemoveToken( char* aFiles, char* aFile )
{
	char*	aBuffer = new char[ strlen( aFiles ) + 1 ];
	strcpy( aBuffer, aFiles );
	aFiles[ 0 ] = '\0';

	char	*aToken = strtok( aBuffer, "," );
	while ( aToken != NULL )
	{
		if ( strcmp( aToken, aFile ))
		{
			if ( strlen( aFiles )) strcat( aFiles, "," );
			strcat( aFiles, aToken );
		}
		aToken = strtok( NULL, "," );
	}

	delete aBuffer;
}

void	AddFileToDelete( CString aFileName )
{
	char	aDeletesIni[ MAX_PATH ];
	MakePath( aDeletesIni, GarantPath, "TODELETE.INI" );

	UINT	aFiles = GetPrivateProfileInt( "Delete", "Count", 0, aDeletesIni );
	char	aEntry[ 16 ];
	sprintf( aEntry, "File%d", aFiles );
	WritePrivateProfileString( "Delete", aEntry, aFileName, aDeletesIni );
	char	sFiles[ 16 ];
	sprintf( sFiles, "%d", ++aFiles );
	WritePrivateProfileString( "Delete", "Count", sFiles, aDeletesIni );
}

void	Log( char *aLogString )
{
	char	aLogFileName[ MAX_PATH ];
	MakePath (aLogFileName, GarantPath, "\\Logs\\update.log");
	FILE	*aLogFile = fopen( aLogFileName, "a" );
	if ( aLogFile )	{
		fputs( aLogString, aLogFile );
		fclose( aLogFile );
	}
}

void	Log( UINT aLogID )
{
	CString aLogString;
	aLogString.LoadString( aLogID );
	Log( aLogString.GetBuffer( 0 ));
	Log( "\n\n\n" );
}

void	TimeLog( UINT aLogID, char* add )
{
	CTime theTime = CTime::GetCurrentTime();
	CString aMessage;
	aMessage.Format (aLogID, add);
	char	aLogString[ 128 ];
	sprintf( aLogString, "\n\nДата: %d:%d:%d Время: %2d:%02d:%02d %s\n", theTime.GetDay(), theTime.GetMonth(), theTime.GetYear(), theTime.GetHour(), theTime.GetMinute(), theTime.GetSecond(), aMessage.GetBuffer( 0 ));
	Log( aLogString );
}

void	TimeLog( UINT aLogID )
{
	CTime theTime = CTime::GetCurrentTime();
	CString aMessage;
	aMessage.LoadString( aLogID );
	char	aLogString[ 128 ];
	sprintf( aLogString, "\n\nДата: %d:%d:%d Время: %2d:%02d:%02d %s\n", theTime.GetDay(), theTime.GetMonth(), theTime.GetYear(), theTime.GetHour(), theTime.GetMinute(), theTime.GetSecond(), aMessage.GetBuffer( 0 ));
	Log( aLogString );
}

UINT64 Version64( char* aVersion )
{
	char* aCopy = new char[ strlen( aVersion ) + 1 ];
	strcpy( aCopy, aVersion );

	char	*a1 = strtok( aCopy, "." );
	char	*a2 = strtok( NULL,  "." );
	char	*a3 = strtok( NULL,  "." );
	char	*a4 = strtok( NULL,  "." );

	UINT64	u1 = a1 ? atol( a1 ) * 1000000 : 0;
	UINT64	u2 = a2 ? atol( a2 ) * 10000 : 0;
	UINT64	u3 = a3 ? atol( a3 ) * 100 : 0;
	UINT64	u4 = a4 ? atol( a4 ) : 0;
	delete aCopy;

	return u1 + u2 + u3 + u4;
}

void	RunDownload( revision aFrom )
{
	char buffer [MAX_PATH];
	buffer [GetModuleFileName ((HMODULE)NULL, buffer, MAX_PATH)] = '\0';
	char* slash = strrchr( buffer, '\\' );
	if ( slash ) *slash = '\0'; //отрезали имя
	slash = strrchr( buffer, '\\' );
	if ( slash ) *slash = '\0'; //отрезали win9x/winnt
	slash = strrchr( buffer, '\\' );
	if ( slash ) *slash = '\0'; //отрезали apps
	CString aCmdLine;
	aCmdLine.Format( "\"%s\\garant.exe\" F1Download -runupdate", buffer );
	if ( m_llogin ) {
		aCmdLine += " -login ";
		aCmdLine += m_llogin;
	}
	if ( m_lpwd ) {
		aCmdLine += " -pwd ";
		aCmdLine += m_lpwd;
	}
	if ( DeleteZips ) {
		aCmdLine += " -deletezips";
	}
	aCmdLine += " ";
	PROCESS_INFORMATION	processInfo;
	STARTUPINFO	startupInfo;
	memset( &startupInfo, 0, sizeof( startupInfo ));
	if ( CreateProcess( NULL, aCmdLine.GetBuffer( 0 ), NULL, NULL, FALSE, CREATE_SUSPENDED, NULL, NULL, &startupInfo, &processInfo ))
	{
		CloseHandle( UpdateHandle );
		DeleteGarbage();
		::ResumeThread( processInfo.hThread );
		exit( EXIT_SUCCESS );
	}
}

BOOL	ApplyPatch( CString aPatchIni, int &aNewUpdate )
{
	CCopyFilesDlg	copyDlg;
	CStringList		newFiles;
	CStringList		filesToPatch;
	CStringList		shortFileNames;
	CStringList		aMoreFilesToCheck;
	CString			newUpdateFileName;

	aNewUpdate = 0;

	char	aRequired[ 32 ]; GetPrivateProfileString( "Patch",   "Required",    "", aRequired, 32, aPatchIni );
	char	aPatchVer[ 32 ]; GetPrivateProfileString( "Patch",   "release_tag", "", aPatchVer, 32, aPatchIni );
	char	aBreeder[  32 ]; GetPrivateProfileString( "Version", "breeder",     "", aBreeder,  32, aPatchIni );
	char	aDosShell[ 32 ]; GetPrivateProfileString( "Version", "dos_shell",   "", aDosShell, 32, aPatchIni );
	char	aWinShell[ 32 ]; GetPrivateProfileString( "Version", "win_shell",   "", aWinShell, 32, aPatchIni );
	char	aVersion[  32 ]; GetPrivateProfileString( "Version", "release_tag", "", aVersion,  32, GarantIni );

	char	aLogString[ MAX_PATH * 2 ];

	if ( ( strcmp( aRequired, aVersion ) && strlen( aRequired )) || ( strlen( aPatchVer ) && ( Version64( aPatchVer ) < Version64( aVersion )))) {
		RemovePatch( aPatchIni, TRUE );
		sprintf( aLogString, "Патч %s не применим. Версия Гаранта: %s\n", aPatchIni, aVersion );
		Log( aLogString );
		//OkBox( IDS_BADPATCHVERSION, IDS_ERROR, IDI_BESTOP );
		return TRUE;
	}

	sprintf( aLogString, "Применяем патч %s\n", aPatchIni );
	Log( aLogString );

	char	aPatchIniSubDir[ MAX_PATH ];
	if ( GetPrivateProfileString( "Patch", "Dir", "", aPatchIniSubDir, MAX_PATH, aPatchIni )) {
		char	aPatchSubDir[ MAX_PATH ];
		MakePath( aPatchSubDir, DeltaPath, aPatchIniSubDir );

		UINT	aChanges = GetPrivateProfileInt( "Changes", "Count", 0, aPatchIni );
		UINT I = 0; // GARANT_FORSCOPING
		for ( I = 0; I < aChanges; I++ ) {
			char	aEntry[ 16 ];
			sprintf( aEntry, "File%d", I );
			char	aFileName[ MAX_PATH ];
			GetPrivateProfileString( "Changes", aEntry, "", aFileName, MAX_PATH, aPatchIni );
			sprintf( aEntry, "Version%d", I );
			char	aVersion[ 16 ];
			GetPrivateProfileString( "Changes", aEntry, "", aVersion, 16, aPatchIni );

			char	aSrcFile[ MAX_PATH ];
			MakePath( aSrcFile, aPatchSubDir, aFileName );

			if ( !GarantVersion.CompareNoCase( aVersion ) || !stricmp( aVersion, "Net" ) || !GarantVersion.CompareNoCase( "Net" )) {
				copyDlg.AddSourceFile( aSrcFile );

				shortFileNames.AddTail( aFileName );
				filesToPatch.AddTail( aSrcFile );

				char	aDstFile[ MAX_PATH ];
				copyDlg.AddDestFile( MakePath( aDstFile, GarantPath, aFileName ));

				if ( !stricmp( UpdateExe.GetBuffer( 0 ), aDstFile )) {
					newUpdateFileName = aSrcFile;
					copyDlg.AddCanBeNewFile( aDstFile );
				} else {
					aMoreFilesToCheck.AddTail( aDstFile );
				}
			} else {
				MyDeleteFile( aSrcFile );
			}
		}

		if ( aChanges && aMoreFilesToCheck.GetCount()) {
			LockBases( TRUE );
			BOOL aResult = TryToOpenBases( &aMoreFilesToCheck );
			UnlockBases();

			if ( !aResult ) {
				OkBox( IDS_SHELLLOCKED );
				return FALSE;
			}
		}

		UINT	aNewFiles = GetPrivateProfileInt( "New", "Count", 0, aPatchIni );
		for ( I = 0; I < aNewFiles; I++ ) {
			char	aEntry[ 16 ];
			sprintf( aEntry, "File%d", I );
			char	aFileName[ MAX_PATH ];
			GetPrivateProfileString( "New", aEntry, "", aFileName, MAX_PATH, aPatchIni );
			sprintf( aEntry, "Version%d", I );
			char	aVersion[ 16 ];
			GetPrivateProfileString( "New", aEntry, "", aVersion, 16, aPatchIni );

			char	aSrcFile[ MAX_PATH ];
			MakePath( aSrcFile, aPatchSubDir, aFileName );

			if ( !GarantVersion.CompareNoCase( aVersion ) || !stricmp( aVersion, "Net" ) || !GarantVersion.CompareNoCase( "Net" )) {
				copyDlg.AddSourceFile( aSrcFile );

				shortFileNames.AddTail( aFileName );
				filesToPatch.AddTail( aSrcFile );
				newFiles.AddTail( aSrcFile );

				char	aDstFile[ MAX_PATH ];
				copyDlg.AddDestFile( MakePath( aDstFile, GarantPath, aFileName ));
			} else {
				MyDeleteFile( aSrcFile );
			}
		}

		UINT	aFonts = GetPrivateProfileInt( "Fonts", "Count", 0, aPatchIni );
		for ( I = 0; I < aFonts; I++ ) {
			char	aEntry[ 16 ];
			sprintf( aEntry, "Font%d", I );
			char	aRelFontName[ MAX_PATH ];
			GetPrivateProfileString( "Fonts", aEntry, "", aRelFontName, MAX_PATH, aPatchIni );
			char	aSourceFont[ MAX_PATH ];
			MakePath( aSourceFont, GarantPath, aRelFontName );
			
			if ( !FileSize( aSourceFont ))
				continue;

			char	aWindowsDirectory[ MAX_PATH ];
			if ( GetWindowsDirectory( aWindowsDirectory, MAX_PATH )) {
				strcat( aWindowsDirectory, "\\FONTS" );
				char	aDestFont[ MAX_PATH ];
				MakePath( aDestFont, aWindowsDirectory, strrchr( aRelFontName, '\\' ));
				if ( FileSize( aDestFont ) && ( FileSize( aDestFont ) != FileSize( aSourceFont ))) {
					copyDlg.AddSourceFile( aSourceFont );
					copyDlg.AddDestFile( aDestFont );
				}
			}
		}
		
		UINT	aFilesToDelete = GetPrivateProfileInt( "Remove", "Count", 0, aPatchIni );
		for ( I = 0; I < aFilesToDelete; I++ ) {
			char	aEntry[ 16 ];
			sprintf( aEntry, "File%d", I );
			char	aFile[ 16 ];
			GetPrivateProfileString( "Remove", aEntry, "", aFile, 16, aPatchIni );
			sprintf( aEntry, "File%s", aFile );
			char	aShortFileName[ MAX_PATH ];
			GetPrivateProfileString( "CRC", aEntry, "", aShortFileName, MAX_PATH, GarantIni );
			if ( strlen( aShortFileName )) {
				char	aFileName[ MAX_PATH ];
				MakePath( aFileName, GarantPath, aShortFileName );
				if ( !MyDeleteFile( aFileName ))
					AddFileToDelete( aFileName );

				sprintf( aEntry, "File%s", aFile ); WritePrivateProfileString( "CRC", aEntry, NULL, GarantIni );
				sprintf( aEntry, "Crc%s",  aFile ); WritePrivateProfileString( "CRC", aEntry, NULL, GarantIni );
			}
		}
	}

	int copyFiles = copyDlg.DoModal();

	if ( newUpdateFileName.GetLength()) {
		if ( copyDlg.CanBeNewFiles.GetCount() == 0 )
			aNewUpdate = 2;
		else
		if ( copyDlg.OkFiles.Find( newUpdateFileName ))
			aNewUpdate = 1;
	}

	POSITION	posFilesToPatch = filesToPatch.GetHeadPosition();
	POSITION	posShortFileNames = shortFileNames.GetHeadPosition();
	while ( posFilesToPatch != NULL ) {
		CString	aFileToPatch = filesToPatch.GetNext( posFilesToPatch );
		CString	aShortFileName = shortFileNames.GetNext( posShortFileNames );

		if ( copyDlg.OkFiles.Find( aFileToPatch )) {
			MyDeleteFile( aFileToPatch ); // стерли файл из каталога с патчами

			char	aCrc[ 16 ]; GetPrivateProfileString( "CRC", aShortFileName, "", aCrc, 16, aPatchIni );
			char	aFile[ 8 ];	GetPrivateProfileString( "Files", aShortFileName, "0", aFile, 8, aPatchIni );
			if ( strlen( aCrc ) && strlen( aFile )) {
				char	aIniCrc[ 16  ]; sprintf( aIniCrc,  "Crc%s",  aFile ); WritePrivateProfileString( "CRC", aIniCrc,  aCrc,           GarantIni );
				char	aIniFile[ 16 ]; sprintf( aIniFile, "File%s", aFile ); WritePrivateProfileString( "CRC", aIniFile, aShortFileName, GarantIni );

				if ( newFiles.Find( aFileToPatch )) {
					// файл новый, надо добавить его в [Setup].Files
					char	aFiles[ 4096 ];
					GetPrivateProfileString( "Setup", "Files", "", aFiles, 4096, GarantIni );
					if ( AddToken( aFiles, aFile )) {
						WritePrivateProfileString( "Setup", "Files", aFiles, GarantIni );
						UINT	aCrcFiles = GetPrivateProfileInt( "CRC", "Count", 0, GarantIni );
						char	sCrcFiles[ 16 ];
						sprintf( sCrcFiles, "%ld", aCrcFiles + 1 );
						WritePrivateProfileString( "CRC", "Count", sCrcFiles, GarantIni );
					}
				}
			}
		}
	}

	POSITION aPos = copyDlg.RenamedFiles.GetHeadPosition();
	while ( aPos )
		AddFileToDelete( copyDlg.RenamedFiles.GetNext( aPos ));

	if ( copyFiles == IDCANCEL ) {
		OkBox( IDS_PATCHNOTAPPLIED, IDS_ERROR, IDI_BEHAND );
		return FALSE;
	} else {
		if ( strlen( aPatchVer )) WritePrivateProfileString( "Version", "release_tag", aPatchVer, GarantIni );
		if ( strlen( aBreeder  )) WritePrivateProfileString( "Version", "breeder",   aBreeder,  GarantIni );
		if ( strlen( aDosShell )) WritePrivateProfileString( "Version", "dos_shell", aDosShell, GarantIni );
		if ( strlen( aWinShell )) WritePrivateProfileString( "Version", "win_shell", aWinShell, GarantIni );
		RemovePatch( aPatchIni );
		return TRUE;
	}
}

UpdateRunner :: UpdateRunner(): m_login (NULL), m_pwd ( NULL ), m_auto ( false ), m_nofinalmessage ( false )
{
	register_receptacles(Defines::FN_FUNCTION_MNG);
	register_receptacles(Defines::FN_BASE_UPDATE);
	register_receptacles(Defines::FN_HEARTBEAT_MANAGER);
	register_receptacles(Defines::FN_USER_MANAGER);
}

void UpdateRunner::process_args (const GCD::Args& args) {
	for(unsigned i = 0; i < args.length(); i++) {
		if((ACE_OS_String::strcmp(args[i], "-login" ) == 0) || (ACE_OS_String::strcmp(args[i], "/login") == 0)) {
			if(i+1 < args.length()) {
				m_login = ACE_OS_String::strdup(args[i+1]);;
				m_llogin = ACE_OS_String::strdup( m_login );
			}
		} else
		if((ACE_OS_String::strcmp(args[i], "-pwd") == 0) || (ACE_OS_String::strcmp(args[i], "/pwd") == 0)) {
			if(i+1 < args.length()) {
				m_pwd = ACE_OS_String::strdup(args[i+1]);;
				m_lpwd = ACE_OS_String::strdup( m_pwd );
			}
		} else
		if((ACE_OS_String::strcmp(args[i], "-auto") == 0) || (ACE_OS_String::strcmp(args[i], "auto") == 0)) {
			m_auto = true;
		} else
		if((ACE_OS_String::strcmp(args[i], "-nofinalmessage") == 0) || (ACE_OS_String::strcmp(args[i], "nofinalmessage") == 0)) {
			m_nofinalmessage = true;
		}
	}

	if (!m_pwd) {
		m_pwd = ACE_OS_String::strdup ("");
		m_lpwd = ACE_OS_String::strdup (m_pwd);
	}
};

void UpdateRunner :: execute() {
	GCMComponentBase::execute ();
	CORBA::Object_var o = provide(Defines::FN_USER_MANAGER);
	um = GslUserManager::UserManager::_narrow(o);
	GCD::Args args(__argc, __argc, __argv, 0);
	process_args (args);
	if (!(m_llogin && m_lpwd)) {
		m_llogin = ACE_OS_String::strdup("ADMIN");
		m_lpwd = ACE_OS_String::strdup("ADMIN");
	}

	bool b_waitxml_visible = false;
	bool auto_login = true;
	int aLoginResult = IDCANCEL;
	bool canupdatedataorg = false;
	if (true) {	
	loginagain:
		try {
			if ((UpdateRunner::um->get_protection_error () == 0) && (UpdateRunner::um->get_rest_trial_days_count () >= 0)) {
				CString string = theApp.b_english_face ? "Cant update base for trial version." : "Обновление информационного банка в ознакомительной версии невозможно.";
				MessageBox (NULL, string, theApp.b_english_face ? "Authorization" : "Авторизация", MB_ICONERROR+MB_OK);
				status (GCM::cs_exit_requested);
				return;
			}

			if (UpdateRunner::um->get_protection_error () == 0)
				canupdatedataorg = true;

			if (!auto_login) {
				CLoginDlg* loginDlg = new CLoginDlg();
				UINT login_result = loginDlg->DoModal();
				if (login_result == IDOK) {
					m_llogin = ACE_OS_String::strdup (loginDlg->m_Login);
					m_lpwd = ACE_OS_String::strdup (loginDlg->m_Password);
				}
				delete loginDlg;
				if (login_result == IDCANCEL) {
					status (GCM::cs_exit_requested);
					return;
				}
			}
			auto_login = false;
			UpdateRunner::um->login(m_llogin, m_lpwd);
			aLoginResult = IDOK;
		}

		catch(GslUserManager::LoginFailed&) {
			CString err;
			err.LoadString(IDS_MSG_91);
			if ( NoFinalMessage ) {
				Log( err.GetBuffer(0) );
				Log( "\n" );
				status (GCM::cs_exit_requested);
				return;
			}
			else
				MessageBox(NULL, err, theApp.b_english_face ? "Authorization" : "Авторизация", MB_OK);
		}
		catch(GslUserManager::LoginDuplicate&) {
			CString err;
			err.LoadString(IDS_MSG_92);
			if ( NoFinalMessage ) {
				Log( err.GetBuffer(0) );
				Log( "\n" );
				status (GCM::cs_exit_requested);
				return;
			}
			else
				MessageBox(NULL, err, theApp.b_english_face ? "Authorization" : "Авторизация", MB_OK);
		}

		catch(GslUserManager::LoginBlocked&) {
			CString err;
			err.LoadString(IDS_MSG_93);
			if ( NoFinalMessage ) {
				Log( err.GetBuffer(0) );
				Log( "\n" );
				status (GCM::cs_exit_requested);
				return;
			}
			else
				MessageBox(NULL, err, theApp.b_english_face ? "Authorization" : "Авторизация", MB_OK);
		}
		catch(GslUserManager::NoMoreConnections&) {
			CString err;
			err.LoadString(IDS_NOMORE_CONNECTIONS);
			if ( NoFinalMessage ) {
				Log( err.GetBuffer(0) );
				Log( "\n" );
				status (GCM::cs_exit_requested);
				return;
			}
			else
				MessageBox(NULL, err, theApp.b_english_face ? "Authorization" : "Авторизация", MB_OK);
		}

		catch(GCD::XMLImportRunning) {
			if (!b_waitxml_visible) {
				ACE_OS::sleep(3);
			} else {
				CWaitXmlDialog *waitXml = new CWaitXmlDialog();
				waitXml->SetUpdateRunner (this);
				waitXml->SetLoginPassword (m_llogin, m_lpwd);
				aLoginResult = waitXml->DoModal ();
				delete waitXml;
				if (aLoginResult == IDCANCEL) {
					status (GCM::cs_exit_requested);
					return;
				}
			}
			b_waitxml_visible = true;
			auto_login = true;
		}
		catch(CORBA::TRANSIENT&) {
			CString err;
			err.LoadString(IDS_TRANSIENT);
			if ( NoFinalMessage ) {
				Log( err.GetBuffer(0) );
				Log( "\n" );
				status (GCM::cs_exit_requested);
				return;
			}
			else
				MessageBox(NULL, err, theApp.b_english_face ? "Authorization" : "Авторизация", MB_OK);
		}
		catch(CORBA::Exception& ex) {
			CString err = "Произошел системный сбой при авторизации, свяжитесь с разработчиками.\n(CORBA::Исключение ";
			err += ex._rep_id();
			err += ")";
			if ( NoFinalMessage ) {
				Log( err.GetBuffer(0) );
				Log( "\n" );
				status (GCM::cs_exit_requested);
				return;
			}
			else
				MessageBox(NULL,err, theApp.b_english_face ? "Authorization" : "Авторизация", MB_OK);
		}
		catch(...) {
			CString err = "Произошел системный сбой при авторизации, свяжитесь с разработчиками.";
			if ( NoFinalMessage ) {
				Log( err.GetBuffer(0) );
				Log( "\n" );
				status (GCM::cs_exit_requested);
				return;
			}
			else
				MessageBox(NULL,err, theApp.b_english_face ? "Authorization" : "Авторизация", MB_OK);
		}

		if (aLoginResult != IDOK)
			goto loginagain;

		revision aTodayRevision;	
		memset( &aTodayRevision, 0, sizeof( aTodayRevision ));
		time_t atime = time( NULL );
		struct	tm *ptm = localtime( &atime );
		aTodayRevision.RevisionDate.da_day  = ptm -> tm_mday;
		aTodayRevision.RevisionDate.da_mon  = ptm -> tm_mon + 1;
		aTodayRevision.RevisionDate.da_year = ptm -> tm_year + 1900;

		logged = true;
		if(!um->has_admin_rights ()) {
			CString str = "Неизвестная ошибка";
			str.LoadString(IDS_FORBIDDEN);
			FatalError( str );
		}
		o = provide(Defines::FN_BASE_UPDATE);
		bu = GblPilot::BaseUpdate::_narrow(o);

		if (!strcmp (Core::ParamManagerFactory::get ().get_string ("-EnableGu7trOptimization").c_str (), "1"))
			enable_gu_7tr_optimization = true;

		if (!strcmp (Core::ParamManagerFactory::get ().get_string ("-EnableGuMergeOptimization").c_str (), "1"))
			enable_gu_merge_optimization = true;

		if (!strcmp (Core::ParamManagerFactory::get ().get_string ("-ExtendedLog").c_str (), "1"))
			extended_log = true;

		try {
			if ( !SilentDelta ) {
				strcpy (DeltaPath, Core::ParamManagerFactory::get ().get_string ("-DUDeltaDefaultPath").c_str ());
				if (!strlen (DeltaPath)) {
					strcpy( DeltaPath, GarantPath );
					if ( strrchr( DeltaPath, '\\' )) *strrchr( DeltaPath, '\\' ) = '\0';
					if ( strrchr( DeltaPath, '\\' )) *strrchr( DeltaPath, '\\' ) = '\0';
					strcat( DeltaPath, "\\Delta" );
				}
			} else {
				if ( !strlen( DeltaPath ))
					strcpy (DeltaPath, Core::ParamManagerFactory::get ().get_string ("-DUDeltaDefaultPath").c_str ());
			}
		}
		catch(CORBA::TRANSIENT&) {
			CString err;
			err.LoadString(IDS_TRANSIENT);
			MessageBox(NULL, err, "Обновление", MB_OK);
		}
		catch(CORBA::Exception& ex) {
			CString str;
			str = CString("CORBA::Исключение ") + ex._rep_id();
			OkBox( str );
		}
		catch(...) {
			OkBox( "get_update_path(): неизвестное исключение" );
		}

		CSelectBaseFolder	selectBaseFolder;
		try {
			CORBA::Object_var oo = provide(Defines::FN_FUNCTION_MNG);
			m_func_manager = GblPilot::FunctionMng::_narrow(oo);

			if (m_func_manager->check_datastore () != GblPilotDef::SS_OK) {
				if (NoFinalMessage)
					TimeLog (IDS_NOBASE);
				else
					FatalMessage (IDS_NOBASE);
				this->cancel_update (GblPilot::UCC_NOBASE);
				goto finish;
			}

			GblPilotDef::PersonificationKey_var key = UpdateRunner::m_func_manager->get_personification_key ();
			std::string _pers_key (reinterpret_cast <const char*> (key->get_buffer ()), key->length ());
			theApp.pers_key = _pers_key;

			GblPilotDef::AllSegmentInfo_var all_segs_info = m_func_manager->get_segments_info();
			//is_packed, real_segments, all_segments

			BOOL		aFreshBase = FALSE;
			BOOL		aPackedPresent = FALSE;

			char aShortBaseName[ MAX_PATH ];
			strcpy( aShortBaseName, "data" );

			if ( bu->is_update_started()) {
				if ( YesNoBox( IDS_UPDATERUNOTHER ))
					//FatalError( IDS_UPDATERUN );
					NormalExit();
			}

			if ( all_segs_info->is_packed ) {
				aPackedPresent = TRUE;
				this->cancel_update (GblPilot::UCC_BASE_PACKED);
				if (NoFinalMessage)
					TimeLog	(IDS_BASEPACKED, aShortBaseName);
				else
					FatalError (IDS_BASEPACKED, aShortBaseName);
				goto finish;
			}

			unsigned short I = 0;
			for (I = 0; I < all_segs_info->real_segments.length(); I++ ) {
				revision	aPrevRevision;

				short	aSegID = all_segs_info->real_segments[I].id;
				if (aSegID == DEMO_SEGMENT)
					b_isetalon = true;

				revision	aSegRevision;
				gk_bzero( &aSegRevision, sizeof( aSegRevision ));
				aSegRevision.RevisionDate.da_day  = static_cast<unsigned char> (all_segs_info->real_segments[I].revision.m_day);
				aSegRevision.RevisionDate.da_mon  = static_cast<unsigned char> (all_segs_info->real_segments[I].revision.m_mounth);
				aSegRevision.RevisionDate.da_year = all_segs_info->real_segments[I].revision.m_year;

				char	aSegName[ BASE_NAME_SIZE ];
				strcpy( aSegName, all_segs_info->real_segments[I].name.in() );
			#ifndef	WINENCODE
				Win2Dos( aSegName );
			#endif

				if ( I == 0 ) {
					aPrevRevision = aSegRevision;

					char rev_str [64];
					sprintf (rev_str, "%ld-%ld-%ld", aSegRevision.RevisionDate.da_day, aSegRevision.RevisionDate.da_mon, aSegRevision.RevisionDate.da_year);
					theApp.from_str = rev_str;

					if ( CompRevs( &aTodayRevision, &aPrevRevision ) <= 0 )
						aFreshBase = TRUE;

					DeltaManager = new TDeltaManager( aPrevRevision, aTodayRevision, TRUE );
				}

				if ( CompRevs( &aPrevRevision, &aSegRevision ) != 0 ) {
					this->cancel_update (GblPilot::UCC_BAD_REVS);
					FatalError( IDS_BASEBADREVS );
				}

				DeltaManager -> AddSegment( aSegID, aSegName, aShortBaseName );

			}

			if (aFreshBase && !b_isetalon) {
				if ( NoFinalMessage )
					TimeLog( IDS_NONEED );
				else
					OkBox( IDS_NONEED );
				this->cancel_update (GblPilot::UCC_DONT_NEED);
				goto finish;
			}

			for ( I = 1; I < all_segs_info->all_segments.length(); I++ ) {
				baseInfoIds.add( newShort( all_segs_info->all_segments[I].id ));
				baseInfoNames.add( newStr( all_segs_info->all_segments[I].name.in() ));
			}

			CWelcomeDlg				welcomeDlg;
			CSelectMethodDlg		methodDlg;
			CSelectDeltasFolderDlg	deltasDlg;
			CCollectPartsDlg		collectPartsDlg;
			CBadDeltasDlg			badDeltasDlg;
			CCantUpdateDlg			cantUpdateDlg;
			CPartUpdateDlg			partUpdateDlg;
			CFullUpdateDlg			fullUpdateDlg;
			CUnzipDlg				unzipDlg;
			CSelectBackupFolderDlg	backupDlg;
			UINT					aResult;

			Log( "\n\n--------------------------------------------------\nЗапущен с параметрами:\n" );
			Log( theApp.cmdLine );
			Log( "\n" );
			if (enable_gu_merge_optimization) {
				Log ("Пущен с объединением дельт (EnableGuMergeOptimization=1)\n");
			}

			if (!enable_gu_7tr_optimization && m_func_manager->get_index_key_count ("Context.str") > 0) {
				enable_gu_7tr_optimization = true;
				Log ("Турбоиндекс ранее был обновлен \"сбоку\", поэтому значение параметра EnableGu7trOptimization равно 1 (в garant.ini 0)\n");
			}
			if (enable_gu_7tr_optimization)
				enable_gu_merge_optimization = true;

			if (b_isetalon)
				enable_gu_7tr_optimization = false;

		cycleWelcome:
			if ( !SilentMode && !SkipMode && !FromDownload && welcomeDlg.DoModal() == IDCANCEL ) {
				this->cancel_update (GblPilot::UCC_MANUAL);
				goto finish;
			}

		cycleMethod:
			if ( !SilentMode && !SkipMode /*&& !FromDownload*/ ) {
				aResult = methodDlg.DoModal();
				if ( aResult == IDBACK )
					goto cycleWelcome;
				else
				if ( aResult == IDCANCEL ) {
					this->cancel_update (GblPilot::UCC_MANUAL);
					goto finish;
				}
				bExtended = methodDlg.bExtended;
			}
			Log( bExtended ? "Выбран расширенный тип обновления\n" : "Выбран упрощенный тип обновления\n" );

		cycleDeltasFolder:
			if ( !SilentMode && !SkipMode && !FromDownload ) {
				aResult = deltasDlg.DoModal();
				if ( aResult == IDBACK )
					goto cycleMethod;
				else
				if ( aResult == IDCANCEL ) {
					this->cancel_update (GblPilot::UCC_MANUAL);
					goto finish;
				}
			}

			SkipMode = FALSE;
			aResult = collectPartsDlg.DoModal();
			if ( aResult == IDBACK )
				goto cycleDeltasFolder;
			else
			if ( aResult == IDCANCEL ) {
				this->cancel_update (GblPilot::UCC_MANUAL);
				goto finish;
			}

			aResult = unzipDlg.DoModal();
			if ( aResult == IDBACK )
				goto cycleDeltasFolder;
			else
				if ( aResult == IDCANCEL ) {
					this->cancel_update (GblPilot::UCC_MANUAL);
					goto finish;
				}

			aResult = badDeltasDlg.DoModal();
			if ( aResult == IDBACK ) {
				FromDownload = false;
				DeltaManager -> FreeDeltas();
				goto cycleDeltasFolder;
			} else if ( aResult == IDCANCEL ) {
				global_return_code = 2;
				this->cancel_update (GblPilot::UCC_MANUAL);
				goto finish;
			}

			DeltaManager->remoteType = 0;
			DeltaManager->serverType = 0;

			if ( DeleteZips ) {
				POSITION	posArchiveToDelete = Archives.GetHeadPosition();
				while ( posArchiveToDelete ) DeleteFile( Archives.GetNext( posArchiveToDelete ));
			}

			if ( DeltaManager -> Deltas -> getCount() == 0 || DeltaManager -> Status() == UPDATE_NONE ) {
				if ( DeltaManager -> Absents -> getCount() == 0 ) {
					if ( NoFinalMessage )
						TimeLog( IDS_NONEED );
					else
						OkBox( IDS_NONEED );

					this->cancel_update (GblPilot::UCC_DONT_NEED);
					goto finish;
				} else {
					TimeLog( IDS_UPDATENOLOG );
					for ( short I = 0; I < DeltaManager -> Absents -> getCount(); I++ ) {
						CString	atI( DeltaManager -> Absents -> at( I ));
						Log( "  " );
						Log( atI.GetBuffer( 0 ));
						Log( "\n" );
					}

					if ( NoFinalMessage ) {
						this->cancel_update (GblPilot::UCC_NO_SEGMENT);
						goto finish;
					}

					aResult = cantUpdateDlg.DoModal();
					if ( aResult == IDBACK ) {
						DeltaManager -> FreeDeltas();
						goto cycleDeltasFolder;
					}
					this->cancel_update (GblPilot::UCC_MANUAL);
					goto finish;
				}
			} else {
				BOOL aSuccess = FALSE;

				char rev_str [64];
				sprintf (rev_str, "%ld-%ld-%ld", DeltaManager->MinRevision.RevisionDate.da_day, DeltaManager->MinRevision.RevisionDate.da_mon, DeltaManager->MinRevision.RevisionDate.da_year);
				theApp.to_str = rev_str;

				if ( DeltaManager -> Absents -> getCount() > 0 ) {
					aResult = partUpdateDlg.DoModal();
					if ( aResult == IDBACK ) {
						DeltaManager -> FreeDeltas();
						goto cycleDeltasFolder;
					} else if ( aResult == IDCANCEL ) {
						this->cancel_update (GblPilot::UCC_MANUAL);
						goto finish;
					}

					TimeLog( IDS_PARTUPDATELOG );
					for ( short I = 0; I < DeltaManager -> Absents -> getCount(); I++ ) {
						CString	atI( DeltaManager -> Absents -> at( I ));
						Log( "  " );
						Log( atI.GetBuffer( 0 ));
						Log( "\n" );
					}
				} else {
					aResult = fullUpdateDlg.DoModal();
					if ( aResult == IDBACK ) {
						DeltaManager -> FreeDeltas();
						goto cycleDeltasFolder;
					} else if ( aResult == IDCANCEL ) {
						this->cancel_update (GblPilot::UCC_MANUAL);
						goto finish;
					}

				}

				if (SERVERNOTONTHISMACHINE) {
					CSelectRemoteTypeDlg remoteTypeDlg;
					if ( !bExtended || remoteTypeDlg.DoModal() == IDOK ) {
						if ( !bExtended )
							DeltaManager->remoteType = 1;
						else
							DeltaManager->remoteType = remoteTypeDlg.remoteType;

						if ( !DeltaManager->remoteType ) {
							//копируем на локал, обновляем, копируем обратно
							RemoteUpdate = true;
							CSelectBaseFolderEx selectFolderEx;
							if ( selectFolderEx.DoModal() == IDOK ) {
								MakePath( BasePath, DataPath, "data" );
								MakePath( ResultFile, DataPath, "RESULT" );

								TimeLog (IDS_STARTBACKUPLOG);
								waitDialog = new CWaitServerDialog();								
								bool stillOk = false;
								startWorking = false;
								GslDataPipe::FileReadingSet_var real_file_set = bu->get_base_files ();
								file_set = new GslDataPipe::FileReadingSet (real_file_set.in ());
								ACE_Thread_Manager* inst = ACE_Thread_Manager::instance ();
								if (inst->spawn ((ACE_THR_FUNC)write_files_to_disk, NULL, THR_DETACHED) == -1)
									FatalError( "Ошибка при создании потока копирования информационного банка" );
								else {
									while ( !startWorking ) ACE_OS::sleep(1);
									if ( !endWorking ) waitDialog->DoModal();
								}
								delete waitDialog;
								file_set = 0;
								real_file_set = 0;

								if ( write_files_to_disk_result == 2 ) {
									global_return_code = 4;
									theApp.send_internet_result ();
									FatalError( theApp.b_english_face ? "Cannot copy datastore. Not enough free space" : "Недостаточно места на диске для копирования информационного банка" );
								} else if ( write_files_to_disk_result == 1 ) {
									global_return_code = 4;
									theApp.send_internet_result ();
									FatalError( theApp.b_english_face ? "There was an error while copying datastore" : "Ошибка при копировании информационного банка" );
								} else {
									stillOk = true;
								}

								if ( stillOk ) {
									TimeLog( IDS_COPY2CLIENT );
									Log( DataPath );
									Log( "\n" );
									aSuccess = DeltaManager->ApplyDeltas();
								}
							}
						} else {
							//обновление на сервере
							CSelectServerUpdateTypeDlg remoteServerDlg;
							if ( !bExtended || remoteServerDlg.DoModal() == IDOK ) {
								if ( SilentMode && SyncBackup ) {
									TimeLog (IDS_BACKUPREFUSAL);
									DeltaManager->serverType = 1;
									char aLogString[128];
									Log( "\nПроверка свободного места, требуемого для обновления:\n" );
									sprintf( aLogString, "  есть: %I64d МБайт\n", (__int64)UpdateRunner::bu->get_free_space_for_sync()/1024 );
									Log( aLogString );
									sprintf( aLogString, "  надо: %I64d МБайт\n", (__int64)space_for_update()/1024 );
									Log( aLogString );
									if ( bu->get_free_space_for_sync() < space_for_update() ) {
										Log( "Возможно, места недостаточно!\n");
										if (!SkipWarning) {
											Log ("Обновление не начато\n");
											if (SilentMode) {
												goto finish;
											} else {
												FatalError (IDS_BASELOCKED);
											}
										}
									}
								} else if ( !bExtended ) {
									DeltaManager->serverType = 0;
									if ( SilentMode ) {
										char aLogString[128];
										Log( "\nПроверка свободного места, требуемого для обновления:\n" );
										sprintf( aLogString, "  есть: %I64d МБайт\n", (__int64)UpdateRunner::bu->get_free_space_for_sync()/1024 );
										Log( aLogString );
										sprintf( aLogString, "  надо: %I64d МБайт\n", (__int64)space_for_update()/1024 );
										Log( aLogString );
										if ( bu->get_free_space_for_sync() < space_for_update() ) {
											Log( "Возможно, места недостаточно!\n");
										}
									}
								} else {
									DeltaManager->serverType = remoteServerDlg.remoteType;
									if ( DeltaManager->serverType ) {
										//с отключением пользователей
										space_checked = true;
										char aLogString[128];
										Log( "\nПроверка свободного места, требуемого для обновления:\n" );
										sprintf( aLogString, "  есть: %I64d МБайт\n", (__int64)UpdateRunner::bu->get_free_space_for_sync()/1024 );
										Log( aLogString );
										sprintf( aLogString, "  надо: %I64d МБайт\n", (__int64)space_for_update()/1024 );
										Log( aLogString );
										if ( bu->get_free_space_for_sync() < space_for_update() ) {
											Log( "Возможно, места недостаточно!\n");
											if ( !SilentMode && !YesNoBox( IDS_SMALLFREESPACE ))
												FatalError( IDS_BASELOCKED );
										}
									}
								}

								aSuccess = DeltaManager->ApplyDeltas();
							}
						}
					}
				} else {
					if ( SilentMode || !bExtended || selectBaseFolder.DoModal() == IDOK ) {
						bool stillOk = true;
						update_copy = true;
						if ( SilentMode || !bExtended ) {
							if ( SyncBackup ) {
								TimeLog (IDS_BACKUPREFUSAL);
								char aLogString[128];
								Log( "\nПроверка свободного места, требуемого для обновления:\n" );
								sprintf( aLogString, "  есть: %I64d МБайт\n", (__int64)UpdateRunner::bu->get_free_space_for_sync()/1024 );
								Log( aLogString );
								sprintf( aLogString, "  надо: %I64d МБайт\n", (__int64)space_for_update()/1024 );
								Log( aLogString );
								if ( UpdateRunner::bu->get_free_space_for_sync() < space_for_update())
									Log( "Возможно, места недостаточно!\n");

								try {
									strcpy( BasePath, UpdateRunner::bu->sync_update_start());
								}
								catch(GblPilot::UpdateAlreadyStarted&) {
									if ( NoFinalMessage )
										TimeLog( IDS_UPDATERUN );
									else
										FatalMessage( IDS_UPDATERUN );
									stillOk = false;
								}
							} else {
								char aLogString[128];
								Log( "\nПроверка свободного места, требуемого для обновления:\n" );
								sprintf( aLogString, "  есть: %I64d МБайт\n", (__int64)UpdateRunner::bu->get_free_space_for_async()/1024 );
								Log( aLogString );
								sprintf( aLogString, "  надо: %I64d МБайт + %I64d МБайт, итого: %I64d МБайт\n", (__int64)space_for_update()/1024, (__int64)base_size()/1024, ((__int64)space_for_update() + (__int64)base_size())/1024 );
								Log( aLogString );
								if (UpdateRunner::bu->get_free_space_for_async() < space_for_update() + base_size()) {
									Log( "Возможно, места недостаточно!\n");
									if (!SkipWarning && SilentMode) {
										stillOk = false;
									} else if (!SilentMode) {
										if ( !YesNoBox (IDS_SMALLFREESPACE))
											stillOk = false;
									}
								}

								if ( stillOk ) {
									waitDialog = new CWaitServerDialog();								
									startWorking = false;
									ACE_Thread_Manager* inst = ACE_Thread_Manager::instance ();
									TimeLog (IDS_STARTBACKUPLOG);
									if (inst->spawn ((ACE_THR_FUNC)bu_update_start, NULL, THR_DETACHED) == -1) {
										if (SilentMode || NoFinalMessage)
											Log ("Ошибка при создании потока копирования информационного банка\n");
										else
											FatalError ("Ошибка при создании потока копирования информационного банка");
									} else {
										while ( !startWorking ) ACE_OS::sleep(1);
										if ( !endWorking ) waitDialog->DoModal();
									}
									delete waitDialog;
									TimeLog (bu_update_start_result ? IDS_ENDBACKUPLOG_ERROR : IDS_ENDBACKUPLOG);

									if ( bu_update_start_result == 1 ) {
										global_return_code = 4;
										theApp.send_internet_result ();
										this->cancel_update (GblPilot::UCC_UPDATE_RUN);
										if (SilentMode || NoFinalMessage)
											TimeLog (IDS_UPDATERUN);
										else
											FatalMessage (IDS_UPDATERUN);
										stillOk = false;
									} else
									if ( bu_update_start_result == 2 ) {
										global_return_code = 4;
										theApp.send_internet_result ();
										this->cancel_update (GblPilot::UCC_NOT_ENOUGH_SPACE);
										if (SilentMode || NoFinalMessage)
											Log ("Недостаточно места на диске для копирования информационного банка\n" );
										else
											FatalMessage( theApp.b_english_face ? "Cannot copy datastore. Not enough free space" : "Недостаточно места на диске для копирования информационного банка" );
										stillOk = false;
									} else
									if ( bu_update_start_result == 4 ) {
										global_return_code = 4;
										theApp.send_internet_result ();
										this->cancel_update (GblPilot::UCC_UNKNOWN_COPY_ERROR);
										if (SilentMode || NoFinalMessage)
											Log ("Ошибка при копировании информационного банка\n");
										else
											FatalMessage( theApp.b_english_face ? "There was an error while copying datastore" : "Ошибка при копировании информационного банка" );
										stillOk = false;
									}
								}
							}
						} else {
							if ( !space_checked ) {
								char aLogString[128];
								Log( "\nПроверка свободного места, требуемого для обновления:\n" );
								sprintf( aLogString, "  есть: %I64d МБайт\n", (__int64)UpdateRunner::bu->get_free_space_for_sync()/1024 );
								Log( aLogString );
								sprintf( aLogString, "  надо: %I64d МБайт\n", (__int64)space_for_update()/1024 );
								Log( aLogString );

								if ( UpdateRunner::bu->get_free_space_for_sync() < space_for_update() ) {
									Log( "Возможно, места недостаточно!\n");
									if ( !SilentMode && !YesNoBox( IDS_SMALLFREESPACE )) {
										stillOk = false;
									}
								}
							}
						}

						strcpy( DataPath, BasePath );
						if ( strrchr( DataPath, '\\' )) *strrchr( DataPath, '\\' ) = '\0';
						MakePath( ResultFile, DataPath, "RESULT" );
						if ( stillOk )
							aSuccess = DeltaManager -> ApplyDeltas();
						else
							aSuccess = false;
					}
				}

				if ( aSuccess || !BaseUpdated ) {
					if ( aSuccess ) {
						if (canupdatedataorg) TuneProtInfo();
						if ( RemoteUpdate ) {
							CSelectRemoteUpdateTypeDlg remoteUpdateType;
							if ( remoteUpdateType.DoModal() == IDOK ) {
								GslDataPipe::FileReadingSet_var real_file_set = get_file_set( DataPath );

								space_checked = true;
								if ( remoteUpdateType.updateType == 0 ) {
									char aLogString[128];
									Log( "\nПроверка свободного места, требуемого для обновления:\n" );
									sprintf( aLogString, "  есть: %I64d МБайт\n", (__int64)UpdateRunner::bu->get_free_space_for_async()/1024 );
									Log( aLogString );
									sprintf( aLogString, "  надо: %I64d МБайт + %I64d МБайт, итого: %I64d МБайт\n", (__int64)space_for_update()/1024, (__int64)base_size()/1024, ((__int64)space_for_update() + (__int64)base_size())/1024 );
									Log( aLogString );
									if ( bu->get_free_space_for_async() < space_for_update() + base_size() ) {
										Log( "Возможно, места недостаточно!\n");
										if ( !SilentMode && !YesNoBox( IDS_SMALLFREESPACE ))
											FatalError( IDS_BASELOCKED );
									}
								} else {
									char aLogString[128];
									Log( "\nПроверка свободного места, требуемого для обновления:\n" );
									sprintf( aLogString, "  есть: %I64d МБайт\n", (__int64)UpdateRunner::bu->get_free_space_for_sync()/1024 );
									Log( aLogString );
									sprintf( aLogString, "  надо: %I64d МБайт\n", (__int64)space_for_update()/1024 );
									Log( aLogString );
									if ( bu->get_free_space_for_sync() < space_for_update() ) {
										Log( "Возможно, места недостаточно!\n");
										if ( !SilentMode && !YesNoBox( IDS_SMALLFREESPACE ))
											FatalError( IDS_BASELOCKED );
									}
								}

								wait1Dialog = new CWaitServer1Dialog();
								startWorking = false;
								file_set = new GslDataPipe::FileReadingSet (real_file_set.in ());
								ACE_Thread_Manager* inst = ACE_Thread_Manager::instance ();
								if (inst->spawn ((ACE_THR_FUNC)bu_remote_update, &remoteUpdateType.updateType, THR_DETACHED) == -1)
									FatalError( "Ошибка при создании потока копирования информационного банка\n" );
								else {
									while ( !startWorking ) ACE_OS::sleep(1);
									if ( !endWorking ) wait1Dialog->DoModal();
								}
								delete wait1Dialog;

								if (bu_remote_update_result) {
									global_return_code = 4;
									theApp.send_internet_result ();
								}

								if ( bu_remote_update_result == 1 )
									FatalError( IDS_ACCESSDENIED );
								else
								if ( bu_remote_update_result == 2 )
									FatalError( IDS_COPYPROCESSFAILED );
								else
								if ( bu_remote_update_result == 3 )
									FatalError( IDS_NOTENOUGHROOM2 );
								else
								if ( bu_remote_update_result == 4 )
									FatalError( "remote_update(): неизвестное исключение" );
								else {
									TimeLog( IDS_COPYOK );
									for (CORBA::ULong i = 0; i < real_file_set->length (); i++) {
										char aFileName[ MAX_PATH ];
										MakePath( aFileName, DataPath, (char*)real_file_set[i].m_name.in() );
										DeleteFile( aFileName );
									}
								}
								real_file_set = 0;
							} else {
								GslDataPipe::FileReadingSet_var real_file_set = get_file_set( DataPath );
								for (CORBA::ULong i = 0; i < real_file_set->length (); i++) {
									char aFileName[ MAX_PATH ];
									MakePath( aFileName, DataPath, (char*)real_file_set[i].m_name.in() );
									real_file_set[i].m_data_reading->remove_reference ();
									DeleteFile( aFileName );
								}
								real_file_set = 0;
								NoFinalMessage = true;
							}
						} else {
							if ( !DeltaManager->remoteType ) {
								wait2Dialog = new CWaitServer2Dialog();
								startWorking = false;
								ACE_Thread_Manager* inst = ACE_Thread_Manager::instance ();
								if (inst->spawn ((ACE_THR_FUNC)bu_update_complete, NULL, THR_DETACHED) == -1)
									FatalError( "Завершение обновления: ошибка при создании потока" );
								else {
									while ( !startWorking ) ACE_OS::sleep(1);
									if ( !endWorking ) wait2Dialog->DoModal();
								}
								delete wait2Dialog;
								if (bu_remote_update_result) {
									global_return_code = 4;
									theApp.send_internet_result ();
									BadExit ();
								}
							}
						}

						CTimeSpan runTime = DeltaManager -> EndTime - DeltaManager-> StartTime;
						CString aFinalMessage;
						aFinalMessage.Format( IDS_BASEUPDATED, runTime.GetHours(), runTime.GetMinutes(), runTime.GetSeconds());
						theApp.send_internet_result ();

						if ( NoFinalMessage )
							Log( aFinalMessage.GetBuffer( 0 ));
						else
							OkBox( aFinalMessage );
					} else {
						if ( NoFinalMessage )
							if (update_copy)
								Log (IDS_NOTUPDATED);
							else
								Log (IDS_BASEDEAD);
						else {
							if (!aSuccess && !update_copy && !BaseUpdated) {
								Log (IDS_BASEDEAD);
								FatalMessage (IDS_BASEDEAD);
							} else if (update_copy || !BaseUpdated) {
								TimeLog (IDS_NOTUPDATED);
								OkBox (IDS_NOTUPDATED);
							} else {
								Log (IDS_BASEDEAD);
								FatalMessage (IDS_BASEDEAD);
							}
						}
					}
				} else {
					if (NoFinalMessage)
						Log (IDS_BASEDEAD);
					else {
						Log (IDS_BASEDEAD);
						FatalError (IDS_BASEDEAD);
					}
				}
			}
		} catch(CORBA::Exception&) {
				this->cancel_update (GblPilot::UCC_SERVER_SIDE_ERROR);
		}
		catch(...) {
				CString str;
				str = CString("Неизвестное исключение при обновлении");
				FatalError ( str );
				this->cancel_update (GblPilot::UCC_UNKNOWN_ERROR);
		}
	}

finish:
	theApp.send_internet_result ();
	//NormalExit(); //ses: ploho! static varibales not destroyed
	CloseHandle (UpdateHandle);
	DeleteGarbage ();
//	status (GCM::cs_exit_requested);   //зачем это здесь, если уже делается в DeleteGarbage
}

void CUpdateApp::read_from_ini (LPCTSTR key_name, LPSTR str, DWORD sz) {
	if (0 == m_ini_name.size ())
		m_ini_name = Core::ParamManagerFactory::get ().get_string ("-GCMConfigFile");
	ACE_OS::memset (str, 0, sz);
	::GetPrivateProfileString ("Downloader", key_name, _T (""), str, sz, m_ini_name.c_str ());
}

Internet::InternetAccessInfo m_access_info;

void CUpdateApp::read_inet_settings () {
	class Local {
	public:
		static char* decode (const char *key) {
			if (0 == strlen (key)) {
				return strdup (key);
			}
			if (1024 <= strlen (key)) {
				assert (0);
			}
			unsigned char s [1024];
			int j = 0;
			for (unsigned i = 0; i < strlen (key); i += 2) {
				int code = ('A' <= key [i] && 'F' >= key [i]) ? 16 * (key [i] - 65 + 10) : 16 * (key [i] - 48);
				code += ('A' <= key [i + 1] && 'F' >= key [i + 1]) ? (key [i + 1] - 65 + 10) : (key [i + 1] - 48);
				s [j++] = code;
			}
			GCL::SimpleCrypto::Buffer buf_in ((void*)s, j);
			GCL::SimpleCrypto::Buffer buf_out;
			GCL::SimpleCrypto cryp;
			cryp.decrypt (buf_in, buf_out);
			if (1024 <= buf_out.m_len) {
				assert (0);
			}

			char* ret = (char*) malloc ((buf_out.m_len + 1) * sizeof (char));
			memcpy (ret, buf_out.m_buf, buf_out.m_len);
			ret [buf_out.m_len] = '\0';
			return ret;
		}
	};

	char buffer [512];

	*buffer = 0;

	this->read_from_ini ("accesstype", buffer, sizeof (buffer));

	if (strlen (buffer)) {
		m_access_info.access_type = atoi (buffer);
	} else {
		m_access_info.access_type = INTERNET_OPEN_TYPE_PRECONFIG;
	}

	m_access_info.open_query_flags = 0;

	this->read_from_ini ("proxyadress", buffer, sizeof (buffer));
	m_access_info.proxy_info.host = buffer;
	this->read_from_ini ("proxyport", buffer, sizeof (buffer));
	m_access_info.proxy_info.port = buffer;
	this->read_from_ini ("proxylogin", buffer, sizeof (buffer));
	{
		char* res = Local::decode (buffer);
		if (res) {
			m_access_info.proxy_info.login = res;
			free (res); 
		}
	}
	this->read_from_ini ("proxypassword", buffer, sizeof (buffer));
	{
		char* res = Local::decode (buffer);
		if (res) {
			m_access_info.proxy_info.password = Local::decode (buffer);
			free (res); 
		}
	}
	this->read_from_ini ("proxyauthentication", buffer, sizeof (buffer));
	m_access_info.proxy_info.is_authentication = (atol (buffer) == 1);
}

void	CUpdateApp::send_internet_result ()
{
	if (b_result_send)
		return;

	b_result_send = true;

	read_inet_settings ();

	try {
		Internet::Inet_i::Connect_i_factory_var factory = new  Internet::Inet_i::Connect_i_factory ();
		factory->registrate_me (0);
	} catch(...) {}

	try {
		Internet::Inet_i::Connection_i_factory_var factory = new Internet::Inet_i::Connection_i_factory ();
		factory->registrate_me (0);
	} catch(...) {}

	try {
		Internet::ConnectManager* manager = Internet::ConnectManager::instance ();
		manager->init (m_access_info, true);
		Internet::IConnect_var connect = Internet::ConnectManager::instance ()->get_connect ();

		std::string host = Core::ParamManagerFactory::get ().get_string ("-DSHost").c_str ();
		if (0 == host.size ()) host = "datasetup.garant.ru";
		connect->execute (host, AfxGetAppName ());

		Internet::IConnection_var m_connection = connect->get_connection ();

		/*
		int	global_return_code = 1;
		//0 - все хорошо, дельта применилась
		//1 - пользователь вышел
		//2 - вышел, но были плохие дельты
		//3 - упало все нафик
		//4 - не смогли переключиться
		*/
		long	update_status = global_return_code;
		/*
		0 - успех
		1 - не смогли начать обновление (не смогли создать копию, etc)
		2 - обновление упало;
		3 - gu/gl отработали, но сервер не смог переключиться на новую базу. 
		*/
		switch (global_return_code) {
			case 2:
				update_status = 1;
				break;
			case 3:
				update_status = 2;
				break;
			case 4:
				update_status = 3;
				break;
		}

		char request [128];
		sprintf (request, "/datasetup/update?key=%s&from=%s&to=%s&status=%ld&time=%ld", pers_key.c_str (), theApp.from_str.c_str (), theApp.to_str.c_str (), update_status, update_seconds);

		try {
			if (m_connection->open_request (request, "Accept: application/json,*/*\r\nAccept-Encoding: identity\r\n")) {
				try {
					m_connection->send_request ();
				} catch (...) {}
			}
		} catch (...) {}
	} catch (...) {}
}

void CUpdateApp::ApplyPatches()
{
	CStringList	aPatchInis;

	char	aPatchFileMask[ MAX_PATH ];
	MakePath( aPatchFileMask, DeltaPath, "PATCH*.INI" );
	WIN32_FIND_DATA	findData;
	HANDLE	aFindResult = FindFirstFile( aPatchFileMask, &findData );
	while ( aFindResult != INVALID_HANDLE_VALUE )
	{
		if ( ( findData.dwFileAttributes & FILE_ATTRIBUTE_DIRECTORY ) == 0 )
		{
			char	aPatchFileName[ MAX_PATH ];
			MakePath( aPatchFileName, DeltaPath, findData.cFileName );
			UINT	aPatchID = 	GetPrivateProfileInt( "Patch", "ID", 0, aPatchFileName );
			if ( aPatchID )
			{
				POSITION	aPos = aPatchInis.GetHeadPosition();
				while ( aPos && aPatchID > GetPrivateProfileInt( "Patch", "ID", 0, aPatchInis.GetAt( aPos )))
					aPatchInis.GetNext( aPos );
				if ( aPos )
					aPatchInis.InsertBefore( aPos, aPatchFileName );
				else
					aPatchInis.AddTail( aPatchFileName );
			}
		}

		if ( !FindNextFile( aFindResult, &findData ))
			break;
	}
	FindClose( aFindResult );

	POSITION aPos = aPatchInis.GetHeadPosition();
	while ( aPos )
	{
		int		aNewUpdate;
		BOOL	aResult = ApplyPatch( aPatchInis.GetNext( aPos ), aNewUpdate );

		if ( aNewUpdate == 2 )
		{
			char	aUpdateNew[ MAX_PATH ];
			ForceExt( strcpy( aUpdateNew, UpdateExe ), "NEW" );
			UpdateExe = aUpdateNew;
		}

		if ( aNewUpdate )
		{
			char aLogString[ MAX_PATH * 2 ];
			sprintf( aLogString, "Пускаем новый Update: %s\n", UpdateExe );
			Log( aLogString );

			CString	aCmdLine = UpdateExe + " " + m_lpCmdLine;
			aCmdLine += " SKIP ";
			aCmdLine += DeltaPath;

			PROCESS_INFORMATION	processInfo;
			STARTUPINFO	startupInfo;
			memset( &startupInfo, 0, sizeof( startupInfo ));
			if ( CreateProcess( NULL, aCmdLine.GetBuffer( 0 ), NULL, NULL, FALSE, CREATE_SUSPENDED, NULL, NULL, &startupInfo, &processInfo ))
			{
				CloseHandle( UpdateHandle );
				DeleteGarbage();
				::ResumeThread( processInfo.hThread );
				exit( EXIT_SUCCESS );
			}
		}

		if ( !aResult )
			break;
	}
}

int CUpdateApp::ExitInstance () {
	CWinApp::ExitInstance ();

	return global_return_code;
}

BOOL CUpdateApp::InitInstance()
{
	b_english_face = false;
#if defined (_GCD_CLIENT) || defined (PILOT)
	class AutoInitFini {
	public:
		AutoInitFini () {
			Core::init ();
		};
		~AutoInitFini () {
			Core::fini ();
		};
	};
	AutoInitFini auto_init_fini;
#endif

#ifdef _AFXDLL
	Enable3dControls();
#else
	Enable3dControlsStatic();
#endif

	char	aCurDir[ MAX_PATH ];
	GetModuleFileName( NULL, aCurDir, MAX_PATH );
	UpdateExe = aCurDir;
	*strrchr( aCurDir, '\\' ) = '\0';
	strcpy( GarantPath, aCurDir );

	CheckArgs();
	char	aUpdateEvent[ MAX_PATH ];
	ReplaceSlashes( strupr( strcat( strcpy( aUpdateEvent, "UPDATERUN-" ), GarantPath )));
	if ( OpenEvent( EVENT_ALL_ACCESS, FALSE, aUpdateEvent ))
		if ( NoFinalMessage ) {
			TimeLog( IDS_UPDATERUN );
			NormalExit();
		}
		else
			FatalError( IDS_UPDATERUN );
	UpdateHandle = CreateEvent( NULL, TRUE, TRUE, aUpdateEvent );

	DeltaPath[0] = '\0';
	CheckArgs();

	try {
		Core::ParamManagerReg::instance ();

		if (0 == Core::ParamManagerFactory::get ().init (Core::ParamConvert::make_arg_list (__argc, __argv), GCL::F1::DATA_UPDATE)) {
			throw Core::DataNotFound ();
		}

		char garant_ini [MAX_PATH];
		strcpy (garant_ini, Core::ParamManagerFactory::get ().get_string ("-GCMConfigFile").c_str ());
		if (strlen (garant_ini)) {
			char* slash = strrchr (garant_ini, '\\');
			if (slash) *slash = '\0';
			strcpy (GarantPath, garant_ini);
		}

		if (Core::ParamManagerFactory::get ().is_exist ("-eng")) {
			b_english_face = true;
			LPTSTR file_name = PathFindFileName (__argv [0]);
			PathRemoveExtension (file_name);

			std::string resource_name = file_name;
			resource_name += "_eng";
			
			this->set_local_resource (resource_name.c_str ());
		}

		GCM::GCMManager_ptr theManager = GCM::GCM_get_manager ();

		theManager->register_local_component(aUpdateRunner=new UpdateRunner());
		theManager->register_component(new GblPilot::PilotClientHome());
		theManager->register_component(new GslHeartbeatManager::HeartbeatManagerClientHome());
		theManager->register_component(new GslUserManager::UserManagerClientHome());
        theManager->register_local_component(new GslSessionHandlerClientServer::SessionHandlerClientServerHome);
		theManager->register_component(new GslSecurity::SecurityClientHome());
		theManager->start_components(true);
	} catch (GCM::AutoIPConfig::ServerNotFound&) {
		b_result_send = true;
		CString str;
		str.LoadString (IDS_SERVER_NOT_FOUND);
		Core::fini();
		if ( NoFinalMessage ) {
			Log( str.GetBuffer(0) );
			BadExit();
		}
		else
			FatalError (str);
	} catch (GCM::NoServer&) {
		b_result_send = true;
		CString str;
		str.LoadString (IDS_SERVER_NOT_FOUND);
		GCM::GCMManager_ptr theManager = GCM::GCM_get_manager ();
		try {
			theManager->stop_components ();
		} catch (...) {
			// в зависимости от ситуации stop_components может выполнится, а может нет!!!!
			// если не может выполнится возможны утечки
		}
		aUpdateRunner = 0;
		Core::fini ();

		if ( NoFinalMessage ) {
			Log( str.GetBuffer(0) );
			BadExit();
		}
		else
			FatalError (str);
	} catch (GCM::ServerIsStarting&) {
		b_result_send = true;
		CString str;
		str.LoadString (IDS_SERVER_IS_STARTING);
		GCM::GCMManager_ptr theManager = GCM::GCM_get_manager ();
		try {
			theManager->stop_components ();
		} catch (...) {
			// в зависимости от ситуации stop_components может выполнится, а может нет!!!!
			// если не может выполнится возможны утечки
		}
		aUpdateRunner = 0;
		Core::fini ();

		if ( NoFinalMessage ) {
			Log( str.GetBuffer(0) );
			BadExit();
		}
		else
			FatalError (str);
	} catch (GCM::AutoIPConfig::BadNetworkConfig&) {
		b_result_send = true;
		CString str;
		str.LoadString (IDS_BAD_NETWORK_CONFIG);
		Core::fini();
		if ( NoFinalMessage ) {
			Log( str.GetBuffer(0) );
			BadExit();
		}
		else
			FatalError (str);
	} catch (GCM::AutoIPConfig::IPAddressNotFound&) {
		b_result_send = true;
		CString str;
		str.LoadString (IDS_IP_ADDRESS_NOT_FOUND);
		Core::fini();
		if ( NoFinalMessage ) {
			Log( str.GetBuffer(0) );
			BadExit();
		}
		else
			FatalError (str);
	} catch (Core::DataNotFound&) {
		b_result_send = true;
		CString str;
		str.LoadString (IDS_DATANOTFOUND);
		Core::fini();
		if ( NoFinalMessage ) {
			Log( str.GetBuffer(0) );
			BadExit();
		}
		else
			FatalError (str);
	} catch (GCM::InvalidName&) {
		b_result_send = true;
		CString str;
		str.LoadString (IDS_TRANSIENT);
		Core::fini();
		if ( NoFinalMessage ) {
			Log( str.GetBuffer(0) );
			BadExit();
		}
		else
			FatalError (str);
	} catch (CORBA::TRANSIENT&) {
		b_result_send = true;
		CString str;
		str.LoadString (IDS_TRANSIENT);
		Core::fini();
		if ( NoFinalMessage ) {
			Log( str.GetBuffer(0) );
			BadExit();
		}
		else
			FatalError (str);
	} catch (CORBA::Exception& ex) {
		b_result_send = true;
		CString str;
		str = CString ("CORBA::Исключение ") + ex._rep_id ();
		Core::fini();
		if ( NoFinalMessage ) {
			Log( str.GetBuffer(0) );
			BadExit();
		}
		else
			FatalError (str);
	} catch (...) {
		b_result_send = true;
		Core::fini();
		CString str = "register_... or start_component(): неизвестное исключение"; 
		if ( NoFinalMessage ) {
			Log( str.GetBuffer(0) );
			BadExit();
		}
		else
			FatalError (str);
	}
	gugl_fileset = 0;
	file_set = 0;

	return FALSE;
}

void    FatalError( UINT aMessageID, CString aAdd, UINT aTitleID, CWnd* mainwindow )
{
	if ( mainwindow )
		mainwindow->EnableWindow(FALSE);

	CFatalErrorDlg	fatalDlg( aMessageID, aAdd, aTitleID );
	fatalDlg.DoModal();

	if ( mainwindow )
		mainwindow->EnableWindow(TRUE);

	CloseHandle( UpdateHandle );
	DeleteGarbage();
	exit (3);
}

void	FatalMessage( UINT aMessageID, CString aAdd, UINT aTitleID )
{
	CFatalErrorDlg	fatalDlg( aMessageID, aAdd, aTitleID );
	fatalDlg.DoModal();
}

void	FatalMessage( CString aMessage )
{
	CFatalErrorDlg fatalDlg( aMessage );
	fatalDlg.DoModal();
}

void	BadExit()
{
	CloseHandle( UpdateHandle );
	DeleteGarbage();
	exit (3);
}

void	FatalError( CString aMessage )
{
	theApp.send_internet_result ();
	FatalMessage( aMessage );
	BadExit();
}

void	OkBox( UINT aMessageID, UINT aTitle, UINT aIcon )
{
	CFatalErrorDlg fatalDlg( aMessageID, "", aTitle, aIcon );
	fatalDlg.DoModal();
}

void	OkBox( CString aMessage, UINT aTitle, UINT aIcon )
{
	CFatalErrorDlg fatalDlg( aMessage, aTitle, aIcon );
	fatalDlg.DoModal();
}

BOOL	YesNoBox( UINT aMessageID, CWnd* mainwindow ) {
	return YesNoBox( aMessageID, IDS_CONFIRM, IDI_BEWARNING, "", mainwindow );
}

BOOL	YesNoBox( UINT aMessageID, UINT aTitleID, UINT aIconID, CString aAdd, CWnd* mainwindow )
{
	if ( mainwindow )
		mainwindow->EnableWindow(FALSE);

	CConfirmDlg confirmDlg( aMessageID, aTitleID, aIconID, aAdd );
	INT_PTR domodal = confirmDlg.DoModal(); 

	if ( mainwindow ) {
		mainwindow->EnableWindow(TRUE);
		mainwindow->BringWindowToTop();
	}

	return ( domodal == IDYES );
}

void	NormalExit()
{
	CloseHandle( UpdateHandle );
	DeleteGarbage();
	exit (global_return_code);
}

//////////////////////////////////////////////////////////////////////////////

TDelta :: TDelta( revision aFrom, revision aTo )
{
	From      = aFrom;
	To        = aTo;
	Segments  = new TShortCollection(  5,5 );
	FileNames = new TStringCollection( 5,5 );
	State     = DELTA_NONE;
}

TDelta :: ~TDelta()
{
	delete Segments;
	delete FileNames;
}

BOOL	TDelta :: AddDelta( char* aFileName, UpdateDHReader *dhReader )
{
	BOOL	aFound = FALSE;
	short	aSegsCount = 0;
	short	*aSegs = dhReader -> LoadSegs( aSegsCount );

	short I = 0; // GARANT_FORSCOPING
	for ( I = 0; I < aSegsCount; I++ )
		if ( Segments -> indexOf( aSegs[ I ] ) != -1 )
			aFound = TRUE;

	if ( aFound )
	{
		// дельта к сегментам, которые уже будут обновлены другой, ранее
		// встреченной дельтой, напримео сначала была найдена дельта для сегмента,
		// а потом дельта для Максимума. Правильнее было бы вышибать в этом случае
		// дельту сегмента, но ситуация редкая и должна исправляться на сервере ПП.
		free( aSegs );
		return FALSE;
	}

	aFound = FALSE;
	for ( I = 0; I < aSegsCount; I++ )
		if ( Segments -> indexOf( aSegs[ I ] ) == -1 )
		{
			aFound = TRUE;
			Segments -> add( newShort( aSegs[ I ] ));
		}

	if ( aFound ) FileNames -> add( newStr( aFileName ));
	free( aSegs );

	Version = dhReader -> dhReader -> Version();

	return TRUE;
}

short	TDelta :: CheckDelta( UpdateDHReader *dhReader )
{
	return ( CompRevs( &From, &dhReader -> GetOldRev() ) == 0 ) && ( CompRevs( &To, &dhReader -> GetNewRev() ) == 0 );
}

//////////////////////////////////////////////////////////////////////////////

TDeltaManager :: TDeltaManager( revision aFrom, revision aToday, short aMerged )
{
	Merged   = aMerged;
	From     = aFrom;
	Today    = aToday;
	Deltas   = new TDeltaCollection( 5, 10 );
	Segments = new TShortCollection( 5, 10 );
	BadDeltas= new TStringCollection( 5,10 );
	BadDescs = new TStringCollection( 5,10 );	
	SegmentNames = new TStringCollection( 5,10 );
	SegmentFiles = new TStringCollection( 5,10 );
	Absents      = new TStringCollection( 5,10 );
}

TDeltaManager :: ~TDeltaManager()
{
	delete Deltas;
	delete Segments;
	delete BadDeltas;
	delete BadDescs;
	delete SegmentNames;
	delete SegmentFiles;
	delete Absents;
}

void	TDeltaManager :: FreeDeltas()
{
	BadDeltas -> freeAll();
	BadDescs  -> freeAll();
	Deltas    -> freeAll();
	Absents   -> freeAll();
}

void	TDeltaManager :: AddSegment( short aSegment, char* aSegmentName, char* aSegmentFile )
{
	Segments -> add( newShort( aSegment ));
	SegmentNames -> add( newStr( aSegmentName ));
	SegmentFiles -> add( newStr( aSegmentFile ));
}

char*	TDeltaManager :: SegmentName( short aId )
{
	for ( short I = 0; I < Segments -> getCount(); I++ )
		if ( Segments -> at( I ) == aId )
			return SegmentNames -> at( I );
	return NULL;
}

char*	TDeltaManager :: SegmentFile( short aId )
{
	for ( short I = 0; I < Segments -> getCount(); I++ )
		if ( Segments -> at( I ) == aId )
			return SegmentFiles -> at( I );
	return NULL;
}

void	TDeltaManager :: AddDelta( char* aFileName, UpdateDHReader* dhReader )
{
	CString	aDesc;
	
	if ( CompRevs( &From, &dhReader -> GetOldRev()) > 0 ) {
		//! наличие старых дельт - не криминал. Но они не будут стерты, поскольку
		//  не применялись. Тем самым место на диске занимаем, а о том, что его
		//  можно освободить, не сообщаем.
		/*
		BadDeltas -> add( newStr( aFileName ));
		aDesc.LoadString( IDS_OLDDELTA );
		BadDescs -> add( newStr( aDesc.GetBuffer( 0 )));
		*/
		return ;
	}

	TShortCollection	badSegs( 5, 5 );
	
	short	aSegsCount = 0;
	short*	aSegs = dhReader -> LoadSegs( aSegsCount );
	short	Invalids = 0;
	short I = 0; // GARANT_FORSCOPING
	for ( I = 0; I < aSegsCount; I++ ) {
		BOOL	aFound = FALSE;
		for ( short J = 0; J < Segments -> getCount(); J++ )
			if ( Segments -> at( J ) == aSegs[ I ] ) {
				aFound = TRUE;
				break;
			}

			if ( !aFound ) {
				Invalids++;
				badSegs.add( newShort( aSegs[ I ] ));
			}
	}
	free( aSegs );

	if ( Invalids > 0 || ( !Merged && aSegsCount > 1 )) {
		// в дельте есть лишние сегменты (которых нет в установленном банке)
		BadDeltas -> add( newStr( aFileName ));
		aDesc.LoadString( IDS_UNSEGS );
		if ( badSegs.getCount() && baseInfoNames.getCount() ) {
			for ( short I = 0; I < badSegs.getCount(); I++ ) {
				if ( I ) aDesc += ", ";	else aDesc += ": ";
				aDesc += "\"";
				aDesc += BaseIdName( badSegs.at( I ));
				aDesc += "\"";
			}

			Log( "Дельта " );
			char* aSlashPos = strrchr( aFileName, '\\' );
			if ( aSlashPos )
				Log( aSlashPos + 1 );
			else
				Log( aFileName );
			Log( ": " );
			Log( aDesc.GetBuffer( 0 ));
			Log( "\n" );
		}
		BadDescs  -> add( newStr( aDesc.GetBuffer( 0 )));
		return;
	}

	int a_dup_index = -1;
	TDelta*	aFound = NULL;
	for ( I = 0; I < Deltas -> getCount(); I++ )
		if ( Deltas -> at( I ) -> CheckDelta( dhReader ))
		{
			// найдена дельта за аналогичный период
			a_dup_index = I;
			aFound = Deltas -> at( I );
			break;
		}

	if ( !aFound )
	{
		// дельта с новым периодом, надо ее добавить
		aFound = new TDelta( dhReader -> GetOldRev(), dhReader -> GetNewRev() );
		Deltas -> insert( aFound );
	}

	// добавляем к периоду рассматриваемую дельту:
	// имя файла и сегменты, которые она обновляет
	if ( !aFound -> AddDelta( aFileName, dhReader )) {
		BadDeltas -> add( newStr( aFileName ));
		if (a_dup_index != -1) {
			char* dup_filename = Deltas->at (I)->FileNames->at (0);
			if (strrchr (dup_filename, '\\'))
				dup_filename = strrchr (dup_filename, '\\') + 1;
			aDesc.Format (IDS_DUP, dup_filename);
		} else {
			aDesc.LoadString( IDS_UNSEGS );
		}
		BadDescs -> add( newStr( aDesc.GetBuffer( 0 )));

		Log( "Дельта " );
		char* aSlashPos = strrchr( aFileName, '\\' );
		if ( aSlashPos )
			Log( aSlashPos + 1 );
		else
			Log( aFileName );
		Log( ": " );
		Log( aDesc.GetBuffer( 0 ));
		Log( "\n" );
	}
}

void	TDeltaManager :: Check()
{
	// Шаг первый. Проверить, полностью ли период обновляет информационный банк
	// Если неполностью, то в Absents сформировать имена недостающих

	short I = 0; // GARANT_FORSCOPING
	for ( I = 0; I < Deltas -> getCount(); I++ ) {
		TDelta *aDelta = Deltas -> at( I );
		if ( aDelta -> Segments -> getCount() != Segments -> getCount() ) {
			// период обновляется неполностью.
			// Надо сформировать список недостающих дельт

			for ( short J = 0; J < Segments -> getCount(); J++ ) {
				if ( aDelta -> Segments -> indexOf( Segments -> at( J ) ) == -1 ) {
					CString	aName, aSegmentName( SegmentNames -> at( J ));
				#ifndef	WINENCODE
					Dos2Win( aSegmentName );
				#endif
					aName.Format( IDS_ABSENTPERIODFOR, aDelta -> From.RevisionDate.da_day, aDelta -> From.RevisionDate.da_mon, aDelta -> From.RevisionDate.da_year, aDelta -> To.RevisionDate.da_day, aDelta -> To.RevisionDate.da_mon, aDelta -> To.RevisionDate.da_year, aSegmentName );
					Absents -> add( newStr( aName.GetBuffer( 0 )));
				}
			}

			aDelta -> State = DELTA_ABSENT_SOME;
		}
	}

	// Шаг второй. Надо понять, применим ли потенциально период.
	// Проверять только для тех, кто DELTA_NOTSELECTED.
	// Для самого первого применимость - совпадение From с ревизией базы
	// Для каждого следующего - наличие применимого периода с равным To

	// при поиске "последнего" периода запоминать дату наибольшего
	// (даже неприменимого из-за отсутствия некоторых дельт), чтобы
	// в случае неудачи сформировать отсутствующий период (для Absents)

	// кажется, надо просто Selectнуть последнюю NOTSELECTED дельту.
	// ^ не совсем правильно, так как не будут правильно выставлены
	//   галочки в предыдущих периодах в случае их взаимопересечения во времени

	// Наверно, лучше выбрать первую NOTSELECTED и потом пробежать по списку,
	// отмечая дельты, у которых From совпадает с To дельты, отмеченной на
	// прошлом шаге. Может, и неоптимально (то есть в случае пересекающихся)
	// периодов будет выбрана не самая длинная цепочка применимых дельт,
	// Зато хоть что-то будет выбрано.

	// расставляем флаг DELTA_ABSENT_PREVIOUS
	for ( I = 0; I < Deltas -> getCount(); I++ ) {
		TDelta *aDelta = Deltas -> at( I );
		if ( aDelta -> State != DELTA_ABSENT_SOME ) {
			// период обновляет банк полностью. Весь вопрос в том, есть ли
			// дельта за предыдущий период или если дельта первая,
			// то совпадает ли её ревизия From с ревизией банка

			int	aFound = -1;

			if ( I == 0 || CompRevs( &aDelta -> From, &Deltas -> at( 0 ) -> From ) == 0 ) {
				if ( CompRevs( &aDelta -> From, &From ) == 0 )
					aFound = -2;
			} else {
				// ищем дельту, которая за предыдущий период
				for ( short J = 0; J < I; J++ ) {
					TDelta *aDeltaJ = Deltas -> at( J );
					if ( CompRevs( &aDelta -> From, &aDeltaJ -> To ) == 0 ) {
						aFound = J;
						break;
					}
				}
			}

			if ( aFound != -1 ) {
				if ( aFound == -2 || Deltas -> at( aFound ) -> State == DELTA_NOTSELECTED )
					aDelta -> State = DELTA_NOTSELECTED;
				else
					aDelta -> State = DELTA_PREV_BAD;
			} else {
				// нужна дельта за отсутствующий период

				revision aFrom = From;
				if ( I ) {
					for ( short J = I - 1; J >= 0; J-- ) {
						TDelta *atJ = Deltas -> at( J );
						if ( CompRevs( &atJ -> From, &aDelta -> From ) != 0 ) {
							aFrom = atJ -> To;
							break;
						}
					}
				}

				CString	aName;
				aName.Format( IDS_ABSENTPERIOD, aFrom.RevisionDate.da_day, aFrom.RevisionDate.da_mon, aFrom.RevisionDate.da_year, aDelta -> From.RevisionDate.da_day, aDelta -> From.RevisionDate.da_mon, aDelta -> From.RevisionDate.da_year );
				Absents -> add( newStr( aName.GetBuffer( 0 )));

				aDelta -> State = DELTA_ABSENT_PREVIOUS;
			}
		}
	}

	// теперь начинаем для дельт, которые NOTSELECTED, выставлять SELECTED
	CalcMinRevision();
}

void	TDeltaManager :: CalcMinRevision()
{
	if ( Deltas -> getCount() > 0 )
	{
		short		aBestChoice = -1;
		revision	aBestRevision = From;
		short		I = 0;
		TDelta*		atI = Deltas -> at( I );
		while ( I < Deltas -> getCount() && CompRevs( &atI -> From, &From ) == 0 )
		{
			UnselectAll();
			Select( I );

		    MinRevision = From;
        	for ( short J = Deltas -> getCount() - 1; J >= 0; J-- )
			{
				TDelta*	atJ = Deltas -> at( J );
        		if ( atJ -> State == DELTA_SELECTED )
	        	{
        			MinRevision = atJ -> To;
        			break;
				}
			}

			if ( CompRevs( &MinRevision, &aBestRevision ) >= 0 ) {
				aBestChoice = I;
				aBestRevision = MinRevision;			
			}

			I++;
		}

		MinRevision = From;
		UnselectAll();
		if ( aBestChoice == -1 )
		{
			// есть дельты, но они неприменимы (отсутствуют предыдущие периоды, например)
			// ищем первую с конца дельты, которая ABSENT_SOME
		check:
			BOOL	aFound = FALSE;
			for ( I = Deltas -> getCount() - 1; I >= 0; I-- )
			{
				if ( Deltas -> at( I ) -> State == DELTA_PREV_BAD || Deltas -> at( I ) -> State == DELTA_ABSENT_PREVIOUS )
				{
					aFound = TRUE;
					revision aRevision = Deltas -> at( I ) -> To;
					if ( CompRevs( &aRevision, &Today ) < 0 )
					{
						CString	aName;
						aName.Format( IDS_ABSENTPERIOD, aRevision.RevisionDate.da_day, aRevision.RevisionDate.da_mon, aRevision.RevisionDate.da_year, Today.RevisionDate.da_day, Today.RevisionDate.da_mon, Today.RevisionDate.da_year );
						Absents -> add( newStr( aName.GetBuffer( 0 )));
					}
					break;
				}
			}

			if ( !aFound && CompRevs( &MinRevision, &Today ) < 0 )
			{
				CString	aName;
				aName.Format( IDS_ABSENTPERIOD, MinRevision.RevisionDate.da_day, MinRevision.RevisionDate.da_mon, MinRevision.RevisionDate.da_year, Today.RevisionDate.da_day, Today.RevisionDate.da_mon, Today.RevisionDate.da_year );
				Absents -> add( newStr( aName.GetBuffer( 0 )));
			}	
		}
		else
		{
			Select( aBestChoice );
			MinRevision = aBestRevision;
			goto check;
		}
	}
	else
	if ( CompRevs( &From, &Today ) < 0 )
	{	
		MinRevision = From;
		CString	aName;
		aName.Format( IDS_ABSENTPERIOD, From.RevisionDate.da_day, From.RevisionDate.da_mon, From.RevisionDate.da_year, Today.RevisionDate.da_day, Today.RevisionDate.da_mon, Today.RevisionDate.da_year );
		Absents -> add( newStr( aName.GetBuffer( 0 )));
	}
}

void	TDeltaManager :: SelectAll()
{
	short I = 0; // GARANT_FORSCOPING
	for ( I = 0; I < Deltas -> getCount(); I++ )
	{
		TDelta *aDelta = Deltas -> at( I );
		if ( aDelta -> State == DELTA_SELECTED ) aDelta -> State = DELTA_NOTSELECTED;
	}

	revision aRev = From;
	for ( I = 0; I < Deltas -> getCount(); I++ )
	{
		TDelta *aDelta = Deltas -> at( I );
		if ( aDelta -> State == DELTA_NOTSELECTED && CompRevs( &aRev, &aDelta -> From ) == 0 )
		{
			aDelta -> State = DELTA_SELECTED;
			aRev = aDelta -> To;
		}			
	}
}

void	TDeltaManager :: UnselectAll()
{
	for ( short I = 0; I < Deltas -> getCount(); I++ )
	{
		TDelta *aDelta = Deltas -> at( I );
		if ( aDelta -> State == DELTA_SELECTED ) aDelta -> State = DELTA_NOTSELECTED;
	}
}

void	TDeltaManager :: Select( short aIndex )
{
	TDelta *aDelta = Deltas -> at( aIndex );
	if ( aDelta -> State == DELTA_NOTSELECTED )
	{
		// cнять Selection с предыдущих дельт
		short I = 0; // GARANT_FORSCOPING
		for ( I = 0; I < Deltas -> getCount(); I++ )
		{
			TDelta *aDeltaI = Deltas -> at( I );
			if ( I != aIndex && CompRevs( &aDeltaI -> From, &aDelta -> From ) <= 0 )
				Unselect( I );
		}

		aDelta -> State = DELTA_SELECTED;

		// предшествующие неотмеченные дельты надо отметить
		// причем только в том случае, если нет отмеченной дельты с To == From текущей
		BOOL	aFound = FALSE;
		for ( I = aIndex - 1; I >= 0; I-- )
		{
			TDelta* atI = Deltas -> at( I );
			if ( atI -> State == DELTA_SELECTED && CompRevs( &atI -> To, &aDelta -> From ) == 0 )
			{
				aFound = TRUE;
				break;
			}
		}

		if ( !aFound )
		{
			revision aRev = aDelta -> From;
			for ( I = aIndex - 1; I >= 0; I-- )
			{
				TDelta* atI = Deltas -> at( I );
				if ( CompRevs( &aRev, &atI -> To ) == 0 )
				{
					if ( atI -> State == DELTA_SELECTED ) break;
					if ( atI -> State == DELTA_NOTSELECTED ) atI -> State = DELTA_SELECTED;
					aRev = atI -> From;
				}
			}
		}

		// отметить дельты за следующие периоды		..
		revision aTo = aDelta -> To;
		for ( I = aIndex + 1; I < Deltas -> getCount(); I++ )
		{
			TDelta *atI = Deltas -> at( I );
			if ( atI -> State == DELTA_NOTSELECTED && CompRevs( &aTo, &atI -> From ) == 0 )
			{
				atI -> State = DELTA_SELECTED;
				aTo = atI -> To;
			}
		}
	}
}

void	TDeltaManager :: Unselect( short aIndex )
{
	TDelta *aDelta = Deltas -> at( aIndex );
	if ( aDelta -> State == DELTA_SELECTED )
	{
		aDelta -> State = DELTA_NOTSELECTED;

		// надо убрать чек с дельты, у которой From == To рассматриваемой
		for ( short I = 0; I < Deltas -> getCount(); I++ )
			if ( CompRevs( &Deltas -> at( I ) -> From, &aDelta -> To ) == 0 )
				Unselect( I );
	}
}

UpdateStatus	TDeltaManager :: Status()
{
	BOOL	aFull  = FALSE;
	BOOL	aFound = FALSE;
	for ( short I = 0; I < Deltas -> getCount(); I++ )
	{
		TDelta *aDelta = Deltas -> at( I );
		if ( aDelta -> State == DELTA_SELECTED )
		{
			aFound = TRUE;
			if ( CompRevs( &aDelta -> To, &Today ) >= 0 )
				aFull = TRUE;
		}
	}
	if ( aFull )
		return UPDATE_FULL;
	else
	if ( aFound )
		return UPDATE_PART;
	else
		return UPDATE_NONE;
}

CString	UpdateStatus2Str( UpdateStatus aStatus )
{
	CString	aResult;
	switch ( aStatus )
	{
		case UPDATE_FULL:
			aResult.LoadString( IDS_UPDATEFULL );
			break;			
		case UPDATE_PART:
			aResult.LoadString( IDS_UPDATEPART );
			break;			
		case UPDATE_NONE:
			aResult.LoadString( IDS_UPDATENO );
			break;			
	}
	return	aResult;
}

void	RunGL( char* aBaseName )
{
	MyDeleteFile( ResultFile );
	RunGUGLProgress runProgress( false, 0, aBaseName, ResultFile );
	runProgress.DoModal();
}

void	RunGU()
{
	char aCmdLine[ MAX_PATH + 8 ], aGUIniPath[ MAX_PATH ];
	MakePath( aGUIniPath, DataPath, "GU.INI" );
	sprintf( aCmdLine, "-i:%s", aGUIniPath );

	MyDeleteFile( ResultFile );
	RunGUGLProgress runProgress( false, 1, aCmdLine );
	runProgress.DoModal();
}

void	CheckGUGLResult( BOOL &AResult, int aFailID )
{
	int AHandle, ABytes;
	char ResultBuffer[ 256 ];
	CString aFail;
	aFail.LoadString( aFailID );

	if (( AHandle = _open( ResultFile, O_RDONLY | O_TEXT )) != -1 )
	{
		ABytes = read( AHandle, ResultBuffer, 256 );
		if ( ABytes < 1 || ResultBuffer[ 0 ] != '0' )
		{
			if ( ABytes < 1 )
				strcpy( ResultBuffer, aFail.GetBuffer( 0 ));
			else
			{
				ResultBuffer[ ABytes ] = '\0';
				Dos2Win( ResultBuffer );
			}

			Log( ResultBuffer );
			Log( "\n" );
			AResult = FALSE;
			CString aError( ResultBuffer );
			if ( !SilentMode ) OkBox( ResultBuffer, IDS_ERROR, IDI_BESTOP );
		}
		_close( AHandle );
		AHandle = 0;
		MyDeleteFile( ResultFile );
	}
	else
	{
		AResult = FALSE;
		Log( aFail.GetBuffer( 0 ));
		Log( "\n" );
		if ( !SilentMode ) OkBox( aFailID );
	}
}

void	LockBases( BOOL aLockShell )
{
	WritePrivateProfileString( "Environment", "Data", "**LOCKED**", GarantIni );
	WritePrivateProfileString( NULL, NULL, NULL, GarantIni );

	char	aBaseFileName[ MAX_PATH ];
	if ( lpComplectInfo -> ComplectSet ) {
		MakePath( aBaseFileName, DataPath, lpComplectInfo -> ComplectName );
		for ( short I = 0; I < 5; I++ ) {
			ForceExt( aBaseFileName, Extensions[ I ] );
			SetFileAttributes( aBaseFileName, FILE_ATTRIBUTE_ARCHIVE );
		}
		ForceExt( aBaseFileName, "LCK" );
		FILE *aLockFile = fopen( aBaseFileName, "a" );
		if ( aLockFile ) {
			fputs( "**LOCKED**", aLockFile );
			fclose( aLockFile );
		}
	} else for ( int I = 0; I < BasesCount(); I++ ) {
		MakePath( aBaseFileName, DataPath, BaseName( I ));
		for ( short I = 0; I < 5; I++ ) {
			ForceExt( aBaseFileName, Extensions[ I ] );
			SetFileAttributes( aBaseFileName, FILE_ATTRIBUTE_ARCHIVE );
		}
		ForceExt( aBaseFileName, "LCK" );
		FILE	*aLockFile = fopen( aBaseFileName, "a" );
		if ( aLockFile ) {
			fputs( "**LOCKED**", aLockFile );
			fclose( aLockFile );
		}
	}

	if ( aLockShell )
	{
		char	aLockFileName[ MAX_PATH ];
		MakePath( aLockFileName, DataPath, "$SHELL$.LCK" );
		FILE	*aLockFile = fopen( aLockFileName, "a" );
		if ( aLockFile ) {
			fputs( "**LOCKED**", aLockFile );
			fclose( aLockFile );
		}
	}
}

void	UnlockBases()
{
	char	aBaseFileName[ MAX_PATH ];

	if ( lpComplectInfo -> ComplectSet )
		MyDeleteFile( ForceExt( MakePath( aBaseFileName, DataPath, lpComplectInfo -> ComplectName ), "LCK" ));
	else for ( int I = 0; I < BasesCount(); I++ )
		MyDeleteFile( ForceExt( MakePath( aBaseFileName, DataPath, BaseName( I )), "LCK" ));

	char	aLockFileName[ MAX_PATH ];
	DeleteFile( MakePath( aLockFileName, DataPath, "$SHELL$.LCK" ));

	WritePrivateProfileString( "Environment", "Data", "", GarantIni );
	WritePrivateProfileString( NULL, NULL, NULL, GarantIni );
}

BOOL TDeltaManager::ApplyDeltas()
{
	//перенести лог
	if (!RemoteUpdate) {
		char	aLogPath [MAX_PATH], aLogFileName [MAX_PATH];
		strcpy (aLogPath, DataPath);
		if ( strrchr( aLogPath, '\\' )) *strrchr( aLogPath, '\\' ) = '\0';
		strcat (aLogPath, "\\Logs");
		strcat (strcpy (aLogFileName, aLogPath), "\\data.log");

		if (FileExist (aLogFileName)) {
			char	aBackupLogPath [MAX_PATH], aBackupLogFileName [MAX_PATH];
			strcat (strcpy (aBackupLogPath, aLogPath), "\\dataupd");
			mkdir (aBackupLogPath);

			char time_buf [64] = {'\0'};
			ACE_OS::tzset ();
			time_t seconds_since_1970 = ACE_OS::time ();
			tm* tm_local_time = ACE_OS::localtime (&seconds_since_1970);
			ACE_OS::strftime (time_buf, 64, "%d-%m-%Y-%H-%M-%S.log", tm_local_time);

			strcat (strcat (strcpy (aBackupLogFileName, aBackupLogPath), "\\data-"), time_buf);
			rename (aLogFileName, aBackupLogFileName);
		}
	}

#if !defined (_GCD_CLIENT) && !defined (PILOT)
	LockBases();
#endif

	TStringCollection *aGLBases = new TStringCollection( Segments -> getCount(), 0 );
	TStringCollection *aDeltas  = new TStringCollection( Deltas -> getCount(), Deltas -> getCount() );
	BOOL	aResult = TRUE;
	char	aLogString[ MAX_PATH + 100 ];
	short	I;

#if !defined (_GCD_CLIENT) && !defined (PILOT)
	if ( !TryToOpenBases()) {
		aResult = FALSE;
		goto exitGL;
	}
#endif

#ifdef	_GCD_CLIENT
	if ( remoteType ) {
		if ( serverType ) {
			//с отключением пользователей
			UpdateRunner::bu->remote_sync_delta_start();
		} else {
			CWaitServerDialog* waitDialog = new CWaitServerDialog();
			waitDialog->Create();
			waitDialog->SetWindowPos ( &CWnd::wndTop, 0,0,0,0, SWP_NOSIZE|SWP_NOMOVE );
			try {
				UpdateRunner::bu->remote_delta_start();
				update_copy = 1;
			}
			catch (...) {
				aResult = FALSE;
				FatalError( "Недостаточно места на диске для копирования информационного банка" );
				delete waitDialog;
				goto exitGL;
			}
			delete waitDialog;
		}
	}
#endif
	
	StartTime = CTime::GetCurrentTime();
	Log( "\n" );

	int total_selected = 0, counter_selected = 0;
	for ( I = 0; I < Deltas -> getCount(); I++ ) {
		TDelta* aDelta = Deltas -> at( I );
		if ( aDelta -> State == DELTA_SELECTED )
			total_selected++;
	}

	short LastI = Deltas -> getCount() + (enable_gu_merge_optimization && !remoteType ? 1 : 0);
	for (I = 0; I < LastI; I++) {
		TDelta* aDelta = Deltas -> at (I < Deltas -> getCount() ? I : I - 1);
		if (I == LastI - 1 && aDelta->State != DELTA_SELECTED) {
			for (int J = I - 1; J >= 0; J--) {
				aDelta = Deltas -> at (J);
				if (aDelta->State == DELTA_SELECTED)
					break;
			}
		}
		if (aDelta -> State == DELTA_SELECTED) {
			counter_selected++;
			sprintf (GUDllFileName, "GU%d.DLL", aDelta -> Version);

			char	aGUIniFileName[ MAX_PATH ], aNDTFileName[  MAX_PATH ];
			MyDeleteFile( MakePath( aGUIniFileName, DataPath, "GU.INI" ));
			if ( DeltaManager -> Merged ) {
				if ( remoteType ) {
					GslDataPipe::FileReadingSet_var file_set = new GslDataPipe::FileReadingSet();

					typedef std::pair<std::string, GslDataPipe::PipeManager_var> FileData;
					typedef std::vector<FileData> FileDataVector;
					FileDataVector pipe_managers;
					for ( short J = 0; J < aDelta -> FileNames -> getCount(); J++ ) {
						char*	aDeltaFileName = aDelta -> FileNames -> at( J );

						GslDataPipeServer::Stream* str = new GslDataPipeServer::FileStream (aDeltaFileName, true);
						if (false == str->is_open ()) {
							for (FileDataVector::size_type j = 0; j < pipe_managers.size (); j++) {
								pipe_managers[j].second->close_pipe ();
							}
							delete str;
							continue;
						}
						aDeltas -> add( newStr( aDeltaFileName ));

						GslDataPipeServer::PipeManager_i* manager = new GslDataPipeServer::PipeManager_i (str, true);
						PortableServer::ObjectId_var oid = GCM::get_cached_root_poa()->activate_object (manager);
						CORBA::Object_var obj = GCM::get_cached_root_poa()->id_to_reference (oid);

						FileData fd;
						fd.second = GslDataPipe::PipeManager::_narrow (obj);
						fd.first = strrchr( aDeltaFileName, '\\' ) + 1;
						pipe_managers.push_back (fd);	

						CTime theTime = CTime::GetCurrentTime();
						sprintf( aLogString, "Пускаем GU к базе. Дельта: %s, дата: %d:%d:%d Время: %2d:%02d:%02d\n\n", aDeltaFileName, theTime.GetDay(), theTime.GetMonth(), theTime.GetYear(), theTime.GetHour(), theTime.GetMinute(), theTime.GetSecond() );
						Log( aLogString );
					}
					file_set->length (pipe_managers.size ());
					for (FileDataVector::size_type j = 0; j < pipe_managers.size (); j++) {
						file_set[j].m_name = pipe_managers[j].first.c_str ();
						file_set[j].m_data_reading = pipe_managers[j].second->get_reading_interface ();
						file_set[j].m_data_reading->add_reference ();
					}
					
					gugl_fileset = file_set;
					RunGUGLProgress runProgress( true, 1, "Применение дельты" );
					runProgress.DoModal();
					runProgress.updateScreen->m_pDlg = 0;
					file_set = 0;

					aResult = TRUE;
				} else {
					bool b_updateonlyturbo = false;

					// каждая из дельт должна быть применена к комплекту
					strcpy( aNDTFileName, BasePath );

					if (enable_gu_merge_optimization && counter_selected > total_selected && enable_gu_7tr_optimization && !b_isetalon)
						strcpy (GUDllFileName, "GU7tr.dll");

					CTime theTime = CTime::GetCurrentTime();
					sprintf( aLogString, "Пускаем %s к базе %s. Дата: %d:%d:%d Время: %2d:%02d:%02d\n", GUDllFileName, aNDTFileName, theTime.GetDay(), theTime.GetMonth(), theTime.GetYear(), theTime.GetHour(), theTime.GetMinute(), theTime.GetSecond() );
					Log( aLogString );

					CString	aCount;
					aCount.Format( "%d", aDelta -> FileNames -> getCount());

					WritePrivateProfileString( "base",      "base",     aNDTFileName, aGUIniFileName );
					WritePrivateProfileString( "out files", "Result",   ResultFile,   aGUIniFileName );
					if (theApp.b_english_face)
						WritePrivateProfileString( "base", "Language", "1", aGUIniFileName );

					char	aLogPath[ MAX_PATH ];
					strcpy( aLogPath, DataPath );
					if ( !RemoteUpdate ) {
						if ( strrchr( aLogPath, '\\' )) *strrchr( aLogPath, '\\' ) = '\0';
						strcat( aLogPath, "\\Logs" );
					}
					WritePrivateProfileString( "out files", "Log",      aLogPath,     aGUIniFileName );
					WritePrivateProfileString( "delta",     "Count",    aCount,       aGUIniFileName );
					if (enable_gu_merge_optimization) {
						if (counter_selected > total_selected) {
							WritePrivateProfileString( "delta", "UpdateOnlyTurbo", "1", aGUIniFileName );
							b_updateonlyturbo = true;
						} else
							WritePrivateProfileString( "delta", "UpdateTurbo", "0", aGUIniFileName );
					} else {
						WritePrivateProfileString( "delta", "UpdateTurbo", "1", aGUIniFileName );
					}

					WritePrivateProfileString( "delta", "Update7tr", enable_gu_7tr_optimization ? "1" : "0", aGUIniFileName );
					if (extended_log) WritePrivateProfileString( "delta", "ExtendedLog", "1", aGUIniFileName );

					for ( short J = 0; J < aDelta -> FileNames -> getCount(); J++ ) {
						char	aEntry[ 11 ];
						char*	aDeltaFileName = aDelta -> FileNames -> at( J );
						aDeltas -> add( newStr( aDeltaFileName ));
						sprintf( aEntry, "Delta%d", J );
						WritePrivateProfileString( "delta", aEntry, aDeltaFileName, aGUIniFileName );

						if (b_updateonlyturbo) {
							Log ("Обновление морфоиндекса\n");
						} else {
							sprintf( aLogString, "   Дельта: %s\n", aDeltaFileName );
							Log( aLogString );
						}
					}

					WritePrivateProfileString( NULL, NULL, NULL, aGUIniFileName );
					RunGU();
					MyDeleteFile( aGUIniFileName );

					CheckGUGLResult( aResult, IDS_GUFAIL );
					if ( !aResult ) goto exitGU;
					if (b_updateonlyturbo)
						Log ("Обновление морфоиндекса прошло успешно\n\n");
					else
						Log( "Применение дельт(ы) прошло успешно\n\n" );

					if ( aGLBases -> indexOf( aNDTFileName ) == -1 )
						aGLBases -> add( newStr( aNDTFileName ));
				}
			} else {
				if ( remoteType ) {
					for ( short J = 0; J < aDelta -> FileNames -> getCount(); J++ ) {
						char*	aDeltaFileName = aDelta -> FileNames -> at( J );

						GslDataPipe::FileReadingSet_var file_set = new GslDataPipe::FileReadingSet();

						typedef std::pair<std::string, GslDataPipe::PipeManager_var> FileData;
						typedef std::vector<FileData> FileDataVector;
						FileDataVector pipe_managers;

						GslDataPipeServer::Stream* str = new GslDataPipeServer::FileStream (aDeltaFileName);
						if (false == str->is_open ()) {
							for (FileDataVector::size_type j = 0; j < pipe_managers.size (); j++) {
								pipe_managers[j].second->close_pipe ();
							}
							delete str;
							break;
						}
						aDeltas -> add( newStr( aDeltaFileName ));
						GslDataPipeServer::PipeManager_i* manager = new GslDataPipeServer::PipeManager_i (str, true);
						PortableServer::ObjectId_var oid = GCM::get_cached_root_poa()->activate_object (manager);
						CORBA::Object_var obj = GCM::get_cached_root_poa()->id_to_reference (oid);

						FileData fd;
						fd.second = GslDataPipe::PipeManager::_narrow (obj);
						fd.first = aDeltaFileName;
						pipe_managers.push_back (fd);	

						file_set->length (pipe_managers.size ());
						for (FileDataVector::size_type j = 0; j < pipe_managers.size (); j++) {
							file_set[j].m_name = pipe_managers[j].first.c_str ();
							file_set[j].m_data_reading = pipe_managers[j].second->get_reading_interface ();
							file_set[j].m_data_reading->add_reference ();
						}
						
						CTime theTime = CTime::GetCurrentTime();
						sprintf( aLogString, "Пускаем gu к базе. Дельта: %s, дата: %d:%d:%d Время: %2d:%02d:%02d\n", aDeltaFileName, theTime.GetDay(), theTime.GetMonth(), theTime.GetYear(), theTime.GetHour(), theTime.GetMinute(), theTime.GetSecond() );
						Log( aLogString );

						gugl_fileset = file_set;
						RunGUGLProgress runProgress( true, 1, "Применение дельты" );
						runProgress.DoModal();
						runProgress.updateScreen->m_pDlg = 0;
						file_set = 0;
					}
					aResult = TRUE;
				} else {
					strcpy( DataPath, BasePath );
					if ( strrchr( DataPath, '\\' )) *strrchr( DataPath, '\\' ) = '\0';

					// каждая из дельт должна быть применена к своему сегменту
					for ( short J = 0; J < aDelta -> FileNames -> getCount(); J++ ) {
						short	aId = aDelta -> Segments -> at( J );
						char*	aDeltaFileName = aDelta -> FileNames -> at( J );
						aDeltas -> add( newStr( aDeltaFileName ));

						MakePath( aNDTFileName, DataPath, SegmentFiles -> at( Segments->indexOf( aId )));

						if (enable_gu_merge_optimization && counter_selected > total_selected && enable_gu_7tr_optimization && !b_isetalon)
							strcpy (GUDllFileName, "GU7tr.dll");

						CTime theTime = CTime::GetCurrentTime();
						sprintf( aLogString, "Пускаем %s к базе %s. Дата: %d:%d:%d Время: %2d:%02d:%02d\n", GUDllFileName, aNDTFileName, theTime.GetDay(), theTime.GetMonth(), theTime.GetYear(), theTime.GetHour(), theTime.GetMinute(), theTime.GetSecond() );
						Log( aLogString );

						WritePrivateProfileString( "base",      "base",     aNDTFileName,   aGUIniFileName );
						WritePrivateProfileString( "out files", "Result",   ResultFile,     aGUIniFileName );
						if (theApp.b_english_face)
							WritePrivateProfileString( "base", "Language", "1", aGUIniFileName );
						char	aLogPath[ MAX_PATH ];
						strcpy( aLogPath, DataPath );
						if ( strrchr( aLogPath, '\\' )) *strrchr( aLogPath, '\\' ) = '\0';
						strcat( aLogPath, "\\Logs" );
						WritePrivateProfileString( "out files", "Log",      aLogPath,     aGUIniFileName );
						WritePrivateProfileString( "delta",	"Count",	"1",            aGUIniFileName );
						WritePrivateProfileString( "delta",	"Delta0",	aDeltaFileName, aGUIniFileName );
						if (enable_gu_merge_optimization) {
							if (counter_selected > total_selected)
								WritePrivateProfileString( "delta", "UpdateOnlyTurbo", "1", aGUIniFileName );
							else
								WritePrivateProfileString( "delta", "UpdateTurbo", "0", aGUIniFileName );
						} else {
							WritePrivateProfileString( "delta", "UpdateTurbo", "1", aGUIniFileName );
						}
						if (extended_log) WritePrivateProfileString( "delta", "ExtendedLog", "1", aGUIniFileName );

						sprintf( aLogString, "   Дельта: %s\n", aDeltaFileName );
						Log( aLogString );

						WritePrivateProfileString( NULL, NULL, NULL, aGUIniFileName );
						RunGU();
						MyDeleteFile( aGUIniFileName );

						CheckGUGLResult( aResult, IDS_GUFAIL );
						if ( !aResult ) goto exitGU;
						Log( "Применение дельты прошло успешно\n\n" );

						if ( aGLBases -> indexOf( aNDTFileName ) == -1 )
							aGLBases -> add( newStr( aNDTFileName ));
					}
				}
			}
		}
	}

exitGU:
	if ( aResult ) {
		BaseUpdated = TRUE;
		if ( remoteType ) {
			CTime theTime = CTime::GetCurrentTime();
			sprintf( aLogString, "Пускаем GL к базе. Дата: %d:%d:%d Время: %2d:%02d:%02d\n\n", theTime.GetDay(), theTime.GetMonth(), theTime.GetYear(), theTime.GetHour(), theTime.GetMinute(), theTime.GetSecond() );
			Log( aLogString );
			RunGUGLProgress runProgress( true, 0, "Построение классификатора" );
			runProgress.DoModal();
		} else {
			for ( int I = 0; I < aGLBases -> getCount(); I++ ) {
				CTime theTime = CTime::GetCurrentTime();
				sprintf( aLogString, "Пускаем GL к базе %s. Дата: %d:%d:%d Время: %2d:%02d:%02d\n", aGLBases -> at( I ), theTime.GetDay(), theTime.GetMonth(), theTime.GetYear(), theTime.GetHour(), theTime.GetMinute(), theTime.GetSecond() );
				Log( aLogString );

				RunGL( aGLBases -> at( I ));
				CheckGUGLResult( aResult, IDS_GLFAIL );
				if ( !aResult ) goto exitGL;

				theTime = CTime::GetCurrentTime();
				sprintf( aLogString, "Применение GL прошло успешно. Дата: %d:%d:%d Время: %2d:%02d:%02d\n\n", theTime.GetDay(), theTime.GetMonth(), theTime.GetYear(), theTime.GetHour(), theTime.GetMinute(), theTime.GetSecond() );
				Log( aLogString );
			}
		}
	}

exitGL:

	if ( aResult && BaseUpdated /*&& !remoteType*/ )
		for ( int I = 0; I < aDeltas -> getCount(); I++ )
			MyDeleteFile( aDeltas -> at( I ));

	delete aGLBases;
	delete aDeltas;

	EndTime = CTime::GetCurrentTime();

	CTimeSpan runTime = DeltaManager -> EndTime - DeltaManager-> StartTime;
	theApp.update_seconds = (long) (runTime.GetTotalSeconds () & 0xFFFFFFFF);

	if (!aResult)
		global_return_code = 3;

	return aResult;
}

#ifdef	_GCD_CLIENT
void	CUpdateApp::Help( const char* html )
{
	char buffer [MAX_PATH];
	char helpFileName [MAX_PATH + 128];
	buffer [GetModuleFileName ((HMODULE)NULL, buffer, MAX_PATH)] = '\0';
	char* slash = strrchr( buffer, '\\' );
	if ( slash ) *slash = '\0';
	strcat( strcpy( helpFileName, buffer ), "\\..\\..\\help\\F1DataTools.chm" );
	if ( !FileExist( helpFileName ))
		strcat( strcpy( helpFileName, buffer ), "\\F1DataTools.chm" );
	strcat( strcat( helpFileName, "::/" ), html );
	::HtmlHelp( NULL, helpFileName, HH_DISPLAY_TOPIC, NULL );
}
#endif
