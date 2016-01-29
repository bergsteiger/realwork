////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/impl/StrFunctionImpl/ToWideStr.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::StrFunctionImpl::ToWideStr
// ��������� ���������� ������ �������� ��� ��������� 
//
// ���������� ���������� ������� ���������� "_to_wide_str"
// _to_wide_str (<������>, <�������>, <����������� ������>, <����������� ������>) - ��������������
// ������ � wide-����, ���� ����� ����������� ������ �� ���������� ������� ����������� � ASCI-
// ������� � ����������� ���������� ���������.
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_STRFUNCTIONIMPL_TOWIDESTR_H__
#define __MDPROCESS_MDAMODEL_STRFUNCTIONIMPL_TOWIDESTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/BaseFunctionImpl/InternalFunctionBase.h"

namespace StrFunctionImpl {

class ToWideStr; // self forward Var
typedef ::Core::Var<ToWideStr> ToWideStr_var;
typedef ::Core::Var<const ToWideStr> ToWideStr_cvar;

class ToWideStr_factory;

// ���������� ���������� ������� ���������� "_to_wide_str"
// _to_wide_str (<������>, <�������>, <����������� ������>, <����������� ������>) - ��������������
// ������ � wide-����, ���� ����� ����������� ������ �� ���������� ������� ����������� � ASCI-
// ������� � ����������� ���������� ���������.
class ToWideStr:
	virtual public BaseFunctionImpl::InternalFunctionBase
{
	SET_OBJECT_COUNTER (ToWideStr)
	friend class ToWideStr_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	ToWideStr ();

	virtual ~ToWideStr ();

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
}; // class ToWideStr

} // namespace StrFunctionImpl


#endif //__MDPROCESS_MDAMODEL_STRFUNCTIONIMPL_TOWIDESTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
