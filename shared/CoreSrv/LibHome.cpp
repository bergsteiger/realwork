////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/CoreSrv/LibHome.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<ServerLibrary::Category>> shared::CoreSrv
//
// Клиент-серверное ядро, набор базовых вспомогательных функциий и типов для работы с CORBA, а так
// же клиент-сервная часть фреймворка GCM2
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/LibHome.h"
#include "shared/CoreSrv/ClientSecurity.h"
#include "shared/CoreSrv/ServerSecurity.h"
#include "shared/CoreSrv/SecuritySrv/SecuritySrvFactories.h"
#include "shared/CoreSrv/EventComm/EventCommFactories.h"

namespace CoreSrv {

void LibHomeImpl::publish_all_servers_factories () const {
	SecuritySrv::SessionManagerFactoryManager::publish_self ();
	EventComm::EventChannelManagerFactoryManager::publish_self ();
}

void LibHomeImpl::ORBInitializer::pre_init(PortableInterceptor::ORBInitInfo_ptr info) throw (CORBA::SystemException) {
	{
		PortableInterceptor::ServerRequestInterceptor_var si = new ServerSecurity();
		info->add_server_request_interceptor(si.in());
	}
	{
		PortableInterceptor::ClientRequestInterceptor_var ci = new ClientSecurity();
		info->add_client_request_interceptor(ci.in());
	}

	CurrentSlotAccessor::set_current_token_slot_id (info->allocate_slot_id ());

}

void LibHomeImpl::ORBInitializer::post_init(PortableInterceptor::ORBInitInfo_ptr info) throw (CORBA::SystemException) {
}

PortableInterceptor::ORBInitializer* LibHomeImpl::get_orb_initializer () const {
	return new ORBInitializer ();
}

CoreSrv::Root::CorbaLibHome& LibHomeFactory::get () {
	return LibHomeImpl::Singleton::instance();
}

LibHomeImpl::LibHomeImpl () {
}

void LibHomeImpl::registrate_all_factories () const {
	//#UC START# *457FF5F002EE_ENVIRONMENTS_CONFIG*
	//#UC END# *457FF5F002EE_ENVIRONMENTS_CONFIG*

}
	
void LibHomeImpl::finalize () {
}


PortableInterceptor::SlotId CurrentSlotAccessor::s_current_token_slot_id = 0;

PortableInterceptor::SlotId CurrentSlotAccessor::get_current_token_slot_id () {
	return CurrentSlotAccessor::s_current_token_slot_id;
}

void CurrentSlotAccessor::set_current_token_slot_id (PortableInterceptor::SlotId allocated_slot) {
	CurrentSlotAccessor::s_current_token_slot_id = allocated_slot;
}
} // namespace CoreSrv

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
