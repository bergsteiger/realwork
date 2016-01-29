////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/RosePackageLocking/impl/RosePackageLockingServerImpl/PackageContainer_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::RosePackageLocking::RosePackageLockingServerImpl::PackageContainer
// Заголовк реализации фабрик интерфеса PackageManagerEx для серванта PackageContainer
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_ROSEPACKAGELOCKING_ROSEPACKAGELOCKINGSERVERIMPL_PACKAGECONTAINER_FCTR_H__
#define __MDPROCESS_ROSEPACKAGELOCKING_ROSEPACKAGELOCKINGSERVERIMPL_PACKAGECONTAINER_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/RosePackageLocking/impl/RosePackageLockingServerImpl/RosePackageLockingServerImplFactories.h"
#include "MDProcess/RosePackageLocking/impl/RosePackageLockingServerImpl/RosePackageLockingServerImpl.h"

namespace RosePackageLocking {
namespace RosePackageLockingServerImpl {

/// Interface-factory implementation for PackageContainer
class PackageContainer_factory:
	virtual public ::Core::RefCountObjectBase
	, virtual public PackageManagerExAbstractFactory
{
public:
	PackageContainer_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const char* key () const;

	RosePackageLockingServer::PackageManager* instance ();

};

typedef ::Core::Var<PackageContainer_factory> PackageContainer_factory_var;

} // namespace RosePackageLockingServerImpl
} // namespace RosePackageLocking


#endif //__MDPROCESS_ROSEPACKAGELOCKING_ROSEPACKAGELOCKINGSERVERIMPL_PACKAGECONTAINER_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

