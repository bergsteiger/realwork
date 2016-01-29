////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/Settings/Settings.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::Settings
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Settings/Settings.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Settings/SettingsFactories.h"

namespace GblAdapterLib {


const char* InvalidValueType::uid () const /*throw ()*/ {
	return "53443A7A-5ED8-4E63-990A-2F20E985BBF1";
}

const char* InvalidValueType::what () const throw () {
	//#UC START# *45EEDDFF0071_WHAT_IMPL*
	return "InvalidValueType (Возвращается при попытке прочитать или присвоить через интерфейс ParameterValues значение по типу, который не совпадает с реальным типом значения (реальный тип можно получить через свойство value_type).)";
	//#UC END# *45EEDDFF0071_WHAT_IMPL*
}

// factory interface wrapper for SettingsManager
SettingsManager* SettingsManagerFactory::make () /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed, NoSession)*/ {
	return SettingsManagerFactoryManager::Singleton::instance ()->make ();
}


const char* ConfigurationIsActiveNow::uid () const /*throw ()*/ {
	return "BD770959-DE38-4B42-9FDB-7C541DDDCC62";
}

const char* ConfigurationIsActiveNow::what () const throw () {
	//#UC START# *45EEDDFF006D_WHAT_IMPL*
	return "ConfigurationIsActiveNow ()";
	//#UC END# *45EEDDFF006D_WHAT_IMPL*
}

// factory interface wrapper for Configuration
Configuration* ConfigurationFactory::make (
	long id
	, const GCI::IO::String* name
	, const GCI::IO::String* hint
	, bool readonly
) /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return ConfigurationFactoryManager::Singleton::instance ()->make (id, name, hint, readonly);
}


const char* ConfigurationsNotDefined::uid () const /*throw ()*/ {
	return "AAF23401-0674-4990-9861-0629AA3C4489";
}

const char* ConfigurationsNotDefined::what () const throw () {
	//#UC START# *45EEDDFF006F_WHAT_IMPL*
	return "ConfigurationsNotDefined ()";
	//#UC END# *45EEDDFF006F_WHAT_IMPL*
}

// factory interface wrapper for DefaultValuesChangesIndicator
DefaultValuesChangesIndicator* DefaultValuesChangesIndicatorFactory::make (
	DefaultValuesChangesState state
	, const Configuration* configuration
) /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return DefaultValuesChangesIndicatorFactoryManager::Singleton::instance ()->make (state, configuration);
}

// factory interface wrapper for ConfigurationManager
ConfigurationManager* ConfigurationManagerFactory::make () /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return ConfigurationManagerFactoryManager::Singleton::instance ()->make ();
}

// factory interface wrapper for PermanentSettingsManager
PermanentSettingsManager* PermanentSettingsManagerFactory::make () /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return PermanentSettingsManagerFactoryManager::Singleton::instance ()->make ();
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

