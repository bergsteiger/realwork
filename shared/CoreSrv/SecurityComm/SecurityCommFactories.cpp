////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/CoreSrv/SecurityComm/SecurityCommFactories.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Interfaces::Category>> shared::CoreSrv::SecurityComm
//
// коммуникационные локальные интерфейсы и типы ддля подсистемы Безопасности
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/CoreSrv/SecurityComm/SecurityCommFactories.h"

namespace CoreSrv {

//////////////////////////////////////////////////////////////////////////////////////
// implementation of factory manager methods for Authenticator
bool AuthenticatorFactoryManager::s_was_destroyed = false;

AuthenticatorFactoryManager::AuthenticatorFactoryManager () /*throw (Core::Root::FactoryManagerWasDestroyed)*/
	: m_has_registred_factories(false)
{
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
}

AuthenticatorFactoryManager::~AuthenticatorFactoryManager () {
	s_was_destroyed = true;
}

void AuthenticatorFactoryManager::register_factory (
	AuthenticatorAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
	Singleton::instance()->register_factory_i (factory, priority);
}

void AuthenticatorFactoryManager::register_factory_i (
	AuthenticatorAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey)*/ {
	m_has_registred_factories = true;
	FactoryMap::iterator f = m_factories_map.find(factory->key());
	if (f != m_factories_map.end() && f->second.priority == priority) {
		throw Core::Root::DuplicatedFactoryKey (
			"CoreSrv::SecurityComm::AuthenticatorFactory"
			, factory->key()
		);
	}
	if (f == m_factories_map.end() || f->second.priority <= priority) {
		m_factories_map[factory->key()].factory = AuthenticatorAbstractFactory::_duplicate(factory);
		m_factories_map[factory->key()].priority = priority;
	}
	
	if (!m_single_active_factory || m_single_active_factory_priority <= priority) {
		m_single_active_factory = AuthenticatorAbstractFactory::_duplicate(factory);
		m_single_active_factory_priority = priority;
	}
}

Authenticator& AuthenticatorFactoryManager::get () /*throw (Core::Root::NoActiveFactory)*/ {
	if (m_cached_object_for_get.ptr() == 0) {
		GUARD(m_mutex_for_get);
		if (m_cached_object_for_get.ptr() == 0) {
			if (m_single_active_factory.is_nil()) {
				throw Core::Root::NoActiveFactory ("CoreSrv::SecurityComm::AuthenticatorFactory");
			}
			m_cached_object_for_get = m_single_active_factory->get ();
		
			GDS_ASSERT_MSG (m_cached_object_for_get.ptr() != 0, ("CoreSrv::SecurityComm::AuthenticatorFactory impl can't return zerro"));
		}
	}
	return *m_cached_object_for_get;
}
} // namespace CoreSrv

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

