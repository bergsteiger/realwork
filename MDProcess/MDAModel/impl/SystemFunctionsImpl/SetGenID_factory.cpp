////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/impl/SystemFunctionsImpl/SetGenID_factory.cpp"
// ��������� ������ ���������� ��� ������ ����������� (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::SystemFunctionsImpl::SetGenID
//
// ���������� ���������� ������� ���������� "_set_gen_id"
// _set_gen_id(�gen id�) - ������������� ���������.
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/SystemFunctionsImpl/SetGenID_factory.h"
#include "MDProcess/MDAModel/impl/SystemFunctionsImpl/SetGenID.h"

namespace SystemFunctionsImpl {

SetGenID_factory::SetGenID_factory () {
}

void SetGenID_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	TemplateFunctions::InternalFunctionFactoryManager::register_factory (this, priority);
}

const std::string SetGenID_factory::key () const {
	return "_set_gen_id";
}

TemplateFunctions::InternalFunction* SetGenID_factory::make () {
	SetGenID_var ret = new SetGenID ();
	return ret._retn ();
}

} // namespace SystemFunctionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

