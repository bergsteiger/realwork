////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/DynamicDocList/DynamicDocListFactories.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::DynamicDocList
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DynamicDocList/DynamicDocListFactories.h"

namespace GblAdapterLib {

//////////////////////////////////////////////////////////////////////////////////////
// implementation of factory manager methods for ListEntryInfo
bool ListEntryInfoFactoryManager::s_was_destroyed = false;

ListEntryInfoFactoryManager::ListEntryInfoFactoryManager () /*throw (Core::Root::FactoryManagerWasDestroyed)*/
	: m_has_registred_factories(false)
{
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
}

ListEntryInfoFactoryManager::~ListEntryInfoFactoryManager () {
	s_was_destroyed = true;
}

void ListEntryInfoFactoryManager::register_factory (
	ListEntryInfoAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
	Singleton::instance()->register_factory_i (factory, priority);
}

void ListEntryInfoFactoryManager::register_factory_i (
	ListEntryInfoAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey)*/ {
	m_has_registred_factories = true;
	FactoryMap::iterator f = m_factories_map.find(factory->key());
	if (f != m_factories_map.end() && f->second.priority == priority) {
		throw Core::Root::DuplicatedFactoryKey (
			"GblAdapterLib::DynamicDocList::ListEntryInfoFactory"
			, factory->key()
		);
	}
	if (f == m_factories_map.end() || f->second.priority <= priority) {
		m_factories_map[factory->key()].factory = ListEntryInfoAbstractFactory::_duplicate(factory);
		m_factories_map[factory->key()].priority = priority;
	}
	
	if (!m_single_active_factory || m_single_active_factory_priority <= priority) {
		m_single_active_factory = ListEntryInfoAbstractFactory::_duplicate(factory);
		m_single_active_factory_priority = priority;
	}
}

ListEntryInfo* ListEntryInfoFactoryManager::make (const GblPilot::ListEntryInfo& info, const NodeBase* root) /*throw (Core::Root::NoActiveFactory)*/ {
	if (m_single_active_factory.is_nil()) {
		throw Core::Root::NoActiveFactory ("GblAdapterLib::DynamicDocList::ListEntryInfoFactory");
	}
	ListEntryInfo* ret_ = m_single_active_factory->make (info, root);
	GDS_ASSERT_MSG (ret_ != 0, ("GblAdapterLib::DynamicDocList::ListEntryInfoFactory impl can't return zerro"));
	return ret_;
}

ListEntryInfo* ListEntryInfoFactoryManager::make (const GblPilot::ListEntryInfo& info) /*throw (Core::Root::NoActiveFactory)*/ {
	if (m_single_active_factory.is_nil()) {
		throw Core::Root::NoActiveFactory ("GblAdapterLib::DynamicDocList::ListEntryInfoFactory");
	}
	ListEntryInfo* ret_ = m_single_active_factory->make (info);
	GDS_ASSERT_MSG (ret_ != 0, ("GblAdapterLib::DynamicDocList::ListEntryInfoFactory impl can't return zerro"));
	return ret_;
}

//////////////////////////////////////////////////////////////////////////////////////
// implementation of factory manager methods for DynList
bool DynListFactoryManager::s_was_destroyed = false;

DynListFactoryManager::DynListFactoryManager () /*throw (Core::Root::FactoryManagerWasDestroyed)*/
	: m_has_registred_factories(false)
{
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
}

DynListFactoryManager::~DynListFactoryManager () {
	s_was_destroyed = true;
}

void DynListFactoryManager::register_factory (
	DynListAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
	Singleton::instance()->register_factory_i (factory, priority);
}

void DynListFactoryManager::register_factory_i (
	DynListAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey)*/ {
	m_has_registred_factories = true;
	FactoryMap::iterator f = m_factories_map.find(factory->key());
	if (f != m_factories_map.end() && f->second.priority == priority) {
		throw Core::Root::DuplicatedFactoryKey (
			"GblAdapterLib::DynamicDocList::DynListFactory"
			, factory->key()
		);
	}
	if (f == m_factories_map.end() || f->second.priority <= priority) {
		m_factories_map[factory->key()].factory = DynListAbstractFactory::_duplicate(factory);
		m_factories_map[factory->key()].priority = priority;
	}
	
	if (!m_single_active_factory || m_single_active_factory_priority <= priority) {
		m_single_active_factory = DynListAbstractFactory::_duplicate(factory);
		m_single_active_factory_priority = priority;
	}
}

DynList* DynListFactoryManager::make (GblDocList::DocListTree* server_list) /*throw (Core::Root::NoActiveFactory)*/ {
	if (m_single_active_factory.is_nil()) {
		throw Core::Root::NoActiveFactory ("GblAdapterLib::DynamicDocList::DynListFactory");
	}
	DynList* ret_ = m_single_active_factory->make (server_list);
	GDS_ASSERT_MSG (ret_ != 0, ("GblAdapterLib::DynamicDocList::DynListFactory impl can't return zerro"));
	return ret_;
}

DynList* DynListFactoryManager::make (GblPilot::LegalDocument* legal_document, const GblPilotQueryDef::Query& query, DynListType type) /*throw (Core::Root::NoActiveFactory)*/ {
	if (m_single_active_factory.is_nil()) {
		throw Core::Root::NoActiveFactory ("GblAdapterLib::DynamicDocList::DynListFactory");
	}
	DynList* ret_ = m_single_active_factory->make (legal_document, query, type);
	GDS_ASSERT_MSG (ret_ != 0, ("GblAdapterLib::DynamicDocList::DynListFactory impl can't return zerro"));
	return ret_;
}

DynList* DynListFactoryManager::make (SpecialListKey key) /*throw (Core::Root::NoActiveFactory)*/ {
	if (m_single_active_factory.is_nil()) {
		throw Core::Root::NoActiveFactory ("GblAdapterLib::DynamicDocList::DynListFactory");
	}
	DynList* ret_ = m_single_active_factory->make (key);
	GDS_ASSERT_MSG (ret_ != 0, ("GblAdapterLib::DynamicDocList::DynListFactory impl can't return zerro"));
	return ret_;
}

//////////////////////////////////////////////////////////////////////////////////////
// implementation of factory manager methods for SearchDynList
bool SearchDynListFactoryManager::s_was_destroyed = false;

SearchDynListFactoryManager::SearchDynListFactoryManager () /*throw (Core::Root::FactoryManagerWasDestroyed)*/
	: m_has_registred_factories(false)
{
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
}

SearchDynListFactoryManager::~SearchDynListFactoryManager () {
	s_was_destroyed = true;
}

void SearchDynListFactoryManager::register_factory (
	SearchDynListAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
	Singleton::instance()->register_factory_i (factory, priority);
}

void SearchDynListFactoryManager::register_factory_i (
	SearchDynListAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey)*/ {
	m_has_registred_factories = true;
	FactoryMap::iterator f = m_factories_map.find(factory->key());
	if (f != m_factories_map.end() && f->second.priority == priority) {
		throw Core::Root::DuplicatedFactoryKey (
			"GblAdapterLib::DynamicDocList::SearchDynListFactory"
			, factory->key()
		);
	}
	if (f == m_factories_map.end() || f->second.priority <= priority) {
		m_factories_map[factory->key()].factory = SearchDynListAbstractFactory::_duplicate(factory);
		m_factories_map[factory->key()].priority = priority;
	}
	
	if (!m_single_active_factory || m_single_active_factory_priority <= priority) {
		m_single_active_factory = SearchDynListAbstractFactory::_duplicate(factory);
		m_single_active_factory_priority = priority;
	}
}

SearchDynList* SearchDynListFactoryManager::make (GblPilot::SearchDocList* search_doc_list) /*throw (Core::Root::NoActiveFactory)*/ {
	if (m_single_active_factory.is_nil()) {
		throw Core::Root::NoActiveFactory ("GblAdapterLib::DynamicDocList::SearchDynListFactory");
	}
	SearchDynList* ret_ = m_single_active_factory->make (search_doc_list);
	GDS_ASSERT_MSG (ret_ != 0, ("GblAdapterLib::DynamicDocList::SearchDynListFactory impl can't return zerro"));
	return ret_;
}

//////////////////////////////////////////////////////////////////////////////////////
// implementation of factory manager methods for DocListFactory
bool DocListFactoryFactoryManager::s_was_destroyed = false;

DocListFactoryFactoryManager::DocListFactoryFactoryManager () /*throw (Core::Root::FactoryManagerWasDestroyed)*/
	: m_has_registred_factories(false)
{
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
}

DocListFactoryFactoryManager::~DocListFactoryFactoryManager () {
	s_was_destroyed = true;
}

void DocListFactoryFactoryManager::register_factory (
	DocListFactoryAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
	Singleton::instance()->register_factory_i (factory, priority);
}

void DocListFactoryFactoryManager::register_factory_i (
	DocListFactoryAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey)*/ {
	m_has_registred_factories = true;
	FactoryMap::iterator f = m_factories_map.find(factory->key());
	if (f != m_factories_map.end() && f->second.priority == priority) {
		throw Core::Root::DuplicatedFactoryKey (
			"GblAdapterLib::DynamicDocList::DocListFactoryFactory"
			, factory->key()
		);
	}
	if (f == m_factories_map.end() || f->second.priority <= priority) {
		m_factories_map[factory->key()].factory = DocListFactoryAbstractFactory::_duplicate(factory);
		m_factories_map[factory->key()].priority = priority;
	}
	
	if (!m_single_active_factory || m_single_active_factory_priority <= priority) {
		m_single_active_factory = DocListFactoryAbstractFactory::_duplicate(factory);
		m_single_active_factory_priority = priority;
	}
}

DocListFactory* DocListFactoryFactoryManager::make () /*throw (Core::Root::NoActiveFactory)*/ {
	if (m_single_active_factory.is_nil()) {
		throw Core::Root::NoActiveFactory ("GblAdapterLib::DynamicDocList::DocListFactoryFactory");
	}
	DocListFactory* ret_ = m_single_active_factory->make ();
	GDS_ASSERT_MSG (ret_ != 0, ("GblAdapterLib::DynamicDocList::DocListFactoryFactory impl can't return zerro"));
	return ret_;
}

//////////////////////////////////////////////////////////////////////////////////////
// implementation of factory manager methods for DynListNode
bool DynListNodeFactoryManager::s_was_destroyed = false;

DynListNodeFactoryManager::DynListNodeFactoryManager () /*throw (Core::Root::FactoryManagerWasDestroyed)*/
	: m_has_registred_factories(false)
{
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
}

DynListNodeFactoryManager::~DynListNodeFactoryManager () {
	s_was_destroyed = true;
}

void DynListNodeFactoryManager::register_factory (
	DynListNodeAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
	Singleton::instance()->register_factory_i (factory, priority);
}

void DynListNodeFactoryManager::register_factory_i (
	DynListNodeAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey)*/ {
	m_has_registred_factories = true;
	FactoryMap::iterator f = m_factories_map.find(factory->key());
	if (f != m_factories_map.end() && f->second.priority == priority) {
		throw Core::Root::DuplicatedFactoryKey (
			"GblAdapterLib::DynamicDocList::DynListNodeFactory"
			, factory->key()
		);
	}
	if (f == m_factories_map.end() || f->second.priority <= priority) {
		m_factories_map[factory->key()].factory = DynListNodeAbstractFactory::_duplicate(factory);
		m_factories_map[factory->key()].priority = priority;
	}
	
	if (!m_single_active_factory || m_single_active_factory_priority <= priority) {
		m_single_active_factory = DynListNodeAbstractFactory::_duplicate(factory);
		m_single_active_factory_priority = priority;
	}
}

DynListNode* DynListNodeFactoryManager::make (FakeFacetForFactory* owner_tree, const GTree::Node& snode) /*throw (Core::Root::NoActiveFactory)*/ {
	if (m_single_active_factory.is_nil()) {
		throw Core::Root::NoActiveFactory ("GblAdapterLib::DynamicDocList::DynListNodeFactory");
	}
	DynListNode* ret_ = m_single_active_factory->make (owner_tree, snode);
	GDS_ASSERT_MSG (ret_ != 0, ("GblAdapterLib::DynamicDocList::DynListNodeFactory impl can't return zerro"));
	return ret_;
}
} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

