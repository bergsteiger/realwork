////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/garant6x/implementation/Garant/GblAdapterLib/Start/Start.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::Start
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_START_H__
#define __GARANT6X_GBLADAPTERLIB_START_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Banner/Banner.h"
#include "garant6x/implementation/Garant/GblAdapterLib/BaseTypes/BaseTypes.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Document/Document.h"
#include "garant6x/implementation/Garant/GblAdapterLib/ExternalObject/ExternalObject.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Folders/Folders.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Search/Search.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Security/Security.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Settings/Settings.h"
#include "shared/GCI/IO/IO.h"

namespace GblAdapterLib {

// ������������, ����� �� ������ �� ������ IP ������ ��� ������ ������� (��������� �������: ���
// �������� ������� ����������).
class IPAddressNotFound : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

// ����������� ��� �������� ����.
class InvalidBase : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

// ������������ � ������, ����� �� �����-�� �������� ������ �������� �����������.
class NoServer : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

// ������������, ���� � ������� 10 ������ �� ������ ����� �� ������� �� �� ���� �� IP �������� ��
// ������-������� (��������� �������: firewall ��������� `incoming connection` �� �����, �������
// ���������� ACE/TAO ��� �������� ������).
class BadNetworkConfig : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

// �� ����� ����� SMTP �������
class SMTPServerAddressNotDefined : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

// ���������� �� ����� ����������� c SMTP ��������. �������� ���� �������� ������ � ��� �����
// ������ �������.
class SMTPServerNotFound : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

// ������������ �� ������
class UserNotFound : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

class ServerVersionNotValid : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

// ���������� ������ �������
class InternalServerError : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

// �� ������� ���������, ����������� ��� ������ ����������.
class WorkingParamsNotFound : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

class BadSMTPReply : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

class SettingsRestoreFails : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

// ������ ��� ������ �������� ����������
class ExternalApplicationError : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

class AlreadyLogged : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

// ��������� �������� ��� ����������� �������� �� ������� ����������
static const char* PATH_TO_PICTURES = "-PathToPictures";
static const char* PATH_TO_EXECUTABLE = "-PathToPicturesExecutable";

// �����������
enum Capacity {
	C_32
	, C_64
};

// ��� ��������
enum ProductType {
	PT_UNKNOWN
	, PT_DVD
	, PT_MOBILE
	, PT_FILESERVER
	, PT_DESKTOP
	, PT_CLIENTSERVER
	, PT_SUPERMOBILE
};

class AccountDisabled : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

class NoMoreConnections : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

// ��������� ����������� �� �������� �������
class SMTPAuthorizationFailed : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

// ����������� �����������.
class MorphoNotExists : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

// ��� ��������
enum BaseType {
	BT_UNKNOWN // ����������� ��� (����������� data.org)
	, BT_TRIAL // ��������������� ������
	, BT_COMMERCIAL // ������������ ����
	, BT_NON_COMMERCIAL // �� ������������ ����
	, BT_DEMO // ����������
};

// ������ � ��������� gcm
class InternalApplicationError : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

// ����� ���� ������� ������ �� desktop ������ - ������������� � ����� ���� ������������ (���-�� ��
// ����������� �������� settings)
class InvalidUserDatastore : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

class Authorization;
typedef ::Core::Var<Authorization> Authorization_var;
typedef ::Core::Var<const Authorization> Authorization_cvar;
// ��������� ������������ ��������� ����������� � �������, �������� ���������� ��������� ������,
// ��������� ���������� � ���������.
class Authorization
	: virtual public ::Core::IObject
{
public:
	// ������ ������.
	virtual long get_protection_error () const = 0;

	// ����������� ���������� ��������� ����. ���� `== 0` - ��������� ������ �����; ���� `< 0`
	// ��������� ������ �� ����������.
	virtual long get_rest_trial_days_count () const = 0;

	// ������ ���������������
	virtual bool get_autoregistration_status () const = 0;

	virtual void set_autoregistration_status (bool autoregistration_status)
		/*throw (AccessDenied)*/ = 0;

	// ����� ��������������
	virtual const GCI::IO::String& get_administrator_email () const = 0;
	virtual GCI::IO::String& get_administrator_email () = 0;

	virtual void set_administrator_email (GCI::IO::String* administrator_email) = 0;

	// ������� ��������������
	virtual const GCI::IO::String& get_administrator_phone () const = 0;
	virtual GCI::IO::String& get_administrator_phone () = 0;

	virtual void set_administrator_phone (GCI::IO::String* administrator_phone) = 0;

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
	)*/ = 0;

	// ������ ������ � �������� ������������-�����. ��� �������� ���������� ������������ � ����,
	// ����������� � ����������, ��� ���� �� ��������� � ���������� ��������� ICommon.
	virtual void guest_login () const /*throw (NoMoreProfiles, LicenceViolation, XMLImportRunning, ShutdownInited, TrialPeriodExpired, NoMoreConnections)*/ = 0;

	// ��������� ������ � ��������.
	virtual void logout () const = 0;

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
	)*/ = 0;

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
	)*/ = 0;

	// ���������� true ���� ������ ��������, false �����
	virtual bool is_server_alive () const = 0;

	// K274827650
	virtual void logout_without_xml_backup () const = 0;
};

/// factory interface for Authorization
class AuthorizationFactory {
public:
	static Authorization* make ()
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed, XMLImportRunning)*/;
};

// ������ �������, ��������� � �������� �������������
class ServerIsStarting : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

// ��������� ��� ����������� ����������
static const char* EO_ENABLED = "-EOEnable"; // ��������� �� ������ ��. ��-��������� �������, ��� ���������.

