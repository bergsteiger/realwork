////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/impl/StrFunctionImpl/StringFind.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::StrFunctionImpl::StringFind
// ��������� ���������� ������ �������� ��� ��������� 
//
// ���������� ���������� ������� ���������� _string_find
// _string_find(�������,����������) - ���� ��������� � ������, ���������� ��������� �������, ����
// ��������� �� ������� - ���������� -1
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_STRFUNCTIONIMPL_STRINGFIND_H__
#define __MDPROCESS_MDAMODEL_STRFUNCTIONIMPL_STRINGFIND_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/BaseFunctionImpl/InternalFunctionBase.h"

namespace StrFunctionImpl {

class StringFind; // self forward Var
typedef ::Core::Var<StringFind> StringFind_var;
typedef ::Core::Var<const StringFind> StringFind_cvar;

class StringFind_factory;

// ���������� ���������� ������� ���������� _string_find
// _string_find(�������,����������) - ���� ��������� � ������, ���������� ��������� �������, ����
// ��������� �� ������� - ���������� -1
class StringFind:
	virtual public BaseFunctionImpl::InternalFunctionBase
{
	SET_OBJECT_COUNTER (StringFind)
	friend class StringFind_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	StringFind ();

	virtual ~StringFind ();

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
}; // class StringFind

} // namespace StrFunctionImpl


#endif //__MDPROCESS_MDAMODEL_STRFUNCTIONIMPL_STRINGFIND_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
