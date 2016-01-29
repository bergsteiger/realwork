////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/impl/SystemFunctionsImpl/SetProp_factory.cpp"
// ��������� ������ ���������� ��� ������ ����������� (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::SystemFunctionsImpl::SetProp
//
// ���������� ���������� ������� ���������� "_set_prop"
// _set_prop(�prop id�,�value�) - ������������� �������� ���������� ��������� ��������.
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/SystemFunctionsImpl/SetProp_factory.h"
#include "MDProcess/MDAModel/impl/SystemFunctionsImpl/SetProp.h"

namespace SystemFunctionsImpl {

SetProp_factory::SetProp_factory () {
}

void SetProp_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	TemplateFunctions::InternalFunctionFactoryManager::register_factory (this, priority);
}

const std::string SetProp_factory::key () const {
	return "_set_prop";
}

TemplateFunctions::InternalFunction* SetProp_factory::make () {
	SetProp_var ret = new SetProp ();
	return ret._retn ();
}

} // namespace SystemFunctionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

