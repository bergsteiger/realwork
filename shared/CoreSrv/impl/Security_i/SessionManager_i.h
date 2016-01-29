////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/shared/CoreSrv/impl/Security_i/SessionManager_i.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> shared::CoreSrv::Security_i::SessionManager_i
// ��������� ���������� ������ �������� ��� ��������� SessionManager
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CORESRV_SECURITY_I_SESSIONMANAGER_I_H__
#define __SHARED_CORESRV_SECURITY_I_SESSIONMANAGER_I_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include <map>
#include "shared/Core/data/unsorted_containers.h"
#include "shared/CoreSrv/SecuritySrv/SecuritySrv.h"
#include "shared/CoreSrv/SecuritySrvComm/SecuritySrvComm.h"
#include "shared/CoreSrv/SecurityComm/SecurityComm.h"
#include "shared/CoreSrv/SecuritySrv/SecuritySrvS.h"

namespace CoreSrv {
namespace Security_i {

class SessionManager_i; // self forward Var
typedef ::Core::Var<SessionManager_i> SessionManager_i_var;
typedef ::Core::Var<const SessionManager_i> SessionManager_i_cvar;

class SessionManager_i_factory;

class SessionManager_i:
	virtual public POA_CoreSrv::SecuritySrv::SessionManager
	, virtual public ::CoreSrv::RefCountServantBase
{
	SET_OBJECT_COUNTER (SessionManager_i)
	friend class SessionManager_i_factory; // self factory

//////////////////////////////////////////////////////////////////////////////////////////
// nested declorations
private:
	// ������ ������
	struct SessionData {
		// ������� ������������ ������
		ProfileData profile;
		// �������� ������� ������� �� ������� ��������� �����
		ACE_Time_Value time_to_kill;
	};

	// ���� ID ������ �� �� ������
	typedef std::map < SessionID, SessionData > SessionMap;

	// ������ �������������� ������
	typedef boost::unordered_set <SessionInterceptor_var
		, Core::hash<SessionInterceptor_var>
		, Core::equal_to<SessionInterceptor_var> > SInts;

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	SessionManager_i ();

	virtual ~SessionManager_i ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
private:
	// ������� ������ �� ������ �������� � �������� ��������� ����������� ��������� � ��� ������. ���
	// �� �������� ������������������ ������-����������.
	virtual void remove_sid (SessionID sid);

	// ������������ (� �����) ����� ����� �������� ������
	/*oneway*/ Core::ThreadHandle session_watcher ();

//////////////////////////////////////////////////////////////////////////////////////////
// oneway methods impl
private:
	static void thr_session_watcher_ (void* arg);

protected:
	virtual void session_watcher_ ();

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	Core::Mutex m_session_mut;

	SessionMap m_sessions;

	// ������������� ID ����� ������
	Core::AtomicOp<unsigned long> m_sid_incrementor;

	SInts m_sints;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from SecuritySrv::SessionManager
	// ���������� �������-��������� ��� �������� �� ��������
	virtual void add_session_interceptor (SessionInterceptor* sint) throw (CORBA::SystemException);

	// implemented method from SecuritySrv::SessionManager
	// �������� ��������� � ��� ��� ������� (�� ������ ������� ������ �����) ������� ����
	virtual void keep_alive () throw (CORBA::SystemException);

	// implemented method from SecuritySrv::SessionManager
	// ����������� � ������ ������. � ������ ������ ����������� ��������������� ������ � �� ������� id
	// ������. ����� ����������.
	virtual SecuritySrv::Token login (
		const char* login
		, const char* pswd
	) throw (
		CORBA::SystemException
		, AccessDenied
		, AlreadyLogged
	);

	// implemented method from SecuritySrv::SessionManager
	// ���������� ������.
	virtual void logout () throw (CORBA::SystemException);
}; // class SessionManager_i

} // namespace Security_i
} // namespace CoreSrv


#endif //__SHARED_CORESRV_SECURITY_I_SESSIONMANAGER_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
