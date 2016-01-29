////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/SetImplementSelectType.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VirtualElementsFuncionsImpl::SetImplementSelectType
// ��������� ���������� ������ �������� ��� ��������� 
//
// %S%f_set_implement_select_type(all|include|exclude) - ������������� ��� ��������� ���
// ����������� �������� ������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_SETIMPLEMENTSELECTTYPE_H__
#define __MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_SETIMPLEMENTSELECTTYPE_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/VirtualElementsFunctionBase.h"

namespace VirtualElementsFuncionsImpl {

class SetImplementSelectType; // self forward Var
typedef ::Core::Var<SetImplementSelectType> SetImplementSelectType_var;
typedef ::Core::Var<const SetImplementSelectType> SetImplementSelectType_cvar;

class SetImplementSelectType_factory;

// %S%f_set_implement_select_type(all|include|exclude) - ������������� ��� ��������� ���
// ����������� �������� ������
class SetImplementSelectType:
	virtual public VirtualElementsFunctionBase
{
	SET_OBJECT_COUNTER (SetImplementSelectType)
	friend class SetImplementSelectType_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	SetImplementSelectType ();

	virtual ~SetImplementSelectType ();

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
}; // class SetImplementSelectType

} // namespace VirtualElementsFuncionsImpl


#endif //__MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_SETIMPLEMENTSELECTTYPE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
