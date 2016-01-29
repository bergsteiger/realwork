////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/CoreSrv/impl/Root_i/ConfigurationSrv_i_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> shared::CoreSrv::Root_i::ConfigurationSrv_i
//
// Серверный вариант (пере определяет серверные переменные)
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/CoreSrv/impl/Root_i/ConfigurationSrv_i_factory.h"
#include "shared/CoreSrv/impl/Root_i/ConfigurationSrv_i.h"

namespace CoreSrv {
namespace Root_i {

ConfigurationSrv_i_factory::ConfigurationSrv_i_factory () {
}

void ConfigurationSrv_i_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	Core::Root::ConfigurationFactoryManager::register_factory (this, priority);
}

const char* ConfigurationSrv_i_factory::key () const {
	return "ConfigurationSrv_i";
}

Core::Root::Configuration* ConfigurationSrv_i_factory::get () {
	ConfigurationSrv_i_var ret = new ConfigurationSrv_i ();
	return ret._retn ();
}

} // namespace Root_i
} // namespace CoreSrv

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

