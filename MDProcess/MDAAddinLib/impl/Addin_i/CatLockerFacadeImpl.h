////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAAddinLib/impl/Addin_i/CatLockerFacadeImpl.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAAddinLib::Addin_i::CatLockerFacadeImpl
// ��������� ���������� ������ �������� ��� ��������� CatLockerFacade
//
// ���������� ���������� �������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAADDINLIB_ADDIN_I_CATLOCKERFACADEIMPL_H__
#define __MDPROCESS_MDAADDINLIB_ADDIN_I_CATLOCKERFACADEIMPL_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/RoseTypes/RationalRoseTlb.h"
#include "MDProcess/MDAModel/MDPSupport/MDPSupport.h"


class CatLockerFacadeImpl; // self forward Var
typedef ::Core::Var<CatLockerFacadeImpl> CatLockerFacadeImpl_var;
typedef ::Core::Var<const CatLockerFacadeImpl> CatLockerFacadeImpl_cvar;

class CatLockerFacadeImpl_factory;

// ���������� ���������� �������
class CatLockerFacadeImpl:
	virtual public MDPSupport::CatLockerFacade
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (CatLockerFacadeImpl)
	friend class CatLockerFacadeImpl_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	CatLockerFacadeImpl (IRoseCategoryPtr cat);

	CatLockerFacadeImpl (IRoseElementPtr elem);

	virtual ~CatLockerFacadeImpl ();
//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	IRoseCategoryPtr m_cat;

	bool m_is_change_mode;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from MDPSupport::CatLockerFacade
	// ���������� true ���� ��� ����� ������
	virtual bool can_change () const;

	// implemented method from MDPSupport::CatLockerFacade
	// ���������� true, ���� ��� ����� ��������
	virtual bool can_commit () const;

	// implemented method from MDPSupport::CatLockerFacade
	// ���������� true, ���� ��� ����� ��������
	virtual bool can_lock () const;

	// implemented method from MDPSupport::CatLockerFacade
	// ���������� true, ���� ��������� � ��� ����� ������ ��������
	virtual bool can_rollback () const;

	// implemented method from MDPSupport::CatLockerFacade
	// ���������� �������� ������, ������� ���������. ���� ����������� ���� �� �������,  �� �
	// ����������� CatLockerFacade ��������� ����� ��������.
	virtual void do_change ();

	// implemented method from MDPSupport::CatLockerFacade
	// ������ ����������� ��������
	virtual bool try_change ();
}; // class CatLockerFacadeImpl



#endif //__MDPROCESS_MDAADDINLIB_ADDIN_I_CATLOCKERFACADEIMPL_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
