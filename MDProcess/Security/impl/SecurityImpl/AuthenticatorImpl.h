////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/Security/impl/SecurityImpl/AuthenticatorImpl.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::Security::SecurityImpl::AuthenticatorImpl
// ��������� ���������� ������ �������� ��� ��������� Authenticator
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_SECURITY_SECURITYIMPL_AUTHENTICATORIMPL_H__
#define __MDPROCESS_SECURITY_SECURITYIMPL_AUTHENTICATORIMPL_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/CoreSrv/SecurityComm/SecurityComm.h"

namespace Security {
namespace SecurityImpl {

class AuthenticatorImpl; // self forward Var
typedef ::Core::Var<AuthenticatorImpl> AuthenticatorImpl_var;
typedef ::Core::Var<const AuthenticatorImpl> AuthenticatorImpl_cvar;

class AuthenticatorImpl_factory;

class AuthenticatorImpl:
	virtual public CoreSrv::Authenticator
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (AuthenticatorImpl)
	friend class AuthenticatorImpl_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	AuthenticatorImpl ();

	virtual ~AuthenticatorImpl ();

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from CoreSrv::Authenticator
	// ����������, � ������ ������ ������� ������� ������ �������� � ��������������� ���������������
	// ������������ � �����. ����� ����������
	virtual CoreSrv::ProfileData* authentication (
		const char* login
		, const char* pswd
	) const /*throw (
		CoreSrv::AccessDenied
	)*/;
}; // class AuthenticatorImpl

} // namespace SecurityImpl
} // namespace Security


#endif //__MDPROCESS_SECURITY_SECURITYIMPL_AUTHENTICATORIMPL_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
