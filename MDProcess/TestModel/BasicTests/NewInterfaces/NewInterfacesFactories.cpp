////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/TestModel/BasicTests/NewInterfaces/NewInterfacesFactories.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Interfaces::Category>> TestModel::BasicTests::NewInterfaces
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/Core/sys/std_inc.h"
#include "boost/lexical_cast.hpp"
#include "TestModel/BasicTests/NewInterfaces/NewInterfacesFactories.h"

namespace BasicTests {
namespace NewInterfaces {


//////////////////////////////////////////////////////////////////////////////////////
// implementation of factory manager methods for DerivedInterface
bool DerivedInterfaceFactoryManager::s_was_destroyed = false;

DerivedInterfaceFactoryManager::DerivedInterfaceFactoryManager () /*throw (Core::Root::FactoryManagerWasDestroyed)*/
	: m_has_registred_factories(false)
{
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
}

DerivedInterfaceFactoryManager::~DerivedInterfaceFactoryManager () {
	s_was_destroyed = true;
}

void DerivedInterfaceFactoryManager::register_factory (
	DerivedInterfaceAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
	Singleton::instance()->register_factory_i (factory, priority);
}

void DerivedInterfaceFactoryManager::register_factory_i (
	DerivedInterfaceAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey)*/ {
	m_has_registred_factories = true;
	FactoryMap::iterator f = m_factories_map.find(factory->key());
	if (f != m_factories_map.end() && f->second.priority == priority) {
		throw Core::Root::DuplicatedFactoryKey (
			"BasicTests::NewInterfaces::DerivedInterfaceFactory"
			, factory->key()
		);
	}
	if (f == m_factories_map.end() || f->second.priority <= priority) {
		m_factories_map[factory->key()].factory = DerivedInterfaceAbstractFactory::_duplicate(factory);
		m_factories_map[factory->key()].priority = priority;
	}
	
	if (!m_single_active_factory || m_single_active_factory_priority <= priority) {
		m_single_active_factory = DerivedInterfaceAbstractFactory::_duplicate(factory);
		m_single_active_factory_priority = priority;
	}
}

DerivedInterface* DerivedInterfaceFactoryManager::factory () /*throw (Core::Root::NoActiveFactory)*/ {
	if (m_single_active_factory.is_nil()) {
		throw Core::Root::NoActiveFactory ("BasicTests::NewInterfaces::DerivedInterfaceFactory");
	}
	DerivedInterface* ret_ = m_single_active_factory->factory ();
	GDS_ASSERT_MSG (ret_ != 0, ("BasicTests::NewInterfaces::DerivedInterfaceFactory impl can't return zerro"));
	return ret_;
}


//////////////////////////////////////////////////////////////////////////////////////
// implementation of factory manager methods for BaseInterface1
bool BaseInterface1FactoryManager::s_was_destroyed = false;

BaseInterface1FactoryManager::BaseInterface1FactoryManager () /*throw (Core::Root::FactoryManagerWasDestroyed)*/
	: m_has_registred_factories(false)
{
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
}

BaseInterface1FactoryManager::~BaseInterface1FactoryManager () {
	s_was_destroyed = true;
}

void BaseInterface1FactoryManager::register_factory (
	BaseInterface1AbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
	Singleton::instance()->register_factory_i (factory, priority);
}

void BaseInterface1FactoryManager::register_factory_i (
	BaseInterface1AbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey)*/ {
	m_has_registred_factories = true;
	FactoryMap::iterator f = m_factories_map.find(factory->key());
	if (f != m_factories_map.end() && f->second.priority == priority) {
		throw Core::Root::DuplicatedFactoryKey (
			"BasicTests::NewInterfaces::BaseInterface1Factory"
			, boost::lexical_cast<std::string> (factory->key()).c_str ()
		);
	}
	if (f == m_factories_map.end() || f->second.priority <= priority) {
		m_factories_map[factory->key()].factory = BaseInterface1AbstractFactory::_duplicate(factory);
		m_factories_map[factory->key()].priority = priority;
	}
	
	if (!m_single_active_factory || m_single_active_factory_priority <= priority) {
		m_single_active_factory = BaseInterface1AbstractFactory::_duplicate(factory);
		m_single_active_factory_priority = priority;
	}
}

BaseInterface1* BaseInterface1FactoryManager::make (MultiSelector key) /*throw (Core::Root::UnknownFactoryKey)*/ {
	FactoryMap::iterator f = m_factories_map.find (key);
	if (f == m_factories_map.end()) {
		throw Core::Root::UnknownFactoryKey (
			"BasicTests::NewInterfaces::AbstractInterfaceFactory"
			, boost::lexical_cast<std::string> (key).c_str ()
		);
	}
	return f->second.factory->make ();
}

//////////////////////////////////////////////////////////////////////////////////////
// implementation of factory manager methods for DerivedInterface1
bool DerivedInterface1FactoryManager::s_was_destroyed = false;

DerivedInterface1FactoryManager::DerivedInterface1FactoryManager () /*throw (Core::Root::FactoryManagerWasDestroyed)*/
	: m_has_registred_factories(false)
{
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
}

DerivedInterface1FactoryManager::~DerivedInterface1FactoryManager () {
	s_was_destroyed = true;
}

void DerivedInterface1FactoryManager::register_factory (
	DerivedInterface1AbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
	Singleton::instance()->register_factory_i (factory, priority);
}

void DerivedInterface1FactoryManager::register_factory_i (
	DerivedInterface1AbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey)*/ {
	m_has_registred_factories = true;
	FactoryMap::iterator f = m_factories_map.find(factory->key());
	if (f != m_factories_map.end() && f->second.priority == priority) {
		throw Core::Root::DuplicatedFactoryKey (
			"BasicTests::NewInterfaces::DerivedInterface1Factory"
			, boost::lexical_cast<std::string> (factory->key()).c_str ()
		);
	}
	if (f == m_factories_map.end() || f->second.priority <= priority) {
		m_factories_map[factory->key()].factory = DerivedInterface1AbstractFactory::_duplicate(factory);
		m_factories_map[factory->key()].priority = priority;
	}
	
	if (!m_single_active_factory || m_single_active_factory_priority <= priority) {
		m_single_active_factory = DerivedInterface1AbstractFactory::_duplicate(factory);
		m_single_active_factory_priority = priority;
	}
}

DerivedInterface1* DerivedInterface1FactoryManager::make_derived (MultiSelector key) /*throw (Core::Root::UnknownFactoryKey)*/ {
	FactoryMap::iterator f = m_factories_map.find (key);
	if (f == m_factories_map.end()) {
		throw Core::Root::UnknownFactoryKey (
			"BasicTests::NewInterfaces::DerivedInterface1Factory"
			, boost::lexical_cast<std::string> (key).c_str ()
		);
	}
	return f->second.factory->make_derived ();
}

DerivedInterface1* DerivedInterface1FactoryManager::make (MultiSelector key) /*throw (Core::Root::UnknownFactoryKey)*/ {
	FactoryMap::iterator f = m_factories_map.find (key);
	if (f == m_factories_map.end()) {
		throw Core::Root::UnknownFactoryKey (
			"BasicTests::NewInterfaces::AbstractInterfaceFactory"
			, boost::lexical_cast<std::string> (key).c_str ()
		);
	}
	return f->second.factory->make ();
}
} // namespace NewInterfaces
} // namespace BasicTests

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

