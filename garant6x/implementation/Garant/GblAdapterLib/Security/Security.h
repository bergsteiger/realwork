////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/garant6x/implementation/Garant/GblAdapterLib/Security/Security.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::Security
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_SECURITY_H__
#define __GARANT6X_GBLADAPTERLIB_SECURITY_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include <vector>
#include "garant6x/implementation/Garant/GblAdapterLib/BaseTypes/BaseTypes.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DynamicTree/DynamicTree.h"
#include "garant6x/implementation/Garant/GblAdapterLib/TimeStampSyncInterface/TimeStampSyncInterface.h"
#include "shared/GCI/IO/IO.h"

namespace GblAdapterLib {

static const unsigned long UFF_USER_ACTIVE = 1;
static const unsigned long UFF_USER_NOT_ACTIVE = 2;
static const unsigned long UFF_USER_SYSTEM = 4;
static const unsigned long UFF_USER_NOT_SYSTEM = 8;
static const unsigned long UFF_USER_NOT_CURRENT = 16;
static const unsigned long UFF_GUEST_USER = 32;
static const unsigned long UFF_NOT_GUEST_USER = 64;
static const unsigned long UFF_USER_CAN_BUY_CONSULTING = 128;
static const unsigned long UFF_USER_CANT_BUY_CONSULTING = 256;
static const unsigned long UFF_USER_PRIVILEGED = 512;
static const unsigned long UFF_USER_NOT_PRIVILEGED = 1024;
static const unsigned long UFF_GROUP_UID = 2048; // ������� ������������� ������ �������� ������
static const unsigned long UFF_NOT_GROUPPED_USERS = 4096; // ������������, �������� ������ � ������ ���
static const unsigned long UFF_CHAT_CONTACT_LIST_USERS = 8192; // ������ �� ������������, ������� �������� � ������ ��������� ��� ���� �������� ������������

// �������� ������ ��������������
class WrongAuthentication : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

// ���������� ������ �������� �������������
class NoMoreProfiles : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

// ������� ������� ����������� � ������ ������ ������������
class UserActive : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

// ��������� ������������ ��������
class LicenceViolation : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

// ������� ������� ������� �� ������� �������
class XMLImportRunning : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

// ������ ������������ ��� ��������������� � �������
class LoginDuplicate : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

// ��������� � ������ ������� ����������� � ������ ���������� ������ �������.
class ShutdownInited : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

// ��������� � ������� ����� ��������� ������������ � ����� ������ �� �����������.
static const NodeType PNT_LOGGED_FLAG = 1; // ������������ � ������ ������ �������� � �������
static const NodeType PNT_SYSTEM_FLAG = 2; // ������� �����������
static const NodeType PNT_EXIT_FLAG = 4;
static const NodeType PNT_PRIVILEGED_FLAG = 8;

class UserProfile;
typedef ::Core::Var<UserProfile> UserProfile_var;
typedef ::Core::Var<const UserProfile> UserProfile_cvar;
// ���������� � ������������
class UserProfile
	: virtual public EntityBase
	, virtual public ActiveChangeable
{
public:
	// ������������� ������, � ������� ����������� ������������.
	virtual const Uid get_group_id () const
		/*throw (AccessDenied)*/ = 0;

	virtual const GCI::IO::String& get_login () const = 0;

	virtual bool has_password () const = 0;

	virtual const GCI::IO::String& get_name () const = 0;

	virtual const GCI::IO::String& get_mail () const = 0;

	virtual long get_uid () const = 0;

	virtual bool is_system () const = 0;

	virtual bool can_buy_consulting () const = 0;

	// ����������������� ������������
	virtual bool is_privileged () const = 0;
};

/// factory interface for UserProfile
class UserProfileFactory {
public:
	static UserProfile* make (
		Uid uid
		, const char* login
		, const char* name
		, const char* mail
		, bool is_system
		, bool has_password
		, bool can_buy_consulting
		, bool is_permanent
	) /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;

