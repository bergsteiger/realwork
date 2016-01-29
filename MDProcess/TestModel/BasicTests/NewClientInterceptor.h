////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/TestModel/BasicTests/NewClientInterceptor.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<ClientInterceptor::Class>> TestModel::BasicTests::NewLibSupport::NewClientInterceptor
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __TESTMODEL_BASICTESTS_NEWLIBSUPPORT_NEWCLIENTINTERCEPTOR_H__
#define __TESTMODEL_BASICTESTS_NEWLIBSUPPORT_NEWCLIENTINTERCEPTOR_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/Core/impl/Root_i/ExecutorBase.h"
namespace BasicTests {


class NewClientInterceptor 
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

}; // class NewClientInterceptor

} // namespace BasicTests


#endif //__TESTMODEL_BASICTESTS_NEWLIBSUPPORT_NEWCLIENTINTERCEPTOR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
