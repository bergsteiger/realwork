////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/UsersImportLib/UsersImportMain.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<LibExecutor::Class>> garant6x::UsersImportLib::LibSupport::UsersImportMain
//
// методы высокого уровня
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "ace/Signal.h"
#include "garant6x/implementation/Garant/UsersImportLib/UsersImportMain.h"
// by <<uses>> dependencies
#include "garant6x/implementation/Garant/UsersImportLib/UsersImport/UsersImportFactories.h"
#include "garant6x/implementation/Garant/UsersImportLib/UsersImport/UsersImport.h"
#include "garant6x/implementation/Garant/UsersImportLib/impl/UsersImport_i/Writer_i_factory.h"
#include "garant6x/implementation/Garant/UsersImportLib/impl/UsersImport_i/Writer_i.h"

//#UC START# *481D6E04016B_CUSTOM_INCLUDES*
#include "shared/Core/Params/Params.h"

#include "garantServer/src/Global/Core/Common/GCMManagerHome.h"
#include "garantServer/src/Global/Core/Common/AutoIPConfig.h"
#include "garantServer/src/Services/GslUserManager/Client/UserManagerClientHome.h"
#include "garantServer/src/Services/GslSessionHandlerClient/Home/Server.h"
//#UC END# *481D6E04016B_CUSTOM_INCLUDES*

//#UC START# *481D6E04016B_CUSTOM_BODY*
//#UC END# *481D6E04016B_CUSTOM_BODY*

//////////////////////////////////////////////////////////////////////////////////////////
// main execute method

void UsersImportMain::execute_ () {
	try {
		
		ACE_Sig_Action ((ACE_SignalHandler)UsersImportMain::handle_control, SIGTERM);
		ACE_Sig_Action ((ACE_SignalHandler)UsersImportMain::handle_control, SIGINT);
		ACE_Sig_Action ((ACE_SignalHandler)UsersImportMain::handle_control, SIGQUIT);
	
		//#UC START# *481D6E04016B*
		{  // грохаем все бизнес-объекты перед остановом gcm
			this->init_environment ();
			std::string file_name;
			this->get_path_to_datafile (file_name);
			if (file_name.empty ()) {
				LOG_E (("can't find file with data for import. Use '-f' option"));
				this->usage ();
				this->set_current_status(Core::Root::ES_ERROR);
				return;
			}

			UsersImport::DataWriter_var writer (this->init ());
			UsersImport::DataParser_var parser (UsersImport::DataParserFactory::make (writer._sretn ()));
			try {
				UsersImport::DataReader_var reader (
					UsersImport::DataReaderFactory::make (file_name, parser.ptr ())
				);
			} catch (UsersImport_i::CantFindUserManager&) {
				LOG_E (("error: can't get server component"));
			} catch (UsersImport_i::BadSourceFile&) {
				LOG_E (("can't read data from file: %s", file_name.c_str ()));
			} catch (GslUserManager::LoginFailed&) {
				LOG_E (("bad ADMIN password, use -pwd option"));
				this->usage ();
			} catch (UsersImport_i::AdminAlreadyLogged&) {
				LOG_E (("user ADMIN already logged, please log off ADMIN before use this application"));
			} catch (GslUserManager::LoginBlocked&) {
				GDS_ASSERT (!"ADMIN is blocked, very strange");
			} catch (GslUserManager::NoMoreConnections&) {
				GDS_ASSERT (!"ADMIN can't be blocked");
			} catch (GslUserManager::LoginDisabled&) {
				GDS_ASSERT (!"LoginDisabled, i don't know what is it");
			} catch (GslUserManager::TrialPeriodExpired&) {
				LOG_E (("trial period expired, sorry"));
			} catch (GslUserManager::ShutdownInited&) {
				LOG_E (("server now is stopped, please restart it"));
			}
		}
		this->fini ();
		//#UC END# *481D6E04016B*	
		ExecutorBase::execute_ ();
		return;
	} CATCH_AND_LOG ("in execute")
	
	this->set_current_status(Core::Root::ES_ERROR);
}

