////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/Core/os/NTService.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<UtilityPack::Class>> shared::Core::os::NTService
//
// Сервис NT
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CORE_OS_NTSERVICE_H__
#define __SHARED_CORE_OS_NTSERVICE_H__

#include "ace/ACE.h"

//#UC START# *4E9BF2560306_USER_INCLUDES*
#include "ace/OS.h"
#include "ace/NT_Service.h"
#include "ace/Singleton.h"
#include "ace/Synch.h"
#include "tao/orbconf.h"

#include "boost/shared_ptr.hpp"

#include "shared/Core/os/ApplicationServer.h"
//#UC END# *4E9BF2560306_USER_INCLUDES*

namespace Core {

//#UC START# *4E9BF2560306_USER_DEFINITION*

#if defined (_WIN32) || defined (_WIN64)

class NTService : public ACE_NT_Service {
public:
	NTService ();
	virtual ~NTService ();

	virtual void handle_control (DWORD control_code);
	virtual int handle_exception (ACE_HANDLE h);
	virtual int svc ();
	int init (int argc, char* argv[]);
	void set_application_server (boost::shared_ptr<ApplicationServer> app_server);

	void set_subkey_name (const std::string& subkey_name);
	void set_value_name (const std::string& value_name);

private:
	int m_argc;
	int m_argc_save;

	char** m_argv;
	char** m_argv_save; 

	std::string m_registry_subkey;
	std::string m_registry_value;

	boost::shared_ptr<ApplicationServer> m_app_server;

	friend class ACE_Unmanaged_Singleton<NTService, ACE_Null_Mutex>;
};

typedef ACE_Unmanaged_Singleton<NTService, ACE_Null_Mutex> SERVICE;

#endif
//#UC END# *4E9BF2560306_USER_DEFINITION*

} // namespace Core


#endif //__SHARED_CORE_OS_NTSERVICE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
