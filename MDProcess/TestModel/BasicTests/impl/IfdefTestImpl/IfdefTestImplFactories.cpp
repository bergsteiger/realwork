////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/TestModel/BasicTests/impl/IfdefTestImpl/IfdefTestImplFactories.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Impl::Category>> TestModel::BasicTests::IfdefTestImpl
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/Core/sys/std_inc.h"
#include "TestModel/BasicTests/impl/IfdefTestImpl/IfdefTestImplFactories.h"

#if defined(WIN32)
namespace BasicTests {
namespace IfdefTestImpl {

//////////////////////////////////////////////////////////////////////////////////////
// implementation of factory manager methods for TestLocal
bool TestLocalFactoryManager::s_was_destroyed = false;

TestLocalFactoryManager::TestLocalFactoryManager () /*throw (Core::Root::FactoryManagerWasDestroyed)*/
	: m_has_registred_factories(false)
{
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
}

TestLocalFactoryManager::~TestLocalFactoryManager () {
	s_was_destroyed = true;
}

void TestLocalFactoryManager::register_factory (
	TestLocalAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
	Singleton::instance()->register_factory_i (factory, priority);
	
}

void TestLocalFactoryManager::register_factory_i (
	TestLocalAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey)*/ {
	m_has_registred_factories = true;
	FactoryMap::iterator f = m_factories_map.find(factory->key());
	if (f != m_factories_map.end() && f->second.priority == priority) {
		throw Core::Root::DuplicatedFactoryKey (
			"BasicTests::IfdefTestImpl::TestLocalFactory"
			, factory->key()
		);
	}
	if (f == m_factories_map.end() || f->second.priority <= priority) {
		m_factories_map[factory->key()].factory = TestLocalAbstractFactory::_duplicate(factory);
		m_factories_map[factory->key()].priority = priority;
	}
	
	if (!m_single_active_factory || m_single_active_factory_priority <= priority) {
		m_single_active_factory = TestLocalAbstractFactory::_duplicate(factory);
		m_single_active_factory_priority = priority;
	}
}

TestLocal* TestLocalFactoryManager::create () /*throw (Core::Root::NoActiveFactory)*/ {
	if (m_single_active_factory.is_nil()) {
		throw Core::Root::NoActiveFactory ("BasicTests::IfdefTestImpl::TestLocalFactory");
	}
	TestLocal* ret_ = m_single_active_factory->create ();
	GDS_ASSERT_MSG (ret_ != 0, ("BasicTests::IfdefTestImpl::TestLocalFactory impl can't return zerro"));
	return ret_;
}
} // namespace IfdefTestImpl
} // namespace BasicTests

#endif //WIN32
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

