////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/impl/StereotypeFunctionsImpl/RemoveFromList_factory.cpp"
// ��������� ������ ���������� ��� ������ ����������� (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::StereotypeFunctionsImpl::RemoveFromList
//
// %S%f_remove_from_list (���������) - ��������� � ������ c �������� ��������������� �������
// (����� ���� ������� ������ ��� ������).
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/StereotypeFunctionsImpl/RemoveFromList_factory.h"
#include "MDProcess/MDAModel/impl/StereotypeFunctionsImpl/RemoveFromList.h"

namespace StereotypeFunctionsImpl {

RemoveFromList_factory::RemoveFromList_factory () {
}

void RemoveFromList_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	TemplateFunctions::InternalStereotypeFunctionFactoryManager::register_factory (this, priority);
}

const std::string RemoveFromList_factory::key () const {
	return "_remove_from_list";
}

TemplateFunctions::InternalStereotypeFunction* RemoveFromList_factory::make () {
	RemoveFromList_var ret = new RemoveFromList ();
	return ret._retn ();
}

} // namespace StereotypeFunctionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

