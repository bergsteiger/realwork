////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/impl/StrFunctionImpl/Prefix.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::StrFunctionImpl::Prefix
// ��������� ���������� ������ �������� ��� ��������� 
//
// ������ ������:
// %f_prefix(������,�������) - ���� ������ ���������� � �������� - ���������� �������, �����
// ���������� �������� ������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_STRFUNCTIONIMPL_PREFIX_H__
#define __MDPROCESS_MDAMODEL_STRFUNCTIONIMPL_PREFIX_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/BaseFunctionImpl/InternalFunctionBase.h"

namespace StrFunctionImpl {

class Prefix; // self forward Var
typedef ::Core::Var<Prefix> Prefix_var;
typedef ::Core::Var<const Prefix> Prefix_cvar;

class Prefix_factory;

// ������ ������:
// %f_prefix(������,�������) - ���� ������ ���������� � �������� - ���������� �������, �����
// ���������� �������� ������
class Prefix:
	virtual public BaseFunctionImpl::InternalFunctionBase
{
	SET_OBJECT_COUNTER (Prefix)
	friend class Prefix_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	Prefix ();

	virtual ~Prefix ();

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
}; // class Prefix

} // namespace StrFunctionImpl


#endif //__MDPROCESS_MDAMODEL_STRFUNCTIONIMPL_PREFIX_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
