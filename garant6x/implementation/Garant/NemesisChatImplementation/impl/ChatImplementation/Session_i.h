////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/garant6x/implementation/Garant/NemesisChatImplementation/impl/ChatImplementation/Session_i.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::NemesisChatImplementation::ChatImplementation::Session_i
// ��������� ���������� ������ �������� ��� ��������� Session
//
// �������� ��� ��������� �������������� ������������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_NEMESISCHATIMPLEMENTATION_CHATIMPLEMENTATION_SESSION_I_H__
#define __GARANT6X_NEMESISCHATIMPLEMENTATION_CHATIMPLEMENTATION_SESSION_I_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/CoreSrv/Security/Security.h"

namespace NemesisChatImplementation {
namespace ChatImplementation {

class Session_i; // self forward Var
typedef ::Core::Var<Session_i> Session_i_var;
typedef ::Core::Var<const Session_i> Session_i_cvar;

class Session_i_factory;

// �������� ��� ��������� �������������� ������������
class Session_i:
	virtual public CoreSrv::Session
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (Session_i)
	friend class Session_i_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	Session_i ();

	virtual ~Session_i ();

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from CoreSrv::Session
	// ��������� ���������������� ����������� �������� ��������
	virtual void add_request_interceptor (const CoreSrv::UserRequestInterceptor* rint);

	// implemented method from CoreSrv::Session
	// ���������� �������-��������� ��� �������� �� ��������
	virtual void add_session_interceptor (CoreSrv::SessionInterceptor* sint);

	// implemented method from CoreSrv::Session
	// ������������� ������ ����������� ���������. �.�. ������������� ������ ������� ��������� �������
	// �����. ������������ � ��������� �������.
	virtual CoreSrv::SessionID get_context_sid () const;

	// implemented method from CoreSrv::Session
	// ������������� ������������ ����������� ���������. �.�. ������������� ������������ �� ����
	// �������� ��� ������ ������� �����. ������������ � ��������� �������.
	virtual CoreSrv::UserID get_context_uid () const;

	// implemented method from CoreSrv::Session
	// ���������� �� ���������� ������������ ����� ���������� �������; �������� � ������ �������
	// finish �� ���� ������������������ ���������������� ������������� �������� ��������.
	// {warning}����� ������� ���������{warning}
	virtual void finish_user_request (CoreSrv::UserID uid) const;

	// implemented method from CoreSrv::Session
	// ����������� �� ������� � ��������� �����-������. � ������ �������� ����������� ����������
	// ������ �������� ������������� �������� �� ����. � ������ ������ ����������� �������������
	// ����������
	virtual void login (
		const std::string& login
		, const std::string& pswd
	) /*throw (
		CoreSrv::AccessDenied
		, CoreSrv::AlreadyLogged
	)*/;

	// implemented method from CoreSrv::Session
	// ���������� ������
	virtual void logout ();

	// implemented method from CoreSrv::Session
	// ������������� ���������� ������ (�� ����� ���� � ������ �������� ����������� �� �������).
	// ������������ � ��������� �������.
	virtual CoreSrv::SessionID get_self_sid () const;

	// implemented method from CoreSrv::Session
	// ������������� ������������ �� ����� �������� ���� ��������� ����������. ������������ �
	// ��������� �������.
	virtual CoreSrv::UserID get_self_uid () const;

	// implemented method from CoreSrv::Session
	// ���������� �� ���������� ������������ ����� ������� ����������� �������; �������� � ������
	// ������� start �� ���� ������������������ ���������������� ������������� �������� ��������.
	// {warning}����� ������� ���������{warning}
	virtual void start_user_request (CoreSrv::UserID uid) const;
}; // class Session_i

} // namespace ChatImplementation
} // namespace NemesisChatImplementation


#endif //__GARANT6X_NEMESISCHATIMPLEMENTATION_CHATIMPLEMENTATION_SESSION_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
