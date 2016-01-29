////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/impl/SystemFunctionsImpl/Exec.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::SystemFunctionsImpl::Exec
// ��������� ���������� ������ �������� ��� ��������� 
//
// %f_exec(���� �������, ������� ����� ����������) - ��������� ��� �������. ������:
// {code}
// %f_exec(%SN)
// 
// //���� �����:
// %f_set_var(CODE,"\%SN")\
// %f_exec(%{CODE}N)
// {code}
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_SYSTEMFUNCTIONSIMPL_EXEC_H__
#define __MDPROCESS_MDAMODEL_SYSTEMFUNCTIONSIMPL_EXEC_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/BaseFunctionImpl/InternalFunctionBase.h"

namespace SystemFunctionsImpl {

class Exec; // self forward Var
typedef ::Core::Var<Exec> Exec_var;
typedef ::Core::Var<const Exec> Exec_cvar;

class Exec_factory;

// %f_exec(���� �������, ������� ����� ����������) - ��������� ��� �������. ������:
// {code}
// %f_exec(%SN)
// 
// //���� �����:
// %f_set_var(CODE,"\%SN")\
// %f_exec(%{CODE}N)
// {code}
class Exec:
	virtual public BaseFunctionImpl::InternalFunctionBase
{
	SET_OBJECT_COUNTER (Exec)
	friend class Exec_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	Exec ();

	virtual ~Exec ();

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
}; // class Exec

} // namespace SystemFunctionsImpl


#endif //__MDPROCESS_MDAMODEL_SYSTEMFUNCTIONSIMPL_EXEC_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
