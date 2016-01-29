////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/impl/VarFunctionsImpl/DelVar.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VarFunctionsImpl::DelVar
// ��������� ���������� ������ �������� ��� ��������� 
//
// ���������� ���������� ������� ���������� _del_var.
// _del_var (��������������) - ������� ���������� ���������� (������� ��������� ������������)
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_VARFUNCTIONSIMPL_DELVAR_H__
#define __MDPROCESS_MDAMODEL_VARFUNCTIONSIMPL_DELVAR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/BaseFunctionImpl/InternalFunctionBase.h"

namespace VarFunctionsImpl {

class DelVar; // self forward Var
typedef ::Core::Var<DelVar> DelVar_var;
typedef ::Core::Var<const DelVar> DelVar_cvar;

class DelVar_factory;

// ���������� ���������� ������� ���������� _del_var.
// _del_var (��������������) - ������� ���������� ���������� (������� ��������� ������������)
class DelVar:
	virtual public BaseFunctionImpl::InternalFunctionBase
{
	SET_OBJECT_COUNTER (DelVar)
	friend class DelVar_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	DelVar ();

	virtual ~DelVar ();

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
}; // class DelVar

} // namespace VarFunctionsImpl


#endif //__MDPROCESS_MDAMODEL_VARFUNCTIONSIMPL_DELVAR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
