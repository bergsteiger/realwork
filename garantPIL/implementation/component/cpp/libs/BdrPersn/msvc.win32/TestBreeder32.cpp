// TestBreeder32.cpp : Defines the class behaviors for the application.
//

#include "stdafx.h"
#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/Core/sys/start_stop.h"
#include "shared/Core/Params/Params.h"
#include "shared/Core/ParamsHelper/ParamConvert.h"

#include "recode.h"
#include "TestBreeder32.h"
#include "TestBreeder32Dlg.h"
#include "PilotLoginDlg.h"
#include "WaitServer.h"
#include <direct.h>

#include "garantServer/src/Global/Core/Common/AutoIPConfig.h"
#include "garantServer/src/Global/Core/Common/GCMManagerHome.h"
#include "garantServer/src/Global/Core/Common/ParamManagerReg.h"

#include "garantServer/src/Services/GslUserManager/Client/UserManagerClientHome.h"

#if defined (_GCD_CLIENT)
#include "shared/Core/fix/wine.h"
#include "garantServer/src/Global/Defines/Common/ProjectConsts.h"

#include <shlwapi.h>
#endif

#include <garver.h>
#include <basemask.h>
#include "message.h"
/////////////////////////////////////////////////////////////////////////////

int BreederMessageBox (UINT msg_id, UINT caption_id, UINT type) {
	CString msg;
	msg.LoadString (msg_id);

	CString caption;
	caption.LoadString (caption_id);

	return MessageBox (NULL, msg.GetBuffer (), caption.GetBuffer (), type);
}

/////////////////////////////////////////////////////////////////////////////
// CTestBreeder32App

BEGIN_MESSAGE_MAP(CTestBreeder32App, CWinApp)
	//{{AFX_MSG_MAP(CTestBreeder32App)
		// NOTE - the ClassWizard will add and remove mapping macros here.
		//    DO NOT EDIT what you see in these blocks of generated code!
	//}}AFX_MSG
	ON_COMMAND(ID_HELP, CWinApp::OnHelp)
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CTestBreeder32App construction

CTestBreeder32App::CTestBreeder32App () : m_rc_lang (rl_Rus) {
	module_file_name [0] = '\0';
	global_success = false;
}

/////////////////////////////////////////////////////////////////////////////

void CTestBreeder32App::set_local_resource (const char* dll_name) {
	HMODULE language_handle = (HMODULE) NULL;

	m_res_loader = new GCL::DllLoader (dll_name);

	if (m_res_loader.ptr ()) {
		language_handle = static_cast <HMODULE> (m_res_loader->get_handle ());
	} 

	if (language_handle) {
		AfxSetResourceHandle (language_handle);
		m_rc_lang = rl_Eng;
	} else {
		std::string str = dll_name;
		str += std::string (".dll not loaded");
		::MessageBox (NULL, str.c_str (), AfxGetAppName (), MB_OK | MB_ICONEXCLAMATION);
	}
}

/////////////////////////////////////////////////////////////////////////////
// The one and only CTestBreeder32App object

CTestBreeder32App theApp;
CWaitServerStart2* waitSSDialog = 0;
Core::Mutex wait_mutex;
bool	waitss_inmodal = false;
HANDLE	hThread;

void WINAPI	waitss_thread (void* params) {
	ACE_OS::sleep (3);
	bool can_modal = false;
	{
		GUARD (wait_mutex);
		if (waitSSDialog) {
			waitss_inmodal = true;
			can_modal = true;
		}
	}
	if (can_modal)
		waitSSDialog->DoModal ();

	return ;
}

extern CString Frmt52;

