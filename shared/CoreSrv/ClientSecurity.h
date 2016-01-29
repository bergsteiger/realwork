////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/CoreSrv/ClientSecurity.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<ClientInterceptor::Class>> shared::CoreSrv::interceptors::ClientSecurity
//
// Клиентский интерцептор для передачи контекста сессии. Передает на сервер объект Токен с данными
// безопасности.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CORESRV_INTERCEPTORS_CLIENTSECURITY_H__
#define __SHARED_CORESRV_INTERCEPTORS_CLIENTSECURITY_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/Core/impl/Root_i/ExecutorBase.h"
namespace CoreSrv {

// Клиентский интерцептор для передачи контекста сессии. Передает на сервер объект Токен с данными
// безопасности.

class ClientSecurity 
	: virtual public PortableInterceptor::ClientRequestInterceptor
	, virtual public TAO_Local_RefCounted_Object
{
public:
	ClientSecurity () {
	}

//////////////////////////////////////////////////////////////////////////////////////////
// interceptor methods
private:
	char* name() throw (CORBA::SystemException);	
	
	void destroy() throw (CORBA::SystemException);
	
	void send_request (PortableInterceptor::ClientRequestInfo_ptr ri) throw (PortableInterceptor::ForwardRequest, CORBA::SystemException);
	
	void send_poll (PortableInterceptor::ClientRequestInfo_ptr ri) throw (CORBA::SystemException);
	
	void receive_reply (PortableInterceptor::ClientRequestInfo_ptr ri) throw (CORBA::SystemException);
	
	void receive_exception (PortableInterceptor::ClientRequestInfo_ptr ri) throw (PortableInterceptor::ForwardRequest, CORBA::SystemException);
	
	void receive_other (PortableInterceptor::ClientRequestInfo_ptr ri) throw (PortableInterceptor::ForwardRequest, CORBA::SystemException);

}; // class ClientSecurity

} // namespace CoreSrv


#endif //__SHARED_CORESRV_INTERCEPTORS_CLIENTSECURITY_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
