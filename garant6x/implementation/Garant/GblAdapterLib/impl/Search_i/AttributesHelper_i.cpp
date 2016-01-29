////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Search_i/AttributesHelper_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Search_i::AttributesHelper_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/LibHome.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Search_i/AttributesHelper_i.h"
// by <<uses>> dependencies
#include "garant6x/implementation/Garant/GblAdapterLib/ApplicationHelper/ApplicationHelper.h"

namespace GblAdapterLib {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

AttributesHelper_i::AttributesHelper_i ()
//#UC START# *4CEA4CD7006D_4CEA4EEF01E8_4CEA4F29009A_BASE_INIT*
//#UC END# *4CEA4CD7006D_4CEA4EEF01E8_4CEA4F29009A_BASE_INIT*
{
	//#UC START# *4CEA4CD7006D_4CEA4EEF01E8_4CEA4F29009A_BODY*
	//#UC END# *4CEA4CD7006D_4CEA4EEF01E8_4CEA4F29009A_BODY*
}

AttributesHelper_i::~AttributesHelper_i () {
	//#UC START# *4CEA4F29009A_DESTR_BODY*
	//#UC END# *4CEA4F29009A_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from AttributesHelper
bool AttributesHelper_i::attribute_KW_exists () const {
	//#UC START# *4CEA4D0702FD_4CEA4F29009A*
	return ApplicationHelper::instance ()->get_cached_search_manager ()->attribute_exists (GblPilotQueryDef::AT_KW);
	//#UC END# *4CEA4D0702FD_4CEA4F29009A*
}

// implemented method from AttributesHelper
bool AttributesHelper_i::attribute_publish_source_exists () const {
	//#UC START# *4CEA4D5D002C_4CEA4F29009A*
	return ApplicationHelper::instance ()->get_cached_search_manager ()->attribute_exists (GblPilotQueryDef::AT_PUBLISH_SOURCE);
	//#UC END# *4CEA4D5D002C_4CEA4F29009A*
}
} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

