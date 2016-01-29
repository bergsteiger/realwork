////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/QueryFromLink.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Document_i::QueryFromLink
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/LibHome.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/QueryFromLink.h"
// by <<uses>> dependencies
#include "garant6x/implementation/Garant/GblAdapterLib/Search/Search.h"

namespace GblAdapterLib {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

QueryFromLink::QueryFromLink (GblPilot::Link* server_link) : ObjectFromLink_i(server_link)
//#UC START# *559E9DF3002D_559EA10A018E_559F7C8400E2_BASE_INIT*
//#UC END# *559E9DF3002D_559EA10A018E_559F7C8400E2_BASE_INIT*
{
	//#UC START# *559E9DF3002D_559EA10A018E_559F7C8400E2_BODY*
	//#UC END# *559E9DF3002D_559EA10A018E_559F7C8400E2_BODY*
}

QueryFromLink::~QueryFromLink () {
	//#UC START# *559F7C8400E2_DESTR_BODY*
	//#UC END# *559F7C8400E2_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from ObjectFromLink
Core::IObject* QueryFromLink::get_object () const {
	//#UC START# *559EA0D2028B_559F7C8400E2*
	GblPilotQueryDef::Query_var server_query = this->get_server_link ()->get_query ();
	QueryCreator_var creator (QueryCreatorFactory::make ());
	return creator->make_query (server_query.in ());
	//#UC END# *559EA0D2028B_559F7C8400E2*
}

// implemented method from ObjectFromLink
LinkedObjectType QueryFromLink::get_object_type () const {
	//#UC START# *559EA0DE038A_559F7C8400E2*
	return LO_QUERY;
	//#UC END# *559EA0DE038A_559F7C8400E2*
}
} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

