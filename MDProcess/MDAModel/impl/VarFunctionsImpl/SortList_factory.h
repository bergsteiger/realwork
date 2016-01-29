////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/impl/VarFunctionsImpl/SortList_factory.h"
// ��������� ������������ ������ ��� ������ ����������� (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VarFunctionsImpl::SortList
// �������� ���������� ������ ���������  ��� �������� SortList
//
// ���������� ���������� ������� ���������� _sort_list
// _sort_list(��������������, ���� ����������) - ��������� ������ � ������������ � �������� �����
// ����������. ���������� ����:
// - n - �� �����
// - g - �� ����� �� ������
// - p - ���� ��� �� �����, �� �������������� �� ��������
// - u - �� ������������� (���������� �������������� �� ��������� ��������� � ����� �����������)
// - k - ���������, ��� � �������� ������ ���������� ����� ������������ ������� ������
// (������������� ������ ����������� ��� 3-� ��������: %f_sort_list(LIST,k,KEY_LIST))
// - ���� ������ �������� �������� � �������, �� ���������, ��� ��� ������� ���������� �� �����
// ������� �, ��� ���������� ������ ����� ��������� ���� ��������� ����������� ���������� ����
// ������� ������� �� ��������� ������.
// 
// ������ �������������:
// %f_add_to_list(LIST,"B")\
// %f_add_to_list(LIST,"C")\
// %f_add_to_list(LIST,"A")\
// %f_add_to_list(LIST,"D")\
// %f_sort_list(LIST,n)\
// // � ���������� �������� � ������ ���������� � �������: A, B, C, D
// 
// ����������, ����� ������������� ������, ��������� ������� �������:
// %f_sort_list(LIST,"%SN")
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_VARFUNCTIONSIMPL_SORTLIST_FCTR_H__
#define __MDPROCESS_MDAMODEL_VARFUNCTIONSIMPL_SORTLIST_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/TemplateFunctions/TemplateFunctionsFactories.h"

namespace VarFunctionsImpl {

/// Interface-factory implementation for SortList
class SortList_factory:
	virtual public ::Core::RefCountObjectBase
	, virtual public TemplateFunctions::InternalFunctionAbstractFactory
{
public:
	SortList_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const std::string key () const;

	TemplateFunctions::InternalFunction* make ();

};

typedef ::Core::Var<SortList_factory> SortList_factory_var;

} // namespace VarFunctionsImpl


#endif //__MDPROCESS_MDAMODEL_VARFUNCTIONSIMPL_SORTLIST_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

