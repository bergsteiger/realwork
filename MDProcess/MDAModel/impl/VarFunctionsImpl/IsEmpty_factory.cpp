////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/impl/VarFunctionsImpl/IsEmpty_factory.cpp"
// ��������� ������ ���������� ��� ������ ����������� (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VarFunctionsImpl::IsEmpty
//
// ���������� ���������� ������� ���������� _is_empty.
// _is_empty(��������������) - ���������� true, ���� ������ ����
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/VarFunctionsImpl/IsEmpty_factory.h"
#include "MDProcess/MDAModel/impl/VarFunctionsImpl/IsEmpty.h"

namespace VarFunctionsImpl {

IsEmpty_factory::IsEmpty_factory () {
}

void IsEmpty_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	TemplateFunctions::InternalFunctionFactoryManager::register_factory (this, priority);
}

const std::string IsEmpty_factory::key () const {
	return "_is_empty";
}

TemplateFunctions::InternalFunction* IsEmpty_factory::make () {
	IsEmpty_var ret = new IsEmpty ();
	return ret._retn ();
}

} // namespace VarFunctionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

