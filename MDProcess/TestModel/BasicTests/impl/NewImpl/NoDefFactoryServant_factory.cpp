////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/TestModel/BasicTests/impl/NewImpl/NoDefFactoryServant_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> TestModel::BasicTests::NewImpl::NoDefFactoryServant
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/Core/sys/std_inc.h"
#include "TestModel/BasicTests/impl/NewImpl/NoDefFactoryServant_factory.h"
#include "TestModel/BasicTests/impl/NewImpl/NoDefFactoryServant.h"
//#UC START# *49AEE4B5036ECUSTOM_INLUDE*
//#UC END# *49AEE4B5036ECUSTOM_INLUDE*
#include "TestModel/BasicTests/impl/NewImpl/Environment.h"

namespace BasicTests {
namespace NewImpl {

NoDefFactoryServant_factory::NoDefFactoryServant_factory () {
}

void NoDefFactoryServant_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	DerivedLocalFactoryManager::register_factory (this, priority);
}

const char* NoDefFactoryServant_factory::key () const {
	return "NoDefFactoryServant";
}

NewInterfaces::DerivedInterface* NoDefFactoryServant_factory::factory () {
	//#UC START# *49B93A11015649AEE4B5036E_49B93A3403B0_IMPL*
	throw Core::Root::MDAGenNotImplemented(GDS_CURRENT_FUNCTION);
	//#UC END# *49B93A11015649AEE4B5036E_49B93A3403B0_IMPL*
}

} // namespace NewImpl
} // namespace BasicTests

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

