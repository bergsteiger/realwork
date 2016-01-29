////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/BuildTestLib/TestResults/TestResultsFactories.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<ServerInterfaces::Category>> MDProcess::BuildTestLib::TestResults
//
// разновидности результатов тестов - общий (generic), функциональный, нагрузочный..
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/BuildTestLib/TestResults/TestResultsFactories.h"
#include "MDProcess/BuildTestLib/LibHome.h"

namespace BuildTestLib {
namespace TestResults {

//////////////////////////////////////////////////////////////////////////////////////
// implementation of factory manager methods for Test
bool TestFactoryManager::s_was_destroyed = false;

TestFactoryManager::TestFactoryManager () /*throw (Core::Root::FactoryManagerWasDestroyed)*/
	: m_has_registred_factories(false)
{
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
}

TestFactoryManager::~TestFactoryManager () {
	s_was_destroyed = true;
}

void TestFactoryManager::register_factory (
	TestAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
	Singleton::instance()->register_factory_i (factory, priority);
}

void TestFactoryManager::publish_self () {
	if (Singleton::instance()->m_has_registred_factories) {
		TestFactoryManagerSrv_var ref = Singleton::instance()->_this();
		CoreSrv::bind_path (&LibHomeFactory::get().get_orb_facet().get_ns_root(), ref.in(), "BuildTestLib::TestResults::Test");
	}
}

void TestFactoryManager::register_factory_i (
	TestAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey)*/ {
	m_has_registred_factories = true;
	FactoryMap::iterator f = m_factories_map.find(factory->key());
	if (f != m_factories_map.end() && f->second.priority == priority) {
		throw Core::Root::DuplicatedFactoryKey (
			"BuildTestLib::TestResults::TestFactory"
			, factory->key()
		);
	}
	if (f == m_factories_map.end() || f->second.priority <= priority) {
		m_factories_map[factory->key()].factory = TestAbstractFactory::_duplicate(factory);
		m_factories_map[factory->key()].priority = priority;
	}
	
	if (!m_single_active_factory || m_single_active_factory_priority <= priority) {
		m_single_active_factory = TestAbstractFactory::_duplicate(factory);
		m_single_active_factory_priority = priority;
	}
}

Test* TestFactoryManager::make () throw (CORBA::SystemException, CoreSrv::NoActiveFactory) {
	if (m_single_active_factory.is_nil()) {
		throw Core::Root::NoActiveFactory ("BuildTestLib::TestResults::TestFactory");
	}
	Test* ret_ = m_single_active_factory->make ();
	GDS_ASSERT_MSG (ret_ != 0, ("BuildTestLib::TestResults::TestFactory impl can't return zerro"));
	return ret_;
}

//////////////////////////////////////////////////////////////////////////////////////
// implementation of factory manager methods for FunctionalTest
bool FunctionalTestFactoryManager::s_was_destroyed = false;

FunctionalTestFactoryManager::FunctionalTestFactoryManager () /*throw (Core::Root::FactoryManagerWasDestroyed)*/
	: m_has_registred_factories(false)
{
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
}

FunctionalTestFactoryManager::~FunctionalTestFactoryManager () {
	s_was_destroyed = true;
}

void FunctionalTestFactoryManager::register_factory (
	FunctionalTestAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	if (s_was_destroyed == true) {
		throw Core::Root::FactoryManagerWasDestroyed ();
	}
	Singleton::instance()->register_factory_i (factory, priority);
}

void FunctionalTestFactoryManager::publish_self () {
	if (Singleton::instance()->m_has_registred_factories) {
		FunctionalTestFactoryManagerSrv_var ref = Singleton::instance()->_this();
		CoreSrv::bind_path (&LibHomeFactory::get().get_orb_facet().get_ns_root(), ref.in(), "BuildTestLib::TestResults::FunctionalTest");
	}
}

void FunctionalTestFactoryManager::register_factory_i (
	FunctionalTestAbstractFactory* factory, Core::Root::FactoryPriority priority
) /*throw (Core::Root::DuplicatedFactoryKey)*/ {
	m_has_registred_factories = true;
	FactoryMap::iterator f = m_factories_map.find(factory->key());
	if (f != m_factories_map.end() && f->second.priority == priority) {
		throw Core::Root::DuplicatedFactoryKey (
			"BuildTestLib::TestResults::FunctionalTestFactory"
			, factory->key()
		);
	}
	if (f == m_factories_map.end() || f->second.priority <= priority) {
		m_factories_map[factory->key()].factory = FunctionalTestAbstractFactory::_duplicate(factory);
		m_factories_map[factory->key()].priority = priority;
	}
	
	if (!m_single_active_factory || m_single_active_factory_priority <= priority) {
		m_single_active_factory = FunctionalTestAbstractFactory::_duplicate(factory);
		m_single_active_factory_priority = priority;
	}
}

FunctionalTest* FunctionalTestFactoryManager::make () throw (CORBA::SystemException, CoreSrv::NoActiveFactory) {
	if (m_single_active_factory.is_nil()) {
		throw Core::Root::NoActiveFactory ("BuildTestLib::TestResults::FunctionalTestFactory");
	}
	FunctionalTest* ret_ = m_single_active_factory->make ();
	GDS_ASSERT_MSG (ret_ != 0, ("BuildTestLib::TestResults::FunctionalTestFactory impl can't return zerro"));
	return ret_;
}
} // namespace TestResults
} // namespace BuildTestLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

