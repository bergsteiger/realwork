////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/AddParameter_factory.cpp"
// ��������� ������ ���������� ��� ������ ����������� (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VirtualElementsFuncionsImpl::AddParameter
//
// %S%f_add_parameter(<GUID ������ ��������>, ,<���������>,<��������� ���������>,<��� ����������>) -
// ���������� _add_attribute, �� ��������� ����� �������� .
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/AddParameter_factory.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/AddParameter.h"

namespace VirtualElementsFuncionsImpl {

AddParameter_factory::AddParameter_factory () {
}

void AddParameter_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	TemplateFunctions::InternalStereotypeFunctionFactoryManager::register_factory (this, priority);
}

const std::string AddParameter_factory::key () const {
	return "_add_parameter";
}

TemplateFunctions::InternalStereotypeFunction* AddParameter_factory::make () {
	AddParameter_var ret = new AddParameter ();
	return ret._retn ();
}

} // namespace VirtualElementsFuncionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

