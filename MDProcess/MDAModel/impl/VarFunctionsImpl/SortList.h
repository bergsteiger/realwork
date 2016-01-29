////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/impl/VarFunctionsImpl/SortList.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VarFunctionsImpl::SortList
// ��������� ���������� ������ �������� ��� ��������� 
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
#ifndef __MDPROCESS_MDAMODEL_VARFUNCTIONSIMPL_SORTLIST_H__
#define __MDPROCESS_MDAMODEL_VARFUNCTIONSIMPL_SORTLIST_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/ContainerOperationsImpl/ListOperationBaseImpl.h"

namespace VarFunctionsImpl {

class SortList; // self forward Var
typedef ::Core::Var<SortList> SortList_var;
typedef ::Core::Var<const SortList> SortList_cvar;

class SortList_factory;

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
class SortList:
	virtual public ContainerOperationsImpl::ListOperationBaseImpl
{
	SET_OBJECT_COUNTER (SortList)
	friend class SortList_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	SortList ();

	virtual ~SortList ();

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
}; // class SortList

} // namespace VarFunctionsImpl


#endif //__MDPROCESS_MDAMODEL_VARFUNCTIONSIMPL_SORTLIST_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
