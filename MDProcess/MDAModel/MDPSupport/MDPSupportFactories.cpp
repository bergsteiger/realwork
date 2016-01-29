////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/MDPSupport/MDPSupportFactories.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Interfaces::Category>> MDProcess::MDAModel::MDPSupport
//
// интерфейсы для  работы с сервером залочек
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/MDPSupport/MDPSupportFactories.h"

namespace MDPSupport {

//////////////////////////////////////////////////////////////////////////////////////
// implementation of factory manager methods for CatLocker
bool CatLockerFactoryManager::s_was_destroyed = false;

CatLockerFactoryManager::CatLockerFactoryManager () /*throw (Core::Root::FactoryManagerWasDestroyed)*/
	: m_has_registred_factories(false)
{
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
}

CatLockerFactoryManager::~CatLockerFactoryManager () {
	s_was_destroyed = true;
}

void CatLockerFactoryManager::register_factory (
	CatLockerAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
	Singleton::instance()->register_factory_i (factory, priority);
}

void CatLockerFactoryManager::register_factory_i (
	CatLockerAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey)*/ {
	m_has_registred_factories = true;
	FactoryMap::iterator f = m_factories_map.find(factory->key());
	if (f != m_factories_map.end() && f->second.priority == priority) {
		throw Core::Root::DuplicatedFactoryKey (
			"MDAModel::MDPSupport::CatLockerFactory"
			, factory->key()
		);
	}
	if (f == m_factories_map.end() || f->second.priority <= priority) {
		m_factories_map[factory->key()].factory = CatLockerAbstractFactory::_duplicate(factory);
		m_factories_map[factory->key()].priority = priority;
	}
	
	if (!m_single_active_factory || m_single_active_factory_priority <= priority) {
		m_single_active_factory = CatLockerAbstractFactory::_duplicate(factory);
		m_single_active_factory_priority = priority;
	}
}

CatLocker* CatLockerFactoryManager::make (IRoseCategoryPtr cat) /*throw (Core::Root::NoActiveFactory)*/ {
	if (m_single_active_factory.is_nil()) {
		throw Core::Root::NoActiveFactory ("MDAModel::MDPSupport::CatLockerFactory");
	}
	CatLocker* ret_ = m_single_active_factory->make (cat);
	GDS_ASSERT_MSG (ret_ != 0, ("MDAModel::MDPSupport::CatLockerFactory impl can't return zerro"));
	return ret_;
}

//////////////////////////////////////////////////////////////////////////////////////
// implementation of factory manager methods for MDPFacade
bool MDPFacadeFactoryManager::s_was_destroyed = false;

MDPFacadeFactoryManager::MDPFacadeFactoryManager () /*throw (Core::Root::FactoryManagerWasDestroyed)*/
	: m_has_registred_factories(false)
{
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
}

MDPFacadeFactoryManager::~MDPFacadeFactoryManager () {
	s_was_destroyed = true;
}

void MDPFacadeFactoryManager::register_factory (
	MDPFacadeAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
	Singleton::instance()->register_factory_i (factory, priority);
}

void MDPFacadeFactoryManager::register_factory_i (
	MDPFacadeAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey)*/ {
	m_has_registred_factories = true;
	FactoryMap::iterator f = m_factories_map.find(factory->key());
	if (f != m_factories_map.end() && f->second.priority == priority) {
		throw Core::Root::DuplicatedFactoryKey (
			"MDAModel::MDPSupport::MDPFacadeFactory"
			, factory->key()
		);
	}
	if (f == m_factories_map.end() || f->second.priority <= priority) {
		m_factories_map[factory->key()].factory = MDPFacadeAbstractFactory::_duplicate(factory);
		m_factories_map[factory->key()].priority = priority;
	}
	
	if (!m_single_active_factory || m_single_active_factory_priority <= priority) {
		m_single_active_factory = MDPFacadeAbstractFactory::_duplicate(factory);
		m_single_active_factory_priority = priority;
	}
}

MDPFacade& MDPFacadeFactoryManager::get () /*throw (Core::Root::NoActiveFactory)*/ {
	if (m_cached_object_for_get.ptr() == 0) {
		GUARD(m_mutex_for_get);
		if (m_cached_object_for_get.ptr() == 0) {
			if (m_single_active_factory.is_nil()) {
				throw Core::Root::NoActiveFactory ("MDAModel::MDPSupport::MDPFacadeFactory");
			}
			m_cached_object_for_get = m_single_active_factory->get ();
		
			GDS_ASSERT_MSG (m_cached_object_for_get.ptr() != 0, ("MDAModel::MDPSupport::MDPFacadeFactory impl can't return zerro"));
		}
	}
	return *m_cached_object_for_get;
}

//////////////////////////////////////////////////////////////////////////////////////
// implementation of factory manager methods for CatLockerFacade
bool CatLockerFacadeFactoryManager::s_was_destroyed = false;

CatLockerFacadeFactoryManager::CatLockerFacadeFactoryManager () /*throw (Core::Root::FactoryManagerWasDestroyed)*/
	: m_has_registred_factories(false)
{
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
}

CatLockerFacadeFactoryManager::~CatLockerFacadeFactoryManager () {
	s_was_destroyed = true;
}

void CatLockerFacadeFactoryManager::register_factory (
	CatLockerFacadeAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
	Singleton::instance()->register_factory_i (factory, priority);
}

void CatLockerFacadeFactoryManager::register_factory_i (
	CatLockerFacadeAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey)*/ {
	m_has_registred_factories = true;
	FactoryMap::iterator f = m_factories_map.find(factory->key());
	if (f != m_factories_map.end() && f->second.priority == priority) {
		throw Core::Root::DuplicatedFactoryKey (
			"MDAModel::MDPSupport::CatLockerFacadeFactory"
			, factory->key()
		);
	}
	if (f == m_factories_map.end() || f->second.priority <= priority) {
		m_factories_map[factory->key()].factory = CatLockerFacadeAbstractFactory::_duplicate(factory);
		m_factories_map[factory->key()].priority = priority;
	}
	
	if (!m_single_active_factory || m_single_active_factory_priority <= priority) {
		m_single_active_factory = CatLockerFacadeAbstractFactory::_duplicate(factory);
		m_single_active_factory_priority = priority;
	}
}

CatLockerFacade* CatLockerFacadeFactoryManager::make (IRoseCategoryPtr cat) /*throw (Core::Root::NoActiveFactory)*/ {
	if (m_single_active_factory.is_nil()) {
		throw Core::Root::NoActiveFactory ("MDAModel::MDPSupport::CatLockerFacadeFactory");
	}
	CatLockerFacade* ret_ = m_single_active_factory->make (cat);
	GDS_ASSERT_MSG (ret_ != 0, ("MDAModel::MDPSupport::CatLockerFacadeFactory impl can't return zerro"));
	return ret_;
}

CatLockerFacade* CatLockerFacadeFactoryManager::make (IRoseElementPtr elem) /*throw (Core::Root::NoActiveFactory)*/ {
	if (m_single_active_factory.is_nil()) {
		throw Core::Root::NoActiveFactory ("MDAModel::MDPSupport::CatLockerFacadeFactory");
	}
	CatLockerFacade* ret_ = m_single_active_factory->make (elem);
	GDS_ASSERT_MSG (ret_ != 0, ("MDAModel::MDPSupport::CatLockerFacadeFactory impl can't return zerro"));
	return ret_;
}

//////////////////////////////////////////////////////////////////////////////////////
// implementation of factory manager methods for CatsContainer
bool CatsContainerFactoryManager::s_was_destroyed = false;

CatsContainerFactoryManager::CatsContainerFactoryManager () /*throw (Core::Root::FactoryManagerWasDestroyed)*/
	: m_has_registred_factories(false)
{
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
}

CatsContainerFactoryManager::~CatsContainerFactoryManager () {
	s_was_destroyed = true;
}

void CatsContainerFactoryManager::register_factory (
	CatsContainerAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
	Singleton::instance()->register_factory_i (factory, priority);
}

void CatsContainerFactoryManager::register_factory_i (
	CatsContainerAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey)*/ {
	m_has_registred_factories = true;
	FactoryMap::iterator f = m_factories_map.find(factory->key());
	if (f != m_factories_map.end() && f->second.priority == priority) {
		throw Core::Root::DuplicatedFactoryKey (
			"MDAModel::MDPSupport::CatsContainerFactory"
			, factory->key()
		);
	}
	if (f == m_factories_map.end() || f->second.priority <= priority) {
		m_factories_map[factory->key()].factory = CatsContainerAbstractFactory::_duplicate(factory);
		m_factories_map[factory->key()].priority = priority;
	}
	
	if (!m_single_active_factory || m_single_active_factory_priority <= priority) {
		m_single_active_factory = CatsContainerAbstractFactory::_duplicate(factory);
		m_single_active_factory_priority = priority;
	}
}

CatsContainer& CatsContainerFactoryManager::get () /*throw (Core::Root::NoActiveFactory)*/ {
	if (m_cached_object_for_get.ptr() == 0) {
		GUARD(m_mutex_for_get);
		if (m_cached_object_for_get.ptr() == 0) {
			if (m_single_active_factory.is_nil()) {
				throw Core::Root::NoActiveFactory ("MDAModel::MDPSupport::CatsContainerFactory");
			}
			m_cached_object_for_get = m_single_active_factory->get ();
		
			GDS_ASSERT_MSG (m_cached_object_for_get.ptr() != 0, ("MDAModel::MDPSupport::CatsContainerFactory impl can't return zerro"));
		}
	}
	return *m_cached_object_for_get;
}
} // namespace MDPSupport

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

