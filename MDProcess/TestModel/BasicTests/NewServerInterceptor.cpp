////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/TestModel/BasicTests/NewServerInterceptor.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<ServerInterceptor::Class>> TestModel::BasicTests::NewLibSupport::NewServerInterceptor
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/Core/sys/std_inc.h"
#include "TestModel/BasicTests/NewServerInterceptor.h"
#include "TestModel/BasicTests/LibHome.h"

namespace BasicTests {

//////////////////////////////////////////////////////////////////////////////////////////
// interceptor methods
const IOP::ServiceId ISID_NEW_SERVER_INTERCEPTOR = 3937355545;

char* NewServerInterceptor::name() throw (CORBA::SystemException) {
	return CORBA::string_dup("BasicTests::NewServerInterceptor");
}
	
void NewServerInterceptor::destroy() throw (CORBA::SystemException) {
	//#UC START# *49AEE41400E3_DESTROY*
	//#UC END# *49AEE41400E3_DESTROY*
}

void NewServerInterceptor::receive_request_service_contexts(PortableInterceptor::ServerRequestInfo_ptr ri) throw (PortableInterceptor::ForwardRequest, CORBA::SystemException) {
	//#UC START# *49AEE41400E3_RECEIVE_RSC*
	//#UC END# *49AEE41400E3_RECEIVE_RSC*
}
	
void NewServerInterceptor::receive_request(PortableInterceptor::ServerRequestInfo_ptr ri) throw (PortableInterceptor::ForwardRequest, CORBA::SystemException) {
	//#UC START# *49AEE41400E3_RECEIVE_R*
	//#UC END# *49AEE41400E3_RECEIVE_R*
}
	
void NewServerInterceptor::send_reply(PortableInterceptor::ServerRequestInfo_ptr ri) throw (CORBA::SystemException) {
	//#UC START# *49AEE41400E3_SEND_R*
	//#UC END# *49AEE41400E3_SEND_R*
}
	
void NewServerInterceptor::send_exception(PortableInterceptor::ServerRequestInfo_ptr ri) throw (PortableInterceptor::ForwardRequest, CORBA::SystemException) {
	//#UC START# *49AEE41400E3_SEND_E*
	//#UC END# *49AEE41400E3_SEND_E*
}
	
void NewServerInterceptor::send_other(PortableInterceptor::ServerRequestInfo_ptr ri) throw (PortableInterceptor::ForwardRequest, CORBA::SystemException) {
	//#UC START# *49AEE41400E3_SEND_O*
	//#UC END# *49AEE41400E3_SEND_O*
}


} // namespace BasicTests

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
