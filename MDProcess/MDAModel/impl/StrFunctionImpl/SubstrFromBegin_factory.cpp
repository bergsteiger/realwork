////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/impl/StrFunctionImpl/SubstrFromBegin_factory.cpp"
// ��������� ������ ���������� ��� ������ ����������� (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::StrFunctionImpl::SubstrFromBegin
//
// ���������� ���������� ������� ���������� "_substr_from_begin"
// _substr_from_begin("<������>",n) - ���������� n �������� � ������ ������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/StrFunctionImpl/SubstrFromBegin_factory.h"
#include "MDProcess/MDAModel/impl/StrFunctionImpl/SubstrFromBegin.h"

namespace StrFunctionImpl {

SubstrFromBegin_factory::SubstrFromBegin_factory () {
}

void SubstrFromBegin_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	TemplateFunctions::InternalFunctionFactoryManager::register_factory (this, priority);
}

const std::string SubstrFromBegin_factory::key () const {
	return "_substr_from_begin";
}

TemplateFunctions::InternalFunction* SubstrFromBegin_factory::make () {
	SubstrFromBegin_var ret = new SubstrFromBegin ();
	return ret._retn ();
}

} // namespace StrFunctionImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

