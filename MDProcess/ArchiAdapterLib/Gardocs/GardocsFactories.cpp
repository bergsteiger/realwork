////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/ArchiAdapterLib/Gardocs/GardocsFactories.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Interfaces::Category>> MDProcess::ArchiAdapterLib::Gardocs
//
// Gardoc
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/ArchiAdapterLib/Gardocs/GardocsFactories.h"

namespace ArchiAdapterLib {
namespace Gardocs {

//////////////////////////////////////////////////////////////////////////////////////
// implementation of factory manager methods for Searcher
bool SearcherFactoryManager::s_was_destroyed = false;

SearcherFactoryManager::SearcherFactoryManager () /*throw (Core::Root::FactoryManagerWasDestroyed)*/
	: m_has_registred_factories(false)
{
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
}

SearcherFactoryManager::~SearcherFactoryManager () {
	s_was_destroyed = true;
}

void SearcherFactoryManager::register_factory (
	SearcherAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
	Singleton::instance()->register_factory_i (factory, priority);
}

void SearcherFactoryManager::register_factory_i (
	SearcherAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey)*/ {
	m_has_registred_factories = true;
	FactoryMap::iterator f = m_factories_map.find(factory->key());
	if (f != m_factories_map.end() && f->second.priority == priority) {
		throw Core::Root::DuplicatedFactoryKey (
			"ArchiAdapterLib::Gardocs::SearcherFactory"
			, factory->key()
		);
	}
	if (f == m_factories_map.end() || f->second.priority <= priority) {
		m_factories_map[factory->key()].factory = SearcherAbstractFactory::_duplicate(factory);
		m_factories_map[factory->key()].priority = priority;
	}
	
	if (!m_single_active_factory || m_single_active_factory_priority <= priority) {
		m_single_active_factory = SearcherAbstractFactory::_duplicate(factory);
		m_single_active_factory_priority = priority;
	}
}

Searcher& SearcherFactoryManager::get () /*throw (Core::Root::NoActiveFactory)*/ {
	if (m_cached_object_for_get.ptr() == 0) {
		GUARD(m_mutex_for_get);
		if (m_cached_object_for_get.ptr() == 0) {
			if (m_single_active_factory.is_nil()) {
				throw Core::Root::NoActiveFactory ("ArchiAdapterLib::Gardocs::SearcherFactory");
			}
			m_cached_object_for_get = m_single_active_factory->get ();
		
			GDS_ASSERT_MSG (m_cached_object_for_get.ptr() != 0, ("ArchiAdapterLib::Gardocs::SearcherFactory impl can't return zerro"));
		}
	}
	return *m_cached_object_for_get;
}

//////////////////////////////////////////////////////////////////////////////////////
// implementation of factory manager methods for ArchiEventsListener
bool ArchiEventsListenerFactoryManager::s_was_destroyed = false;

ArchiEventsListenerFactoryManager::ArchiEventsListenerFactoryManager () /*throw (Core::Root::FactoryManagerWasDestroyed)*/
	: m_has_registred_factories(false)
{
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
}

ArchiEventsListenerFactoryManager::~ArchiEventsListenerFactoryManager () {
	s_was_destroyed = true;
}

void ArchiEventsListenerFactoryManager::register_factory (
	ArchiEventsListenerAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
	Singleton::instance()->register_factory_i (factory, priority);
}

void ArchiEventsListenerFactoryManager::register_factory_i (
	ArchiEventsListenerAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey)*/ {
	m_has_registred_factories = true;
	FactoryMap::iterator f = m_factories_map.find(factory->key());
	if (f != m_factories_map.end() && f->second.priority == priority) {
		throw Core::Root::DuplicatedFactoryKey (
			"ArchiAdapterLib::Gardocs::ArchiEventsListenerFactory"
			, factory->key()
		);
	}
	if (f == m_factories_map.end() || f->second.priority <= priority) {
		m_factories_map[factory->key()].factory = ArchiEventsListenerAbstractFactory::_duplicate(factory);
		m_factories_map[factory->key()].priority = priority;
	}
	
	if (!m_single_active_factory || m_single_active_factory_priority <= priority) {
		m_single_active_factory = ArchiEventsListenerAbstractFactory::_duplicate(factory);
		m_single_active_factory_priority = priority;
	}
}

ArchiEventsListener& ArchiEventsListenerFactoryManager::get () /*throw (Core::Root::NoActiveFactory)*/ {
	if (m_cached_object_for_get.ptr() == 0) {
		GUARD(m_mutex_for_get);
		if (m_cached_object_for_get.ptr() == 0) {
			if (m_single_active_factory.is_nil()) {
				throw Core::Root::NoActiveFactory ("ArchiAdapterLib::Gardocs::ArchiEventsListenerFactory");
			}
			m_cached_object_for_get = m_single_active_factory->get ();
		
			GDS_ASSERT_MSG (m_cached_object_for_get.ptr() != 0, ("ArchiAdapterLib::Gardocs::ArchiEventsListenerFactory impl can't return zerro"));
		}
	}
	return *m_cached_object_for_get;
}

//////////////////////////////////////////////////////////////////////////////////////
// implementation of factory manager methods for Searcher2
bool Searcher2FactoryManager::s_was_destroyed = false;

Searcher2FactoryManager::Searcher2FactoryManager () /*throw (Core::Root::FactoryManagerWasDestroyed)*/
	: m_has_registred_factories(false)
{
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
}

Searcher2FactoryManager::~Searcher2FactoryManager () {
	s_was_destroyed = true;
}

void Searcher2FactoryManager::register_factory (
	Searcher2AbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
	Singleton::instance()->register_factory_i (factory, priority);
}

void Searcher2FactoryManager::register_factory_i (
	Searcher2AbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey)*/ {
	m_has_registred_factories = true;
	FactoryMap::iterator f = m_factories_map.find(factory->key());
	if (f != m_factories_map.end() && f->second.priority == priority) {
		throw Core::Root::DuplicatedFactoryKey (
			"ArchiAdapterLib::Gardocs::Searcher2Factory"
			, factory->key()
		);
	}
	if (f == m_factories_map.end() || f->second.priority <= priority) {
		m_factories_map[factory->key()].factory = Searcher2AbstractFactory::_duplicate(factory);
		m_factories_map[factory->key()].priority = priority;
	}
	
	if (!m_single_active_factory || m_single_active_factory_priority <= priority) {
		m_single_active_factory = Searcher2AbstractFactory::_duplicate(factory);
		m_single_active_factory_priority = priority;
	}
}

Searcher2* Searcher2FactoryManager::get () /*throw (Core::Root::NoActiveFactory)*/ {
	if (m_single_active_factory.is_nil()) {
		throw Core::Root::NoActiveFactory ("ArchiAdapterLib::Gardocs::Searcher2Factory");
	}
	Searcher2* ret_ = m_single_active_factory->get ();
	GDS_ASSERT_MSG (ret_ != 0, ("ArchiAdapterLib::Gardocs::Searcher2Factory impl can't return zerro"));
	return ret_;
}

//////////////////////////////////////////////////////////////////////////////////////
// implementation of factory manager methods for Utils
bool UtilsFactoryManager::s_was_destroyed = false;

UtilsFactoryManager::UtilsFactoryManager () /*throw (Core::Root::FactoryManagerWasDestroyed)*/
	: m_has_registred_factories(false)
{
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
}

UtilsFactoryManager::~UtilsFactoryManager () {
	s_was_destroyed = true;
}

void UtilsFactoryManager::register_factory (
	UtilsAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
	Singleton::instance()->register_factory_i (factory, priority);
}

void UtilsFactoryManager::register_factory_i (
	UtilsAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey)*/ {
	m_has_registred_factories = true;
	FactoryMap::iterator f = m_factories_map.find(factory->key());
	if (f != m_factories_map.end() && f->second.priority == priority) {
		throw Core::Root::DuplicatedFactoryKey (
			"ArchiAdapterLib::Gardocs::UtilsFactory"
			, factory->key()
		);
	}
	if (f == m_factories_map.end() || f->second.priority <= priority) {
		m_factories_map[factory->key()].factory = UtilsAbstractFactory::_duplicate(factory);
		m_factories_map[factory->key()].priority = priority;
	}
	
	if (!m_single_active_factory || m_single_active_factory_priority <= priority) {
		m_single_active_factory = UtilsAbstractFactory::_duplicate(factory);
		m_single_active_factory_priority = priority;
	}
}

Utils* UtilsFactoryManager::get () /*throw (Core::Root::NoActiveFactory)*/ {
	if (m_single_active_factory.is_nil()) {
		throw Core::Root::NoActiveFactory ("ArchiAdapterLib::Gardocs::UtilsFactory");
	}
	Utils* ret_ = m_single_active_factory->get ();
	GDS_ASSERT_MSG (ret_ != 0, ("ArchiAdapterLib::Gardocs::UtilsFactory impl can't return zerro"));
	return ret_;
}

//////////////////////////////////////////////////////////////////////////////////////
// implementation of factory manager methods for GardocGetter
bool GardocGetterFactoryManager::s_was_destroyed = false;

GardocGetterFactoryManager::GardocGetterFactoryManager () /*throw (Core::Root::FactoryManagerWasDestroyed)*/
	: m_has_registred_factories(false)
{
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
}

GardocGetterFactoryManager::~GardocGetterFactoryManager () {
	s_was_destroyed = true;
}

void GardocGetterFactoryManager::register_factory (
	GardocGetterAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
	Singleton::instance()->register_factory_i (factory, priority);
}

void GardocGetterFactoryManager::register_factory_i (
	GardocGetterAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey)*/ {
	m_has_registred_factories = true;
	FactoryMap::iterator f = m_factories_map.find(factory->key());
	if (f != m_factories_map.end() && f->second.priority == priority) {
		throw Core::Root::DuplicatedFactoryKey (
			"ArchiAdapterLib::Gardocs::GardocGetterFactory"
			, factory->key()
		);
	}
	if (f == m_factories_map.end() || f->second.priority <= priority) {
		m_factories_map[factory->key()].factory = GardocGetterAbstractFactory::_duplicate(factory);
		m_factories_map[factory->key()].priority = priority;
	}
	
	if (!m_single_active_factory || m_single_active_factory_priority <= priority) {
		m_single_active_factory = GardocGetterAbstractFactory::_duplicate(factory);
		m_single_active_factory_priority = priority;
	}
}

GardocGetter* GardocGetterFactoryManager::get () /*throw (Core::Root::NoActiveFactory)*/ {
	if (m_single_active_factory.is_nil()) {
		throw Core::Root::NoActiveFactory ("ArchiAdapterLib::Gardocs::GardocGetterFactory");
	}
	GardocGetter* ret_ = m_single_active_factory->get ();
	GDS_ASSERT_MSG (ret_ != 0, ("ArchiAdapterLib::Gardocs::GardocGetterFactory impl can't return zerro"));
	return ret_;
}
} // namespace Gardocs
} // namespace ArchiAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

