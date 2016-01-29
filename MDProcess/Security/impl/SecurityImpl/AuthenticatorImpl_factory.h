////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/Security/impl/SecurityImpl/AuthenticatorImpl_factory.h"
// ��������� ������������ ������ ��� ������ ����������� (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::Security::SecurityImpl::AuthenticatorImpl
// �������� ���������� ������ ��������� Authenticator ��� �������� AuthenticatorImpl
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_SECURITY_SECURITYIMPL_AUTHENTICATORIMPL_FCTR_H__
#define __MDPROCESS_SECURITY_SECURITYIMPL_AUTHENTICATORIMPL_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/CoreSrv/SecurityComm/SecurityCommFactories.h"

namespace Security {
namespace SecurityImpl {

/// Interface-factory implementation for AuthenticatorImpl
class AuthenticatorImpl_factory:
	virtual public ::Core::RefCountObjectBase
	, virtual public CoreSrv::AuthenticatorAbstractFactory
{
public:
	AuthenticatorImpl_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const char* key () const;

	CoreSrv::Authenticator* get ();

};

typedef ::Core::Var<AuthenticatorImpl_factory> AuthenticatorImpl_factory_var;

} // namespace SecurityImpl
} // namespace Security


#endif //__MDPROCESS_SECURITY_SECURITYIMPL_AUTHENTICATORIMPL_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

