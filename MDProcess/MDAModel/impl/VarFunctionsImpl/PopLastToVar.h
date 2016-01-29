////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/impl/VarFunctionsImpl/PopLastToVar.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VarFunctionsImpl::PopLastToVar
// ��������� ���������� ������ �������� ��� ��������� 
//
// ���������� ���������� ������� ���������� _pop_last_to_var.
// _pop_last_to_var(��������������, �������������� ����������) - �������� � ����������
// �������������� ���������� �������� ���������� ������� �� ������ (���������� _set_var), �
// ������� ��� (�� ������)
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_VARFUNCTIONSIMPL_POPLASTTOVAR_H__
#define __MDPROCESS_MDAMODEL_VARFUNCTIONSIMPL_POPLASTTOVAR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/ContainerOperationsImpl/ListOperationBaseImpl.h"

namespace VarFunctionsImpl {

class PopLastToVar; // self forward Var
typedef ::Core::Var<PopLastToVar> PopLastToVar_var;
typedef ::Core::Var<const PopLastToVar> PopLastToVar_cvar;

class PopLastToVar_factory;

// ���������� ���������� ������� ���������� _pop_last_to_var.
// _pop_last_to_var(��������������, �������������� ����������) - �������� � ����������
// �������������� ���������� �������� ���������� ������� �� ������ (���������� _set_var), �
// ������� ��� (�� ������)
class PopLastToVar:
	virtual public ContainerOperationsImpl::ListOperationBaseImpl
{
	SET_OBJECT_COUNTER (PopLastToVar)
	friend class PopLastToVar_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	PopLastToVar ();

	virtual ~PopLastToVar ();

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
}; // class PopLastToVar

} // namespace VarFunctionsImpl


#endif //__MDPROCESS_MDAMODEL_VARFUNCTIONSIMPL_POPLASTTOVAR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
