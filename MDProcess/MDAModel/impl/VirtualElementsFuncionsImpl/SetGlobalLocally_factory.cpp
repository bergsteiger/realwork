////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/SetGlobalLocally_factory.cpp"
// ��������� ������ ���������� ��� ������ ����������� (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VirtualElementsFuncionsImpl::SetGlobalLocally
//
// %S%f_set_global_locally(true|false) - ����� ��� ��������� "��������� ������������"
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/SetGlobalLocally_factory.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/SetGlobalLocally.h"

namespace VirtualElementsFuncionsImpl {

SetGlobalLocally_factory::SetGlobalLocally_factory () {
}

void SetGlobalLocally_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	TemplateFunctions::InternalStereotypeFunctionFactoryManager::register_factory (this, priority);
}

const std::string SetGlobalLocally_factory::key () const {
	return "_set_global_locally";
}

TemplateFunctions::InternalStereotypeFunction* SetGlobalLocally_factory::make () {
	SetGlobalLocally_var ret = new SetGlobalLocally ();
	return ret._retn ();
}

} // namespace VirtualElementsFuncionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

