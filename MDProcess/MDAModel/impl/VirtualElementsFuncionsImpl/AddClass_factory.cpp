////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/AddClass_factory.cpp"
// ��������� ������ ���������� ��� ������ ����������� (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VirtualElementsFuncionsImpl::AddClass
//
// %S%f_add_class(<GUID ������ ��������>,<���������>,<��� ������>,<��� ����������>) - ������� �����
// ������� - ����� � �������� ������ � �����������, ��������� ��� � ���������� � ��������� ���
// ������� � �������� ��������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/AddClass_factory.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/AddClass.h"

namespace VirtualElementsFuncionsImpl {

AddClass_factory::AddClass_factory () {
}

void AddClass_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	TemplateFunctions::InternalStereotypeFunctionFactoryManager::register_factory (this, priority);
}

const std::string AddClass_factory::key () const {
	return "_add_class";
}

TemplateFunctions::InternalStereotypeFunction* AddClass_factory::make () {
	AddClass_var ret = new AddClass ();
	return ret._retn ();
}

} // namespace VirtualElementsFuncionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

