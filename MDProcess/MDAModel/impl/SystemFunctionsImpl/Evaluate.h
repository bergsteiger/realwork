////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/impl/SystemFunctionsImpl/Evaluate.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::SystemFunctionsImpl::Evaluate
// ��������� ���������� ������ �������� ��� ��������� 
//
// ���������� ���������� ������� ���������� _evaluate
// _evaluate(����. ���������) - ��������� ���. ��������� � ���������� ���������. ��������:
// %f_evaluate(2*2+10) - ����� 14.
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_SYSTEMFUNCTIONSIMPL_EVALUATE_H__
#define __MDPROCESS_MDAMODEL_SYSTEMFUNCTIONSIMPL_EVALUATE_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/BaseFunctionImpl/InternalFunctionBase.h"

namespace SystemFunctionsImpl {

class Evaluate; // self forward Var
typedef ::Core::Var<Evaluate> Evaluate_var;
typedef ::Core::Var<const Evaluate> Evaluate_cvar;

class Evaluate_factory;

// ���������� ���������� ������� ���������� _evaluate
// _evaluate(����. ���������) - ��������� ���. ��������� � ���������� ���������. ��������:
// %f_evaluate(2*2+10) - ����� 14.
class Evaluate:
	virtual public BaseFunctionImpl::InternalFunctionBase
{
	SET_OBJECT_COUNTER (Evaluate)
	friend class Evaluate_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	Evaluate ();

	virtual ~Evaluate ();

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
}; // class Evaluate

} // namespace SystemFunctionsImpl


#endif //__MDPROCESS_MDAMODEL_SYSTEMFUNCTIONSIMPL_EVALUATE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
