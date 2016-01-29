////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/DynamicTreeLocalInterface/DynamicTreeLocalInterfaceFactories.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::DynamicTreeLocalInterface
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DynamicTreeLocalInterface/DynamicTreeLocalInterfaceFactories.h"

namespace GblAdapterLib {

//////////////////////////////////////////////////////////////////////////////////////
// implementation of factory manager methods for QueryFilter
bool QueryFilterFactoryManager::s_was_destroyed = false;

QueryFilterFactoryManager::QueryFilterFactoryManager () /*throw (Core::Root::FactoryManagerWasDestroyed)*/
	: m_has_registred_factories(false)
{
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
}

QueryFilterFactoryManager::~QueryFilterFactoryManager () {
	s_was_destroyed = true;
}

void QueryFilterFactoryManager::register_factory (
	QueryFilterAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
	Singleton::instance()->register_factory_i (factory, priority);
}

void QueryFilterFactoryManager::register_factory_i (
	QueryFilterAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey)*/ {
	m_has_registred_factories = true;
	FactoryMap::iterator f = m_factories_map.find(factory->key());
	if (f != m_factories_map.end() && f->second.priority == priority) {
		throw Core::Root::DuplicatedFactoryKey (
			"GblAdapterLib::DynamicTreeLocalInterface::QueryFilterFactory"
			, factory->key()
		);
	}
	if (f == m_factories_map.end() || f->second.priority <= priority) {
		m_factories_map[factory->key()].factory = QueryFilterAbstractFactory::_duplicate(factory);
		m_factories_map[factory->key()].priority = priority;
	}
	
	if (!m_single_active_factory || m_single_active_factory_priority <= priority) {
		m_single_active_factory = QueryFilterAbstractFactory::_duplicate(factory);
		m_single_active_factory_priority = priority;
	}
}

QueryFilter* QueryFilterFactoryManager::make (FilterFromQuery* data) /*throw (Core::Root::NoActiveFactory)*/ {
	if (m_single_active_factory.is_nil()) {
		throw Core::Root::NoActiveFactory ("GblAdapterLib::DynamicTreeLocalInterface::QueryFilterFactory");
	}
	QueryFilter* ret_ = m_single_active_factory->make (data);
	GDS_ASSERT_MSG (ret_ != 0, ("GblAdapterLib::DynamicTreeLocalInterface::QueryFilterFactory impl can't return zerro"));
	return ret_;
}

QueryFilter* QueryFilterFactoryManager::make (FiltersFromQuery& data) /*throw (Core::Root::NoActiveFactory)*/ {
	if (m_single_active_factory.is_nil()) {
		throw Core::Root::NoActiveFactory ("GblAdapterLib::DynamicTreeLocalInterface::QueryFilterFactory");
	}
	QueryFilter* ret_ = m_single_active_factory->make (data);
	GDS_ASSERT_MSG (ret_ != 0, ("GblAdapterLib::DynamicTreeLocalInterface::QueryFilterFactory impl can't return zerro"));
	return ret_;
}

QueryFilter* QueryFilterFactoryManager::make () /*throw (Core::Root::NoActiveFactory)*/ {
	if (m_single_active_factory.is_nil()) {
		throw Core::Root::NoActiveFactory ("GblAdapterLib::DynamicTree::FilterForTreeFactory");
	}
	QueryFilter* ret_ = m_single_active_factory->make ();
	GDS_ASSERT_MSG (ret_ != 0, ("GblAdapterLib::DynamicTree::FilterForTreeFactory impl can't return zerro"));
	return ret_;
}
} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