#if defined (_GCD_CLIENT) || defined (PILOT)
	bool	autoLogin = true;

	UpdateRunner::UpdateRunner () : m_logged (false) {
		b_exit_requested = false;
		PilotBaseRoot = "C:\\";
		PilotBaseName= "";
		PilotBaseDir= "";
		updateType = 0;
		version_type = GblPilot::VT_UNKNOWN;

		GCMServerBase::register_receptacles (Defines::FN_BASE_UPDATE);
		GCMServerBase::register_receptacles (Defines::FN_FUNCTION_MNG);
		GCMServerBase::register_receptacles (Defines::FN_HEARTBEAT_MANAGER);
		GCMServerBase::register_receptacles (Defines::FN_USER_MANAGER);
	}

	void UpdateRunner :: terminate_exit () {
		this->logout_current ();
		if (!b_exit_requested) {
			b_exit_requested = true;
			status (GCM::cs_exit_requested);
		}
	}

	void UpdateRunner :: execute(){
		GCMComponentBase::execute ();
		int aResult= IDCANCEL;
		m_logged = false;

		{
		CloseHandle (hThread);
		GUARD (wait_mutex);
		if (waitSSDialog) {
			if (waitss_inmodal)
				waitSSDialog->EndDialog (IDOK);
			delete waitSSDialog;
			waitSSDialog = 0;
		}
		}

#if defined (_GCD_CLIENT) || defined (PILOT)
		bool b_waitxml_visible = false;
		bool b_waitserverstart_visible = false;

		CPilotLoginDlg LoginDlg;

		CORBA::Object_var um_obj = provide (Defines::FN_USER_MANAGER);
		um = GslUserManager::UserManager::_narrow (um_obj.in ());

		if ((um->get_rest_trial_days_count () >= 0) && (um->get_protection_error () == 0)) {
			BreederMessageBox (IDS_CANT_UPDATE_BASE, IDS_AUTHORIZATION, MB_ICONERROR + MB_OK);
			status (GCM::cs_exit_requested);
			return;
		}

		for (; !m_logged; ) {
			if(LoginDlg.DoModal() == IDOK){
				autoLogin = false;
				try {
					UpdateRunner::um->login((LPCTSTR)LoginDlg.m_Login, (LPCTSTR)LoginDlg.m_Password);
					m_logged = true;

					if(!um->has_admin_rights ()) {
						BreederMessageBox (IDS_FORBIDDEN, IDS_AUTHORIZATION, MB_OK);

						um->logout_current();
						m_logged = false;
						continue;

						//status (GCM::cs_exit_requested);
						//return;
					}

					CORBA::Object_var bu_obj = provide (Defines::FN_BASE_UPDATE);
					bu = GblPilot::BaseUpdate::_narrow (bu_obj.in ());

					if (bu->is_update_started ()) {
						if (BreederMessageBox (IDS_FATAL_END, IDS_ATTENTION, MB_ICONQUESTION | MB_YESNO) == IDYES) {
							this->logout_current();
							status (GCM::cs_exit_requested);
							return;
						}
					}

					CORBA::Object_var fm_object = provide (Defines::FN_FUNCTION_MNG);
					function_mng = GblPilot::FunctionMng::_narrow (fm_object);
					version_info = function_mng->version_info ();
					version_type = function_mng->get_product_info ();
					if (version_type == GblPilot::VT_UNKNOWN)
						((CTestBreeder32App*)AfxGetApp())->Log ("type=?\n");
					else if ((version_type == GblPilot::VT_DVD) || (version_type == GblPilot::VT_MOBILE))
						((CTestBreeder32App*)AfxGetApp())->Log ("type=cd\n");
					else if (version_type == GblPilot::VT_FILESERVER)
						((CTestBreeder32App*)AfxGetApp())->Log ("type=2\n");
					else if (version_type == GblPilot::VT_DESKTOP)
						((CTestBreeder32App*)AfxGetApp())->Log ("type=1\n");
					else if (version_type == GblPilot::VT_CLIENTSERVER)
						((CTestBreeder32App*)AfxGetApp())->Log ("type=3\n");

					try {
						PilotBaseName = UpdateRunner::bu->get_local_dir_for_async ();
						PilotBaseDir = PilotBaseName.Left(1 + PilotBaseName.ReverseFind ('\\'));

						if (GCM::is_server_running_on_that_mashine ()) {
							bool was_error =  false;

							char attemptfilename [MAX_PATH];
							strcat (strcpy( attemptfilename, PilotBaseName), ".$$$");

							FILE* attemptfile = ACE_OS::fopen (attemptfilename, "w+b");

							if (!attemptfile) {
								was_error = true;
								CString err;
								err.Format (IDS_CANT_WRITE_TO_DIR, PilotBaseDir.GetBuffer ());
								((CTestBreeder32App*)AfxGetApp())->Log (err.GetBuffer (0));
								AfxMessageBox (err.GetBuffer ());
							} else {
								ACE_OS::fclose (attemptfile);
								ACE_OS::unlink (attemptfilename);
							}

							if (!was_error) {
								PilotBaseName = UpdateRunner::bu->get_local_dir_for_sync ();
								PilotBaseDir = PilotBaseName.Left (1 + PilotBaseName.ReverseFind ('\\'));
								ACE_OS::strcat (ACE_OS::strcpy (attemptfilename, PilotBaseName), ".$$$");

								attemptfile = ACE_OS::fopen (attemptfilename, "w+b");

								if (!attemptfile) {
									CString err;
									err.Format (IDS_CANT_WRITE_TO_DIR, PilotBaseDir.GetBuffer ());
									((CTestBreeder32App*)AfxGetApp())->Log (err.GetBuffer (0));
									AfxMessageBox (err.GetBuffer ());
								} else {
									ACE_OS::fclose (attemptfile);
									ACE_OS::unlink (attemptfilename);
								}
							}
						}

						if (PilotBaseName [1] == ':') {
							PilotBaseRoot = PilotBaseName.Left (3);
						} else {
							PilotBaseRoot = PilotBaseName.Left (PilotBaseName.Find ('\\',1+PilotBaseName.Find('\\',2)));
						}
						Core::GDS::HiResCounter hi_res_counter;
						do{
							{
								CTestBreeder32Dlg dlg;
								dlg.pPilotBaseRoot= &PilotBaseRoot;
								dlg.pPilotBaseName= &PilotBaseName; 
								dlg.pPilotBaseDir= &PilotBaseDir, 
									dlg.pPilotDistribPath= &PilotDistribPath;
								dlg.pUR = this;

								dlg.secondPilotDistribPath= &secondPilotDistribPath;

								aResult = dlg.DoModal();
							}
							if(aResult != selectDefPath)
								break;
							PilotDistribPath= secondPilotDistribPath;
						}while(true);
						unsigned int ret_s, ret_ms, ret_us;
						hi_res_counter.tiks_to_time(hi_res_counter.get_count(), ret_s, ret_ms, ret_us);
						ret_s++;
						CString qqq;
						qqq.Format(Frmt52, ret_s/60, ret_s%60);

						((CTestBreeder32App*)AfxGetApp())->Log (qqq.GetBuffer (0));
						((CTestBreeder32App*)AfxGetApp())->Log ("\n");
					} catch (GblPilot::UpdateAlreadyStarted&) {
						BreederMessageBox (IDS_ERROR_LOAD_SECOND_APPLICATION, IDS_ATTENTION, MB_OK);
						this->logout_current();
						status (GCM::cs_exit_requested);
						return;
					}
				} catch (GCM::ServerIsStarting) {
					if (!b_waitserverstart_visible) {
						ACE_OS::sleep(3);
					} else {
						CWaitServerStart *waitServerStart = new CWaitServerStart();
						waitServerStart->SetUpdateRunner (this);
						waitServerStart->SetLoginPassword (LoginDlg.m_Login, LoginDlg.m_Password);
						waitServerStart->DoModal ();
						delete waitServerStart;
						this->logout_current ();
					}
					b_waitserverstart_visible = true;
					autoLogin = true;
					continue;
				} catch (GCD::XMLImportRunning) {
					if (b_waitserverstart_visible) {
						ACE_OS::sleep(3);
					} else {
					if (!b_waitxml_visible) {
						ACE_OS::sleep(3);
					} else {
						CWaitXml *waitXml = new CWaitXml();
						waitXml->SetUpdateRunner (this);
						waitXml->SetLoginPassword (LoginDlg.m_Login, LoginDlg.m_Password);
						waitXml->DoModal ();
						delete waitXml;
						this->logout_current ();
					}
					b_waitxml_visible = true;
					autoLogin = true;
					} 
					continue;
				} catch(GslUserManager::LoginFailed&) {
					BreederMessageBox (IDS_MSG_91, IDS_AUTHORIZATION, MB_OK);
					this->logout_current ();
					continue;
				} catch (GslUserManager::LoginDuplicate&) {
					BreederMessageBox (IDS_MSG_92, IDS_AUTHORIZATION, MB_OK);
					this->logout_current ();
					continue;
				} catch (GslUserManager::LoginBlocked&) {
					BreederMessageBox (IDS_MSG_93, IDS_AUTHORIZATION, MB_OK);
					this->logout_current ();
					continue;
				} catch (GslUserManager::NoMoreConnections&) {
					BreederMessageBox (IDS_NOMORE_CONNECTIONS, IDS_AUTHORIZATION, MB_OK);
					this->logout_current ();
					continue;
				} catch(CORBA::TRANSIENT&) {
					BreederMessageBox (IDS_TRANSIENT, IDS_AUTHORIZATION, MB_OK);
					this->logout_current ();
					continue;
				} catch (CORBA::Exception& ex) {
					CString msg;
					msg.LoadString (IDS_AUTHORIZATION_EXEPTION);
					msg += CString ("\nCORBA::Exception ") + ex._rep_id ();

					CString caption;
					caption.LoadString (IDS_AUTHORIZATION);

					MessageBox (NULL, msg.GetBuffer (), caption.GetBuffer (), MB_OK);
					this->logout_current ();
					continue;
				} catch (...) {
					BreederMessageBox (IDS_AUTHORIZATION_EXEPTION, IDS_AUTHORIZATION, MB_OK);
					this->logout_current ();
					continue;
				}
			} else {
				((CTestBreeder32App*)AfxGetApp())->TimeLog ("LoginDlg::DoModal != IDOK, break\n");
				break;
			}
#endif
			if (aResult == IDOK) {
#ifndef	_GCD_CLIENT
				CString err;

				try {
					UpdateRunner::bu->update_complete();
					global_success = true;
				} catch (GCD::InvalidDatastoreKey&) {
					err.LoadString (IDS_MSG_94);
				} catch (CORBA::TRANSIENT&) {
					err.LoadString (IDS_TRANSIENT);
				} catch (CORBA::Exception& ex) {
					err.LoadString (IDS_INSTALL_BASE_EXEPTION);
					err += CString ("\nCORBA::Exception ") + ex._rep_id ();
				} catch(...) {
					err.LoadString (IDS_INSTALL_BASE_EXEPTION);
				}

				if (!err.IsEmpty ()) {
					CString title;
					title.LoadString (IDS_SETUP_DATA);
					MessageBox (NULL, err.GetBuffer (), title.GetBuffer (), MB_OK);
				}
#endif
			}
			break;
		}

		terminate_exit();
	}

	void UpdateRunner::logout_current () {
		if (m_logged) {
			try {
				um->logout_current ();
			} catch(...) {
			}
			m_logged = false;
		}
	}
