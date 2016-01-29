////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/CoreSrv/SecuritySrv/SecuritySrvFactories.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<ServerInterfaces::Category>> shared::CoreSrv::SecuritySrv
//
// сервисные распределенные интерфейсы подсистемы Безопасности
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/CoreSrv/SecuritySrv/SecuritySrvFactories.h"
#include "shared/CoreSrv/LibHome.h"

namespace CoreSrv {
namespace SecuritySrv {

//////////////////////////////////////////////////////////////////////////////////////
// implementation of factory manager methods for SessionManager
bool SessionManagerFactoryManager::s_was_destroyed = false;

SessionManagerFactoryManager::SessionManagerFactoryManager () /*throw (Core::Root::FactoryManagerWasDestroyed)*/
	: m_has_registred_factories(false)
{
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
}

SessionManagerFactoryManager::~SessionManagerFactoryManager () {
	s_was_destroyed = true;
}

void SessionManagerFactoryManager::register_factory (
	SessionManagerAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
	Singleton::instance()->register_factory_i (factory, priority);
}

void SessionManagerFactoryManager::publish_self () {
	if (Singleton::instance()->m_has_registred_factories) {
		SessionManagerFactoryManagerSrv_var ref = Singleton::instance()->_this();
		CoreSrv::bind_path (&LibHomeFactory::get().get_orb_facet().get_ns_root(), ref.in(), "CoreSrv::SecuritySrv::SessionManager");
	}
}

void SessionManagerFactoryManager::register_factory_i (
	SessionManagerAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey)*/ {
	m_has_registred_factories = true;
	FactoryMap::iterator f = m_factories_map.find(factory->key());
	if (f != m_factories_map.end() && f->second.priority == priority) {
		throw Core::Root::DuplicatedFactoryKey (
			"CoreSrv::SecuritySrv::SessionManagerFactory"
			, factory->key()
		);
	}
	if (f == m_factories_map.end() || f->second.priority <= priority) {
		m_factories_map[factory->key()].factory = SessionManagerAbstractFactory::_duplicate(factory);
		m_factories_map[factory->key()].priority = priority;
	}
	
	if (!m_single_active_factory || m_single_active_factory_priority <= priority) {
		m_single_active_factory = SessionManagerAbstractFactory::_duplicate(factory);
		m_single_active_factory_priority = priority;
	}
}

SessionManager* SessionManagerFactoryManager::get () throw (CORBA::SystemException, CoreSrv::NoActiveFactory) {
	if (m_cached_object_for_get.ptr() == 0) {
		GUARD(m_mutex_for_get);
		if (m_cached_object_for_get.ptr() == 0) {
			if (m_single_active_factory.is_nil()) {
				throw Core::Root::NoActiveFactory ("CoreSrv::SecuritySrv::SessionManagerFactory");
			}
			m_cached_object_for_get = m_single_active_factory->get ();
		
			GDS_ASSERT_MSG (m_cached_object_for_get.ptr() != 0, ("CoreSrv::SecuritySrv::SessionManagerFactory impl can't return zerro"));
		}
	}
	return SessionManager::_duplicate(m_cached_object_for_get.in ());
}
} // namespace SecuritySrv
} // namespace CoreSrv

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

