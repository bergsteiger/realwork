//
// Downloader.cpp : Defines the class behaviors for the application.
//

#include "stdafx.h"

#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/Core/sys/start_stop.h"
#include "shared/Core/sys/AutoInit.h"
#include "shared/Core/Params/Params.h"
#include "shared/Core/ParamsHelper/ParamConvert.h"
#include "shared/Core/fix/wine.h"

#include "shared/jsoncpp/json.h"

#include "shared/Internet/impl/Inet_i/Connect_i_factory.h"
#include "shared/Internet/impl/Inet_i/Connection_i_factory.h"

#include "boost/bind.hpp"
#include "boost/thread.hpp"
#include "boost/lexical_cast.hpp"

#include "garantServer/src/Global/Core/Common/ParamManagerReg.h"
#include "garantServer/src/Global/Defines/Common/ProjectConsts.h"

#include "Common.h"
#include "Config.h"
#include "LogFile.h"
#include "ServerConnect.h"
#include "DownloadProcess.h"
#include "InternetFileDownload.h"
#include "Downloader.h"
#include "LoginDlg.h"
#include "DownloaderDlg.h"
#include "EndDownloadDlg.h"

#include "gardefs.h"
#include "htmlhelp.h"

#if defined _GCD_CLIENT
#include "garantServer/src/Global/Defines/DefinesC.h"
#include "garantServer/src/Business/GblPilot/Home/Client.h"
#include "garantServer/src/Global/Core/Common/GCMManagerHome.h"
#include "garantServer/src/Global/Core/Common/AutoIPConfig.h"
#include "garantServer/src/Services/GslUserManager/Client/UserManagerClientHome.h"
#include "garantServer/src/Global/Core/Common/GCMSimpleComponents.h"

#include <shlwapi.h>

class ServerDataClient
	: public GCM::GCMSimpleServer {
public:	
	ServerDataClient ();

	void execute ();
};
#endif

/////////////////////////////////////////////////////////////////////////////

static const unsigned long BUF_SIZE = 16 * 1024;

class NeedManuaMode
	: public std::exception {
public:
	virtual const char* what () const throw () {
		return "need manual mode";
	}
};

class DownloadError
	: public std::exception {
public:
	virtual const char* what () const throw () {
		return "special exception";
	}
};

/////////////////////////////////////////////////////////////////////////////

static void run_process (const char* cmd_line, bool is_auto) {
	STARTUPINFO si;
	PROCESS_INFORMATION pi;

	ZeroMemory (&si, sizeof (si));
	si.cb = sizeof (si);
	ZeroMemory (&pi, sizeof (pi));

	if (!CreateProcess (       // start the child process...
		NULL                   // no module name (use command line)
		, (LPSTR) cmd_line     // command line
		, NULL                 // process handle not inheritable
		, NULL                 // thread handle not inheritable
		, FALSE                // set handle inheritance to FALSE
		, 0                    // no creation flags
		, NULL                 // use parent's environment block 
		, NULL                 // use parent's starting directory 
		, &si                  // pointer to STARTUPINFO structure
		, &pi)                 // pointer to PROCESS_INFORMATION structure
	) {
		std::string err_str = get_last_error ();

		DLOG->out_t ("%s: %s", GDS_CURRENT_FUNCTION, err_str.c_str ());

		if (is_auto == false) {
			CString title;
			title.LoadString (IDS_DONT_RUN_PROGRAM);

			CString msg;
			msg.Format (IDS_CANT_RUN_PROCESS, cmd_line);
			msg += err_str.c_str ();

			::MessageBox (NULL, msg.GetBuffer (), title.GetBuffer (), MB_OK | MB_ICONSTOP | MB_APPLMODAL);
		}
	}

	// Wait until child process exits. WaitForSingleObject (pi.hProcess, INFINITE);

	// Close process and thread handles. 
	CloseHandle (pi.hProcess);
	CloseHandle (pi.hThread);
}

CDownloaderApp theApp;

/////////////////////////////////////////////////////////////////////////////
// CDownloaderApp

BEGIN_MESSAGE_MAP(CDownloaderApp, CWinApp)
	//{{AFX_MSG_MAP(CDownloaderApp)
	//}}AFX_MSG
	ON_COMMAND(ID_HELP, CWinApp::OnHelp)
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CDownloaderApp construction & destruction