#pragma pack (push, 1)

// ��������� ������������ ��������
struct LicenseRestrictions {
	// ����������� ���������� ������� �������������
	unsigned long users;
	// ����������� ���������� ������������� � ���������� ��������
	unsigned long permanent_users;
};

#pragma pack (pop)

class Common;
typedef ::Core::Var<Common> Common_var;
typedef ::Core::Var<const Common> Common_cvar;
// ��������� ������������ ������ � �������� ���������������� �������, ��������� �� "��������� ����"
// ��� ����������.
class Common
	: virtual public ::Core::IObject
{
public:
	virtual const Date& get_base_date () const = 0;

	// ������������ ����������� �� ���������� �������������
	virtual const LicenseRestrictions get_license_restrictions () const = 0;

	// ���������� �������� (Document) �� ��������� ����������� ("�������������") ������.
	virtual bool get_document_on_number (long number, Document*& document, MissingInfo*& missing_info) const = 0;

	// ���������� ����������� ��������� �����.
	virtual void start_processing_folder_notification (ExternalFoldersChangeNotifier* notifier) = 0;

	// ��������� ���������� (��������) �� � ������� �������� �������.
	// ���������� true � ������, ���� �������� ������� ����������.
	virtual bool is_explanatory_dictionary_exist () const = 0;

	virtual bool is_pharm_exist () const = 0;

	// �������� �������� �� ���� � ������������� ����������� - "��� ����������� �������������"
	virtual bool check_internal () const = 0;

	// ���������� ������� ��� ��������� ������ (���������������� ���������� ������)
	virtual void show_pictures_on_number (
		long number
	) const /*throw (
		WorkingParamsNotFound
		, ExternalApplicationError
	)*/ = 0;

	virtual GCI::IO::String* get_complect_name () const = 0;

	// ���������� �� ������ ��� ������ ������� ����� ����������.
	virtual bool auto_show_help () const = 0;

	// �������� ��� �������������� ��������
	virtual ProductType get_product_type () const = 0;

	// �������� �����
	virtual SplashScreen* get_splash_screen (bool is_start, short x, short y, bool flash_available) const = 0;

	// �������� �������� ��������
	virtual SettingsManager* get_settings_manager () const = 0;

	// �������� �� ������ ��.
	virtual bool is_eo_enabled () const = 0;

	// ��� ����
	virtual BaseType get_base_type () const = 0;

	// ������� ������� ��������� �������� �����������
	virtual void create_folder_notification_queue () = 0;

	// �������� ������
	virtual Banner* get_banner () const /*throw (CanNotFindData)*/ = 0;

	// ���� �� ��������� ������ �������� �������������
	virtual bool is_trimmed_publish_source_exists () const = 0;

	// ������� ��� �������� (�271754146)
	virtual GCI::IO::Stream* get_scripts_system_dictionary () const = 0;

	virtual ExternalObject* get_picture (long id) const /*throw (CanNotFindData)*/ = 0;

	// �������� �� ��������� �������� �������������, ������� ����� �� ������������ ��������
	virtual bool is_erase_of_inactive_users_enabled () const = 0;

	// �������� ������������� ������������� ���������
	virtual GCI::IO::String* get_encrypted_complect_id () const = 0;
};

/// factory interface for Common
class CommonFactory {
public:
	static Common* make ()
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

class ComponentManager;
typedef ::Core::Var<ComponentManager> ComponentManager_var;
typedef ::Core::Var<const ComponentManager> ComponentManager_cvar;
class ComponentManager
	: virtual public ::Core::IObject
{
public:
	virtual void start () /*throw (StorageLocked, LicenceViolation, ConfigurationsNotDefined, IPAddressNotFound, InvalidBase, NoServer, BadNetworkConfig, ServerVersionNotValid, WorkingParamsNotFound, NoMoreConnections, MorphoNotExists, InternalApplicationError, InvalidUserDatastore, ServerIsStarting)*/ = 0;

	virtual void stop () = 0;
};

/// factory interface for ComponentManager
class ComponentManagerFactory {
public:
	static ComponentManager& make ()
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

class AssemblyInfo;
typedef ::Core::Var<AssemblyInfo> AssemblyInfo_var;
typedef ::Core::Var<const AssemblyInfo> AssemblyInfo_cvar;
class AssemblyInfo
	: virtual public ::Core::IObject
{
public:
	virtual bool get_is_debug () const = 0;

	virtual bool get_is_desktop () const = 0;

	virtual bool get_is_commerce () const = 0;

	virtual bool get_first_start () const = 0;

	virtual void set_first_start (bool first_start) = 0;

	// ����������� �������
	virtual const Capacity get_server_capacity () const = 0;
};

/// factory interface for AssemblyInfo
class AssemblyInfoFactory {
public:
	static AssemblyInfo* make ()
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

} // namespace GblAdapterLib

// TypeTraits specializations
namespace Core {	
template <>
struct TypeTraits <GblAdapterLib::Authorization> {
	typedef GblAdapterLib::AuthorizationFactory Factory;
};
template <>
struct TypeTraits <GblAdapterLib::Common> {
	typedef GblAdapterLib::CommonFactory Factory;
};
template <>
struct TypeTraits <GblAdapterLib::ComponentManager> {
	typedef GblAdapterLib::ComponentManagerFactory Factory;
};
template <>
struct TypeTraits <GblAdapterLib::AssemblyInfo> {
	typedef GblAdapterLib::AssemblyInfoFactory Factory;
};
} // namespace Core


#endif //__GARANT6X_GBLADAPTERLIB_START_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
