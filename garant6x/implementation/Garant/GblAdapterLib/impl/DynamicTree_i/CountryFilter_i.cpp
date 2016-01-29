////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/CountryFilter_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::DynamicTree_i::CountryFilter_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/LibHome.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/CountryFilter_i.h"

namespace GblAdapterLib {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

CountryFilter_i::CountryFilter_i (const NodeBase* country)
//#UC START# *47F7244B0303_47F7267701D5_47F7262802B1_BASE_INIT*
: m_country (Core::IObject::_duplicate (const_cast <NodeBase*> (country)))
//#UC END# *47F7244B0303_47F7267701D5_47F7262802B1_BASE_INIT*
{
	//#UC START# *47F7244B0303_47F7267701D5_47F7262802B1_BODY*
	//#UC END# *47F7244B0303_47F7267701D5_47F7262802B1_BODY*
}

CountryFilter_i::CountryFilter_i ()
//#UC START# *45EEBB9B01F4_45F6A01A007D_47F7262802B1_BASE_INIT*
//#UC END# *45EEBB9B01F4_45F6A01A007D_47F7262802B1_BASE_INIT*
{
	//#UC START# *45EEBB9B01F4_45F6A01A007D_47F7262802B1_BODY*
	//#UC END# *45EEBB9B01F4_45F6A01A007D_47F7262802B1_BODY*
}

CountryFilter_i::~CountryFilter_i () {
	//#UC START# *47F7262802B1_DESTR_BODY*
	//#UC END# *47F7262802B1_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from CountryFilter
const NodeBase* CountryFilter_i::get_country () const {
	//#UC START# *47F724570292_47F7262802B1_GET*
	return m_country.ptr ();
	//#UC END# *47F724570292_47F7262802B1_GET*
}

NodeBase* CountryFilter_i::get_country () {
	return const_cast<NodeBase*>(((const CountryFilter_i*)this)->get_country ());
}

void CountryFilter_i::set_country (NodeBase* country) {
	//#UC START# *47F724570292_47F7262802B1_SET*
	m_country = Core::IObject::_duplicate (country);
	//#UC END# *47F724570292_47F7262802B1_SET*
}
} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

