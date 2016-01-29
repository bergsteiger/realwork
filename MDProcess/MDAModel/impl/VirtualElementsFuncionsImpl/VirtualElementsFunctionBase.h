////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/VirtualElementsFunctionBase.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VirtualElementsFuncionsImpl::VirtualElementsFunctionBase
// ��������� ���������� ������ �������� ��� ��������� 
//
// ������� ����� ��� ���� ������� ������ � ������������ ����������. ��� ���������� �������
// ���������� ������ ������������� �� ����!
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_VIRTUALELEMENTSFUNCTIONBASE_H__
#define __MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_VIRTUALELEMENTSFUNCTIONBASE_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/AbstractDumpers/AbstractDumperBase.h"
#include "MDProcess/MDAModel/impl/BaseFunctionImpl/InternalStereotypeFunctionBase.h"

namespace VirtualElementsFuncionsImpl {

class VirtualElementsFunctionBase; // self forward Var
typedef ::Core::Var<VirtualElementsFunctionBase> VirtualElementsFunctionBase_var;
typedef ::Core::Var<const VirtualElementsFunctionBase> VirtualElementsFunctionBase_cvar;

// ������� ����� ��� ���� ������� ������ � ������������ ����������. ��� ���������� �������
// ���������� ������ ������������� �� ����!
class VirtualElementsFunctionBase:
	virtual public BaseFunctionImpl::InternalStereotypeFunctionBase
{
	SET_OBJECT_COUNTER (VirtualElementsFunctionBase)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	VirtualElementsFunctionBase ();

	virtual ~VirtualElementsFunctionBase ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
protected:
	// ��������� ����� UID �� ��������� �������� ��������.
	virtual const std::string make_uid (
		const AbstractDumperBase* self
		, const std::string& prefix
		, const std::string& suffix
	) const;



//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods

private:

	// overloaded method from BaseFunctionImpl::InternalStereotypeFunctionBase
	// ����� ���������� ����� ������ ���������� �������
	virtual void post_execute () const;

	// overloaded method from BaseFunctionImpl::InternalStereotypeFunctionBase
	// ����� ���������� ����� ������� ���������� �������
	virtual void pre_execute () const;

}; // class VirtualElementsFunctionBase

} // namespace VirtualElementsFuncionsImpl


#endif //__MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_VIRTUALELEMENTSFUNCTIONBASE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
