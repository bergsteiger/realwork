////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/ExternalOperationFromLink.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Document_i::ExternalOperationFromLink
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/LibHome.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/ExternalOperationFromLink.h"
// by <<uses>> dependencies
#include "garant6x/implementation/Garant/GblAdapterLib/ExternalOperation/ExternalOperation.h"

namespace GblAdapterLib {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

ExternalOperationFromLink::ExternalOperationFromLink (GblPilot::Link* server_link) : ObjectFromLink_i(server_link)
//#UC START# *559E9DF3002D_559EA10A018E_559F7C670381_BASE_INIT*
//#UC END# *559E9DF3002D_559EA10A018E_559F7C670381_BASE_INIT*
{
	//#UC START# *559E9DF3002D_559EA10A018E_559F7C670381_BODY*
	//#UC END# *559E9DF3002D_559EA10A018E_559F7C670381_BODY*
}

ExternalOperationFromLink::~ExternalOperationFromLink () {
	//#UC START# *559F7C670381_DESTR_BODY*
	//#UC END# *559F7C670381_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from ObjectFromLink
Core::IObject* ExternalOperationFromLink::get_object () const {
	//#UC START# *559EA0D2028B_559F7C670381*
	return ExternalOperationFactory::make (this->get_server_link ()->get_topic_id ().m_object_id);
	//#UC END# *559EA0D2028B_559F7C670381*
}

// implemented method from ObjectFromLink
LinkedObjectType ExternalOperationFromLink::get_object_type () const {
	//#UC START# *559EA0DE038A_559F7C670381*
	return LO_EXTERNAL_OPERATION;
	//#UC END# *559EA0DE038A_559F7C670381*
}
} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

