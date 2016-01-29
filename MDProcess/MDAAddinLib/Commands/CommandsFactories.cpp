////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAAddinLib/Commands/CommandsFactories.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Interfaces::Category>> MDProcess::MDAAddinLib::Commands
//
// интерфейсы для обработки MDA-команд
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAAddinLib/Commands/CommandsFactories.h"

namespace Commands {

//////////////////////////////////////////////////////////////////////////////////////
// implementation of factory manager methods for CmdManager
bool CmdManagerFactoryManager::s_was_destroyed = false;

CmdManagerFactoryManager::CmdManagerFactoryManager () /*throw (Core::Root::FactoryManagerWasDestroyed)*/
	: m_has_registred_factories(false)
{
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
}

CmdManagerFactoryManager::~CmdManagerFactoryManager () {
	s_was_destroyed = true;
}

void CmdManagerFactoryManager::register_factory (
	CmdManagerAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
	Singleton::instance()->register_factory_i (factory, priority);
}

void CmdManagerFactoryManager::register_factory_i (
	CmdManagerAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey)*/ {
	m_has_registred_factories = true;
	FactoryMap::iterator f = m_factories_map.find(factory->key());
	if (f != m_factories_map.end() && f->second.priority == priority) {
		throw Core::Root::DuplicatedFactoryKey (
			"MDAAddinLib::Commands::CmdManagerFactory"
			, factory->key()
		);
	}
	if (f == m_factories_map.end() || f->second.priority <= priority) {
		m_factories_map[factory->key()].factory = CmdManagerAbstractFactory::_duplicate(factory);
		m_factories_map[factory->key()].priority = priority;
	}
	
	if (!m_single_active_factory || m_single_active_factory_priority <= priority) {
		m_single_active_factory = CmdManagerAbstractFactory::_duplicate(factory);
		m_single_active_factory_priority = priority;
	}
}

CmdManager& CmdManagerFactoryManager::get () /*throw (Core::Root::NoActiveFactory)*/ {
	if (m_cached_object_for_get.ptr() == 0) {
		GUARD(m_mutex_for_get);
		if (m_cached_object_for_get.ptr() == 0) {
			if (m_single_active_factory.is_nil()) {
				throw Core::Root::NoActiveFactory ("MDAAddinLib::Commands::CmdManagerFactory");
			}
			m_cached_object_for_get = m_single_active_factory->get ();
		
			GDS_ASSERT_MSG (m_cached_object_for_get.ptr() != 0, ("MDAAddinLib::Commands::CmdManagerFactory impl can't return zerro"));
		}
	}
	return *m_cached_object_for_get;
}

//////////////////////////////////////////////////////////////////////////////////////
// implementation of factory manager methods for DblClickAction
bool DblClickActionFactoryManager::s_was_destroyed = false;

DblClickActionFactoryManager::DblClickActionFactoryManager () /*throw (Core::Root::FactoryManagerWasDestroyed)*/
	: m_has_registred_factories(false)
{
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
}

DblClickActionFactoryManager::~DblClickActionFactoryManager () {
	s_was_destroyed = true;
}

void DblClickActionFactoryManager::register_factory (
	DblClickActionAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
	Singleton::instance()->register_factory_i (factory, priority);
}

void DblClickActionFactoryManager::register_factory_i (
	DblClickActionAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey)*/ {
	m_has_registred_factories = true;
	FactoryMap::iterator f = m_factories_map.find(factory->key());
	if (f != m_factories_map.end() && f->second.priority == priority) {
		throw Core::Root::DuplicatedFactoryKey (
			"MDAAddinLib::Commands::DblClickActionFactory"
			, factory->key()
		);
	}
	if (f == m_factories_map.end() || f->second.priority <= priority) {
		m_factories_map[factory->key()].factory = DblClickActionAbstractFactory::_duplicate(factory);
		m_factories_map[factory->key()].priority = priority;
	}
	
	if (!m_single_active_factory || m_single_active_factory_priority <= priority) {
		m_single_active_factory = DblClickActionAbstractFactory::_duplicate(factory);
		m_single_active_factory_priority = priority;
	}
}

DblClickAction* DblClickActionFactoryManager::make () /*throw (Core::Root::NoActiveFactory)*/ {
	if (m_single_active_factory.is_nil()) {
		throw Core::Root::NoActiveFactory ("MDAAddinLib::Commands::DblClickActionFactory");
	}
	DblClickAction* ret_ = m_single_active_factory->make ();
	GDS_ASSERT_MSG (ret_ != 0, ("MDAAddinLib::Commands::DblClickActionFactory impl can't return zerro"));
	return ret_;
}
} // namespace Commands

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

