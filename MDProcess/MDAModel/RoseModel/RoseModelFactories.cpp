////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/RoseModel/RoseModelFactories.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Interfaces::Category>> MDProcess::MDAModel::RoseModel
//
// Собственные обёртки над розовскими типами. Обёртки нужны, чтобы не складывать алгоритмы в одну
// кучу (сейчас это RoseHelper)
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/RoseModel/RoseModelFactories.h"



//////////////////////////////////////////////////////////////////////////////////////
// implementation of factory manager methods for Category
bool CategoryFactoryManager::s_was_destroyed = false;

CategoryFactoryManager::CategoryFactoryManager () /*throw (Core::Root::FactoryManagerWasDestroyed)*/
	: m_has_registred_factories(false)
{
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
}

CategoryFactoryManager::~CategoryFactoryManager () {
	s_was_destroyed = true;
}

void CategoryFactoryManager::register_factory (
	CategoryAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
	Singleton::instance()->register_factory_i (factory, priority);
}

void CategoryFactoryManager::register_factory_i (
	CategoryAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey)*/ {
	m_has_registred_factories = true;
	FactoryMap::iterator f = m_factories_map.find(factory->key());
	if (f != m_factories_map.end() && f->second.priority == priority) {
		throw Core::Root::DuplicatedFactoryKey (
			"MDAModel::RoseModel::CategoryFactory"
			, factory->key()
		);
	}
	if (f == m_factories_map.end() || f->second.priority <= priority) {
		m_factories_map[factory->key()].factory = CategoryAbstractFactory::_duplicate(factory);
		m_factories_map[factory->key()].priority = priority;
	}
	
	if (!m_single_active_factory || m_single_active_factory_priority <= priority) {
		m_single_active_factory = CategoryAbstractFactory::_duplicate(factory);
		m_single_active_factory_priority = priority;
	}
}

Category* CategoryFactoryManager::make (IRoseCategoryPtr cat) /*throw (Core::Root::NoActiveFactory)*/ {
	if (m_single_active_factory.is_nil()) {
		throw Core::Root::NoActiveFactory ("MDAModel::RoseModel::CategoryFactory");
	}
	Category* ret_ = m_single_active_factory->make (cat);
	GDS_ASSERT_MSG (ret_ != 0, ("MDAModel::RoseModel::CategoryFactory impl can't return zerro"));
	return ret_;
}

//////////////////////////////////////////////////////////////////////////////////////
// implementation of factory manager methods for IsVirtual
bool IsVirtualFactoryManager::s_was_destroyed = false;

IsVirtualFactoryManager::IsVirtualFactoryManager () /*throw (Core::Root::FactoryManagerWasDestroyed)*/
	: m_has_registred_factories(false)
{
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
}

IsVirtualFactoryManager::~IsVirtualFactoryManager () {
	s_was_destroyed = true;
}

void IsVirtualFactoryManager::register_factory (
	IsVirtualAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
	Singleton::instance()->register_factory_i (factory, priority);
}

void IsVirtualFactoryManager::register_factory_i (
	IsVirtualAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey)*/ {
	m_has_registred_factories = true;
	FactoryMap::iterator f = m_factories_map.find(factory->key());
	if (f != m_factories_map.end() && f->second.priority == priority) {
		throw Core::Root::DuplicatedFactoryKey (
			"MDAModel::RoseModel::IsVirtualFactory"
			, factory->key()
		);
	}
	if (f == m_factories_map.end() || f->second.priority <= priority) {
		m_factories_map[factory->key()].factory = IsVirtualAbstractFactory::_duplicate(factory);
		m_factories_map[factory->key()].priority = priority;
	}
	
	if (!m_single_active_factory || m_single_active_factory_priority <= priority) {
		m_single_active_factory = IsVirtualAbstractFactory::_duplicate(factory);
		m_single_active_factory_priority = priority;
	}
}

