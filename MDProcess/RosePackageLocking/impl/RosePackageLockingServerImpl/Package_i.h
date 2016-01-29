////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/RosePackageLocking/impl/RosePackageLockingServerImpl/Package_i.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::RosePackageLocking::RosePackageLockingServerImpl::Package_i
// ��������� ���������� ������ �������� ��� ��������� Package
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_ROSEPACKAGELOCKING_ROSEPACKAGELOCKINGSERVERIMPL_PACKAGE_I_H__
#define __MDPROCESS_ROSEPACKAGELOCKING_ROSEPACKAGELOCKINGSERVERIMPL_PACKAGE_I_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/RosePackageLocking/RosePackageLockingServer/RosePackageLockingServer.h"
#include "MDProcess/RosePackageLocking/RosePackageLockingServer/RosePackageLockingServerS.h"

namespace RosePackageLocking {
namespace RosePackageLockingServerImpl {

class Package_i; // self forward Var
typedef ::Core::Var<Package_i> Package_i_var;
typedef ::Core::Var<const Package_i> Package_i_cvar;

class Package_i_factory;

class Package_i:
	virtual public POA_RosePackageLocking::RosePackageLockingServer::Package
	, virtual public ::CoreSrv::RefCountServantBase
{
	SET_OBJECT_COUNTER (Package_i)
	friend class Package_i_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	Package_i (RosePackageLockingServer::PackageGUID_const guid);

	virtual ~Package_i ();
//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	std::string m_guid;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from RosePackageLockingServer::Package
	// ������������ ���������
	virtual void commit () throw (CORBA::SystemException, RosePackageLockingServer::LockFailed);

	// implemented method from RosePackageLockingServer::Package
	// ���������� � ������
	virtual RosePackageLockingServer::PackageInfo* get_info ()
		throw (CORBA::SystemException);

	// implemented method from RosePackageLockingServer::Package
	// ������ ����������� ������
	virtual void modify () throw (CORBA::SystemException, RosePackageLockingServer::LockFailed);

	// implemented method from RosePackageLockingServer::Package
	// �������� ��������� � ������
	virtual void rollback () throw (CORBA::SystemException);
}; // class Package_i

} // namespace RosePackageLockingServerImpl
} // namespace RosePackageLocking


#endif //__MDPROCESS_ROSEPACKAGELOCKING_ROSEPACKAGELOCKINGSERVERIMPL_PACKAGE_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
