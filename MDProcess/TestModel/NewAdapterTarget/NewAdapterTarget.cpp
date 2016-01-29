////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/TestModel/NewAdapterTarget/NewAdapterTarget.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<AdapterTarget::Category>> TestModel::NewAdapterTarget
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/Core/sys/start_stop.h"
#include "shared/Core/sys/std_inc.h"
#include "TestModel/NewAdapterTarget/NewAdapterTarget.h"
#include "shared/Core/GDS/MemoryWatcher.h"
#include "shared/Core/GDS/ObjectWatcher.h"	
#include "shared/CoreSrv/impl/Root_i/CorbaLibHomeManager_factory.h"
#include "shared/Core/impl/ParamsImpl/ParamManagerImpl_factory.h"
#include "shared/GCI/I18N/I18N.h"
#include "shared/GCI/impl/I18N_i/Environment.h"
#include "shared/GCI/impl/I18N_i/GarantWinLocaleOperations_factory.h"
#include "shared/GCI/impl/I18N_i/PosixLocaleOperations_factory.h"
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



namespace NewAdapterTarget {
	Core::Mutex DllInintializator::s_init_mutex;
	unsigned long DllInintializator::s_count = 0;
	
	void DllInintializator::init (unsigned long client_version, const char* locale_string) {
		GUARD (s_init_mutex);
		if (s_count++ != 0) {
			return;
		}
		Core::init ();
		{
			CoreSrv::Root_i::CorbaLibHomeManager_factory_var f = new CoreSrv::Root_i::CorbaLibHomeManager_factory ();
			f->registrate_me(0);
		}
		{
			Core::ParamsImpl::ParamManagerImpl_factory_var f = new Core::ParamsImpl::ParamManagerImpl_factory ();
			f->registrate_me(0);
		}
		
		{
			#if defined (WIN32)
				GCI::I18N_i::GarantWinLocaleOperations_factory_var fctr = new GCI::I18N_i::GarantWinLocaleOperations_factory ();
				fctr->registrate_me(0);
			#else
				GCI::I18N_i::PosixLocaleOperations_factory_var fctr = new GCI::I18N_i::PosixLocaleOperations_factory ();
				fctr->registrate_me(0);
			#endif
		}
		try {
			Core::ParamManagerInitData init = {"NewAdapterTarget", "Core::RegistryHelper::KEY_LOCAL_MACHINE\\Software\\Garant\\TestModel\\NewAdapterTarget"};
			Core::ParamManagerFactory::get ().init (Core::ParamConvert::make_arg_list (0, 0), init);
		} CATCH_AND_LOG ("while init ParamManager executed")
		Core::Root::LibHomeManager& lhm = Core::Root::LibHomeManagerFactory::get();
	
		lhm.registrate_lib_home (&BasicTests::LibHomeFactory::get ());
		lhm.registrate_lib_home (&SubTestLibrary::LibHomeFactory::get ());
		lhm.registrate_lib_home (&SubServerLibrary::LibHomeFactory::get ());
		lhm.registrate_lib_home (&NewLibrary::LibHomeFactory::get ());
		lhm.registrate_lib_home (&NewServerLibrary::LibHomeFactory::get ());
		lhm.registrate_lib_home (&NewServerLibrary::ServerLibHomeFactory::get ());
		lhm.registrate_lib_home (&NewTestLibrary::LibHomeFactory::get ());

		GCI::I18N_i::Environment::set_default_locale (GCI::I18N::SL_RU_CP1251);
		GCI::I18N::SupportedLocales locale = GCI::I18N::LocaleOperationsFactory::make ().string_to_locale (locale_string);
		GCI::I18N::LocaleOperationsFactory::make ().set_locale (locale);
		
		if (dll_version () != client_version) {
			throw Core::Root::WrongVersion (client_version, dll_version ());
		}
		try {
			lhm.execute ();
		} CATCH_AND_LOG ("while HomeManager processed")
	}
	
	void DllInintializator::done () {
		GUARD (s_init_mutex);
		if (--s_count != 0) {
			return;
		}
		Core::Root::LibHomeManager& lhm = Core::Root::LibHomeManagerFactory::get();
		lhm.finalize ();

		Core::fini ();
	}

} //namespace NewAdapterTarget
extern "C" __declspec (dllexport) void __stdcall dll_init (unsigned long client_version) {
_DLL_TRY
	NewAdapterTarget::DllInintializator::init (client_version, "ru");
_DLL_CATCH
}

extern "C" __declspec (dllexport) void __stdcall dll_init_with_locale (unsigned long client_version, const char* locale_string) {
_DLL_TRY
	NewAdapterTarget::DllInintializator::init (client_version, locale_string);
_DLL_CATCH
}

extern "C" __declspec (dllexport) void __stdcall dll_done () {
_DLL_TRY
	NewAdapterTarget::DllInintializator::done ();
_DLL_CATCH
}

extern "C" __declspec (dllexport) void __stdcall dll_get_root(
	NewAdapterTarget::Root*& root
) {
_DLL_TRY
	root = NewAdapterTarget::Root::Singleton::instance();
	root->addref ();
_DLL_CATCH
}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
