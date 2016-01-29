////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/ContainerOperations/ContainerOperationsFactories.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Interfaces::Category>> MDProcess::MDAModel::ContainerOperations
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/ContainerOperations/ContainerOperationsFactories.h"

namespace ContainerOperations {

//////////////////////////////////////////////////////////////////////////////////////
// implementation of factory manager methods for ContainerTemplateOperations
bool ContainerTemplateOperationsFactoryManager::s_was_destroyed = false;

ContainerTemplateOperationsFactoryManager::ContainerTemplateOperationsFactoryManager () /*throw (Core::Root::FactoryManagerWasDestroyed)*/
	: m_has_registred_factories(false)
{
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
}

ContainerTemplateOperationsFactoryManager::~ContainerTemplateOperationsFactoryManager () {
	s_was_destroyed = true;
}

void ContainerTemplateOperationsFactoryManager::register_factory (
	ContainerTemplateOperationsAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
	Singleton::instance()->register_factory_i (factory, priority);
}

void ContainerTemplateOperationsFactoryManager::register_factory_i (
	ContainerTemplateOperationsAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey)*/ {
	m_has_registred_factories = true;
	FactoryMap::iterator f = m_factories_map.find(factory->key());
	if (f != m_factories_map.end() && f->second.priority == priority) {
		throw Core::Root::DuplicatedFactoryKey (
			"MDAModel::ContainerOperations::ContainerTemplateOperationsFactory"
			, factory->key()
		);
	}
	if (f == m_factories_map.end() || f->second.priority <= priority) {
		m_factories_map[factory->key()].factory = ContainerTemplateOperationsAbstractFactory::_duplicate(factory);
		m_factories_map[factory->key()].priority = priority;
	}
	
	if (!m_single_active_factory || m_single_active_factory_priority <= priority) {
		m_single_active_factory = ContainerTemplateOperationsAbstractFactory::_duplicate(factory);
		m_single_active_factory_priority = priority;
	}
}

ContainerTemplateOperations& ContainerTemplateOperationsFactoryManager::get () /*throw (Core::Root::NoActiveFactory)*/ {
	if (m_cached_object_for_get.ptr() == 0) {
		GUARD(m_mutex_for_get);
		if (m_cached_object_for_get.ptr() == 0) {
			if (m_single_active_factory.is_nil()) {
				throw Core::Root::NoActiveFactory ("MDAModel::ContainerOperations::ContainerTemplateOperationsFactory");
			}
			m_cached_object_for_get = m_single_active_factory->get ();
		
			GDS_ASSERT_MSG (m_cached_object_for_get.ptr() != 0, ("MDAModel::ContainerOperations::ContainerTemplateOperationsFactory impl can't return zerro"));
		}
	}
	return *m_cached_object_for_get;
}
} // namespace ContainerOperations

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

