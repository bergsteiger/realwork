////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/impl/VarFunctionsImpl/PopFirstToVar.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VarFunctionsImpl::PopFirstToVar
// ��������� ���������� ������ �������� ��� ��������� 
//
// ���������� ���������� ������� ����������  _pop_first_to_var.
// _pop_first_to_var(��������������, �������������� ����������) - �������� � ����������
// �������������� ���������� �������� ������ ������� �� ������ (���������� _set_var), � �������
// ��� (�� ������)
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_VARFUNCTIONSIMPL_POPFIRSTTOVAR_H__
#define __MDPROCESS_MDAMODEL_VARFUNCTIONSIMPL_POPFIRSTTOVAR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/ContainerOperationsImpl/ListOperationBaseImpl.h"

namespace VarFunctionsImpl {

class PopFirstToVar; // self forward Var
typedef ::Core::Var<PopFirstToVar> PopFirstToVar_var;
typedef ::Core::Var<const PopFirstToVar> PopFirstToVar_cvar;

class PopFirstToVar_factory;

// ���������� ���������� ������� ����������  _pop_first_to_var.
// _pop_first_to_var(��������������, �������������� ����������) - �������� � ����������
// �������������� ���������� �������� ������ ������� �� ������ (���������� _set_var), � �������
// ��� (�� ������)
class PopFirstToVar:
	virtual public ContainerOperationsImpl::ListOperationBaseImpl
{
	SET_OBJECT_COUNTER (PopFirstToVar)
	friend class PopFirstToVar_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	PopFirstToVar ();

	virtual ~PopFirstToVar ();

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
}; // class PopFirstToVar

} // namespace VarFunctionsImpl


#endif //__MDPROCESS_MDAMODEL_VARFUNCTIONSIMPL_POPFIRSTTOVAR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
