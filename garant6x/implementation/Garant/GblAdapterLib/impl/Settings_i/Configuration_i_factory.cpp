////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Settings_i/Configuration_i_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Settings_i::Configuration_i
//
// Реализация интерфейса, обеспечивающего работу с конкретной конфигурацией, является элементом
// списка конфигураций.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Settings_i/Configuration_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Settings_i/Configuration_i.h"

namespace GblAdapterLib {

Configuration_i_factory* Configuration_i_factory::s_instance = 0;

Configuration_i_factory::Configuration_i_factory () {
}

void Configuration_i_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	ConfigurationFactoryManager::register_factory (this, priority);
	s_instance = this;
}

const char* Configuration_i_factory::key () const {
	return "Configuration_i";
}

Configuration* Configuration_i_factory::make (
	long id
	, const GCI::IO::String* name
	, const GCI::IO::String* hint
	, bool readonly
) {
	Configuration_i_var ret = new Configuration_i (id, name, hint, readonly);
	return ret._retn ();
}

Configuration_i* Configuration_iServantFactory::make (long id, const GCI::IO::String* name, const GCI::IO::String* hint, bool readonly) {
	if (Configuration_i_factory::s_instance) {
		return dynamic_cast<Configuration_i*>(Configuration_i_factory::s_instance->make (id, name, hint, readonly));
	} else {
		throw Core::Root::NoActiveFactory ("GblAdapterLib::Settings_i::Configuration_i_factory");
	}
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

