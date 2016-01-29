////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/ServerGate/BuildSupport/BuildSupportFactories.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<ServerInterfaces::Category>> MDProcess::ServerGate::BuildSupport
//
// Пакет серверных интерфейсов для создания сборок в К
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/ServerGate/BuildSupport/BuildSupportFactories.h"
#include "MDProcess/ServerGate/LibHome.h"

namespace ServerGate {
namespace BuildSupport {

//////////////////////////////////////////////////////////////////////////////////////
// implementation of factory manager methods for BuildManager
bool BuildManagerFactoryManager::s_was_destroyed = false;

BuildManagerFactoryManager::BuildManagerFactoryManager () /*throw (Core::Root::FactoryManagerWasDestroyed)*/
	: m_has_registred_factories(false)
{
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
}

BuildManagerFactoryManager::~BuildManagerFactoryManager () {
	s_was_destroyed = true;
}

void BuildManagerFactoryManager::register_factory (
	BuildManagerAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
	Singleton::instance()->register_factory_i (factory, priority);
}

void BuildManagerFactoryManager::publish_self () {
	if (Singleton::instance()->m_has_registred_factories) {
		BuildManagerFactoryManagerSrv_var ref = Singleton::instance()->_this();
		CoreSrv::bind_path (&LibHomeFactory::get().get_orb_facet().get_ns_root(), ref.in(), "ServerGate::BuildSupport::BuildManager");
	}
}

void BuildManagerFactoryManager::register_factory_i (
	BuildManagerAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey)*/ {
	m_has_registred_factories = true;
	FactoryMap::iterator f = m_factories_map.find(factory->key());
	if (f != m_factories_map.end() && f->second.priority == priority) {
		throw Core::Root::DuplicatedFactoryKey (
			"ServerGate::BuildSupport::BuildManagerFactory"
			, factory->key()
		);
	}
	if (f == m_factories_map.end() || f->second.priority <= priority) {
		m_factories_map[factory->key()].factory = BuildManagerAbstractFactory::_duplicate(factory);
		m_factories_map[factory->key()].priority = priority;
	}
	
	if (!m_single_active_factory || m_single_active_factory_priority <= priority) {
		m_single_active_factory = BuildManagerAbstractFactory::_duplicate(factory);
		m_single_active_factory_priority = priority;
	}
}

BuildManager* BuildManagerFactoryManager::get () throw (CORBA::SystemException, CoreSrv::NoActiveFactory) {
	if (m_cached_object_for_get.ptr() == 0) {
		GUARD(m_mutex_for_get);
		if (m_cached_object_for_get.ptr() == 0) {
			if (m_single_active_factory.is_nil()) {
				throw Core::Root::NoActiveFactory ("ServerGate::BuildSupport::BuildManagerFactory");
			}
			m_cached_object_for_get = m_single_active_factory->get ();
		
			GDS_ASSERT_MSG (m_cached_object_for_get.ptr() != 0, ("ServerGate::BuildSupport::BuildManagerFactory impl can't return zerro"));
		}
	}
	return BuildManager::_duplicate(m_cached_object_for_get.in ());
}
} // namespace BuildSupport
} // namespace ServerGate

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

