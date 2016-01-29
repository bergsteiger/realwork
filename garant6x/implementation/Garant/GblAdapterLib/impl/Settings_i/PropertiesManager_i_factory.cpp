////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Settings_i/PropertiesManager_i_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Settings_i::PropertiesManager_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Settings_i/PropertiesManager_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Settings_i/PropertiesManager_i.h"

namespace GblAdapterLib {

PropertiesManager_i_factory::PropertiesManager_i_factory () {
}

void PropertiesManager_i_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	PermanentSettingsManagerFactoryManager::register_factory (this, priority);
}

const char* PropertiesManager_i_factory::key () const {
	return "PropertiesManager_i";
}

PermanentSettingsManager* PropertiesManager_i_factory::make () {
	return Core::IObject::_duplicate (PropertiesManager_i::Singleton::instance());
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

