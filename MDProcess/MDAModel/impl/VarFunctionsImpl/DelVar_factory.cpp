////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/impl/VarFunctionsImpl/DelVar_factory.cpp"
// ��������� ������ ���������� ��� ������ ����������� (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VarFunctionsImpl::DelVar
//
// ���������� ���������� ������� ���������� _del_var.
// _del_var (��������������) - ������� ���������� ���������� (������� ��������� ������������)
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/VarFunctionsImpl/DelVar_factory.h"
#include "MDProcess/MDAModel/impl/VarFunctionsImpl/DelVar.h"

namespace VarFunctionsImpl {

DelVar_factory::DelVar_factory () {
}

void DelVar_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	TemplateFunctions::InternalFunctionFactoryManager::register_factory (this, priority);
}

const std::string DelVar_factory::key () const {
	return "_del_var";
}

TemplateFunctions::InternalFunction* DelVar_factory::make () {
	DelVar_var ret = new DelVar ();
	return ret._retn ();
}

} // namespace VarFunctionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

