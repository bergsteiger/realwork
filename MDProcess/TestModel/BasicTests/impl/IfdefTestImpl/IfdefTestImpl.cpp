////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/TestModel/BasicTests/impl/IfdefTestImpl/IfdefTestImpl.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Impl::Category>> TestModel::BasicTests::IfdefTestImpl
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/Core/sys/std_inc.h"
#include "TestModel/BasicTests/impl/IfdefTestImpl/IfdefTestImpl.h"
#include "TestModel/BasicTests/impl/IfdefTestImpl/IfdefTestImplFactories.h"

#if defined(WIN32)

namespace BasicTests {
namespace IfdefTestImpl {

// factory interface wrapper for TestLocal
TestLocal* TestLocalFactory::create () /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return TestLocalFactoryManager::Singleton::instance ()->create ();
}



} //namespace IfdefTestImpl
} // namespace BasicTests

#endif //WIN32
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

