////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Search_i/QueryContextAttribute_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Search_i::QueryContextAttribute_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/LibHome.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Search_i/QueryContextAttribute_i.h"

namespace GblAdapterLib {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

QueryContextAttribute_i::QueryContextAttribute_i (AttributeTag_const attribute_tag)
//#UC START# *45EEE3740381_45FFE4CA02FD_45FFE88B0180_BASE_INIT*
	: QueryAttribute_i (QTT_CONTEXT, attribute_tag)
//#UC END# *45EEE3740381_45FFE4CA02FD_45FFE88B0180_BASE_INIT*
{
	//#UC START# *45EEE3740381_45FFE4CA02FD_45FFE88B0180_BODY*
	//#UC END# *45EEE3740381_45FFE4CA02FD_45FFE88B0180_BODY*
}

QueryContextAttribute_i::~QueryContextAttribute_i () {
	//#UC START# *45FFE88B0180_DESTR_BODY*
	//#UC END# *45FFE88B0180_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from QueryAttribute
void QueryContextAttribute_i::clear () {
	//#UC START# *4663F1D20290_45FFE88B0180*
	m_values.clear ();
	//#UC END# *4663F1D20290_45FFE88B0180*
}

// implemented method from QueryContextAttribute
void QueryContextAttribute_i::add_value (QueryLogicOperation operation, GCI::IO::String* context) {
	//#UC START# *45EEE3740383_45FFE88B0180*
	m_values.push_back (ContextValue (context));
	//#UC END# *45EEE3740383_45FFE88B0180*
}

// implemented method from QueryContextAttribute
const ContextValueList& QueryContextAttribute_i::get_values () const {
	//#UC START# *45EEE405019B_45FFE88B0180_GET*
	return m_values;
	//#UC END# *45EEE405019B_45FFE88B0180_GET*
}
} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

