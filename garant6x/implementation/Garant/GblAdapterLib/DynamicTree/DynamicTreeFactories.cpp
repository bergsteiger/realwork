////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/DynamicTree/DynamicTreeFactories.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::DynamicTree
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "boost/bind.hpp"
#include "garant6x/implementation/Garant/GblAdapterLib/DynamicTree/DynamicTreeFactories.h"

namespace GblAdapterLib {


//////////////////////////////////////////////////////////////////////////////////////
// implementation of factory manager methods for SortFilter
bool SortFilterFactoryManager::s_was_destroyed = false;

SortFilterFactoryManager::SortFilterFactoryManager () /*throw (Core::Root::FactoryManagerWasDestroyed)*/
	: m_has_registred_factories(false)
{
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
}

SortFilterFactoryManager::~SortFilterFactoryManager () {
	s_was_destroyed = true;
}

void SortFilterFactoryManager::register_factory (
	SortFilterAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
	Singleton::instance()->register_factory_i (factory, priority);
}

void SortFilterFactoryManager::register_factory_i (
	SortFilterAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey)*/ {
	m_has_registred_factories = true;
	FactoryMap::iterator f = m_factories_map.find(factory->key());
	if (f != m_factories_map.end() && f->second.priority == priority) {
		throw Core::Root::DuplicatedFactoryKey (
			"GblAdapterLib::DynamicTree::SortFilterFactory"
			, factory->key()
		);
	}
	if (f == m_factories_map.end() || f->second.priority <= priority) {
		m_factories_map[factory->key()].factory = SortFilterAbstractFactory::_duplicate(factory);
		m_factories_map[factory->key()].priority = priority;
	}
	
	if (!m_single_active_factory || m_single_active_factory_priority <= priority) {
		m_single_active_factory = SortFilterAbstractFactory::_duplicate(factory);
		m_single_active_factory_priority = priority;
	}
}

SortFilter* SortFilterFactoryManager::make () /*throw (Core::Root::NoActiveFactory)*/ {
	if (m_single_active_factory.is_nil()) {
		throw Core::Root::NoActiveFactory ("GblAdapterLib::DynamicTree::FilterForTreeFactory");
	}
	SortFilter* ret_ = m_single_active_factory->make ();
	GDS_ASSERT_MSG (ret_ != 0, ("GblAdapterLib::DynamicTree::FilterForTreeFactory impl can't return zerro"));
	return ret_;
}

//////////////////////////////////////////////////////////////////////////////////////
// implementation of factory manager methods for TrimFilter
bool TrimFilterFactoryManager::s_was_destroyed = false;

TrimFilterFactoryManager::TrimFilterFactoryManager () /*throw (Core::Root::FactoryManagerWasDestroyed)*/
	: m_has_registred_factories(false)
{
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
}

TrimFilterFactoryManager::~TrimFilterFactoryManager () {
	s_was_destroyed = true;
}

void TrimFilterFactoryManager::register_factory (
	TrimFilterAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
	Singleton::instance()->register_factory_i (factory, priority);
}

void TrimFilterFactoryManager::register_factory_i (
	TrimFilterAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey)*/ {
	m_has_registred_factories = true;
	FactoryMap::iterator f = m_factories_map.find(factory->key());
	if (f != m_factories_map.end() && f->second.priority == priority) {
		throw Core::Root::DuplicatedFactoryKey (
			"GblAdapterLib::DynamicTree::TrimFilterFactory"
			, factory->key()
		);
	}
	if (f == m_factories_map.end() || f->second.priority <= priority) {
		m_factories_map[factory->key()].factory = TrimFilterAbstractFactory::_duplicate(factory);
		m_factories_map[factory->key()].priority = priority;
	}
	
	if (!m_single_active_factory || m_single_active_factory_priority <= priority) {
		m_single_active_factory = TrimFilterAbstractFactory::_duplicate(factory);
		m_single_active_factory_priority = priority;
	}
}

TrimFilter* TrimFilterFactoryManager::make () /*throw (Core::Root::NoActiveFactory)*/ {
	if (m_single_active_factory.is_nil()) {
		throw Core::Root::NoActiveFactory ("GblAdapterLib::DynamicTree::FilterForTreeFactory");
	}
	TrimFilter* ret_ = m_single_active_factory->make ();
	GDS_ASSERT_MSG (ret_ != 0, ("GblAdapterLib::DynamicTree::FilterForTreeFactory impl can't return zerro"));
	return ret_;
}

//////////////////////////////////////////////////////////////////////////////////////
// implementation of factory manager methods for LayerFilter
bool LayerFilterFactoryManager::s_was_destroyed = false;

LayerFilterFactoryManager::LayerFilterFactoryManager () /*throw (Core::Root::FactoryManagerWasDestroyed)*/
	: m_has_registred_factories(false)
{
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
}

LayerFilterFactoryManager::~LayerFilterFactoryManager () {
	s_was_destroyed = true;
}

void LayerFilterFactoryManager::register_factory (
	LayerFilterAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
	Singleton::instance()->register_factory_i (factory, priority);
}

void LayerFilterFactoryManager::register_factory_i (
	LayerFilterAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey)*/ {
	m_has_registred_factories = true;
	FactoryMap::iterator f = m_factories_map.find(factory->key());
	if (f != m_factories_map.end() && f->second.priority == priority) {
		throw Core::Root::DuplicatedFactoryKey (
			"GblAdapterLib::DynamicTree::LayerFilterFactory"
			, factory->key()
		);
	}
	if (f == m_factories_map.end() || f->second.priority <= priority) {
		m_factories_map[factory->key()].factory = LayerFilterAbstractFactory::_duplicate(factory);
		m_factories_map[factory->key()].priority = priority;
	}
	
	if (!m_single_active_factory || m_single_active_factory_priority <= priority) {
		m_single_active_factory = LayerFilterAbstractFactory::_duplicate(factory);
		m_single_active_factory_priority = priority;
	}
}

LayerFilter* LayerFilterFactoryManager::make () /*throw (Core::Root::NoActiveFactory)*/ {
	if (m_single_active_factory.is_nil()) {
		throw Core::Root::NoActiveFactory ("GblAdapterLib::DynamicTree::FilterForTreeFactory");
	}
	LayerFilter* ret_ = m_single_active_factory->make ();
	GDS_ASSERT_MSG (ret_ != 0, ("GblAdapterLib::DynamicTree::FilterForTreeFactory impl can't return zerro"));
	return ret_;
}

//////////////////////////////////////////////////////////////////////////////////////
// implementation of factory manager methods for FindIterator
bool FindIteratorFactoryManager::s_was_destroyed = false;

FindIteratorFactoryManager::FindIteratorFactoryManager () /*throw (Core::Root::FactoryManagerWasDestroyed)*/
	: m_has_registred_factories(false)
{
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
}

FindIteratorFactoryManager::~FindIteratorFactoryManager () {
	s_was_destroyed = true;
}

void FindIteratorFactoryManager::register_factory (
	FindIteratorAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
	Singleton::instance()->register_factory_i (factory, priority);
}

void FindIteratorFactoryManager::register_factory_i (
	FindIteratorAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey)*/ {
	m_has_registred_factories = true;
	FactoryMap::iterator f = m_factories_map.find(factory->key());
	if (f != m_factories_map.end() && f->second.priority == priority) {
		throw Core::Root::DuplicatedFactoryKey (
			"GblAdapterLib::DynamicTree::FindIteratorFactory"
			, factory->key()
		);
	}
	if (f == m_factories_map.end() || f->second.priority <= priority) {
		m_factories_map[factory->key()].factory = FindIteratorAbstractFactory::_duplicate(factory);
		m_factories_map[factory->key()].priority = priority;
	}
	
	if (!m_single_active_factory || m_single_active_factory_priority <= priority) {
		m_single_active_factory = FindIteratorAbstractFactory::_duplicate(factory);
		m_single_active_factory_priority = priority;
	}
}

FindIterator* FindIteratorFactoryManager::make (GTree::FindIterator* iterator) /*throw (Core::Root::NoActiveFactory)*/ {
	if (m_single_active_factory.is_nil()) {
		throw Core::Root::NoActiveFactory ("GblAdapterLib::DynamicTree::FindIteratorFactory");
	}
	FindIterator* ret_ = m_single_active_factory->make (iterator);
	GDS_ASSERT_MSG (ret_ != 0, ("GblAdapterLib::DynamicTree::FindIteratorFactory impl can't return zerro"));
	return ret_;
}


//////////////////////////////////////////////////////////////////////////////////////
// implementation of factory manager methods for NodesClipboard
bool NodesClipboardFactoryManager::s_was_destroyed = false;

NodesClipboardFactoryManager::NodesClipboardFactoryManager () /*throw (Core::Root::FactoryManagerWasDestroyed)*/
	: m_has_registred_factories(false)
{
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
}

NodesClipboardFactoryManager::~NodesClipboardFactoryManager () {
	s_was_destroyed = true;
}

void NodesClipboardFactoryManager::register_factory (
	NodesClipboardAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
	Singleton::instance()->register_factory_i (factory, priority);
}

void NodesClipboardFactoryManager::register_factory_i (
	NodesClipboardAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey)*/ {
	m_has_registred_factories = true;
	FactoryMap::iterator f = m_factories_map.find(factory->key());
	if (f != m_factories_map.end() && f->second.priority == priority) {
		throw Core::Root::DuplicatedFactoryKey (
			"GblAdapterLib::DynamicTree::NodesClipboardFactory"
			, factory->key()
		);
	}
	if (f == m_factories_map.end() || f->second.priority <= priority) {
		m_factories_map[factory->key()].factory = NodesClipboardAbstractFactory::_duplicate(factory);
		m_factories_map[factory->key()].priority = priority;
	}
	
	if (!m_single_active_factory || m_single_active_factory_priority <= priority) {
		m_single_active_factory = NodesClipboardAbstractFactory::_duplicate(factory);
		m_single_active_factory_priority = priority;
	}
}

NodesClipboard* NodesClipboardFactoryManager::make () /*throw (Core::Root::NoActiveFactory)*/ {
	if (m_single_active_factory.is_nil()) {
		throw Core::Root::NoActiveFactory ("GblAdapterLib::DynamicTree::NodesClipboardFactory");
	}
	NodesClipboard* ret_ = m_single_active_factory->make ();
	GDS_ASSERT_MSG (ret_ != 0, ("GblAdapterLib::DynamicTree::NodesClipboardFactory impl can't return zerro"));
	return ret_;
}

NodesClipboard* NodesClipboardFactoryManager::make (GTree::NodeHolder* node_holder) /*throw (Core::Root::NoActiveFactory)*/ {
	if (m_single_active_factory.is_nil()) {
		throw Core::Root::NoActiveFactory ("GblAdapterLib::DynamicTree::NodesClipboardFactory");
	}
	NodesClipboard* ret_ = m_single_active_factory->make (node_holder);
	GDS_ASSERT_MSG (ret_ != 0, ("GblAdapterLib::DynamicTree::NodesClipboardFactory impl can't return zerro"));
	return ret_;
}

//////////////////////////////////////////////////////////////////////////////////////
// implementation of factory manager methods for NodeBase
bool NodeBaseFactoryManager::s_was_destroyed = false;

NodeBaseFactoryManager::NodeBaseFactoryManager () /*throw (Core::Root::FactoryManagerWasDestroyed)*/
	: m_has_registred_factories(false)
{
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
}

NodeBaseFactoryManager::~NodeBaseFactoryManager () {
	s_was_destroyed = true;
}

void NodeBaseFactoryManager::register_factory (
	NodeBaseAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
	Singleton::instance()->register_factory_i (factory, priority);
}

NodeBaseFactory::KeySet* NodeBaseFactoryManager::keys () {
	Core::Aptr<NodeBaseFactory::KeySet> keys (new NodeBaseFactory::KeySet (Singleton::instance()->m_factories_map.size ()));
	
	std::transform (
		Singleton::instance()->m_factories_map.begin ()
		, Singleton::instance()->m_factories_map.end ()
		, std::back_inserter(*keys)
		, boost::bind (&FactoryMap::value_type::first, _1)
	);
	
	return keys.forget ();
}

void NodeBaseFactoryManager::register_factory_i (
	NodeBaseAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey)*/ {
	m_has_registred_factories = true;
	FactoryMap::iterator f = m_factories_map.find(factory->key());
	if (f != m_factories_map.end() && f->second.priority == priority) {
		throw Core::Root::DuplicatedFactoryKey (
			"GblAdapterLib::DynamicTree::NodeBaseFactory"
			, factory->key()
		);
	}
	if (f == m_factories_map.end() || f->second.priority <= priority) {
		m_factories_map[factory->key()].factory = NodeBaseAbstractFactory::_duplicate(factory);
		m_factories_map[factory->key()].priority = priority;
	}
	
	if (!m_single_active_factory || m_single_active_factory_priority <= priority) {
		m_single_active_factory = NodeBaseAbstractFactory::_duplicate(factory);
		m_single_active_factory_priority = priority;
	}
}

NodeBase* NodeBaseFactoryManager::make (const char* key) /*throw (Core::Root::UnknownFactoryKey, CanNotFindData)*/ {
	FactoryMap::iterator f = m_factories_map.find (key);
	if (f == m_factories_map.end()) {
		throw Core::Root::UnknownFactoryKey (
			"GblAdapterLib::DynamicTree::NodeBaseFactory"
			, key
		);
	}
	return f->second.factory->make ();
}

NodeBase* NodeBaseFactoryManager::make (FakeFacetForFactory* owner_tree, const GTree::Node& snode, const char* key) /*throw (Core::Root::UnknownFactoryKey)*/ {
	FactoryMap::iterator f = m_factories_map.find (key);
	if (f == m_factories_map.end()) {
		throw Core::Root::UnknownFactoryKey (
			"GblAdapterLib::DynamicTree::NodeBaseFactory"
			, key
		);
	}
	return f->second.factory->make (owner_tree, snode);
}

//////////////////////////////////////////////////////////////////////////////////////
// implementation of factory manager methods for NodeIterator
bool NodeIteratorFactoryManager::s_was_destroyed = false;

NodeIteratorFactoryManager::NodeIteratorFactoryManager () /*throw (Core::Root::FactoryManagerWasDestroyed)*/
	: m_has_registred_factories(false)
{
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
}

NodeIteratorFactoryManager::~NodeIteratorFactoryManager () {
	s_was_destroyed = true;
}

void NodeIteratorFactoryManager::register_factory (
	NodeIteratorAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
	Singleton::instance()->register_factory_i (factory, priority);
}

void NodeIteratorFactoryManager::register_factory_i (
	NodeIteratorAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey)*/ {
	m_has_registred_factories = true;
	FactoryMap::iterator f = m_factories_map.find(factory->key());
	if (f != m_factories_map.end() && f->second.priority == priority) {
		throw Core::Root::DuplicatedFactoryKey (
			"GblAdapterLib::DynamicTree::NodeIteratorFactory"
			, factory->key()
		);
	}
	if (f == m_factories_map.end() || f->second.priority <= priority) {
		m_factories_map[factory->key()].factory = NodeIteratorAbstractFactory::_duplicate(factory);
		m_factories_map[factory->key()].priority = priority;
	}
	
	if (!m_single_active_factory || m_single_active_factory_priority <= priority) {
		m_single_active_factory = NodeIteratorAbstractFactory::_duplicate(factory);
		m_single_active_factory_priority = priority;
	}
}

NodeIterator* NodeIteratorFactoryManager::make () /*throw (Core::Root::NoActiveFactory)*/ {
	if (m_single_active_factory.is_nil()) {
		throw Core::Root::NoActiveFactory ("GblAdapterLib::DynamicTree::NodeIteratorFactory");
	}
	NodeIterator* ret_ = m_single_active_factory->make ();
	GDS_ASSERT_MSG (ret_ != 0, ("GblAdapterLib::DynamicTree::NodeIteratorFactory impl can't return zerro"));
	return ret_;
}


//////////////////////////////////////////////////////////////////////////////////////
// implementation of factory manager methods for TrimLeafFilter
bool TrimLeafFilterFactoryManager::s_was_destroyed = false;

TrimLeafFilterFactoryManager::TrimLeafFilterFactoryManager () /*throw (Core::Root::FactoryManagerWasDestroyed)*/
	: m_has_registred_factories(false)
{
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
}

TrimLeafFilterFactoryManager::~TrimLeafFilterFactoryManager () {
	s_was_destroyed = true;
}

void TrimLeafFilterFactoryManager::register_factory (
	TrimLeafFilterAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
	Singleton::instance()->register_factory_i (factory, priority);
}

void TrimLeafFilterFactoryManager::register_factory_i (
	TrimLeafFilterAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey)*/ {
	m_has_registred_factories = true;
	FactoryMap::iterator f = m_factories_map.find(factory->key());
	if (f != m_factories_map.end() && f->second.priority == priority) {
		throw Core::Root::DuplicatedFactoryKey (
			"GblAdapterLib::DynamicTree::TrimLeafFilterFactory"
			, factory->key()
		);
	}
	if (f == m_factories_map.end() || f->second.priority <= priority) {
		m_factories_map[factory->key()].factory = TrimLeafFilterAbstractFactory::_duplicate(factory);
		m_factories_map[factory->key()].priority = priority;
	}
	
	if (!m_single_active_factory || m_single_active_factory_priority <= priority) {
		m_single_active_factory = TrimLeafFilterAbstractFactory::_duplicate(factory);
		m_single_active_factory_priority = priority;
	}
}

TrimLeafFilter* TrimLeafFilterFactoryManager::make () /*throw (Core::Root::NoActiveFactory)*/ {
	if (m_single_active_factory.is_nil()) {
		throw Core::Root::NoActiveFactory ("GblAdapterLib::DynamicTree::FilterForTreeFactory");
	}
	TrimLeafFilter* ret_ = m_single_active_factory->make ();
	GDS_ASSERT_MSG (ret_ != 0, ("GblAdapterLib::DynamicTree::FilterForTreeFactory impl can't return zerro"));
	return ret_;
}

//////////////////////////////////////////////////////////////////////////////////////
// implementation of factory manager methods for CountryFilter
bool CountryFilterFactoryManager::s_was_destroyed = false;

CountryFilterFactoryManager::CountryFilterFactoryManager () /*throw (Core::Root::FactoryManagerWasDestroyed)*/
	: m_has_registred_factories(false)
{
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
}

CountryFilterFactoryManager::~CountryFilterFactoryManager () {
	s_was_destroyed = true;
}

void CountryFilterFactoryManager::register_factory (
	CountryFilterAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
	Singleton::instance()->register_factory_i (factory, priority);
}

void CountryFilterFactoryManager::register_factory_i (
	CountryFilterAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey)*/ {
	m_has_registred_factories = true;
	FactoryMap::iterator f = m_factories_map.find(factory->key());
	if (f != m_factories_map.end() && f->second.priority == priority) {
		throw Core::Root::DuplicatedFactoryKey (
			"GblAdapterLib::DynamicTree::CountryFilterFactory"
			, factory->key()
		);
	}
	if (f == m_factories_map.end() || f->second.priority <= priority) {
		m_factories_map[factory->key()].factory = CountryFilterAbstractFactory::_duplicate(factory);
		m_factories_map[factory->key()].priority = priority;
	}
	
	if (!m_single_active_factory || m_single_active_factory_priority <= priority) {
		m_single_active_factory = CountryFilterAbstractFactory::_duplicate(factory);
		m_single_active_factory_priority = priority;
	}
}

CountryFilter* CountryFilterFactoryManager::make (const NodeBase* country) /*throw (Core::Root::NoActiveFactory)*/ {
	if (m_single_active_factory.is_nil()) {
		throw Core::Root::NoActiveFactory ("GblAdapterLib::DynamicTree::CountryFilterFactory");
	}
	CountryFilter* ret_ = m_single_active_factory->make (country);
	GDS_ASSERT_MSG (ret_ != 0, ("GblAdapterLib::DynamicTree::CountryFilterFactory impl can't return zerro"));
	return ret_;
}

CountryFilter* CountryFilterFactoryManager::make () /*throw (Core::Root::NoActiveFactory)*/ {
	if (m_single_active_factory.is_nil()) {
		throw Core::Root::NoActiveFactory ("GblAdapterLib::DynamicTree::FilterForTreeFactory");
	}
	CountryFilter* ret_ = m_single_active_factory->make ();
	GDS_ASSERT_MSG (ret_ != 0, ("GblAdapterLib::DynamicTree::FilterForTreeFactory impl can't return zerro"));
	return ret_;
}

//////////////////////////////////////////////////////////////////////////////////////
// implementation of factory manager methods for CutToLeafCountFilter
bool CutToLeafCountFilterFactoryManager::s_was_destroyed = false;

CutToLeafCountFilterFactoryManager::CutToLeafCountFilterFactoryManager () /*throw (Core::Root::FactoryManagerWasDestroyed)*/
	: m_has_registred_factories(false)
{
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
}

CutToLeafCountFilterFactoryManager::~CutToLeafCountFilterFactoryManager () {
	s_was_destroyed = true;
}

void CutToLeafCountFilterFactoryManager::register_factory (
	CutToLeafCountFilterAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
	Singleton::instance()->register_factory_i (factory, priority);
}

void CutToLeafCountFilterFactoryManager::register_factory_i (
	CutToLeafCountFilterAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey)*/ {
	m_has_registred_factories = true;
	FactoryMap::iterator f = m_factories_map.find(factory->key());
	if (f != m_factories_map.end() && f->second.priority == priority) {
		throw Core::Root::DuplicatedFactoryKey (
			"GblAdapterLib::DynamicTree::CutToLeafCountFilterFactory"
			, factory->key()
		);
	}
	if (f == m_factories_map.end() || f->second.priority <= priority) {
		m_factories_map[factory->key()].factory = CutToLeafCountFilterAbstractFactory::_duplicate(factory);
		m_factories_map[factory->key()].priority = priority;
	}
	
	if (!m_single_active_factory || m_single_active_factory_priority <= priority) {
		m_single_active_factory = CutToLeafCountFilterAbstractFactory::_duplicate(factory);
		m_single_active_factory_priority = priority;
	}
}

CutToLeafCountFilter* CutToLeafCountFilterFactoryManager::make (unsigned long leaf_count) /*throw (Core::Root::NoActiveFactory)*/ {
	if (m_single_active_factory.is_nil()) {
		throw Core::Root::NoActiveFactory ("GblAdapterLib::DynamicTree::CutToLeafCountFilterFactory");
	}
	CutToLeafCountFilter* ret_ = m_single_active_factory->make (leaf_count);
	GDS_ASSERT_MSG (ret_ != 0, ("GblAdapterLib::DynamicTree::CutToLeafCountFilterFactory impl can't return zerro"));
	return ret_;
}

CutToLeafCountFilter* CutToLeafCountFilterFactoryManager::make () /*throw (Core::Root::NoActiveFactory)*/ {
	if (m_single_active_factory.is_nil()) {
		throw Core::Root::NoActiveFactory ("GblAdapterLib::DynamicTree::FilterForTreeFactory");
	}
	CutToLeafCountFilter* ret_ = m_single_active_factory->make ();
	GDS_ASSERT_MSG (ret_ != 0, ("GblAdapterLib::DynamicTree::FilterForTreeFactory impl can't return zerro"));
	return ret_;
}

//////////////////////////////////////////////////////////////////////////////////////
// implementation of factory manager methods for BlocksFilter
bool BlocksFilterFactoryManager::s_was_destroyed = false;

BlocksFilterFactoryManager::BlocksFilterFactoryManager () /*throw (Core::Root::FactoryManagerWasDestroyed)*/
	: m_has_registred_factories(false)
{
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
}

BlocksFilterFactoryManager::~BlocksFilterFactoryManager () {
	s_was_destroyed = true;
}

void BlocksFilterFactoryManager::register_factory (
	BlocksFilterAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
	Singleton::instance()->register_factory_i (factory, priority);
}

void BlocksFilterFactoryManager::register_factory_i (
	BlocksFilterAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey)*/ {
	m_has_registred_factories = true;
	FactoryMap::iterator f = m_factories_map.find(factory->key());
	if (f != m_factories_map.end() && f->second.priority == priority) {
		throw Core::Root::DuplicatedFactoryKey (
			"GblAdapterLib::DynamicTree::BlocksFilterFactory"
			, factory->key()
		);
	}
	if (f == m_factories_map.end() || f->second.priority <= priority) {
		m_factories_map[factory->key()].factory = BlocksFilterAbstractFactory::_duplicate(factory);
		m_factories_map[factory->key()].priority = priority;
	}
	
	if (!m_single_active_factory || m_single_active_factory_priority <= priority) {
		m_single_active_factory = BlocksFilterAbstractFactory::_duplicate(factory);
		m_single_active_factory_priority = priority;
	}
}

BlocksFilter* BlocksFilterFactoryManager::make () /*throw (Core::Root::NoActiveFactory)*/ {
	if (m_single_active_factory.is_nil()) {
		throw Core::Root::NoActiveFactory ("GblAdapterLib::DynamicTree::FilterForTreeFactory");
	}
	BlocksFilter* ret_ = m_single_active_factory->make ();
	GDS_ASSERT_MSG (ret_ != 0, ("GblAdapterLib::DynamicTree::FilterForTreeFactory impl can't return zerro"));
	return ret_;
}

//////////////////////////////////////////////////////////////////////////////////////
// implementation of factory manager methods for InpharmFilter
bool InpharmFilterFactoryManager::s_was_destroyed = false;

InpharmFilterFactoryManager::InpharmFilterFactoryManager () /*throw (Core::Root::FactoryManagerWasDestroyed)*/
	: m_has_registred_factories(false)
{
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
}

InpharmFilterFactoryManager::~InpharmFilterFactoryManager () {
	s_was_destroyed = true;
}

void InpharmFilterFactoryManager::register_factory (
	InpharmFilterAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
	Singleton::instance()->register_factory_i (factory, priority);
}

void InpharmFilterFactoryManager::register_factory_i (
	InpharmFilterAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey)*/ {
	m_has_registred_factories = true;
	FactoryMap::iterator f = m_factories_map.find(factory->key());
	if (f != m_factories_map.end() && f->second.priority == priority) {
		throw Core::Root::DuplicatedFactoryKey (
			"GblAdapterLib::DynamicTree::InpharmFilterFactory"
			, factory->key()
		);
	}
	if (f == m_factories_map.end() || f->second.priority <= priority) {
		m_factories_map[factory->key()].factory = InpharmFilterAbstractFactory::_duplicate(factory);
		m_factories_map[factory->key()].priority = priority;
	}
	
	if (!m_single_active_factory || m_single_active_factory_priority <= priority) {
		m_single_active_factory = InpharmFilterAbstractFactory::_duplicate(factory);
		m_single_active_factory_priority = priority;
	}
}

InpharmFilter* InpharmFilterFactoryManager::make () /*throw (Core::Root::NoActiveFactory)*/ {
	if (m_single_active_factory.is_nil()) {
		throw Core::Root::NoActiveFactory ("GblAdapterLib::DynamicTree::FilterForTreeFactory");
	}
	InpharmFilter* ret_ = m_single_active_factory->make ();
	GDS_ASSERT_MSG (ret_ != 0, ("GblAdapterLib::DynamicTree::FilterForTreeFactory impl can't return zerro"));
	return ret_;
}

//////////////////////////////////////////////////////////////////////////////////////
// implementation of factory manager methods for VariantsForDocFilter
bool VariantsForDocFilterFactoryManager::s_was_destroyed = false;

VariantsForDocFilterFactoryManager::VariantsForDocFilterFactoryManager () /*throw (Core::Root::FactoryManagerWasDestroyed)*/
	: m_has_registred_factories(false)
{
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
}

VariantsForDocFilterFactoryManager::~VariantsForDocFilterFactoryManager () {
	s_was_destroyed = true;
}

void VariantsForDocFilterFactoryManager::register_factory (
	VariantsForDocFilterAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
	Singleton::instance()->register_factory_i (factory, priority);
}

void VariantsForDocFilterFactoryManager::register_factory_i (
	VariantsForDocFilterAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey)*/ {
	m_has_registred_factories = true;
	FactoryMap::iterator f = m_factories_map.find(factory->key());
	if (f != m_factories_map.end() && f->second.priority == priority) {
		throw Core::Root::DuplicatedFactoryKey (
			"GblAdapterLib::DynamicTree::VariantsForDocFilterFactory"
			, factory->key()
		);
	}
	if (f == m_factories_map.end() || f->second.priority <= priority) {
		m_factories_map[factory->key()].factory = VariantsForDocFilterAbstractFactory::_duplicate(factory);
		m_factories_map[factory->key()].priority = priority;
	}
	
	if (!m_single_active_factory || m_single_active_factory_priority <= priority) {
		m_single_active_factory = VariantsForDocFilterAbstractFactory::_duplicate(factory);
		m_single_active_factory_priority = priority;
	}
}

VariantsForDocFilter* VariantsForDocFilterFactoryManager::make (unsigned long doc_id) /*throw (Core::Root::NoActiveFactory)*/ {
	if (m_single_active_factory.is_nil()) {
		throw Core::Root::NoActiveFactory ("GblAdapterLib::DynamicTree::VariantsForDocFilterFactory");
	}
	VariantsForDocFilter* ret_ = m_single_active_factory->make (doc_id);
	GDS_ASSERT_MSG (ret_ != 0, ("GblAdapterLib::DynamicTree::VariantsForDocFilterFactory impl can't return zerro"));
	return ret_;
}

VariantsForDocFilter* VariantsForDocFilterFactoryManager::make () /*throw (Core::Root::NoActiveFactory)*/ {
	if (m_single_active_factory.is_nil()) {
		throw Core::Root::NoActiveFactory ("GblAdapterLib::DynamicTree::FilterForTreeFactory");
	}
	VariantsForDocFilter* ret_ = m_single_active_factory->make ();
	GDS_ASSERT_MSG (ret_ != 0, ("GblAdapterLib::DynamicTree::FilterForTreeFactory impl can't return zerro"));
	return ret_;
}

//////////////////////////////////////////////////////////////////////////////////////
// implementation of factory manager methods for ContextFilter
bool ContextFilterFactoryManager::s_was_destroyed = false;

ContextFilterFactoryManager::ContextFilterFactoryManager () /*throw (Core::Root::FactoryManagerWasDestroyed)*/
	: m_has_registred_factories(false)
{
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
}

ContextFilterFactoryManager::~ContextFilterFactoryManager () {
	s_was_destroyed = true;
}

void ContextFilterFactoryManager::register_factory (
	ContextFilterAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
	Singleton::instance()->register_factory_i (factory, priority);
}

void ContextFilterFactoryManager::register_factory_i (
	ContextFilterAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey)*/ {
	m_has_registred_factories = true;
	FactoryMap::iterator f = m_factories_map.find(factory->key());
	if (f != m_factories_map.end() && f->second.priority == priority) {
		throw Core::Root::DuplicatedFactoryKey (
			"GblAdapterLib::DynamicTree::ContextFilterFactory"
			, factory->key()
		);
	}
	if (f == m_factories_map.end() || f->second.priority <= priority) {
		m_factories_map[factory->key()].factory = ContextFilterAbstractFactory::_duplicate(factory);
		m_factories_map[factory->key()].priority = priority;
	}
	
	if (!m_single_active_factory || m_single_active_factory_priority <= priority) {
		m_single_active_factory = ContextFilterAbstractFactory::_duplicate(factory);
		m_single_active_factory_priority = priority;
	}
}

ContextFilter* ContextFilterFactoryManager::make () /*throw (Core::Root::NoActiveFactory)*/ {
	if (m_single_active_factory.is_nil()) {
		throw Core::Root::NoActiveFactory ("GblAdapterLib::DynamicTree::FilterForTreeFactory");
	}
	ContextFilter* ret_ = m_single_active_factory->make ();
	GDS_ASSERT_MSG (ret_ != 0, ("GblAdapterLib::DynamicTree::FilterForTreeFactory impl can't return zerro"));
	return ret_;
}
} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