IsVirtual& IsVirtualFactoryManager::get () /*throw (Core::Root::NoActiveFactory)*/ {
	if (m_cached_object_for_get.ptr() == 0) {
		GUARD(m_mutex_for_get);
		if (m_cached_object_for_get.ptr() == 0) {
			if (m_single_active_factory.is_nil()) {
				throw Core::Root::NoActiveFactory ("MDAModel::RoseModel::IsVirtualFactory");
			}
			m_cached_object_for_get = m_single_active_factory->get ();
		
			GDS_ASSERT_MSG (m_cached_object_for_get.ptr() != 0, ("MDAModel::RoseModel::IsVirtualFactory impl can't return zerro"));
		}
	}
	return *m_cached_object_for_get;
}

//////////////////////////////////////////////////////////////////////////////////////
// implementation of factory manager methods for PropertyHelper
bool PropertyHelperFactoryManager::s_was_destroyed = false;

PropertyHelperFactoryManager::PropertyHelperFactoryManager () /*throw (Core::Root::FactoryManagerWasDestroyed)*/
	: m_has_registred_factories(false)
{
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
}

PropertyHelperFactoryManager::~PropertyHelperFactoryManager () {
	s_was_destroyed = true;
}

void PropertyHelperFactoryManager::register_factory (
	PropertyHelperAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
	Singleton::instance()->register_factory_i (factory, priority);
}

void PropertyHelperFactoryManager::register_factory_i (
	PropertyHelperAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey)*/ {
	m_has_registred_factories = true;
	FactoryMap::iterator f = m_factories_map.find(factory->key());
	if (f != m_factories_map.end() && f->second.priority == priority) {
		throw Core::Root::DuplicatedFactoryKey (
			"MDAModel::RoseModel::PropertyHelperFactory"
			, factory->key()
		);
	}
	if (f == m_factories_map.end() || f->second.priority <= priority) {
		m_factories_map[factory->key()].factory = PropertyHelperAbstractFactory::_duplicate(factory);
		m_factories_map[factory->key()].priority = priority;
	}
	
	if (!m_single_active_factory || m_single_active_factory_priority <= priority) {
		m_single_active_factory = PropertyHelperAbstractFactory::_duplicate(factory);
		m_single_active_factory_priority = priority;
	}
}

PropertyHelper& PropertyHelperFactoryManager::get () /*throw (Core::Root::NoActiveFactory)*/ {
	if (m_cached_object_for_get.ptr() == 0) {
		GUARD(m_mutex_for_get);
		if (m_cached_object_for_get.ptr() == 0) {
			if (m_single_active_factory.is_nil()) {
				throw Core::Root::NoActiveFactory ("MDAModel::RoseModel::PropertyHelperFactory");
			}
			m_cached_object_for_get = m_single_active_factory->get ();
		
			GDS_ASSERT_MSG (m_cached_object_for_get.ptr() != 0, ("MDAModel::RoseModel::PropertyHelperFactory impl can't return zerro"));
		}
	}
	return *m_cached_object_for_get;
}

//////////////////////////////////////////////////////////////////////////////////////
// implementation of factory manager methods for ModelPropertiesHelper
bool ModelPropertiesHelperFactoryManager::s_was_destroyed = false;

ModelPropertiesHelperFactoryManager::ModelPropertiesHelperFactoryManager () /*throw (Core::Root::FactoryManagerWasDestroyed)*/
	: m_has_registred_factories(false)
{
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
}

ModelPropertiesHelperFactoryManager::~ModelPropertiesHelperFactoryManager () {
	s_was_destroyed = true;
}

void ModelPropertiesHelperFactoryManager::register_factory (
	ModelPropertiesHelperAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
	Singleton::instance()->register_factory_i (factory, priority);
}

void ModelPropertiesHelperFactoryManager::register_factory_i (
	ModelPropertiesHelperAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey)*/ {
	m_has_registred_factories = true;
	FactoryMap::iterator f = m_factories_map.find(factory->key());
	if (f != m_factories_map.end() && f->second.priority == priority) {
		throw Core::Root::DuplicatedFactoryKey (
			"MDAModel::RoseModel::ModelPropertiesHelperFactory"
			, factory->key()
		);
	}
	if (f == m_factories_map.end() || f->second.priority <= priority) {
		m_factories_map[factory->key()].factory = ModelPropertiesHelperAbstractFactory::_duplicate(factory);
		m_factories_map[factory->key()].priority = priority;
	}
	
	if (!m_single_active_factory || m_single_active_factory_priority <= priority) {
		m_single_active_factory = ModelPropertiesHelperAbstractFactory::_duplicate(factory);
		m_single_active_factory_priority = priority;
	}
}