CDownloaderApp::CDownloaderApp ()
    : m_app_handle (INVALID_HANDLE_VALUE)
	, m_state (ds_Error)
	, m_return_value (rc_Succesful)
	, m_complect_id (-1)
	, m_time_limit_connect (-1)
	, m_has_init (0)
	, m_is_auto (false)
	, m_is_week (false)
	, m_is_strong (false)
	, m_is_run_update (false)
	, m_is_rewrite (false)
	, m_is_etalon (false) 
{
	m_revision_date = COleDateTime::GetCurrentTime ();
}

CDownloaderApp::~CDownloaderApp () {
	if (m_app_handle != INVALID_HANDLE_VALUE) {
		CloseHandle (m_app_handle);
	}
}

/////////////////////////////////////////////////////////////////////////////
// CDownloaderApp initialization

BOOL CDownloaderApp::InitInstance () {
#ifdef _AFXDLL
	Enable3dControls ();        // Call this when using MFC in a shared DLL
#else
	Enable3dControlsStatic ();  // Call this when linking to MFC statically
#endif

	Core::AutoInit init;
	{
		Internet::Inet_i::Connect_i_factory_var factory = new Internet::Inet_i::Connect_i_factory ();
		factory->registrate_me (0);
	} {
		Internet::Inet_i::Connection_i_factory_var factory = new Internet::Inet_i::Connection_i_factory ();
		factory->registrate_me (0);
	}

	try {
		this->initialize ();
	} catch (...) {
		m_return_value = rc_Error;
		DLOG->out_t ("%s: initialize: exception handled", GDS_CURRENT_FUNCTION);
		return FALSE;
	}

#if defined _GCD_CLIENT
	DLOG->out_t_ext ("%s: corba_client_thread_start", GDS_CURRENT_FUNCTION);
	boost::thread corba_client_thread (boost::bind (&CDownloaderApp::start_corba_client, this));
#endif

	try {
		this->execute ();
	} catch (...) {
		m_return_value = rc_Error;
		DLOG->out_t ("%s: execute: exception handled", GDS_CURRENT_FUNCTION);
	}

#if defined _GCD_CLIENT
	DLOG->out_t_ext ("%s: corba_client_thread_join", GDS_CURRENT_FUNCTION);
	corba_client_thread.join ();
#endif

	return FALSE;
}

int CDownloaderApp::ExitInstance () {
	CWinApp::ExitInstance ();
	return (int) m_return_value;
}

void CDownloaderApp::init_params () {
	Core::ParamManagerReg::instance ();

	if (0 == Core::ParamManagerFactory::get ().init (Core::ParamConvert::make_arg_list (__argc, __argv), GCL::F1::DOWNLOADER)) {
		throw Core::DataNotFound ();
	}

	m_module_path = Core::ParamManagerFactory::get ().get_string ("-GCMConfigFile");

	if (m_module_path.empty () == false) {
		size_t pos = m_module_path.find_last_of ('\\');

		if (pos != std::string::npos) {
			m_module_path.erase (pos);
		}

		SetCurrentDirectory (m_module_path.c_str ());
	}

	m_is_auto = Core::ParamManagerFactory::get ().is_exist ("-auto");
	m_is_rewrite = Core::ParamManagerFactory::get ().is_exist ("-rewrite");
	m_is_week = m_is_strong = Core::ParamManagerFactory::get ().is_exist ("-week");
	m_is_run_update = Core::ParamManagerFactory::get ().is_exist ("-runupdate");

	/*
	if (m_is_strong == false) { 
		m_is_strong = Core::ParamManagerFactory::get ().is_exist ("-strong");
	}
	*/

	if (Core::ParamManagerFactory::get ().is_exist ("-useragent")) {
		m_user_agent = Core::ParamManagerFactory::get ().get_string ("-useragent");
	}
	if (m_user_agent.empty ()) {
		m_user_agent = AfxGetAppName ();
	} 
	if (Core::ParamManagerFactory::get ().is_exist ("-id")) {
		m_complect_id = Core::ParamManagerFactory::get ().get_long ("-id");
	}
	if (Core::ParamManagerFactory::get ().is_exist ("-server")) {
		m_default_server = Core::ParamManagerFactory::get ().get_string ("-server");
	} 
	if (m_default_server.empty ()) {
		m_default_server = "mirror.garant.ru";
	}
	if (Core::ParamManagerFactory::get ().is_exist ("-dsc")) {
		m_time_limit_connect = Core::ParamManagerFactory::get ().get_long ("-dsc");
	}
	if (Core::ParamManagerFactory::get ().is_exist ("-path")) {
		m_default_path =  Core::ParamManagerFactory::get ().get_string ("-path");
	} 
	if (Core::ParamManagerFactory::get ().is_exist ("-from")) {
		m_date_from = Core::ParamManagerFactory::get ().get_string ("-from");
		std::replace (m_date_from.begin (), m_date_from.end (), '.', '-');
	} 
	if (Core::ParamManagerFactory::get ().is_exist ("-to")) {
		m_date_to = Core::ParamManagerFactory::get ().get_string ("-to");
		std::replace (m_date_to.begin (), m_date_to.end (), '.', '-');
	}
	if (Core::ParamManagerFactory::get ().is_exist ("-eng")) {
		LPTSTR file_name = PathFindFileName (__argv [0]);
		PathRemoveExtension (file_name);

		std::string resource_name = file_name;
		resource_name += "_eng";

		this->set_local_resource (resource_name.c_str ());
	}
}

