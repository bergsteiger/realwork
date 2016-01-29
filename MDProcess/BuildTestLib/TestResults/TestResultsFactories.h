////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/BuildTestLib/TestResults/TestResultsFactories.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<ServerInterfaces::Category>> MDProcess::BuildTestLib::TestResults
//
// разновидности результатов тестов - общий (generic), функциональный, нагрузочный..
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_BUILDTESTLIB_TESTRESULTS_FCTR_H__
#define __MDPROCESS_BUILDTESTLIB_TESTRESULTS_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include <map>
#include <string>
#include "ace/Singleton.h"
#include "MDProcess/BuildTestLib/TestResults/TestResults.h"
#include "MDProcess/BuildTestLib/TestResults/TestResultsS.h"

namespace BuildTestLib {
namespace TestResults {

////////////////////////////////////////////////////////////////////////////////////
// factories definition for Test

class TestAbstractFactory;

/// factory manager for Test
class TestFactoryManager: virtual public POA_BuildTestLib::TestResults::TestFactoryManagerSrv {
public:
	static void register_factory (TestAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

	static void publish_self ();

protected:
	TestFactoryManager ();
	
	~TestFactoryManager ();
	
	void register_factory_i (TestAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	Test* make () throw (CORBA::SystemException, CoreSrv::NoActiveFactory);

	friend class TestFactory;
	typedef ACE_Singleton <TestFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <TestFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<TestAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<TestAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;
};

/// abstract factory for Test
class TestAbstractFactory : virtual public Core::IObject {
	friend class TestFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual Test* make () = 0;
};


////////////////////////////////////////////////////////////////////////////////////
// factories definition for FunctionalTest

class FunctionalTestAbstractFactory;

/// factory manager for FunctionalTest
class FunctionalTestFactoryManager: virtual public POA_BuildTestLib::TestResults::FunctionalTestFactoryManagerSrv {
public:
	static void register_factory (FunctionalTestAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;

	static void publish_self ();

protected:
	FunctionalTestFactoryManager ();
	
	~FunctionalTestFactoryManager ();
	
	void register_factory_i (FunctionalTestAbstractFactory* factory, Core::Root::FactoryPriority priority)
		/*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	FunctionalTest* make () throw (CORBA::SystemException, CoreSrv::NoActiveFactory);

	friend class FunctionalTestFactory;
	typedef ACE_Singleton <FunctionalTestFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <FunctionalTestFactoryManager, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
	static bool s_was_destroyed;
	
	bool m_has_registred_factories;
	
	struct FactoryData {
		Core::Var<FunctionalTestAbstractFactory> factory;
		short priority;
	};
	
	typedef std::map <std::string, FactoryData> FactoryMap;
	
	FactoryMap m_factories_map;
	
	Core::Var<FunctionalTestAbstractFactory> m_single_active_factory;
	
	short m_single_active_factory_priority;
};

/// abstract factory for FunctionalTest
class FunctionalTestAbstractFactory : virtual public Core::IObject {
	friend class FunctionalTestFactoryManager;
protected:
	virtual const char* key () const = 0;

	virtual FunctionalTest* make () = 0;
};

} // namespace TestResults
} // namespace BuildTestLib


#endif //__MDPROCESS_BUILDTESTLIB_TESTRESULTS_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

