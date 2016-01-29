////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/TestModel/BasicTests/NewClientInterceptor.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<ClientInterceptor::Class>> TestModel::BasicTests::NewLibSupport::NewClientInterceptor
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/Core/sys/std_inc.h"
#include "TestModel/BasicTests/NewClientInterceptor.h"
#include "TestModel/BasicTests/LibHome.h"

namespace BasicTests {

//////////////////////////////////////////////////////////////////////////////////////////
// interceptor methods
const IOP::ServiceId ISID_NEW_CLIENT_INTERCEPTOR = 2160569500;

char* NewClientInterceptor::name() throw (CORBA::SystemException) {
	return CORBA::string_dup("BasicTests::NewClientInterceptor");
}
	
void NewClientInterceptor::destroy() throw (CORBA::SystemException) {
	//#UC START# *49AEE40302B5_DESTROY*
	//#UC END# *49AEE40302B5_DESTROY*
}

void NewClientInterceptor::send_request (PortableInterceptor::ClientRequestInfo_ptr ri) throw (PortableInterceptor::ForwardRequest, CORBA::SystemException) {
	//#UC START# *49AEE40302B5_SEND_R*
	//#UC END# *49AEE40302B5_SEND_R*
}

void NewClientInterceptor::send_poll (PortableInterceptor::ClientRequestInfo_ptr ri) throw (CORBA::SystemException) {
	//#UC START# *49AEE40302B5_SEND_P*
	//#UC END# *49AEE40302B5_SEND_P*
}

void NewClientInterceptor::receive_reply (PortableInterceptor::ClientRequestInfo_ptr ri) throw (CORBA::SystemException) {
	//#UC START# *49AEE40302B5_RECEIVE_R*
	//#UC END# *49AEE40302B5_RECEIVE_R*
}

void NewClientInterceptor::receive_exception (PortableInterceptor::ClientRequestInfo_ptr ri) throw (PortableInterceptor::ForwardRequest, CORBA::SystemException) {
	//#UC START# *49AEE40302B5_RECEIVE_E*
	//#UC END# *49AEE40302B5_RECEIVE_E*
}

void NewClientInterceptor::receive_other (PortableInterceptor::ClientRequestInfo_ptr ri) throw (PortableInterceptor::ForwardRequest, CORBA::SystemException) {
	//#UC START# *49AEE40302B5_RECEIVE_O*
	//#UC END# *49AEE40302B5_RECEIVE_O*
}


} // namespace BasicTests

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
