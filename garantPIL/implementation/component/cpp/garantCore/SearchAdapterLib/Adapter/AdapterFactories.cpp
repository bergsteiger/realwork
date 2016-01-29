////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garantPIL/implementation/component/cpp/garantCore/SearchAdapterLib/Adapter/AdapterFactories.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Interfaces::Category>> garantCore::SearchAdapterLib::Adapter
//
// Интерфейсы и типы поискового адаптера
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/Core/sys/std_inc.h"
#include "garantCore/SearchAdapterLib/Adapter/AdapterFactories.h"

namespace SearchAdapterLib {
namespace Adapter {

//////////////////////////////////////////////////////////////////////////////////////
// implementation of factory manager methods for ISearcher
bool ISearcherFactoryManager::s_was_destroyed = false;

ISearcherFactoryManager::ISearcherFactoryManager () /*throw (Core::Root::FactoryManagerWasDestroyed)*/
	: m_has_registred_factories(false)
{
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
}

ISearcherFactoryManager::~ISearcherFactoryManager () {
	s_was_destroyed = true;
}

void ISearcherFactoryManager::register_factory (
	ISearcherAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
	Singleton::instance()->register_factory_i (factory, priority);
}

void ISearcherFactoryManager::register_factory_i (
	ISearcherAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey)*/ {
	m_has_registred_factories = true;
	FactoryMap::iterator f = m_factories_map.find(factory->key());
	if (f != m_factories_map.end() && f->second.priority == priority) {
		throw Core::Root::DuplicatedFactoryKey (
			"SearchAdapterLib::Adapter::ISearcherFactory"
			, factory->key()
		);
	}
	if (f == m_factories_map.end() || f->second.priority <= priority) {
		m_factories_map[factory->key()].factory = ISearcherAbstractFactory::_duplicate(factory);
		m_factories_map[factory->key()].priority = priority;
	}
	
	if (!m_single_active_factory || m_single_active_factory_priority <= priority) {
		m_single_active_factory = ISearcherAbstractFactory::_duplicate(factory);
		m_single_active_factory_priority = priority;
	}
}

ISearcher* ISearcherFactoryManager::make (DBCore::IBase* base, Morpho::Def::ICache* cache, const std::string& src) /*throw (Core::Root::NoActiveFactory)*/ {
	if (m_single_active_factory.is_nil()) {
		throw Core::Root::NoActiveFactory ("SearchAdapterLib::Adapter::ISearcherFactory");
	}
	ISearcher* ret_ = m_single_active_factory->make (base, cache, src);
	GDS_ASSERT_MSG (ret_ != 0, ("SearchAdapterLib::Adapter::ISearcherFactory impl can't return zerro"));
	return ret_;
}

//////////////////////////////////////////////////////////////////////////////////////
// implementation of factory manager methods for IHelper
bool IHelperFactoryManager::s_was_destroyed = false;

IHelperFactoryManager::IHelperFactoryManager () /*throw (Core::Root::FactoryManagerWasDestroyed)*/
	: m_has_registred_factories(false)
{
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
}

IHelperFactoryManager::~IHelperFactoryManager () {
	s_was_destroyed = true;
}

void IHelperFactoryManager::register_factory (
	IHelperAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
	Singleton::instance()->register_factory_i (factory, priority);
}

void IHelperFactoryManager::register_factory_i (
	IHelperAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey)*/ {
	m_has_registred_factories = true;
	FactoryMap::iterator f = m_factories_map.find(factory->key());
	if (f != m_factories_map.end() && f->second.priority == priority) {
		throw Core::Root::DuplicatedFactoryKey (
			"SearchAdapterLib::Adapter::IHelperFactory"
			, factory->key()
		);
	}
	if (f == m_factories_map.end() || f->second.priority <= priority) {
		m_factories_map[factory->key()].factory = IHelperAbstractFactory::_duplicate(factory);
		m_factories_map[factory->key()].priority = priority;
	}
	
	if (!m_single_active_factory || m_single_active_factory_priority <= priority) {
		m_single_active_factory = IHelperAbstractFactory::_duplicate(factory);
		m_single_active_factory_priority = priority;
	}
}

IHelper* IHelperFactoryManager::make (Morpho::Def::ICache* cache) /*throw (Core::Root::NoActiveFactory)*/ {
	if (m_single_active_factory.is_nil()) {
		throw Core::Root::NoActiveFactory ("SearchAdapterLib::Adapter::IHelperFactory");
	}
	IHelper* ret_ = m_single_active_factory->make (cache);
	GDS_ASSERT_MSG (ret_ != 0, ("SearchAdapterLib::Adapter::IHelperFactory impl can't return zerro"));
	return ret_;
}

//////////////////////////////////////////////////////////////////////////////////////
// implementation of factory manager methods for IAdapter
bool IAdapterFactoryManager::s_was_destroyed = false;

IAdapterFactoryManager::IAdapterFactoryManager () /*throw (Core::Root::FactoryManagerWasDestroyed)*/
	: m_has_registred_factories(false)
{
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
}

IAdapterFactoryManager::~IAdapterFactoryManager () {
	s_was_destroyed = true;
}

void IAdapterFactoryManager::register_factory (
	IAdapterAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
	Singleton::instance()->register_factory_i (factory, priority);
}

void IAdapterFactoryManager::register_factory_i (
	IAdapterAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey)*/ {
	m_has_registred_factories = true;
	FactoryMap::iterator f = m_factories_map.find(factory->key());
	if (f != m_factories_map.end() && f->second.priority == priority) {
		throw Core::Root::DuplicatedFactoryKey (
			"SearchAdapterLib::Adapter::IAdapterFactory"
			, factory->key()
		);
	}
	if (f == m_factories_map.end() || f->second.priority <= priority) {
		m_factories_map[factory->key()].factory = IAdapterAbstractFactory::_duplicate(factory);
		m_factories_map[factory->key()].priority = priority;
	}
	
	if (!m_single_active_factory || m_single_active_factory_priority <= priority) {
		m_single_active_factory = IAdapterAbstractFactory::_duplicate(factory);
		m_single_active_factory_priority = priority;
	}
}

IAdapter& IAdapterFactoryManager::instance () /*throw (Core::Root::NoActiveFactory)*/ {
	if (m_cached_object_for_instance.ptr() == 0) {
		GUARD(m_mutex_for_instance);
		if (m_cached_object_for_instance.ptr() == 0) {
			if (m_single_active_factory.is_nil()) {
				throw Core::Root::NoActiveFactory ("SearchAdapterLib::Adapter::IAdapterFactory");
			}
			m_cached_object_for_instance = m_single_active_factory->instance ();
		
			GDS_ASSERT_MSG (m_cached_object_for_instance.ptr() != 0, ("SearchAdapterLib::Adapter::IAdapterFactory impl can't return zerro"));
		}
	}
	return *m_cached_object_for_instance;
}
} // namespace Adapter
} // namespace SearchAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

