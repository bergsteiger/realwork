////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/impl/SystemFunctionsImpl/NumberCmp.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::SystemFunctionsImpl::NumberCmp
// ��������� ���������� ������ �������� ��� ��������� 
//
// ���������� ���������� ������� ���������� _number_cmp
// _number_cmp("<������1>","<������2>","<�������� ���������>") - ���������� ��� ����� ������1 ��
// �������2 �������� �������� �������� (>,<,==, !=, >=, <=). ���� ��������� ��������� - ������,
// ���������� 1, � ��������� ������ 0.
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_SYSTEMFUNCTIONSIMPL_NUMBERCMP_H__
#define __MDPROCESS_MDAMODEL_SYSTEMFUNCTIONSIMPL_NUMBERCMP_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/BaseFunctionImpl/InternalFunctionBase.h"

namespace SystemFunctionsImpl {

class NumberCmp; // self forward Var
typedef ::Core::Var<NumberCmp> NumberCmp_var;
typedef ::Core::Var<const NumberCmp> NumberCmp_cvar;

class NumberCmp_factory;

// ���������� ���������� ������� ���������� _number_cmp
// _number_cmp("<������1>","<������2>","<�������� ���������>") - ���������� ��� ����� ������1 ��
// �������2 �������� �������� �������� (>,<,==, !=, >=, <=). ���� ��������� ��������� - ������,
// ���������� 1, � ��������� ������ 0.
class NumberCmp:
	virtual public BaseFunctionImpl::InternalFunctionBase
{
	SET_OBJECT_COUNTER (NumberCmp)
	friend class NumberCmp_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	NumberCmp ();

	virtual ~NumberCmp ();

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
}; // class NumberCmp

} // namespace SystemFunctionsImpl


#endif //__MDPROCESS_MDAMODEL_SYSTEMFUNCTIONSIMPL_NUMBERCMP_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
