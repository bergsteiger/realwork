////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/DocTree_i/DocNodeFilter_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::DocTree_i::DocNodeFilter_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/LibHome.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DocTree_i/DocNodeFilter_i.h"

namespace GblAdapterLib {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

DocNodeFilter_i::DocNodeFilter_i ()
//#UC START# *45EEBB9B01F4_45F6A01A007D_45F177DF01C5_BASE_INIT*
: m_type (0), m_id (0), m_inheritable (0)

//#UC END# *45EEBB9B01F4_45F6A01A007D_45F177DF01C5_BASE_INIT*
{
	//#UC START# *45EEBB9B01F4_45F6A01A007D_45F177DF01C5_BODY*
	//#UC END# *45EEBB9B01F4_45F6A01A007D_45F177DF01C5_BODY*
}

DocNodeFilter_i::~DocNodeFilter_i () {
	//#UC START# *45F177DF01C5_DESTR_BODY*
	//#UC END# *45F177DF01C5_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from DocNodeFilter
TagHandle DocNodeFilter_i::get_id () const {
	//#UC START# *46039E9C00BB_45F177DF01C5_GET*
	return m_id;
	//#UC END# *46039E9C00BB_45F177DF01C5_GET*
}

void DocNodeFilter_i::set_id (TagHandle id) {
	//#UC START# *46039E9C00BB_45F177DF01C5_SET*
	m_id = id;
	//#UC END# *46039E9C00BB_45F177DF01C5_SET*
}

// implemented method from DocNodeFilter
bool DocNodeFilter_i::get_inheritable () const {
	//#UC START# *46039ECA03C8_45F177DF01C5_GET*
	return m_inheritable;
	//#UC END# *46039ECA03C8_45F177DF01C5_GET*
}

void DocNodeFilter_i::set_inheritable (bool inheritable) {
	//#UC START# *46039ECA03C8_45F177DF01C5_SET*
	m_inheritable = inheritable;
	//#UC END# *46039ECA03C8_45F177DF01C5_SET*
}

// implemented method from DocNodeFilter
NodeType DocNodeFilter_i::get_type () const {
	//#UC START# *4603F61F03C8_45F177DF01C5_GET*
	return m_type;
	//#UC END# *4603F61F03C8_45F177DF01C5_GET*
}

void DocNodeFilter_i::set_type (NodeType type) {
	//#UC START# *4603F61F03C8_45F177DF01C5_SET*
	m_type = type;
	//#UC END# *4603F61F03C8_45F177DF01C5_SET*
}
} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

