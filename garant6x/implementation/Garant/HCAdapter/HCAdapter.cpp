////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/HCAdapter/HCAdapter.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<AdapterTarget::Category>> garant6x::HCAdapter
//
// Библиотека для взаимодействия сервера консультаций и ПО отдела правовой поддержки
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/Core/sys/start_stop.h"
#include "shared/Core/sys/std_inc.h"
#include "garant6x/implementation/Garant/HCAdapter/HCAdapter.h"
#include "shared/Core/GDS/MemoryWatcher.h"
#include "shared/Core/GDS/ObjectWatcher.h"	
#include "shared/Core/impl/Root_i/StdLibHomeManager_factory.h"
#include "shared/Core/impl/ParamsImpl/ParamManagerImpl_factory.h"
#include "shared/GCI/I18N/I18N.h"
#include "shared/GCI/impl/I18N_i/Environment.h"
#include "shared/GCI/impl/I18N_i/GarantWinLocaleOperations_factory.h"
#include "shared/GCI/impl/I18N_i/PosixLocaleOperations_factory.h"
#include "garant6x/implementation/Garant/HCAdapterLib/LibHome.h"
#include "shared/GCI/LibHome.h"
#include "shared/GCL/LibHome.h"
#include "garant6x/implementation/Garant/CommonUtils/LibHome.h"
#include "shared/GCI/LibHome.h"
#include "shared/GCL/LibHome.h"
#include "shared/XercesHelpers/LibHome.h"
#include "shared/XercesHelpers/LibHome.h"

#include "garantServer/src/Global/Defines/DefinesC.h"
#include "garantServer/src/Global/Core/Common/GCMManagerHome.h"
#include "garantServer/src/Business/GblConsulting/GblConsultingDefC.h"
#include "garantServer/src/Business/GblPilot/GblPilotDefC.h"
//#UC START# *442BEE8500AB_CUSTOM_INCLUDE*
#include "shared/Core/fix/wine.h"
#include "garantServer/src/Global/Defines/Common/ProjectConsts.h"
//#UC END# *442BEE8500AB_CUSTOM_INCLUDE*


namespace HCAdapter {
	Core::Mutex DllInintializator::s_init_mutex;
	unsigned long DllInintializator::s_count = 0;
	
	void DllInintializator::init (unsigned long client_version, const char* locale_string) {
		GUARD (s_init_mutex);
		if (s_count++ != 0) {
			return;
		}
		Core::init ();
		{
			Core::Root_i::StdLibHomeManager_factory_var f = new Core::Root_i::StdLibHomeManager_factory ();
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
		
		Core::Root::LibHomeManager& lhm = Core::Root::LibHomeManagerFactory::get();
	
		lhm.registrate_lib_home (&GCL::LibHomeFactory::get ());
		lhm.registrate_lib_home (&GCI::LibHomeFactory::get ());
		lhm.registrate_lib_home (&XercesHelpers::LibHomeFactory::get ());
		lhm.registrate_lib_home (&CommonUtils::LibHomeFactory::get ());
		lhm.registrate_lib_home (&HCAdapterLib::LibHomeFactory::get ());

		GCI::I18N_i::Environment::set_default_locale (GCI::I18N::SL_RU_CP1251);
		GCI::I18N::SupportedLocales locale = GCI::I18N::LocaleOperationsFactory::make ().string_to_locale (locale_string);
		GCI::I18N::LocaleOperationsFactory::make ().set_locale (locale);
		
		if (dll_version () != client_version) {
			Core::Root::WrongVersion ex (client_version, dll_version ());
			LOG_D (("%s: %s", GDS_CURRENT_FUNCTION, ex.what ()));
			throw ex;
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

} //namespace HCAdapter
extern "C" __declspec (dllexport) void __stdcall dll_init (unsigned long client_version) {
_DLL_TRY
	HCAdapter::DllInintializator::init (client_version, "ru");
_DLL_CATCH
}

extern "C" __declspec (dllexport) void __stdcall dll_init_with_locale (unsigned long client_version, const char* locale_string) {
_DLL_TRY
	HCAdapter::DllInintializator::init (client_version, locale_string);
_DLL_CATCH
}

extern "C" __declspec (dllexport) void __stdcall dll_done () {
_DLL_TRY
	HCAdapter::DllInintializator::done ();
_DLL_CATCH
}

extern "C" __declspec (dllexport) void __stdcall dll_get_root(
	HCAdapter::Root*& root
) {
_DLL_TRY
	root = HCAdapter::Root::Singleton::instance();
	root->addref ();
_DLL_CATCH
}
extern "C" __declspec (dllexport) unsigned long __stdcall dll_version () {
	return 237;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
