////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/impl/StrFunctionImpl/StrSplit.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::StrFunctionImpl::StrSplit
// ��������� ���������� ������ �������� ��� ��������� 
//
// ���������� ���������� ������� ���������� "_str_split".
// _str_split ("<������>","<�������>","<�����������>") - ��������� ������ �� n-����� � ��������
// ��������� � ������������ (������ ����� ����� ���� ��� ����� ������ � ����������)
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_STRFUNCTIONIMPL_STRSPLIT_H__
#define __MDPROCESS_MDAMODEL_STRFUNCTIONIMPL_STRSPLIT_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/BaseFunctionImpl/InternalFunctionBase.h"

namespace StrFunctionImpl {

class StrSplit; // self forward Var
typedef ::Core::Var<StrSplit> StrSplit_var;
typedef ::Core::Var<const StrSplit> StrSplit_cvar;

class StrSplit_factory;

// ���������� ���������� ������� ���������� "_str_split".
// _str_split ("<������>","<�������>","<�����������>") - ��������� ������ �� n-����� � ��������
// ��������� � ������������ (������ ����� ����� ���� ��� ����� ������ � ����������)
class StrSplit:
	virtual public BaseFunctionImpl::InternalFunctionBase
{
	SET_OBJECT_COUNTER (StrSplit)
	friend class StrSplit_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	StrSplit ();

	virtual ~StrSplit ();

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
}; // class StrSplit

} // namespace StrFunctionImpl


#endif //__MDPROCESS_MDAMODEL_STRFUNCTIONIMPL_STRSPLIT_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
