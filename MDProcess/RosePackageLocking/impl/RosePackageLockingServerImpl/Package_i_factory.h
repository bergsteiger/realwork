////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/RosePackageLocking/impl/RosePackageLockingServerImpl/Package_i_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::RosePackageLocking::RosePackageLockingServerImpl::Package_i
// Заголовк реализации фабрик интерфеса Package для серванта Package_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_ROSEPACKAGELOCKING_ROSEPACKAGELOCKINGSERVERIMPL_PACKAGE_I_FCTR_H__
#define __MDPROCESS_ROSEPACKAGELOCKING_ROSEPACKAGELOCKINGSERVERIMPL_PACKAGE_I_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/RosePackageLocking/RosePackageLockingServer/RosePackageLockingServerFactories.h"
#include "MDProcess/RosePackageLocking/impl/RosePackageLockingServerImpl/RosePackageLockingServerImpl.h"

namespace RosePackageLocking {
namespace RosePackageLockingServerImpl {

/// Interface-factory implementation for Package_i
class Package_i_factory:
	virtual public ::Core::RefCountObjectBase
	, virtual public RosePackageLockingServer::PackageAbstractFactory
{
public:
	Package_i_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const char* key () const;

	RosePackageLockingServer::Package* instance (RosePackageLockingServer::PackageGUID_const guid);

};

typedef ::Core::Var<Package_i_factory> Package_i_factory_var;

} // namespace RosePackageLockingServerImpl
} // namespace RosePackageLocking


#endif //__MDPROCESS_ROSEPACKAGELOCKING_ROSEPACKAGELOCKINGSERVERIMPL_PACKAGE_I_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

