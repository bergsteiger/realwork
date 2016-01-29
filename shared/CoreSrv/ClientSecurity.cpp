////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/CoreSrv/ClientSecurity.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<ClientInterceptor::Class>> shared::CoreSrv::interceptors::ClientSecurity
//
// Клиентский интерцептор для передачи контекста сессии. Передает на сервер объект Токен с данными
// безопасности.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/CoreSrv/ClientSecurity.h"
#include "shared/CoreSrv/LibHome.h"
// by <<uses>> dependencies
#include "shared/CoreSrv/Security/Security.h"
#include "shared/CoreSrv/SecuritySrv/SecuritySrv.h"

namespace CoreSrv {

//////////////////////////////////////////////////////////////////////////////////////////
// interceptor methods
const IOP::ServiceId ISID_SERVER_SECURITY = 3879353251;

char* ClientSecurity::name() throw (CORBA::SystemException) {
	return CORBA::string_dup("CoreSrv::ClientSecurity");
}
	
void ClientSecurity::destroy() throw (CORBA::SystemException) {
	//#UC START# *45E58F48007D_DESTROY*
	//#UC END# *45E58F48007D_DESTROY*
}

void ClientSecurity::send_request (PortableInterceptor::ClientRequestInfo_ptr ri) throw (PortableInterceptor::ForwardRequest, CORBA::SystemException) {
	//#UC START# *45E58F48007D_SEND_R*
		SecuritySrv::Token tk;
		tk.sid = 0;
		tk.uid = 0;
		try {
			tk.sid = SessionFactory::get().get_context_sid ();			
			if (tk.sid == 0) {
				tk.sid = SessionFactory::get().get_self_sid ();
				tk.uid = SessionFactory::get().get_self_uid ();
			} else {
				tk.uid = SessionFactory::get().get_context_uid ();
			}
		} catch (...) {
		}

		IOP::ServiceContext service_context;
		service_context.context_id = ISID_SERVER_SECURITY;
		service_context.context_data.replace (sizeof (SecuritySrv::Token), sizeof (SecuritySrv::Token), (CORBA::Octet*)&tk, 0);
		ri->add_request_service_context (service_context, false);
	//#UC END# *45E58F48007D_SEND_R*
}

void ClientSecurity::send_poll (PortableInterceptor::ClientRequestInfo_ptr ri) throw (CORBA::SystemException) {
	//#UC START# *45E58F48007D_SEND_P*
	//#UC END# *45E58F48007D_SEND_P*
}

void ClientSecurity::receive_reply (PortableInterceptor::ClientRequestInfo_ptr ri) throw (CORBA::SystemException) {
	//#UC START# *45E58F48007D_RECEIVE_R*
	try {
		CORBA::Any_var data = ri->get_slot (CurrentSlotAccessor::get_current_token_slot_id ());
		LibHomeFactory::get().get_orb_facet().get_pi_current ().set_slot (CurrentSlotAccessor::get_current_token_slot_id (), *data);
	} CATCH_AND_LOG ("...");
	//#UC END# *45E58F48007D_RECEIVE_R*
}

void ClientSecurity::receive_exception (PortableInterceptor::ClientRequestInfo_ptr ri) throw (PortableInterceptor::ForwardRequest, CORBA::SystemException) {
	//#UC START# *45E58F48007D_RECEIVE_E*
	try {
		CORBA::Any_var data = ri->get_slot (CurrentSlotAccessor::get_current_token_slot_id ());
		LibHomeFactory::get().get_orb_facet().get_pi_current ().set_slot (CurrentSlotAccessor::get_current_token_slot_id (), *data);
	} CATCH_AND_LOG ("...");
	//#UC END# *45E58F48007D_RECEIVE_E*
}

void ClientSecurity::receive_other (PortableInterceptor::ClientRequestInfo_ptr ri) throw (PortableInterceptor::ForwardRequest, CORBA::SystemException) {
	//#UC START# *45E58F48007D_RECEIVE_O*
	try {
		CORBA::Any_var data = ri->get_slot (CurrentSlotAccessor::get_current_token_slot_id ());
		LibHomeFactory::get().get_orb_facet().get_pi_current ().set_slot (CurrentSlotAccessor::get_current_token_slot_id (), *data);
	} CATCH_AND_LOG ("...");
	//#UC END# *45E58F48007D_RECEIVE_O*
}


} // namespace CoreSrv

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
