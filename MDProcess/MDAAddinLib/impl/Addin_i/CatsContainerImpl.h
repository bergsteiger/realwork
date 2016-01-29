////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAAddinLib/impl/Addin_i/CatsContainerImpl.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAAddinLib::Addin_i::CatsContainerImpl
// ��������� ���������� ������ �������� ��� ��������� CatsContainer
//
// ���������� ���������� ���������� �����
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAADDINLIB_ADDIN_I_CATSCONTAINERIMPL_H__
#define __MDPROCESS_MDAADDINLIB_ADDIN_I_CATSCONTAINERIMPL_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/RosePackageLocking/RosePackageLockingServer/RosePackageLockingServer.h"
#include "MDProcess/MDAModel/MDPSupport/MDPSupport.h"

//#UC START# *47D140840220_CUSTOM_INCLUDES*
#include "MDProcess/RosePackageLocking/RosePackageLockingServer/RosePackageLockingServerS.h"
//#UC END# *47D140840220_CUSTOM_INCLUDES*


class CatsContainerImpl; // self forward Var
typedef ::Core::Var<CatsContainerImpl> CatsContainerImpl_var;
typedef ::Core::Var<const CatsContainerImpl> CatsContainerImpl_cvar;

class CatsContainerImpl_factory;

// ���������� ���������� ���������� �����
class CatsContainerImpl:
	virtual public MDPSupport::CatsContainer
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (CatsContainerImpl)
	friend class CatsContainerImpl_factory; // self factory

//////////////////////////////////////////////////////////////////////////////////////////
// nested declorations
private:


	// ���������� ���������� callback
	class LocksListenerImpl;
	typedef Core::Var<LocksListenerImpl> LocksListenerImpl_var;
	typedef Core::Var<const LocksListenerImpl> LocksListenerImpl_cvar;

	class LocksListenerImpl :
		virtual public POA_RosePackageLocking::RosePackageLockingServer::LocksListener
		, virtual public ::CoreSrv::RefCountServantBase
	{
		SET_OBJECT_COUNTER (LocksListenerImpl)
	//////////////////////////////////////////////////////////////////////////////////////////
	// constructors and destructor
	public:
		virtual ~LocksListenerImpl ();


	//////////////////////////////////////////////////////////////////////////////////////////
	// implemented interface's methods
	protected:

	// implemented method from RosePackageLocking::RosePackageLockingServer::LocksListener
	// lock_changed - ������� � ���, ��� ��������� ������� ������ ��������� ������ by_user.
	virtual void lock_changed (
		RosePackageLocking::RosePackageLockingServer::PackageGUID_const guid
		, const char* by_user
		, const char* time
		, RosePackageLocking::RosePackageLockingServer::LockChange what
	) throw (
		CORBA::SystemException
	);
	}; // class LocksListenerImpl

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	CatsContainerImpl ();

	virtual ~CatsContainerImpl ();
//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	MDPSupport::CatsLockStatus m_cats_lock_status;

	// ������������� ���������� ������� � ���������� ������� COM-�����������
	DWORD m_current_model_id;

	// ��������� ���������� ������� COM-��������
	IGlobalInterfaceTablePtr m_git;

	// ������� ��� ������������� ������� � GIT
	mutable Core::Mutex m_git_mutex;

	// ��������� ��������� �������
	LocksListenerImpl_var m_listener;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from MDPSupport::CatsContainer
	// ������� �������
	virtual const MDPSupport::CatsLockStatus& get_cats_lock_status () const;

	// implemented method from MDPSupport::CatsContainer
	// ������� ������ �������
	virtual void clear_lock_status ();

	// implemented method from MDPSupport::CatsContainer
	// �������� ��� �� ��� �����
	virtual IRoseCategoryPtr get_cat_by_guid (const char* guid) const;

	// implemented method from MDPSupport::CatsContainer
	// �������� ���������� � �������
	virtual const MDPSupport::LockInfo& get_info (
		const std::string& key
	) const /*throw (
		MDPSupport::LockInfoNotExists
	)*/;

	// implemented method from MDPSupport::CatsContainer
	// ���������� ������ ��������� (�������� �� ��, ��� ����� �� ������������ - ��������  ������
	// ������������ ������ ���� � ��� ��)
	virtual RosePackageLocking::RosePackageLockingServer::LocksListener* get_listener ();

	// implemented method from MDPSupport::CatsContainer
	// ���������� true, ���� ���� ���������� � �������
	virtual bool is_info_exists (const std::string& key) const;

	// implemented method from MDPSupport::CatsContainer
	// ������������ ��������� ��� ���������� ����������, ����� ��� ������� �� �� ���� ������, �
	// ������� �������������� ������ �� ������� �������
	virtual void register_for_com_marshal (IRoseModelPtr model);

	// implemented method from MDPSupport::CatsContainer
	// unregister ��� ���������
	virtual void unregister_for_com_marshal (IRoseModelPtr model);

	// implemented method from MDPSupport::CatsContainer
	// ���������� ���������� � �������
	virtual void write_info (const std::string& key, const MDPSupport::LockInfo& info);

//#UC START# *47D140840220*
//#UC END# *47D140840220*
}; // class CatsContainerImpl



#endif //__MDPROCESS_MDAADDINLIB_ADDIN_I_CATSCONTAINERIMPL_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
