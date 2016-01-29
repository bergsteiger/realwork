////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/impl/StrFunctionImpl/ToWideStr_factory.cpp"
// ��������� ������ ���������� ��� ������ ����������� (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::StrFunctionImpl::ToWideStr
//
// ���������� ���������� ������� ���������� "_to_wide_str"
// _to_wide_str (<������>, <�������>, <����������� ������>, <����������� ������>) - ��������������
// ������ � wide-����, ���� ����� ����������� ������ �� ���������� ������� ����������� � ASCI-
// ������� � ����������� ���������� ���������.
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/StrFunctionImpl/ToWideStr_factory.h"
#include "MDProcess/MDAModel/impl/StrFunctionImpl/ToWideStr.h"

namespace StrFunctionImpl {

ToWideStr_factory::ToWideStr_factory () {
}

void ToWideStr_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	TemplateFunctions::InternalFunctionFactoryManager::register_factory (this, priority);
}

const std::string ToWideStr_factory::key () const {
	return "_to_wide_str";
}

TemplateFunctions::InternalFunction* ToWideStr_factory::make () {
	ToWideStr_var ret = new ToWideStr ();
	return ret._retn ();
}

} // namespace StrFunctionImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

