////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/impl/VarFunctionsImpl/ClearList_factory.cpp"
// ��������� ������ ���������� ��� ������ ����������� (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VarFunctionsImpl::ClearList
//
// ���������� ���������� ������� ���������� _clear_list.
// _clear_list (�������������) - ������� ������ � �������� ���������������.
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/VarFunctionsImpl/ClearList_factory.h"
#include "MDProcess/MDAModel/impl/VarFunctionsImpl/ClearList.h"

namespace VarFunctionsImpl {

ClearList_factory::ClearList_factory () {
}

void ClearList_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	TemplateFunctions::InternalFunctionFactoryManager::register_factory (this, priority);
}

const std::string ClearList_factory::key () const {
	return "_clear_list";
}

TemplateFunctions::InternalFunction* ClearList_factory::make () {
	ClearList_var ret = new ClearList ();
	return ret._retn ();
}

} // namespace VarFunctionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

