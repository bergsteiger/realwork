////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/CoreSrv/Security/SecurityFactories.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Interfaces::Category>> shared::CoreSrv::Security
//
// сервисные локальные интерфейсы подсистемы безопасности
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/CoreSrv/Security/SecurityFactories.h"

namespace CoreSrv {

//////////////////////////////////////////////////////////////////////////////////////
// implementation of factory manager methods for Session
bool SessionFactoryManager::s_was_destroyed = false;

SessionFactoryManager::SessionFactoryManager () /*throw (Core::Root::FactoryManagerWasDestroyed)*/
	: m_has_registred_factories(false)
{
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
}

SessionFactoryManager::~SessionFactoryManager () {
	s_was_destroyed = true;
}

void SessionFactoryManager::register_factory (
	SessionAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
	Singleton::instance()->register_factory_i (factory, priority);
}

void SessionFactoryManager::register_factory_i (
	SessionAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey)*/ {
	m_has_registred_factories = true;
	FactoryMap::iterator f = m_factories_map.find(factory->key());
	if (f != m_factories_map.end() && f->second.priority == priority) {
		throw Core::Root::DuplicatedFactoryKey (
			"CoreSrv::Security::SessionFactory"
			, factory->key()
		);
	}
	if (f == m_factories_map.end() || f->second.priority <= priority) {
		m_factories_map[factory->key()].factory = SessionAbstractFactory::_duplicate(factory);
		m_factories_map[factory->key()].priority = priority;
	}
	
	if (!m_single_active_factory || m_single_active_factory_priority <= priority) {
		m_single_active_factory = SessionAbstractFactory::_duplicate(factory);
		m_single_active_factory_priority = priority;
	}
}

Session& SessionFactoryManager::get () /*throw (Core::Root::NoActiveFactory)*/ {
	if (m_cached_object_for_get.ptr() == 0) {
		GUARD(m_mutex_for_get);
		if (m_cached_object_for_get.ptr() == 0) {
			if (m_single_active_factory.is_nil()) {
				throw Core::Root::NoActiveFactory ("CoreSrv::Security::SessionFactory");
			}
			m_cached_object_for_get = m_single_active_factory->get ();
		
			GDS_ASSERT_MSG (m_cached_object_for_get.ptr() != 0, ("CoreSrv::Security::SessionFactory impl can't return zerro"));
		}
	}
	return *m_cached_object_for_get;
}
} // namespace CoreSrv

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

