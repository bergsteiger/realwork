////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/ExternalObjectFromLink.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Document_i::ExternalObjectFromLink
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/LibHome.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/ExternalObjectFromLink.h"
// by <<uses>> dependencies
#include "garant6x/implementation/Garant/GblAdapterLib/ApplicationHelper/ApplicationHelper.h"

namespace GblAdapterLib {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

ExternalObjectFromLink::ExternalObjectFromLink (GblPilot::Link* server_link) : ObjectFromLink_i(server_link)
//#UC START# *559E9DF3002D_559EA10A018E_559F7B4B0126_BASE_INIT*
//#UC END# *559E9DF3002D_559EA10A018E_559F7B4B0126_BASE_INIT*
{
	//#UC START# *559E9DF3002D_559EA10A018E_559F7B4B0126_BODY*
	//#UC END# *559E9DF3002D_559EA10A018E_559F7B4B0126_BODY*
}

ExternalObjectFromLink::~ExternalObjectFromLink () {
	//#UC START# *559F7B4B0126_DESTR_BODY*
	//#UC END# *559F7B4B0126_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from ObjectFromLink
Core::IObject* ExternalObjectFromLink::get_object () const {
	//#UC START# *559EA0D2028B_559F7B4B0126*
	try {
		GblPilot::InternalObj_var internal_object = this->get_server_link ()->get_internal_object ();
		ExternalObject_var external_object;
		try {
			external_object = ExternalObjectFactory::make (internal_object.in ());
		} catch (CORBA::Exception&) {
			ApplicationHelper::instance ()->get_cached_life_cycle_manager ()->release_object (internal_object.in ());
			throw CanNotFindData ();
		}
		ApplicationHelper::instance ()->get_cached_life_cycle_manager ()->release_object (internal_object.in ());
		return external_object._retn ();
	} catch (CORBA::Exception&) {
		throw CanNotFindData ();
	}
	GDS_ASSERT (false);
	return 0;
	//#UC END# *559EA0D2028B_559F7B4B0126*
}

// implemented method from ObjectFromLink
LinkedObjectType ExternalObjectFromLink::get_object_type () const {
	//#UC START# *559EA0DE038A_559F7B4B0126*
	return LO_EXTERNAL_OBJECT;
	//#UC END# *559EA0DE038A_559F7B4B0126*
}
} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

