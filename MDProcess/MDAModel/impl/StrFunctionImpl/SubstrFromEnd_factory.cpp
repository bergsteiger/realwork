////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/impl/StrFunctionImpl/SubstrFromEnd_factory.cpp"
// ��������� ������ ���������� ��� ������ ����������� (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::StrFunctionImpl::SubstrFromEnd
//
// ���������� ���������� ������� ���������� "_substr_from_end"
// _substr_from_end("<������>",n) - ���������� n �������� � ����� ������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/StrFunctionImpl/SubstrFromEnd_factory.h"
#include "MDProcess/MDAModel/impl/StrFunctionImpl/SubstrFromEnd.h"

namespace StrFunctionImpl {

SubstrFromEnd_factory::SubstrFromEnd_factory () {
}

void SubstrFromEnd_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	TemplateFunctions::InternalFunctionFactoryManager::register_factory (this, priority);
}

const std::string SubstrFromEnd_factory::key () const {
	return "_substr_from_end";
}

TemplateFunctions::InternalFunction* SubstrFromEnd_factory::make () {
	SubstrFromEnd_var ret = new SubstrFromEnd ();
	return ret._retn ();
}

} // namespace StrFunctionImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

