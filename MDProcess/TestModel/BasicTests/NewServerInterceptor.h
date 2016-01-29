////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/TestModel/BasicTests/NewServerInterceptor.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<ServerInterceptor::Class>> TestModel::BasicTests::NewLibSupport::NewServerInterceptor
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __TESTMODEL_BASICTESTS_NEWLIBSUPPORT_NEWSERVERINTERCEPTOR_H__
#define __TESTMODEL_BASICTESTS_NEWLIBSUPPORT_NEWSERVERINTERCEPTOR_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/Core/impl/Root_i/ExecutorBase.h"
namespace BasicTests {


class NewServerInterceptor 
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

}; // class NewServerInterceptor

} // namespace BasicTests


#endif //__TESTMODEL_BASICTESTS_NEWLIBSUPPORT_NEWSERVERINTERCEPTOR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
