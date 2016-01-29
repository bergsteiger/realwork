////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/Core/os/Process.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<UtilityPack::Class>> shared::Core::os::Process
// Файл реализации утилитного набора Process
//
// Просцесс управления сервисом NT
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "ace/ACE.h"
#include "shared/Core/os/Process.h"

//#UC START# *4E9BF1F8005A_CUSTOM_INCLUDES*
#include "shared/Core/Params/Params.h"
#include "shared/Core/ParamsHelper/ParamConvert.h"
#include "shared/Core/os/NTService.h"
//#UC END# *4E9BF1F8005A_CUSTOM_INCLUDES*

namespace Core {

//#UC START# *4E9BF1F8005A*

#if defined (_WIN32) || defined (_WIN64)

// SERVICE_BOOT_START   0x00000000 // This value is valid only for driver services.
// SERVICE_SYSTEM_START	0x00000001 // This value is valid only for driver services.
// SERVICE_AUTO_START   0x00000002
// SERVICE_DEMAND_START 0x00000003
// SERVICE_DISABLED     0x00000004


const std::string INSTALL_KEY                  = "-i";
const std::string REMOVE_KEY                   = "-r";
const std::string START_KEY                    = "-s";
const std::string STOP_KEY                     = "-k";
const std::string SET_SERVICE_STARTUP_TYPE_KEY = "-t";
const std::string DEBUG_KEY                    = "-d";
const std::string REGISTRY_SUBKEY              = "-subkey";
const std::string REGISTRY_VALUE               = "-opt";
const std::string SERVICE_NAME_KEY             = "-Sn";
const std::string SERVICE_DESC_KEY             = "-Sd";
const std::string PRINTHELP_KEY                = "-h";


Process::Process (int argc, char* argv [])
	: m_argc (argc)
	, m_argv (argv)
	, m_run_mode (RM_RUN_AS_SERVICE)
	, m_service_startup_type (SERVICE_DEMAND_START) {
}


void Process::print_usage_and_exit () {
	ACE_DEBUG ((LM_INFO,
		"Usage: %s [options]\n"
		"Options:\n"
		"  -i<N>                 Install this program as an NT service, with specified startup N\n"
		"  -r                    Remove this program from the Service Control Manager database\n"
		"  -s                    Start the service\n"
		"  -k                    Stop the service\n"
		"  -t<N>                 Set startup type N for an existing service\n"
		"  -d                    Debug mode\n"
		"  -subkey               default is '%s'\n"
		"  -opt                  default is '%s'\n"
		"  -Sn <name>            Service name, default is '%s'\n"
		"  -Sd <description>     Service description, default is '%s'\n"
		"  -h                    This help\n"
		, m_argv [0]
		, m_registry_subkey.c_str ()
		, m_registry_value.c_str ()
		, m_service_name.c_str ()
		, m_service_description.c_str ()
		, 0
	));

	ACE_OS::exit (0);
}

void Process::parse_args () {
	const char* pos = 0;
	for (int i = 1; i < m_argc; ++i) {
		if (m_argv [i] == REGISTRY_SUBKEY) { 
			if (++i < m_argc) {
				m_registry_subkey = m_argv [i];
			}
		} else if (m_argv [i] == REGISTRY_VALUE) {
			if (++i < m_argc) {
				m_registry_value = m_argv [i];
			}
		} else if (m_argv [i] == SERVICE_NAME_KEY) {
			if (++i < m_argc) {
				m_service_name = m_argv [i];
			}
		} else if (m_argv [i] == SERVICE_DESC_KEY) {
			if (++i < m_argc) {
				m_service_description = m_argv [i];
			}
		} else if (m_argv [i] == REMOVE_KEY) {
			m_run_mode = RM_REMOVE;
		} else if (m_argv [i] == START_KEY) {
			m_run_mode = RM_START;
		} else if (m_argv [i] == STOP_KEY) {
			m_run_mode = RM_STOP;
		} else if (m_argv [i] == DEBUG_KEY) {
			m_run_mode = RM_DEBUG;
		} else if (m_argv [i] == PRINTHELP_KEY) {
			this->print_usage_and_exit ();
		} else if ((pos = ACE_OS_String::strstr (m_argv [i], INSTALL_KEY.c_str ())) != 0) {
			m_run_mode = RM_INSTALL;
			this->check_and_set_service_startup_type (ACE_OS::atoi (pos + 2));
		} else if ((pos = ACE_OS_String::strstr (m_argv [i], SET_SERVICE_STARTUP_TYPE_KEY.c_str ())) != 0) {
			m_run_mode = RM_SET_SERVICE_STARTUP_TYPE;
			this->check_and_set_service_startup_type (ACE_OS::atoi (pos + 2));
		}
	}
}


void Process::check_and_set_service_startup_type (int type) {
	
	if (SERVICE_SYSTEM_START < type && type < SERVICE_DISABLED) {
		m_service_startup_type = type;
		return;
	}

	ACE_DEBUG ((LM_INFO, "wrong the startup type: %d\n", m_service_startup_type));
	this->print_usage_and_exit ();
}


static BOOL WINAPI console_handler (DWORD ctrl_type) {                 // Ctrl+C handler to cleanly shutdown
	ACE_UNUSED_ARG (ctrl_type);
	SERVICE::instance ()->handle_control (SERVICE_CONTROL_STOP);
	return true;
}

ACE_NT_SERVICE_DEFINE (YetAnotherGarantServer, Core::NTService, ("Some Service"));

int Process::run () {

	m_registry_subkey     = this->get_registry_subkey ();
	m_registry_value      = this->get_registry_value ();
	m_service_name        = this->get_service_name ();
	m_service_description = this->get_service_description ();
	
	this->parse_args ();
	
	SERVICE::instance ()->set_application_server (this->make_application_server ());
	
	SERVICE::instance ()->name (m_service_name.c_str (), m_service_description.c_str ());
	SERVICE::instance ()->set_subkey_name (m_registry_subkey.c_str ());
	SERVICE::instance ()->set_value_name (m_registry_value.c_str ());

	switch (m_run_mode) {
		case RM_INSTALL                  : return SERVICE::instance ()->insert (m_service_startup_type);
		case RM_REMOVE                   : return SERVICE::instance ()->remove ();
		case RM_START                    : return SERVICE::instance ()->start_svc ();
		case RM_STOP	                   : return SERVICE::instance ()->stop_svc ();
		case RM_SET_SERVICE_STARTUP_TYPE : return SERVICE::instance ()->startup (m_service_startup_type);
		
		case RM_DEBUG: {
			SetConsoleCtrlHandler (&console_handler, static_cast<BOOL> (true));
			SERVICE::instance()->init (m_argc, m_argv);
			SERVICE::instance()->svc ();
			return 0;
		}
		
		case RM_RUN_AS_SERVICE: {
			ACE_NT_SERVICE_RUN (YetAnotherGarantServer, SERVICE::instance (), ret);
			return 0;
		}
		
		default : GDS_ASSERT (false); return 0;
	};
}

#endif

//#UC END# *4E9BF1F8005A*

} // namespace Core

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

