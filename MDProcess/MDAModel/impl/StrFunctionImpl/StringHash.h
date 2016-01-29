////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/impl/StrFunctionImpl/StringHash.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::StrFunctionImpl::StringHash
// ��������� ���������� ������ �������� ��� ��������� 
//
// ���������� ���������� ������� ���������� "_string_hash"
// _string_hash("<������>") - ��� ���������� ������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_STRFUNCTIONIMPL_STRINGHASH_H__
#define __MDPROCESS_MDAMODEL_STRFUNCTIONIMPL_STRINGHASH_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/BaseFunctionImpl/InternalFunctionBase.h"

namespace StrFunctionImpl {

class StringHash; // self forward Var
typedef ::Core::Var<StringHash> StringHash_var;
typedef ::Core::Var<const StringHash> StringHash_cvar;

class StringHash_factory;

// ���������� ���������� ������� ���������� "_string_hash"
// _string_hash("<������>") - ��� ���������� ������
class StringHash:
	virtual public BaseFunctionImpl::InternalFunctionBase
{
	SET_OBJECT_COUNTER (StringHash)
	friend class StringHash_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	StringHash ();

	virtual ~StringHash ();

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
}; // class StringHash

} // namespace StrFunctionImpl


#endif //__MDPROCESS_MDAMODEL_STRFUNCTIONIMPL_STRINGHASH_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
