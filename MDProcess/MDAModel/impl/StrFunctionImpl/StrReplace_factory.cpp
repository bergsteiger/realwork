////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/impl/StrFunctionImpl/StrReplace_factory.cpp"
// ��������� ������ ���������� ��� ������ ����������� (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::StrFunctionImpl::StrReplace
//
// ���������� ���������� ������� ���������� "_str_replace".
// _str_replace (<������>,<�������� ���������>,<����� ���������>) - �������� � ������ ��� ��������
// ��������� �� �����
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/StrFunctionImpl/StrReplace_factory.h"
#include "MDProcess/MDAModel/impl/StrFunctionImpl/StrReplace.h"

namespace StrFunctionImpl {

StrReplace_factory::StrReplace_factory () {
}

void StrReplace_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	TemplateFunctions::InternalFunctionFactoryManager::register_factory (this, priority);
}

const std::string StrReplace_factory::key () const {
	return "_str_replace";
}

TemplateFunctions::InternalFunction* StrReplace_factory::make () {
	StrReplace_var ret = new StrReplace ();
	return ret._retn ();
}

} // namespace StrFunctionImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

