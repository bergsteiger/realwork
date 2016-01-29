////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/Core/Root/RootFactories.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Interfaces::Category>> shared::Core::Root
//
// Пакет интерфейсов фремворка GCM2 (не сетевая часть)
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CORE_ROOT_FCTR_H__
#define __SHARED_CORE_ROOT_FCTR_H__

#include "shared/Core/sys/core_std_inc.h"
#include "shared/Core/Root/Root.h"
#include "shared/Core/mt/mt.h"
#include <map>
#include <string>
#include "ace/Singleton.h"
#include "shared/Core/Root/Root.h"

namespace Core {
namespace Root {

////////////////////////////////////////////////////////////////////////////////////
// factories definition for Configuration

class ConfigurationAbstractFactory;

/// factory manager for Configuration
class ConfigurationFactoryManager {
public:
	static void register_factory (ConfigurationAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

protected:
	ConfigurationFactoryManager ();
	
	~ConfigurationFactoryManager ();
	
	void register_factory_i (ConfigurationAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const Configuration& get () /*throw (Core::Root::NoActiveFactory)*/;

	friend class ConfigurationFactory;
	typedef ACE_Singleton <ConfigurationFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <ConfigurationFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<ConfigurationAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<ConfigurationAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;

	// for cached factory get
	Configuration_var m_cached_object_for_get;

	Core::Mutex m_mutex_for_get;
};

/// abstract factory for Configuration
class ConfigurationAbstractFactory : virtual public Core::IObject {
	friend class ConfigurationFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual Configuration* get () = 0;
};


////////////////////////////////////////////////////////////////////////////////////
// factories definition for LibHomeManager

class LibHomeManagerAbstractFactory;

/// factory manager for LibHomeManager
class LibHomeManagerFactoryManager {
public:
	static void register_factory (LibHomeManagerAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

protected:
	LibHomeManagerFactoryManager ();
	
	~LibHomeManagerFactoryManager ();
	
	void register_factory_i (LibHomeManagerAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	LibHomeManager& get () /*throw (Core::Root::NoActiveFactory)*/;

	friend class LibHomeManagerFactory;
	typedef ACE_Singleton <LibHomeManagerFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <LibHomeManagerFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<LibHomeManagerAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<LibHomeManagerAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;

	// for cached factory get
	LibHomeManager_var m_cached_object_for_get;

	Core::Mutex m_mutex_for_get;
};

/// abstract factory for LibHomeManager
class LibHomeManagerAbstractFactory : virtual public Core::IObject {
	friend class LibHomeManagerFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual LibHomeManager* get () = 0;
};

} // namespace Root
} // namespace Core


#endif //__SHARED_CORE_ROOT_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

