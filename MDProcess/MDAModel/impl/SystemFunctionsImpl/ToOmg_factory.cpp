////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/impl/SystemFunctionsImpl/ToOmg_factory.cpp"
// ��������� ������ ���������� ��� ������ ����������� (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::SystemFunctionsImpl::ToOmg
//
// ���������� ���������� ������� ���������� "_to_omg"
// _to_omg (<������>) - ������������ ������ <������> � ����� �OMG� - ��������� ����� � ���������
// ���� ����������� �������� �������������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/SystemFunctionsImpl/ToOmg_factory.h"
#include "MDProcess/MDAModel/impl/SystemFunctionsImpl/ToOmg.h"

namespace SystemFunctionsImpl {

ToOmg_factory::ToOmg_factory () {
}

void ToOmg_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	TemplateFunctions::InternalFunctionFactoryManager::register_factory (this, priority);
}

const std::string ToOmg_factory::key () const {
	return "_to_omg";
}

TemplateFunctions::InternalFunction* ToOmg_factory::make () {
	ToOmg_var ret = new ToOmg ();
	return ret._retn ();
}

} // namespace SystemFunctionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

