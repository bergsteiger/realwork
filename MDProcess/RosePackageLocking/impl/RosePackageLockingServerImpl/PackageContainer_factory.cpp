////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/RosePackageLocking/impl/RosePackageLockingServerImpl/PackageContainer_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::RosePackageLocking::RosePackageLockingServerImpl::PackageContainer
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/RosePackageLocking/impl/RosePackageLockingServerImpl/PackageContainer_factory.h"
#include "MDProcess/RosePackageLocking/impl/RosePackageLockingServerImpl/PackageContainer.h"
#include "MDProcess/RosePackageLocking/LibHome.h"

namespace RosePackageLocking {
namespace RosePackageLockingServerImpl {

PackageContainer_factory::PackageContainer_factory () {
}

void PackageContainer_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	PackageManagerExFactoryManager::register_factory (this, priority);
}

const char* PackageContainer_factory::key () const {
	return "PackageContainer";
}

RosePackageLockingServer::PackageManager* PackageContainer_factory::instance () {
	PackageContainer_var ret = new PackageContainer ();
	return ret->_this ();
}

} // namespace RosePackageLockingServerImpl
} // namespace RosePackageLocking

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

