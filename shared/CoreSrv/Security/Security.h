////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/shared/CoreSrv/Security/Security.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Interfaces::Category>> shared::CoreSrv::Security
//
// ��������� ��������� ���������� ���������� ������������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CORESRV_SECURITY_H__
#define __SHARED_CORESRV_SECURITY_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/CoreSrv/SecurityComm/SecurityComm.h"
#include "shared/CoreSrv/SecuritySrvComm/SecuritySrvComm.h"

namespace CoreSrv {

class Session;
typedef ::Core::Var<Session> Session_var;
typedef ::Core::Var<const Session> Session_cvar;
// ��������� ������� � ������� �������� ��������� � ��������������� � ��������������. ��� ������
// ��������� ��������������� ����� � ������������ �������������� ��������.
class Session
	: virtual public ::Core::IObject
{
public:
	// ������������� ���������� ������ (�� ����� ���� � ������ �������� ����������� �� �������).
	// ������������ � ��������� �������.
	virtual SessionID get_self_sid () const = 0;

	// ������������� ������������ �� ����� �������� ���� ��������� ����������. ������������ �
	// ��������� �������.
	virtual UserID get_self_uid () const = 0;

	// ������������� ������ ����������� ���������. �.�. ������������� ������ ������� ��������� �������
	// �����. ������������ � ��������� �������.
	virtual SessionID get_context_sid () const = 0;

	// ������������� ������������ ����������� ���������. �.�. ������������� ������������ �� ����
	// �������� ��� ������ ������� �����. ������������ � ��������� �������.
	virtual UserID get_context_uid () const = 0;

	// ����������� �� ������� � ��������� �����-������. � ������ �������� ����������� ����������
	// ������ �������� ������������� �������� �� ����. � ������ ������ ����������� �������������
	// ����������
	virtual void login (const std::string& login, const std::string& pswd) /*throw (AccessDenied, AlreadyLogged)*/ = 0;

	// ���������� ������
	virtual void logout () = 0;

	// ���������� �������-��������� ��� �������� �� ��������
	virtual void add_session_interceptor (SessionInterceptor* sint) = 0;

	// ��������� ���������������� ����������� �������� ��������
	virtual void add_request_interceptor (const UserRequestInterceptor* rint) = 0;

	// ���������� �� ���������� ������������ ����� ������� ����������� �������; �������� � ������
	// ������� start �� ���� ������������������ ���������������� ������������� �������� ��������.
	// {warning}����� ������� ���������{warning}
	virtual void start_user_request (UserID uid) const = 0;

	// ���������� �� ���������� ������������ ����� ���������� �������; �������� � ������ �������
	// finish �� ���� ������������������ ���������������� ������������� �������� ��������.
	// {warning}����� ������� ���������{warning}
	virtual void finish_user_request (UserID uid) const = 0;
};

/// factory interface for Session
class SessionFactory {
public:
	// ���������� ������ ������� ������
	static Session& get ()
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

} // namespace CoreSrv

// TypeTraits specializations
namespace Core {	
template <>
struct TypeTraits <CoreSrv::Session> {
	typedef CoreSrv::SessionFactory Factory;
};
} // namespace Core


#endif //__SHARED_CORESRV_SECURITY_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
