////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/Core/os/Process.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<UtilityPack::Class>> shared::Core::os::Process
//
// Просцесс управления сервисом NT
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CORE_OS_PROCESS_H__
#define __SHARED_CORE_OS_PROCESS_H__

#include "ace/ACE.h"

//#UC START# *4E9BF1F8005A_USER_INCLUDES*
#include <string>
#include "boost/shared_ptr.hpp"
#include "shared/Core/os/ApplicationServer.h"
//#UC END# *4E9BF1F8005A_USER_INCLUDES*

namespace Core {

//#UC START# *4E9BF1F8005A_USER_DEFINITION*
class ApplicationServer;

enum RunMode {
	RM_RUN_AS_SERVICE
	, RM_INSTALL
	, RM_REMOVE
	, RM_START
	, RM_STOP
	, RM_SET_SERVICE_STARTUP_TYPE
	, RM_DEBUG
};

class Process {
public:
	Process (int argc, char* argv []);
	int run ();

private:
	void parse_args ();
	void print_usage_and_exit ();
	void check_and_set_service_startup_type (int type);
	
	virtual boost::shared_ptr<ApplicationServer> make_application_server () const = 0;
	
	virtual std::string get_registry_subkey () const = 0;
	virtual std::string get_registry_value () const = 0;
	virtual std::string get_service_name () const = 0;
	virtual std::string get_service_description () const = 0;

	std::string m_registry_subkey;    
	std::string m_registry_value;     
	std::string m_service_name;       
	std::string m_service_description;
	
	int    m_argc;
	char** m_argv;
	
	RunMode m_run_mode;
	int m_service_startup_type;
};

//#UC END# *4E9BF1F8005A_USER_DEFINITION*

} // namespace Core


#endif //__SHARED_CORE_OS_PROCESS_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
