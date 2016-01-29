////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/SetDocumentation.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VirtualElementsFuncionsImpl::SetDocumentation
// ��������� ���������� ������ �������� ��� ��������� 
//
// %S%f_set_documentation(<������������>) - ������������� ������������ ��� ��������. ���������
// ������ � ����������� ���������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_SETDOCUMENTATION_H__
#define __MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_SETDOCUMENTATION_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/VirtualElementsFunctionBase.h"

namespace VirtualElementsFuncionsImpl {

class SetDocumentation; // self forward Var
typedef ::Core::Var<SetDocumentation> SetDocumentation_var;
typedef ::Core::Var<const SetDocumentation> SetDocumentation_cvar;

class SetDocumentation_factory;

// %S%f_set_documentation(<������������>) - ������������� ������������ ��� ��������. ���������
// ������ � ����������� ���������
class SetDocumentation:
	virtual public VirtualElementsFunctionBase
{
	SET_OBJECT_COUNTER (SetDocumentation)
	friend class SetDocumentation_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	SetDocumentation ();

	virtual ~SetDocumentation ();

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
}; // class SetDocumentation

} // namespace VirtualElementsFuncionsImpl


#endif //__MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_SETDOCUMENTATION_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
