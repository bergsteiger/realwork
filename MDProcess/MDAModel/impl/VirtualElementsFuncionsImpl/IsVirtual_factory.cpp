////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/IsVirtual_factory.cpp"
// ��������� ������ ���������� ��� ������ ����������� (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VirtualElementsFuncionsImpl::IsVirtual
//
// �������� �� ������� �����������:
// %S%f_is_virtual()
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/IsVirtual_factory.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/IsVirtual.h"

namespace VirtualElementsFuncionsImpl {

IsVirtual_factory::IsVirtual_factory () {
}

void IsVirtual_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	TemplateFunctions::InternalStereotypeFunctionFactoryManager::register_factory (this, priority);
}

const std::string IsVirtual_factory::key () const {
	return "_is_virtual";
}

TemplateFunctions::InternalStereotypeFunction* IsVirtual_factory::make () {
	IsVirtual_var ret = new IsVirtual ();
	return ret._retn ();
}

} // namespace VirtualElementsFuncionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

