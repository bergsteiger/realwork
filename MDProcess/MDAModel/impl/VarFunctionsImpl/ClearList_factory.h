////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/impl/VarFunctionsImpl/ClearList_factory.h"
// ��������� ������������ ������ ��� ������ ����������� (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VarFunctionsImpl::ClearList
// �������� ���������� ������ ���������  ��� �������� ClearList
//
// ���������� ���������� ������� ���������� _clear_list.
// _clear_list (�������������) - ������� ������ � �������� ���������������.
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_VARFUNCTIONSIMPL_CLEARLIST_FCTR_H__
#define __MDPROCESS_MDAMODEL_VARFUNCTIONSIMPL_CLEARLIST_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/TemplateFunctions/TemplateFunctionsFactories.h"

namespace VarFunctionsImpl {

/// Interface-factory implementation for ClearList
class ClearList_factory:
	virtual public ::Core::RefCountObjectBase
	, virtual public TemplateFunctions::InternalFunctionAbstractFactory
{
public:
	ClearList_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const std::string key () const;

	TemplateFunctions::InternalFunction* make ();

};

typedef ::Core::Var<ClearList_factory> ClearList_factory_var;

} // namespace VarFunctionsImpl


#endif //__MDPROCESS_MDAMODEL_VARFUNCTIONSIMPL_CLEARLIST_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

