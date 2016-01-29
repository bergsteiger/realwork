////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/TestModel/NewExeTarget/NewExeTarget_main.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<ExeTarget::Category>> TestModel::NewExeTarget
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
#include "TestModel/NewLibrary/LibHome.h"
#include "TestModel/BasicTests/LibHome.h"
#include "TestModel/gui/Garant/SubTestLibrary/LibHome.h"
#include "TestModel/SubServerLibrary/LibHome.h"
#include "TestModel/NewServerLibrary/LibHome.h"
#include "TestModel/NewServerLibrary/ServerLibHome.h"
#include "TestModel/BasicTests/LibHome.h"
#include "TestModel/gui/Garant/SubTestLibrary/LibHome.h"
#include "TestModel/SubServerLibrary/LibHome.h"
#include "TestModel/gui/Garant/NewTestLibrary/LibHome.h"
#include "TestModel/BasicTests/LibHome.h"
#include "TestModel/gui/Garant/SubTestLibrary/LibHome.h"
#include "TestModel/SubServerLibrary/LibHome.h"



void print_usage (const Core::Root::LibHomeManager& lhm) {
	std::cout << "NewExeTarget\n";
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
			Core::ParamManagerInitData init = {"NewExeTarget", "Core::RegistryHelper::KEY_LOCAL_MACHINE\\Software\\Garant\\TestModel\\NewExeTarget"};
			Core::ParamManagerFactory::get ().init (Core::ParamConvert::make_arg_list (argc, argv), init);
		} CATCH_AND_LOG ("while init ParamManager executed")
		
		Core::Root::LibHomeManager& lhm = Core::Root::LibHomeManagerFactory::get();
		lhm.registrate_lib_home (&BasicTests::LibHomeFactory::get ());
		lhm.registrate_lib_home (&SubTestLibrary::LibHomeFactory::get ());
		lhm.registrate_lib_home (&SubServerLibrary::LibHomeFactory::get ());
		lhm.registrate_lib_home (&NewLibrary::LibHomeFactory::get ());
		lhm.registrate_lib_home (&NewServerLibrary::LibHomeFactory::get ());
		lhm.registrate_lib_home (&NewServerLibrary::ServerLibHomeFactory::get ());
		lhm.registrate_lib_home (&NewTestLibrary::LibHomeFactory::get ());

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
			lhm.wait_all ();
		} CATCH_AND_LOG ("while HomeManager processed")
	
		lhm.finalize ();
		
		return ret_code;
	}
};

int main (int argc, char** argv) {
	return MainFunction::execute (argc, argv);
}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
