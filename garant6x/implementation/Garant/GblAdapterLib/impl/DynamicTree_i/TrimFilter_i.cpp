////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/TrimFilter_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::DynamicTree_i::TrimFilter_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/LibHome.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/TrimFilter_i.h"

namespace GblAdapterLib {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

TrimFilter_i::TrimFilter_i ()
//#UC START# *45EEBB9B01F4_45F6A01A007D_45F6AA230271_BASE_INIT*
: m_is_trimmed (false)
//#UC END# *45EEBB9B01F4_45F6A01A007D_45F6AA230271_BASE_INIT*
{
	//#UC START# *45EEBB9B01F4_45F6A01A007D_45F6AA230271_BODY*
	//#UC END# *45EEBB9B01F4_45F6A01A007D_45F6AA230271_BODY*
}

TrimFilter_i::~TrimFilter_i () {
	//#UC START# *45F6AA230271_DESTR_BODY*
	//#UC END# *45F6AA230271_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from TrimFilter
bool TrimFilter_i::get_is_trimmed () const {
	//#UC START# *45EEC54700D0_45F6AA230271_GET*
	return m_is_trimmed;
	//#UC END# *45EEC54700D0_45F6AA230271_GET*
}

void TrimFilter_i::set_is_trimmed (bool is_trimmed) {
	//#UC START# *45EEC54700D0_45F6AA230271_SET*
	m_is_trimmed = is_trimmed;
	//#UC END# *45EEC54700D0_45F6AA230271_SET*
}
} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

