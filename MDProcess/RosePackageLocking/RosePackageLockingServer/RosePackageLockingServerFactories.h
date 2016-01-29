////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/RosePackageLocking/RosePackageLockingServer/RosePackageLockingServerFactories.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<ServerInterfaces::Category>> MDProcess::RosePackageLocking::RosePackageLockingServer
//
// ответственности для работы с залочками пакетов
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_ROSEPACKAGELOCKING_ROSEPACKAGELOCKINGSERVER_FCTR_H__
#define __MDPROCESS_ROSEPACKAGELOCKING_ROSEPACKAGELOCKINGSERVER_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include <map>
#include <string>
#include "ace/Singleton.h"
#include "MDProcess/RosePackageLocking/RosePackageLockingServer/RosePackageLockingServer.h"
#include "MDProcess/RosePackageLocking/RosePackageLockingServer/RosePackageLockingServerS.h"

namespace RosePackageLocking {
namespace RosePackageLockingServer {

////////////////////////////////////////////////////////////////////////////////////
// factories definition for Package

class PackageAbstractFactory;

/// factory manager for Package
class PackageFactoryManager: virtual public POA_RosePackageLocking::RosePackageLockingServer::PackageFactoryManagerSrv {
public:
	static void register_factory (PackageAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

	static void publish_self ();

protected:
	PackageFactoryManager ();
	
	~PackageFactoryManager ();
	
	void register_factory_i (PackageAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	Package* instance (PackageGUID_const guid) throw (CORBA::SystemException, CoreSrv::NoActiveFactory);

	friend class PackageFactory;
	typedef ACE_Singleton <PackageFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <PackageFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<PackageAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<PackageAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;

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
	CachedObjectsForInstance m_cached_objects_for_instance;
	CachedObjectsIndexForInstance m_cached_objects_index_for_instance;

	Core::Mutex m_mutex_for_instance;
};

/// abstract factory for Package
class PackageAbstractFactory : virtual public Core::IObject {
	friend class PackageFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual Package* instance (PackageGUID_const guid) = 0;
};


////////////////////////////////////////////////////////////////////////////////////
// factories definition for PackageManager

class PackageManagerAbstractFactory;

/// factory manager for PackageManager
class PackageManagerFactoryManager: virtual public POA_RosePackageLocking::RosePackageLockingServer::PackageManagerFactoryManagerSrv {
public:
	static void register_factory (PackageManagerAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

	static void publish_self ();

protected:
	PackageManagerFactoryManager ();
	
	~PackageManagerFactoryManager ();
	
	void register_factory_i (PackageManagerAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	PackageManager* instance () throw (CORBA::SystemException, CoreSrv::NoActiveFactory);

	friend class PackageManagerFactory;
	typedef ACE_Singleton <PackageManagerFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <PackageManagerFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<PackageManagerAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<PackageManagerAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;

	// for cached factory instance
	PackageManager_var m_cached_object_for_instance;

	Core::Mutex m_mutex_for_instance;
};

/// abstract factory for PackageManager
class PackageManagerAbstractFactory : virtual public Core::IObject {
	friend class PackageManagerFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual PackageManager* instance () = 0;
};

} // namespace RosePackageLockingServer
} // namespace RosePackageLocking


#endif //__MDPROCESS_ROSEPACKAGELOCKING_ROSEPACKAGELOCKINGSERVER_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

