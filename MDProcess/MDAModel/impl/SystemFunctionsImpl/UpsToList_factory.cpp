////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/impl/SystemFunctionsImpl/UpsToList_factory.cpp"
// ��������� ������ ���������� ��� ������ ����������� (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::SystemFunctionsImpl::UpsToList
//
// ���������� ���������� ������� ���������� _ups_to_list.
// _ups_to_list (��������, ��������������) - ��������� � ������ c �������� ���������������
// ���������������� ���������� � �������: ���� �������� = ���������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/SystemFunctionsImpl/UpsToList_factory.h"
#include "MDProcess/MDAModel/impl/SystemFunctionsImpl/UpsToList.h"

namespace SystemFunctionsImpl {

UpsToList_factory::UpsToList_factory () {
}

void UpsToList_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	TemplateFunctions::InternalFunctionFactoryManager::register_factory (this, priority);
}

const std::string UpsToList_factory::key () const {
	return "_ups_to_list";
}

TemplateFunctions::InternalFunction* UpsToList_factory::make () {
	UpsToList_var ret = new UpsToList ();
	return ret._retn ();
}

} // namespace SystemFunctionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

