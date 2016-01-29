////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/Notify/NotifyFactories.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::Notify
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Notify/NotifyFactories.h"

namespace GblAdapterLib {

//////////////////////////////////////////////////////////////////////////////////////
// implementation of factory manager methods for Notification
bool NotificationFactoryManager::s_was_destroyed = false;

NotificationFactoryManager::NotificationFactoryManager () /*throw (Core::Root::FactoryManagerWasDestroyed)*/
	: m_has_registred_factories(false)
{
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
}

NotificationFactoryManager::~NotificationFactoryManager () {
	s_was_destroyed = true;
}

void NotificationFactoryManager::register_factory (
	NotificationAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
	Singleton::instance()->register_factory_i (factory, priority);
}

void NotificationFactoryManager::register_factory_i (
	NotificationAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey)*/ {
	m_has_registred_factories = true;
	FactoryMap::iterator f = m_factories_map.find(factory->key());
	if (f != m_factories_map.end() && f->second.priority == priority) {
		throw Core::Root::DuplicatedFactoryKey (
			"GblAdapterLib::Notify::NotificationFactory"
			, factory->key()
		);
	}
	if (f == m_factories_map.end() || f->second.priority <= priority) {
		m_factories_map[factory->key()].factory = NotificationAbstractFactory::_duplicate(factory);
		m_factories_map[factory->key()].priority = priority;
	}
	
	if (!m_single_active_factory || m_single_active_factory_priority <= priority) {
		m_single_active_factory = NotificationAbstractFactory::_duplicate(factory);
		m_single_active_factory_priority = priority;
	}
}

Notification* NotificationFactoryManager::make () /*throw (Core::Root::NoActiveFactory)*/ {
	if (m_single_active_factory.is_nil()) {
		throw Core::Root::NoActiveFactory ("GblAdapterLib::Notify::NotificationFactory");
	}
	Notification* ret_ = m_single_active_factory->make ();
	GDS_ASSERT_MSG (ret_ != 0, ("GblAdapterLib::Notify::NotificationFactory impl can't return zerro"));
	return ret_;
}

//////////////////////////////////////////////////////////////////////////////////////
// implementation of factory manager methods for NotifyManager
bool NotifyManagerFactoryManager::s_was_destroyed = false;

NotifyManagerFactoryManager::NotifyManagerFactoryManager () /*throw (Core::Root::FactoryManagerWasDestroyed)*/
	: m_has_registred_factories(false)
{
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
}

NotifyManagerFactoryManager::~NotifyManagerFactoryManager () {
	s_was_destroyed = true;
}

void NotifyManagerFactoryManager::register_factory (
	NotifyManagerAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
	Singleton::instance()->register_factory_i (factory, priority);
}

void NotifyManagerFactoryManager::register_factory_i (
	NotifyManagerAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey)*/ {
	m_has_registred_factories = true;
	FactoryMap::iterator f = m_factories_map.find(factory->key());
	if (f != m_factories_map.end() && f->second.priority == priority) {
		throw Core::Root::DuplicatedFactoryKey (
			"GblAdapterLib::Notify::NotifyManagerFactory"
			, factory->key()
		);
	}
	if (f == m_factories_map.end() || f->second.priority <= priority) {
		m_factories_map[factory->key()].factory = NotifyManagerAbstractFactory::_duplicate(factory);
		m_factories_map[factory->key()].priority = priority;
	}
	
	if (!m_single_active_factory || m_single_active_factory_priority <= priority) {
		m_single_active_factory = NotifyManagerAbstractFactory::_duplicate(factory);
		m_single_active_factory_priority = priority;
	}
}

NotifyManager& NotifyManagerFactoryManager::make () /*throw (Core::Root::NoActiveFactory)*/ {
	if (m_cached_object_for_make.ptr() == 0) {
		GUARD(m_mutex_for_make);
		if (m_cached_object_for_make.ptr() == 0) {
			if (m_single_active_factory.is_nil()) {
				throw Core::Root::NoActiveFactory ("GblAdapterLib::Notify::NotifyManagerFactory");
			}
			m_cached_object_for_make = m_single_active_factory->make ();
		
			GDS_ASSERT_MSG (m_cached_object_for_make.ptr() != 0, ("GblAdapterLib::Notify::NotifyManagerFactory impl can't return zerro"));
		}
	}
	return *m_cached_object_for_make;
}
} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

