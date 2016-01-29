////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/impl/VarFunctionsImpl/SortList_factory.cpp"
// ��������� ������ ���������� ��� ������ ����������� (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VarFunctionsImpl::SortList
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
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/VarFunctionsImpl/SortList_factory.h"
#include "MDProcess/MDAModel/impl/VarFunctionsImpl/SortList.h"

namespace VarFunctionsImpl {

SortList_factory::SortList_factory () {
}

void SortList_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	TemplateFunctions::InternalFunctionFactoryManager::register_factory (this, priority);
}

const std::string SortList_factory::key () const {
	return "_sort_list";
}

TemplateFunctions::InternalFunction* SortList_factory::make () {
	SortList_var ret = new SortList ();
	return ret._retn ();
}

} // namespace VarFunctionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

