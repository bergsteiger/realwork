////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/TextOpFilter_i.cpp"
// C++ implementation files (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::DynamicTree_i::TextOpFilter_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/LibHome.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/TextOpFilter_i.h"

namespace GblAdapterLib {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

TextOpFilter_i::TextOpFilter_i ()
//#UC START# *45EEBB9B01F4_45F6A01A007D_45F6B63602BF_BASE_INIT*
//#UC END# *45EEBB9B01F4_45F6A01A007D_45F6B63602BF_BASE_INIT*
{
	//#UC START# *45EEBB9B01F4_45F6A01A007D_45F6B63602BF_BODY*
	//#UC END# *45EEBB9B01F4_45F6A01A007D_45F6B63602BF_BODY*
}

TextOpFilter_i::~TextOpFilter_i () {
	//#UC START# *45F6B63602BF_DESTR_BODY*
	//#UC END# *45F6B63602BF_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from TextOptFilter
bool TextOpFilter_i::get_without_name () const {
	//#UC START# *45EEC54700BF_45F6B63602BF_GET*
	return m_without_name;
	//#UC END# *45EEC54700BF_45F6B63602BF_GET*
}

void TextOpFilter_i::set_without_name (bool without_name) {
	//#UC START# *45EEC54700BF_45F6B63602BF_SET*
	m_without_name = without_name;
	//#UC END# *45EEC54700BF_45F6B63602BF_SET*
}
} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

