////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/impl/StrFunctionImpl/Suffix_factory.cpp"
// ��������� ������ ���������� ��� ������ ����������� (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::StrFunctionImpl::Suffix
//
// ������ ������:
// %f_suffix(������,�������) - ���� ������ ������������� ��������� - ���������� �������, �����
// ���������� �������� ������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/StrFunctionImpl/Suffix_factory.h"
#include "MDProcess/MDAModel/impl/StrFunctionImpl/Suffix.h"

namespace StrFunctionImpl {

Suffix_factory::Suffix_factory () {
}

void Suffix_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	TemplateFunctions::InternalFunctionFactoryManager::register_factory (this, priority);
}

const std::string Suffix_factory::key () const {
	return "_suffix";
}

TemplateFunctions::InternalFunction* Suffix_factory::make () {
	Suffix_var ret = new Suffix ();
	return ret._retn ();
}

} // namespace StrFunctionImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