	static UserProfile* make ()
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

class UserFilter;
typedef ::Core::Var<UserFilter> UserFilter_var;
typedef ::Core::Var<const UserFilter> UserFilter_cvar;
// ������ ��� ������ �������������
class UserFilter
	: virtual public FilterForTree
{
public:
	virtual unsigned long get_flags () const = 0;

	virtual void set_flags (unsigned long flags) = 0;

	// ������������� ������ �� ������� ���������� ����������� ����������
	virtual const Uid get_group_uid () const = 0;

	virtual void set_group_uid (Uid group_uid) = 0;
};

/// factory interface for UserFilter
class UserFilterFactory {
public:
	static UserFilter* make ()
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

class ProfileNode;
typedef ::Core::Var<ProfileNode> ProfileNode_var;
typedef ::Core::Var<const ProfileNode> ProfileNode_cvar;
// ���� � ������ �������������
class ProfileNode
	: virtual public NodeBase
{
public:
	virtual Uid get_uid () const = 0;
};

/// factory interface for ProfileNode
class ProfileNodeFactory {
public:
	static ProfileNode* make ()
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

// ����� ��������������� ������ �������
class TrialPeriodExpired : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

// ������ �������������
typedef std::vector < Uid > UidList;

// ��������������� ��������� ��������������� �������
class AutoregistrationDisabled : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

// ������ ������� ����� ������������� � ����������������� ������
class NoMorePrivilegedProfiles : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

class UserManager;
typedef ::Core::Var<UserManager> UserManager_var;
typedef ::Core::Var<const UserManager> UserManager_cvar;
// ����� ��� ������ � ��������������. �������� ����� ��� ��������� ������ �������������.
class UserManager
	: virtual public ::Core::IObject
{
public:
	virtual void create_user_with_rights (
		const char* name
		, const char* login
		, const char* password
		, const char* mail
		, bool can_buy_consulting
		, bool is_privileged
		, Uid group_id
	) const /*throw (
		WrongAuthentication
		, NoMoreProfiles
		, XMLImportRunning
		, LoginDuplicate
		, TrialPeriodExpired
		, NoMorePrivilegedProfiles
	)*/ = 0;

	virtual void delete_user (Uid uid) const /*throw (AccessDenied, CanNotFindData, UserActive)*/ = 0;

	// ��������� ���������� ������������ �� �����������
	// ������. ������������ ���������������� �� uid.
	virtual void change_user_info (
		Uid uid
		, const char* name
		, const char* mail
	) const /*throw (
		AccessDenied
		, CanNotFindData
		, LicenceViolation
		, XMLImportRunning
	)*/ = 0;

	// ��������� ������ ������������. ������������ ���������������� �� uid.
	virtual void change_user_password (
		Uid uid
		, const char* password
	) const /*throw (
		AccessDenied
		, CanNotFindData
		, WrongAuthentication
		, LicenceViolation
		, XMLImportRunning
	)*/ = 0;

	virtual void change_user_group (Uid user_id, Uid group_id) const /*throw (AccessDenied, CanNotFindData)*/ = 0;

	virtual void change_users_group (
		const UidList& id_list
		, Uid group_id
	) const /*throw (
		AccessDenied
		, CanNotFindData
	)*/ = 0;

	// ��������� �������� - ����� �� ������ ������������ ������� �� ������������
	virtual void user_can_buy_consulting (
		Uid uid
		, bool is_allowed
	) const /*throw (
		AccessDenied
		, CanNotFindData
		, LicenceViolation
		, XMLImportRunning
	)*/ = 0;

	// ���������� �������� ������������������� ��� ������������
	virtual void user_is_privileged (
		Uid uid
		, bool is_privileged
	) const /*throw (
		AccessDenied
		, XMLImportRunning
		, NoMorePrivilegedProfiles
	)*/ = 0;

	virtual void logout_user (Uid uid) const /*throw (AccessDenied, CanNotFindData)*/ = 0;

	virtual UserProfile* get_self_profile () /*throw (CanNotFindData)*/ = 0;

	// ��������� �������� ������ ������������ ��� ���� �������������
	virtual void set_consulting_payment_for_all (bool is_allowed) const /*throw (AccessDenied)*/ = 0;

	// ��������� �������� ������ ������������ ��� ����� �������������
	virtual void set_consulting_payment_for_newbies (bool is_allowed) const /*throw (AccessDenied)*/ = 0;

	// ���������� ������� �������� �������� ������ ������������ ��� ����� ������������� (true - ������
	// ���������)
	virtual bool get_consulting_payment_for_newbies () const = 0;

	// ������� ������ �������������. ���������� ������ �������������, ������� ������� �� �������.
	virtual UidList* delete_users (const UidList& list) const /*throw (AccessDenied)*/ = 0;

	// ��������� ������ � ������� ���������� ������ �������������.
	virtual void logout_users (const UidList& list) const /*throw (AccessDenied)*/ = 0;

	// ������ ����� �� ������ ������������ ��� ��������� ������ �������������.
	virtual void set_consulting_rights (
		const UidList& list
		, bool is_payment_allowed
	) const /*throw (
		AccessDenied
		, InternalDatabaseError
	)*/ = 0;

	// ���������� ����� �������������������
	virtual void set_privileged_rights (
		const UidList& list
		, bool is_privileged
	) const /*throw (
		AccessDenied
		, XMLImportRunning
		, NoMorePrivilegedProfiles
	)*/ = 0;

	// ����� �� ��������� ����������������� �������������
	virtual bool can_create_privileged_user () const /*throw (AccessDenied)*/ = 0;

	// ��������� ������ ������, ����������� ������� ������
	virtual StringList* get_active_users_list_for_net_one_user_version () const /*throw (CanNotFindData)*/ = 0;

	// �������� ������ �����
	virtual NodeBase* get_groups_tree () const = 0;

	// �������� ������ ������������� ��� ������ � �������� ���������������
	virtual NodeBase* get_users_tree () const = 0;

	// ������� ������ � �������� ������
	virtual void create_group (
		const char* name
	) const /*throw (
		AccessDenied
		, WrongAuthentication
		, XMLImportRunning
		, LoginDuplicate
	)*/ = 0;

	// ������� ������ � �������� ���������������
	virtual void delete_group (Uid uid) const /*throw (AccessDenied, CanNotFindData)*/ = 0;

	// ���������� ������ ������ ���� �� ������� �������� ����� ������ �������������
	virtual void set_nonsearchable_blocks_for_group (
		Uid uid
		, const NodeIdList& blocks_ids
	) const /*throw (
		AccessDenied
		, CanNotFindData
	)*/ = 0;

	// �������� ������ ������ ���� �� ������� �������� ����� ������ �������������
	virtual NodeIdList* get_nonsearchable_blocks_for_group (
		Uid uid
	) const /*throw (
		AccessDenied
		, InternalDatabaseError
	)*/ = 0;

	// ������� ��� ������
	virtual void change_group_name (
		Uid uid
		, const char* name
	) const /*throw (
		AccessDenied
		, CanNotFindData
		, LoginDuplicate
	)*/ = 0;

	// ����� �� ������� ������������
	virtual bool has_shared_filters (Uid uid) const = 0;

	// ������������� ������ �������� �� ������� ������������ uid ������ � ������������ �� ���������
	// state
	virtual void set_shared_filters_state (Uid uid, bool state) const = 0;

	// ����� �� ������������ ���� �����
	virtual bool is_erasable (Uid uid) const = 0;

	// ��������� �������� - ����� �� ������� ������������
	virtual void set_erasable_state (Uid uid, bool state) const = 0;
};

/// factory interface for UserManager
class UserManagerFactory {
public:
	static UserManager* make ()
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

// ���������, ��������� � ��������
static const Uid GROUP_ALL_ID = 0; // ������������� ������ "���"

class GroupNode;
typedef ::Core::Var<GroupNode> GroupNode_var;
typedef ::Core::Var<const GroupNode> GroupNode_cvar;
// ���� ������ �����
class GroupNode
	: virtual public ProfileNode
{
public:
	// ���� �� � ������ ������������
	virtual bool has_users () const /*throw (AccessDenied, CanNotFindData)*/ = 0;
};

/// factory interface for GroupNode
class GroupNodeFactory {
public:
	// �������
	static GroupNode* make ()
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

} // namespace GblAdapterLib

// TypeTraits specializations
namespace Core {	
template <>
struct TypeTraits <GblAdapterLib::UserProfile> {
	typedef GblAdapterLib::UserProfileFactory Factory;
};
template <>
struct TypeTraits <GblAdapterLib::UserFilter> {
	typedef GblAdapterLib::UserFilterFactory Factory;
};
template <>
struct TypeTraits <GblAdapterLib::ProfileNode> {
	typedef GblAdapterLib::ProfileNodeFactory Factory;
};
template <>
struct TypeTraits <GblAdapterLib::UserManager> {
	typedef GblAdapterLib::UserManagerFactory Factory;
};
template <>
struct TypeTraits <GblAdapterLib::GroupNode> {
	typedef GblAdapterLib::GroupNodeFactory Factory;
};
} // namespace Core


#endif //__GARANT6X_GBLADAPTERLIB_SECURITY_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