void CDownloaderApp::set_local_resource (const char* dll_name) {
	HMODULE language_handle = (HMODULE) NULL;

	m_res_loader = new GCL::DllLoader (dll_name);

	if (m_res_loader.ptr ()) {
		language_handle = static_cast <HMODULE> (m_res_loader->get_handle ());
	} 

	if (language_handle) {
		AfxSetResourceHandle (language_handle);
	} else {
		DLOG->out_t ("%s: %s.dll not loaded", GDS_CURRENT_FUNCTION, dll_name);
	}
}

void CDownloaderApp::show_help (const char* page_htm) {
	std::string str = m_module_path + "\\apps\\winnt";
	std::string help_file_name = str + "\\..\\..\\help\\F1DataTools.chm";

	if (ACE_OS::access (help_file_name.c_str (), R_OK) == -1) {
		help_file_name = str + "\\F1DataTools.chm";
	}

	help_file_name += std::string ("::/") + page_htm;
	::HtmlHelp (NULL, help_file_name.c_str (), HH_DISPLAY_TOPIC, NULL);
}

bool CDownloaderApp::is_first_application () {
	std::string str = m_module_path + "\\apps\\winnt\\f1download.run";
	std::replace (str.begin (), str.end (), '\\', '-');

	GCL::to_upper (str);

	if (OpenEvent (EVENT_ALL_ACCESS, FALSE, str.c_str ()) == 0) {
		m_app_handle = CreateEvent (NULL, TRUE, TRUE, str.c_str ());
	}

	return m_app_handle != INVALID_HANDLE_VALUE;
}

void CDownloaderApp::initialize () {
	this->init_params ();

#if defined _GCD_CLIENT
	DLOG->open (m_module_path + "\\Logs\\download.log");
#else
	DLOG->open (m_module_path + "\\download.log");
#endif

	if (this->is_first_application () == false) { // only one CDownloaderApp object
		CString msg, caption;
		caption.Format (IDS_DONT_RUN_PROGRAM);
		msg.Format (IDS_APPLICATION_ALREADY_RUNNING);

		if (!m_is_auto) {
			::MessageBox (NULL, msg.GetBuffer (), caption.GetBuffer (), MB_OK | MB_ICONSTOP | MB_APPLMODAL);
		}

		DLOG->out_t (IDS_ERROR_LOAD_SECOND_APPLICATION);
		throw std::exception ();
	}

	m_ini_name = m_module_path + "\\garant.ini";

	DConfigManager::instance ()->init (m_ini_name, "Downloader");
	DLOG->set_extended (DConfigManager::instance ()->get_int ("ExtLog") == 1);

	this->read_inet_settings ();  // internet access settings

	AfxEnableControlContainer (); // enable control container
}

