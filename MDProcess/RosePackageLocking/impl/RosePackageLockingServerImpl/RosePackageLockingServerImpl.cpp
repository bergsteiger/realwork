////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/RosePackageLocking/impl/RosePackageLockingServerImpl/RosePackageLockingServerImpl.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Impl::Category>> MDProcess::RosePackageLocking::RosePackageLockingServerImpl
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include <typeinfo>
#include "MDProcess/RosePackageLocking/impl/RosePackageLockingServerImpl/RosePackageLockingServerImpl.h"
#include "MDProcess/RosePackageLocking/impl/RosePackageLockingServerImpl/RosePackageLockingServerImplFactories.h"
#include "MDProcess/RosePackageLocking/LibHome.h"


namespace RosePackageLocking {
namespace RosePackageLockingServerImpl {

// factory interface wrapper for PackageManagerEx
PackageManagerEx& PackageManagerExFactory::instance () /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	try {
		PortableServer::ServantBase_var serv = LibHomeFactory::get().get_orb_facet().get_root_poa().reference_to_servant (
			&RosePackageLockingServer::PackageManagerFactory::instance ()
		);
		return dynamic_cast<PackageManagerEx&> (*serv.in ());
	} catch (std::bad_cast&) {
		throw Core::Root::NoActiveFactory ("RosePackageLocking::RosePackageLockingServerImpl::PackageManagerExFactory");
	}
}



} //namespace RosePackageLockingServerImpl
} // namespace RosePackageLocking

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

