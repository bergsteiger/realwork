////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/TestModel/BasicTests/NewInterfaces/NewInterfaces.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Interfaces::Category>> TestModel::BasicTests::NewInterfaces
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/Core/sys/std_inc.h"
#include "TestModel/BasicTests/NewInterfaces/NewInterfaces.h"
#include "TestModel/BasicTests/NewInterfaces/NewInterfacesFactories.h"

namespace BasicTests {
namespace NewInterfaces {

// factory interface wrapper for DerivedInterface
DerivedInterface* DerivedInterfaceFactory::factory () /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return DerivedInterfaceFactoryManager::Singleton::instance ()->factory ();
}

// factory interface wrapper for BaseInterface1
BaseInterface1* BaseInterface1Factory::make (MultiSelector key) /*throw (Core::Root::UnknownFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	return BaseInterface1FactoryManager::Singleton::instance ()->make (key);
}

// factory interface wrapper for DerivedInterface1
DerivedInterface1* DerivedInterface1Factory::make_derived (MultiSelector key) /*throw (Core::Root::UnknownFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	return DerivedInterface1FactoryManager::Singleton::instance ()->make_derived (key);
}

DerivedInterface1* DerivedInterface1Factory::make (MultiSelector key) /*throw (Core::Root::UnknownFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/ {
	return DerivedInterface1FactoryManager::Singleton::instance ()->make (key);
}

} // namespace NewInterfaces
} // namespace BasicTests

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