void CDownloaderApp::start_corba_client () {
	DLOG->out_t_ext ("%s: start", GDS_CURRENT_FUNCTION);

	CString err;

	try {
		GCM::GCMManager_ptr manager = GCM::GCM_get_manager ();

		manager->register_local_component (new ServerDataClient ());
		manager->register_component (new GblPilot::PilotClientHome ());
		manager->register_component (new GslUserManager::UserManagerClientHome ());
		manager->start_components (true);

	} catch (GCM::AutoIPConfig::ServerNotFound&) {
		err.Format (IDS_SERVER_NOT_FOUND);
	} catch (GCM::NoServer&) {
		err.Format (IDS_SERVER_NOT_FOUND);
	} catch (GCM::AutoIPConfig::BadNetworkConfig&) {
		err.Format (IDS_BAD_NETWORK_CONFIG);
	} catch (GCM::AutoIPConfig::IPAddressNotFound&) {
		err.Format (IDS_IP_ADDRESS_NOT_FOUND);
	} catch (Core::DataNotFound&) {
		err.Format (IDS_DATANOTFOUND);
	} catch (GCM::InvalidName&) {
		err.Format (IDS_TRANSIENT);	
	} catch (GCM::ServerIsStarting&) {
		err.Format (IDS_SERVER_IS_STARTING);
	} catch (CORBA::TRANSIENT&) {
		err.Format (IDS_TRANSIENT);
	} catch (CORBA::ORB::InvalidName&) {
		err.Format (IDS_TRANSIENT);
	} catch (CORBA::Exception& ex) {
		err = CString ("CORBA::Exception ") + ex._rep_id ();
	} catch (...) {
		err = CString ("GCMManager::register_XXX or GCMManager::start_component: unknown exception");
	}

	if (!err.IsEmpty ()) {
		m_has_init = 2; // чтобы не повесить основной поток

		DLOG->out_t ("%s: %s", GDS_CURRENT_FUNCTION, err.GetBuffer ());

		if (m_is_auto == false) {
			::MessageBox (NULL, err.GetBuffer (), AfxGetAppName (), MB_OK | MB_ICONSTOP);
		}
		try {
			GCM::GCM_get_manager ()->stop_components ();
		} catch (...) {
			// В зависимости от ситуации stop_components может выполнится, а может нет!
			// Если не может выполнится, то возможны утечки. 

			DLOG->out_t ("%s: UEX in stop_components", GDS_CURRENT_FUNCTION);
		}
	}

	DLOG->out_t_ext ("%s: finish", GDS_CURRENT_FUNCTION);
}

void CDownloaderApp::execute () {
	DLOG->out_t_ext ("%s: start", GDS_CURRENT_FUNCTION);
	{
		std::string str_ver = get_windows_version ();
		std::string str_ip  = get_local_ip_addr ();

		DLOG->out_t ("IP Address: %s", str_ip.c_str ());
		DLOG->out_t ("Version of Windows: %s", str_ver.c_str ());
		DLOG->out_t ("Command line: %s", m_lpCmdLine);
		DLOG->out_t ("User Agent: %s", m_user_agent.c_str ());
		DLOG->out_t ("Mode: %s", (m_is_auto)? "AUTOMATIC" : "MANUAL");
	}

	while (m_has_init == 0) { // ждем пока корба-клиент инициализирует данные
		ACE_OS::sleep (0);
	}

	if (m_has_init == 2) {
		return;
	}

	if (m_is_auto) {
		try {
			this->start_auto (); // start in auto mode
		} catch (const NeedManuaMode&) {
			m_return_value = rc_Error;
		} catch (const NoUpdate&) {
			m_return_value = rc_NoUpdate;
		} catch (const DownloadError&) {
			m_return_value = rc_NoUpdate;
		} catch (...) {
			m_return_value = rc_Error;
		}
	} else {
		try {
			this->start_manual ();
		} catch (...) {
			DLOG->out_t ("%s: start_manual: exception handled", GDS_CURRENT_FUNCTION);
		}
	}

	if (m_is_run_update && m_return_value == rc_Succesful) {
		try {
			this->start_update ();
		} catch (...) {
			DLOG->out_t ("%s: start_update: exception handled", GDS_CURRENT_FUNCTION);
		}
	}

	DLOG->out_t_ext ("%s: finish", GDS_CURRENT_FUNCTION);
}

