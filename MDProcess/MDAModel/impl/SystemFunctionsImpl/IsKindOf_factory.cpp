////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/impl/SystemFunctionsImpl/IsKindOf_factory.cpp"
// ��������� ������ ���������� ��� ������ ����������� (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::SystemFunctionsImpl::IsKindOf
//
// _kind_of(�������, �����-�����) - ���������� true, ���� ����-����� ����������� �������
// ��������� ��� �������� ����������� �� �����-�����. ������ �������������:
// %f_kind_of(S,SimpleClass::Class)
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/SystemFunctionsImpl/IsKindOf_factory.h"
#include "MDProcess/MDAModel/impl/SystemFunctionsImpl/IsKindOf.h"

namespace SystemFunctionsImpl {

IsKindOf_factory::IsKindOf_factory () {
}

void IsKindOf_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	TemplateFunctions::InternalFunctionFactoryManager::register_factory (this, priority);
}

const std::string IsKindOf_factory::key () const {
	return "_kind_of";
}

TemplateFunctions::InternalFunction* IsKindOf_factory::make () {
	IsKindOf_var ret = new IsKindOf ();
	return ret._retn ();
}

} // namespace SystemFunctionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

