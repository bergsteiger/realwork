////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/ScriptFromLink.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Document_i::ScriptFromLink
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/LibHome.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/ScriptFromLink.h"

namespace GblAdapterLib {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

ScriptFromLink::ScriptFromLink (GblPilot::Link* server_link) : ExternalLinkFromLink(server_link)
//#UC START# *559E9DF3002D_559EA10A018E_559F7C0002EC_BASE_INIT*
	, ObjectFromLink_i (server_link)
//#UC END# *559E9DF3002D_559EA10A018E_559F7C0002EC_BASE_INIT*
{
	//#UC START# *559E9DF3002D_559EA10A018E_559F7C0002EC_BODY*
	//#UC END# *559E9DF3002D_559EA10A018E_559F7C0002EC_BODY*
}

ScriptFromLink::~ScriptFromLink () {
	//#UC START# *559F7C0002EC_DESTR_BODY*
	//#UC END# *559F7C0002EC_DESTR_BODY*
}



//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods

// overloaded method from ObjectFromLink
LinkedObjectType ScriptFromLink::get_object_type () const {
	//#UC START# *559EA0DE038A_559F7C0002EC*
	throw Core::Root::MDAGenNotImplemented(GDS_CURRENT_FUNCTION);
	//#UC END# *559EA0DE038A_559F7C0002EC*
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

