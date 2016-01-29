////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/AddAttribute_factory.cpp"
// ��������� ������ ���������� ��� ������ ����������� (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VirtualElementsFuncionsImpl::AddAttribute
//
// %S%f_add_attribute(<GUID ������ ��������>, <���������>,<��������� ��������>,<��� ����������>) -
// ���������� _add_operation, �� ��������� ����� �������, �������� ��-��������� ����� ���� ������
// ������ ��������� �������� ���� ������ ������� (���������� ����).
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/AddAttribute_factory.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/AddAttribute.h"

namespace VirtualElementsFuncionsImpl {

AddAttribute_factory::AddAttribute_factory () {
}

void AddAttribute_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	TemplateFunctions::InternalStereotypeFunctionFactoryManager::register_factory (this, priority);
}

const std::string AddAttribute_factory::key () const {
	return "_add_attribute";
}

TemplateFunctions::InternalStereotypeFunction* AddAttribute_factory::make () {
	AddAttribute_var ret = new AddAttribute ();
	return ret._retn ();
}

} // namespace VirtualElementsFuncionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

