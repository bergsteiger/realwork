////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/BookmarkFromLink.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Document_i::BookmarkFromLink
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/LibHome.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/BookmarkFromLink.h"

namespace GblAdapterLib {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

BookmarkFromLink::BookmarkFromLink (GblPilot::Link* server_link) : ObjectFromLink_i(server_link)
//#UC START# *559E9DF3002D_559EA10A018E_559F7C7B00C2_BASE_INIT*
//#UC END# *559E9DF3002D_559EA10A018E_559F7C7B00C2_BASE_INIT*
{
	//#UC START# *559E9DF3002D_559EA10A018E_559F7C7B00C2_BODY*
	//#UC END# *559E9DF3002D_559EA10A018E_559F7C7B00C2_BODY*
}

BookmarkFromLink::~BookmarkFromLink () {
	//#UC START# *559F7C7B00C2_DESTR_BODY*
	//#UC END# *559F7C7B00C2_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from ObjectFromLink
Core::IObject* BookmarkFromLink::get_object () const {
	//#UC START# *559EA0D2028B_559F7C7B00C2*
	GblPilotDef::Bookmark server_bookmark = this->get_server_link ()->get_bookmark ();
	return BookmarkFactory::make (server_bookmark, 0, 0);
	//#UC END# *559EA0D2028B_559F7C7B00C2*
}

// implemented method from ObjectFromLink
LinkedObjectType BookmarkFromLink::get_object_type () const {
	//#UC START# *559EA0DE038A_559F7C7B00C2*
	return LO_BOOKMARK;
	//#UC END# *559EA0DE038A_559F7C7B00C2*
}
} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

