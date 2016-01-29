////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/HCAdapterLib/impl/HCInterfaces_i/BusinessLogicLifeCycle_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::HCAdapterLib::HCInterfaces_i::BusinessLogicLifeCycle_i
//
// реализация соответствующего интерфейса
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/HCAdapterLib/LibHome.h"
#include "garant6x/implementation/Garant/HCAdapterLib/impl/HCInterfaces_i/BusinessLogicLifeCycle_i.h"

//#UC START# *47861A7102CF_CUSTOM_INCLUDES*
#include "shared/Core/Params/Params.h"
#include "shared/Core/ParamsHelper/ParamConvert.h"

#include "shared/XercesHelpers/wrappers/XercesHelper.h"

#include "garantServer/src/Global/Defines/Common/ProjectConsts.h"
#include "garantServer/src/Global/Defines/DefinesC.h"
#include "garantServer/src/Global/Core/Common/GCMManagerHome.h"
//#UC END# *47861A7102CF_CUSTOM_INCLUDES*

namespace HCAdapterLib {
namespace HCInterfaces_i {

//#UC START# *47861A7102CF*
void BusinessLogicLifeCycle_i::execute () {
	{
		CORBA::Object_var o (provide (Defines::FN_CONSULTATION_MANAGER_70));
		m_consultation_manager70 = GblConsulting::ConsultationManager70::_narrow (o);

		if (CORBA::is_nil (m_consultation_manager70)) {
			LOG_E (("%s: can't find ConsultationManager70, check your settings", GDS_CURRENT_FUNCTION));
			throw GCM::ComponentError ();
		}
	}			

	// Register valuetypes
	GCM::register_valuetype_factory<GblConsultingDef::ConsultationData_init> ();
	GCM::register_valuetype_factory<GblConsultingDef::HCConsultationData_init> ();

	GCMSimpleServer::execute ();
}
//#UC END# *47861A7102CF*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

BusinessLogicLifeCycle_i::BusinessLogicLifeCycle_i ()
//#UC START# *47861964033F_47861A37017B_47861A7102CF_BASE_INIT*
//#UC END# *47861964033F_47861A37017B_47861A7102CF_BASE_INIT*
{
	//#UC START# *47861964033F_47861A37017B_47861A7102CF_BODY*
	this->register_receptacles (Defines::FN_CONSULTATION_MANAGER_70);

	XercesHelpers::XercesHelper::instance (); // инициализируем библиотеку xerces
	//#UC END# *47861964033F_47861A37017B_47861A7102CF_BODY*
}

BusinessLogicLifeCycle_i::~BusinessLogicLifeCycle_i () {
	//#UC START# *47861A7102CF_DESTR_BODY*
	//#UC END# *47861A7102CF_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from HCInterfaces::BusinessLogicLifeCycle
// получить интерфейс к СК  версии 7
GblConsulting::ConsultationManager70& BusinessLogicLifeCycle_i::get_consultation_manager70 () const {
	//#UC START# *47861DA9035C_47861A7102CF*
	return *m_consultation_manager70.ptr ();
	//#UC END# *47861DA9035C_47861A7102CF*
}

// implemented method from HCInterfaces::BusinessLogicLifeCycle
// метод должен быть вызван первым после загрузки dll библиотеки
void BusinessLogicLifeCycle_i::start () {
	//#UC START# *478619CE0231_47861A7102CF*
	char ini_file[MAXPATHLEN];
	GetModuleFileName (NULL, ini_file, MAXPATHLEN);
	if (::strcmp (ini_file + ::strlen (ini_file) - sizeof(".exe"), ".exe")) {
		::memcpy (ini_file + ::strlen (ini_file) - ::strlen(".exe"), ".ini", sizeof(".ini"));
	} else {
		::strcat (ini_file, ".ini");
	}

	char* argv_[] = {
		"Program"
		, "-GCMConfigFile"
		, ini_file
		, "-GPMAdapterConfigSection"
		, "F1Client Params"
	};

	const Core::ParamManagerInitData* my_init_id = &GCL::F1::ADAPTER;
	try {
		int argc_ = sizeof (argv_) / sizeof (argv_[0]);
		Core::ParamManagerFactory::get ().init (Core::ParamConvert::make_arg_list (argc_, argv_), *my_init_id);	
		GCM::GCMManager_var gcm_manager = GCM::GCM_get_manager();
		gcm_manager->register_component (new GCM::GCMSimpleClient (GblConsulting::ComponentKey_c));

		gcm_manager->register_local_component (IObject::_duplicate (this));
		gcm_manager->start_components (false);	
	} catch (CORBA::Exception& ex) {
		LOG_CEXD ((ex, "%s: can't get server component", GDS_CURRENT_FUNCTION));
		std::exit ( 1);
		return;
	} catch (...) {
		LOG_E (("%s: can't get server component", GDS_CURRENT_FUNCTION));
		throw;
	}
	//#UC END# *478619CE0231_47861A7102CF*
}

// implemented method from HCInterfaces::BusinessLogicLifeCycle
// метод должен быть вызван перед завершением работы библиотеки
void BusinessLogicLifeCycle_i::stop () {
	//#UC START# *478619F80225_47861A7102CF*
	GCM::GCMManager_var gcm_manager = GCM::GCM_get_manager();
	gcm_manager->stop_components ();
	gcm_manager = GCM::GCMManager::_nil ();
	//#UC END# *478619F80225_47861A7102CF*
}
} // namespace HCInterfaces_i
} // namespace HCAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

