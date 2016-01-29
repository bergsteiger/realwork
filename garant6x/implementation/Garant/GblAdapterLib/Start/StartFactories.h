////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/Start/StartFactories.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::Start
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_START_FCTR_H__
#define __GARANT6X_GBLADAPTERLIB_START_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include <map>
#include <string>
#include "ace/Singleton.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Start/Start.h"

namespace GblAdapterLib {

////////////////////////////////////////////////////////////////////////////////////
// factories definition for Authorization

class AuthorizationAbstractFactory;

/// factory manager for Authorization
class AuthorizationFactoryManager {
public:
	static void register_factory (AuthorizationAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

protected:
	AuthorizationFactoryManager ();
	
	~AuthorizationFactoryManager ();
	
	void register_factory_i (AuthorizationAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	Authorization* make () /*throw (Core::Root::NoActiveFactory, XMLImportRunning)*/;

	friend class AuthorizationFactory;
	typedef ACE_Singleton <AuthorizationFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <AuthorizationFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<AuthorizationAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<AuthorizationAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;
};

/// abstract factory for Authorization
class AuthorizationAbstractFactory : virtual public Core::IObject {
	friend class AuthorizationFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual Authorization* make () /*throw (XMLImportRunning)*/ = 0;
};


////////////////////////////////////////////////////////////////////////////////////
// factories definition for Common

class CommonAbstractFactory;

/// factory manager for Common
class CommonFactoryManager {
public:
	static void register_factory (CommonAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

protected:
	CommonFactoryManager ();
	
	~CommonFactoryManager ();
	
	void register_factory_i (CommonAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	Common* make () /*throw (Core::Root::NoActiveFactory)*/;

	friend class CommonFactory;
	typedef ACE_Singleton <CommonFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <CommonFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<CommonAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<CommonAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;
};

/// abstract factory for Common
class CommonAbstractFactory : virtual public Core::IObject {
	friend class CommonFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual Common* make () = 0;
};


////////////////////////////////////////////////////////////////////////////////////
// factories definition for ComponentManager

class ComponentManagerAbstractFactory;

/// factory manager for ComponentManager
class ComponentManagerFactoryManager {
public:
	static void register_factory (ComponentManagerAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

protected:
	ComponentManagerFactoryManager ();
	
	~ComponentManagerFactoryManager ();
	
	void register_factory_i (ComponentManagerAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	ComponentManager& make () /*throw (Core::Root::NoActiveFactory)*/;

	friend class ComponentManagerFactory;
	typedef ACE_Singleton <ComponentManagerFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <ComponentManagerFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<ComponentManagerAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<ComponentManagerAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;

	// for cached factory make
	ComponentManager_var m_cached_object_for_make;

	Core::Mutex m_mutex_for_make;
};

/// abstract factory for ComponentManager
class ComponentManagerAbstractFactory : virtual public Core::IObject {
	friend class ComponentManagerFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual ComponentManager* make () = 0;
};


////////////////////////////////////////////////////////////////////////////////////
// factories definition for AssemblyInfo

class AssemblyInfoAbstractFactory;

/// factory manager for AssemblyInfo
class AssemblyInfoFactoryManager {
public:
	static void register_factory (AssemblyInfoAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

protected:
	AssemblyInfoFactoryManager ();
	
	~AssemblyInfoFactoryManager ();
	
	void register_factory_i (AssemblyInfoAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	AssemblyInfo* make () /*throw (Core::Root::NoActiveFactory)*/;

	friend class AssemblyInfoFactory;
	typedef ACE_Singleton <AssemblyInfoFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <AssemblyInfoFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<AssemblyInfoAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<AssemblyInfoAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;
};

/// abstract factory for AssemblyInfo
class AssemblyInfoAbstractFactory : virtual public Core::IObject {
	friend class AssemblyInfoFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual AssemblyInfo* make () = 0;
};

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_START_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

