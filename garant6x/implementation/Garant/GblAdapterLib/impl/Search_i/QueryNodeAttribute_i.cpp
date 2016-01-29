////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Search_i/QueryNodeAttribute_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Search_i::QueryNodeAttribute_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/LibHome.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Search_i/QueryNodeAttribute_i.h"

namespace GblAdapterLib {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

QueryNodeAttribute_i::QueryNodeAttribute_i (AttributeTag_const attribute_tag)
//#UC START# *45EEE3890352_45FFE4E60138_45FFE86F0103_BASE_INIT*
	: QueryAttribute_i (QTT_NODE, attribute_tag)
//#UC END# *45EEE3890352_45FFE4E60138_45FFE86F0103_BASE_INIT*
{
	//#UC START# *45EEE3890352_45FFE4E60138_45FFE86F0103_BODY*
	//#UC END# *45EEE3890352_45FFE4E60138_45FFE86F0103_BODY*
}

QueryNodeAttribute_i::~QueryNodeAttribute_i () {
	//#UC START# *45FFE86F0103_DESTR_BODY*
	//#UC END# *45FFE86F0103_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from QueryAttribute
void QueryNodeAttribute_i::clear () {
	//#UC START# *4663F1D20290_45FFE86F0103*
	m_values.clear ();
	//#UC END# *4663F1D20290_45FFE86F0103*
}

// implemented method from QueryNodeAttribute
void QueryNodeAttribute_i::add_value (QueryLogicOperation operation, NodeBase* node) {
	//#UC START# *45EEE3890354_45FFE86F0103*
	m_values.push_back (QueryNodeValue (node, operation));
	//#UC END# *45EEE3890354_45FFE86F0103*
}

// implemented method from QueryNodeAttribute
const NodeValueList& QueryNodeAttribute_i::get_values () const {
	//#UC START# *45EEE6290002_45FFE86F0103_GET*
	return m_values;
	//#UC END# *45EEE6290002_45FFE86F0103_GET*
}
} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

