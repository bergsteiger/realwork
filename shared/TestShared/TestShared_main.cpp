////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/TestShared/TestShared_main.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<ExeTarget::Category>> shared::TestShared
//
// Утилита для тестирования различных функцианальных частей shared.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/Core/sys/AutoInit.h"
#include "shared/Core/sys/std_inc.h"
#include "shared/Core/GDS/MemoryWatcher.h"
#include "shared/Core/GDS/ObjectWatcher.h"	
#include "shared/CoreSrv/impl/Root_i/CorbaLibHomeManager_factory.h"
#include "shared/Core/impl/ParamsImpl/ParamManagerImpl_factory.h"
#include "shared/TestLib/LibHome.h"
#include "shared/TestLib/ServerLibHome.h"
#include "shared/GCI/LibHome.h"
#include "shared/GCL/LibHome.h"
#include "shared/GSI/LibHome.h"
#include "shared/ContextSearch/LibHome.h"
#include "shared/GCL/LibHome.h"
#include "shared/DB/LibHome.h"
#include "shared/CoreSrv/LibHome.h"



void print_usage (const Core::Root::LibHomeManager& lhm) {
	std::cout << "TestShared - Утилита для тестирования различных функцианальных частей\n";
	std::cout << "shared.\n";
	std::cout << std::endl;
	lhm.print_usage ();
	std::cout << "\nВсе права принадлежат ООО НПП \"Гарант-Сервис\"\n";
}

/// main-function wrapper
class MainFunction {
public:
	static int execute (int argc, char** argv) {
		int ret_code = 0;
		Core::AutoInit auto_init;

		Core::select_log_format_set (Core::LFI_FULL);

		{
			CoreSrv::Root_i::CorbaLibHomeManager_factory_var f = new CoreSrv::Root_i::CorbaLibHomeManager_factory ();
			f->registrate_me(0);
		}
		{
			Core::ParamsImpl::ParamManagerImpl_factory_var f = new Core::ParamsImpl::ParamManagerImpl_factory ();
			f->registrate_me(0);
		}
		try {
			Core::ParamManagerInitData init = {"TestShared", "Core::RegistryHelper::KEY_LOCAL_MACHINE\\Software\\Garant\\shared\\TestShared"};
			Core::ParamManagerFactory::get ().init (Core::ParamConvert::make_arg_list (argc, argv), init);
		} CATCH_AND_LOG ("while init ParamManager executed")
		
		Core::Root::LibHomeManager& lhm = Core::Root::LibHomeManagerFactory::get();
		lhm.registrate_lib_home (&GCL::LibHomeFactory::get ());
		lhm.registrate_lib_home (&GCI::LibHomeFactory::get ());
		lhm.registrate_lib_home (&GSI::LibHomeFactory::get ());
		lhm.registrate_lib_home (&DB::LibHomeFactory::get ());
		lhm.registrate_lib_home (&CoreSrv::LibHomeFactory::get ());
		lhm.registrate_lib_home (&ContextSearch::LibHomeFactory::get ());
		lhm.registrate_lib_home (&TestLib::LibHomeFactory::get ());
		lhm.registrate_lib_home (&TestLib::ServerLibHomeFactory::get ());

		if (
			Core::ParamManagerFactory::get ().is_exist ("-help")
			|| Core::ParamManagerFactory::get ().is_exist ("-h")
			|| Core::ParamManagerFactory::get ().is_exist ("-?")
		) {
			print_usage(lhm);
			return ret_code;
		}
		if (!lhm.check_params ()) {
			print_usage (lhm);
			return 1;
		}
		
		try {
			lhm.execute ();
			ret_code = lhm.wait_all () == 0 ? 0 : 2;
		} CATCH_LOG_AND_DO ("while HomeManager processed", ret_code = 3;)
	
		lhm.finalize ();
		
		return ret_code;
	}
};

int main (int argc, char** argv) {
	return MainFunction::execute (argc, argv);
}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
