////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/impl/StrFunctionImpl/ToUpper_factory.cpp"
// ��������� ������ ���������� ��� ������ ����������� (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::StrFunctionImpl::ToUpper
//
// ���������� ���������� ������� ���������� "_to_upper".
// _to_upper ("<������>")  - �������� ������� ������ �� uppercase
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/StrFunctionImpl/ToUpper_factory.h"
#include "MDProcess/MDAModel/impl/StrFunctionImpl/ToUpper.h"

namespace StrFunctionImpl {

ToUpper_factory::ToUpper_factory () {
}

void ToUpper_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	TemplateFunctions::InternalFunctionFactoryManager::register_factory (this, priority);
}

const std::string ToUpper_factory::key () const {
	return "_to_upper";
}

TemplateFunctions::InternalFunction* ToUpper_factory::make () {
	ToUpper_var ret = new ToUpper ();
	return ret._retn ();
}

} // namespace StrFunctionImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

