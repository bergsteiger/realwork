////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/SetLinkType_factory.cpp"
// ��������� ������ ���������� ��� ������ ����������� (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VirtualElementsFuncionsImpl::SetLinkType
//
// %S%f_set_link_type(agr|lnk|ref) - ������������� ��� ����� ��� ��������. ��������� ������ ���
// ����������� ���������. ���� ��������������� ��� ����� �� ����� ��� ����������� � ������� -
// ������� ����������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/SetLinkType_factory.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/SetLinkType.h"

namespace VirtualElementsFuncionsImpl {

SetLinkType_factory::SetLinkType_factory () {
}

void SetLinkType_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	TemplateFunctions::InternalStereotypeFunctionFactoryManager::register_factory (this, priority);
}

const std::string SetLinkType_factory::key () const {
	return "_set_link_type";
}

TemplateFunctions::InternalStereotypeFunction* SetLinkType_factory::make () {
	SetLinkType_var ret = new SetLinkType ();
	return ret._retn ();
}

} // namespace VirtualElementsFuncionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

