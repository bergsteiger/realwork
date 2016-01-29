////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/ListFromLink.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Document_i::ListFromLink
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/LibHome.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/ListFromLink.h"
// by <<uses>> dependencies
#include "garant6x/implementation/Garant/GblAdapterLib/DynamicDocList/DynamicDocList.h"

namespace GblAdapterLib {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

ListFromLink::ListFromLink (GblPilot::Link* server_link) : ObjectFromLink_i(server_link)
//#UC START# *559E9DF3002D_559EA10A018E_559F75EF03DA_BASE_INIT*
//#UC END# *559E9DF3002D_559EA10A018E_559F75EF03DA_BASE_INIT*
{
	//#UC START# *559E9DF3002D_559EA10A018E_559F75EF03DA_BODY*
	//#UC END# *559E9DF3002D_559EA10A018E_559F75EF03DA_BODY*
}

ListFromLink::~ListFromLink () {
	//#UC START# *559F75EF03DA_DESTR_BODY*
	//#UC END# *559F75EF03DA_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from ObjectFromLink
Core::IObject* ListFromLink::get_object () const {
	//#UC START# *559EA0D2028B_559F75EF03DA*
	try {
		GblDocList::DocListTree_var server_list = this->get_server_link ()->get_list ();
		GDS_ASSERT (!CORBA::is_nil (server_list));
		return DynListFactory::make (server_list);
	} catch (GCD::CanNotFindData&) {
	}
	throw InvalidTopicId ();

	//#UC END# *559EA0D2028B_559F75EF03DA*
}

// implemented method from ObjectFromLink
LinkedObjectType ListFromLink::get_object_type () const {
	//#UC START# *559EA0DE038A_559F75EF03DA*
	return LO_MULTILINK;
	//#UC END# *559EA0DE038A_559F75EF03DA*
}
} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

