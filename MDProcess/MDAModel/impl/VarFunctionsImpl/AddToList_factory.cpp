////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/impl/VarFunctionsImpl/AddToList_factory.cpp"
// ��������� ������ ���������� ��� ������ ����������� (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VarFunctionsImpl::AddToList
//
// ���������� ���������� ������� ���������� _add_to_list.
// _add_to_list (��������������, ���������) - ��������� � ������ c �������� ���������������
// ������� (����� ���� ������� ������ ��� ������).
// %f_add_to_list (LIST, S)
// %f_add_to_list (LIST, "test str")
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/VarFunctionsImpl/AddToList_factory.h"
#include "MDProcess/MDAModel/impl/VarFunctionsImpl/AddToList.h"

namespace VarFunctionsImpl {

AddToList_factory::AddToList_factory () {
}

void AddToList_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	TemplateFunctions::InternalFunctionFactoryManager::register_factory (this, priority);
}

const std::string AddToList_factory::key () const {
	return "_add_to_list";
}

TemplateFunctions::InternalFunction* AddToList_factory::make () {
	AddToList_var ret = new AddToList ();
	return ret._retn ();
}

} // namespace VarFunctionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

