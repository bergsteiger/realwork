////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/UsersImport/UsersImport_main.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<ExeTarget::Category>> garant6x::UsersImport
//
// утилита импорта списка пользователей, ТЗ - К14517328.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/Core/sys/AutoInit.h"
#include "shared/Core/sys/std_inc.h"
#include "shared/Core/GDS/MemoryWatcher.h"
#include "shared/Core/GDS/ObjectWatcher.h"	
#include "shared/Core/impl/Root_i/StdLibHomeManager_factory.h"
#include "shared/Core/impl/ParamsImpl/ParamManagerImpl_factory.h"
#include "garant6x/implementation/Garant/UsersImportLib/LibHome.h"
#include "shared/GSI/LibHome.h"

//#UC START# *481D6CF50225_CUSTOM_INCLUDE*
#include "shared/Core/Params/Params.h"
#include "shared/Core/ParamsHelper/ParamConvert.h"

#include "garantServer/src/Global/Defines/Common/ProjectConsts.h"
//#UC END# *481D6CF50225_CUSTOM_INCLUDE*


void print_usage (const Core::Root::LibHomeManager& lhm) {
	std::cout << "UsersImport - утилита импорта списка пользователей, ТЗ - К14517328.\n";
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
			Core::Root_i::StdLibHomeManager_factory_var f = new Core::Root_i::StdLibHomeManager_factory ();
			f->registrate_me(0);
		}
		{
			Core::ParamsImpl::ParamManagerImpl_factory_var f = new Core::ParamsImpl::ParamManagerImpl_factory ();
			f->registrate_me(0);
		}
		try {
			//#UC START# *481D6CF50225_PARAM_MANAGER_INIT*
			if (!Core::ParamManagerFactory::get ().init (Core::ParamConvert::make_arg_list (argc, argv), GCL::F1::F1CLIENT)) {
				std::cerr << "error while init ParamManager executed\n";
				return -1;
			}	 
			Core::ParamManagerFactory::get ().add_long ("-GCMHackForOldNewModelsProblem", 1);
			//#UC END# *481D6CF50225_PARAM_MANAGER_INIT*
		} CATCH_AND_LOG ("while init ParamManager executed")
		
		Core::Root::LibHomeManager& lhm = Core::Root::LibHomeManagerFactory::get();
		lhm.registrate_lib_home (&GSI::LibHomeFactory::get ());
		lhm.registrate_lib_home (&UsersImportLib::LibHomeFactory::get ());

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
