////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/SetOverloadSelectType.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VirtualElementsFuncionsImpl::SetOverloadSelectType
// ��������� ���������� ������ �������� ��� ��������� 
//
// %S%f_set_overload_select_type(all|include|exclude) - ������������� ��� ��������� ���
// ���������������� �������� ������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_SETOVERLOADSELECTTYPE_H__
#define __MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_SETOVERLOADSELECTTYPE_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/VirtualElementsFunctionBase.h"

namespace VirtualElementsFuncionsImpl {

class SetOverloadSelectType; // self forward Var
typedef ::Core::Var<SetOverloadSelectType> SetOverloadSelectType_var;
typedef ::Core::Var<const SetOverloadSelectType> SetOverloadSelectType_cvar;

class SetOverloadSelectType_factory;

// %S%f_set_overload_select_type(all|include|exclude) - ������������� ��� ��������� ���
// ���������������� �������� ������
class SetOverloadSelectType:
	virtual public VirtualElementsFunctionBase
{
	SET_OBJECT_COUNTER (SetOverloadSelectType)
	friend class SetOverloadSelectType_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	SetOverloadSelectType ();

	virtual ~SetOverloadSelectType ();

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
}; // class SetOverloadSelectType

} // namespace VirtualElementsFuncionsImpl


#endif //__MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_SETOVERLOADSELECTTYPE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
