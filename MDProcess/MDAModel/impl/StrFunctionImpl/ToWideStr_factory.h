////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/impl/StrFunctionImpl/ToWideStr_factory.h"
// ��������� ������������ ������ ��� ������ ����������� (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::StrFunctionImpl::ToWideStr
// �������� ���������� ������ ���������  ��� �������� ToWideStr
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
#ifndef __MDPROCESS_MDAMODEL_STRFUNCTIONIMPL_TOWIDESTR_FCTR_H__
#define __MDPROCESS_MDAMODEL_STRFUNCTIONIMPL_TOWIDESTR_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/TemplateFunctions/TemplateFunctionsFactories.h"

namespace StrFunctionImpl {

/// Interface-factory implementation for ToWideStr
class ToWideStr_factory:
	virtual public ::Core::RefCountObjectBase
	, virtual public TemplateFunctions::InternalFunctionAbstractFactory
{
public:
	ToWideStr_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const std::string key () const;

	TemplateFunctions::InternalFunction* make ();

};

typedef ::Core::Var<ToWideStr_factory> ToWideStr_factory_var;

} // namespace StrFunctionImpl


#endif //__MDPROCESS_MDAMODEL_STRFUNCTIONIMPL_TOWIDESTR_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

