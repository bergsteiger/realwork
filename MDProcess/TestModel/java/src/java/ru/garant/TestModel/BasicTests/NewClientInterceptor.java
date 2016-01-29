////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/TestModel/java/src/java/ru/garant/TestModel/BasicTests/NewClientInterceptor.java"
// генератор классов, интерфейсов на java (.java)
// Generated from UML model, root element: <<ClientInterceptor::Class>> TestModel::BasicTests::NewLibSupport::NewClientInterceptor
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
package ru.garant.TestModel.BasicTests;

import ru.garant.shared.Core.Logs;

//#UC START# *49AEE40302B5_CUSTOM_INCLUDES*
//#UC END# *49AEE40302B5_CUSTOM_INCLUDES*

public class NewClientInterceptor
	extends org.omg.CORBA.LocalObject
	implements org.omg.PortableInterceptor.ClientRequestInterceptor {

	private final long ISID_NEW_CLIENT_INTERCEPTOR = 2160569500L;
	private static final long serialVersionUID = 2160569500L;

	public NewClientInterceptor () {
	}

//////////////////////////////////////////////////////////////////////////////////////////
// interceptor methods

	public String name() throws org.omg.CORBA.SystemException {
		return "BasicTests::NewClientInterceptor";
	}

	public void destroy() throws org.omg.CORBA.SystemException {
		//#UC START# *49AEE40302B5_DESTROY*
		//#UC END# *49AEE40302B5_DESTROY*
	}

	public void send_request (org.omg.PortableInterceptor.ClientRequestInfo requestInfo)
		 throws org.omg.PortableInterceptor.ForwardRequest
		 , org.omg.CORBA.SystemException
	{
		//#UC START# *49AEE40302B5_SEND_R*
		//#UC END# *49AEE40302B5_SEND_R*
	}

	public void send_poll (org.omg.PortableInterceptor.ClientRequestInfo requestInfo)
		throws org.omg.CORBA.SystemException
	{
		//#UC START# *49AEE40302B5_SEND_P*
		//#UC END# *49AEE40302B5_SEND_P*
	}

	public void receive_reply (org.omg.PortableInterceptor.ClientRequestInfo requestInfo)
		throws org.omg.CORBA.SystemException
	{
		//#UC START# *49AEE40302B5_RECEIVE_R*
		//#UC END# *49AEE40302B5_RECEIVE_R*
	}

	public void receive_exception (org.omg.PortableInterceptor.ClientRequestInfo requestInfo)
		throws org.omg.PortableInterceptor.ForwardRequest
		, org.omg.CORBA.SystemException
	{
		//#UC START# *49AEE40302B5_RECEIVE_E*
		//#UC END# *49AEE40302B5_RECEIVE_E*
	}

	public void receive_other (org.omg.PortableInterceptor.ClientRequestInfo requestInfo)
		throws org.omg.PortableInterceptor.ForwardRequest
		, org.omg.CORBA.SystemException
	{
		//#UC START# *49AEE40302B5_RECEIVE_O*
		//#UC END# *49AEE40302B5_RECEIVE_O*
	}

} // class NewClientInterceptor
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
