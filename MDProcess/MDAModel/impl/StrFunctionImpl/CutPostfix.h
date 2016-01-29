////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/impl/StrFunctionImpl/CutPostfix.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::StrFunctionImpl::CutPostfix
// ��������� ���������� ������ �������� ��� ��������� 
//
// ���������� ���������� ������� ���������� "_cut_postfix"
// _cut_postfix(<������>,<��������>) - ������� �������� � �������, ���� ��� �� ���� �������������.
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_STRFUNCTIONIMPL_CUTPOSTFIX_H__
#define __MDPROCESS_MDAMODEL_STRFUNCTIONIMPL_CUTPOSTFIX_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/BaseFunctionImpl/InternalFunctionBase.h"

namespace StrFunctionImpl {

class CutPostfix; // self forward Var
typedef ::Core::Var<CutPostfix> CutPostfix_var;
typedef ::Core::Var<const CutPostfix> CutPostfix_cvar;

class CutPostfix_factory;

// ���������� ���������� ������� ���������� "_cut_postfix"
// _cut_postfix(<������>,<��������>) - ������� �������� � �������, ���� ��� �� ���� �������������.
class CutPostfix:
	virtual public BaseFunctionImpl::InternalFunctionBase
{
	SET_OBJECT_COUNTER (CutPostfix)
	friend class CutPostfix_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	CutPostfix ();

	virtual ~CutPostfix ();

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
}; // class CutPostfix

} // namespace StrFunctionImpl


#endif //__MDPROCESS_MDAMODEL_STRFUNCTIONIMPL_CUTPOSTFIX_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
