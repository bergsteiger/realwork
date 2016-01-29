////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/impl/StrFunctionImpl/Suffix_factory.h"
// ��������� ������������ ������ ��� ������ ����������� (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::StrFunctionImpl::Suffix
// �������� ���������� ������ ���������  ��� �������� Suffix
//
// ������ ������:
// %f_suffix(������,�������) - ���� ������ ������������� ��������� - ���������� �������, �����
// ���������� �������� ������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_STRFUNCTIONIMPL_SUFFIX_FCTR_H__
#define __MDPROCESS_MDAMODEL_STRFUNCTIONIMPL_SUFFIX_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/TemplateFunctions/TemplateFunctionsFactories.h"

namespace StrFunctionImpl {

/// Interface-factory implementation for Suffix
class Suffix_factory:
	virtual public ::Core::RefCountObjectBase
	, virtual public TemplateFunctions::InternalFunctionAbstractFactory
{
public:
	Suffix_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const std::string key () const;

	TemplateFunctions::InternalFunction* make ();

};

typedef ::Core::Var<Suffix_factory> Suffix_factory_var;

} // namespace StrFunctionImpl


#endif //__MDPROCESS_MDAMODEL_STRFUNCTIONIMPL_SUFFIX_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

