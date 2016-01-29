////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAAddinLib/impl/Addin_i/MDPFacadeSrv.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAAddinLib::Addin_i::MDPFacadeSrv
// ��������� ���������� ������ �������� ��� ��������� MDPFacade
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAADDINLIB_ADDIN_I_MDPFACADESRV_H__
#define __MDPROCESS_MDAADDINLIB_ADDIN_I_MDPFACADESRV_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/MDPSupport/MDPSupport.h"

//#UC START# *462C9FB20331_CUSTOM_INCLUDES*
//#UC END# *462C9FB20331_CUSTOM_INCLUDES*


class MDPFacadeSrv; // self forward Var
typedef ::Core::Var<MDPFacadeSrv> MDPFacadeSrv_var;
typedef ::Core::Var<const MDPFacadeSrv> MDPFacadeSrv_cvar;

class MDPFacadeSrv_factory;

class MDPFacadeSrv:
	virtual public MDPSupport::MDPFacade
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (MDPFacadeSrv)
	friend class MDPFacadeSrv_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	MDPFacadeSrv ();

	virtual ~MDPFacadeSrv ();
//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	bool m_is_login;

	bool m_is_server_exist;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from MDPSupport::MDPFacade
	// ���������� false ���� ������ ������� ����������
	virtual bool is_server_exist () const;

	// implemented method from MDPSupport::MDPFacade
	// ������ ������ ������ � �������� �������
	virtual bool login ();

	// implemented method from MDPSupport::MDPFacade
	// ��������� ������ ������ � �������� �������
	virtual void logout ();

	// implemented method from MDPSupport::MDPFacade
	// ���������� ���� ������� �� �������  ���������� �������
	virtual void show_locked () const;

	// implemented method from MDPSupport::MDPFacade
	// �������������� ������ (model) �� ������� - �������� ������� ������� ������� � �������
	virtual bool sync (IRoseModelPtr model);

	// implemented method from MDPSupport::MDPFacade
	// "���������" ������ ����� �������������. ����������� ��� �������� ������.
	virtual bool unsync (IRoseModelPtr model);

//#UC START# *462C9FB20331*
//#UC END# *462C9FB20331*
}; // class MDPFacadeSrv



#endif //__MDPROCESS_MDAADDINLIB_ADDIN_I_MDPFACADESRV_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
