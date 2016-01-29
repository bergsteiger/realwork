////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/Core/impl/Root_i/Configuration_i_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> shared::Core::Root_i::Configuration_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "ace/ACE.h"
#include "shared/Core/impl/Root_i/Configuration_i_factory.h"
#include "shared/Core/impl/Root_i/Configuration_i.h"

namespace Core {
namespace Root_i {

Configuration_i_factory::Configuration_i_factory () {
}

void Configuration_i_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	Root::ConfigurationFactoryManager::register_factory (this, priority);
}

const char* Configuration_i_factory::key () const {
	return "Configuration_i";
}

Root::Configuration* Configuration_i_factory::get () {
	Configuration_i_var ret = new Configuration_i ();
	return ret._retn ();
}

} // namespace Root_i
} // namespace Core

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

