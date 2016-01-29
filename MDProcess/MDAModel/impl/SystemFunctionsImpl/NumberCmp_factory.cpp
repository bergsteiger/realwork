////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/impl/SystemFunctionsImpl/NumberCmp_factory.cpp"
// ��������� ������ ���������� ��� ������ ����������� (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::SystemFunctionsImpl::NumberCmp
//
// ���������� ���������� ������� ���������� _number_cmp
// _number_cmp("<������1>","<������2>","<�������� ���������>") - ���������� ��� ����� ������1 ��
// �������2 �������� �������� �������� (>,<,==, !=, >=, <=). ���� ��������� ��������� - ������,
// ���������� 1, � ��������� ������ 0.
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/SystemFunctionsImpl/NumberCmp_factory.h"
#include "MDProcess/MDAModel/impl/SystemFunctionsImpl/NumberCmp.h"

namespace SystemFunctionsImpl {

NumberCmp_factory::NumberCmp_factory () {
}

void NumberCmp_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	TemplateFunctions::InternalFunctionFactoryManager::register_factory (this, priority);
}

const std::string NumberCmp_factory::key () const {
	return "_number_cmp";
}

TemplateFunctions::InternalFunction* NumberCmp_factory::make () {
	NumberCmp_var ret = new NumberCmp ();
	return ret._retn ();
}

} // namespace SystemFunctionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

