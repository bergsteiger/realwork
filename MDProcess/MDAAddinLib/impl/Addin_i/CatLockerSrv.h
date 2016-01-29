////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAAddinLib/impl/Addin_i/CatLockerSrv.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAAddinLib::Addin_i::CatLockerSrv
// ��������� ���������� ������ �������� ��� ��������� CatLocker
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAADDINLIB_ADDIN_I_CATLOCKERSRV_H__
#define __MDPROCESS_MDAADDINLIB_ADDIN_I_CATLOCKERSRV_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/RoseTypes/RationalRoseTlb.h"
#include "MDProcess/MDAModel/MDPSupport/MDPSupport.h"


class CatLockerSrv; // self forward Var
typedef ::Core::Var<CatLockerSrv> CatLockerSrv_var;
typedef ::Core::Var<const CatLockerSrv> CatLockerSrv_cvar;

class CatLockerSrv_factory;

class CatLockerSrv:
	virtual public MDPSupport::CatLocker
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (CatLockerSrv)
	friend class CatLockerSrv_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// static member methods and data
private:
	// ���������� ������� ����� � ���� � ���� ������
	static const std::string get_time ();

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	CatLockerSrv (IRoseCategoryPtr cat);

	virtual ~CatLockerSrv ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
private:
	// ����� �� ��������� ������
	virtual bool can_commit_i (bool need_assertion) const;

	// ����� �� ������ �����������
	virtual bool can_modify_i (bool need_assertion) const;

	// ����� �� �������� ���������
	virtual bool can_rollback_i (bool need_assertion) const;

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	IRoseCategoryPtr m_cat;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from MDPSupport::CatLocker
	// ����������� �����. ���������� false � ������ ������.
	virtual bool commit ();

	// implemented method from MDPSupport::CatLocker
	// ���������� false, ���� ����� ��������� ��� ����������� ������� �������.
	virtual bool has_lock_status () const;

	// implemented method from MDPSupport::CatLocker
	// ������ ������� ������
	virtual RosePackageLocking::RosePackageLockingServer::LockStatus get_lock_status () const;

	// implemented method from MDPSupport::CatLocker
	// ����� ����� ��� �����������. ���������� false ���� ����� ��� ���-�� �������.
	virtual bool modify ();

	// implemented method from MDPSupport::CatLocker
	// ���������� ���������.
	virtual bool rollback ();
}; // class CatLockerSrv



#endif //__MDPROCESS_MDAADDINLIB_ADDIN_I_CATLOCKERSRV_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
