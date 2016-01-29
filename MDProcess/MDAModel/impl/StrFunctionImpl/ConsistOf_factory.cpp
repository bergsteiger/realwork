////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/impl/StrFunctionImpl/ConsistOf_factory.cpp"
// ��������� ������ ���������� ��� ������ ����������� (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::StrFunctionImpl::ConsistOf
//
// ���������� ���������� ������� ����������:
// _consist_of(������,������ ��������) - ��������, ��� �������� ������ ������� ������ ��
// ����������� ��������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/StrFunctionImpl/ConsistOf_factory.h"
#include "MDProcess/MDAModel/impl/StrFunctionImpl/ConsistOf.h"

namespace StrFunctionImpl {

ConsistOf_factory::ConsistOf_factory () {
}

void ConsistOf_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	TemplateFunctions::InternalFunctionFactoryManager::register_factory (this, priority);
}

const std::string ConsistOf_factory::key () const {
	return "_consist_of";
}

TemplateFunctions::InternalFunction* ConsistOf_factory::make () {
	ConsistOf_var ret = new ConsistOf ();
	return ret._retn ();
}

} // namespace StrFunctionImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

