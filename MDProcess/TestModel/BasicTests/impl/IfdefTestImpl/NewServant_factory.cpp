////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/TestModel/BasicTests/impl/IfdefTestImpl/NewServant_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> TestModel::BasicTests::IfdefTestImpl::NewServant
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/Core/sys/std_inc.h"
#include "TestModel/BasicTests/impl/IfdefTestImpl/NewServant_factory.h"
#include "TestModel/BasicTests/impl/IfdefTestImpl/NewServant.h"

#if defined(WIN32)
namespace BasicTests {
namespace IfdefTestImpl {

NewServant_factory::NewServant_factory () {
}

void NewServant_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	TestLocalFactoryManager::register_factory (this, priority);
}

const char* NewServant_factory::key () const {
	return "NewServant";
}

TestLocal* NewServant_factory::create () {
	NewServant_var ret = new NewServant ();
	return ret._retn ();
}

} // namespace IfdefTestImpl
} // namespace BasicTests

#endif //WIN32
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

