
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/RosePackageLocking/RosePackageLockingServer/RosePackageLockingServer.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<ServerInterfaces::Category>> MDProcess::RosePackageLocking::RosePackageLockingServer
//
// ответственности для работы с залочками пакетов
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_ROSEPACKAGELOCKING_ROSEPACKAGELOCKINGSERVER_H__
#define __MDPROCESS_ROSEPACKAGELOCKING_ROSEPACKAGELOCKINGSERVER_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/RosePackageLocking/RosePackageLockingServer/RosePackageLockingServerC.h"
#include <vector>

namespace RosePackageLocking {
namespace RosePackageLockingServer {

typedef const char* PackageGUID_const;

/// factory interface for Package
class PackageFactory {
public:
	// получить кэшированный экземпляр объекта
	static Package& instance (PackageGUID_const guid)
		/*throw (CoreSrv::NoActiveFactory)*/;
private:
	typedef ACE_Singleton<PackageFactoryManagerSrv_var, ACE_SYNCH_RECURSIVE_MUTEX> FactoryManagerSrvSingleton;
	static Core::Mutex s_init_mutex;
	static bool s_renew_mode;

	// for cached factory instance
	struct ObjectCreationIdForInstance {
		std::string guid_arg;

		ObjectCreationIdForInstance (PackageGUID_const guid) : guid_arg (guid) {
		}

		bool operator < (const ObjectCreationIdForInstance& c) const {
			return guid_arg < c.guid_arg;
		}
	};

	typedef std::map<ObjectCreationIdForInstance, Package_var> CachedObjectsForInstance;
	typedef std::map<CORBA::ULong, CachedObjectsForInstance::iterator> CachedObjectsIndexForInstance;
	typedef ACE_Singleton <CachedObjectsForInstance, ACE_SYNCH_RECURSIVE_MUTEX> CachedObjectsForInstanceSngl;
	typedef ACE_Singleton <CachedObjectsIndexForInstance, ACE_SYNCH_RECURSIVE_MUTEX> CachedObjectsIndexForInstanceSngl;

	static Core::Mutex s_mutex_for_instance;
};

/// factory interface for PackageManager
class PackageManagerFactory {
public:
	// получить кэшированый экземпляр
	static PackageManager& instance ()
		/*throw (CoreSrv::NoActiveFactory)*/;
private:
	typedef ACE_Singleton<PackageManagerFactoryManagerSrv_var, ACE_SYNCH_RECURSIVE_MUTEX> FactoryManagerSrvSingleton;
	static Core::Mutex s_init_mutex;
	static bool s_renew_mode;

	// for cached factory instance
	typedef ACE_Singleton <PackageManager_var, ACE_SYNCH_RECURSIVE_MUTEX> CachedObjectForInstance;
	static CORBA::ULong s_cached_object_hash_for_instance;

	static Core::Mutex s_mutex_for_instance;
};

} // namespace RosePackageLockingServer
} // namespace RosePackageLocking


#endif //__MDPROCESS_ROSEPACKAGELOCKING_ROSEPACKAGELOCKINGSERVER_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

