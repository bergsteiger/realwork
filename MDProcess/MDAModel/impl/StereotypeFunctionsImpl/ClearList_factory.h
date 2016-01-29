////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/impl/StereotypeFunctionsImpl/ClearList_factory.h"
// ��������� ������������ ������ ��� ������ ����������� (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::StereotypeFunctionsImpl::ClearList
// �������� ���������� ������ ���������  ��� �������� ClearList
//
// %S%f_clear_list(LIST_ID) - ������� ��������� ������ � ��������������� LIST_ID, ���� � %S �� ����
// ������� ���������� ���� ������ � ����� ���������������, ������ ��������� � �����������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_STEREOTYPEFUNCTIONSIMPL_CLEARLIST_FCTR_H__
#define __MDPROCESS_MDAMODEL_STEREOTYPEFUNCTIONSIMPL_CLEARLIST_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/TemplateFunctions/TemplateFunctionsFactories.h"

namespace StereotypeFunctionsImpl {

/// Interface-factory implementation for ClearList
class ClearList_factory:
	virtual public ::Core::RefCountObjectBase
	, virtual public TemplateFunctions::InternalStereotypeFunctionAbstractFactory
{
public:
	ClearList_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const std::string key () const;

	TemplateFunctions::InternalStereotypeFunction* make ();

};

typedef ::Core::Var<ClearList_factory> ClearList_factory_var;

} // namespace StereotypeFunctionsImpl


#endif //__MDPROCESS_MDAMODEL_STEREOTYPEFUNCTIONSIMPL_CLEARLIST_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