#endif

/////////////////////////////////////////////////////////////////////////////
// CTestBreeder32App initialization

void	CTestBreeder32App::Log (char *aLogString, bool only_in_crypt)
{
	char aCurDir [MAX_PATH], aLogFileName [MAX_PATH];
	//GetModuleFileName (0, aCurDir, MAX_PATH);
	strcpy (aCurDir, module_file_name);
	*strrchr (aCurDir, '\\') = '\0';
	strcpy (aLogFileName, aCurDir);
	if (strrchr (aLogFileName, '\\')) *strrchr (aLogFileName, '\\') = '\0';
	if (strrchr (aLogFileName, '\\')) *strrchr (aLogFileName, '\\') = '\0';

	strcat (aLogFileName, "\\Logs\\datasetup.log");
	FILE *aLogFile;
	if (!only_in_crypt) {
		aLogFile = ACE_OS::fopen (aLogFileName, "a");
		if (aLogFile)	{
			ACE_OS::fputs (aLogString, aLogFile);
			fflush (aLogFile);
			ACE_OS::fclose (aLogFile);
		}
	}

	strcpy (aLogFileName, aCurDir);
	if (strrchr (aLogFileName, '\\')) *strrchr (aLogFileName, '\\') = '\0';
	if (strrchr (aLogFileName, '\\')) *strrchr (aLogFileName, '\\') = '\0';
	if (!log_file_prefix.GetLength ()) {
		char time_buf [64] = {'\0'};
		ACE_OS::tzset ();
		time_t seconds_since_1970 = ACE_OS::time ();
		tm* tm_local_time = ACE_OS::localtime (&seconds_since_1970);
		ACE_OS::strftime (time_buf, 64, "datasetup-%d-%m-%Y-%H-%M-%S.cry", tm_local_time);
		log_file_prefix = time_buf;
	}
	strcat (aLogFileName, "\\Logs\\datasetup\\");
	ACE_OS::mkdir (aLogFileName);
	strcat (aLogFileName, log_file_prefix);
	aLogFile = fopen (aLogFileName, "a");
	if (aLogFile)	{
		for (unsigned int i = 0; i < strlen (aLogString); i++) {
			char code [16];
			sprintf (code, "%03d", (int)(unsigned char)aLogString [i]);
			fputs (code, aLogFile);
		}
		fclose (aLogFile);
	}
}

