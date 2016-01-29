////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/impl/StereotypeFunctionsImpl/UniqueList_factory.cpp"
// ��������� ������ ���������� ��� ������ ����������� (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::StereotypeFunctionsImpl::UniqueList
//
// %S%f_unique_list() - ������� ��������� �� ������.
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/StereotypeFunctionsImpl/UniqueList_factory.h"
#include "MDProcess/MDAModel/impl/StereotypeFunctionsImpl/UniqueList.h"

namespace StereotypeFunctionsImpl {

UniqueList_factory::UniqueList_factory () {
}

void UniqueList_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	TemplateFunctions::InternalStereotypeFunctionFactoryManager::register_factory (this, priority);
}

const std::string UniqueList_factory::key () const {
	return "_unique_list";
}

TemplateFunctions::InternalStereotypeFunction* UniqueList_factory::make () {
	UniqueList_var ret = new UniqueList ();
	return ret._retn ();
}

} // namespace StereotypeFunctionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

