////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/Security/SecurityFactories.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::Security
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_SECURITY_FCTR_H__
#define __GARANT6X_GBLADAPTERLIB_SECURITY_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include <map>
#include <string>
#include "ace/Singleton.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Security/Security.h"
#include "garant6x/implementation/Garant/GblAdapterLib/BaseTypes/BaseTypesFactories.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DynamicTree/DynamicTreeFactories.h"

namespace GblAdapterLib {

////////////////////////////////////////////////////////////////////////////////////
// factories definition for UserProfile

class UserProfileAbstractFactory;

/// factory manager for UserProfile
class UserProfileFactoryManager {
public:
	static void register_factory (UserProfileAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

protected:
	UserProfileFactoryManager ();
	
	~UserProfileFactoryManager ();
	
	void register_factory_i (UserProfileAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	UserProfile* make (
		Uid uid
		, const char* login
		, const char* name
		, const char* mail
		, bool is_system
		, bool has_password
		, bool can_buy_consulting
		, bool is_permanent
	) /*throw (Core::Root::NoActiveFactory)*/;

	UserProfile* make () /*throw (Core::Root::NoActiveFactory)*/;

	friend class UserProfileFactory;
	typedef ACE_Singleton <UserProfileFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <UserProfileFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<UserProfileAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<UserProfileAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;
};

/// abstract factory for UserProfile
class UserProfileAbstractFactory : virtual public Core::IObject {
	friend class UserProfileFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual UserProfile* make (
		Uid uid
		, const char* login
		, const char* name
		, const char* mail
		, bool is_system
		, bool has_password
		, bool can_buy_consulting
		, bool is_permanent
	) = 0;

	virtual UserProfile* make () = 0;
};


////////////////////////////////////////////////////////////////////////////////////
// factories definition for UserFilter

class UserFilterAbstractFactory;

/// factory manager for UserFilter
class UserFilterFactoryManager {
public:
	static void register_factory (UserFilterAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

protected:
	UserFilterFactoryManager ();
	
	~UserFilterFactoryManager ();
	
	void register_factory_i (UserFilterAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	UserFilter* make () /*throw (Core::Root::NoActiveFactory)*/;

	friend class UserFilterFactory;
	typedef ACE_Singleton <UserFilterFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <UserFilterFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<UserFilterAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<UserFilterAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;
};

/// abstract factory for UserFilter
class UserFilterAbstractFactory : virtual public Core::IObject {
	friend class UserFilterFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual UserFilter* make () = 0;
};


////////////////////////////////////////////////////////////////////////////////////
// factories definition for ProfileNode

class ProfileNodeAbstractFactory;

/// factory manager for ProfileNode
class ProfileNodeFactoryManager {
public:
	static void register_factory (ProfileNodeAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

protected:
	ProfileNodeFactoryManager ();
	
	~ProfileNodeFactoryManager ();
	
	void register_factory_i (ProfileNodeAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	ProfileNode* make () /*throw (Core::Root::NoActiveFactory)*/;

	friend class ProfileNodeFactory;
	typedef ACE_Singleton <ProfileNodeFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <ProfileNodeFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<ProfileNodeAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<ProfileNodeAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;
};

/// abstract factory for ProfileNode
class ProfileNodeAbstractFactory : virtual public Core::IObject {
	friend class ProfileNodeFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual ProfileNode* make () = 0;
};


////////////////////////////////////////////////////////////////////////////////////
// factories definition for UserManager

class UserManagerAbstractFactory;

/// factory manager for UserManager
class UserManagerFactoryManager {
public:
	static void register_factory (UserManagerAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

protected:
	UserManagerFactoryManager ();
	
	~UserManagerFactoryManager ();
	
	void register_factory_i (UserManagerAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	UserManager* make () /*throw (Core::Root::NoActiveFactory)*/;

	friend class UserManagerFactory;
	typedef ACE_Singleton <UserManagerFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <UserManagerFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<UserManagerAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<UserManagerAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;
};

/// abstract factory for UserManager
class UserManagerAbstractFactory : virtual public Core::IObject {
	friend class UserManagerFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual UserManager* make () = 0;
};


////////////////////////////////////////////////////////////////////////////////////
// factories definition for GroupNode

class GroupNodeAbstractFactory;

/// factory manager for GroupNode
class GroupNodeFactoryManager {
public:
	static void register_factory (GroupNodeAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

protected:
	GroupNodeFactoryManager ();
	
	~GroupNodeFactoryManager ();
	
	void register_factory_i (GroupNodeAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	GroupNode* make () /*throw (Core::Root::NoActiveFactory)*/;

	friend class GroupNodeFactory;
	typedef ACE_Singleton <GroupNodeFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <GroupNodeFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<GroupNodeAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<GroupNodeAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;
};

/// abstract factory for GroupNode
class GroupNodeAbstractFactory : virtual public Core::IObject {
	friend class GroupNodeFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual GroupNode* make () = 0;
};

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_SECURITY_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

