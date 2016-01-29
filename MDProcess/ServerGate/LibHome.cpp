////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/ServerGate/LibHome.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<ServerLibrary::Category>> MDProcess::ServerGate
//
// серверная библиотека для поддержки генерации в К
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "MDProcess/ServerGate/LibHome.h"
#include "MDProcess/ServerGate/Users/UsersFactories.h"
#include "MDProcess/ServerGate/Contents/ContentsFactories.h"
#include "MDProcess/ServerGate/GenerationContents/GenerationContentsFactories.h"
#include "MDProcess/ServerGate/Comm/CommFactories.h"
#include "MDProcess/ServerGate/BuildSupport/BuildSupportFactories.h"

namespace ServerGate {

void LibHomeImpl::publish_all_servers_factories () const {
	Users::AccessorFactoryManager::publish_self ();
	Users::UserFactoryManager::publish_self ();
	Contents::KPageFactoryManager::publish_self ();
	Contents::RequestFactoryManager::publish_self ();
	GenerationContents::PageFactoryManager::publish_self ();
	GenerationContents::GenerationManagerFactoryManager::publish_self ();
	Comm::BuildListnerFactoryManager::publish_self ();
	BuildSupport::BuildManagerFactoryManager::publish_self ();
}

CoreSrv::Root::CorbaLibHome& LibHomeFactory::get () {
	return LibHomeImpl::Singleton::instance();
}

LibHomeImpl::LibHomeImpl () {
}

void LibHomeImpl::registrate_all_factories () const {
	//#UC START# *4614D4F6009C_ENVIRONMENTS_CONFIG*
	//#UC END# *4614D4F6009C_ENVIRONMENTS_CONFIG*

}
	
void LibHomeImpl::finalize () {
}
} // namespace ServerGate

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
