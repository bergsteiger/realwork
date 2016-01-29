
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/CoreSrv/SecuritySrv/SecuritySrv.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<ServerInterfaces::Category>> shared::CoreSrv::SecuritySrv
//
// сервисные распределенные интерфейсы подсистемы Безопасности
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CORESRV_SECURITYSRV_H__
#define __SHARED_CORESRV_SECURITYSRV_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/CoreSrv/SecuritySrv/SecuritySrvC.h"
#include "shared/CoreSrv/SecuritySrvComm/SecuritySrvComm.h"

namespace CoreSrv {
namespace SecuritySrv {

/// factory interface for SessionManager
class SessionManagerFactory {
public:
	// возвращает системного менеджера сессий
	static SessionManager& get ()
		/*throw (CoreSrv::NoActiveFactory)*/;
private:
	typedef ACE_Singleton<SessionManagerFactoryManagerSrv_var, ACE_SYNCH_RECURSIVE_MUTEX> FactoryManagerSrvSingleton;
	static Core::Mutex s_init_mutex;
	static bool s_renew_mode;

	// for cached factory get
	typedef ACE_Singleton <SessionManager_var, ACE_SYNCH_RECURSIVE_MUTEX> CachedObjectForGet;
	static CORBA::ULong s_cached_object_hash_for_get;

	static Core::Mutex s_mutex_for_get;
};

} // namespace SecuritySrv
} // namespace CoreSrv


#endif //__SHARED_CORESRV_SECURITYSRV_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

