////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/impl/StrFunctionImpl/StrToRule_factory.cpp"
// ��������� ������ ���������� ��� ������ ����������� (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::StrFunctionImpl::StrToRule
//
// ������������ ���������� ������� � �������������� �������, �������� ������� "pack|package"
// ��������������� � ("pack"|"package")
// 
// �������������:
// %f_str_to_rule(pack|package)
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/StrFunctionImpl/StrToRule_factory.h"
#include "MDProcess/MDAModel/impl/StrFunctionImpl/StrToRule.h"

namespace StrFunctionImpl {

StrToRule_factory::StrToRule_factory () {
}

void StrToRule_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	TemplateFunctions::InternalFunctionFactoryManager::register_factory (this, priority);
}

const std::string StrToRule_factory::key () const {
	return "_str_to_rule";
}

TemplateFunctions::InternalFunction* StrToRule_factory::make () {
	StrToRule_var ret = new StrToRule ();
	return ret._retn ();
}

} // namespace StrFunctionImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

