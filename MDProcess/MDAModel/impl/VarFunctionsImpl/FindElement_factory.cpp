////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/impl/VarFunctionsImpl/FindElement_factory.cpp"
// ��������� ������ ���������� ��� ������ ����������� (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VarFunctionsImpl::FindElement
//
// ���������� ���������� ������� ���������� _find_element.
// _find_element(��������������|����, ������������) - ������� ������� �� ����� ��� ��
// �������������� � ���������� ��� � ����������. ������ �������� ������� ���������������� ���
// ������������� ��������, ���� ������� � ����� ��������������� �� ��� ������, �� ��������
// ���������������� ��� ��� ��������, ������ ��� ����� ����������� � ������ ���� �� ���� ��
// �������� (��� ��������� ������). ���� � ���������� ������ �� ����� ������� ����� ������ ��������
// - ������������� ����������. ��������:
// {code}
// %S%f_find_element(%SU, SELF)  - ���������� SELF ���� ��������� �� ������� ������� (S)
// %S%f_set_var (A::B::attr, ATTR)  - ���������� ATTR ����� ��������� �� �������, �� ��������
// ������ ���� �� ���� ������������� �� "A::B::attr"
// {code}
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/VarFunctionsImpl/FindElement_factory.h"
#include "MDProcess/MDAModel/impl/VarFunctionsImpl/FindElement.h"

namespace VarFunctionsImpl {

FindElement_factory::FindElement_factory () {
}

void FindElement_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	TemplateFunctions::InternalFunctionFactoryManager::register_factory (this, priority);
}

const std::string FindElement_factory::key () const {
	return "_find_element";
}

TemplateFunctions::InternalFunction* FindElement_factory::make () {
	FindElement_var ret = new FindElement ();
	return ret._retn ();
}

} // namespace VarFunctionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

