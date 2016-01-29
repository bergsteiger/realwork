////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/impl/VarFunctionsImpl/FindElement_factory.h"
// ��������� ������������ ������ ��� ������ ����������� (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VarFunctionsImpl::FindElement
// �������� ���������� ������ ���������  ��� �������� FindElement
//
// ���������� ���������� ������� ���������� _find_element.
// _find_element(��������������|����, ������������) - ������� ������� �� ����� ��� ��
// �������������� � ���������� ��� � ����������. ������ �������� ������� ���������������� ���
// ������������� ��������, ���� ������� � ����� ��������������� �� ��� ������, �� ��������
// ���������������� ��� ��� ��������, ������ ��� ����� ����������� � ������ ���� �� ���� ��
// �������� (��� ��������� ������). ���� � ���������� ������ �� ����� ������� ����� ������ ��������
// - ������������� ����������. ��������:
// {code}
// %S%f_find_element(%SU, SELF)  - ���������� SELF ���� ��������� �� ������� ������� (S)
// %S%f_set_var (A::B::attr, ATTR)  - ���������� ATTR ����� ��������� �� �������, �� ��������
// ������ ���� �� ���� ������������� �� "A::B::attr"
// {code}
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_VARFUNCTIONSIMPL_FINDELEMENT_FCTR_H__
#define __MDPROCESS_MDAMODEL_VARFUNCTIONSIMPL_FINDELEMENT_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/TemplateFunctions/TemplateFunctionsFactories.h"

namespace VarFunctionsImpl {

/// Interface-factory implementation for FindElement
class FindElement_factory:
	virtual public ::Core::RefCountObjectBase
	, virtual public TemplateFunctions::InternalFunctionAbstractFactory
{
public:
	FindElement_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const std::string key () const;

	TemplateFunctions::InternalFunction* make ();

};

typedef ::Core::Var<FindElement_factory> FindElement_factory_var;

} // namespace VarFunctionsImpl


#endif //__MDPROCESS_MDAMODEL_VARFUNCTIONSIMPL_FINDELEMENT_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

