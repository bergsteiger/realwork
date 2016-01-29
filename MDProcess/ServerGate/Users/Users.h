
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/ServerGate/Users/Users.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<ServerInterfaces::Category>> MDProcess::ServerGate::Users
//
// все ответсвенности связанные с авторизованным доступом
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_SERVERGATE_USERS_H__
#define __MDPROCESS_SERVERGATE_USERS_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/ServerGate/Users/UsersC.h"
#include "shared/CoreSrv/SecuritySrvComm/SecuritySrvComm.h"

namespace ServerGate {
namespace Users {

/// factory interface for Accessor
class AccessorFactory {
public:
	// получить экземпляр
	static Accessor* make ()
		/*throw (CoreSrv::NoActiveFactory)*/;
private:
	typedef ACE_Singleton<AccessorFactoryManagerSrv_var, ACE_SYNCH_RECURSIVE_MUTEX> FactoryManagerSrvSingleton;
	static Core::Mutex s_init_mutex;
	static bool s_renew_mode;
};

/// factory interface for User
class UserFactory {
public:
	// получить экземпляр по юзер-айди
	static User& make (CoreSrv::UserID uid)
		/*throw (CoreSrv::NoActiveFactory)*/;
private:
	typedef ACE_Singleton<UserFactoryManagerSrv_var, ACE_SYNCH_RECURSIVE_MUTEX> FactoryManagerSrvSingleton;
	static Core::Mutex s_init_mutex;
	static bool s_renew_mode;

	// for cached factory make
	struct ObjectCreationIdForMake {
		CoreSrv::UserID uid_arg;

		ObjectCreationIdForMake (CoreSrv::UserID uid) : uid_arg (uid) {
		}

		bool operator < (const ObjectCreationIdForMake& c) const {
			return uid_arg < c.uid_arg;
		}
	};

	typedef std::map<ObjectCreationIdForMake, User_var> CachedObjectsForMake;
	typedef std::map<CORBA::ULong, CachedObjectsForMake::iterator> CachedObjectsIndexForMake;
	typedef ACE_Singleton <CachedObjectsForMake, ACE_SYNCH_RECURSIVE_MUTEX> CachedObjectsForMakeSngl;
	typedef ACE_Singleton <CachedObjectsIndexForMake, ACE_SYNCH_RECURSIVE_MUTEX> CachedObjectsIndexForMakeSngl;

	static Core::Mutex s_mutex_for_make;
};

} // namespace Users
} // namespace ServerGate


#endif //__MDPROCESS_SERVERGATE_USERS_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

