////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/SetDefaultUC_factory.cpp"
// ��������� ������ ���������� ��� ������ ����������� (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VirtualElementsFuncionsImpl::SetDefaultUC
//
// %f_set_default_uc(<���������>,<������������� ����-������>,<��� ����-������>) - �������� ��� ����-
// ������, ������� ��������� �������� ��� ������ ��������� (��� ��� ������������ ����� "rewrite
// user code")
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/SetDefaultUC_factory.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/SetDefaultUC.h"

namespace VirtualElementsFuncionsImpl {

SetDefaultUC_factory::SetDefaultUC_factory () {
}

void SetDefaultUC_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	TemplateFunctions::InternalStereotypeFunctionFactoryManager::register_factory (this, priority);
}

const std::string SetDefaultUC_factory::key () const {
	return "_set_default_uc";
}

TemplateFunctions::InternalStereotypeFunction* SetDefaultUC_factory::make () {
	SetDefaultUC_var ret = new SetDefaultUC ();
	return ret._retn ();
}

} // namespace VirtualElementsFuncionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

