////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/AddInheritable.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VirtualElementsFuncionsImpl::AddInheritable
// ��������� ���������� ������ �������� ��� ��������� 
//
// %S%f_add_inheritable(<���� ��������� �������� ��� ������ ���>) - ���������� _add_realized, ��
// �������� ������� � ������ �����������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_ADDINHERITABLE_H__
#define __MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_ADDINHERITABLE_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/VirtualElementsFunctionBase.h"

namespace VirtualElementsFuncionsImpl {

class AddInheritable; // self forward Var
typedef ::Core::Var<AddInheritable> AddInheritable_var;
typedef ::Core::Var<const AddInheritable> AddInheritable_cvar;

class AddInheritable_factory;

// %S%f_add_inheritable(<���� ��������� �������� ��� ������ ���>) - ���������� _add_realized, ��
// �������� ������� � ������ �����������
class AddInheritable:
	virtual public VirtualElementsFunctionBase
{
	SET_OBJECT_COUNTER (AddInheritable)
	friend class AddInheritable_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	AddInheritable ();

	virtual ~AddInheritable ();

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from BaseFunctionImpl::InternalStereotypeFunctionBase
	// ���������� ���������� ���������� �������. ������ ���������� ������� ��������� ��� �����
	virtual const std::string execute_impl (
		const AbstractDumperBase* self
		, const TemplateFunctions::FunctionParams& params
		, TemplatePainter* painter
	) const /*throw (
		TemplateFunctions::BadParams
	)*/;
}; // class AddInheritable

} // namespace VirtualElementsFuncionsImpl


#endif //__MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_ADDINHERITABLE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