void UsersImportMain::finalize () {
	//#UC START# *481D6E04016B_FINI*
	//#UC END# *481D6E04016B_FINI*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// Останов приложения
void UsersImportMain::fini () const {
	//#UC START# *481F29DE0029*
	GCM::GCMManager_ptr manager = GCM::GCM_get_manager ();
	GDS_ASSERT (manager && "can't get gcm manager");
	manager->stop_components ();
	//#UC END# *481F29DE0029*
}

// вернуть путь к приложению
void UsersImportMain::get_path_to_application (std::string& path) const {
	//#UC START# *4821669F03B3*
#if defined (WIN32)
	char full_path[MAX_PATH];
	full_path[0] = 0;

	char app_path [MAX_PATH];
	DWORD res = GetModuleFileName (NULL, app_path, sizeof (app_path));
	if (!res) {
		return;
	}

	char drive [_MAX_DRIVE];
	char dir [_MAX_DIR];
	_splitpath (app_path, drive, dir, 0, 0);
	if ((strlen (drive) + strlen (dir)) >= MAX_PATH) {
		GDS_ASSERT (!"very long path");
		return;
	}
	_makepath (full_path, drive, dir, 0, 0);
	path = full_path;
#else
	GDS_ASSERT ("not released");
	path = ".";
#endif
	if (path[path.size () - 1] != ACE_DIRECTORY_SEPARATOR_CHAR) {
		path += ACE_DIRECTORY_SEPARATOR_STR;
	}
	//#UC END# *4821669F03B3*
}

// получить полный путь к файлу с данными
void UsersImportMain::get_path_to_datafile (std::string& path) const {
	//#UC START# *482199220094*
	const std::string file_name_option ("-f");

	path = Core::ParamManagerFactory::get ().get_string (file_name_option.c_str ());
	if (path.empty ()) {
		return;
	}
	if (path.find_first_of (ACE_DIRECTORY_SEPARATOR_CHAR) == std::string::npos) {
		// относительный путь, приклеиваем каталог где лежит утилита
		std::string current_path;
		this->get_path_to_application (current_path);
		GDS_ASSERT (!current_path.empty ());
		path = current_path + path;
	}
	//#UC END# *482199220094*
}

// инициализация приложения (GCMManager-а),возвращает созданный объект для записи данных
UsersImport::DataWriter* UsersImportMain::init () const {
	//#UC START# *481EBA160187*
	GCM::GCMManager_ptr manager = GCM::GCM_get_manager ();
	GDS_ASSERT (manager && "can't get gcm manager");
	manager->register_component (new GslUserManager::UserManagerClientHome ());
	manager->register_component (new GCM::GCMSimpleClient (GblPilot::ComponentKey_c));
	manager->register_local_component (new GslSessionHandlerClientServer::SessionHandlerClientServerHome ());

	Core::Var<UsersImport_i::Writer_i> writer (Core::TypeTraits<UsersImport_i::Writer_i>::Factory::make ());
	manager->register_local_component (writer._sretn ());

	try {
		manager->start_components (false);
	} CATCH_LOG_AND_DO ("in init", std::cerr << "can't connect to server\n"; throw;)

	return writer._retn ();
	//#UC END# *481EBA160187*
}

// установка параметров ParamManager
void UsersImportMain::init_environment () const {
	//#UC START# *4821676E03BD*
	std::string path_to_app;
	this->get_path_to_application (path_to_app);
	if (path_to_app.empty ()) {
		LOG_W (("can't find path to application, using '.'"));
		path_to_app = ".";
	}

	if (!Core::ParamManagerFactory::get ().is_exist ("-GCMConfigFile")) {
		// пытаемя использовать инишник по-умолчанию
		std::string path_to_ini (path_to_app);
		path_to_ini += "..";
		path_to_ini += ACE_DIRECTORY_SEPARATOR_STR;
		path_to_ini += "..";
		path_to_ini += ACE_DIRECTORY_SEPARATOR_STR;
		path_to_ini += "garant.ini";
		Core::ParamManagerFactory::get ().add_string ("-GCMConfigFile", path_to_ini.c_str ());
	}
	// лог должен лежать под ногами
	std::string path_to_log (path_to_app);
	path_to_log += "F1UserImport.log";
	Core::ParamManagerFactory::get ().add_string ("-ORBLogFile", path_to_log.c_str ());
	// NotifyService нам не нужен пока
	Core::ParamManagerFactory::get ().add_string ("-GCMNotifyServiceEnable", "0");
	//#UC END# *4821676E03BD*
}

// описание использования утилиты
void UsersImportMain::usage () const {
	//#UC START# *481D6E1A0146*
	LOG_I (("usage: F1UsersImport -GCMConfigFile <path_to_garant_ini> -f <file_name> -pwd <password>"));
	LOG_I (("-f <file_name>: path to file with data. Option is required"));
	LOG_I (("-pwd <password>: password of ADMIN login. Default value is 'ADMIN'"));
	LOG_I (("-GCMConfigFile <path_to_garant_ini>: path to garant.ini file. Default path is './../../garant.ini'"));
	//#UC END# *481D6E1A0146*
}
void UsersImportMain::handle_control (int sig) {
	//#UC START# *481D6E04016B_HANDLE_CONTROl*
	//TODO: write your code for handle Ctrl-C
	//#UC END# *481D6E04016B_HANDLE_CONTROl*
}


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
