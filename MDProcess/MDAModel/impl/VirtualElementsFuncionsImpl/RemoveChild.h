////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/RemoveChild.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VirtualElementsFuncionsImpl::RemoveChild
// ��������� ���������� ������ �������� ��� ��������� 
//
// %S%f_remove_child(<��� ��������>) - ������� �������� �������� �� ������ ��������� - ���� �������
// � �������� ���'�� ����� ����� �������� �������� (%S) ���� ������� - ������� ������� �� ������,
// ���� �� ������� - ������������ ����������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_REMOVECHILD_H__
#define __MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_REMOVECHILD_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/VirtualElementsFunctionBase.h"

namespace VirtualElementsFuncionsImpl {

class RemoveChild; // self forward Var
typedef ::Core::Var<RemoveChild> RemoveChild_var;
typedef ::Core::Var<const RemoveChild> RemoveChild_cvar;

class RemoveChild_factory;

// %S%f_remove_child(<��� ��������>) - ������� �������� �������� �� ������ ��������� - ���� �������
// � �������� ���'�� ����� ����� �������� �������� (%S) ���� ������� - ������� ������� �� ������,
// ���� �� ������� - ������������ ����������
class RemoveChild:
	virtual public VirtualElementsFunctionBase
{
	SET_OBJECT_COUNTER (RemoveChild)
	friend class RemoveChild_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	RemoveChild ();

	virtual ~RemoveChild ();

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
}; // class RemoveChild

} // namespace VirtualElementsFuncionsImpl


#endif //__MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_REMOVECHILD_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
