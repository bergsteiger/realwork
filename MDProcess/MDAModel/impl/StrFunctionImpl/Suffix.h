////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/impl/StrFunctionImpl/Suffix.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::StrFunctionImpl::Suffix
// ��������� ���������� ������ �������� ��� ��������� 
//
// ������ ������:
// %f_suffix(������,�������) - ���� ������ ������������� ��������� - ���������� �������, �����
// ���������� �������� ������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_STRFUNCTIONIMPL_SUFFIX_H__
#define __MDPROCESS_MDAMODEL_STRFUNCTIONIMPL_SUFFIX_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/BaseFunctionImpl/InternalFunctionBase.h"

namespace StrFunctionImpl {

class Suffix; // self forward Var
typedef ::Core::Var<Suffix> Suffix_var;
typedef ::Core::Var<const Suffix> Suffix_cvar;

class Suffix_factory;

// ������ ������:
// %f_suffix(������,�������) - ���� ������ ������������� ��������� - ���������� �������, �����
// ���������� �������� ������
class Suffix:
	virtual public BaseFunctionImpl::InternalFunctionBase
{
	SET_OBJECT_COUNTER (Suffix)
	friend class Suffix_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	Suffix ();

	virtual ~Suffix ();

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
}; // class Suffix

} // namespace StrFunctionImpl


#endif //__MDPROCESS_MDAMODEL_STRFUNCTIONIMPL_SUFFIX_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
