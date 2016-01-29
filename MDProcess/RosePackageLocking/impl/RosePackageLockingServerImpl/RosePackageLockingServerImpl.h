////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/RosePackageLocking/impl/RosePackageLockingServerImpl/RosePackageLockingServerImpl.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Impl::Category>> MDProcess::RosePackageLocking::RosePackageLockingServerImpl
//
//
// ��� ����� ����������� ��� ��� "������-������".
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

// ��������� ���������� ���������� � ������
struct PackageInfo {
	// �����, ����� ��������/��������� �����
	std::string time;
	// ������ ��� ������
	std::string full_name;
	// ID ������������, �����������/������������ �����
	CoreSrv::UserID owner_user;
};

class PackageManagerEx;
typedef ::Core::Var<PackageManagerEx> PackageManagerEx_var;
typedef ::Core::Var<const PackageManagerEx> PackageManagerEx_cvar;
// ��������� ���������� PackageManager �������� lock/unlock
class PackageManagerEx
	: virtual public POA_RosePackageLocking::RosePackageLockingServer::PackageManager
{
public:
	// ����� �����
	virtual void lock (const std::string& guid) /*throw (RosePackageLockingServer::LockFailed)*/ = 0;

	// ����������� ����� � �� ��������� ��� ��������� ���� ���������� need_roolback
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
	// �������� ����������� ���������
	static PackageManagerEx& instance ()
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

} //namespace RosePackageLockingServerImpl
} // namespace RosePackageLocking


#endif //__MDPROCESS_ROSEPACKAGELOCKING_ROSEPACKAGELOCKINGSERVERIMPL_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

