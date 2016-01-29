////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/RemoveInheritable_factory.cpp"
// ��������� ������ ���������� ��� ������ ����������� (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VirtualElementsFuncionsImpl::RemoveInheritable
//
// %S%f_remove_inheritable(<��� ��������>) - ������� �������� ����� ������������ ����� �������
// ��������� � ���������, ������� ���'��. ���� �� ������� ����� ������� � �������� ���'�� ��� �
// ���� ��������� ��� ����� ������������ - ������������ ����������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/RemoveInheritable_factory.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/RemoveInheritable.h"

namespace VirtualElementsFuncionsImpl {

RemoveInheritable_factory::RemoveInheritable_factory () {
}

void RemoveInheritable_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	TemplateFunctions::InternalStereotypeFunctionFactoryManager::register_factory (this, priority);
}

const std::string RemoveInheritable_factory::key () const {
	return "_remove_inheritable";
}

TemplateFunctions::InternalStereotypeFunction* RemoveInheritable_factory::make () {
	RemoveInheritable_var ret = new RemoveInheritable ();
	return ret._retn ();
}

} // namespace VirtualElementsFuncionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

