////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAAddinLib/Helpers/HelpersFactories.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Interfaces::Category>> MDProcess::MDAAddinLib::Helpers
//
// набор вспомогательных интерфейсов
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAAddinLib/Helpers/HelpersFactories.h"

namespace Helpers {

//////////////////////////////////////////////////////////////////////////////////////
// implementation of factory manager methods for StereotypeManager
bool StereotypeManagerFactoryManager::s_was_destroyed = false;

StereotypeManagerFactoryManager::StereotypeManagerFactoryManager () /*throw (Core::Root::FactoryManagerWasDestroyed)*/
	: m_has_registred_factories(false)
{
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
}

StereotypeManagerFactoryManager::~StereotypeManagerFactoryManager () {
	s_was_destroyed = true;
}

void StereotypeManagerFactoryManager::register_factory (
	StereotypeManagerAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
	Singleton::instance()->register_factory_i (factory, priority);
}

void StereotypeManagerFactoryManager::register_factory_i (
	StereotypeManagerAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey)*/ {
	m_has_registred_factories = true;
	FactoryMap::iterator f = m_factories_map.find(factory->key());
	if (f != m_factories_map.end() && f->second.priority == priority) {
		throw Core::Root::DuplicatedFactoryKey (
			"MDAAddinLib::Helpers::StereotypeManagerFactory"
			, factory->key()
		);
	}
	if (f == m_factories_map.end() || f->second.priority <= priority) {
		m_factories_map[factory->key()].factory = StereotypeManagerAbstractFactory::_duplicate(factory);
		m_factories_map[factory->key()].priority = priority;
	}
	
	if (!m_single_active_factory || m_single_active_factory_priority <= priority) {
		m_single_active_factory = StereotypeManagerAbstractFactory::_duplicate(factory);
		m_single_active_factory_priority = priority;
	}
}

StereotypeManager* StereotypeManagerFactoryManager::make () /*throw (Core::Root::NoActiveFactory)*/ {
	if (m_single_active_factory.is_nil()) {
		throw Core::Root::NoActiveFactory ("MDAAddinLib::Helpers::StereotypeManagerFactory");
	}
	StereotypeManager* ret_ = m_single_active_factory->make ();
	GDS_ASSERT_MSG (ret_ != 0, ("MDAAddinLib::Helpers::StereotypeManagerFactory impl can't return zerro"));
	return ret_;
}

//////////////////////////////////////////////////////////////////////////////////////
// implementation of factory manager methods for KViewElement
bool KViewElementFactoryManager::s_was_destroyed = false;

KViewElementFactoryManager::KViewElementFactoryManager () /*throw (Core::Root::FactoryManagerWasDestroyed)*/
	: m_has_registred_factories(false)
{
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
}

KViewElementFactoryManager::~KViewElementFactoryManager () {
	s_was_destroyed = true;
}

void KViewElementFactoryManager::register_factory (
	KViewElementAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
	Singleton::instance()->register_factory_i (factory, priority);
}

void KViewElementFactoryManager::register_factory_i (
	KViewElementAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey)*/ {
	m_has_registred_factories = true;
	FactoryMap::iterator f = m_factories_map.find(factory->key());
	if (f != m_factories_map.end() && f->second.priority == priority) {
		throw Core::Root::DuplicatedFactoryKey (
			"MDAAddinLib::Helpers::KViewElementFactory"
			, factory->key()
		);
	}
	if (f == m_factories_map.end() || f->second.priority <= priority) {
		m_factories_map[factory->key()].factory = KViewElementAbstractFactory::_duplicate(factory);
		m_factories_map[factory->key()].priority = priority;
	}
	
	if (!m_single_active_factory || m_single_active_factory_priority <= priority) {
		m_single_active_factory = KViewElementAbstractFactory::_duplicate(factory);
		m_single_active_factory_priority = priority;
	}
}

KViewElement& KViewElementFactoryManager::get () /*throw (Core::Root::NoActiveFactory)*/ {
	if (m_cached_object_for_get.ptr() == 0) {
		GUARD(m_mutex_for_get);
		if (m_cached_object_for_get.ptr() == 0) {
			if (m_single_active_factory.is_nil()) {
				throw Core::Root::NoActiveFactory ("MDAAddinLib::Helpers::KViewElementFactory");
			}
			m_cached_object_for_get = m_single_active_factory->get ();
		
			GDS_ASSERT_MSG (m_cached_object_for_get.ptr() != 0, ("MDAAddinLib::Helpers::KViewElementFactory impl can't return zerro"));
		}
	}
	return *m_cached_object_for_get;
}

//////////////////////////////////////////////////////////////////////////////////////
// implementation of factory manager methods for ReportBuilder
bool ReportBuilderFactoryManager::s_was_destroyed = false;

ReportBuilderFactoryManager::ReportBuilderFactoryManager () /*throw (Core::Root::FactoryManagerWasDestroyed)*/
	: m_has_registred_factories(false)
{
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
}

ReportBuilderFactoryManager::~ReportBuilderFactoryManager () {
	s_was_destroyed = true;
}

void ReportBuilderFactoryManager::register_factory (
	ReportBuilderAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
	Singleton::instance()->register_factory_i (factory, priority);
}

void ReportBuilderFactoryManager::register_factory_i (
	ReportBuilderAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey)*/ {
	m_has_registred_factories = true;
	FactoryMap::iterator f = m_factories_map.find(factory->key());
	if (f != m_factories_map.end() && f->second.priority == priority) {
		throw Core::Root::DuplicatedFactoryKey (
			"MDAAddinLib::Helpers::ReportBuilderFactory"
			, factory->key()
		);
	}
	if (f == m_factories_map.end() || f->second.priority <= priority) {
		m_factories_map[factory->key()].factory = ReportBuilderAbstractFactory::_duplicate(factory);
		m_factories_map[factory->key()].priority = priority;
	}
	
	if (!m_single_active_factory || m_single_active_factory_priority <= priority) {
		m_single_active_factory = ReportBuilderAbstractFactory::_duplicate(factory);
		m_single_active_factory_priority = priority;
	}
}

ReportBuilder* ReportBuilderFactoryManager::make () /*throw (Core::Root::NoActiveFactory)*/ {
	if (m_single_active_factory.is_nil()) {
		throw Core::Root::NoActiveFactory ("MDAAddinLib::Helpers::ReportBuilderFactory");
	}
	ReportBuilder* ret_ = m_single_active_factory->make ();
	GDS_ASSERT_MSG (ret_ != 0, ("MDAAddinLib::Helpers::ReportBuilderFactory impl can't return zerro"));
	return ret_;
}
} // namespace Helpers

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

