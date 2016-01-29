////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/impl/SystemFunctionsImpl/HasNonEmptyGen.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::SystemFunctionsImpl::HasNonEmptyGen
// ��������� ���������� ������ �������� ��� ��������� 
//
// ���������� ���������� ������� ���������� _has_non_empty_gen
// _has_non_empty_gen(�������,����������) - ���������� true, ���� ������ ����� �� ������
// ���������, ����� ���������� false
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_SYSTEMFUNCTIONSIMPL_HASNONEMPTYGEN_H__
#define __MDPROCESS_MDAMODEL_SYSTEMFUNCTIONSIMPL_HASNONEMPTYGEN_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/BaseFunctionImpl/InternalFunctionBase.h"

namespace SystemFunctionsImpl {

class HasNonEmptyGen; // self forward Var
typedef ::Core::Var<HasNonEmptyGen> HasNonEmptyGen_var;
typedef ::Core::Var<const HasNonEmptyGen> HasNonEmptyGen_cvar;

class HasNonEmptyGen_factory;

// ���������� ���������� ������� ���������� _has_non_empty_gen
// _has_non_empty_gen(�������,����������) - ���������� true, ���� ������ ����� �� ������
// ���������, ����� ���������� false
class HasNonEmptyGen:
	virtual public BaseFunctionImpl::InternalFunctionBase
{
	SET_OBJECT_COUNTER (HasNonEmptyGen)
	friend class HasNonEmptyGen_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	HasNonEmptyGen ();

	virtual ~HasNonEmptyGen ();

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
}; // class HasNonEmptyGen

} // namespace SystemFunctionsImpl


#endif //__MDPROCESS_MDAMODEL_SYSTEMFUNCTIONSIMPL_HASNONEMPTYGEN_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
