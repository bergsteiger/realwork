////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/impl/VarFunctionsImpl/PopFirstToVar_factory.cpp"
// ��������� ������ ���������� ��� ������ ����������� (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VarFunctionsImpl::PopFirstToVar
//
// ���������� ���������� ������� ����������  _pop_first_to_var.
// _pop_first_to_var(��������������, �������������� ����������) - �������� � ����������
// �������������� ���������� �������� ������ ������� �� ������ (���������� _set_var), � �������
// ��� (�� ������)
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/VarFunctionsImpl/PopFirstToVar_factory.h"
#include "MDProcess/MDAModel/impl/VarFunctionsImpl/PopFirstToVar.h"

namespace VarFunctionsImpl {

PopFirstToVar_factory::PopFirstToVar_factory () {
}

void PopFirstToVar_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	TemplateFunctions::InternalFunctionFactoryManager::register_factory (this, priority);
}

const std::string PopFirstToVar_factory::key () const {
	return "_pop_first_to_var";
}

TemplateFunctions::InternalFunction* PopFirstToVar_factory::make () {
	PopFirstToVar_var ret = new PopFirstToVar ();
	return ret._retn ();
}

} // namespace VarFunctionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

