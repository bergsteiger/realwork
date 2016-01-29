////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/ServerGate/Comm/CommFactories.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<ServerInterfaces::Category>> MDProcess::ServerGate::Comm
//
// Коммуникационные иинтерфейсы для взаимодействия с внешними агентами
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/ServerGate/Comm/CommFactories.h"
#include "MDProcess/ServerGate/LibHome.h"

namespace ServerGate {
namespace Comm {

//////////////////////////////////////////////////////////////////////////////////////
// implementation of factory manager methods for BuildListner
bool BuildListnerFactoryManager::s_was_destroyed = false;

BuildListnerFactoryManager::BuildListnerFactoryManager () /*throw (Core::Root::FactoryManagerWasDestroyed)*/
	: m_has_registred_factories(false)
{
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
}

BuildListnerFactoryManager::~BuildListnerFactoryManager () {
	s_was_destroyed = true;
}

void BuildListnerFactoryManager::register_factory (
	BuildListnerAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
	Singleton::instance()->register_factory_i (factory, priority);
}

void BuildListnerFactoryManager::publish_self () {
	if (Singleton::instance()->m_has_registred_factories) {
		BuildListnerFactoryManagerSrv_var ref = Singleton::instance()->_this();
		CoreSrv::bind_path (&LibHomeFactory::get().get_orb_facet().get_ns_root(), ref.in(), "ServerGate::Comm::BuildListner");
	}
}

void BuildListnerFactoryManager::register_factory_i (
	BuildListnerAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey)*/ {
	m_has_registred_factories = true;
	FactoryMap::iterator f = m_factories_map.find(factory->key());
	if (f != m_factories_map.end() && f->second.priority == priority) {
		throw Core::Root::DuplicatedFactoryKey (
			"ServerGate::Comm::BuildListnerFactory"
			, factory->key()
		);
	}
	if (f == m_factories_map.end() || f->second.priority <= priority) {
		m_factories_map[factory->key()].factory = BuildListnerAbstractFactory::_duplicate(factory);
		m_factories_map[factory->key()].priority = priority;
	}
	
	if (!m_single_active_factory || m_single_active_factory_priority <= priority) {
		m_single_active_factory = BuildListnerAbstractFactory::_duplicate(factory);
		m_single_active_factory_priority = priority;
	}
}

BuildListner* BuildListnerFactoryManager::get () throw (CORBA::SystemException, CoreSrv::NoActiveFactory) {
	if (m_cached_object_for_get.ptr() == 0) {
		GUARD(m_mutex_for_get);
		if (m_cached_object_for_get.ptr() == 0) {
			if (m_single_active_factory.is_nil()) {
				throw Core::Root::NoActiveFactory ("ServerGate::Comm::BuildListnerFactory");
			}
			m_cached_object_for_get = m_single_active_factory->get ();
		
			GDS_ASSERT_MSG (m_cached_object_for_get.ptr() != 0, ("ServerGate::Comm::BuildListnerFactory impl can't return zerro"));
		}
	}
	return BuildListner::_duplicate(m_cached_object_for_get.in ());
}
} // namespace Comm
} // namespace ServerGate

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

