////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/impl/SystemFunctionsImpl/Evaluate_factory.cpp"
// ��������� ������ ���������� ��� ������ ����������� (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::SystemFunctionsImpl::Evaluate
//
// ���������� ���������� ������� ���������� _evaluate
// _evaluate(����. ���������) - ��������� ���. ��������� � ���������� ���������. ��������:
// %f_evaluate(2*2+10) - ����� 14.
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/SystemFunctionsImpl/Evaluate_factory.h"
#include "MDProcess/MDAModel/impl/SystemFunctionsImpl/Evaluate.h"

namespace SystemFunctionsImpl {

Evaluate_factory::Evaluate_factory () {
}

void Evaluate_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	TemplateFunctions::InternalFunctionFactoryManager::register_factory (this, priority);
}

const std::string Evaluate_factory::key () const {
	return "_evaluate";
}

TemplateFunctions::InternalFunction* Evaluate_factory::make () {
	Evaluate_var ret = new Evaluate ();
	return ret._retn ();
}

} // namespace SystemFunctionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