void CDownloaderApp::start_update () {
#ifdef _GCD_CLIENT
	DLOG->out_t (IDS_RUN_UPDATE_UTIL);

	std::string cmd_line = '"' + m_module_path + std::string ("\\garant.exe\" F1DataUpd");

	if (m_is_auto) { 
		cmd_line += std::string (" auto ") + '"';
		cmd_line += m_default_path + '"';
	} else {
		std::string str = DConfigManager::instance ()->get ("Path");

		if (str.empty () == false && *(str.rbegin ()) == '\\') {
			str.erase (str.size () - 1);
		}

		cmd_line += " fromdownload \"";
		cmd_line += str + "\" ";
	}

	if (Core::ParamManagerFactory::get ().is_exist ("-login")) {
		std::string update_login = Core::ParamManagerFactory::get ().get_string ("-login");
		if (update_login.size ()) {
			cmd_line += std::string (" -login ") + update_login;
		}
	}

	if (Core::ParamManagerFactory::get ().is_exist ("-pwd")) {
		std::string update_pwd = Core::ParamManagerFactory::get ().get_string ("-pwd");
		if (update_pwd.size ()) {
			cmd_line += std::string (" -pwd ") + update_pwd;
		}
	}

	if (Core::ParamManagerFactory::get ().is_exist ("-nobackup")) { 
		cmd_line += " nobackup";
	}
	if (Core::ParamManagerFactory::get ().is_exist ("-nofinalmessage")) { 
		cmd_line += " nofinalmessage";
	}
	if (Core::ParamManagerFactory::get ().is_exist ("-deletezips")) {
		cmd_line += " deletezips";
	}

	run_process (cmd_line.c_str (), m_is_auto);

	DLOG->out_t_ext ("%s: finish", GDS_CURRENT_FUNCTION);
#endif
}

void CDownloaderApp::start_auto () {
	DLOG->out_t_ext ("%s: start", GDS_CURRENT_FUNCTION);

	std::string str_begin, str_end, str_begin_, str_end_;
	{
		COleDateTime current_date = COleDateTime::GetCurrentTime ();
		COleDateTime beg_date = m_revision_date, end_date = current_date;

		if (m_date_from.empty () == false) {
			beg_date.ParseDateTime (m_date_from.c_str (), VAR_DATEVALUEONLY);
		}
		if (m_date_to.empty () == false) {
			end_date.ParseDateTime (m_date_to.c_str (), VAR_DATEVALUEONLY);
			m_is_strong = true;
		} 

		if (beg_date.GetStatus () != 0 || end_date.GetStatus () != 0) {
			DLOG->out_t ("%s: invalid date", GDS_CURRENT_FUNCTION);
			throw std::exception ();
		}
		if (!m_is_etalon && (beg_date >= end_date || end_date > current_date)) {
			DLOG->out_t ("%s: incorrect period", GDS_CURRENT_FUNCTION);
			throw std::exception ();
		}

		str_begin = beg_date.Format (_T ("%m-%d-%Y")).GetBuffer ();
		str_end = end_date.Format (_T ("%m-%d-%Y")).GetBuffer ();

		str_begin_ = beg_date.Format (_T ("%d-%m-%Y")).GetBuffer ();
		str_end_ = end_date.Format (_T ("%d-%m-%Y")).GetBuffer ();

		if (m_is_week) {
			init_week (str_begin, str_begin_, -1);
			init_week (str_end, str_end_, 1);
		}
	} 

	std::string str_login = DConfigManager::instance ()->get ("Login");
	std::string str_password = DConfigManager::instance ()->get_crypt ("Pswd");

	if (str_login.empty () || str_password.empty ()) {
		DLOG->out_t (IDS_ERROR_NOT_INIT_LOGIN_OR_PASSWORD);
		throw NeedManuaMode ();
	}

	switch (this->authorization (str_login.c_str (), str_password.c_str (), m_is_strong)) {
		case as_InvalidLogin:
			DLOG->out_t (IDS_ERROR_INCORRECT_LOGIN);
			throw NeedManuaMode ();
		case as_InvalidData:
			DLOG->out_t (IDS_ERROR_USERS_AUTHORIZATION);
			throw NeedManuaMode ();
		case as_Error:
			DLOG->out_t (IDS_ERROR_HTTP_ERROR);
			throw DownloadError ();
	}

	CString str;

	long complect_id = this->get_complect_id ();

	std::string complect_name = this->get_complect_name (complect_id);

	if (complect_name.empty () && m_personification_key.size () == 0) {
		str.Format (IDS_COMPLECT_NOT_REGISTRED, complect_id);
		DLOG->out_t (str);
		throw std::exception ();
	}

	DownloadManager obj ((m_default_path.empty ())? DConfigManager::instance ()->get ("Path") : m_default_path);

	switch (obj.execute (complect_id, str_begin, str_end)) {
		case ds_Success:
			DLOG->out_t (IDS_STATIC_DOWNLOAD_NORMAL);
			break;
		case ds_Cancel:
			DLOG->out_t (IDS_STATIC_DOWNLOAD_CANCELED);
			break;
		case ds_Abort:
			DLOG->out_t (IDS_STATIC_DOWNLOAD_ABORTED);
			throw AbortedProcess ();
		case ds_Repeat:
		case ds_Error:
			throw DownloadError ();
		case ds_NoUpdate:
			str.Format (IDS_ERROR_NO_UPDATE, complect_name.c_str (), str_begin_.c_str (), str_end_.c_str ());
			DLOG->out_t (str);
			throw NoUpdate ();
	}

	DLOG->out_t_ext ("%s: finish", GDS_CURRENT_FUNCTION);
}

