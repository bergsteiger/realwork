////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/PrefixTree/PrefixTreeFactories.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::PrefixTree
//
// Дерево для Вид правовой информации
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/PrefixTree/PrefixTreeFactories.h"

namespace GblAdapterLib {

//////////////////////////////////////////////////////////////////////////////////////
// implementation of factory manager methods for PrefixNode
bool PrefixNodeFactoryManager::s_was_destroyed = false;

PrefixNodeFactoryManager::PrefixNodeFactoryManager () /*throw (Core::Root::FactoryManagerWasDestroyed)*/
	: m_has_registred_factories(false)
{
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
}

PrefixNodeFactoryManager::~PrefixNodeFactoryManager () {
	s_was_destroyed = true;
}

void PrefixNodeFactoryManager::register_factory (
	PrefixNodeAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
	Singleton::instance()->register_factory_i (factory, priority);
}

void PrefixNodeFactoryManager::register_factory_i (
	PrefixNodeAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey)*/ {
	m_has_registred_factories = true;
	FactoryMap::iterator f = m_factories_map.find(factory->key());
	if (f != m_factories_map.end() && f->second.priority == priority) {
		throw Core::Root::DuplicatedFactoryKey (
			"GblAdapterLib::PrefixTree::PrefixNodeFactory"
			, factory->key()
		);
	}
	if (f == m_factories_map.end() || f->second.priority <= priority) {
		m_factories_map[factory->key()].factory = PrefixNodeAbstractFactory::_duplicate(factory);
		m_factories_map[factory->key()].priority = priority;
	}
	
	if (!m_single_active_factory || m_single_active_factory_priority <= priority) {
		m_single_active_factory = PrefixNodeAbstractFactory::_duplicate(factory);
		m_single_active_factory_priority = priority;
	}
}

PrefixNode* PrefixNodeFactoryManager::make () /*throw (Core::Root::NoActiveFactory, CanNotFindData)*/ {
	if (m_single_active_factory.is_nil()) {
		throw Core::Root::NoActiveFactory ("GblAdapterLib::PrefixTree::PrefixNodeFactory");
	}
	PrefixNode* ret_ = m_single_active_factory->make ();
	GDS_ASSERT_MSG (ret_ != 0, ("GblAdapterLib::PrefixTree::PrefixNodeFactory impl can't return zerro"));
	return ret_;
}

PrefixNode* PrefixNodeFactoryManager::make (FakeFacetForFactory* owner_tree, const GTree::Node& snode) /*throw (Core::Root::NoActiveFactory)*/ {
	if (m_single_active_factory.is_nil()) {
		throw Core::Root::NoActiveFactory ("GblAdapterLib::PrefixTree::PrefixNodeFactory");
	}
	PrefixNode* ret_ = m_single_active_factory->make (owner_tree, snode);
	GDS_ASSERT_MSG (ret_ != 0, ("GblAdapterLib::PrefixTree::PrefixNodeFactory impl can't return zerro"));
	return ret_;
}
} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

