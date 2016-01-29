////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/BaseTypes/BaseTypesFactories.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::BaseTypes
//
// Базовые типы, используемые в адаптере
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/BaseTypes/BaseTypesFactories.h"

namespace GblAdapterLib {




//////////////////////////////////////////////////////////////////////////////////////
// implementation of factory manager methods for SearchEntity
bool SearchEntityFactoryManager::s_was_destroyed = false;

SearchEntityFactoryManager::SearchEntityFactoryManager () /*throw (Core::Root::FactoryManagerWasDestroyed)*/
	: m_has_registred_factories(false)
{
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
}

SearchEntityFactoryManager::~SearchEntityFactoryManager () {
	s_was_destroyed = true;
}

void SearchEntityFactoryManager::register_factory (
	SearchEntityAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
	Singleton::instance()->register_factory_i (factory, priority);
}

void SearchEntityFactoryManager::register_factory_i (
	SearchEntityAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey)*/ {
	m_has_registred_factories = true;
	FactoryMap::iterator f = m_factories_map.find(factory->key());
	if (f != m_factories_map.end() && f->second.priority == priority) {
		throw Core::Root::DuplicatedFactoryKey (
			"GblAdapterLib::BaseTypes::SearchEntityFactory"
			, factory->key()
		);
	}
	if (f == m_factories_map.end() || f->second.priority <= priority) {
		m_factories_map[factory->key()].factory = SearchEntityAbstractFactory::_duplicate(factory);
		m_factories_map[factory->key()].priority = priority;
	}
	
	if (!m_single_active_factory || m_single_active_factory_priority <= priority) {
		m_single_active_factory = SearchEntityAbstractFactory::_duplicate(factory);
		m_single_active_factory_priority = priority;
	}
}

SearchEntity* SearchEntityFactoryManager::make (SearchResultType result_type, size_t document_count, size_t entry_count, size_t edition_count) /*throw (Core::Root::NoActiveFactory)*/ {
	if (m_single_active_factory.is_nil()) {
		throw Core::Root::NoActiveFactory ("GblAdapterLib::BaseTypes::SearchEntityFactory");
	}
	SearchEntity* ret_ = m_single_active_factory->make (result_type, document_count, entry_count, edition_count);
	GDS_ASSERT_MSG (ret_ != 0, ("GblAdapterLib::BaseTypes::SearchEntityFactory impl can't return zerro"));
	return ret_;
}

SearchEntity* SearchEntityFactoryManager::make (GblPilotQueryDef::SearchEntity* search_entity) /*throw (Core::Root::NoActiveFactory)*/ {
	if (m_single_active_factory.is_nil()) {
		throw Core::Root::NoActiveFactory ("GblAdapterLib::BaseTypes::SearchEntityFactory");
	}
	SearchEntity* ret_ = m_single_active_factory->make (search_entity);
	GDS_ASSERT_MSG (ret_ != 0, ("GblAdapterLib::BaseTypes::SearchEntityFactory impl can't return zerro"));
	return ret_;
}

//////////////////////////////////////////////////////////////////////////////////////
// implementation of factory manager methods for Variant
bool VariantFactoryManager::s_was_destroyed = false;

VariantFactoryManager::VariantFactoryManager () /*throw (Core::Root::FactoryManagerWasDestroyed)*/
	: m_has_registred_factories(false)
{
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
}

VariantFactoryManager::~VariantFactoryManager () {
	s_was_destroyed = true;
}

void VariantFactoryManager::register_factory (
	VariantAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
	Singleton::instance()->register_factory_i (factory, priority);
}

void VariantFactoryManager::register_factory_i (
	VariantAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey)*/ {
	m_has_registred_factories = true;
	FactoryMap::iterator f = m_factories_map.find(factory->key());
	if (f != m_factories_map.end() && f->second.priority == priority) {
		throw Core::Root::DuplicatedFactoryKey (
			"GblAdapterLib::BaseTypes::VariantFactory"
			, factory->key()
		);
	}
	if (f == m_factories_map.end() || f->second.priority <= priority) {
		m_factories_map[factory->key()].factory = VariantAbstractFactory::_duplicate(factory);
		m_factories_map[factory->key()].priority = priority;
	}
	
	if (!m_single_active_factory || m_single_active_factory_priority <= priority) {
		m_single_active_factory = VariantAbstractFactory::_duplicate(factory);
		m_single_active_factory_priority = priority;
	}
}

Variant* VariantFactoryManager::make () /*throw (Core::Root::NoActiveFactory)*/ {
	if (m_single_active_factory.is_nil()) {
		throw Core::Root::NoActiveFactory ("GblAdapterLib::BaseTypes::VariantFactory");
	}
	Variant* ret_ = m_single_active_factory->make ();
	GDS_ASSERT_MSG (ret_ != 0, ("GblAdapterLib::BaseTypes::VariantFactory impl can't return zerro"));
	return ret_;
}

Variant* VariantFactoryManager::make_long (long value) /*throw (Core::Root::NoActiveFactory)*/ {
	if (m_single_active_factory.is_nil()) {
		throw Core::Root::NoActiveFactory ("GblAdapterLib::BaseTypes::VariantFactory");
	}
	Variant* ret_ = m_single_active_factory->make_long (value);
	GDS_ASSERT_MSG (ret_ != 0, ("GblAdapterLib::BaseTypes::VariantFactory impl can't return zerro"));
	return ret_;
}

Variant* VariantFactoryManager::make_bool (bool value) /*throw (Core::Root::NoActiveFactory)*/ {
	if (m_single_active_factory.is_nil()) {
		throw Core::Root::NoActiveFactory ("GblAdapterLib::BaseTypes::VariantFactory");
	}
	Variant* ret_ = m_single_active_factory->make_bool (value);
	GDS_ASSERT_MSG (ret_ != 0, ("GblAdapterLib::BaseTypes::VariantFactory impl can't return zerro"));
	return ret_;
}

Variant* VariantFactoryManager::make_string (GCI::IO::String* value) /*throw (Core::Root::NoActiveFactory)*/ {
	if (m_single_active_factory.is_nil()) {
		throw Core::Root::NoActiveFactory ("GblAdapterLib::BaseTypes::VariantFactory");
	}
	Variant* ret_ = m_single_active_factory->make_string (value);
	GDS_ASSERT_MSG (ret_ != 0, ("GblAdapterLib::BaseTypes::VariantFactory impl can't return zerro"));
	return ret_;
}

Variant* VariantFactoryManager::make_object (Core::IObject* value) /*throw (Core::Root::NoActiveFactory)*/ {
	if (m_single_active_factory.is_nil()) {
		throw Core::Root::NoActiveFactory ("GblAdapterLib::BaseTypes::VariantFactory");
	}
	Variant* ret_ = m_single_active_factory->make_object (value);
	GDS_ASSERT_MSG (ret_ != 0, ("GblAdapterLib::BaseTypes::VariantFactory impl can't return zerro"));
	return ret_;
}
} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

