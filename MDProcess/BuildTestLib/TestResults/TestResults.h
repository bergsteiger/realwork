
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/BuildTestLib/TestResults/TestResults.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<ServerInterfaces::Category>> MDProcess::BuildTestLib::TestResults
//
// разновидности результатов тестов - общий (generic), функциональный, нагрузочный..
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_BUILDTESTLIB_TESTRESULTS_H__
#define __MDPROCESS_BUILDTESTLIB_TESTRESULTS_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/BuildTestLib/TestResults/TestResultsC.h"
#include <vector>

namespace BuildTestLib {
namespace TestResults {

/// factory interface for Test
class TestFactory {
public:
	// обычная фабрика создания объекта
	static Test* make ()
		/*throw (CoreSrv::NoActiveFactory)*/;
private:
	typedef ACE_Singleton<TestFactoryManagerSrv_var, ACE_SYNCH_RECURSIVE_MUTEX> FactoryManagerSrvSingleton;
	static Core::Mutex s_init_mutex;
	static bool s_renew_mode;
};

/// factory interface for FunctionalTest
class FunctionalTestFactory {
public:
	// обычная фабрика создания объекта
	static FunctionalTest* make ()
		/*throw (CoreSrv::NoActiveFactory)*/;
private:
	typedef ACE_Singleton<FunctionalTestFactoryManagerSrv_var, ACE_SYNCH_RECURSIVE_MUTEX> FactoryManagerSrvSingleton;
	static Core::Mutex s_init_mutex;
	static bool s_renew_mode;
};

} // namespace TestResults
} // namespace BuildTestLib


#endif //__MDPROCESS_BUILDTESTLIB_TESTRESULTS_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

