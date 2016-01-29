////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/TestModel/BasicTests/impl/NewImpl/NewServant_factory.cpp"
// ��������� ������ ���������� ��� ������ ����������� (.cpp)
// Generated from UML model, root element: <<Servant::Class>> TestModel::BasicTests::NewImpl::NewServant
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/Core/sys/std_inc.h"
#include "TestModel/BasicTests/impl/NewImpl/NewServant_factory.h"
#include "TestModel/BasicTests/impl/NewImpl/NewServant.h"
#include "TestModel/BasicTests/impl/NewImpl/Environment.h"

namespace BasicTests {
namespace NewImpl {

NewServant_factory::NewServant_factory () {
}

void NewServant_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	DerivedLocalFactoryManager::register_factory (this, priority);
}

const char* NewServant_factory::key () const {
	return "NewServant";
}

NewInterfaces::DerivedInterface* NewServant_factory::factory () {
	NewServant_var ret = new NewServant ();
	return ret._retn ();
}

} // namespace NewImpl
} // namespace BasicTests

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

