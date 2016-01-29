////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Start_i/AssemblyInfo_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Start_i::AssemblyInfo_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/LibHome.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Start_i/AssemblyInfo_i.h"
// by <<uses>> dependencies
#include "garant6x/implementation/Garant/GblAdapterLib/ApplicationHelper/ApplicationHelper.h"

//#UC START# *46091A1F033C_CUSTOM_INCLUDES*
#include "garantServer/src/Global/Core/Common/AssemblyInfo.h"
//#UC END# *46091A1F033C_CUSTOM_INCLUDES*

namespace GblAdapterLib {

//#UC START# *46091A1F033C*
//#UC END# *46091A1F033C*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

AssemblyInfo_i::AssemblyInfo_i ()
//#UC START# *45EEE44100BB_460919DE03B9_46091A1F033C_BASE_INIT*
//#UC END# *45EEE44100BB_460919DE03B9_46091A1F033C_BASE_INIT*
{
	//#UC START# *45EEE44100BB_460919DE03B9_46091A1F033C_BODY*
	//#UC END# *45EEE44100BB_460919DE03B9_46091A1F033C_BODY*
}

AssemblyInfo_i::~AssemblyInfo_i () {
	//#UC START# *46091A1F033C_DESTR_BODY*
	//#UC END# *46091A1F033C_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from AssemblyInfo
bool AssemblyInfo_i::get_first_start () const {
	//#UC START# *45EEE44100BF_46091A1F033C_GET*
	const ACE_TCHAR REGISTRY_OPTION_NAME [] = ACE_TEXT ("FirstStart");
	const ACE_TCHAR DEFAULT_OPTION_VALUE [] = ACE_TEXT ("true");

	std::string option_value = // GARANT_CROSSP
		Core::RegistryHelper::get_option_value (
			Core::RegistryHelper::KEY_CURRENT_USER
			, ACE_TEXT ("SOFTWARE\\GARANT.F1")
			, REGISTRY_OPTION_NAME
			, DEFAULT_OPTION_VALUE
	);			

	if (option_value == "false") {
		return false;
	} else {
		return true;
	}
	//#UC END# *45EEE44100BF_46091A1F033C_GET*
}

void AssemblyInfo_i::set_first_start (bool first_start) {
	//#UC START# *45EEE44100BF_46091A1F033C_SET*
	const ACE_TCHAR REGISTRY_OPTION_NAME [] = ACE_TEXT ("FirstStart");
	const ACE_TCHAR OPTION_VALUE [] = ACE_TEXT ("false");

	Core::RegistryHelper::set_option_value (
		Core::RegistryHelper::KEY_CURRENT_USER
		, ACE_TEXT ("SOFTWARE\\GARANT.F1")
		, REGISTRY_OPTION_NAME
		, OPTION_VALUE
	);
	//#UC END# *45EEE44100BF_46091A1F033C_SET*
}

// implemented method from AssemblyInfo
bool AssemblyInfo_i::get_is_commerce () const {
	//#UC START# *45EEE44100BE_46091A1F033C_GET*
#if defined (TEST_UPDATE) && (TEST_UPDATE!=0)
	LOG_D (("BEFORE UPDATE"));
	ApplicationHelper::instance ()->get_cached_base_update ()->base_commit ("");
	LOG_D (("AFTER UPDATE"));
	return false;
#else
	GCD::LicenseSettings_var licence_settings = ApplicationHelper::instance ()->get_cached_user_manager ()->get_licence_info ();
	if (licence_settings->m_licence_type == GCD::lt_InternalUse) {
		return false;
	}
	return true;
#endif
	//#UC END# *45EEE44100BE_46091A1F033C_GET*
}

// implemented method from AssemblyInfo
bool AssemblyInfo_i::get_is_debug () const {
	//#UC START# *45EEE44100BC_46091A1F033C_GET*
	return Core::Root::ConfigurationFactory::get().get_info().debug;
	//#UC END# *45EEE44100BC_46091A1F033C_GET*
}

// implemented method from AssemblyInfo
bool AssemblyInfo_i::get_is_desktop () const {
	//#UC START# *45EEE44100BD_46091A1F033C_GET*
	return GCM_IS_ASSEMBLY_LOCAL;
	//#UC END# *45EEE44100BD_46091A1F033C_GET*
}

// implemented method from AssemblyInfo
// Разрядность сервера
const Capacity AssemblyInfo_i::get_server_capacity () const {
	//#UC START# *4AFC2189030C_46091A1F033C_GET*
	GCD::Capacity server_capacity = ApplicationHelper::instance ()->get_cached_function_manager ()->get_capacity ();
	return ServerCapacityConverterSingleton::instance ()->get (server_capacity); 
	//#UC END# *4AFC2189030C_46091A1F033C_GET*
}
} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