void CDownloaderApp::start_manual () {
	CLoginDlg login_dlg;
	CDownloaderDlg downloader_dlg;
	CEndDownloadDlg end_dlg;

	bool is_back = false, is_exit = true;

	while (is_exit) {
		if (is_back) {
			is_back = false;
		} else if (login_dlg.DoModal () == IDCANCEL) { // start of user's authorization dialog  
			break;
		}

		switch (downloader_dlg.DoModal ()) { // start download dialog
		case IDBACK:
			if (is_back) { 
				is_back = false;
			}
			break;
		case IDCANCEL:
			is_exit = false; 
			break;
		case IDOK:
			if (m_is_run_update) {
				is_exit = false;
			} else {
				int res = end_dlg.DoModal (); // start of finaly dialog
				
				if (res == IDCANCEL || res == IDOK) { 
					is_exit = false; 
				} else {
					is_back = (res == IDBACK);
				}
			}
			break;
		}
	}
}

std::string CDownloaderApp::get_path () {
	std::string ret = m_default_path;

	if (ret.empty ()) {
		ret = DConfigManager::instance ()->get ("Path");

		if (ret.empty ()) {
			ret = m_module_path + "\\Delta\\";
		} 
	} 

	if (ret [ret.size () - 1] != '\\') {
		ret += '\\';
	}

	return ret;
}

void CDownloaderApp::write_inet_settings (const Internet::InternetAccessInfo& info) {
	char buffer [2048];

	ConfigManager* conf_manager = DConfigManager::instance ();

	conf_manager->set ("AccessType", info.access_type);
	conf_manager->set ("Queries Flags", ltoa (info.open_query_flags, buffer, 10));
	conf_manager->set ("ProxyAuthentication", (info.proxy_info.is_authentication)? 1 : 0);
	conf_manager->set ("ProxyAdress", info.proxy_info.host);
	conf_manager->set ("ProxyPort", info.proxy_info.port);
	conf_manager->set ("ProxyLogin", CryptHelper::encode (info.proxy_info.login));
	conf_manager->set ("ProxyPassword", CryptHelper::encode (info.proxy_info.password));
}

void CDownloaderApp::read_inet_settings () {
	ConfigManager* conf_manager = DConfigManager::instance ();

	std::string str = conf_manager->get ("Queries Flags");

	m_access_info.access_type = conf_manager->get_int ("AccessType");
	m_access_info.open_query_flags = (str.empty ())? 0 : atoi (str.c_str ());
	m_access_info.proxy_info.is_authentication = (conf_manager->get_int ("ProxyAuthentication") == 1);
	m_access_info.proxy_info.host = conf_manager->get ("ProxyAdress");
	m_access_info.proxy_info.port = conf_manager->get ("ProxyPort");
	m_access_info.proxy_info.login = CryptHelper::decode (conf_manager->get ("ProxyLogin"));
	m_access_info.proxy_info.password = CryptHelper::decode (conf_manager->get ("ProxyPassword"));
}

