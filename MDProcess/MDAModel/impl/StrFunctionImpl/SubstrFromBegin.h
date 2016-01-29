////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/impl/StrFunctionImpl/SubstrFromBegin.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::StrFunctionImpl::SubstrFromBegin
// ��������� ���������� ������ �������� ��� ��������� 
//
// ���������� ���������� ������� ���������� "_substr_from_begin"
// _substr_from_begin("<������>",n) - ���������� n �������� � ������ ������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_STRFUNCTIONIMPL_SUBSTRFROMBEGIN_H__
#define __MDPROCESS_MDAMODEL_STRFUNCTIONIMPL_SUBSTRFROMBEGIN_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/BaseFunctionImpl/InternalFunctionBase.h"

namespace StrFunctionImpl {

class SubstrFromBegin; // self forward Var
typedef ::Core::Var<SubstrFromBegin> SubstrFromBegin_var;
typedef ::Core::Var<const SubstrFromBegin> SubstrFromBegin_cvar;

class SubstrFromBegin_factory;

// ���������� ���������� ������� ���������� "_substr_from_begin"
// _substr_from_begin("<������>",n) - ���������� n �������� � ������ ������
class SubstrFromBegin:
	virtual public BaseFunctionImpl::InternalFunctionBase
{
	SET_OBJECT_COUNTER (SubstrFromBegin)
	friend class SubstrFromBegin_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	SubstrFromBegin ();

	virtual ~SubstrFromBegin ();

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
}; // class SubstrFromBegin

} // namespace StrFunctionImpl


#endif //__MDPROCESS_MDAMODEL_STRFUNCTIONIMPL_SUBSTRFROMBEGIN_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
