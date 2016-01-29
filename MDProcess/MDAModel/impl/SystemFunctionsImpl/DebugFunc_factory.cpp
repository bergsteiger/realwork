////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/impl/SystemFunctionsImpl/DebugFunc_factory.cpp"
// ��������� ������ ���������� ��� ������ ����������� (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::SystemFunctionsImpl::DebugFunc
//
// ���������� ���������� ������� ���������� "_dbg_point"
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/SystemFunctionsImpl/DebugFunc_factory.h"
#include "MDProcess/MDAModel/impl/SystemFunctionsImpl/DebugFunc.h"

namespace SystemFunctionsImpl {

DebugFunc_factory::DebugFunc_factory () {
}

void DebugFunc_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	TemplateFunctions::InternalFunctionFactoryManager::register_factory (this, priority);
}

const std::string DebugFunc_factory::key () const {
	return "_dbg_point";
}

TemplateFunctions::InternalFunction* DebugFunc_factory::make () {
	DebugFunc_var ret = new DebugFunc ();
	return ret._retn ();
}

} // namespace SystemFunctionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

