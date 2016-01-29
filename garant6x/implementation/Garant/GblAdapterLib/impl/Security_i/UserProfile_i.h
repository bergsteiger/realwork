////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Security_i/UserProfile_i.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Security_i::UserProfile_i
// ��������� ���������� ������ �������� ��� ��������� UserProfile
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_SECURITY_I_USERPROFILE_I_H__
#define __GARANT6X_GBLADAPTERLIB_SECURITY_I_USERPROFILE_I_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/GCI/IO/IO.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Security/Security.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/TimeStampSync/ActiveChangeableBase.h"

namespace GblAdapterLib {

class UserProfile_i; // self forward Var
typedef ::Core::Var<UserProfile_i> UserProfile_i_var;
typedef ::Core::Var<const UserProfile_i> UserProfile_i_cvar;

class UserProfile_i_factory;

class UserProfile_i:
	virtual public UserProfile
	, virtual public ::Core::RefCountObjectBase
	, virtual public TimeStampSync::ActiveChangeableBase
{
	SET_OBJECT_COUNTER (UserProfile_i)
	friend class UserProfile_i_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	UserProfile_i (
		long uid
		, const char* login
		, const char* name
		, const char* mail
		, bool is_system
		, bool has_password
		, bool can_buy_consulting
		, bool is_privileged
	);

	virtual ~UserProfile_i ();
//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	bool m_can_buy_consulting;

	bool m_has_password;

	bool m_is_privileged;

	bool m_is_system;

	GCI::IO::String_var m_login;

	GCI::IO::String_var m_mail;

	GCI::IO::String_var m_name;

	long m_uid;

	Core::Mutex m_update_mutex;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from ActiveChangeable
	virtual void acquire_update_mutex ();

	// implemented method from ActiveChangeable
	virtual void release_update_mutex ();

	// implemented method from ActiveChangeable
	virtual void update_cache (const CORBA::Any& hint);

	// implemented method from EntityBase
	// ��������� � ����  ���������� ��������� �������.
	// ��������� � � ����� ������������ �������
	virtual EntityStorage* append_to (
		EntityStorage* storage
	) /*throw (
		ConstantModify
		, AccessDenied
		, Unsupported
		, CanNotSave
	)*/;

	// implemented method from EntityBase
	// �������������
	virtual const unsigned long get_eid () const
		/*throw (Unsupported)*/;

	// implemented method from EntityBase
	// �������� �����������
	virtual bool get_is_changed () const;

	// implemented method from EntityBase
	// ������� ���� ��� ������ ������ ��� �������� � ���� ������. ��� �� ����������� ������� �������
	// ���������� ������� ����� �������� (���� ����� �����). ��� �� ����������� �������� �������� save
	// ������ ����������.
	virtual bool get_is_saved () const;

	// implemented method from EntityBase
	// ������������ �������� ������� ���������.
	virtual EntityStorage* save_to (
		EntityStorage* storage
	) /*throw (
		AccessDenied
		, Unsupported
		, NotSaved
		, DuplicateNode
		, CanNotSave
	)*/;

	// implemented method from UserProfile
	virtual bool can_buy_consulting () const;

	// implemented method from UserProfile
	virtual const GCI::IO::String& get_login () const;

	// implemented method from UserProfile
	virtual const GCI::IO::String& get_mail () const;

	// implemented method from UserProfile
	virtual const GCI::IO::String& get_name () const;

	// implemented method from UserProfile
	virtual long get_uid () const;

	// implemented method from UserProfile
	// ������������� ������, � ������� ����������� ������������.
	virtual const Uid get_group_id () const
		/*throw (AccessDenied)*/;

	// implemented method from UserProfile
	virtual bool has_password () const;

	// implemented method from UserProfile
	// ����������������� ������������
	virtual bool is_privileged () const;

	// implemented method from UserProfile
	virtual bool is_system () const;
}; // class UserProfile_i

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_SECURITY_I_USERPROFILE_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
