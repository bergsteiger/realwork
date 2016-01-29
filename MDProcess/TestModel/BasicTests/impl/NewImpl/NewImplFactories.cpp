////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/TestModel/BasicTests/impl/NewImpl/NewImplFactories.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Impl::Category>> TestModel::BasicTests::NewImpl
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/Core/sys/std_inc.h"
#include "TestModel/BasicTests/impl/NewImpl/NewImplFactories.h"

namespace BasicTests {
namespace NewImpl {


//////////////////////////////////////////////////////////////////////////////////////
// implementation of factory manager methods for DerivedLocal
bool DerivedLocalFactoryManager::s_was_destroyed = false;

DerivedLocalFactoryManager::DerivedLocalFactoryManager () /*throw (Core::Root::FactoryManagerWasDestroyed)*/
	: m_has_registred_factories(false)
{
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
}

DerivedLocalFactoryManager::~DerivedLocalFactoryManager () {
	s_was_destroyed = true;
}

void DerivedLocalFactoryManager::register_factory (
	DerivedLocalAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
	Singleton::instance()->register_factory_i (factory, priority);
	NewInterfaces::DerivedInterfaceFactoryManager::register_factory (factory, priority);
	
}

void DerivedLocalFactoryManager::register_factory_i (
	DerivedLocalAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey)*/ {
	m_has_registred_factories = true;
	FactoryMap::iterator f = m_factories_map.find(factory->key());
	if (f != m_factories_map.end() && f->second.priority == priority) {
		throw Core::Root::DuplicatedFactoryKey (
			"BasicTests::NewImpl::DerivedLocalFactory"
			, factory->key()
		);
	}
	if (f == m_factories_map.end() || f->second.priority <= priority) {
		m_factories_map[factory->key()].factory = DerivedLocalAbstractFactory::_duplicate(factory);
		m_factories_map[factory->key()].priority = priority;
	}
	
	if (!m_single_active_factory || m_single_active_factory_priority <= priority) {
		m_single_active_factory = DerivedLocalAbstractFactory::_duplicate(factory);
		m_single_active_factory_priority = priority;
	}
}
} // namespace NewImpl
} // namespace BasicTests

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

