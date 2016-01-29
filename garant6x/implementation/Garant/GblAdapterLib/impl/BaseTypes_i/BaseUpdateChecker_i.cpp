////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/BaseTypes_i/BaseUpdateChecker_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> garant6x::GblAdapterLib::BaseTypes_i::BaseUpdateChecker_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/BaseTypes_i/BaseUpdateChecker_i.h"
// by <<uses>> dependencies
#include "garant6x/implementation/Garant/GblAdapterLib/ApplicationHelper/ApplicationHelper.h"

namespace GblAdapterLib {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

BaseUpdateChecker_i::~BaseUpdateChecker_i () {
	//#UC START# *45702C2801E4_DESTR_BODY*
	//#UC END# *45702C2801E4_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from StartLocal::BaseUpdateChecker
// метод вызывается при обновлении базы
void BaseUpdateChecker_i::check_update_and_clear_cache () const {
	//#UC START# *456FF2C6035B_45702C2801E4*
	if (!ApplicationHelper::instance ()->compare_and_update_base_id (m_base_id)) {
		const_cast<BaseUpdateChecker_i*> (this)->clear_cache ();
	}
	//#UC END# *456FF2C6035B_45702C2801E4*
}
} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

