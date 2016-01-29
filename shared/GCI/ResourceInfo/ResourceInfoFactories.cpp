////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/GCI/ResourceInfo/ResourceInfoFactories.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Interfaces::Category>> shared::GCI::ResourceInfo
//
// набор интерфейсов для предоставления информации о системе
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/Core/sys/std_inc.h"
#include "shared/GCI/ResourceInfo/ResourceInfoFactories.h"

namespace GCI {
namespace ResourceInfo {

//////////////////////////////////////////////////////////////////////////////////////
// implementation of factory manager methods for CPUInfo
bool CPUInfoFactoryManager::s_was_destroyed = false;

CPUInfoFactoryManager::CPUInfoFactoryManager () /*throw (Core::Root::FactoryManagerWasDestroyed)*/
	: m_has_registred_factories(false)
{
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
}

CPUInfoFactoryManager::~CPUInfoFactoryManager () {
	s_was_destroyed = true;
}

void CPUInfoFactoryManager::register_factory (
	CPUInfoAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
	Singleton::instance()->register_factory_i (factory, priority);
}

void CPUInfoFactoryManager::register_factory_i (
	CPUInfoAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey)*/ {
	m_has_registred_factories = true;
	FactoryMap::iterator f = m_factories_map.find(factory->key());
	if (f != m_factories_map.end() && f->second.priority == priority) {
		throw Core::Root::DuplicatedFactoryKey (
			"GCI::ResourceInfo::CPUInfoFactory"
			, factory->key()
		);
	}
	if (f == m_factories_map.end() || f->second.priority <= priority) {
		m_factories_map[factory->key()].factory = CPUInfoAbstractFactory::_duplicate(factory);
		m_factories_map[factory->key()].priority = priority;
	}
	
	if (!m_single_active_factory || m_single_active_factory_priority <= priority) {
		m_single_active_factory = CPUInfoAbstractFactory::_duplicate(factory);
		m_single_active_factory_priority = priority;
	}
}

CPUInfo& CPUInfoFactoryManager::get () /*throw (Core::Root::NoActiveFactory, NotSupported)*/ {
	if (m_cached_object_for_get.ptr() == 0) {
		GUARD(m_mutex_for_get);
		if (m_cached_object_for_get.ptr() == 0) {
			if (m_single_active_factory.is_nil()) {
				throw Core::Root::NoActiveFactory ("GCI::ResourceInfo::CPUInfoFactory");
			}
			m_cached_object_for_get = m_single_active_factory->get ();
		
			GDS_ASSERT_MSG (m_cached_object_for_get.ptr() != 0, ("GCI::ResourceInfo::CPUInfoFactory impl can't return zerro"));
		}
	}
	return *m_cached_object_for_get;
}

//////////////////////////////////////////////////////////////////////////////////////
// implementation of factory manager methods for ProcessMemoryInfo
bool ProcessMemoryInfoFactoryManager::s_was_destroyed = false;

ProcessMemoryInfoFactoryManager::ProcessMemoryInfoFactoryManager () /*throw (Core::Root::FactoryManagerWasDestroyed)*/
	: m_has_registred_factories(false)
{
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
}

ProcessMemoryInfoFactoryManager::~ProcessMemoryInfoFactoryManager () {
	s_was_destroyed = true;
}

void ProcessMemoryInfoFactoryManager::register_factory (
	ProcessMemoryInfoAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
	Singleton::instance()->register_factory_i (factory, priority);
}

void ProcessMemoryInfoFactoryManager::register_factory_i (
	ProcessMemoryInfoAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey)*/ {
	m_has_registred_factories = true;
	FactoryMap::iterator f = m_factories_map.find(factory->key());
	if (f != m_factories_map.end() && f->second.priority == priority) {
		throw Core::Root::DuplicatedFactoryKey (
			"GCI::ResourceInfo::ProcessMemoryInfoFactory"
			, factory->key()
		);
	}
	if (f == m_factories_map.end() || f->second.priority <= priority) {
		m_factories_map[factory->key()].factory = ProcessMemoryInfoAbstractFactory::_duplicate(factory);
		m_factories_map[factory->key()].priority = priority;
	}
	
	if (!m_single_active_factory || m_single_active_factory_priority <= priority) {
		m_single_active_factory = ProcessMemoryInfoAbstractFactory::_duplicate(factory);
		m_single_active_factory_priority = priority;
	}
}

ProcessMemoryInfo& ProcessMemoryInfoFactoryManager::get () /*throw (Core::Root::NoActiveFactory, NotSupported)*/ {
	if (m_cached_object_for_get.ptr() == 0) {
		GUARD(m_mutex_for_get);
		if (m_cached_object_for_get.ptr() == 0) {
			if (m_single_active_factory.is_nil()) {
				throw Core::Root::NoActiveFactory ("GCI::ResourceInfo::ProcessMemoryInfoFactory");
			}
			m_cached_object_for_get = m_single_active_factory->get ();
		
			GDS_ASSERT_MSG (m_cached_object_for_get.ptr() != 0, ("GCI::ResourceInfo::ProcessMemoryInfoFactory impl can't return zerro"));
		}
	}
	return *m_cached_object_for_get;
}

//////////////////////////////////////////////////////////////////////////////////////
// implementation of factory manager methods for PhysicalMemoryInfo
bool PhysicalMemoryInfoFactoryManager::s_was_destroyed = false;

PhysicalMemoryInfoFactoryManager::PhysicalMemoryInfoFactoryManager () /*throw (Core::Root::FactoryManagerWasDestroyed)*/
	: m_has_registred_factories(false)
{
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
}

PhysicalMemoryInfoFactoryManager::~PhysicalMemoryInfoFactoryManager () {
	s_was_destroyed = true;
}

void PhysicalMemoryInfoFactoryManager::register_factory (
	PhysicalMemoryInfoAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
	Singleton::instance()->register_factory_i (factory, priority);
}

void PhysicalMemoryInfoFactoryManager::register_factory_i (
	PhysicalMemoryInfoAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey)*/ {
	m_has_registred_factories = true;
	FactoryMap::iterator f = m_factories_map.find(factory->key());
	if (f != m_factories_map.end() && f->second.priority == priority) {
		throw Core::Root::DuplicatedFactoryKey (
			"GCI::ResourceInfo::PhysicalMemoryInfoFactory"
			, factory->key()
		);
	}
	if (f == m_factories_map.end() || f->second.priority <= priority) {
		m_factories_map[factory->key()].factory = PhysicalMemoryInfoAbstractFactory::_duplicate(factory);
		m_factories_map[factory->key()].priority = priority;
	}
	
	if (!m_single_active_factory || m_single_active_factory_priority <= priority) {
		m_single_active_factory = PhysicalMemoryInfoAbstractFactory::_duplicate(factory);
		m_single_active_factory_priority = priority;
	}
}

PhysicalMemoryInfo& PhysicalMemoryInfoFactoryManager::get () /*throw (Core::Root::NoActiveFactory, NotSupported)*/ {
	if (m_cached_object_for_get.ptr() == 0) {
		GUARD(m_mutex_for_get);
		if (m_cached_object_for_get.ptr() == 0) {
			if (m_single_active_factory.is_nil()) {
				throw Core::Root::NoActiveFactory ("GCI::ResourceInfo::PhysicalMemoryInfoFactory");
			}
			m_cached_object_for_get = m_single_active_factory->get ();
		
			GDS_ASSERT_MSG (m_cached_object_for_get.ptr() != 0, ("GCI::ResourceInfo::PhysicalMemoryInfoFactory impl can't return zerro"));
		}
	}
	return *m_cached_object_for_get;
}
} // namespace ResourceInfo
} // namespace GCI

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

