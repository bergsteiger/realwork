////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/TestModel/BasicTests/IfdefInterfaces/IfdefInterfaces.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Interfaces::Category>> TestModel::BasicTests::IfdefInterfaces
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/Core/sys/std_inc.h"
#include "TestModel/BasicTests/IfdefInterfaces/IfdefInterfaces.h"
#include "TestModel/BasicTests/IfdefInterfaces/IfdefInterfacesFactories.h"

#if defined(WIN32)
namespace BasicTests {
namespace IfdefInterfaces {

// factory interface wrapper for TestInterface
#if defined(ACE_HAS_WINNT4) && defined(WIN32)
TestInterface* TestInterfaceFactory::make () /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return TestInterfaceFactoryManager::Singleton::instance ()->make ();
}
#endif //ACE_HAS_WINNT4 && WIN32

} // namespace IfdefInterfaces
} // namespace BasicTests

#endif //WIN32
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

