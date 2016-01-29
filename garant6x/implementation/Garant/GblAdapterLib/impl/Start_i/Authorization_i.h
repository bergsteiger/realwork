////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Start_i/Authorization_i.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Start_i::Authorization_i
// ��������� ���������� ������ �������� ��� ��������� Authorization
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_START_I_AUTHORIZATION_I_H__
#define __GARANT6X_GBLADAPTERLIB_START_I_AUTHORIZATION_I_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garantServer/src/Global/Core/gcdC.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Start/Start.h"

//#UC START# *46092234033C_CUSTOM_INCLUDES*
//#UC END# *46092234033C_CUSTOM_INCLUDES*

namespace GblAdapterLib {

class Authorization_i; // self forward Var
typedef ::Core::Var<Authorization_i> Authorization_i_var;
typedef ::Core::Var<const Authorization_i> Authorization_i_cvar;

class Authorization_i_factory;

class Authorization_i:
	virtual public Authorization
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (Authorization_i)
	friend class Authorization_i_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	Authorization_i ();

	virtual ~Authorization_i ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
private:
	virtual void guest_login_i () const;

	virtual void login_i (const char* login, const char* password) const;

	virtual GCD::Uid logout_i () const;

	virtual void post_login () const;

	virtual void pre_login () const;

	virtual void xml_backup (GCD::Uid uid) const;

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	mutable bool m_has_session;

	mutable bool m_need_full_backup_after_logout;

	mutable bool m_need_logout;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from Authorization
	// ����� ��������������
	virtual const GCI::IO::String& get_administrator_email () const;
	virtual GCI::IO::String& get_administrator_email ();

	virtual void set_administrator_email (GCI::IO::String* administrator_email);

	// implemented method from Authorization
	// ������� ��������������
	virtual const GCI::IO::String& get_administrator_phone () const;
	virtual GCI::IO::String& get_administrator_phone ();

	virtual void set_administrator_phone (GCI::IO::String* administrator_phone);

	// implemented method from Authorization
	// ���������� login �� � ������������ ������ ������������. email - �����, �� ������� � �����������
	// ����� ���� ������� ���������� � ������������ (�����, ������)
	virtual void autoregistration (
		const char* name
		, const char* login
		, const char* password
		, const char* email
	) const /*throw (
		WrongAuthentication
		, NoMoreProfiles
		, LicenceViolation
		, XMLImportRunning
		, ShutdownInited
		, TrialPeriodExpired
		, NoMoreConnections
		, AutoregistrationDisabled
	)*/;

	// implemented method from Authorization
	// ������ ���������������
	virtual bool get_autoregistration_status () const;

	virtual void set_autoregistration_status (bool autoregistration_status)
		/*throw (AccessDenied)*/;

	// implemented method from Authorization
	// ������ ������ � �������� ������������-�����. ��� �������� ���������� ������������ � ����,
	// ����������� � ����������, ��� ���� �� ��������� � ���������� ��������� ICommon.
	virtual void guest_login () const /*throw (NoMoreProfiles, LicenceViolation, XMLImportRunning, ShutdownInited, TrialPeriodExpired, NoMoreConnections)*/;

	// implemented method from Authorization
	// ���������� true ���� ������ ��������, false �����
	virtual bool is_server_alive () const;

	// implemented method from Authorization
	// ������ ������ � ��������. ��� �������� ���������� ������������ � ����, ����������� �
	// ����������, ��� ���� �� ��������� � ���������� ��������� ICommon.
	virtual void login (
		const char* login
		, const char* password
	) const /*throw (
		WrongAuthentication
		, NoMoreProfiles
		, XMLImportRunning
		, ShutdownInited
		, TrialPeriodExpired
		, AlreadyLogged
		, AccountDisabled
		, NoMoreConnections
	)*/;

	// implemented method from Authorization
	// ��������� ������ � ��������.
	virtual void logout () const;

	// implemented method from Authorization
	// K274827650
	virtual void logout_without_xml_backup () const;

	// implemented method from Authorization
	// ������ ������.
	virtual long get_protection_error () const;

	// implemented method from Authorization
	// ����������� ���������� ��������� ����. ���� `== 0` - ��������� ������ �����; ���� `< 0`
	// ��������� ������ �� ����������.
	virtual long get_rest_trial_days_count () const;

	// implemented method from Authorization
	// ��������� ������� ���������� ������ � ����. ���� ����� ������,  �������� �� ���� ���������� �
	// ������������.
	virtual void send_user_info_by_email (
		const char* email
	) const /*throw (
		SMTPServerAddressNotDefined
		, SMTPServerNotFound
		, UserNotFound
		, BadSMTPReply
		, SMTPAuthorizationFailed
	)*/;

//#UC START# *46092234033C*
private:
	mutable GCI::IO::String_var m_email; // hack for return 'IString' 
	mutable GCI::IO::String_var m_phone; //   to Nemesis Shell
//#UC END# *46092234033C*
}; // class Authorization_i

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_START_I_AUTHORIZATION_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