ModelPropertiesHelper& ModelPropertiesHelperFactoryManager::get () /*throw (Core::Root::NoActiveFactory)*/ {
	if (m_cached_object_for_get.ptr() == 0) {
		GUARD(m_mutex_for_get);
		if (m_cached_object_for_get.ptr() == 0) {
			if (m_single_active_factory.is_nil()) {
				throw Core::Root::NoActiveFactory ("MDAModel::RoseModel::ModelPropertiesHelperFactory");
			}
			m_cached_object_for_get = m_single_active_factory->get ();
		
			GDS_ASSERT_MSG (m_cached_object_for_get.ptr() != 0, ("MDAModel::RoseModel::ModelPropertiesHelperFactory impl can't return zerro"));
		}
	}
	return *m_cached_object_for_get;
}

//////////////////////////////////////////////////////////////////////////////////////
// implementation of factory manager methods for TypeLinkHelper
bool TypeLinkHelperFactoryManager::s_was_destroyed = false;

TypeLinkHelperFactoryManager::TypeLinkHelperFactoryManager () /*throw (Core::Root::FactoryManagerWasDestroyed)*/
	: m_has_registred_factories(false)
{
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
}

TypeLinkHelperFactoryManager::~TypeLinkHelperFactoryManager () {
	s_was_destroyed = true;
}

void TypeLinkHelperFactoryManager::register_factory (
	TypeLinkHelperAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
	Singleton::instance()->register_factory_i (factory, priority);
}

void TypeLinkHelperFactoryManager::register_factory_i (
	TypeLinkHelperAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey)*/ {
	m_has_registred_factories = true;
	FactoryMap::iterator f = m_factories_map.find(factory->key());
	if (f != m_factories_map.end() && f->second.priority == priority) {
		throw Core::Root::DuplicatedFactoryKey (
			"MDAModel::RoseModel::TypeLinkHelperFactory"
			, factory->key()
		);
	}
	if (f == m_factories_map.end() || f->second.priority <= priority) {
		m_factories_map[factory->key()].factory = TypeLinkHelperAbstractFactory::_duplicate(factory);
		m_factories_map[factory->key()].priority = priority;
	}
	
	if (!m_single_active_factory || m_single_active_factory_priority <= priority) {
		m_single_active_factory = TypeLinkHelperAbstractFactory::_duplicate(factory);
		m_single_active_factory_priority = priority;
	}
}

TypeLinkHelper& TypeLinkHelperFactoryManager::get () /*throw (Core::Root::NoActiveFactory)*/ {
	if (m_cached_object_for_get.ptr() == 0) {
		GUARD(m_mutex_for_get);
		if (m_cached_object_for_get.ptr() == 0) {
			if (m_single_active_factory.is_nil()) {
				throw Core::Root::NoActiveFactory ("MDAModel::RoseModel::TypeLinkHelperFactory");
			}
			m_cached_object_for_get = m_single_active_factory->get ();
		
			GDS_ASSERT_MSG (m_cached_object_for_get.ptr() != 0, ("MDAModel::RoseModel::TypeLinkHelperFactory impl can't return zerro"));
		}
	}
	return *m_cached_object_for_get;
}


//////////////////////////////////////////////////////////////////////////////////////
// implementation of factory manager methods for OverloadedItem
bool OverloadedItemFactoryManager::s_was_destroyed = false;

OverloadedItemFactoryManager::OverloadedItemFactoryManager () /*throw (Core::Root::FactoryManagerWasDestroyed)*/
	: m_has_registred_factories(false)
{
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
}

OverloadedItemFactoryManager::~OverloadedItemFactoryManager () {
	s_was_destroyed = true;
}

void OverloadedItemFactoryManager::register_factory (
	OverloadedItemAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
	Singleton::instance()->register_factory_i (factory, priority);
}

