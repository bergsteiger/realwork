////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/AddRealized_factory.cpp"
// ��������� ������ ���������� ��� ������ ����������� (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VirtualElementsFuncionsImpl::AddRealized
//
// %S%f_add_realized(<���� ��������� �������� ��� ������ ���>, <������������ - true | false>) -
// ��������� � ������ ����������� ��������� �������, ��������������� �����, ���� ����� �� ����, �
// ������ ��� ������ - ������� � ������ ������� � ����� ������ � ��������� ���, ���� �����������
// ������������ �����, �� ��� ��� �� ����� ����������� �������� ����������� � ���������, � �����,
// ����� ����� �� ����� ����������� � ����� �����������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/AddRealized_factory.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/AddRealized.h"

namespace VirtualElementsFuncionsImpl {

AddRealized_factory::AddRealized_factory () {
}

void AddRealized_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	TemplateFunctions::InternalStereotypeFunctionFactoryManager::register_factory (this, priority);
}

const std::string AddRealized_factory::key () const {
	return "_add_realized";
}

TemplateFunctions::InternalStereotypeFunction* AddRealized_factory::make () {
	AddRealized_var ret = new AddRealized ();
	return ret._retn ();
}

} // namespace VirtualElementsFuncionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

