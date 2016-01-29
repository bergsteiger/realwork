////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/impl/SystemFunctionsImpl/JavaTypePath_factory.cpp"
// ��������� ������ ���������� ��� ������ ����������� (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::SystemFunctionsImpl::JavaTypePath
//
// ���������� ������ ���� � �������� �� �������� java
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/SystemFunctionsImpl/JavaTypePath_factory.h"
#include "MDProcess/MDAModel/impl/SystemFunctionsImpl/JavaTypePath.h"

namespace SystemFunctionsImpl {

JavaTypePath_factory::JavaTypePath_factory () {
}

void JavaTypePath_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	TemplateFunctions::InternalFunctionFactoryManager::register_factory (this, priority);
}

const std::string JavaTypePath_factory::key () const {
	return "_java_type_path";
}

TemplateFunctions::InternalFunction* JavaTypePath_factory::make () {
	JavaTypePath_var ret = new JavaTypePath ();
	return ret._retn ();
}

} // namespace SystemFunctionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