void	CTestBreeder32App::RenameLog (bool success)
{
	char aCurDir[ MAX_PATH ];
	strcpy (aCurDir, module_file_name);
	*strrchr( aCurDir, '\\' ) = '\0';

	if (success) {
		//нешифрованный лог стереть
		char	aLogFileName[ MAX_PATH ];
		strcpy( aLogFileName, aCurDir );
		if ( strrchr( aLogFileName, '\\' )) *strrchr( aLogFileName, '\\' ) = '\0';
		if ( strrchr( aLogFileName, '\\' )) *strrchr( aLogFileName, '\\' ) = '\0';

		strcat( aLogFileName, "\\Logs\\datasetup.log" );
		ACE_OS::unlink (aLogFileName);
		strcpy( aLogFileName, aCurDir );
		if ( strrchr( aLogFileName, '\\' )) *strrchr( aLogFileName, '\\' ) = '\0';
		if ( strrchr( aLogFileName, '\\' )) *strrchr( aLogFileName, '\\' ) = '\0';
		strcat( aLogFileName, "\\Logs\\" );
	}
}

void	CTestBreeder32App::TimeLog(char* aMessage)
{
	CTime theTime = CTime::GetCurrentTime();
	char	aLogString[ 256 ];
	sprintf( aLogString, "Дата: %d:%d:%d Время: %2d:%02d:%02d %s", theTime.GetDay(), theTime.GetMonth(), theTime.GetYear(), theTime.GetHour(), theTime.GetMinute(), theTime.GetSecond(), aMessage);
	Log( aLogString );
}

