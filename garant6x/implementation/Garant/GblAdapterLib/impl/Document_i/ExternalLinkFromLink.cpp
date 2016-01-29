////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/ExternalLinkFromLink.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Document_i::ExternalLinkFromLink
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/LibHome.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/ExternalLinkFromLink.h"

namespace GblAdapterLib {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

ExternalLinkFromLink::ExternalLinkFromLink (GblPilot::Link* server_link) : ObjectFromLink_i(server_link)
//#UC START# *559E9DF3002D_559EA10A018E_559F7BA603C6_BASE_INIT*
//#UC END# *559E9DF3002D_559EA10A018E_559F7BA603C6_BASE_INIT*
{
	//#UC START# *559E9DF3002D_559EA10A018E_559F7BA603C6_BODY*
	//#UC END# *559E9DF3002D_559EA10A018E_559F7BA603C6_BODY*
}

ExternalLinkFromLink::~ExternalLinkFromLink () {
	//#UC START# *559F7BA603C6_DESTR_BODY*
	//#UC END# *559F7BA603C6_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from ObjectFromLink
Core::IObject* ExternalLinkFromLink::get_object () const {
	//#UC START# *559EA0D2028B_559F7BA603C6*
	try {
		CORBA::String_var url = this->get_server_link ()->get_string ();
		if (ACE_OS_String::strlen (url.in ()) == 0) {
			throw InvalidTopicId ();
		}
		return ExternalLinkFactory::make (url);
	} catch (GCD::CanNotFindData&) {
	}
	throw InvalidTopicId ();
	//#UC END# *559EA0D2028B_559F7BA603C6*
}

// implemented method from ObjectFromLink
LinkedObjectType ExternalLinkFromLink::get_object_type () const {
	//#UC START# *559EA0DE038A_559F7BA603C6*
	return LO_EXTERNAL_LINK;
	//#UC END# *559EA0DE038A_559F7BA603C6*
}
} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

