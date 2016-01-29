////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/impl/SystemFunctionsImpl/IsKindOf.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::SystemFunctionsImpl::IsKindOf
// ��������� ���������� ������ �������� ��� ��������� 
//
// _kind_of(�������, �����-�����) - ���������� true, ���� ����-����� ����������� �������
// ��������� ��� �������� ����������� �� �����-�����. ������ �������������:
// %f_kind_of(S,SimpleClass::Class)
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_SYSTEMFUNCTIONSIMPL_ISKINDOF_H__
#define __MDPROCESS_MDAMODEL_SYSTEMFUNCTIONSIMPL_ISKINDOF_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/BaseFunctionImpl/InternalFunctionBase.h"

namespace SystemFunctionsImpl {

class IsKindOf; // self forward Var
typedef ::Core::Var<IsKindOf> IsKindOf_var;
typedef ::Core::Var<const IsKindOf> IsKindOf_cvar;

class IsKindOf_factory;

// _kind_of(�������, �����-�����) - ���������� true, ���� ����-����� ����������� �������
// ��������� ��� �������� ����������� �� �����-�����. ������ �������������:
// %f_kind_of(S,SimpleClass::Class)
class IsKindOf:
	virtual public BaseFunctionImpl::InternalFunctionBase
{
	SET_OBJECT_COUNTER (IsKindOf)
	friend class IsKindOf_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	IsKindOf ();

	virtual ~IsKindOf ();

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from BaseFunctionImpl::InternalFunctionBase
	// ���������� ���������� ���������� �������. ������ ���������� ������� ��������� ��� �����
	virtual const std::string execute_impl (
		const TemplateFunctions::FunctionParams& params
		, TemplatePainter* painter
	) const /*throw (
		TemplateFunctions::BadParams
	)*/;
}; // class IsKindOf

} // namespace SystemFunctionsImpl


#endif //__MDPROCESS_MDAMODEL_SYSTEMFUNCTIONSIMPL_ISKINDOF_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