void	CTestBreeder32App::ErrorLog(char* aMessage)
{
	Log ("Ошибка: ");
	Log (aMessage);
	Log ("\n");
}

BOOL CTestBreeder32App::InitInstance()
{
  	HWND GWHandle=::GetTopWindow(0);
  	char	title[1024];
	CString titleD;
	titleD.LoadString(IDS_ABOUTBOX);
	int szT= titleD.GetLength();
  	do{
    	::GetWindowText(GWHandle,title,500);
    	if (!memcmp( title,titleD,szT)) {
		    ::ShowWindow( GWHandle, SW_SHOWMINIMIZED );
		    ::ShowWindow( GWHandle, SW_SHOWNORMAL );
		    ::BringWindowToTop(GWHandle);
			return FALSE;
		}
    }while((GWHandle= ::GetNextWindow(GWHandle,GW_HWNDNEXT)));
#if defined (_GCD_CLIENT) || defined (PILOT)
	Core::init();
#endif
	AfxEnableControlContainer();

	// Standard initialization
	// If you are not using these features and wish to reduce the size
	//  of your final executable, you should remove from the following
	//  the specific initialization routines you do not need.

#if defined (_MSC_VER) && (_MSC_VER < 1300)
#if defined (_AFXDLL)
	Enable3dControls();			// Call this when using MFC in a shared DLL
#else  // defined (_AFXDLL)
	Enable3dControlsStatic();	// Call this when linking to MFC statically
#endif // defined (_AFXDLL)
#endif // defined (_MSC_VER) && (_MSC_VER < 1300)

	char *pFnd= (char*)strrchr(m_pszHelpFilePath, '\\'); // hack: `m_pszHelpFilePath` is constant type `LPCTSTR`
	if(pFnd != NULL){
		*pFnd= '\0';
		if(_chdir(m_pszHelpFilePath)){
			::MessageBox(NULL, m_pszHelpFilePath, "ERROR: Can't change Folder !", MB_OK | MB_ICONERROR);
			return FALSE;
		}
	}else{
		::MessageBox(NULL, m_pszHelpFilePath, "ERROR: Bad format Folder !", MB_OK | MB_ICONERROR);
		return FALSE;
	}

#if !defined (_GCD_CLIENT) && !defined (PILOT)
	VER_PARAM verParam;
	int	i;

	verParam.exeId= TID_BREEDER;			// defines BASEMASK.H
	verParam.lDstrbtd= VC_NUMBER_GDK_DISTR;	// defines GARVER.H
	verParam.stdOut= stdout;
	verParam.pDate= __DATE__;
	verParam.pTime= __TIME__;

	int argc= 2;
	char *argv[3];

	AskFileName = false;
	for ( int aParam = 0; aParam < __argc; aParam++ )
		if ( !stricmp( __argv[ aParam ], "name" ))
			AskFileName = true;

	*pFnd= '\\';
	argv[0]= (char*)m_pszHelpFilePath;

	if(m_lpCmdLine[0] == _T('\0'))
		argc = 1;
	else{
		argv[1]= m_lpCmdLine;
	}

		if(
			(i=_imp_GVersion(&argc, argv, &verParam))
			){
			if(i == VC_ADD_OK){
				::MessageBox(NULL, "ReExecute programm.", "EXIT: Version control -> Add module.", MB_OK);
				return FALSE;
			}else{
				strcpy(pFnd+1, "Breedr32.exe");
				::MessageBox(NULL, m_pszHelpFilePath, "ERROR: Version control -> Bad module !", MB_OK | MB_ICONERROR);
				return FALSE;
			}
		}
#endif

	handle2GLink= NULL;

#if defined (_GCD_CLIENT) || defined (PILOT)

	CString strErr;
	bool b_waitss_visible = false;	

		Core::ParamManagerReg::instance ();
		if (0 == Core::ParamManagerFactory::get ().init (Core::ParamConvert::make_arg_list (__argc, __argv), GCL::F1::DATA_SETUP)) {
			throw Core::DataNotFound ();
		}

		if (Core::ParamManagerFactory::get ().is_exist ("-eng")) {
			LPTSTR file_name = PathFindFileName (__argv [0]);
			PathRemoveExtension (file_name);

			std::string resource_name = file_name;
			resource_name += "_eng";
			
			this->set_local_resource (resource_name.c_str ());
			extern char formatMsg[128];
			strcpy (formatMsg, "Copying file %s");
			/*mrglib*/set_language (1);
		}

	strcpy (module_file_name, Core::ParamManagerFactory::get ().get_string ("-GCMConfigFile").c_str ());
	if (strlen (module_file_name)) {
		strcat (module_file_name, "\\dummy\\dummy.run");
	} else {
		GetModuleFileName (0, module_file_name, MAX_PATH);
	}

	GCM::GCM_get_manager ()->register_local_component (new GslSessionHandlerClientServer::SessionHandlerClientServerHome);

	{
		GUARD (wait_mutex);
		waitSSDialog = new CWaitServerStart2 ();
	}
	DWORD	threadID;
	hThread = ::CreateThread( NULL, 0, (LPTHREAD_START_ROUTINE) waitss_thread, (LPVOID)this, CREATE_SUSPENDED, &threadID );
	if ( hThread ) {
		::SetThreadPriority( hThread, THREAD_PRIORITY_NORMAL );
		::ResumeThread( hThread );
	}
	b_waitss_visible = true;

cycle_register_and_start:
	try {
		UpdateRunner* pUpdater = new UpdateRunner ();
		pUpdater->PilotDistribPath = Core::ParamManagerFactory::get ().get_string ("-DSDataPath").c_str ();
		if (pUpdater->PilotDistribPath.GetBuffer (0)[0] == '\"') {
			pUpdater->PilotDistribPath.Delete (0, 1);
			pUpdater->PilotDistribPath.Delete (pUpdater->PilotDistribPath.GetLength () - 1, 1);
		}
		Log ("Первоначально данные ищем в каталоге ");
		Log (pUpdater->PilotDistribPath.GetBuffer (0));
		Log ("\n");

		Log ("Пущен: ");
		Log (__argv [0]);
		Log ("\n");
		TimeLog ("Инициализация и регистрация компонент\n");

		GCM::GCMManager_ptr theManager = GCM::GCM_get_manager ();
		theManager->register_component (new GblPilot::PilotClientHome());
		theManager->register_component (new GslHeartbeatManager::HeartbeatManagerClientHome());
		theManager->register_component (new GslUserManager::UserManagerClientHome());
		theManager->register_component (new GslSecurity::SecurityClientHome ());
		theManager->register_local_component (pUpdater);
		TimeLog ("Вызываем start_components\n");
		theManager->start_components (true);
	} catch (GCM::AutoIPConfig::ServerNotFound&) {
		strErr.LoadString (IDS_SERVER_NOT_FOUND);
	} catch (GCM::NoServer&) {
		strErr.LoadString (IDS_SERVER_NOT_FOUND);
	} catch (GCM::AutoIPConfig::BadNetworkConfig&) {
		strErr.LoadString (IDS_BAD_NETWORK_CONFIG);
	} catch (GCM::AutoIPConfig::IPAddressNotFound&) {
		strErr.LoadString (IDS_IP_ADDRESS_NOT_FOUND);
	} catch (Core::DataNotFound&) {
		strErr.LoadString (IDS_DATANOTFOUND);
	} catch (GCM::InvalidName&) {
		strErr.LoadString (IDS_TRANSIENT);
	} catch (GCM::ServerIsStarting&) {
		ACE_OS::sleep (3);
		try {
			GCM::GCM_get_manager ()->stop_components ();
		} catch (...) {}
		/*
		TODO!
		GCM::clear_component<GslHeartbeatManager::HeartbeatManagerClientHome> ();
		GCM::clear_component<GblPilot::PilotClientHome> ();
		GCM::clear_component<GslUserManager::UserManagerClientHome> ();
		GCM::clear_component<GslSessionHandlerClientServer::SessionHandlerClientServerHome> ();
		GCM::clear_component<GblLogging::LoggingClientHome> ();
		GCM::clear_component<GslSecurity::SecurityClientHome> ();
		*/
		GCM::GCM_clear_manager ();
		TimeLog ("Исключение ServerIsStaring, перезапускаем компоненты\n");
		goto cycle_register_and_start;
	} catch (CORBA::TRANSIENT&) {
		strErr.LoadString (IDS_TRANSIENT);
	} catch (CORBA::Exception& ex) {
		strErr = CString ("CORBA::Exception ") + ex._rep_id ();
	} catch (...) {
		strErr = CString ("GCMManager::register_... or GCMManager::start_component: unknown exeption");
	}
	if (!strErr.IsEmpty ()) {
		{
		CloseHandle (hThread);
		GUARD (wait_mutex);
		if (waitSSDialog) {
			if (waitss_inmodal)
				waitSSDialog->EndDialog (IDOK);
			delete waitSSDialog;
			waitSSDialog = 0;
		}
		}
		TimeLog (strErr.GetBuffer (0));
		AfxMessageBox (strErr.GetBuffer ());
		try {
			GCM::GCM_get_manager ()->stop_components ();
		} catch (...) {
			// в зависимости от ситуации stop_components может выполнится, а может нет!!!!
			// если не может выполнится возможны утечки
		}
		return FALSE;
	}
	TimeLog ("Выход\n\n------------------------------------------------------------\n\n");
	RenameLog (global_success);
	return TRUE;
#else
	CTestBreeder32Dlg dlg;
	m_pMainWnd = &dlg;

	*pFnd= '\0';
	dlg.m_CurrHlpName= m_pszHelpFilePath + dlg.m_CurrHlpName;
	*pFnd= '\\';
  #ifdef INC_OLD_FAST_CPY
	CString scmd(m_lpCmdLine);
	scmd.MakeUpper();
	if(scmd.Find("-C") != -1 )
		dlg.not_Cache = TRUE;
	else
		dlg.not_Cache = FALSE;
  #endif

	int nResponse = dlg.DoModal();
	if (nResponse == IDOK)
	{
		// TODO: Place code here to handle when the dialog is
		//  dismissed with OK
	}
	else if (nResponse == IDCANCEL)
	{
		// TODO: Place code here to handle when the dialog is
		//  dismissed with Cancel
	}

	// Since the dialog has been closed, return FALSE so that we exit the
	//  application, rather than start the application's message pump.
	return FALSE;
#endif
}

int CTestBreeder32App::ExitInstance() 
{
#if defined (_GCD_CLIENT) || defined (PILOT)

	Core::fini();
#endif
	if (handle2GLink != NULL) 
		FreeLibrary(handle2GLink);
	
	return CWinApp::ExitInstance();
}
