////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/impl/VarFunctionsImpl/PopLastToVar_factory.cpp"
// ��������� ������ ���������� ��� ������ ����������� (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VarFunctionsImpl::PopLastToVar
//
// ���������� ���������� ������� ���������� _pop_last_to_var.
// _pop_last_to_var(��������������, �������������� ����������) - �������� � ����������
// �������������� ���������� �������� ���������� ������� �� ������ (���������� _set_var), �
// ������� ��� (�� ������)
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/VarFunctionsImpl/PopLastToVar_factory.h"
#include "MDProcess/MDAModel/impl/VarFunctionsImpl/PopLastToVar.h"

namespace VarFunctionsImpl {

PopLastToVar_factory::PopLastToVar_factory () {
}

void PopLastToVar_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	TemplateFunctions::InternalFunctionFactoryManager::register_factory (this, priority);
}

const std::string PopLastToVar_factory::key () const {
	return "_pop_last_to_var";
}

TemplateFunctions::InternalFunction* PopLastToVar_factory::make () {
	PopLastToVar_var ret = new PopLastToVar ();
	return ret._retn ();
}

} // namespace VarFunctionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

