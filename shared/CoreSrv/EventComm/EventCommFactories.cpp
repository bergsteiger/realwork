////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/CoreSrv/EventComm/EventCommFactories.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<ServerInterfaces::Category>> shared::CoreSrv::EventComm
//
// коммуникационные распределенные типы и интерфейсы для подсистемы Событий
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/CoreSrv/EventComm/EventCommFactories.h"
#include "shared/CoreSrv/LibHome.h"

namespace CoreSrv {
namespace EventComm {

//////////////////////////////////////////////////////////////////////////////////////
// implementation of factory manager methods for EventChannelManager
bool EventChannelManagerFactoryManager::s_was_destroyed = false;

EventChannelManagerFactoryManager::EventChannelManagerFactoryManager () /*throw (Core::Root::FactoryManagerWasDestroyed)*/
	: m_has_registred_factories(false)
{
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
}

EventChannelManagerFactoryManager::~EventChannelManagerFactoryManager () {
	s_was_destroyed = true;
}

void EventChannelManagerFactoryManager::register_factory (
	EventChannelManagerAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
	Singleton::instance()->register_factory_i (factory, priority);
}

void EventChannelManagerFactoryManager::publish_self () {
	if (Singleton::instance()->m_has_registred_factories) {
		EventChannelManagerFactoryManagerSrv_var ref = Singleton::instance()->_this();
		CoreSrv::bind_path (&LibHomeFactory::get().get_orb_facet().get_ns_root(), ref.in(), "CoreSrv::EventComm::EventChannelManager");
	}
}

void EventChannelManagerFactoryManager::register_factory_i (
	EventChannelManagerAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey)*/ {
	m_has_registred_factories = true;
	FactoryMap::iterator f = m_factories_map.find(factory->key());
	if (f != m_factories_map.end() && f->second.priority == priority) {
		throw Core::Root::DuplicatedFactoryKey (
			"CoreSrv::EventComm::EventChannelManagerFactory"
			, factory->key()
		);
	}
	if (f == m_factories_map.end() || f->second.priority <= priority) {
		m_factories_map[factory->key()].factory = EventChannelManagerAbstractFactory::_duplicate(factory);
		m_factories_map[factory->key()].priority = priority;
	}
	
	if (!m_single_active_factory || m_single_active_factory_priority <= priority) {
		m_single_active_factory = EventChannelManagerAbstractFactory::_duplicate(factory);
		m_single_active_factory_priority = priority;
	}
}

EventChannelManager* EventChannelManagerFactoryManager::get () throw (CORBA::SystemException, CoreSrv::NoActiveFactory) {
	if (m_cached_object_for_get.ptr() == 0) {
		GUARD(m_mutex_for_get);
		if (m_cached_object_for_get.ptr() == 0) {
			if (m_single_active_factory.is_nil()) {
				throw Core::Root::NoActiveFactory ("CoreSrv::EventComm::EventChannelManagerFactory");
			}
			m_cached_object_for_get = m_single_active_factory->get ();
		
			GDS_ASSERT_MSG (m_cached_object_for_get.ptr() != 0, ("CoreSrv::EventComm::EventChannelManagerFactory impl can't return zerro"));
		}
	}
	return EventChannelManager::_duplicate(m_cached_object_for_get.in ());
}
} // namespace EventComm
} // namespace CoreSrv

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