void OverloadedItemFactoryManager::register_factory_i (
	OverloadedItemAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey)*/ {
	m_has_registred_factories = true;
	FactoryMap::iterator f = m_factories_map.find(factory->key());
	if (f != m_factories_map.end() && f->second.priority == priority) {
		throw Core::Root::DuplicatedFactoryKey (
			"MDAModel::RoseModel::OverloadedItemFactory"
			, factory->key()
		);
	}
	if (f == m_factories_map.end() || f->second.priority <= priority) {
		m_factories_map[factory->key()].factory = OverloadedItemAbstractFactory::_duplicate(factory);
		m_factories_map[factory->key()].priority = priority;
	}
	
	if (!m_single_active_factory || m_single_active_factory_priority <= priority) {
		m_single_active_factory = OverloadedItemAbstractFactory::_duplicate(factory);
		m_single_active_factory_priority = priority;
	}
}

OverloadedItem* OverloadedItemFactoryManager::make (const std::string& uid, bool need_collect_child) /*throw (Core::Root::NoActiveFactory)*/ {
	if (m_single_active_factory.is_nil()) {
		throw Core::Root::NoActiveFactory ("MDAModel::RoseModel::InheritedItemFactory");
	}
	OverloadedItem* ret_ = m_single_active_factory->make (uid, need_collect_child);
	GDS_ASSERT_MSG (ret_ != 0, ("MDAModel::RoseModel::InheritedItemFactory impl can't return zerro"));
	return ret_;
}

//////////////////////////////////////////////////////////////////////////////////////
// implementation of factory manager methods for ImplementedItem
bool ImplementedItemFactoryManager::s_was_destroyed = false;

ImplementedItemFactoryManager::ImplementedItemFactoryManager () /*throw (Core::Root::FactoryManagerWasDestroyed)*/
	: m_has_registred_factories(false)
{
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
}

ImplementedItemFactoryManager::~ImplementedItemFactoryManager () {
	s_was_destroyed = true;
}

void ImplementedItemFactoryManager::register_factory (
	ImplementedItemAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
	Singleton::instance()->register_factory_i (factory, priority);
}

void ImplementedItemFactoryManager::register_factory_i (
	ImplementedItemAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey)*/ {
	m_has_registred_factories = true;
	FactoryMap::iterator f = m_factories_map.find(factory->key());
	if (f != m_factories_map.end() && f->second.priority == priority) {
		throw Core::Root::DuplicatedFactoryKey (
			"MDAModel::RoseModel::ImplementedItemFactory"
			, factory->key()
		);
	}
	if (f == m_factories_map.end() || f->second.priority <= priority) {
		m_factories_map[factory->key()].factory = ImplementedItemAbstractFactory::_duplicate(factory);
		m_factories_map[factory->key()].priority = priority;
	}
	
	if (!m_single_active_factory || m_single_active_factory_priority <= priority) {
		m_single_active_factory = ImplementedItemAbstractFactory::_duplicate(factory);
		m_single_active_factory_priority = priority;
	}
}

ImplementedItem* ImplementedItemFactoryManager::make (const std::string& uid, bool need_collect_child) /*throw (Core::Root::NoActiveFactory)*/ {
	if (m_single_active_factory.is_nil()) {
		throw Core::Root::NoActiveFactory ("MDAModel::RoseModel::InheritedItemFactory");
	}
	ImplementedItem* ret_ = m_single_active_factory->make (uid, need_collect_child);
	GDS_ASSERT_MSG (ret_ != 0, ("MDAModel::RoseModel::InheritedItemFactory impl can't return zerro"));
	return ret_;
}

//////////////////////////////////////////////////////////////////////////////////////
// implementation of factory manager methods for InheritedItemHelper
bool InheritedItemHelperFactoryManager::s_was_destroyed = false;

InheritedItemHelperFactoryManager::InheritedItemHelperFactoryManager () /*throw (Core::Root::FactoryManagerWasDestroyed)*/
	: m_has_registred_factories(false)
{
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
}

InheritedItemHelperFactoryManager::~InheritedItemHelperFactoryManager () {
	s_was_destroyed = true;
}

