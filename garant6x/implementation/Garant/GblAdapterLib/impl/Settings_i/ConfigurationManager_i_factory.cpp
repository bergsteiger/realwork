////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Settings_i/ConfigurationManager_i_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Settings_i::ConfigurationManager_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Settings_i/ConfigurationManager_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Settings_i/ConfigurationManager_i.h"

namespace GblAdapterLib {

ConfigurationManager_i_factory* ConfigurationManager_i_factory::s_instance = 0;

ConfigurationManager_i_factory::ConfigurationManager_i_factory () {
}

void ConfigurationManager_i_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	ConfigurationManagerFactoryManager::register_factory (this, priority);
	s_instance = this;
}

const char* ConfigurationManager_i_factory::key () const {
	return "ConfigurationManager_i";
}

ConfigurationManager* ConfigurationManager_i_factory::make () {
	return Core::IObject::_duplicate (ConfigurationManager_i::Singleton::instance());
}

ConfigurationManager_i* ConfigurationManager_iServantFactory::make () {
	if (ConfigurationManager_i_factory::s_instance) {
		return dynamic_cast<ConfigurationManager_i*>(ConfigurationManager_i_factory::s_instance->make ());
	} else {
		throw Core::Root::NoActiveFactory ("GblAdapterLib::Settings_i::ConfigurationManager_i_factory");
	}
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

