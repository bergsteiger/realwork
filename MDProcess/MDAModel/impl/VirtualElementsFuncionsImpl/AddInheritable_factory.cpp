////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/AddInheritable_factory.cpp"
// ��������� ������ ���������� ��� ������ ����������� (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VirtualElementsFuncionsImpl::AddInheritable
//
// %S%f_add_inheritable(<���� ��������� �������� ��� ������ ���>) - ���������� _add_realized, ��
// �������� ������� � ������ �����������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/AddInheritable_factory.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/AddInheritable.h"

namespace VirtualElementsFuncionsImpl {

AddInheritable_factory::AddInheritable_factory () {
}

void AddInheritable_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	TemplateFunctions::InternalStereotypeFunctionFactoryManager::register_factory (this, priority);
}

const std::string AddInheritable_factory::key () const {
	return "_add_inheritable";
}

TemplateFunctions::InternalStereotypeFunction* AddInheritable_factory::make () {
	AddInheritable_var ret = new AddInheritable ();
	return ret._retn ();
}

} // namespace VirtualElementsFuncionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

