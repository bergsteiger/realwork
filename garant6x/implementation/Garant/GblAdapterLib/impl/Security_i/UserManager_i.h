////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Security_i/UserManager_i.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Security_i::UserManager_i
// ��������� ���������� ������ �������� ��� ��������� UserManager
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_SECURITY_I_USERMANAGER_I_H__
#define __GARANT6X_GBLADAPTERLIB_SECURITY_I_USERMANAGER_I_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "ace/Singleton.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Security/Security.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/RealNodeRoot.h"

namespace GblAdapterLib {

class UserManager_i; // self forward Var
typedef ::Core::Var<UserManager_i> UserManager_i_var;
typedef ::Core::Var<const UserManager_i> UserManager_i_cvar;

class UserManager_i_factory;

class UserManager_i:
	virtual public UserManager
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (UserManager_i)
	friend class UserManager_i_factory; // self factory

	// singleton declaration
	typedef ACE_Singleton <UserManager_i, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <UserManager_i, ACE_SYNCH_RECURSIVE_MUTEX>;

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	UserManager_i ();

	virtual ~UserManager_i ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
private:
	virtual bool load_groups_tree () const;

	virtual bool load_users_tree () const;

	virtual void set_privileged_rights_i (const UidList& list, bool is_privileged) const;

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	mutable RealNodeRoot_var m_groups_root;

	mutable bool m_is_payment_status_cached;

	mutable bool m_payment_status_for_newbies;

	mutable RealNodeRoot_var m_users_root;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from UserManager
	// ����� �� ��������� ����������������� �������������
	virtual bool can_create_privileged_user () const /*throw (AccessDenied)*/;

	// implemented method from UserManager
	// ������� ��� ������
	virtual void change_group_name (
		Uid uid
		, const char* name
	) const /*throw (
		AccessDenied
		, CanNotFindData
		, LoginDuplicate
	)*/;

	// implemented method from UserManager
	virtual void change_user_group (Uid user_id, Uid group_id) const /*throw (AccessDenied, CanNotFindData)*/;

	// implemented method from UserManager
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
	)*/;

	// implemented method from UserManager
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
	)*/;

	// implemented method from UserManager
	virtual void change_users_group (
		const UidList& id_list
		, Uid group_id
	) const /*throw (
		AccessDenied
		, CanNotFindData
	)*/;

	// implemented method from UserManager
	// ������� ������ � �������� ������
	virtual void create_group (
		const char* name
	) const /*throw (
		AccessDenied
		, WrongAuthentication
		, XMLImportRunning
		, LoginDuplicate
	)*/;

	// implemented method from UserManager
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
	)*/;

	// implemented method from UserManager
	// ������� ������ � �������� ���������������
	virtual void delete_group (Uid uid) const /*throw (AccessDenied, CanNotFindData)*/;

	// implemented method from UserManager
	virtual void delete_user (Uid uid) const /*throw (AccessDenied, CanNotFindData, UserActive)*/;

	// implemented method from UserManager
	// ������� ������ �������������. ���������� ������ �������������, ������� ������� �� �������.
	virtual UidList* delete_users (const UidList& list) const /*throw (AccessDenied)*/;

	// implemented method from UserManager
	// ��������� ������ ������, ����������� ������� ������
	virtual StringList* get_active_users_list_for_net_one_user_version () const /*throw (CanNotFindData)*/;

	// implemented method from UserManager
	// ���������� ������� �������� �������� ������ ������������ ��� ����� ������������� (true - ������
	// ���������)
	virtual bool get_consulting_payment_for_newbies () const;

	// implemented method from UserManager
	// �������� ������ �����
	virtual NodeBase* get_groups_tree () const;

	// implemented method from UserManager
	// �������� ������ ������ ���� �� ������� �������� ����� ������ �������������
	virtual NodeIdList* get_nonsearchable_blocks_for_group (
		Uid uid
	) const /*throw (
		AccessDenied
		, InternalDatabaseError
	)*/;

	// implemented method from UserManager
	virtual UserProfile* get_self_profile () /*throw (CanNotFindData)*/;

	// implemented method from UserManager
	// �������� ������ ������������� ��� ������ � �������� ���������������
	virtual NodeBase* get_users_tree () const;

	// implemented method from UserManager
	// ����� �� ������� ������������
	virtual bool has_shared_filters (Uid uid) const;

	// implemented method from UserManager
	// ����� �� ������������ ���� �����
	virtual bool is_erasable (Uid uid) const;

	// implemented method from UserManager
	virtual void logout_user (Uid uid) const /*throw (AccessDenied, CanNotFindData)*/;

	// implemented method from UserManager
	// ��������� ������ � ������� ���������� ������ �������������.
	virtual void logout_users (const UidList& list) const /*throw (AccessDenied)*/;

	// implemented method from UserManager
	// ��������� �������� ������ ������������ ��� ���� �������������
	virtual void set_consulting_payment_for_all (bool is_allowed) const /*throw (AccessDenied)*/;

	// implemented method from UserManager
	// ��������� �������� ������ ������������ ��� ����� �������������
	virtual void set_consulting_payment_for_newbies (bool is_allowed) const /*throw (AccessDenied)*/;

	// implemented method from UserManager
	// ������ ����� �� ������ ������������ ��� ��������� ������ �������������.
	virtual void set_consulting_rights (
		const UidList& list
		, bool is_payment_allowed
	) const /*throw (
		AccessDenied
		, InternalDatabaseError
	)*/;

	// implemented method from UserManager
	// ��������� �������� - ����� �� ������� ������������
	virtual void set_erasable_state (Uid uid, bool state) const;

	// implemented method from UserManager
	// ���������� ������ ������ ���� �� ������� �������� ����� ������ �������������
	virtual void set_nonsearchable_blocks_for_group (
		Uid uid
		, const NodeIdList& blocks_ids
	) const /*throw (
		AccessDenied
		, CanNotFindData
	)*/;

	// implemented method from UserManager
	// ���������� ����� �������������������
	virtual void set_privileged_rights (
		const UidList& list
		, bool is_privileged
	) const /*throw (
		AccessDenied
		, XMLImportRunning
		, NoMorePrivilegedProfiles
	)*/;

	// implemented method from UserManager
	// ������������� ������ �������� �� ������� ������������ uid ������ � ������������ �� ���������
	// state
	virtual void set_shared_filters_state (Uid uid, bool state) const;

	// implemented method from UserManager
	// ��������� �������� - ����� �� ������ ������������ ������� �� ������������
	virtual void user_can_buy_consulting (
		Uid uid
		, bool is_allowed
	) const /*throw (
		AccessDenied
		, CanNotFindData
		, LicenceViolation
		, XMLImportRunning
	)*/;

	// implemented method from UserManager
	// ���������� �������� ������������������� ��� ������������
	virtual void user_is_privileged (
		Uid uid
		, bool is_privileged
	) const /*throw (
		AccessDenied
		, XMLImportRunning
		, NoMorePrivilegedProfiles
	)*/;
}; // class UserManager_i

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_SECURITY_I_USERMANAGER_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
