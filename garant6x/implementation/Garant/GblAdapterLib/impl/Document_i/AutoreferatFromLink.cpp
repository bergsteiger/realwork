////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/AutoreferatFromLink.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Document_i::AutoreferatFromLink
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/LibHome.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/AutoreferatFromLink.h"

namespace GblAdapterLib {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

AutoreferatFromLink::AutoreferatFromLink (GblPilot::Link* server_link) : ObjectFromLink_i(server_link)
//#UC START# *559E9DF3002D_559EA10A018E_559F7C3B0387_BASE_INIT*
//#UC END# *559E9DF3002D_559EA10A018E_559F7C3B0387_BASE_INIT*
{
	//#UC START# *559E9DF3002D_559EA10A018E_559F7C3B0387_BODY*
	//#UC END# *559E9DF3002D_559EA10A018E_559F7C3B0387_BODY*
}

AutoreferatFromLink::~AutoreferatFromLink () {
	//#UC START# *559F7C3B0387_DESTR_BODY*
	//#UC END# *559F7C3B0387_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from ObjectFromLink
Core::IObject* AutoreferatFromLink::get_object () const {
	//#UC START# *559EA0D2028B_559F7C3B0387*
	GblPilot::Document_var server_autoreferat = this->get_server_link ()->get_document ();
	return DocumentFactory::make (server_autoreferat.in(), FK_AUTOREFERAT_DOCUMENT);	
	//#UC END# *559EA0D2028B_559F7C3B0387*
}

// implemented method from ObjectFromLink
LinkedObjectType AutoreferatFromLink::get_object_type () const {
	//#UC START# *559EA0DE038A_559F7C3B0387*
	return LO_AUTOREFERAT;
	//#UC END# *559EA0DE038A_559F7C3B0387*
}
} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

