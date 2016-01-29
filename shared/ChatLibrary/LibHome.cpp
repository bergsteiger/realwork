////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/ChatLibrary/LibHome.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<ServerLibrary::Category>> shared::ChatLibrary
//
// библиотека обмена сообщениями
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/ChatLibrary/LibHome.h"
#include "shared/ChatLibrary/ChatService/ChatServiceFactories.h"

namespace ChatLibrary {

void LibHomeImpl::publish_all_servers_factories () const {
	ChatService::UsersListManagerFactoryManager::publish_self ();
	ChatService::MessageListenerFactoryManager::publish_self ();
	ChatService::ChatManagerFactoryManager::publish_self ();
	ChatService::MessageManagerFactoryManager::publish_self ();
}

CoreSrv::Root::CorbaLibHome& LibHomeFactory::get () {
	return LibHomeImpl::Singleton::instance();
}

LibHomeImpl::LibHomeImpl () {
}

void LibHomeImpl::registrate_all_factories () const {
	//#UC START# *4A2E061E0198_ENVIRONMENTS_CONFIG*
	//#UC END# *4A2E061E0198_ENVIRONMENTS_CONFIG*

}
	
void LibHomeImpl::finalize () {
}
} // namespace ChatLibrary

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
