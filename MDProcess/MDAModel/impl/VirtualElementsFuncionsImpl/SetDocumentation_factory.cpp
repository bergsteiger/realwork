////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/SetDocumentation_factory.cpp"
// ��������� ������ ���������� ��� ������ ����������� (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VirtualElementsFuncionsImpl::SetDocumentation
//
// %S%f_set_documentation(<������������>) - ������������� ������������ ��� ��������. ���������
// ������ � ����������� ���������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/SetDocumentation_factory.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/SetDocumentation.h"

namespace VirtualElementsFuncionsImpl {

SetDocumentation_factory::SetDocumentation_factory () {
}

void SetDocumentation_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	TemplateFunctions::InternalStereotypeFunctionFactoryManager::register_factory (this, priority);
}

const std::string SetDocumentation_factory::key () const {
	return "_set_documentation";
}

TemplateFunctions::InternalStereotypeFunction* SetDocumentation_factory::make () {
	SetDocumentation_var ret = new SetDocumentation ();
	return ret._retn ();
}

} // namespace VirtualElementsFuncionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

