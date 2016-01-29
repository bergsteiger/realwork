////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/shared/CoreSrv/SecurityComm/SecurityComm.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Interfaces::Category>> shared::CoreSrv::SecurityComm
//
// ���������������� ��������� ���������� � ���� ���� ���������� ������������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CORESRV_SECURITYCOMM_H__
#define __SHARED_CORESRV_SECURITYCOMM_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/CoreSrv/SecuritySrvComm/SecuritySrvComm.h"

namespace CoreSrv {

// ��� ������� ������������
enum ProfileType {
	PT_REGULAR // ������� ������������, ������������ � ����� ��������� � ���������� ��������������� ����� ���� ������ ������ � ����� �������� �������
	, PT_MULTIPLE // ������������� ������������. ������������ � ����� ��������� � ���������� ��������������� ����� ���� ������ � ����������� ��������� ��������. �������� guest.
};

#pragma pack (push, 1)

// ������������������ ������
struct ProfileData {
	// ������������� ������������
	UserID uid;
	// ��� �������
	ProfileType type;
};

#pragma pack (pop)

class Authenticator;
typedef ::Core::Var<Authenticator> Authenticator_var;
typedef ::Core::Var<const Authenticator> Authenticator_cvar;
// Comm ���������, ��� ����������������� ���������� ��������������
class Authenticator
	: virtual public ::Core::IObject
{
public:
	// ����������, � ������ ������ ������� ������� ������ �������� � ��������������� ���������������
	// ������������ � �����. ����� ����������
	virtual ProfileData* authentication (const char* login, const char* pswd) const /*throw (AccessDenied)*/ = 0;
};

/// factory interface for Authenticator
class AuthenticatorFactory {
public:
	// ���������� ������������������ ������ ��������������.
	static Authenticator& get ()
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

class UserRequestInterceptor;
typedef ::Core::Var<UserRequestInterceptor> UserRequestInterceptor_var;
typedef ::Core::Var<const UserRequestInterceptor> UserRequestInterceptor_cvar;
// ������ ��������� ������������������ ����������� ��������. ������������ ����� ���������� �����
// ������ ����� ����� �������������, ��� ��������� ������ � ����� ���� �������� ����������������
// �������, � �������������� �� ����� ����� ��� ��������
class UserRequestInterceptor
	: virtual public ::Core::IObject
{
public:
	// ������ �����, ���������� ����� ���������� ��������� ��������� ������
	virtual void finish (UserID uid) const = 0;

	// ������ �����, ���������� ����� ������� ��������� ��������� ������
	virtual void start (UserID uid) const = 0;
};

} // namespace CoreSrv

// TypeTraits specializations
namespace Core {	
template <>
struct TypeTraits <CoreSrv::Authenticator> {
	typedef CoreSrv::AuthenticatorFactory Factory;
};
} // namespace Core


#endif //__SHARED_CORESRV_SECURITYCOMM_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
