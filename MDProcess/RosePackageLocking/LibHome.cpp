////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/RosePackageLocking/LibHome.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<ServerLibrary::Category>> MDProcess::RosePackageLocking
//
// библиотека с основной функциональностью сервера залочек
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "MDProcess/RosePackageLocking/LibHome.h"
#include "MDProcess/RosePackageLocking/RosePackageLockingServer/RosePackageLockingServerFactories.h"

namespace RosePackageLocking {

void LibHomeImpl::publish_all_servers_factories () const {
	RosePackageLockingServer::PackageFactoryManager::publish_self ();
	RosePackageLockingServer::PackageManagerFactoryManager::publish_self ();
}

CoreSrv::Root::CorbaLibHome& LibHomeFactory::get () {
	return LibHomeImpl::Singleton::instance();
}

LibHomeImpl::LibHomeImpl () {
}

void LibHomeImpl::registrate_all_factories () const {
	//#UC START# *45DAFE2D0216_ENVIRONMENTS_CONFIG*
	//#UC END# *45DAFE2D0216_ENVIRONMENTS_CONFIG*

}
	
void LibHomeImpl::finalize () {
}
} // namespace RosePackageLocking

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
