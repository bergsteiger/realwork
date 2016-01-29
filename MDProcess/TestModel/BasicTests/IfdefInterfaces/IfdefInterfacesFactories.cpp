////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/TestModel/BasicTests/IfdefInterfaces/IfdefInterfacesFactories.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Interfaces::Category>> TestModel::BasicTests::IfdefInterfaces
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/Core/sys/std_inc.h"
#include "TestModel/BasicTests/IfdefInterfaces/IfdefInterfacesFactories.h"

#if defined(WIN32)
namespace BasicTests {
namespace IfdefInterfaces {
#if defined(ACE_HAS_WINNT4) && defined(WIN32)

//////////////////////////////////////////////////////////////////////////////////////
// implementation of factory manager methods for TestInterface
bool TestInterfaceFactoryManager::s_was_destroyed = false;

TestInterfaceFactoryManager::TestInterfaceFactoryManager () /*throw (Core::Root::FactoryManagerWasDestroyed)*/
	: m_has_registred_factories(false)
{
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
}

TestInterfaceFactoryManager::~TestInterfaceFactoryManager () {
	s_was_destroyed = true;
}

void TestInterfaceFactoryManager::register_factory (
	TestInterfaceAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
	Singleton::instance()->register_factory_i (factory, priority);
}

void TestInterfaceFactoryManager::register_factory_i (
	TestInterfaceAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey)*/ {
	m_has_registred_factories = true;
	FactoryMap::iterator f = m_factories_map.find(factory->key());
	if (f != m_factories_map.end() && f->second.priority == priority) {
		throw Core::Root::DuplicatedFactoryKey (
			"BasicTests::IfdefInterfaces::TestInterfaceFactory"
			, factory->key()
		);
	}
	if (f == m_factories_map.end() || f->second.priority <= priority) {
		m_factories_map[factory->key()].factory = TestInterfaceAbstractFactory::_duplicate(factory);
		m_factories_map[factory->key()].priority = priority;
	}
	
	if (!m_single_active_factory || m_single_active_factory_priority <= priority) {
		m_single_active_factory = TestInterfaceAbstractFactory::_duplicate(factory);
		m_single_active_factory_priority = priority;
	}
}

TestInterface* TestInterfaceFactoryManager::make () /*throw (Core::Root::NoActiveFactory)*/ {
	if (m_single_active_factory.is_nil()) {
		throw Core::Root::NoActiveFactory ("BasicTests::IfdefInterfaces::TestInterfaceFactory");
	}
	TestInterface* ret_ = m_single_active_factory->make ();
	GDS_ASSERT_MSG (ret_ != 0, ("BasicTests::IfdefInterfaces::TestInterfaceFactory impl can't return zerro"));
	return ret_;
}

#endif //ACE_HAS_WINNT4 && WIN32
} // namespace IfdefInterfaces
} // namespace BasicTests

#endif //WIN32
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

