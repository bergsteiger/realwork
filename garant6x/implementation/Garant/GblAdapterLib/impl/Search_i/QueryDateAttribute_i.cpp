////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Search_i/QueryDateAttribute_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Search_i::QueryDateAttribute_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/LibHome.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Search_i/QueryDateAttribute_i.h"

namespace GblAdapterLib {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

QueryDateAttribute_i::QueryDateAttribute_i (AttributeTag_const attribute_tag)
//#UC START# *45EEE3790390_45FFE4EA02AF_45FFE8BB0095_BASE_INIT*
	: QueryAttribute_i (QTT_DATE, attribute_tag)
//#UC END# *45EEE3790390_45FFE4EA02AF_45FFE8BB0095_BASE_INIT*
{
	//#UC START# *45EEE3790390_45FFE4EA02AF_45FFE8BB0095_BODY*
	//#UC END# *45EEE3790390_45FFE4EA02AF_45FFE8BB0095_BODY*
}

QueryDateAttribute_i::~QueryDateAttribute_i () {
	//#UC START# *45FFE8BB0095_DESTR_BODY*
	//#UC END# *45FFE8BB0095_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from QueryAttribute
void QueryDateAttribute_i::clear () {
	//#UC START# *4663F1D20290_45FFE8BB0095*
	m_values.clear ();
	//#UC END# *4663F1D20290_45FFE8BB0095*
}

// implemented method from QueryDateAttribute
void QueryDateAttribute_i::add_value (QueryLogicOperation operation, const Date& from, const Date& to) {
	//#UC START# *45EEE3790392_45FFE8BB0095*
	GDS_ASSERT (m_values.size () <= 1); // only one date interval is supported
	m_values.push_back (DateValue (from, to, QLO_AND));
	//#UC END# *45EEE3790392_45FFE8BB0095*
}

// implemented method from QueryDateAttribute
const DateValueList& QueryDateAttribute_i::get_values () const {
	//#UC START# *45EEE5B50041_45FFE8BB0095_GET*
	return m_values;
	//#UC END# *45EEE5B50041_45FFE8BB0095_GET*
}
} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