/////////////////////////////////////////////////////////////////////////////////////

AuthStatus CDownloaderApp::init_complects (Internet::IConnection* connection) {
	char buf [BUF_SIZE];

	unsigned int bytes = connection->read (static_cast <void*> (buf), sizeof (buf));

	if (bytes) {
		buf [bytes] = 0;

		Json::Value root; // will contains the root value after parsing
		Json::Reader reader;

		if (reader.parse (buf, root) == false) {
			DLOG->out_t ("%s: failed to parse configuration", GDS_CURRENT_FUNCTION);
			return as_InvalidData;
		}

		if (root ["success"].asBool () == false) {
			return as_InvalidLogin;
		}

		const Json::Value& data = root ["complects"];

		if (data.isArray ()) {
			Json::UInt i = 0, count = data.size ();

			m_complects.resize ((size_t) count);

			for (; i < count; ++i) {
				m_complects [i].name = GCL::utf8_to_win1251 (data [i].get ("name", "").asString ());
				m_complects [i].id = data [i].get ("id", "").asUInt ();
			}

			std::sort (m_complects.begin (), m_complects.end ());

			return as_Succesful;
		}
	} else {
		DLOG->out_t ("%s: invalid http buffer", GDS_CURRENT_FUNCTION);
		m_return_value = rc_Error;
	}

	return as_InvalidData;
}

AuthStatus CDownloaderApp::authorization (const char* login, const char* password, bool is_strong) {
	DLOG->out_t_ext ("%s: start", GDS_CURRENT_FUNCTION);

	if (this->server_connect ()) { // connect to server
		Internet::IConnect_var connect = Internet::ConnectManager::instance ()->get_connect ();
		Internet::IConnection_var connection = connect->get_connection ();

		Connection obj (connection.in ());

		ScriptManager* script_manager = ScriptManagerSingleton::instance ();
		script_manager->init (m_is_auto, is_strong, login, m_personification_key);

		if (obj.execute_request (script_manager->get_authorization_script (password))) {
			DLOG->out_t_ext ("%s: finish", GDS_CURRENT_FUNCTION);
			return this->init_complects (connection.in ());
		} 
	}

	DLOG->out_t_ext ("%s: finish", GDS_CURRENT_FUNCTION);
	return as_Error;
}

long CDownloaderApp::get_complect_id () {
	return ((m_complect_id < 0) ? DConfigManager::instance ()->get_int ("IdComplect") : m_complect_id);
}

std::string CDownloaderApp::get_complect_name (unsigned id) {
	Complects::const_iterator it;
	it = std::find_if (m_complects.begin (), m_complects.end (), boost::bind (&Complect::id, _1) == id);
	return (it == m_complects.end ())? "" : it->name;
}

/////////////////////////////////////////////////////////////////////////////////////

bool CDownloaderApp::server_connect (bool is_reconnect) {
	if (m_access_info.access_type == INTERNET_OPEN_TYPE_PROXY) {
		const Internet::ProxyInfo& proxy_info = m_access_info.proxy_info;

		CString str;
		str.Format (IDS_USE_PROXY_SERVER, proxy_info.host.c_str (), proxy_info.port.c_str ());
		DLOG->out_t (str);

		if (proxy_info.is_authentication) { // авторизация на прокси
			str.Format (IDS_ATTEMPT_USER_AUTHORIZATION_ON_PROXY, proxy_info.login.c_str ());
			DLOG->out_t (str);
		}
	} else if (m_access_info.access_type == INTERNET_OPEN_TYPE_PRECONFIG) {
		DLOG->out_t (IDS_USE_PRECONFIG_TYPE);
	}

	try {
		DLOG->out_t_ext ("%s: start connect", GDS_CURRENT_FUNCTION);
		Internet::ConnectManager* manager = Internet::ConnectManager::instance ();

		manager->init (m_access_info, is_reconnect);
		Internet::IConnect_var connect = manager->get_connect ();

		if (connect.is_nil () == false) {
			connect->execute (m_default_server, m_user_agent);
			DLOG->out_t_ext ("%s: finish connect", GDS_CURRENT_FUNCTION);
			return true;
		}

		DLOG->out_t_ext ("%s: invalid connect", GDS_CURRENT_FUNCTION);

	} catch (Internet::ConnectionFailed&) {
		CString str;
		str.LoadString (IDS_CONNECTION_FAILED);
		DLOG->out_t ("%s: %s", GDS_CURRENT_FUNCTION, str.GetBuffer ());
	} catch (Internet::ParseURLException& ex) {
		DLOG->out_t ("%s: %s", GDS_CURRENT_FUNCTION, ex.what ());
	} catch (CInternetException* ex) {
		DLOG->out_t ("%s: %s", GDS_CURRENT_FUNCTION, InetException::what (ex).c_str ());
	} catch (...) {
		DLOG->out_t ("%s: unknown exception", GDS_CURRENT_FUNCTION);
	}

	return false;
}

