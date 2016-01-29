////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/impl/StrFunctionImpl/StrSplit_factory.cpp"
// ��������� ������ ���������� ��� ������ ����������� (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::StrFunctionImpl::StrSplit
//
// ���������� ���������� ������� ���������� "_str_split".
// _str_split ("<������>","<�������>","<�����������>") - ��������� ������ �� n-����� � ��������
// ��������� � ������������ (������ ����� ����� ���� ��� ����� ������ � ����������)
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/StrFunctionImpl/StrSplit_factory.h"
#include "MDProcess/MDAModel/impl/StrFunctionImpl/StrSplit.h"

namespace StrFunctionImpl {

StrSplit_factory::StrSplit_factory () {
}

void StrSplit_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	TemplateFunctions::InternalFunctionFactoryManager::register_factory (this, priority);
}

const std::string StrSplit_factory::key () const {
	return "_str_split";
}

TemplateFunctions::InternalFunction* StrSplit_factory::make () {
	StrSplit_var ret = new StrSplit ();
	return ret._retn ();
}

} // namespace StrFunctionImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

