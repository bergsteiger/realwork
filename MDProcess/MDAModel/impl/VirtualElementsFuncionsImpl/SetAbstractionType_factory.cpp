////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/SetAbstractionType_factory.cpp"
// ��������� ������ ���������� ��� ������ ����������� (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VirtualElementsFuncionsImpl::SetAbstractionType
//
// %S%f_set_abstraction_type(abstract|regular|final) - ������������� ��� ������������� ���
// ��������. ��������� ������ ��� ����������� ���������. ���� ��� ������������� �� ������ � ������
// ����������� �������� - ������������� ����������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/SetAbstractionType_factory.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/SetAbstractionType.h"

namespace VirtualElementsFuncionsImpl {

SetAbstractionType_factory::SetAbstractionType_factory () {
}

void SetAbstractionType_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	TemplateFunctions::InternalStereotypeFunctionFactoryManager::register_factory (this, priority);
}

const std::string SetAbstractionType_factory::key () const {
	return "_set_abstraction_type";
}

TemplateFunctions::InternalStereotypeFunction* SetAbstractionType_factory::make () {
	SetAbstractionType_var ret = new SetAbstractionType ();
	return ret._retn ();
}

} // namespace VirtualElementsFuncionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

