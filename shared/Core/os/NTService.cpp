////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/Core/os/NTService.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<UtilityPack::Class>> shared::Core::os::NTService
// Файл реализации утилитного набора NTService
//
// Сервис NT
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "ace/ACE.h"
#include "shared/Core/os/NTService.h"

//#UC START# *4E9BF2560306_CUSTOM_INCLUDES*
#include "shared/Core/sys/start_stop.h"
#include "shared/Core/sys/AutoInit.h"
#include "ace/ARGV.h"
//#UC END# *4E9BF2560306_CUSTOM_INCLUDES*

namespace Core {

//#UC START# *4E9BF2560306*

#if defined (_WIN32) || defined (_WIN64)	

#define REGISTRY_KEY_ROOT HKEY_LOCAL_MACHINE
NTService::NTService ()
	: m_argc (0)
	, m_argc_save (0)
	, m_argv (0)
	, m_argv_save (0) {
	svc_status_.dwControlsAccepted |= SERVICE_ACCEPT_SHUTDOWN;	// http://mdp.garant.ru/x/VyoVC
}

NTService::~NTService () {
	if (m_argv_save) {
		for (int i = 0; i < m_argc_save; i++) {
			ACE_OS::free (m_argv_save[i]);
		}
		ACE_OS::free (m_argv_save);
	}
}


ACE_THR_FUNC_RETURN application_server_shutdown (void* app_server) {
	reinterpret_cast<Core::ApplicationServer*>(app_server)->shutdown ();
	return 0;
}

void NTService::handle_control (DWORD control_code)
{
	LOG_D (("%s - start", GDS_CURRENT_FUNCTION));
	if (control_code == SERVICE_CONTROL_SHUTDOWN ||
		control_code == SERVICE_CONTROL_STOP) {
		report_status(SERVICE_STOP_PENDING, 40000);
		// мы не можем здесь брать поток из пула, т.к. существует небольшая вероятность что ожидать свободный поток
		// мы будем больше 40 секунд а значит не сможем послать сообщение юзерам об отключении потому-что винда срубит
		// сервис через 40 секунд.
		ACE_Thread_Manager::instance ()->spawn (application_server_shutdown, m_app_server.get ());
	} else {
		ACE_NT_Service::handle_control(control_code);
	}
	LOG_D (("%s - finish", GDS_CURRENT_FUNCTION));
}

int NTService::handle_exception (ACE_HANDLE h)
{
	ACE_UNUSED_ARG (h);
	return 0;
}

void NTService::set_application_server (boost::shared_ptr<ApplicationServer> app_server) {
	m_app_server = app_server;
}

int NTService::init (int argc, char* argv[]) {
	HKEY hkey = 0;
	BYTE buf [ACE_DEFAULT_ARGV_BUFSIZ];
	buf [0] = '\0';

	ACE_TEXT_RegOpenKeyEx (REGISTRY_KEY_ROOT, m_registry_subkey.c_str (), 0, KEY_READ, &hkey);

	DWORD type;
	DWORD bufSize = sizeof (buf);

	ACE_TEXT_RegQueryValueEx (hkey, m_registry_value.c_str (), 0, &type, buf, &bufSize);

	RegCloseKey (hkey);

	// Add options to the args list (if any).
	if (ACE_OS::strlen (reinterpret_cast <const char*> (buf)) > 0) {
		ACE_ARGV args (reinterpret_cast <const char*> (buf));

		// Allocate the internal args list to be one bigger than the
		// args list passed into the function. We use a 'save' list in
		// case we use a 'destructive' args list processor - this way we
		// maintain the correct argv and argc for memory freeing
		// operations in the destructor.
		m_argv_save = (char**)ACE_OS::malloc ((argc + args.argc ()) * sizeof (char*));

		// Copy the values into the internal args buffer.
		int i;
		for (int i = 0; i < argc; i++) {
			m_argv_save[i] = ACE_OS::strdup (argv[i]);
		}

		int j = 0;
		for (i = argc; i < static_cast<int> (args.argc () + argc); ++i) {
			m_argv_save [i] = ACE_OS::strdup (args.argv ()[j++]);
		}

		// Set the arg counter.
		m_argc_save = argc + args.argc ();
		m_argc = m_argc_save;
		m_argv = m_argv_save;
	}
	else {
		m_argc = argc;
		m_argv = argv;
	}

	return 0;
}

int NTService::svc () {
	
	if (!m_app_server.get ()) {
		LOG_A (("%s: Application Server is not specified.", GDS_CURRENT_FUNCTION));
		return -1;
	}
	
	
	Core::AutoInit core; // http://mdp.garant.ru/x/WoDzAg
	
	if (m_app_server->init (m_argc, m_argv) == -1) {
		return -1;
	}

	try {
		this->report_status (SERVICE_RUNNING);
		return m_app_server->run ();
	} catch (...) {
		return -1;
	}
}

void NTService::set_subkey_name (const std::string& subkey_name) {
	m_registry_subkey = subkey_name;
}

void NTService::set_value_name (const std::string& value_name) {
	m_registry_value = value_name;
}

#endif

//#UC END# *4E9BF2560306*

} // namespace Core

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

