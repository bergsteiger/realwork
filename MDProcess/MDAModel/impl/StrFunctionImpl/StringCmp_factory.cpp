////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/impl/StrFunctionImpl/StringCmp_factory.cpp"
// ��������� ������ ���������� ��� ������ ����������� (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::StrFunctionImpl::StringCmp
//
// ���������� ���������� ������� ���������� _string_cmp
// _string_cmp("<������1>","<������2>","<�������� ���������>") - ���������� ������1 �� �������2
// �������� �������� �������� (>,<,==, !=, >=, <=)
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/StrFunctionImpl/StringCmp_factory.h"
#include "MDProcess/MDAModel/impl/StrFunctionImpl/StringCmp.h"

namespace StrFunctionImpl {

StringCmp_factory::StringCmp_factory () {
}

void StringCmp_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	TemplateFunctions::InternalFunctionFactoryManager::register_factory (this, priority);
}

const std::string StringCmp_factory::key () const {
	return "_string_cmp";
}

TemplateFunctions::InternalFunction* StringCmp_factory::make () {
	StringCmp_var ret = new StringCmp ();
	return ret._retn ();
}

} // namespace StrFunctionImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

