////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/SetTarget_factory.cpp"
// ��������� ������ ���������� ��� ������ ����������� (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VirtualElementsFuncionsImpl::SetTarget
//
// ���������� �������� (��������, ���������, ��������)  ����� ���
// %S%f_set_target(<���/��� �������� ��� ����� (� ������ void)>)
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/SetTarget_factory.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/SetTarget.h"

namespace VirtualElementsFuncionsImpl {

SetTarget_factory::SetTarget_factory () {
}

void SetTarget_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	TemplateFunctions::InternalStereotypeFunctionFactoryManager::register_factory (this, priority);
}

const std::string SetTarget_factory::key () const {
	return "_set_target";
}

TemplateFunctions::InternalStereotypeFunction* SetTarget_factory::make () {
	SetTarget_var ret = new SetTarget ();
	return ret._retn ();
}

} // namespace VirtualElementsFuncionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

