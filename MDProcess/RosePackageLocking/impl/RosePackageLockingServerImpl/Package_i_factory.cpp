////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/RosePackageLocking/impl/RosePackageLockingServerImpl/Package_i_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::RosePackageLocking::RosePackageLockingServerImpl::Package_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/RosePackageLocking/impl/RosePackageLockingServerImpl/Package_i_factory.h"
#include "MDProcess/RosePackageLocking/impl/RosePackageLockingServerImpl/Package_i.h"
#include "MDProcess/RosePackageLocking/LibHome.h"

namespace RosePackageLocking {
namespace RosePackageLockingServerImpl {

Package_i_factory::Package_i_factory () {
}

void Package_i_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	RosePackageLockingServer::PackageFactoryManager::register_factory (this, priority);
}

const char* Package_i_factory::key () const {
	return "Package_i";
}

RosePackageLockingServer::Package* Package_i_factory::instance (RosePackageLockingServer::PackageGUID_const guid) {
	Package_i_var ret = new Package_i (guid);
	return ret->_this ();
}

} // namespace RosePackageLockingServerImpl
} // namespace RosePackageLocking

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

