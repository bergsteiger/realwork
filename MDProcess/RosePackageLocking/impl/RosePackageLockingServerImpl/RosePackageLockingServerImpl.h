////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/RosePackageLocking/impl/RosePackageLockingServerImpl/RosePackageLockingServerImpl.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Impl::Category>> MDProcess::RosePackageLocking::RosePackageLockingServerImpl
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_ROSEPACKAGELOCKING_ROSEPACKAGELOCKINGSERVERIMPL_H__
#define __MDPROCESS_ROSEPACKAGELOCKING_ROSEPACKAGELOCKINGSERVERIMPL_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include <fstream>
#include "MDProcess/RosePackageLocking/RosePackageLockingServer/RosePackageLockingServer.h"
#include "shared/CoreSrv/SecuritySrvComm/SecuritySrvComm.h"
#include "MDProcess/ServerGate/Users/Users.h"
#include "MDProcess/RosePackageLocking/LockStarageDef/LockStarageDef.h"
#include "MDProcess/RosePackageLocking/RosePackageLockingServer/RosePackageLockingServerS.h"


namespace RosePackageLocking {
namespace RosePackageLockingServerImpl {

// структура содержащия информацию о пакете
struct PackageInfo {
	// время, когда залочили/разлочили пакет
	std::string time;
	// полное имя пакета
	std::string full_name;
	// ID пользователя, залочевшего/разлочевшего пакет
	CoreSrv::UserID owner_user;
};

class PackageManagerEx;
typedef ::Core::Var<PackageManagerEx> PackageManagerEx_var;
typedef ::Core::Var<const PackageManagerEx> PackageManagerEx_cvar;
// расширяет интерфейса PackageManager методами lock/unlock
class PackageManagerEx
	: virtual public POA_RosePackageLocking::RosePackageLockingServer::PackageManager
{
public:
	// лочит пакет
	virtual void lock (const std::string& guid) /*throw (RosePackageLockingServer::LockFailed)*/ = 0;

	// разлачивает пакет и не рассылает все ссобщение если установлен need_roolback
	virtual void unlock (
		const std::string& guid
		, CORBA::Boolean need_roolback
	) /*throw (
		RosePackageLockingServer::LockFailed
	)*/ = 0;
};

/// factory interface for PackageManagerEx
class PackageManagerExFactory {
public:
	// получить кэшированый экземпляр
	static PackageManagerEx& instance ()
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

} //namespace RosePackageLockingServerImpl
} // namespace RosePackageLocking


#endif //__MDPROCESS_ROSEPACKAGELOCKING_ROSEPACKAGELOCKINGSERVERIMPL_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