bool CDownloaderApp::server_connect () {
	DLOG->out_t_ext ("%s: start", GDS_CURRENT_FUNCTION);

	//m_default_server = "test-spp.garant.ru";

	bool ret = this->server_connect (false);

	if (ret == false && m_is_auto == false) {
		CString msg, caption;
		caption.Format (IDS_ATTENTION);
		msg.Format (IDS_CONNECTION_FAILED);

		::MessageBox (NULL, msg.GetBuffer (), caption.GetBuffer (), MB_OK | MB_ICONEXCLAMATION);
	}

	DLOG->out_t_ext ("%s: finish", GDS_CURRENT_FUNCTION);

	return ret;
}

/////////////////////////////////////////////////////////////////////////////////////
// ServerDataClient

#if defined _GCD_CLIENT

ServerDataClient::ServerDataClient () {
	GCMSimpleServer::register_receptacles (Defines::FN_FUNCTION_MNG);
	GCMSimpleServer::register_receptacles (Defines::FN_USER_MANAGER);
}

void ServerDataClient::execute () {
	CDownloaderApp* ptr_app = GetAppPtr ();

	DLOG->out_t_ext ("%s: component_execute", GDS_CURRENT_FUNCTION);

	GCMComponentBase::execute ();

	DLOG->out_t_ext ("%s: check_datastore", GDS_CURRENT_FUNCTION);

	CORBA::Object_var object = provide (Defines::FN_FUNCTION_MNG);
	GblPilot::FunctionMng_var function_mng = GblPilot::FunctionMng::_narrow (object);

	GblPilotDef::StorageStatus storage_status = function_mng->check_datastore ();
	
	if (storage_status == GblPilotDef::SS_OK) {
		DLOG->out_t_ext ("%s: get_segments_info", GDS_CURRENT_FUNCTION);

		try {
			GblPilotDef::AllSegmentInfo_var all_segs_info = function_mng->get_segments_info ();

			for (unsigned short i = 0; i < all_segs_info->real_segments.length (); ++i) {
				if (all_segs_info->real_segments [i].id == DEMO_SEGMENT) {
					ptr_app->set_etalon_value (true);
				}
			}
		} catch (...) {
			ptr_app->set_etalon_value (true);
		}

		DLOG->out_t_ext ("%s: get_personification_key", GDS_CURRENT_FUNCTION);

		try {
			GblPilotDef::PersonificationKey_var key = function_mng->get_personification_key ();
			std::string str_key (reinterpret_cast <const char*> (key->get_buffer ()), key->length ());
			ptr_app->set_personification_key (str_key);
		} catch (...) {
			DLOG->out_t ("%s: get_personification_key: exception handled", GDS_CURRENT_FUNCTION);
		}

		DLOG->out_t_ext ("%s: get_base_revision", GDS_CURRENT_FUNCTION);

		try {
			GblPilotDef::DocDate r_date = function_mng->get_base_revision ();
			ptr_app->get_revision ().SetDate (r_date.m_year, r_date.m_mounth, r_date.m_day);
		} catch (...) {
			DLOG->out_t ("%s: get_base_revision: exception handled", GDS_CURRENT_FUNCTION);
		}
	}

	ptr_app->set_init ();

	DLOG->out_t_ext ("%s: cs_exit_requested", GDS_CURRENT_FUNCTION);

	status (GCM::cs_exit_requested);

	DLOG->out_t_ext ("%s: finish", GDS_CURRENT_FUNCTION);
}

#endif

// end of..
