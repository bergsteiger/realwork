////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/impl/StrFunctionImpl/Prefix_factory.cpp"
// ��������� ������ ���������� ��� ������ ����������� (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::StrFunctionImpl::Prefix
//
// ������ ������:
// %f_prefix(������,�������) - ���� ������ ���������� � �������� - ���������� �������, �����
// ���������� �������� ������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/StrFunctionImpl/Prefix_factory.h"
#include "MDProcess/MDAModel/impl/StrFunctionImpl/Prefix.h"

namespace StrFunctionImpl {

Prefix_factory::Prefix_factory () {
}

void Prefix_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	TemplateFunctions::InternalFunctionFactoryManager::register_factory (this, priority);
}

const std::string Prefix_factory::key () const {
	return "_prefix";
}

TemplateFunctions::InternalFunction* Prefix_factory::make () {
	Prefix_var ret = new Prefix ();
	return ret._retn ();
}

} // namespace StrFunctionImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

