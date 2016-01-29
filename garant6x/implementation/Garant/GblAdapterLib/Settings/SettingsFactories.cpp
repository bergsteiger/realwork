////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/Settings/SettingsFactories.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::Settings
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Settings/SettingsFactories.h"

namespace GblAdapterLib {


//////////////////////////////////////////////////////////////////////////////////////
// implementation of factory manager methods for SettingsManager
bool SettingsManagerFactoryManager::s_was_destroyed = false;

SettingsManagerFactoryManager::SettingsManagerFactoryManager () /*throw (Core::Root::FactoryManagerWasDestroyed)*/
	: m_has_registred_factories(false)
{
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
}

SettingsManagerFactoryManager::~SettingsManagerFactoryManager () {
	s_was_destroyed = true;
}

void SettingsManagerFactoryManager::register_factory (
	SettingsManagerAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
	Singleton::instance()->register_factory_i (factory, priority);
}

void SettingsManagerFactoryManager::register_factory_i (
	SettingsManagerAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey)*/ {
	m_has_registred_factories = true;
	FactoryMap::iterator f = m_factories_map.find(factory->key());
	if (f != m_factories_map.end() && f->second.priority == priority) {
		throw Core::Root::DuplicatedFactoryKey (
			"GblAdapterLib::Settings::SettingsManagerFactory"
			, factory->key()
		);
	}
	if (f == m_factories_map.end() || f->second.priority <= priority) {
		m_factories_map[factory->key()].factory = SettingsManagerAbstractFactory::_duplicate(factory);
		m_factories_map[factory->key()].priority = priority;
	}
	
	if (!m_single_active_factory || m_single_active_factory_priority <= priority) {
		m_single_active_factory = SettingsManagerAbstractFactory::_duplicate(factory);
		m_single_active_factory_priority = priority;
	}
}

SettingsManager* SettingsManagerFactoryManager::make () /*throw (Core::Root::NoActiveFactory, NoSession)*/ {
	if (m_single_active_factory.is_nil()) {
		throw Core::Root::NoActiveFactory ("GblAdapterLib::Settings::SettingsManagerFactory");
	}
	SettingsManager* ret_ = m_single_active_factory->make ();
	GDS_ASSERT_MSG (ret_ != 0, ("GblAdapterLib::Settings::SettingsManagerFactory impl can't return zerro"));
	return ret_;
}

//////////////////////////////////////////////////////////////////////////////////////
// implementation of factory manager methods for Configuration
bool ConfigurationFactoryManager::s_was_destroyed = false;

ConfigurationFactoryManager::ConfigurationFactoryManager () /*throw (Core::Root::FactoryManagerWasDestroyed)*/
	: m_has_registred_factories(false)
{
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
}

ConfigurationFactoryManager::~ConfigurationFactoryManager () {
	s_was_destroyed = true;
}

void ConfigurationFactoryManager::register_factory (
	ConfigurationAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
	Singleton::instance()->register_factory_i (factory, priority);
}

void ConfigurationFactoryManager::register_factory_i (
	ConfigurationAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey)*/ {
	m_has_registred_factories = true;
	FactoryMap::iterator f = m_factories_map.find(factory->key());
	if (f != m_factories_map.end() && f->second.priority == priority) {
		throw Core::Root::DuplicatedFactoryKey (
			"GblAdapterLib::Settings::ConfigurationFactory"
			, factory->key()
		);
	}
	if (f == m_factories_map.end() || f->second.priority <= priority) {
		m_factories_map[factory->key()].factory = ConfigurationAbstractFactory::_duplicate(factory);
		m_factories_map[factory->key()].priority = priority;
	}
	
	if (!m_single_active_factory || m_single_active_factory_priority <= priority) {
		m_single_active_factory = ConfigurationAbstractFactory::_duplicate(factory);
		m_single_active_factory_priority = priority;
	}
}

Configuration* ConfigurationFactoryManager::make (long id, const GCI::IO::String* name, const GCI::IO::String* hint, bool readonly) /*throw (Core::Root::NoActiveFactory)*/ {
	if (m_single_active_factory.is_nil()) {
		throw Core::Root::NoActiveFactory ("GblAdapterLib::Settings::ConfigurationFactory");
	}
	Configuration* ret_ = m_single_active_factory->make (id, name, hint, readonly);
	GDS_ASSERT_MSG (ret_ != 0, ("GblAdapterLib::Settings::ConfigurationFactory impl can't return zerro"));
	return ret_;
}

//////////////////////////////////////////////////////////////////////////////////////
// implementation of factory manager methods for DefaultValuesChangesIndicator
bool DefaultValuesChangesIndicatorFactoryManager::s_was_destroyed = false;

DefaultValuesChangesIndicatorFactoryManager::DefaultValuesChangesIndicatorFactoryManager () /*throw (Core::Root::FactoryManagerWasDestroyed)*/
	: m_has_registred_factories(false)
{
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
}

DefaultValuesChangesIndicatorFactoryManager::~DefaultValuesChangesIndicatorFactoryManager () {
	s_was_destroyed = true;
}

void DefaultValuesChangesIndicatorFactoryManager::register_factory (
	DefaultValuesChangesIndicatorAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
	Singleton::instance()->register_factory_i (factory, priority);
}

void DefaultValuesChangesIndicatorFactoryManager::register_factory_i (
	DefaultValuesChangesIndicatorAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey)*/ {
	m_has_registred_factories = true;
	FactoryMap::iterator f = m_factories_map.find(factory->key());
	if (f != m_factories_map.end() && f->second.priority == priority) {
		throw Core::Root::DuplicatedFactoryKey (
			"GblAdapterLib::Settings::DefaultValuesChangesIndicatorFactory"
			, factory->key()
		);
	}
	if (f == m_factories_map.end() || f->second.priority <= priority) {
		m_factories_map[factory->key()].factory = DefaultValuesChangesIndicatorAbstractFactory::_duplicate(factory);
		m_factories_map[factory->key()].priority = priority;
	}
	
	if (!m_single_active_factory || m_single_active_factory_priority <= priority) {
		m_single_active_factory = DefaultValuesChangesIndicatorAbstractFactory::_duplicate(factory);
		m_single_active_factory_priority = priority;
	}
}

DefaultValuesChangesIndicator* DefaultValuesChangesIndicatorFactoryManager::make (DefaultValuesChangesState state, const Configuration* configuration) /*throw (Core::Root::NoActiveFactory)*/ {
	if (m_single_active_factory.is_nil()) {
		throw Core::Root::NoActiveFactory ("GblAdapterLib::Settings::DefaultValuesChangesIndicatorFactory");
	}
	DefaultValuesChangesIndicator* ret_ = m_single_active_factory->make (state, configuration);
	GDS_ASSERT_MSG (ret_ != 0, ("GblAdapterLib::Settings::DefaultValuesChangesIndicatorFactory impl can't return zerro"));
	return ret_;
}

//////////////////////////////////////////////////////////////////////////////////////
// implementation of factory manager methods for ConfigurationManager
bool ConfigurationManagerFactoryManager::s_was_destroyed = false;

ConfigurationManagerFactoryManager::ConfigurationManagerFactoryManager () /*throw (Core::Root::FactoryManagerWasDestroyed)*/
	: m_has_registred_factories(false)
{
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
}

ConfigurationManagerFactoryManager::~ConfigurationManagerFactoryManager () {
	s_was_destroyed = true;
}

void ConfigurationManagerFactoryManager::register_factory (
	ConfigurationManagerAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
	Singleton::instance()->register_factory_i (factory, priority);
}

void ConfigurationManagerFactoryManager::register_factory_i (
	ConfigurationManagerAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey)*/ {
	m_has_registred_factories = true;
	FactoryMap::iterator f = m_factories_map.find(factory->key());
	if (f != m_factories_map.end() && f->second.priority == priority) {
		throw Core::Root::DuplicatedFactoryKey (
			"GblAdapterLib::Settings::ConfigurationManagerFactory"
			, factory->key()
		);
	}
	if (f == m_factories_map.end() || f->second.priority <= priority) {
		m_factories_map[factory->key()].factory = ConfigurationManagerAbstractFactory::_duplicate(factory);
		m_factories_map[factory->key()].priority = priority;
	}
	
	if (!m_single_active_factory || m_single_active_factory_priority <= priority) {
		m_single_active_factory = ConfigurationManagerAbstractFactory::_duplicate(factory);
		m_single_active_factory_priority = priority;
	}
}

ConfigurationManager* ConfigurationManagerFactoryManager::make () /*throw (Core::Root::NoActiveFactory)*/ {
	if (m_single_active_factory.is_nil()) {
		throw Core::Root::NoActiveFactory ("GblAdapterLib::Settings::ConfigurationManagerFactory");
	}
	ConfigurationManager* ret_ = m_single_active_factory->make ();
	GDS_ASSERT_MSG (ret_ != 0, ("GblAdapterLib::Settings::ConfigurationManagerFactory impl can't return zerro"));
	return ret_;
}

//////////////////////////////////////////////////////////////////////////////////////
// implementation of factory manager methods for PermanentSettingsManager
bool PermanentSettingsManagerFactoryManager::s_was_destroyed = false;

PermanentSettingsManagerFactoryManager::PermanentSettingsManagerFactoryManager () /*throw (Core::Root::FactoryManagerWasDestroyed)*/
	: m_has_registred_factories(false)
{
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
}

PermanentSettingsManagerFactoryManager::~PermanentSettingsManagerFactoryManager () {
	s_was_destroyed = true;
}

void PermanentSettingsManagerFactoryManager::register_factory (
	PermanentSettingsManagerAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
	Singleton::instance()->register_factory_i (factory, priority);
}

void PermanentSettingsManagerFactoryManager::register_factory_i (
	PermanentSettingsManagerAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey)*/ {
	m_has_registred_factories = true;
	FactoryMap::iterator f = m_factories_map.find(factory->key());
	if (f != m_factories_map.end() && f->second.priority == priority) {
		throw Core::Root::DuplicatedFactoryKey (
			"GblAdapterLib::Settings::PermanentSettingsManagerFactory"
			, factory->key()
		);
	}
	if (f == m_factories_map.end() || f->second.priority <= priority) {
		m_factories_map[factory->key()].factory = PermanentSettingsManagerAbstractFactory::_duplicate(factory);
		m_factories_map[factory->key()].priority = priority;
	}
	
	if (!m_single_active_factory || m_single_active_factory_priority <= priority) {
		m_single_active_factory = PermanentSettingsManagerAbstractFactory::_duplicate(factory);
		m_single_active_factory_priority = priority;
	}
}

PermanentSettingsManager* PermanentSettingsManagerFactoryManager::make () /*throw (Core::Root::NoActiveFactory)*/ {
	if (m_single_active_factory.is_nil()) {
		throw Core::Root::NoActiveFactory ("GblAdapterLib::Settings::PermanentSettingsManagerFactory");
	}
	PermanentSettingsManager* ret_ = m_single_active_factory->make ();
	GDS_ASSERT_MSG (ret_ != 0, ("GblAdapterLib::Settings::PermanentSettingsManagerFactory impl can't return zerro"));
	return ret_;
}
} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

