////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/ApplicationHelper/SessionHelper.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> garant6x::GblAdapterLib::ApplicationHelper::SessionHelper
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/ApplicationHelper/SessionHelper.h"

namespace GblAdapterLib {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

SessionHelper::SessionHelper ()
//#UC START# *477129B00039_BASE_INIT*
	: m_is_session_active (false)
//#UC END# *477129B00039_BASE_INIT*
{
	//#UC START# *477129B00039_BODY*
	//#UC END# *477129B00039_BODY*
}

SessionHelper::~SessionHelper () {
	//#UC START# *47711DA00052_DESTR_BODY*
	//#UC END# *47711DA00052_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors

bool SessionHelper::get_is_session_active () const {
	//#UC START# *47711DCF03A0_GET_ACCESSOR*
	return m_is_session_active;
	//#UC END# *47711DCF03A0_GET_ACCESSOR*
}

void SessionHelper::set_is_session_active (bool is_session_active) {
	//#UC START# *47711DCF03A0_SET_ACCESSOR*
	m_is_session_active = is_session_active;
	//#UC END# *47711DCF03A0_SET_ACCESSOR*
}


} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

