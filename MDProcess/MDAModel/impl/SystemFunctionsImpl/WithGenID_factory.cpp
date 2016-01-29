////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/impl/SystemFunctionsImpl/WithGenID_factory.cpp"
// ��������� ������ ���������� ��� ������ ����������� (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::SystemFunctionsImpl::WithGenID
//
// ���������� ���������� ������� ���������� "_with_gen_id".
// _with_gen_id(�gen id�,���������) - ������� �������� �� ������ ���������� � �������� ID
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/SystemFunctionsImpl/WithGenID_factory.h"
#include "MDProcess/MDAModel/impl/SystemFunctionsImpl/WithGenID.h"

namespace SystemFunctionsImpl {

WithGenID_factory::WithGenID_factory () {
}

void WithGenID_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	TemplateFunctions::InternalFunctionFactoryManager::register_factory (this, priority);
}

const std::string WithGenID_factory::key () const {
	return "_with_gen_id";
}

TemplateFunctions::InternalFunction* WithGenID_factory::make () {
	WithGenID_var ret = new WithGenID ();
	return ret._retn ();
}

} // namespace SystemFunctionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

