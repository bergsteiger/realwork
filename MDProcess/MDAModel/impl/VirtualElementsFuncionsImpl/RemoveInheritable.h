////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/RemoveInheritable.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VirtualElementsFuncionsImpl::RemoveInheritable
// ��������� ���������� ������ �������� ��� ��������� 
//
// %S%f_remove_inheritable(<��� ��������>) - ������� �������� ����� ������������ ����� �������
// ��������� � ���������, ������� ���'��. ���� �� ������� ����� ������� � �������� ���'�� ��� �
// ���� ��������� ��� ����� ������������ - ������������ ����������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_REMOVEINHERITABLE_H__
#define __MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_REMOVEINHERITABLE_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/VirtualElementsFunctionBase.h"

namespace VirtualElementsFuncionsImpl {

class RemoveInheritable; // self forward Var
typedef ::Core::Var<RemoveInheritable> RemoveInheritable_var;
typedef ::Core::Var<const RemoveInheritable> RemoveInheritable_cvar;

class RemoveInheritable_factory;

// %S%f_remove_inheritable(<��� ��������>) - ������� �������� ����� ������������ ����� �������
// ��������� � ���������, ������� ���'��. ���� �� ������� ����� ������� � �������� ���'�� ��� �
// ���� ��������� ��� ����� ������������ - ������������ ����������
class RemoveInheritable:
	virtual public VirtualElementsFunctionBase
{
	SET_OBJECT_COUNTER (RemoveInheritable)
	friend class RemoveInheritable_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	RemoveInheritable ();

	virtual ~RemoveInheritable ();

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
}; // class RemoveInheritable

} // namespace VirtualElementsFuncionsImpl


#endif //__MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_REMOVEINHERITABLE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
