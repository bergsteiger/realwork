////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/Core/mt/mtFactories.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Interfaces::Category>> shared::Core::mt
//
// работа с многопоточностью
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/Core/sys/core_std_inc.h"
#include "shared/Core/Root/Root.h"
#include "shared/Core/mt/mtFactories.h"

namespace Core {

//////////////////////////////////////////////////////////////////////////////////////
// implementation of factory manager methods for ThreadPool
bool ThreadPoolFactoryManager::s_was_destroyed = false;

ThreadPoolFactoryManager::ThreadPoolFactoryManager () /*throw (Core::Root::FactoryManagerWasDestroyed)*/
	: m_has_registred_factories(false)
{
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
}

ThreadPoolFactoryManager::~ThreadPoolFactoryManager () {
	s_was_destroyed = true;
}

void ThreadPoolFactoryManager::register_factory (
	ThreadPoolAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
	Singleton::instance()->register_factory_i (factory, priority);
}

void ThreadPoolFactoryManager::register_factory_i (
	ThreadPoolAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey)*/ {
	m_has_registred_factories = true;
	FactoryMap::iterator f = m_factories_map.find(factory->key());
	if (f != m_factories_map.end() && f->second.priority == priority) {
		throw Core::Root::DuplicatedFactoryKey (
			"Core::mt::ThreadPoolFactory"
			, factory->key()
		);
	}
	if (f == m_factories_map.end() || f->second.priority <= priority) {
		m_factories_map[factory->key()].factory = ThreadPoolAbstractFactory::_duplicate(factory);
		m_factories_map[factory->key()].priority = priority;
	}
	
	if (!m_single_active_factory || m_single_active_factory_priority <= priority) {
		m_single_active_factory = ThreadPoolAbstractFactory::_duplicate(factory);
		m_single_active_factory_priority = priority;
	}
}

ThreadPool& ThreadPoolFactoryManager::def () /*throw (Core::Root::NoActiveFactory)*/ {
	if (m_cached_object_for_def.ptr() == 0) {
		GUARD(m_mutex_for_def);
		if (m_cached_object_for_def.ptr() == 0) {
			if (m_single_active_factory.is_nil()) {
				throw Core::Root::NoActiveFactory ("Core::mt::ThreadPoolFactory");
			}
			m_cached_object_for_def = m_single_active_factory->def ();
		
			GDS_ASSERT_MSG (m_cached_object_for_def.ptr() != 0, ("Core::mt::ThreadPoolFactory impl can't return zerro"));
		}
	}
	return *m_cached_object_for_def;
}

ThreadPool* ThreadPoolFactoryManager::make (unsigned long pool_size) /*throw (Core::Root::NoActiveFactory)*/ {
	if (m_single_active_factory.is_nil()) {
		throw Core::Root::NoActiveFactory ("Core::mt::ThreadPoolFactory");
	}
	ThreadPool* ret_ = m_single_active_factory->make (pool_size);
	GDS_ASSERT_MSG (ret_ != 0, ("Core::mt::ThreadPoolFactory impl can't return zerro"));
	return ret_;
}
} // namespace Core

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

