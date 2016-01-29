////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/MDPSupport/MDPSupport.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Interfaces::Category>> MDProcess::MDAModel::MDPSupport
//
// ���������� ���  ������ � �������� �������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_MDPSUPPORT_H__
#define __MDPROCESS_MDAMODEL_MDPSUPPORT_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include <map>
#include "MDProcess/MDAModel/RoseTypes/RationalRoseTlb.h"
#include "MDProcess/RosePackageLocking/RosePackageLockingServer/RosePackageLockingServer.h"

namespace MDPSupport {

class CatLocker;
typedef ::Core::Var<CatLocker> CatLocker_var;
typedef ::Core::Var<const CatLocker> CatLocker_cvar;
// ��������� ��� ������� �����
class CatLocker
	: virtual public ::Core::IObject
{
public:
	// ������ ������� ������
	virtual RosePackageLocking::RosePackageLockingServer::LockStatus get_lock_status () const = 0;

	// ����� ����� ��� �����������. ���������� false ���� ����� ��� ���-�� �������.
	virtual bool modify () = 0;

	// ����������� �����. ���������� false � ������ ������.
	virtual bool commit () = 0;

	// ���������� ���������.
	virtual bool rollback () = 0;

	// ���������� false, ���� ����� ��������� ��� ����������� ������� �������.
	virtual bool has_lock_status () const = 0;
};

/// factory interface for CatLocker
class CatLockerFactory {
public:
	// ������� ������ CatLocker ��� ���� �� cat
	static CatLocker* make (IRoseCategoryPtr cat)
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

class MDPFacade;
typedef ::Core::Var<MDPFacade> MDPFacade_var;
typedef ::Core::Var<const MDPFacade> MDPFacade_cvar;
// ���������-������� ��� ������� � ������� �������
class MDPFacade
	: virtual public ::Core::IObject
{
public:
	// ������ ������ ������ � �������� �������
	virtual bool login () = 0;

	// ��������� ������ ������ � �������� �������
	virtual void logout () = 0;

	// ���������� false ���� ������ ������� ����������
	virtual bool is_server_exist () const = 0;

	// ���������� ���� ������� �� �������  ���������� �������
	virtual void show_locked () const = 0;

	// �������������� ������ (model) �� ������� - �������� ������� ������� ������� � �������
	virtual bool sync (IRoseModelPtr model) = 0;

	// "���������" ������ ����� �������������. ����������� ��� �������� ������.
	virtual bool unsync (IRoseModelPtr model) = 0;
};

/// factory interface for MDPFacade
class MDPFacadeFactory {
public:
	// ���������� ������������ ������ MDPFacade
	static MDPFacade& get ()
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

#pragma pack (push, 1)

// ������ � ��� ��� �������
struct LockInfo {
	// ���, ����������� �����
	std::string lock_owner_name;
	// ����� �������/�������� ������
	std::string lock_time;
	// ������ �������
	RosePackageLocking::RosePackageLockingServer::LockStatus status;

	// ����������� ���
	LockInfo (
		RosePackageLocking::RosePackageLockingServer::LockStatus s
		, const std::string& owner
		, const std::string& time
	);

	// ������ �����������
	LockInfo ();
};

#pragma pack (pop)

// ������� ������� - ��� �� �� ������ �� ������ ������ ���. ���������� ���� ������ �� ����� ���
// �����������
typedef std::map < std::string, LockInfo > CatsLockStatus;

// ����������� � ������� �����������
class LockInfoNotExists : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

class CatLockerFacade;
typedef ::Core::Var<CatLockerFacade> CatLockerFacade_var;
typedef ::Core::Var<const CatLockerFacade> CatLockerFacade_cvar;
// ��������� ������� ��� cat-������, ������������ ���������� ���������� ��� ����� ��������� �������
// cat. ����� ���������: ������ ������� ����������, ����� ��� �� ��� ����������� ������� � �.�.
class CatLockerFacade
	: virtual public ::Core::IObject
{
public:
	// ���������� true ���� ��� ����� ������
	virtual bool can_change () const = 0;

	// ���������� true, ���� ��� ����� ��������
	virtual bool can_lock () const = 0;

	// ���������� true, ���� ��� ����� ��������
	virtual bool can_commit () const = 0;

	// ���������� true, ���� ��������� � ��� ����� ������ ��������
	virtual bool can_rollback () const = 0;

	// ������ ����������� ��������
	virtual bool try_change () = 0;

	// ���������� �������� ������, ������� ���������. ���� ����������� ���� �� �������,  �� �
	// ����������� CatLockerFacade ��������� ����� ��������.
	virtual void do_change () = 0;
};

/// factory interface for CatLockerFacade
class CatLockerFacadeFactory {
public:
	// ������� ������ ������ �� ���������-���������
	static CatLockerFacade* make (IRoseCategoryPtr cat)
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;

	// ������� ������ ������ �� ���������-��������, �������������� �������� ����� ��� ����
	// ������������ ���������
	static CatLockerFacade* make (IRoseElementPtr elem)
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

class CatsContainer;
typedef ::Core::Var<CatsContainer> CatsContainer_var;
typedef ::Core::Var<const CatsContainer> CatsContainer_cvar;
// ��������� ����� � �� ���������� �������
class CatsContainer
	: virtual public ::Core::IObject
{
public:
	// ������� �������
	virtual const CatsLockStatus& get_cats_lock_status () const = 0;

	// �������� ��� �� ��� �����
	virtual IRoseCategoryPtr get_cat_by_guid (const char* guid) const = 0;

	// ������������ ��������� ��� ���������� ����������, ����� ��� ������� �� �� ���� ������, �
	// ������� �������������� ������ �� ������� �������
	virtual void register_for_com_marshal (IRoseModelPtr model) = 0;

	// unregister ��� ���������
	virtual void unregister_for_com_marshal (IRoseModelPtr model) = 0;

	// ������� ������ �������
	virtual void clear_lock_status () = 0;

	// ���������� ������ ��������� (�������� �� ��, ��� ����� �� ������������ - ��������  ������
	// ������������ ������ ���� � ��� ��)
	virtual RosePackageLocking::RosePackageLockingServer::LocksListener* get_listener () = 0;

	// ���������� ���������� � �������
	virtual void write_info (const std::string& key, const LockInfo& info) = 0;

	// �������� ���������� � �������
	virtual const LockInfo& get_info (const std::string& key) const /*throw (LockInfoNotExists)*/ = 0;

	// ���������� true, ���� ���� ���������� � �������
	virtual bool is_info_exists (const std::string& key) const = 0;
};

/// factory interface for CatsContainer
class CatsContainerFactory {
public:
	// ���������� ���������
	static CatsContainer& get ()
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

} // namespace MDPSupport

// TypeTraits specializations
namespace Core {	
template <>
struct TypeTraits <MDPSupport::CatLocker> {
	typedef MDPSupport::CatLockerFactory Factory;
};
template <>
struct TypeTraits <MDPSupport::MDPFacade> {
	typedef MDPSupport::MDPFacadeFactory Factory;
};
template <>
struct TypeTraits <MDPSupport::CatLockerFacade> {
	typedef MDPSupport::CatLockerFacadeFactory Factory;
};
template <>
struct TypeTraits <MDPSupport::CatsContainer> {
	typedef MDPSupport::CatsContainerFactory Factory;
};
} // namespace Core


#endif //__MDPROCESS_MDAMODEL_MDPSUPPORT_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
