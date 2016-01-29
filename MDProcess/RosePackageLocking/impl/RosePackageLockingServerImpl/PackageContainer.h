////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/RosePackageLocking/impl/RosePackageLockingServerImpl/PackageContainer.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::RosePackageLocking::RosePackageLockingServerImpl::PackageContainer
// ��������� ���������� ������ �������� ��� ��������� PackageManagerEx
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_ROSEPACKAGELOCKING_ROSEPACKAGELOCKINGSERVERIMPL_PACKAGECONTAINER_H__
#define __MDPROCESS_ROSEPACKAGELOCKING_ROSEPACKAGELOCKINGSERVERIMPL_PACKAGECONTAINER_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include <map>
#include <list>
#include "MDProcess/RosePackageLocking/RosePackageLockingServer/RosePackageLockingServer.h"
#include "MDProcess/RosePackageLocking/impl/RosePackageLockingServerImpl/RosePackageLockingServerImpl.h"
#include "shared/CoreSrv/SecuritySrvComm/SecuritySrvComm.h"
#include "shared/Core/sys/RefCountObjectBase.h"
#include "ace/Event_Handler.h"

namespace RosePackageLocking {
namespace RosePackageLockingServerImpl {

class PackageContainer; // self forward Var
typedef ::Core::Var<PackageContainer> PackageContainer_var;
typedef ::Core::Var<const PackageContainer> PackageContainer_cvar;

class PackageContainer_factory;

class PackageContainer:
	virtual public PackageManagerEx
	, virtual public ::CoreSrv::RefCountServantBase
	, virtual public ACE_Event_Handler
{
	SET_OBJECT_COUNTER (PackageContainer)
	friend class PackageContainer_factory; // self factory

//////////////////////////////////////////////////////////////////////////////////////////
// nested declorations
private:
	// ���� ���������� ����� �� ���������� � ��
	typedef std::map < std::string, PackageInfo > GUID2PackageInfo;

	// �������� ���������
	class ListenerInfo: virtual public ::Core::RefCountObjectBase {
	public:
		// ID ����� �������� ���������� ��� ��������� ���������
		CoreSrv::UserID owner_user;
		// ���������, ������� ����� �������� �����������
		RosePackageLockingServer::LocksListener_var listener;
	};

	typedef ::Core::Var<ListenerInfo> ListenerInfo_var;

	// ������ ���������� ������� � ��������� �������
	typedef std::list < ListenerInfo_var > LocksListeners;

//////////////////////////////////////////////////////////////////////////////////////////
// static member methods and data
private:
	// ���������� ������ ������� ��� ������������� �����
	static RosePackageLockingServer::LockStatus get_status (CoreSrv::UserID user_id, CoreSrv::UserID owner_id);

	// ���������� ������� ���� � ����� � ���� ������
	static const std::string get_time ();

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	PackageContainer ();

	virtual ~PackageContainer ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
public:
	// ��������� ���� ��������� � ��������� ���������  �������
	/*oneway*/ Core::ThreadHandle send_lock_changed (
		CoreSrv::UserID user_id
		, RosePackageLockingServer::LockChange lc
		, RosePackageLockingServer::PackageGUID_const guid
		, const char* time
	);

private:
	// �����, � ������� ����� ����������� ���������� ������� ���������� � �������� ����������� �
	// ���������
	/*oneway*/ Core::ThreadHandle flush_thread () const;

	// ��������������� ���������� � �������� �� ���������
	virtual void load_infos ();

	// ��������� ���������� � �������� � ���������
	virtual void store_infos () const;

//////////////////////////////////////////////////////////////////////////////////////////
// oneway methods impl
private:
	static void thr_flush_thread_ (void* arg);

	static void thr_send_lock_changed_ (void* arg);

protected:
	virtual void flush_thread_ () const;

	virtual void send_lock_changed_ (
		CoreSrv::UserID user_id
		, RosePackageLockingServer::LockChange lc
		, RosePackageLockingServer::PackageGUID_const guid
		, const char* time
	);

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	mutable Core::Mutex m_access_guard;

	GUID2PackageInfo m_guid2info;

	mutable Core::Mutex m_listeners_guard;

	// ����� ����������� �� ����� ��������� � ��������� ������� ������������ ������
	LocksListeners m_locks_listeners;

	// ������� ��� ������������� �������� ���������� ���������� � ����������� ������� � ����.
	mutable Core::Mutex m_store_guard;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from RosePackageLockingServer::PackageManager
	// ��������� ���������, ������� ����� �������� ��������� � �������� �������
	virtual void add_locks_listener (RosePackageLockingServer::LocksListener* ll) throw (CORBA::SystemException);

	// implemented method from RosePackageLockingServer::PackageManager
	// ���������� ������ �������, ����������� �������������
	virtual RosePackageLockingServer::PackageInfoSeq* get_self_locked () throw (CORBA::SystemException);

	// implemented method from RosePackageLockingServer::PackageManager
	// sync - ����������� ������� ������� ��� ������� � ������, ������� ������� ���������� � piseq.
	virtual void sync (RosePackageLockingServer::PackageInfoSeq& piseq) throw (CORBA::SystemException);

	// implemented method from PackageManagerEx
	// ����� �����
	virtual void lock (const std::string& guid) /*throw (RosePackageLockingServer::LockFailed)*/;

	// implemented method from PackageManagerEx
	// ����������� ����� � �� ��������� ��� ��������� ���� ���������� need_roolback
	virtual void unlock (
		const std::string& guid
		, CORBA::Boolean need_roolback
	) /*throw (
		RosePackageLockingServer::LockFailed
	)*/;
//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods
public:

	// overloaded method from ACE_Event_Handler
	virtual int handle_timeout (const ACE_Time_Value& current_time, const void* act);

}; // class PackageContainer

} // namespace RosePackageLockingServerImpl
} // namespace RosePackageLocking


#endif //__MDPROCESS_ROSEPACKAGELOCKING_ROSEPACKAGELOCKINGSERVERIMPL_PACKAGECONTAINER_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
