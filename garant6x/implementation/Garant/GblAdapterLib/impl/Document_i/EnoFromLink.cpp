////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/EnoFromLink.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Document_i::EnoFromLink
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/LibHome.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/EnoFromLink.h"

namespace GblAdapterLib {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

EnoFromLink::EnoFromLink (GblPilot::Link* server_link) : ExternalLinkFromLink(server_link)
//#UC START# *559E9DF3002D_559EA10A018E_559F7BD802D5_BASE_INIT*
	, ObjectFromLink_i (server_link)
//#UC END# *559E9DF3002D_559EA10A018E_559F7BD802D5_BASE_INIT*
{
	//#UC START# *559E9DF3002D_559EA10A018E_559F7BD802D5_BODY*
	//#UC END# *559E9DF3002D_559EA10A018E_559F7BD802D5_BODY*
}

EnoFromLink::~EnoFromLink () {
	//#UC START# *559F7BD802D5_DESTR_BODY*
	//#UC END# *559F7BD802D5_DESTR_BODY*
}



//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods

// overloaded method from ObjectFromLink
LinkedObjectType EnoFromLink::get_object_type () const {
	//#UC START# *559EA0DE038A_559F7BD802D5*
	return LO_ENO;
	//#UC END# *559EA0DE038A_559F7BD802D5*
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

