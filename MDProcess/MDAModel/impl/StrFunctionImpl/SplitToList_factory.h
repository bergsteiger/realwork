////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/impl/StrFunctionImpl/SplitToList_factory.h"
// ��������� ������������ ������ ��� ������ ����������� (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::StrFunctionImpl::SplitToList
// �������� ���������� ������ ���������  ��� �������� SplitToList
//
// ���������� ���������� ������� ���������� _split_to_list
// _split_to_list (��������������, �������, �������������) - ��������� ������ �� ������������,
// ��������� ���������� � ������ c �������� ���������������.  ��������:
// %f_split_to_list(ROOT_RELATIVE_PATH,%Sd,/) - ��������� ��������� %Sd �� ������������ /, �������
// �������� � ������ ROOT_RELATIVE_PATH
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_STRFUNCTIONIMPL_SPLITTOLIST_FCTR_H__
#define __MDPROCESS_MDAMODEL_STRFUNCTIONIMPL_SPLITTOLIST_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/TemplateFunctions/TemplateFunctionsFactories.h"

namespace StrFunctionImpl {

/// Interface-factory implementation for SplitToList
class SplitToList_factory:
	virtual public ::Core::RefCountObjectBase
	, virtual public TemplateFunctions::InternalFunctionAbstractFactory
{
public:
	SplitToList_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const std::string key () const;

	TemplateFunctions::InternalFunction* make ();

};

typedef ::Core::Var<SplitToList_factory> SplitToList_factory_var;

} // namespace StrFunctionImpl


#endif //__MDPROCESS_MDAMODEL_STRFUNCTIONIMPL_SPLITTOLIST_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

