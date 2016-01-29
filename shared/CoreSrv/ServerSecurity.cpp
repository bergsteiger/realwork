////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/CoreSrv/ServerSecurity.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<ServerInterceptor::Class>> shared::CoreSrv::interceptors::ServerSecurity
//
// Серверной интерцептор для получения контекста сессии. Принимает от клиента  объект Токен с
// данными безопасности.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/CoreSrv/ServerSecurity.h"
#include "shared/CoreSrv/LibHome.h"
// by <<uses>> dependencies
#include "shared/CoreSrv/SecuritySrv/SecuritySrv.h"

namespace CoreSrv {

//////////////////////////////////////////////////////////////////////////////////////////
// interceptor methods
const IOP::ServiceId ISID_SERVER_SECURITY = 3879353251;

char* ServerSecurity::name() throw (CORBA::SystemException) {
	return CORBA::string_dup("CoreSrv::ServerSecurity");
}
	
void ServerSecurity::destroy() throw (CORBA::SystemException) {
	//#UC START# *45E594460261_DESTROY*
	//#UC END# *45E594460261_DESTROY*
}

void ServerSecurity::receive_request_service_contexts(PortableInterceptor::ServerRequestInfo_ptr ri) throw (PortableInterceptor::ForwardRequest, CORBA::SystemException) {
	//#UC START# *45E594460261_RECEIVE_RSC*
	CORBA::Any data;
	try {
		IOP::ServiceContext_var service_context = ri->get_request_service_context (ISID_SERVER_SECURITY);
		const SecuritySrv::Token* token = (const CoreSrv::SecuritySrv::Token*)service_context->context_data.get_buffer ();

		data <<= *token;

		ri->set_slot (CurrentSlotAccessor::get_current_token_slot_id (), data);

	} CATCH_AND_LOG ("while work with Current")
	//#UC END# *45E594460261_RECEIVE_RSC*
}
	
void ServerSecurity::receive_request(PortableInterceptor::ServerRequestInfo_ptr ri) throw (PortableInterceptor::ForwardRequest, CORBA::SystemException) {
	//#UC START# *45E594460261_RECEIVE_R*
	//#UC END# *45E594460261_RECEIVE_R*
}
	
void ServerSecurity::send_reply(PortableInterceptor::ServerRequestInfo_ptr ri) throw (CORBA::SystemException) {
	//#UC START# *45E594460261_SEND_R*
	//#UC END# *45E594460261_SEND_R*
}
	
void ServerSecurity::send_exception(PortableInterceptor::ServerRequestInfo_ptr ri) throw (PortableInterceptor::ForwardRequest, CORBA::SystemException) {
	//#UC START# *45E594460261_SEND_E*
	//#UC END# *45E594460261_SEND_E*
}
	
void ServerSecurity::send_other(PortableInterceptor::ServerRequestInfo_ptr ri) throw (PortableInterceptor::ForwardRequest, CORBA::SystemException) {
	//#UC START# *45E594460261_SEND_O*
	//#UC END# *45E594460261_SEND_O*
}


} // namespace CoreSrv

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
