////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/CoreSrv/ServerSecurity.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<ServerInterceptor::Class>> shared::CoreSrv::interceptors::ServerSecurity
//
// Серверной интерцептор для получения контекста сессии. Принимает от клиента  объект Токен с
// данными безопасности.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CORESRV_INTERCEPTORS_SERVERSECURITY_H__
#define __SHARED_CORESRV_INTERCEPTORS_SERVERSECURITY_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/Core/impl/Root_i/ExecutorBase.h"
namespace CoreSrv {

// Серверной интерцептор для получения контекста сессии. Принимает от клиента  объект Токен с
// данными безопасности.

class ServerSecurity 
	: virtual public PortableInterceptor::ServerRequestInterceptor
	, virtual public TAO_Local_RefCounted_Object
{
public:
	ServerSecurity () {
	}

//////////////////////////////////////////////////////////////////////////////////////////
// interceptor methods
private:
	char* name() throw (CORBA::SystemException);	
	
	void destroy() throw (CORBA::SystemException);
	
	void receive_request_service_contexts(PortableInterceptor::ServerRequestInfo_ptr ri) throw (PortableInterceptor::ForwardRequest, CORBA::SystemException);
	
	void receive_request(PortableInterceptor::ServerRequestInfo_ptr ri) throw (PortableInterceptor::ForwardRequest, CORBA::SystemException);
	
	void send_reply(PortableInterceptor::ServerRequestInfo_ptr ri) throw (CORBA::SystemException);
	
	void send_exception(PortableInterceptor::ServerRequestInfo_ptr ri) throw (PortableInterceptor::ForwardRequest, CORBA::SystemException);
	
	void send_other(PortableInterceptor::ServerRequestInfo_ptr ri) throw (PortableInterceptor::ForwardRequest, CORBA::SystemException);

}; // class ServerSecurity

} // namespace CoreSrv


#endif //__SHARED_CORESRV_INTERCEPTORS_SERVERSECURITY_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
