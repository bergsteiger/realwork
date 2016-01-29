////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/Settings/SettingsFactories.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::Settings
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_SETTINGS_FCTR_H__
#define __GARANT6X_GBLADAPTERLIB_SETTINGS_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include <map>
#include <string>
#include "ace/Singleton.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Settings/Settings.h"

namespace GblAdapterLib {

////////////////////////////////////////////////////////////////////////////////////
// factories definition for SettingsManager

class SettingsManagerAbstractFactory;

/// factory manager for SettingsManager
class SettingsManagerFactoryManager {
public:
	static void register_factory (SettingsManagerAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

protected:
	SettingsManagerFactoryManager ();
	
	~SettingsManagerFactoryManager ();
	
	void register_factory_i (SettingsManagerAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	SettingsManager* make () /*throw (Core::Root::NoActiveFactory, NoSession)*/;

	friend class SettingsManagerFactory;
	typedef ACE_Singleton <SettingsManagerFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <SettingsManagerFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<SettingsManagerAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<SettingsManagerAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;
};

/// abstract factory for SettingsManager
class SettingsManagerAbstractFactory : virtual public Core::IObject {
	friend class SettingsManagerFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual SettingsManager* make () /*throw (NoSession)*/ = 0;
};


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
	Configuration* make (
		long id
		, const GCI::IO::String* name
		, const GCI::IO::String* hint
		, bool readonly
	) /*throw (Core::Root::NoActiveFactory)*/;

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
};

/// abstract factory for Configuration
class ConfigurationAbstractFactory : virtual public Core::IObject {
	friend class ConfigurationFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual Configuration* make (long id, const GCI::IO::String* name, const GCI::IO::String* hint, bool readonly) = 0;
};


////////////////////////////////////////////////////////////////////////////////////
// factories definition for DefaultValuesChangesIndicator

class DefaultValuesChangesIndicatorAbstractFactory;

/// factory manager for DefaultValuesChangesIndicator
class DefaultValuesChangesIndicatorFactoryManager {
public:
	static void register_factory (DefaultValuesChangesIndicatorAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

protected:
	DefaultValuesChangesIndicatorFactoryManager ();
	
	~DefaultValuesChangesIndicatorFactoryManager ();
	
	void register_factory_i (DefaultValuesChangesIndicatorAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	DefaultValuesChangesIndicator* make (
		DefaultValuesChangesState state
		, const Configuration* configuration
	) /*throw (Core::Root::NoActiveFactory)*/;

	friend class DefaultValuesChangesIndicatorFactory;
	typedef ACE_Singleton <DefaultValuesChangesIndicatorFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <DefaultValuesChangesIndicatorFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<DefaultValuesChangesIndicatorAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<DefaultValuesChangesIndicatorAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;
};

/// abstract factory for DefaultValuesChangesIndicator
class DefaultValuesChangesIndicatorAbstractFactory : virtual public Core::IObject {
	friend class DefaultValuesChangesIndicatorFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual DefaultValuesChangesIndicator* make (DefaultValuesChangesState state, const Configuration* configuration) = 0;
};


////////////////////////////////////////////////////////////////////////////////////
// factories definition for ConfigurationManager

class ConfigurationManagerAbstractFactory;

/// factory manager for ConfigurationManager
class ConfigurationManagerFactoryManager {
public:
	static void register_factory (ConfigurationManagerAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

protected:
	ConfigurationManagerFactoryManager ();
	
	~ConfigurationManagerFactoryManager ();
	
	void register_factory_i (ConfigurationManagerAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	ConfigurationManager* make () /*throw (Core::Root::NoActiveFactory)*/;

	friend class ConfigurationManagerFactory;
	typedef ACE_Singleton <ConfigurationManagerFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <ConfigurationManagerFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<ConfigurationManagerAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<ConfigurationManagerAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;
};

/// abstract factory for ConfigurationManager
class ConfigurationManagerAbstractFactory : virtual public Core::IObject {
	friend class ConfigurationManagerFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual ConfigurationManager* make () = 0;
};


////////////////////////////////////////////////////////////////////////////////////
// factories definition for PermanentSettingsManager

class PermanentSettingsManagerAbstractFactory;

/// factory manager for PermanentSettingsManager
class PermanentSettingsManagerFactoryManager {
public:
	static void register_factory (PermanentSettingsManagerAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

protected:
	PermanentSettingsManagerFactoryManager ();
	
	~PermanentSettingsManagerFactoryManager ();
	
	void register_factory_i (PermanentSettingsManagerAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	PermanentSettingsManager* make () /*throw (Core::Root::NoActiveFactory)*/;

	friend class PermanentSettingsManagerFactory;
	typedef ACE_Singleton <PermanentSettingsManagerFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <PermanentSettingsManagerFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<PermanentSettingsManagerAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<PermanentSettingsManagerAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;
};

/// abstract factory for PermanentSettingsManager
class PermanentSettingsManagerAbstractFactory : virtual public Core::IObject {
	friend class PermanentSettingsManagerFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual PermanentSettingsManager* make () = 0;
};

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_SETTINGS_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

