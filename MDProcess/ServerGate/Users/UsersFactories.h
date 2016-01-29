////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/ServerGate/Users/UsersFactories.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<ServerInterfaces::Category>> MDProcess::ServerGate::Users
//
// все ответсвенности связанные с авторизованным доступом
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_SERVERGATE_USERS_FCTR_H__
#define __MDPROCESS_SERVERGATE_USERS_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include <map>
#include <string>
#include "ace/Singleton.h"
#include "MDProcess/ServerGate/Users/Users.h"
#include "MDProcess/ServerGate/Users/UsersS.h"

namespace ServerGate {
namespace Users {

////////////////////////////////////////////////////////////////////////////////////
// factories definition for Accessor

class AccessorAbstractFactory;

/// factory manager for Accessor
class AccessorFactoryManager: virtual public POA_ServerGate::Users::AccessorFactoryManagerSrv {
public:
	static void register_factory (AccessorAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

	static void publish_self ();

protected:
	AccessorFactoryManager ();
	
	~AccessorFactoryManager ();
	
	void register_factory_i (AccessorAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	Accessor* make () throw (CORBA::SystemException, CoreSrv::NoActiveFactory);

	friend class AccessorFactory;
	typedef ACE_Singleton <AccessorFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <AccessorFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<AccessorAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<AccessorAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;
};

/// abstract factory for Accessor
class AccessorAbstractFactory : virtual public Core::IObject {
	friend class AccessorFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual Accessor* make () = 0;
};


////////////////////////////////////////////////////////////////////////////////////
// factories definition for User

class UserAbstractFactory;

/// factory manager for User
class UserFactoryManager: virtual public POA_ServerGate::Users::UserFactoryManagerSrv {
public:
	static void register_factory (UserAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

	static void publish_self ();

protected:
	UserFactoryManager ();
	
	~UserFactoryManager ();
	
	void register_factory_i (UserAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	User* make (CoreSrv::UserID uid) throw (CORBA::SystemException, CoreSrv::NoActiveFactory);

	friend class UserFactory;
	typedef ACE_Singleton <UserFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <UserFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<UserAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<UserAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;

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
	CachedObjectsForMake m_cached_objects_for_make;
	CachedObjectsIndexForMake m_cached_objects_index_for_make;

	Core::Mutex m_mutex_for_make;
};

/// abstract factory for User
class UserAbstractFactory : virtual public Core::IObject {
	friend class UserFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual User* make (CoreSrv::UserID uid) = 0;
};

} // namespace Users
} // namespace ServerGate


#endif //__MDPROCESS_SERVERGATE_USERS_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

