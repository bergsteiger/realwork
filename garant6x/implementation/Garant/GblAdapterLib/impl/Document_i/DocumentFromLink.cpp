////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/DocumentFromLink.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Document_i::DocumentFromLink
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/LibHome.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/DocumentFromLink.h"
// by <<uses>> dependencies
#include "garant6x/implementation/Garant/GblAdapterLib/DocumentHelper/DocumentFactoryKeyHelper.h"

namespace GblAdapterLib {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

DocumentFromLink::DocumentFromLink (GblPilot::Link* server_link) : ObjectFromLink_i(server_link)
//#UC START# *559E9DF3002D_559EA10A018E_559EA1890090_BASE_INIT*
//#UC END# *559E9DF3002D_559EA10A018E_559EA1890090_BASE_INIT*
{
	//#UC START# *559E9DF3002D_559EA10A018E_559EA1890090_BODY*
	//#UC END# *559E9DF3002D_559EA10A018E_559EA1890090_BODY*
}

DocumentFromLink::~DocumentFromLink () {
	//#UC START# *559EA1890090_DESTR_BODY*
	//#UC END# *559EA1890090_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from ObjectFromLink
Core::IObject* DocumentFromLink::get_object () const {
	//#UC START# *559EA0D2028B_559EA1890090*
	const GCD::PID& server_topic_id = this->get_server_link ()->get_topic_id ();
	Document_var document = DocumentFactory::make (server_topic_id, true, 0, DocumentFactoryKeyHelper::PID_to_key (server_topic_id));
	if (!document->is_alive ()) {
		throw InvalidTopicId ();
	}
	return document._retn ();
	//#UC END# *559EA0D2028B_559EA1890090*
}

// implemented method from ObjectFromLink
LinkedObjectType DocumentFromLink::get_object_type () const {
	//#UC START# *559EA0DE038A_559EA1890090*
	return LO_DOCUMENT;
	//#UC END# *559EA0DE038A_559EA1890090*
}
} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

