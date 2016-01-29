////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/impl/StrFunctionImpl/StringCmp.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::StrFunctionImpl::StringCmp
// ��������� ���������� ������ �������� ��� ��������� 
//
// ���������� ���������� ������� ���������� _string_cmp
// _string_cmp("<������1>","<������2>","<�������� ���������>") - ���������� ������1 �� �������2
// �������� �������� �������� (>,<,==, !=, >=, <=)
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_STRFUNCTIONIMPL_STRINGCMP_H__
#define __MDPROCESS_MDAMODEL_STRFUNCTIONIMPL_STRINGCMP_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/BaseFunctionImpl/InternalFunctionBase.h"

namespace StrFunctionImpl {

class StringCmp; // self forward Var
typedef ::Core::Var<StringCmp> StringCmp_var;
typedef ::Core::Var<const StringCmp> StringCmp_cvar;

class StringCmp_factory;

// ���������� ���������� ������� ���������� _string_cmp
// _string_cmp("<������1>","<������2>","<�������� ���������>") - ���������� ������1 �� �������2
// �������� �������� �������� (>,<,==, !=, >=, <=)
class StringCmp:
	virtual public BaseFunctionImpl::InternalFunctionBase
{
	SET_OBJECT_COUNTER (StringCmp)
	friend class StringCmp_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	StringCmp ();

	virtual ~StringCmp ();

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
}; // class StringCmp

} // namespace StrFunctionImpl


#endif //__MDPROCESS_MDAMODEL_STRFUNCTIONIMPL_STRINGCMP_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
