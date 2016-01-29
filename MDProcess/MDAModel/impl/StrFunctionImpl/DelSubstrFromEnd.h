////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/impl/StrFunctionImpl/DelSubstrFromEnd.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::StrFunctionImpl::DelSubstrFromEnd
// ��������� ���������� ������ �������� ��� ��������� 
//
// ���������� ���������� ������� ���������� "_delsubstr_from_end"
// _delsubstr_from_end("<������>",n) - ������� n �������� � ����� ������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_STRFUNCTIONIMPL_DELSUBSTRFROMEND_H__
#define __MDPROCESS_MDAMODEL_STRFUNCTIONIMPL_DELSUBSTRFROMEND_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/BaseFunctionImpl/InternalFunctionBase.h"

namespace StrFunctionImpl {

class DelSubstrFromEnd; // self forward Var
typedef ::Core::Var<DelSubstrFromEnd> DelSubstrFromEnd_var;
typedef ::Core::Var<const DelSubstrFromEnd> DelSubstrFromEnd_cvar;

class DelSubstrFromEnd_factory;

// ���������� ���������� ������� ���������� "_delsubstr_from_end"
// _delsubstr_from_end("<������>",n) - ������� n �������� � ����� ������
class DelSubstrFromEnd:
	virtual public BaseFunctionImpl::InternalFunctionBase
{
	SET_OBJECT_COUNTER (DelSubstrFromEnd)
	friend class DelSubstrFromEnd_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	DelSubstrFromEnd ();

	virtual ~DelSubstrFromEnd ();

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
}; // class DelSubstrFromEnd

} // namespace StrFunctionImpl


#endif //__MDPROCESS_MDAMODEL_STRFUNCTIONIMPL_DELSUBSTRFROMEND_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
