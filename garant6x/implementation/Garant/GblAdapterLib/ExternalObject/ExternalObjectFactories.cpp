////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/ExternalObject/ExternalObjectFactories.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::ExternalObject
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/ExternalObject/ExternalObjectFactories.h"

namespace GblAdapterLib {

//////////////////////////////////////////////////////////////////////////////////////
// implementation of factory manager methods for ExternalLink
bool ExternalLinkFactoryManager::s_was_destroyed = false;

ExternalLinkFactoryManager::ExternalLinkFactoryManager () /*throw (Core::Root::FactoryManagerWasDestroyed)*/
	: m_has_registred_factories(false)
{
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
}

ExternalLinkFactoryManager::~ExternalLinkFactoryManager () {
	s_was_destroyed = true;
}

void ExternalLinkFactoryManager::register_factory (
	ExternalLinkAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
	Singleton::instance()->register_factory_i (factory, priority);
}

void ExternalLinkFactoryManager::register_factory_i (
	ExternalLinkAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey)*/ {
	m_has_registred_factories = true;
	FactoryMap::iterator f = m_factories_map.find(factory->key());
	if (f != m_factories_map.end() && f->second.priority == priority) {
		throw Core::Root::DuplicatedFactoryKey (
			"GblAdapterLib::ExternalObject::ExternalLinkFactory"
			, factory->key()
		);
	}
	if (f == m_factories_map.end() || f->second.priority <= priority) {
		m_factories_map[factory->key()].factory = ExternalLinkAbstractFactory::_duplicate(factory);
		m_factories_map[factory->key()].priority = priority;
	}
	
	if (!m_single_active_factory || m_single_active_factory_priority <= priority) {
		m_single_active_factory = ExternalLinkAbstractFactory::_duplicate(factory);
		m_single_active_factory_priority = priority;
	}
}

ExternalLink* ExternalLinkFactoryManager::make (const char* url) /*throw (Core::Root::NoActiveFactory)*/ {
	if (m_single_active_factory.is_nil()) {
		throw Core::Root::NoActiveFactory ("GblAdapterLib::ExternalObject::ExternalLinkFactory");
	}
	ExternalLink* ret_ = m_single_active_factory->make (url);
	GDS_ASSERT_MSG (ret_ != 0, ("GblAdapterLib::ExternalObject::ExternalLinkFactory impl can't return zerro"));
	return ret_;
}

//////////////////////////////////////////////////////////////////////////////////////
// implementation of factory manager methods for ExternalObject
bool ExternalObjectFactoryManager::s_was_destroyed = false;

ExternalObjectFactoryManager::ExternalObjectFactoryManager () /*throw (Core::Root::FactoryManagerWasDestroyed)*/
	: m_has_registred_factories(false)
{
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
}

ExternalObjectFactoryManager::~ExternalObjectFactoryManager () {
	s_was_destroyed = true;
}

void ExternalObjectFactoryManager::register_factory (
	ExternalObjectAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
	Singleton::instance()->register_factory_i (factory, priority);
}

void ExternalObjectFactoryManager::register_factory_i (
	ExternalObjectAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey)*/ {
	m_has_registred_factories = true;
	FactoryMap::iterator f = m_factories_map.find(factory->key());
	if (f != m_factories_map.end() && f->second.priority == priority) {
		throw Core::Root::DuplicatedFactoryKey (
			"GblAdapterLib::ExternalObject::ExternalObjectFactory"
			, factory->key()
		);
	}
	if (f == m_factories_map.end() || f->second.priority <= priority) {
		m_factories_map[factory->key()].factory = ExternalObjectAbstractFactory::_duplicate(factory);
		m_factories_map[factory->key()].priority = priority;
	}
	
	if (!m_single_active_factory || m_single_active_factory_priority <= priority) {
		m_single_active_factory = ExternalObjectAbstractFactory::_duplicate(factory);
		m_single_active_factory_priority = priority;
	}
}

ExternalObject* ExternalObjectFactoryManager::make () /*throw (Core::Root::NoActiveFactory)*/ {
	if (m_single_active_factory.is_nil()) {
		throw Core::Root::NoActiveFactory ("GblAdapterLib::ExternalObject::ExternalObjectFactory");
	}
	ExternalObject* ret_ = m_single_active_factory->make ();
	GDS_ASSERT_MSG (ret_ != 0, ("GblAdapterLib::ExternalObject::ExternalObjectFactory impl can't return zerro"));
	return ret_;
}

ExternalObject* ExternalObjectFactoryManager::make (GblPilot::InternalObj* obj) /*throw (Core::Root::NoActiveFactory)*/ {
	if (m_single_active_factory.is_nil()) {
		throw Core::Root::NoActiveFactory ("GblAdapterLib::ExternalObject::ExternalObjectFactory");
	}
	ExternalObject* ret_ = m_single_active_factory->make (obj);
	GDS_ASSERT_MSG (ret_ != 0, ("GblAdapterLib::ExternalObject::ExternalObjectFactory impl can't return zerro"));
	return ret_;
}

//////////////////////////////////////////////////////////////////////////////////////
// implementation of factory manager methods for SplashScreen
bool SplashScreenFactoryManager::s_was_destroyed = false;

SplashScreenFactoryManager::SplashScreenFactoryManager () /*throw (Core::Root::FactoryManagerWasDestroyed)*/
	: m_has_registred_factories(false)
{
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
}

SplashScreenFactoryManager::~SplashScreenFactoryManager () {
	s_was_destroyed = true;
}

void SplashScreenFactoryManager::register_factory (
	SplashScreenAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
	Singleton::instance()->register_factory_i (factory, priority);
}

void SplashScreenFactoryManager::register_factory_i (
	SplashScreenAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey)*/ {
	m_has_registred_factories = true;
	FactoryMap::iterator f = m_factories_map.find(factory->key());
	if (f != m_factories_map.end() && f->second.priority == priority) {
		throw Core::Root::DuplicatedFactoryKey (
			"GblAdapterLib::ExternalObject::SplashScreenFactory"
			, factory->key()
		);
	}
	if (f == m_factories_map.end() || f->second.priority <= priority) {
		m_factories_map[factory->key()].factory = SplashScreenAbstractFactory::_duplicate(factory);
		m_factories_map[factory->key()].priority = priority;
	}
	
	if (!m_single_active_factory || m_single_active_factory_priority <= priority) {
		m_single_active_factory = SplashScreenAbstractFactory::_duplicate(factory);
		m_single_active_factory_priority = priority;
	}
}

SplashScreen* SplashScreenFactoryManager::make (bool is_start, short x, short y, bool flash_available) /*throw (Core::Root::NoActiveFactory, CanNotFindData)*/ {
	if (m_single_active_factory.is_nil()) {
		throw Core::Root::NoActiveFactory ("GblAdapterLib::ExternalObject::SplashScreenFactory");
	}
	SplashScreen* ret_ = m_single_active_factory->make (is_start, x, y, flash_available);
	GDS_ASSERT_MSG (ret_ != 0, ("GblAdapterLib::ExternalObject::SplashScreenFactory impl can't return zerro"));
	return ret_;
}
} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

