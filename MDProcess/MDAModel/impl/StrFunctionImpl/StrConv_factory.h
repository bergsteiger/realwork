////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/impl/StrFunctionImpl/StrConv_factory.h"
// ��������� ������������ ������ ��� ������ ����������� (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::StrFunctionImpl::StrConv
// �������� ���������� ������ ���������  ��� �������� StrConv
//
// ���������� ���������� ������� ���������� "_str_conv".
// _str_conv ("<������>","<������ �������� �������>","<������ ��������� �������>") - ������������
// ������ �� ������ ������� � ������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_STRFUNCTIONIMPL_STRCONV_FCTR_H__
#define __MDPROCESS_MDAMODEL_STRFUNCTIONIMPL_STRCONV_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/TemplateFunctions/TemplateFunctionsFactories.h"

namespace StrFunctionImpl {

/// Interface-factory implementation for StrConv
class StrConv_factory:
	virtual public ::Core::RefCountObjectBase
	, virtual public TemplateFunctions::InternalFunctionAbstractFactory
{
public:
	StrConv_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const std::string key () const;

	TemplateFunctions::InternalFunction* make ();

};

typedef ::Core::Var<StrConv_factory> StrConv_factory_var;

} // namespace StrFunctionImpl


#endif //__MDPROCESS_MDAMODEL_STRFUNCTIONIMPL_STRCONV_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

