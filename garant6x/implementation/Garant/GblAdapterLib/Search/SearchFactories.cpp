////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/Search/SearchFactories.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::Search
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "boost/bind.hpp"
#include "garant6x/implementation/Garant/GblAdapterLib/Search/SearchFactories.h"

namespace GblAdapterLib {


//////////////////////////////////////////////////////////////////////////////////////
// implementation of factory manager methods for QueryPhoneNumberAttribute
bool QueryPhoneNumberAttributeFactoryManager::s_was_destroyed = false;

QueryPhoneNumberAttributeFactoryManager::QueryPhoneNumberAttributeFactoryManager () /*throw (Core::Root::FactoryManagerWasDestroyed)*/
	: m_has_registred_factories(false)
{
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
}

QueryPhoneNumberAttributeFactoryManager::~QueryPhoneNumberAttributeFactoryManager () {
	s_was_destroyed = true;
}

void QueryPhoneNumberAttributeFactoryManager::register_factory (
	QueryPhoneNumberAttributeAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
	Singleton::instance()->register_factory_i (factory, priority);
}

void QueryPhoneNumberAttributeFactoryManager::register_factory_i (
	QueryPhoneNumberAttributeAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey)*/ {
	m_has_registred_factories = true;
	FactoryMap::iterator f = m_factories_map.find(factory->key());
	if (f != m_factories_map.end() && f->second.priority == priority) {
		throw Core::Root::DuplicatedFactoryKey (
			"GblAdapterLib::Search::QueryPhoneNumberAttributeFactory"
			, factory->key()
		);
	}
	if (f == m_factories_map.end() || f->second.priority <= priority) {
		m_factories_map[factory->key()].factory = QueryPhoneNumberAttributeAbstractFactory::_duplicate(factory);
		m_factories_map[factory->key()].priority = priority;
	}
	
	if (!m_single_active_factory || m_single_active_factory_priority <= priority) {
		m_single_active_factory = QueryPhoneNumberAttributeAbstractFactory::_duplicate(factory);
		m_single_active_factory_priority = priority;
	}
}

QueryPhoneNumberAttribute* QueryPhoneNumberAttributeFactoryManager::make (AttributeTag_const attribute_tag) /*throw (Core::Root::NoActiveFactory)*/ {
	if (m_single_active_factory.is_nil()) {
		throw Core::Root::NoActiveFactory ("GblAdapterLib::Search::QueryPhoneNumberAttributeFactory");
	}
	QueryPhoneNumberAttribute* ret_ = m_single_active_factory->make (attribute_tag);
	GDS_ASSERT_MSG (ret_ != 0, ("GblAdapterLib::Search::QueryPhoneNumberAttributeFactory impl can't return zerro"));
	return ret_;
}

//////////////////////////////////////////////////////////////////////////////////////
// implementation of factory manager methods for QueryDateAttribute
bool QueryDateAttributeFactoryManager::s_was_destroyed = false;

QueryDateAttributeFactoryManager::QueryDateAttributeFactoryManager () /*throw (Core::Root::FactoryManagerWasDestroyed)*/
	: m_has_registred_factories(false)
{
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
}

QueryDateAttributeFactoryManager::~QueryDateAttributeFactoryManager () {
	s_was_destroyed = true;
}

void QueryDateAttributeFactoryManager::register_factory (
	QueryDateAttributeAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
	Singleton::instance()->register_factory_i (factory, priority);
}

void QueryDateAttributeFactoryManager::register_factory_i (
	QueryDateAttributeAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey)*/ {
	m_has_registred_factories = true;
	FactoryMap::iterator f = m_factories_map.find(factory->key());
	if (f != m_factories_map.end() && f->second.priority == priority) {
		throw Core::Root::DuplicatedFactoryKey (
			"GblAdapterLib::Search::QueryDateAttributeFactory"
			, factory->key()
		);
	}
	if (f == m_factories_map.end() || f->second.priority <= priority) {
		m_factories_map[factory->key()].factory = QueryDateAttributeAbstractFactory::_duplicate(factory);
		m_factories_map[factory->key()].priority = priority;
	}
	
	if (!m_single_active_factory || m_single_active_factory_priority <= priority) {
		m_single_active_factory = QueryDateAttributeAbstractFactory::_duplicate(factory);
		m_single_active_factory_priority = priority;
	}
}

QueryDateAttribute* QueryDateAttributeFactoryManager::make (AttributeTag_const attribute_tag) /*throw (Core::Root::NoActiveFactory)*/ {
	if (m_single_active_factory.is_nil()) {
		throw Core::Root::NoActiveFactory ("GblAdapterLib::Search::QueryDateAttributeFactory");
	}
	QueryDateAttribute* ret_ = m_single_active_factory->make (attribute_tag);
	GDS_ASSERT_MSG (ret_ != 0, ("GblAdapterLib::Search::QueryDateAttributeFactory impl can't return zerro"));
	return ret_;
}

//////////////////////////////////////////////////////////////////////////////////////
// implementation of factory manager methods for QueryNodeAttribute
bool QueryNodeAttributeFactoryManager::s_was_destroyed = false;

QueryNodeAttributeFactoryManager::QueryNodeAttributeFactoryManager () /*throw (Core::Root::FactoryManagerWasDestroyed)*/
	: m_has_registred_factories(false)
{
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
}

QueryNodeAttributeFactoryManager::~QueryNodeAttributeFactoryManager () {
	s_was_destroyed = true;
}

void QueryNodeAttributeFactoryManager::register_factory (
	QueryNodeAttributeAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
	Singleton::instance()->register_factory_i (factory, priority);
}

void QueryNodeAttributeFactoryManager::register_factory_i (
	QueryNodeAttributeAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey)*/ {
	m_has_registred_factories = true;
	FactoryMap::iterator f = m_factories_map.find(factory->key());
	if (f != m_factories_map.end() && f->second.priority == priority) {
		throw Core::Root::DuplicatedFactoryKey (
			"GblAdapterLib::Search::QueryNodeAttributeFactory"
			, factory->key()
		);
	}
	if (f == m_factories_map.end() || f->second.priority <= priority) {
		m_factories_map[factory->key()].factory = QueryNodeAttributeAbstractFactory::_duplicate(factory);
		m_factories_map[factory->key()].priority = priority;
	}
	
	if (!m_single_active_factory || m_single_active_factory_priority <= priority) {
		m_single_active_factory = QueryNodeAttributeAbstractFactory::_duplicate(factory);
		m_single_active_factory_priority = priority;
	}
}

QueryNodeAttribute* QueryNodeAttributeFactoryManager::make (AttributeTag_const attribute_tag) /*throw (Core::Root::NoActiveFactory)*/ {
	if (m_single_active_factory.is_nil()) {
		throw Core::Root::NoActiveFactory ("GblAdapterLib::Search::QueryNodeAttributeFactory");
	}
	QueryNodeAttribute* ret_ = m_single_active_factory->make (attribute_tag);
	GDS_ASSERT_MSG (ret_ != 0, ("GblAdapterLib::Search::QueryNodeAttributeFactory impl can't return zerro"));
	return ret_;
}

//////////////////////////////////////////////////////////////////////////////////////
// implementation of factory manager methods for QueryContextAttribute
bool QueryContextAttributeFactoryManager::s_was_destroyed = false;

QueryContextAttributeFactoryManager::QueryContextAttributeFactoryManager () /*throw (Core::Root::FactoryManagerWasDestroyed)*/
	: m_has_registred_factories(false)
{
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
}

QueryContextAttributeFactoryManager::~QueryContextAttributeFactoryManager () {
	s_was_destroyed = true;
}

void QueryContextAttributeFactoryManager::register_factory (
	QueryContextAttributeAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
	Singleton::instance()->register_factory_i (factory, priority);
}

void QueryContextAttributeFactoryManager::register_factory_i (
	QueryContextAttributeAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey)*/ {
	m_has_registred_factories = true;
	FactoryMap::iterator f = m_factories_map.find(factory->key());
	if (f != m_factories_map.end() && f->second.priority == priority) {
		throw Core::Root::DuplicatedFactoryKey (
			"GblAdapterLib::Search::QueryContextAttributeFactory"
			, factory->key()
		);
	}
	if (f == m_factories_map.end() || f->second.priority <= priority) {
		m_factories_map[factory->key()].factory = QueryContextAttributeAbstractFactory::_duplicate(factory);
		m_factories_map[factory->key()].priority = priority;
	}
	
	if (!m_single_active_factory || m_single_active_factory_priority <= priority) {
		m_single_active_factory = QueryContextAttributeAbstractFactory::_duplicate(factory);
		m_single_active_factory_priority = priority;
	}
}

QueryContextAttribute* QueryContextAttributeFactoryManager::make (AttributeTag_const attribute_tag) /*throw (Core::Root::NoActiveFactory)*/ {
	if (m_single_active_factory.is_nil()) {
		throw Core::Root::NoActiveFactory ("GblAdapterLib::Search::QueryContextAttributeFactory");
	}
	QueryContextAttribute* ret_ = m_single_active_factory->make (attribute_tag);
	GDS_ASSERT_MSG (ret_ != 0, ("GblAdapterLib::Search::QueryContextAttributeFactory impl can't return zerro"));
	return ret_;
}

//////////////////////////////////////////////////////////////////////////////////////
// implementation of factory manager methods for AttributeInfo
bool AttributeInfoFactoryManager::s_was_destroyed = false;

AttributeInfoFactoryManager::AttributeInfoFactoryManager () /*throw (Core::Root::FactoryManagerWasDestroyed)*/
	: m_has_registred_factories(false)
{
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
}

AttributeInfoFactoryManager::~AttributeInfoFactoryManager () {
	s_was_destroyed = true;
}

void AttributeInfoFactoryManager::register_factory (
	AttributeInfoAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
	Singleton::instance()->register_factory_i (factory, priority);
}

void AttributeInfoFactoryManager::register_factory_i (
	AttributeInfoAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey)*/ {
	m_has_registred_factories = true;
	FactoryMap::iterator f = m_factories_map.find(factory->key());
	if (f != m_factories_map.end() && f->second.priority == priority) {
		throw Core::Root::DuplicatedFactoryKey (
			"GblAdapterLib::Search::AttributeInfoFactory"
			, factory->key()
		);
	}
	if (f == m_factories_map.end() || f->second.priority <= priority) {
		m_factories_map[factory->key()].factory = AttributeInfoAbstractFactory::_duplicate(factory);
		m_factories_map[factory->key()].priority = priority;
	}
	
	if (!m_single_active_factory || m_single_active_factory_priority <= priority) {
		m_single_active_factory = AttributeInfoAbstractFactory::_duplicate(factory);
		m_single_active_factory_priority = priority;
	}
}

AttributeInfo* AttributeInfoFactoryManager::make (AttributeTag_const tag) /*throw (Core::Root::NoActiveFactory)*/ {
	if (m_single_active_factory.is_nil()) {
		throw Core::Root::NoActiveFactory ("GblAdapterLib::Search::AttributeInfoFactory");
	}
	AttributeInfo* ret_ = m_single_active_factory->make (tag);
	GDS_ASSERT_MSG (ret_ != 0, ("GblAdapterLib::Search::AttributeInfoFactory impl can't return zerro"));
	return ret_;
}

//////////////////////////////////////////////////////////////////////////////////////
// implementation of factory manager methods for Query
bool QueryFactoryManager::s_was_destroyed = false;

QueryFactoryManager::QueryFactoryManager () /*throw (Core::Root::FactoryManagerWasDestroyed)*/
	: m_has_registred_factories(false)
{
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
}

QueryFactoryManager::~QueryFactoryManager () {
	s_was_destroyed = true;
}

void QueryFactoryManager::register_factory (
	QueryAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
	Singleton::instance()->register_factory_i (factory, priority);
}

void QueryFactoryManager::register_factory_i (
	QueryAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey)*/ {
	m_has_registred_factories = true;
	FactoryMap::iterator f = m_factories_map.find(factory->key());
	if (f != m_factories_map.end() && f->second.priority == priority) {
		throw Core::Root::DuplicatedFactoryKey (
			"GblAdapterLib::Search::QueryFactory"
			, factory->key()
		);
	}
	if (f == m_factories_map.end() || f->second.priority <= priority) {
		m_factories_map[factory->key()].factory = QueryAbstractFactory::_duplicate(factory);
		m_factories_map[factory->key()].priority = priority;
	}
	
	if (!m_single_active_factory || m_single_active_factory_priority <= priority) {
		m_single_active_factory = QueryAbstractFactory::_duplicate(factory);
		m_single_active_factory_priority = priority;
	}
}

Query* QueryFactoryManager::make (QueryType type) /*throw (Core::Root::NoActiveFactory)*/ {
	if (m_single_active_factory.is_nil()) {
		throw Core::Root::NoActiveFactory ("GblAdapterLib::Search::QueryFactory");
	}
	Query* ret_ = m_single_active_factory->make (type);
	GDS_ASSERT_MSG (ret_ != 0, ("GblAdapterLib::Search::QueryFactory impl can't return zerro"));
	return ret_;
}

//////////////////////////////////////////////////////////////////////////////////////
// implementation of factory manager methods for Search
bool SearchFactoryManager::s_was_destroyed = false;

SearchFactoryManager::SearchFactoryManager () /*throw (Core::Root::FactoryManagerWasDestroyed)*/
	: m_has_registred_factories(false)
{
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
}

SearchFactoryManager::~SearchFactoryManager () {
	s_was_destroyed = true;
}

void SearchFactoryManager::register_factory (
	SearchAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
	Singleton::instance()->register_factory_i (factory, priority);
}

void SearchFactoryManager::register_factory_i (
	SearchAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey)*/ {
	m_has_registred_factories = true;
	FactoryMap::iterator f = m_factories_map.find(factory->key());
	if (f != m_factories_map.end() && f->second.priority == priority) {
		throw Core::Root::DuplicatedFactoryKey (
			"GblAdapterLib::Search::SearchFactory"
			, factory->key()
		);
	}
	if (f == m_factories_map.end() || f->second.priority <= priority) {
		m_factories_map[factory->key()].factory = SearchAbstractFactory::_duplicate(factory);
		m_factories_map[factory->key()].priority = priority;
	}
	
	if (!m_single_active_factory || m_single_active_factory_priority <= priority) {
		m_single_active_factory = SearchAbstractFactory::_duplicate(factory);
		m_single_active_factory_priority = priority;
	}
}

Search* SearchFactoryManager::make () /*throw (Core::Root::NoActiveFactory)*/ {
	if (m_single_active_factory.is_nil()) {
		throw Core::Root::NoActiveFactory ("GblAdapterLib::Search::SearchFactory");
	}
	Search* ret_ = m_single_active_factory->make ();
	GDS_ASSERT_MSG (ret_ != 0, ("GblAdapterLib::Search::SearchFactory impl can't return zerro"));
	return ret_;
}

//////////////////////////////////////////////////////////////////////////////////////
// implementation of factory manager methods for QueryCreator
bool QueryCreatorFactoryManager::s_was_destroyed = false;

QueryCreatorFactoryManager::QueryCreatorFactoryManager () /*throw (Core::Root::FactoryManagerWasDestroyed)*/
	: m_has_registred_factories(false)
{
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
}

QueryCreatorFactoryManager::~QueryCreatorFactoryManager () {
	s_was_destroyed = true;
}

void QueryCreatorFactoryManager::register_factory (
	QueryCreatorAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
	Singleton::instance()->register_factory_i (factory, priority);
}

void QueryCreatorFactoryManager::register_factory_i (
	QueryCreatorAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey)*/ {
	m_has_registred_factories = true;
	FactoryMap::iterator f = m_factories_map.find(factory->key());
	if (f != m_factories_map.end() && f->second.priority == priority) {
		throw Core::Root::DuplicatedFactoryKey (
			"GblAdapterLib::Search::QueryCreatorFactory"
			, factory->key()
		);
	}
	if (f == m_factories_map.end() || f->second.priority <= priority) {
		m_factories_map[factory->key()].factory = QueryCreatorAbstractFactory::_duplicate(factory);
		m_factories_map[factory->key()].priority = priority;
	}
	
	if (!m_single_active_factory || m_single_active_factory_priority <= priority) {
		m_single_active_factory = QueryCreatorAbstractFactory::_duplicate(factory);
		m_single_active_factory_priority = priority;
	}
}

QueryCreator* QueryCreatorFactoryManager::make () /*throw (Core::Root::NoActiveFactory)*/ {
	if (m_single_active_factory.is_nil()) {
		throw Core::Root::NoActiveFactory ("GblAdapterLib::Search::QueryCreatorFactory");
	}
	QueryCreator* ret_ = m_single_active_factory->make ();
	GDS_ASSERT_MSG (ret_ != 0, ("GblAdapterLib::Search::QueryCreatorFactory impl can't return zerro"));
	return ret_;
}

//////////////////////////////////////////////////////////////////////////////////////
// implementation of factory manager methods for FiltersQuery
bool FiltersQueryFactoryManager::s_was_destroyed = false;

FiltersQueryFactoryManager::FiltersQueryFactoryManager () /*throw (Core::Root::FactoryManagerWasDestroyed)*/
	: m_has_registred_factories(false)
{
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
}

FiltersQueryFactoryManager::~FiltersQueryFactoryManager () {
	s_was_destroyed = true;
}

void FiltersQueryFactoryManager::register_factory (
	FiltersQueryAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
	Singleton::instance()->register_factory_i (factory, priority);
}

void FiltersQueryFactoryManager::register_factory_i (
	FiltersQueryAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey)*/ {
	m_has_registred_factories = true;
	FactoryMap::iterator f = m_factories_map.find(factory->key());
	if (f != m_factories_map.end() && f->second.priority == priority) {
		throw Core::Root::DuplicatedFactoryKey (
			"GblAdapterLib::Search::FiltersQueryFactory"
			, factory->key()
		);
	}
	if (f == m_factories_map.end() || f->second.priority <= priority) {
		m_factories_map[factory->key()].factory = FiltersQueryAbstractFactory::_duplicate(factory);
		m_factories_map[factory->key()].priority = priority;
	}
	
	if (!m_single_active_factory || m_single_active_factory_priority <= priority) {
		m_single_active_factory = FiltersQueryAbstractFactory::_duplicate(factory);
		m_single_active_factory_priority = priority;
	}
}

FiltersQuery* FiltersQueryFactoryManager::make (FilterFromQuery* filter) /*throw (Core::Root::NoActiveFactory)*/ {
	if (m_single_active_factory.is_nil()) {
		throw Core::Root::NoActiveFactory ("GblAdapterLib::Search::FiltersQueryFactory");
	}
	FiltersQuery* ret_ = m_single_active_factory->make (filter);
	GDS_ASSERT_MSG (ret_ != 0, ("GblAdapterLib::Search::FiltersQueryFactory impl can't return zerro"));
	return ret_;
}

//////////////////////////////////////////////////////////////////////////////////////
// implementation of factory manager methods for AdapterFiltersQuery
bool AdapterFiltersQueryFactoryManager::s_was_destroyed = false;

AdapterFiltersQueryFactoryManager::AdapterFiltersQueryFactoryManager () /*throw (Core::Root::FactoryManagerWasDestroyed)*/
	: m_has_registred_factories(false)
{
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
}

AdapterFiltersQueryFactoryManager::~AdapterFiltersQueryFactoryManager () {
	s_was_destroyed = true;
}

void AdapterFiltersQueryFactoryManager::register_factory (
	AdapterFiltersQueryAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
	Singleton::instance()->register_factory_i (factory, priority);
}

void AdapterFiltersQueryFactoryManager::register_factory_i (
	AdapterFiltersQueryAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey)*/ {
	m_has_registred_factories = true;
	FactoryMap::iterator f = m_factories_map.find(factory->key());
	if (f != m_factories_map.end() && f->second.priority == priority) {
		throw Core::Root::DuplicatedFactoryKey (
			"GblAdapterLib::Search::AdapterFiltersQueryFactory"
			, factory->key()
		);
	}
	if (f == m_factories_map.end() || f->second.priority <= priority) {
		m_factories_map[factory->key()].factory = AdapterFiltersQueryAbstractFactory::_duplicate(factory);
		m_factories_map[factory->key()].priority = priority;
	}
	
	if (!m_single_active_factory || m_single_active_factory_priority <= priority) {
		m_single_active_factory = AdapterFiltersQueryAbstractFactory::_duplicate(factory);
		m_single_active_factory_priority = priority;
	}
}

AdapterFiltersQuery* AdapterFiltersQueryFactoryManager::make (QueryType type) /*throw (Core::Root::NoActiveFactory)*/ {
	if (m_single_active_factory.is_nil()) {
		throw Core::Root::NoActiveFactory ("GblAdapterLib::Search::AdapterFiltersQueryFactory");
	}
	AdapterFiltersQuery* ret_ = m_single_active_factory->make (type);
	GDS_ASSERT_MSG (ret_ != 0, ("GblAdapterLib::Search::AdapterFiltersQueryFactory impl can't return zerro"));
	return ret_;
}

//////////////////////////////////////////////////////////////////////////////////////
// implementation of factory manager methods for FullAttributeInfo
bool FullAttributeInfoFactoryManager::s_was_destroyed = false;

FullAttributeInfoFactoryManager::FullAttributeInfoFactoryManager () /*throw (Core::Root::FactoryManagerWasDestroyed)*/
	: m_has_registred_factories(false)
{
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
}

FullAttributeInfoFactoryManager::~FullAttributeInfoFactoryManager () {
	s_was_destroyed = true;
}

void FullAttributeInfoFactoryManager::register_factory (
	FullAttributeInfoAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
	Singleton::instance()->register_factory_i (factory, priority);
}

void FullAttributeInfoFactoryManager::register_factory_i (
	FullAttributeInfoAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey)*/ {
	m_has_registred_factories = true;
	FactoryMap::iterator f = m_factories_map.find(factory->key());
	if (f != m_factories_map.end() && f->second.priority == priority) {
		throw Core::Root::DuplicatedFactoryKey (
			"GblAdapterLib::Search::FullAttributeInfoFactory"
			, factory->key()
		);
	}
	if (f == m_factories_map.end() || f->second.priority <= priority) {
		m_factories_map[factory->key()].factory = FullAttributeInfoAbstractFactory::_duplicate(factory);
		m_factories_map[factory->key()].priority = priority;
	}
	
	if (!m_single_active_factory || m_single_active_factory_priority <= priority) {
		m_single_active_factory = FullAttributeInfoAbstractFactory::_duplicate(factory);
		m_single_active_factory_priority = priority;
	}
}

FullAttributeInfo* FullAttributeInfoFactoryManager::make (const GblPilotQueryDef::FullAttributeInfo& full_info) /*throw (Core::Root::NoActiveFactory)*/ {
	if (m_single_active_factory.is_nil()) {
		throw Core::Root::NoActiveFactory ("GblAdapterLib::Search::FullAttributeInfoFactory");
	}
	FullAttributeInfo* ret_ = m_single_active_factory->make (full_info);
	GDS_ASSERT_MSG (ret_ != 0, ("GblAdapterLib::Search::FullAttributeInfoFactory impl can't return zerro"));
	return ret_;
}

//////////////////////////////////////////////////////////////////////////////////////
// implementation of factory manager methods for QueryCardInfo
bool QueryCardInfoFactoryManager::s_was_destroyed = false;

QueryCardInfoFactoryManager::QueryCardInfoFactoryManager () /*throw (Core::Root::FactoryManagerWasDestroyed)*/
	: m_has_registred_factories(false)
{
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
}

QueryCardInfoFactoryManager::~QueryCardInfoFactoryManager () {
	s_was_destroyed = true;
}

void QueryCardInfoFactoryManager::register_factory (
	QueryCardInfoAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
	Singleton::instance()->register_factory_i (factory, priority);
}

QueryCardInfoFactory::KeySet* QueryCardInfoFactoryManager::keys () {
	Core::Aptr<QueryCardInfoFactory::KeySet> keys (new QueryCardInfoFactory::KeySet (Singleton::instance()->m_factories_map.size ()));
	
	std::transform (
		Singleton::instance()->m_factories_map.begin ()
		, Singleton::instance()->m_factories_map.end ()
		, std::back_inserter(*keys)
		, boost::bind (&FactoryMap::value_type::first, _1)
	);
	
	return keys.forget ();
}

void QueryCardInfoFactoryManager::register_factory_i (
	QueryCardInfoAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey)*/ {
	m_has_registred_factories = true;
	FactoryMap::iterator f = m_factories_map.find(factory->key());
	if (f != m_factories_map.end() && f->second.priority == priority) {
		throw Core::Root::DuplicatedFactoryKey (
			"GblAdapterLib::Search::QueryCardInfoFactory"
			, factory->key()
		);
	}
	if (f == m_factories_map.end() || f->second.priority <= priority) {
		m_factories_map[factory->key()].factory = QueryCardInfoAbstractFactory::_duplicate(factory);
		m_factories_map[factory->key()].priority = priority;
	}
	
	if (!m_single_active_factory || m_single_active_factory_priority <= priority) {
		m_single_active_factory = QueryCardInfoAbstractFactory::_duplicate(factory);
		m_single_active_factory_priority = priority;
	}
}

QueryCardInfo* QueryCardInfoFactoryManager::create (const char* key) /*throw (Core::Root::UnknownFactoryKey)*/ {
	FactoryMap::iterator f = m_factories_map.find (key);
	if (f == m_factories_map.end()) {
		throw Core::Root::UnknownFactoryKey (
			"GblAdapterLib::Search::QueryCardInfoFactory"
			, key
		);
	}
	return f->second.factory->create ();
}

//////////////////////////////////////////////////////////////////////////////////////
// implementation of factory manager methods for AttributesHelper
bool AttributesHelperFactoryManager::s_was_destroyed = false;

AttributesHelperFactoryManager::AttributesHelperFactoryManager () /*throw (Core::Root::FactoryManagerWasDestroyed)*/
	: m_has_registred_factories(false)
{
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
}

AttributesHelperFactoryManager::~AttributesHelperFactoryManager () {
	s_was_destroyed = true;
}

void AttributesHelperFactoryManager::register_factory (
	AttributesHelperAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
	Singleton::instance()->register_factory_i (factory, priority);
}

void AttributesHelperFactoryManager::register_factory_i (
	AttributesHelperAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey)*/ {
	m_has_registred_factories = true;
	FactoryMap::iterator f = m_factories_map.find(factory->key());
	if (f != m_factories_map.end() && f->second.priority == priority) {
		throw Core::Root::DuplicatedFactoryKey (
			"GblAdapterLib::Search::AttributesHelperFactory"
			, factory->key()
		);
	}
	if (f == m_factories_map.end() || f->second.priority <= priority) {
		m_factories_map[factory->key()].factory = AttributesHelperAbstractFactory::_duplicate(factory);
		m_factories_map[factory->key()].priority = priority;
	}
	
	if (!m_single_active_factory || m_single_active_factory_priority <= priority) {
		m_single_active_factory = AttributesHelperAbstractFactory::_duplicate(factory);
		m_single_active_factory_priority = priority;
	}
}

AttributesHelper* AttributesHelperFactoryManager::make () /*throw (Core::Root::NoActiveFactory)*/ {
	if (m_single_active_factory.is_nil()) {
		throw Core::Root::NoActiveFactory ("GblAdapterLib::Search::AttributesHelperFactory");
	}
	AttributesHelper* ret_ = m_single_active_factory->make ();
	GDS_ASSERT_MSG (ret_ != 0, ("GblAdapterLib::Search::AttributesHelperFactory impl can't return zerro"));
	return ret_;
}
} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