void InheritedItemHelperFactoryManager::register_factory (
	InheritedItemHelperAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
	Singleton::instance()->register_factory_i (factory, priority);
}

void InheritedItemHelperFactoryManager::register_factory_i (
	InheritedItemHelperAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey)*/ {
	m_has_registred_factories = true;
	FactoryMap::iterator f = m_factories_map.find(factory->key());
	if (f != m_factories_map.end() && f->second.priority == priority) {
		throw Core::Root::DuplicatedFactoryKey (
			"MDAModel::RoseModel::InheritedItemHelperFactory"
			, factory->key()
		);
	}
	if (f == m_factories_map.end() || f->second.priority <= priority) {
		m_factories_map[factory->key()].factory = InheritedItemHelperAbstractFactory::_duplicate(factory);
		m_factories_map[factory->key()].priority = priority;
	}
	
	if (!m_single_active_factory || m_single_active_factory_priority <= priority) {
		m_single_active_factory = InheritedItemHelperAbstractFactory::_duplicate(factory);
		m_single_active_factory_priority = priority;
	}
}

InheritedItemHelper& InheritedItemHelperFactoryManager::get () /*throw (Core::Root::NoActiveFactory)*/ {
	if (m_cached_object_for_get.ptr() == 0) {
		GUARD(m_mutex_for_get);
		if (m_cached_object_for_get.ptr() == 0) {
			if (m_single_active_factory.is_nil()) {
				throw Core::Root::NoActiveFactory ("MDAModel::RoseModel::InheritedItemHelperFactory");
			}
			m_cached_object_for_get = m_single_active_factory->get ();
		
			GDS_ASSERT_MSG (m_cached_object_for_get.ptr() != 0, ("MDAModel::RoseModel::InheritedItemHelperFactory impl can't return zerro"));
		}
	}
	return *m_cached_object_for_get;
}

//////////////////////////////////////////////////////////////////////////////////////
// implementation of factory manager methods for ModelSearcher
bool ModelSearcherFactoryManager::s_was_destroyed = false;

ModelSearcherFactoryManager::ModelSearcherFactoryManager () /*throw (Core::Root::FactoryManagerWasDestroyed)*/
	: m_has_registred_factories(false)
{
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
}

ModelSearcherFactoryManager::~ModelSearcherFactoryManager () {
	s_was_destroyed = true;
}

void ModelSearcherFactoryManager::register_factory (
	ModelSearcherAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
	Singleton::instance()->register_factory_i (factory, priority);
}

void ModelSearcherFactoryManager::register_factory_i (
	ModelSearcherAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey)*/ {
	m_has_registred_factories = true;
	FactoryMap::iterator f = m_factories_map.find(factory->key());
	if (f != m_factories_map.end() && f->second.priority == priority) {
		throw Core::Root::DuplicatedFactoryKey (
			"MDAModel::RoseModel::ModelSearcherFactory"
			, factory->key()
		);
	}
	if (f == m_factories_map.end() || f->second.priority <= priority) {
		m_factories_map[factory->key()].factory = ModelSearcherAbstractFactory::_duplicate(factory);
		m_factories_map[factory->key()].priority = priority;
	}
	
	if (!m_single_active_factory || m_single_active_factory_priority <= priority) {
		m_single_active_factory = ModelSearcherAbstractFactory::_duplicate(factory);
		m_single_active_factory_priority = priority;
	}
}

ModelSearcher& ModelSearcherFactoryManager::get () /*throw (Core::Root::NoActiveFactory)*/ {
	if (m_cached_object_for_get.ptr() == 0) {
		GUARD(m_mutex_for_get);
		if (m_cached_object_for_get.ptr() == 0) {
			if (m_single_active_factory.is_nil()) {
				throw Core::Root::NoActiveFactory ("MDAModel::RoseModel::ModelSearcherFactory");
			}
			m_cached_object_for_get = m_single_active_factory->get ();
		
			GDS_ASSERT_MSG (m_cached_object_for_get.ptr() != 0, ("MDAModel::RoseModel::ModelSearcherFactory impl can't return zerro"));
		}
	}
	return *m_cached_object_for_get;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

