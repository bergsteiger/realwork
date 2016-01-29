////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/impl/SystemFunctionsImpl/CycleBreak_factory.cpp"
// ��������� ������ ���������� ��� ������ ����������� (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::SystemFunctionsImpl::CycleBreak
//
// ���������� �������:
// _cycle_break() - ��������� ������� ����, ���� ������� ������� ��� ����� - ������������ ����������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/SystemFunctionsImpl/CycleBreak_factory.h"
#include "MDProcess/MDAModel/impl/SystemFunctionsImpl/CycleBreak.h"

namespace SystemFunctionsImpl {

CycleBreak_factory::CycleBreak_factory () {
}

void CycleBreak_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	TemplateFunctions::InternalFunctionFactoryManager::register_factory (this, priority);
}

const std::string CycleBreak_factory::key () const {
	return "_cycle_break";
}

TemplateFunctions::InternalFunction* CycleBreak_factory::make () {
	CycleBreak_var ret = new CycleBreak ();
	return ret._retn ();
}

} // namespace SystemFunctionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

