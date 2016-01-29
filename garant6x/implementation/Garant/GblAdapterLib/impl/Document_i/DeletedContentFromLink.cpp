////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/DeletedContentFromLink.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Document_i::DeletedContentFromLink
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/LibHome.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/DeletedContentFromLink.h"

namespace GblAdapterLib {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

DeletedContentFromLink::DeletedContentFromLink (GblPilot::Link* server_link) : ObjectFromLink_i(server_link)
//#UC START# *559E9DF3002D_559EA10A018E_55BB3B990139_BASE_INIT*
//#UC END# *559E9DF3002D_559EA10A018E_55BB3B990139_BASE_INIT*
{
	//#UC START# *559E9DF3002D_559EA10A018E_55BB3B990139_BODY*
	//#UC END# *559E9DF3002D_559EA10A018E_55BB3B990139_BODY*
}

DeletedContentFromLink::~DeletedContentFromLink () {
	//#UC START# *55BB3B990139_DESTR_BODY*
	//#UC END# *55BB3B990139_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from ObjectFromLink
Core::IObject* DeletedContentFromLink::get_object () const {
	//#UC START# *559EA0D2028B_55BB3B990139*
	throw FolderLinkNotFound ();
	//#UC END# *559EA0D2028B_55BB3B990139*
}

// implemented method from ObjectFromLink
LinkedObjectType DeletedContentFromLink::get_object_type () const {
	//#UC START# *559EA0DE038A_55BB3B990139*
	throw FolderLinkNotFound ();
	//#UC END# *559EA0DE038A_55BB3B990139*
}
} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

