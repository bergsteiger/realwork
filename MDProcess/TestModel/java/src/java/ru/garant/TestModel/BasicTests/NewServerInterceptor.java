////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/TestModel/java/src/java/ru/garant/TestModel/BasicTests/NewServerInterceptor.java"
// генератор классов, интерфейсов на java (.java)
// Generated from UML model, root element: <<ServerInterceptor::Class>> TestModel::BasicTests::NewLibSupport::NewServerInterceptor
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
package ru.garant.TestModel.BasicTests;

import ru.garant.shared.Core.Logs;

//#UC START# *49AEE41400E3_CUSTOM_INCLUDES*
//#UC END# *49AEE41400E3_CUSTOM_INCLUDES*

public class NewServerInterceptor
	extends org.omg.CORBA.LocalObject
	implements org.omg.PortableInterceptor.ServerRequestInterceptor {

	private final long ISID_NEW_SERVER_INTERCEPTOR = 3937355545L;
	private static final long serialVersionUID = 3937355545L;

	public NewServerInterceptor () {
	}

//////////////////////////////////////////////////////////////////////////////////////////
// interceptor methods

	public String name() throws org.omg.CORBA.SystemException {
		return "BasicTests::NewServerInterceptor";
	}

	public void destroy() throws org.omg.CORBA.SystemException {
		//#UC START# *49AEE41400E3_DESTROY*
		//#UC END# *49AEE41400E3_DESTROY*
	}

	public void receive_request_service_contexts (org.omg.PortableInterceptor.ServerRequestInfo requestInfo)
		throws org.omg.PortableInterceptor.ForwardRequest
		, org.omg.CORBA.SystemException
	{
		//#UC START# *49AEE41400E3_RECEIVE_RSC*
		//#UC END# *49AEE41400E3_RECEIVE_RSC*
	}

	public void receive_request (org.omg.PortableInterceptor.ServerRequestInfo requestInfo)
		throws org.omg.PortableInterceptor.ForwardRequest
		, org.omg.CORBA.SystemException
	{
		//#UC START# *49AEE41400E3_RECEIVE_R*
		//#UC END# *49AEE41400E3_RECEIVE_R*
	}

	public void send_reply (org.omg.PortableInterceptor.ServerRequestInfo requestInfo)
		throws org.omg.CORBA.SystemException
	{
		//#UC START# *49AEE41400E3_SEND_R*
		//#UC END# *49AEE41400E3_SEND_R*
	}

	public void send_exception (org.omg.PortableInterceptor.ServerRequestInfo requestInfo)
		throws org.omg.PortableInterceptor.ForwardRequest
		, org.omg.CORBA.SystemException
	{
		//#UC START# *49AEE41400E3_SEND_E*
		//#UC END# *49AEE41400E3_SEND_E*
	}

	public void send_other (org.omg.PortableInterceptor.ServerRequestInfo requestInfo)
		throws org.omg.PortableInterceptor.ForwardRequest
		, org.omg.CORBA.SystemException
	{
		//#UC START# *49AEE41400E3_SEND_O*
		//#UC END# *49AEE41400E3_SEND_O*
	}

} // class NewServerInterceptor
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
