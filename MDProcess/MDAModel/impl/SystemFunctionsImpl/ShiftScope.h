////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/impl/SystemFunctionsImpl/ShiftScope.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::SystemFunctionsImpl::ShiftScope
// ��������� ���������� ������ �������� ��� ��������� 
//
// ���������� ���������� ������� ���������� "_shift_scope".
// _shift_scope(true/false) - ������������� ���� - ����� �� �������� scope �� ���� �������.
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_SYSTEMFUNCTIONSIMPL_SHIFTSCOPE_H__
#define __MDPROCESS_MDAMODEL_SYSTEMFUNCTIONSIMPL_SHIFTSCOPE_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/BaseFunctionImpl/InternalFunctionBase.h"

namespace SystemFunctionsImpl {

class ShiftScope; // self forward Var
typedef ::Core::Var<ShiftScope> ShiftScope_var;
typedef ::Core::Var<const ShiftScope> ShiftScope_cvar;

class ShiftScope_factory;

// ���������� ���������� ������� ���������� "_shift_scope".
// _shift_scope(true/false) - ������������� ���� - ����� �� �������� scope �� ���� �������.
class ShiftScope:
	virtual public BaseFunctionImpl::InternalFunctionBase
{
	SET_OBJECT_COUNTER (ShiftScope)
	friend class ShiftScope_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	ShiftScope ();

	virtual ~ShiftScope ();

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
}; // class ShiftScope

} // namespace SystemFunctionsImpl


#endif //__MDPROCESS_MDAMODEL_SYSTEMFUNCTIONSIMPL_SHIFTSCOPE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
