////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/GSI/impl/NotifyService_i/NotifyService_iFactories.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Impl::Category>> shared::GSI::NotifyService_i
//
// Реализация сервиса нотификаций
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/GSI/impl/NotifyService_i/NotifyService_iFactories.h"

namespace GSI {
namespace NotifyService_i {

//////////////////////////////////////////////////////////////////////////////////////
// implementation of factory manager methods for ManagerLocal
bool ManagerLocalFactoryManager::s_was_destroyed = false;

ManagerLocalFactoryManager::ManagerLocalFactoryManager () /*throw (Core::Root::FactoryManagerWasDestroyed)*/
	: m_has_registred_factories(false)
{
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
}

ManagerLocalFactoryManager::~ManagerLocalFactoryManager () {
	s_was_destroyed = true;
}

void ManagerLocalFactoryManager::register_factory (
	ManagerLocalAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
	Singleton::instance()->register_factory_i (factory, priority);
	NotifyService::ManagerFactoryManager::register_factory (factory, priority);
	
}

void ManagerLocalFactoryManager::register_factory_i (
	ManagerLocalAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey)*/ {
	m_has_registred_factories = true;
	FactoryMap::iterator f = m_factories_map.find(factory->key());
	if (f != m_factories_map.end() && f->second.priority == priority) {
		throw Core::Root::DuplicatedFactoryKey (
			"GSI::NotifyService_i::ManagerLocalFactory"
			, factory->key()
		);
	}
	if (f == m_factories_map.end() || f->second.priority <= priority) {
		m_factories_map[factory->key()].factory = ManagerLocalAbstractFactory::_duplicate(factory);
		m_factories_map[factory->key()].priority = priority;
	}
	
	if (!m_single_active_factory || m_single_active_factory_priority <= priority) {
		m_single_active_factory = ManagerLocalAbstractFactory::_duplicate(factory);
		m_single_active_factory_priority = priority;
	}
}
} // namespace NotifyService_i
} // namespace GSI

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

