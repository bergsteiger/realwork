////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/RemoveChild_factory.cpp"
// ��������� ������ ���������� ��� ������ ����������� (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VirtualElementsFuncionsImpl::RemoveChild
//
// %S%f_remove_child(<��� ��������>) - ������� �������� �������� �� ������ ��������� - ���� �������
// � �������� ���'�� ����� ����� �������� �������� (%S) ���� ������� - ������� ������� �� ������,
// ���� �� ������� - ������������ ����������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/RemoveChild_factory.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/RemoveChild.h"

namespace VirtualElementsFuncionsImpl {

RemoveChild_factory::RemoveChild_factory () {
}

void RemoveChild_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	TemplateFunctions::InternalStereotypeFunctionFactoryManager::register_factory (this, priority);
}

const std::string RemoveChild_factory::key () const {
	return "_remove_child";
}

TemplateFunctions::InternalStereotypeFunction* RemoveChild_factory::make () {
	RemoveChild_var ret = new RemoveChild ();
	return ret._retn ();
}

} // namespace VirtualElementsFuncionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

