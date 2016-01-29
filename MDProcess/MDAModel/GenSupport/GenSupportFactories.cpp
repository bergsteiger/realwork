////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/GenSupport/GenSupportFactories.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Interfaces::Category>> MDProcess::MDAModel::GenSupport
//
// вспомогательные интерфейсы для генерации
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/GenSupport/GenSupportFactories.h"

namespace GenSupport {

//////////////////////////////////////////////////////////////////////////////////////
// implementation of factory manager methods for ProgessIndicatorService
bool ProgessIndicatorServiceFactoryManager::s_was_destroyed = false;

ProgessIndicatorServiceFactoryManager::ProgessIndicatorServiceFactoryManager () /*throw (Core::Root::FactoryManagerWasDestroyed)*/
	: m_has_registred_factories(false)
{
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
}

ProgessIndicatorServiceFactoryManager::~ProgessIndicatorServiceFactoryManager () {
	s_was_destroyed = true;
}

void ProgessIndicatorServiceFactoryManager::register_factory (
	ProgessIndicatorServiceAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
	Singleton::instance()->register_factory_i (factory, priority);
}

void ProgessIndicatorServiceFactoryManager::register_factory_i (
	ProgessIndicatorServiceAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey)*/ {
	m_has_registred_factories = true;
	FactoryMap::iterator f = m_factories_map.find(factory->key());
	if (f != m_factories_map.end() && f->second.priority == priority) {
		throw Core::Root::DuplicatedFactoryKey (
			"MDAModel::GenSupport::ProgessIndicatorServiceFactory"
			, factory->key()
		);
	}
	if (f == m_factories_map.end() || f->second.priority <= priority) {
		m_factories_map[factory->key()].factory = ProgessIndicatorServiceAbstractFactory::_duplicate(factory);
		m_factories_map[factory->key()].priority = priority;
	}
	
	if (!m_single_active_factory || m_single_active_factory_priority <= priority) {
		m_single_active_factory = ProgessIndicatorServiceAbstractFactory::_duplicate(factory);
		m_single_active_factory_priority = priority;
	}
}

ProgessIndicatorService& ProgessIndicatorServiceFactoryManager::get () /*throw (Core::Root::NoActiveFactory)*/ {
	if (m_cached_object_for_get.ptr() == 0) {
		GUARD(m_mutex_for_get);
		if (m_cached_object_for_get.ptr() == 0) {
			if (m_single_active_factory.is_nil()) {
				throw Core::Root::NoActiveFactory ("MDAModel::GenSupport::ProgessIndicatorServiceFactory");
			}
			m_cached_object_for_get = m_single_active_factory->get ();
		
			GDS_ASSERT_MSG (m_cached_object_for_get.ptr() != 0, ("MDAModel::GenSupport::ProgessIndicatorServiceFactory impl can't return zerro"));
		}
	}
	return *m_cached_object_for_get;
}

//////////////////////////////////////////////////////////////////////////////////////
// implementation of factory manager methods for PageProxy
bool PageProxyFactoryManager::s_was_destroyed = false;

PageProxyFactoryManager::PageProxyFactoryManager () /*throw (Core::Root::FactoryManagerWasDestroyed)*/
	: m_has_registred_factories(false)
{
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
}

PageProxyFactoryManager::~PageProxyFactoryManager () {
	s_was_destroyed = true;
}

void PageProxyFactoryManager::register_factory (
	PageProxyAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
	Singleton::instance()->register_factory_i (factory, priority);
}

void PageProxyFactoryManager::register_factory_i (
	PageProxyAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey)*/ {
	m_has_registred_factories = true;
	FactoryMap::iterator f = m_factories_map.find(factory->key());
	if (f != m_factories_map.end() && f->second.priority == priority) {
		throw Core::Root::DuplicatedFactoryKey (
			"MDAModel::GenSupport::PageProxyFactory"
			, factory->key()
		);
	}
	if (f == m_factories_map.end() || f->second.priority <= priority) {
		m_factories_map[factory->key()].factory = PageProxyAbstractFactory::_duplicate(factory);
		m_factories_map[factory->key()].priority = priority;
	}
	
	if (!m_single_active_factory || m_single_active_factory_priority <= priority) {
		m_single_active_factory = PageProxyAbstractFactory::_duplicate(factory);
		m_single_active_factory_priority = priority;
	}
}

PageProxy& PageProxyFactoryManager::get (ServerGate::GenerationContents::ModelElementId_const page_guid) /*throw (Core::Root::NoActiveFactory)*/ {
	GUARD(m_mutex_for_get);
	CachedObjectsForGet::iterator f = m_cached_objects_for_get.find (ObjectCreationIdForGet(page_guid));
	if (f == m_cached_objects_for_get.end()) {
		if (m_single_active_factory.is_nil()) {
			throw Core::Root::NoActiveFactory ("MDAModel::GenSupport::PageProxyFactory");
		}
		f = m_cached_objects_for_get.insert (
			CachedObjectsForGet::value_type(
				ObjectCreationIdForGet(page_guid)
				, m_single_active_factory->get (page_guid)
			)
		).first;
		m_cached_objects_index_for_get.insert (
			CachedObjectsIndexForGet::value_type (
				f->second.in()
				, f
			)
		);
	
	}
	GDS_ASSERT_MSG (f->second.in () != 0, ("MDAModel::GenSupport::PageProxyFactory impl can't return zerro"));
	return *f->second;
}

//////////////////////////////////////////////////////////////////////////////////////
// implementation of factory manager methods for LogManager
bool LogManagerFactoryManager::s_was_destroyed = false;

LogManagerFactoryManager::LogManagerFactoryManager () /*throw (Core::Root::FactoryManagerWasDestroyed)*/
	: m_has_registred_factories(false)
{
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
}

LogManagerFactoryManager::~LogManagerFactoryManager () {
	s_was_destroyed = true;
}

void LogManagerFactoryManager::register_factory (
	LogManagerAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
	Singleton::instance()->register_factory_i (factory, priority);
}

void LogManagerFactoryManager::register_factory_i (
	LogManagerAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey)*/ {
	m_has_registred_factories = true;
	FactoryMap::iterator f = m_factories_map.find(factory->key());
	if (f != m_factories_map.end() && f->second.priority == priority) {
		throw Core::Root::DuplicatedFactoryKey (
			"MDAModel::GenSupport::LogManagerFactory"
			, factory->key()
		);
	}
	if (f == m_factories_map.end() || f->second.priority <= priority) {
		m_factories_map[factory->key()].factory = LogManagerAbstractFactory::_duplicate(factory);
		m_factories_map[factory->key()].priority = priority;
	}
	
	if (!m_single_active_factory || m_single_active_factory_priority <= priority) {
		m_single_active_factory = LogManagerAbstractFactory::_duplicate(factory);
		m_single_active_factory_priority = priority;
	}
}

LogManager& LogManagerFactoryManager::get () /*throw (Core::Root::NoActiveFactory)*/ {
	if (m_cached_object_for_get.ptr() == 0) {
		GUARD(m_mutex_for_get);
		if (m_cached_object_for_get.ptr() == 0) {
			if (m_single_active_factory.is_nil()) {
				throw Core::Root::NoActiveFactory ("MDAModel::GenSupport::LogManagerFactory");
			}
			m_cached_object_for_get = m_single_active_factory->get ();
		
			GDS_ASSERT_MSG (m_cached_object_for_get.ptr() != 0, ("MDAModel::GenSupport::LogManagerFactory impl can't return zerro"));
		}
	}
	return *m_cached_object_for_get;
}

//////////////////////////////////////////////////////////////////////////////////////
// implementation of factory manager methods for ErrorManager
bool ErrorManagerFactoryManager::s_was_destroyed = false;

ErrorManagerFactoryManager::ErrorManagerFactoryManager () /*throw (Core::Root::FactoryManagerWasDestroyed)*/
	: m_has_registred_factories(false)
{
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
}

ErrorManagerFactoryManager::~ErrorManagerFactoryManager () {
	s_was_destroyed = true;
}

void ErrorManagerFactoryManager::register_factory (
	ErrorManagerAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
	Singleton::instance()->register_factory_i (factory, priority);
}

void ErrorManagerFactoryManager::register_factory_i (
	ErrorManagerAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey)*/ {
	m_has_registred_factories = true;
	FactoryMap::iterator f = m_factories_map.find(factory->key());
	if (f != m_factories_map.end() && f->second.priority == priority) {
		throw Core::Root::DuplicatedFactoryKey (
			"MDAModel::GenSupport::ErrorManagerFactory"
			, factory->key()
		);
	}
	if (f == m_factories_map.end() || f->second.priority <= priority) {
		m_factories_map[factory->key()].factory = ErrorManagerAbstractFactory::_duplicate(factory);
		m_factories_map[factory->key()].priority = priority;
	}
	
	if (!m_single_active_factory || m_single_active_factory_priority <= priority) {
		m_single_active_factory = ErrorManagerAbstractFactory::_duplicate(factory);
		m_single_active_factory_priority = priority;
	}
}

ErrorManager& ErrorManagerFactoryManager::get () /*throw (Core::Root::NoActiveFactory)*/ {
	if (m_cached_object_for_get.ptr() == 0) {
		GUARD(m_mutex_for_get);
		if (m_cached_object_for_get.ptr() == 0) {
			if (m_single_active_factory.is_nil()) {
				throw Core::Root::NoActiveFactory ("MDAModel::GenSupport::ErrorManagerFactory");
			}
			m_cached_object_for_get = m_single_active_factory->get ();
		
			GDS_ASSERT_MSG (m_cached_object_for_get.ptr() != 0, ("MDAModel::GenSupport::ErrorManagerFactory impl can't return zerro"));
		}
	}
	return *m_cached_object_for_get;
}

//////////////////////////////////////////////////////////////////////////////////////
// implementation of factory manager methods for Environment
bool EnvironmentFactoryManager::s_was_destroyed = false;

EnvironmentFactoryManager::EnvironmentFactoryManager () /*throw (Core::Root::FactoryManagerWasDestroyed)*/
	: m_has_registred_factories(false)
{
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
}

EnvironmentFactoryManager::~EnvironmentFactoryManager () {
	s_was_destroyed = true;
}

void EnvironmentFactoryManager::register_factory (
	EnvironmentAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
	Singleton::instance()->register_factory_i (factory, priority);
}

void EnvironmentFactoryManager::register_factory_i (
	EnvironmentAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey)*/ {
	m_has_registred_factories = true;
	FactoryMap::iterator f = m_factories_map.find(factory->key());
	if (f != m_factories_map.end() && f->second.priority == priority) {
		throw Core::Root::DuplicatedFactoryKey (
			"MDAModel::GenSupport::EnvironmentFactory"
			, factory->key()
		);
	}
	if (f == m_factories_map.end() || f->second.priority <= priority) {
		m_factories_map[factory->key()].factory = EnvironmentAbstractFactory::_duplicate(factory);
		m_factories_map[factory->key()].priority = priority;
	}
	
	if (!m_single_active_factory || m_single_active_factory_priority <= priority) {
		m_single_active_factory = EnvironmentAbstractFactory::_duplicate(factory);
		m_single_active_factory_priority = priority;
	}
}

Environment& EnvironmentFactoryManager::get () /*throw (Core::Root::NoActiveFactory)*/ {
	if (m_cached_object_for_get.ptr() == 0) {
		GUARD(m_mutex_for_get);
		if (m_cached_object_for_get.ptr() == 0) {
			if (m_single_active_factory.is_nil()) {
				throw Core::Root::NoActiveFactory ("MDAModel::GenSupport::EnvironmentFactory");
			}
			m_cached_object_for_get = m_single_active_factory->get ();
		
			GDS_ASSERT_MSG (m_cached_object_for_get.ptr() != 0, ("MDAModel::GenSupport::EnvironmentFactory impl can't return zerro"));
		}
	}
	return *m_cached_object_for_get;
}
} // namespace GenSupport

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

