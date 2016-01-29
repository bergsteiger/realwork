////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/GCI/I18N/I18NFactories.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Interfaces::Category>> shared::GCI::I18N
//
// Интернационализация
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/Core/sys/std_inc.h"
#include "shared/GCI/I18N/I18NFactories.h"

namespace GCI {
namespace I18N {

//////////////////////////////////////////////////////////////////////////////////////
// implementation of factory manager methods for LocaleOperations
bool LocaleOperationsFactoryManager::s_was_destroyed = false;

LocaleOperationsFactoryManager::LocaleOperationsFactoryManager () /*throw (Core::Root::FactoryManagerWasDestroyed)*/
	: m_has_registred_factories(false)
{
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
}

LocaleOperationsFactoryManager::~LocaleOperationsFactoryManager () {
	s_was_destroyed = true;
}

void LocaleOperationsFactoryManager::register_factory (
	LocaleOperationsAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
	Singleton::instance()->register_factory_i (factory, priority);
}

void LocaleOperationsFactoryManager::register_factory_i (
	LocaleOperationsAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey)*/ {
	m_has_registred_factories = true;
	FactoryMap::iterator f = m_factories_map.find(factory->key());
	if (f != m_factories_map.end() && f->second.priority == priority) {
		throw Core::Root::DuplicatedFactoryKey (
			"GCI::I18N::LocaleOperationsFactory"
			, factory->key()
		);
	}
	if (f == m_factories_map.end() || f->second.priority <= priority) {
		m_factories_map[factory->key()].factory = LocaleOperationsAbstractFactory::_duplicate(factory);
		m_factories_map[factory->key()].priority = priority;
	}
	
	if (!m_single_active_factory || m_single_active_factory_priority <= priority) {
		m_single_active_factory = LocaleOperationsAbstractFactory::_duplicate(factory);
		m_single_active_factory_priority = priority;
	}
}

LocaleOperations& LocaleOperationsFactoryManager::make () /*throw (Core::Root::NoActiveFactory)*/ {
	if (m_cached_object_for_make.ptr() == 0) {
		GUARD(m_mutex_for_make);
		if (m_cached_object_for_make.ptr() == 0) {
			if (m_single_active_factory.is_nil()) {
				throw Core::Root::NoActiveFactory ("GCI::I18N::LocaleOperationsFactory");
			}
			m_cached_object_for_make = m_single_active_factory->make ();
		
			GDS_ASSERT_MSG (m_cached_object_for_make.ptr() != 0, ("GCI::I18N::LocaleOperationsFactory impl can't return zerro"));
		}
	}
	return *m_cached_object_for_make;
}

//////////////////////////////////////////////////////////////////////////////////////
// implementation of factory manager methods for Messages
bool MessagesFactoryManager::s_was_destroyed = false;

MessagesFactoryManager::MessagesFactoryManager () /*throw (Core::Root::FactoryManagerWasDestroyed)*/
	: m_has_registred_factories(false)
{
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
}

MessagesFactoryManager::~MessagesFactoryManager () {
	s_was_destroyed = true;
}

void MessagesFactoryManager::register_factory (
	MessagesAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
	Singleton::instance()->register_factory_i (factory, priority);
}

void MessagesFactoryManager::register_factory_i (
	MessagesAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey)*/ {
	m_has_registred_factories = true;
	FactoryMap::iterator f = m_factories_map.find(factory->key());
	if (f != m_factories_map.end() && f->second.priority == priority) {
		throw Core::Root::DuplicatedFactoryKey (
			"GCI::I18N::MessagesFactory"
			, factory->key()
		);
	}
	if (f == m_factories_map.end() || f->second.priority <= priority) {
		m_factories_map[factory->key()].factory = MessagesAbstractFactory::_duplicate(factory);
		m_factories_map[factory->key()].priority = priority;
	}
	
	if (!m_single_active_factory || m_single_active_factory_priority <= priority) {
		m_single_active_factory = MessagesAbstractFactory::_duplicate(factory);
		m_single_active_factory_priority = priority;
	}
}

Messages& MessagesFactoryManager::messages () /*throw (Core::Root::NoActiveFactory)*/ {
	if (m_cached_object_for_messages.ptr() == 0) {
		GUARD(m_mutex_for_messages);
		if (m_cached_object_for_messages.ptr() == 0) {
			if (m_single_active_factory.is_nil()) {
				throw Core::Root::NoActiveFactory ("GCI::I18N::MessagesFactory");
			}
			m_cached_object_for_messages = m_single_active_factory->messages ();
		
			GDS_ASSERT_MSG (m_cached_object_for_messages.ptr() != 0, ("GCI::I18N::MessagesFactory impl can't return zerro"));
		}
	}
	return *m_cached_object_for_messages;
}
} // namespace I18N
} // namespace GCI

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

