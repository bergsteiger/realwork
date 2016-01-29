////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/ExternalOperation_i/ExternalOperation_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::ExternalOperation_i::ExternalOperation_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/LibHome.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/ExternalOperation_i/ExternalOperation_i.h"

namespace GblAdapterLib {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

ExternalOperation_i::ExternalOperation_i (ObjectId id)
//#UC START# *45EEAEA10295_45F577DE0283_45F5798C006D_BASE_INIT*
	: m_id (id)
//#UC END# *45EEAEA10295_45F577DE0283_45F5798C006D_BASE_INIT*
{
	//#UC START# *45EEAEA10295_45F577DE0283_45F5798C006D_BODY*
	//#UC END# *45EEAEA10295_45F577DE0283_45F5798C006D_BODY*
}

ExternalOperation_i::~ExternalOperation_i () {
	//#UC START# *45F5798C006D_DESTR_BODY*
	//#UC END# *45F5798C006D_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from ExternalOperation
ObjectId ExternalOperation_i::get_id () const {
	//#UC START# *45EEAEA10296_45F5798C006D_GET*
	return m_id;
	//#UC END# *45EEAEA10296_45F5798C006D_GET*
}
} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

