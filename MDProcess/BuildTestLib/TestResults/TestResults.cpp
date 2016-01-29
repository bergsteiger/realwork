
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/BuildTestLib/TestResults/TestResults.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<ServerInterfaces::Category>> MDProcess::BuildTestLib::TestResults
//
// разновидности результатов тестов - общий (generic), функциональный, нагрузочный..
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/BuildTestLib/TestResults/TestResults.h"
#include "MDProcess/BuildTestLib/LibHome.h"

namespace BuildTestLib {
namespace TestResults {

Core::Mutex TestFactory::s_init_mutex;
bool TestFactory::s_renew_mode = false;

// обычная фабрика создания объекта
Test* TestFactory::make () /*throw (CoreSrv::NoActiveFactory)*/ {
	if (FactoryManagerSrvSingleton::instance()->ptr() == 0) {
		GUARD (s_init_mutex);
		if (FactoryManagerSrvSingleton::instance()->ptr() == 0) {
			try {
				CORBA::Object_var obj = CoreSrv::resolve_path (&LibHomeFactory::get().get_orb_facet().get_ns_root(), "BuildTestLib::TestResults::Test");
				*FactoryManagerSrvSingleton::instance() = TestFactoryManagerSrv::_narrow (obj);
			} CATCH_AND_LOG ("COS Naming can't find FactoryManagerSrv for Test");
		}
		if (FactoryManagerSrvSingleton::instance()->ptr() == 0) {
			throw CoreSrv::NoActiveFactory ();
		}
	}
	try {
		return (*FactoryManagerSrvSingleton::instance())->make ();
	} catch (CORBA::TRANSIENT& ) {
		if (s_renew_mode) {
			s_renew_mode = false;
			LOG_W (("TestFactoryManagerSrv is in invalid (inactive) state"));
			throw CoreSrv::NoActiveFactory ();
		}
		GUARD (s_init_mutex);
		LOG_D (("Try to renew TestFactoryManagerSrv"));
		
		s_renew_mode = true;
		(*FactoryManagerSrvSingleton::instance()) = 0;
		Test_var ret = make ();
		s_renew_mode = false;
		
		return ret._retn();				
	} catch (CORBA::OBJECT_NOT_EXIST& ) {
		if (s_renew_mode) {
			s_renew_mode = false;
			LOG_W (("TestFactoryManagerSrv is in invalid (inactive) state"));
			throw CoreSrv::NoActiveFactory ();
		}
		GUARD (s_init_mutex);
		LOG_D (("Try to renew TestFactoryManagerSrv"));
		
		s_renew_mode = true;
		(*FactoryManagerSrvSingleton::instance()) = 0;
		Test_var ret = make ();
		s_renew_mode = false;
		
		return ret._retn();				
	}
}


Core::Mutex FunctionalTestFactory::s_init_mutex;
bool FunctionalTestFactory::s_renew_mode = false;

// обычная фабрика создания объекта
FunctionalTest* FunctionalTestFactory::make () /*throw (CoreSrv::NoActiveFactory)*/ {
	if (FactoryManagerSrvSingleton::instance()->ptr() == 0) {
		GUARD (s_init_mutex);
		if (FactoryManagerSrvSingleton::instance()->ptr() == 0) {
			try {
				CORBA::Object_var obj = CoreSrv::resolve_path (&LibHomeFactory::get().get_orb_facet().get_ns_root(), "BuildTestLib::TestResults::FunctionalTest");
				*FactoryManagerSrvSingleton::instance() = FunctionalTestFactoryManagerSrv::_narrow (obj);
			} CATCH_AND_LOG ("COS Naming can't find FactoryManagerSrv for FunctionalTest");
		}
		if (FactoryManagerSrvSingleton::instance()->ptr() == 0) {
			throw CoreSrv::NoActiveFactory ();
		}
	}
	try {
		return (*FactoryManagerSrvSingleton::instance())->make ();
	} catch (CORBA::TRANSIENT& ) {
		if (s_renew_mode) {
			s_renew_mode = false;
			LOG_W (("FunctionalTestFactoryManagerSrv is in invalid (inactive) state"));
			throw CoreSrv::NoActiveFactory ();
		}
		GUARD (s_init_mutex);
		LOG_D (("Try to renew FunctionalTestFactoryManagerSrv"));
		
		s_renew_mode = true;
		(*FactoryManagerSrvSingleton::instance()) = 0;
		FunctionalTest_var ret = make ();
		s_renew_mode = false;
		
		return ret._retn();				
	} catch (CORBA::OBJECT_NOT_EXIST& ) {
		if (s_renew_mode) {
			s_renew_mode = false;
			LOG_W (("FunctionalTestFactoryManagerSrv is in invalid (inactive) state"));
			throw CoreSrv::NoActiveFactory ();
		}
		GUARD (s_init_mutex);
		LOG_D (("Try to renew FunctionalTestFactoryManagerSrv"));
		
		s_renew_mode = true;
		(*FactoryManagerSrvSingleton::instance()) = 0;
		FunctionalTest_var ret = make ();
		s_renew_mode = false;
		
		return ret._retn();				
	}
}


} // namespace TestResults
} // namespace BuildTestLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

