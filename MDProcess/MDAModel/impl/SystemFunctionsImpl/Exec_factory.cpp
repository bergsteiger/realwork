////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/impl/SystemFunctionsImpl/Exec_factory.cpp"
// ��������� ������ ���������� ��� ������ ����������� (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::SystemFunctionsImpl::Exec
//
// %f_exec(���� �������, ������� ����� ����������) - ��������� ��� �������. ������:
// {code}
// %f_exec(%SN)
// 
// //���� �����:
// %f_set_var(CODE,"\%SN")\
// %f_exec(%{CODE}N)
// {code}
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/SystemFunctionsImpl/Exec_factory.h"
#include "MDProcess/MDAModel/impl/SystemFunctionsImpl/Exec.h"

namespace SystemFunctionsImpl {

Exec_factory::Exec_factory () {
}

void Exec_factory::registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/ {
	TemplateFunctions::InternalFunctionFactoryManager::register_factory (this, priority);
}

const std::string Exec_factory::key () const {
	return "_exec";
}

TemplateFunctions::InternalFunction* Exec_factory::make () {
	Exec_var ret = new Exec ();
	return ret._retn ();
}

} // namespace SystemFunctionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

