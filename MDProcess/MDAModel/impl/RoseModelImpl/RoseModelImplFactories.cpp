////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/RoseModelImpl/RoseModelImplFactories.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Impl::Category>> MDProcess::MDAModel::RoseModelImpl
//
// Пакет реализации интерфейсов
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/RoseModelImpl/RoseModelImplFactories.h"

namespace RoseModelImpl {


//////////////////////////////////////////////////////////////////////////////////////
// implementation of factory manager methods for ImplementedItemEx
bool ImplementedItemExFactoryManager::s_was_destroyed = false;

ImplementedItemExFactoryManager::ImplementedItemExFactoryManager () /*throw (Core::Root::FactoryManagerWasDestroyed)*/
	: m_has_registred_factories(false)
{
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
}

ImplementedItemExFactoryManager::~ImplementedItemExFactoryManager () {
	s_was_destroyed = true;
}

void ImplementedItemExFactoryManager::register_factory (
	ImplementedItemExAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
	Singleton::instance()->register_factory_i (factory, priority);
	ImplementedItemFactoryManager::register_factory (factory, priority);
	
}

void ImplementedItemExFactoryManager::register_factory_i (
	ImplementedItemExAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey)*/ {
	m_has_registred_factories = true;
	FactoryMap::iterator f = m_factories_map.find(factory->key());
	if (f != m_factories_map.end() && f->second.priority == priority) {
		throw Core::Root::DuplicatedFactoryKey (
			"MDAModel::RoseModelImpl::ImplementedItemExFactory"
			, factory->key()
		);
	}
	if (f == m_factories_map.end() || f->second.priority <= priority) {
		m_factories_map[factory->key()].factory = ImplementedItemExAbstractFactory::_duplicate(factory);
		m_factories_map[factory->key()].priority = priority;
	}
	
	if (!m_single_active_factory || m_single_active_factory_priority <= priority) {
		m_single_active_factory = ImplementedItemExAbstractFactory::_duplicate(factory);
		m_single_active_factory_priority = priority;
	}
}

ImplementedItemEx* ImplementedItemExFactoryManager::make (const std::string& stored_value) /*throw (Core::Root::NoActiveFactory)*/ {
	if (m_single_active_factory.is_nil()) {
		throw Core::Root::NoActiveFactory ("MDAModel::RoseModelImpl::InheritedItemExFactory");
	}
	ImplementedItemEx* ret_ = m_single_active_factory->make (stored_value);
	GDS_ASSERT_MSG (ret_ != 0, ("MDAModel::RoseModelImpl::InheritedItemExFactory impl can't return zerro"));
	return ret_;
}

//////////////////////////////////////////////////////////////////////////////////////
// implementation of factory manager methods for OverloadedItemEx
bool OverloadedItemExFactoryManager::s_was_destroyed = false;

OverloadedItemExFactoryManager::OverloadedItemExFactoryManager () /*throw (Core::Root::FactoryManagerWasDestroyed)*/
	: m_has_registred_factories(false)
{
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
}

OverloadedItemExFactoryManager::~OverloadedItemExFactoryManager () {
	s_was_destroyed = true;
}

void OverloadedItemExFactoryManager::register_factory (
	OverloadedItemExAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
	Singleton::instance()->register_factory_i (factory, priority);
	OverloadedItemFactoryManager::register_factory (factory, priority);
	
}

void OverloadedItemExFactoryManager::register_factory_i (
	OverloadedItemExAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey)*/ {
	m_has_registred_factories = true;
	FactoryMap::iterator f = m_factories_map.find(factory->key());
	if (f != m_factories_map.end() && f->second.priority == priority) {
		throw Core::Root::DuplicatedFactoryKey (
			"MDAModel::RoseModelImpl::OverloadedItemExFactory"
			, factory->key()
		);
	}
	if (f == m_factories_map.end() || f->second.priority <= priority) {
		m_factories_map[factory->key()].factory = OverloadedItemExAbstractFactory::_duplicate(factory);
		m_factories_map[factory->key()].priority = priority;
	}
	
	if (!m_single_active_factory || m_single_active_factory_priority <= priority) {
		m_single_active_factory = OverloadedItemExAbstractFactory::_duplicate(factory);
		m_single_active_factory_priority = priority;
	}
}

OverloadedItemEx* OverloadedItemExFactoryManager::make (const std::string& stored_value) /*throw (Core::Root::NoActiveFactory)*/ {
	if (m_single_active_factory.is_nil()) {
		throw Core::Root::NoActiveFactory ("MDAModel::RoseModelImpl::InheritedItemExFactory");
	}
	OverloadedItemEx* ret_ = m_single_active_factory->make (stored_value);
	GDS_ASSERT_MSG (ret_ != 0, ("MDAModel::RoseModelImpl::InheritedItemExFactory impl can't return zerro"));
	return ret_;
}
} // namespace RoseModelImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

