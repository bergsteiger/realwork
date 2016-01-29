////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Settings_i/SettingsManager_i_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Settings_i::SettingsManager_i
//
// Реализация интерфейса работы с настройками. Обеспечивает создание новых свойств и их получение.
// Свойство характеризуется строковым идентификатором. Интерфейс может быть получен или  из
// интерфейса Common,  в этом случае он обеспечивает доступ к свойствам активной конфигурации, или
// из интерфейса Configuration, тогда обеспечивается работа со свойствами этой конфигурации.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Settings_i/SettingsManager_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Settings_i/SettingsManager_i.h"

namespace GblAdapterLib {

SettingsManager_i_factory* SettingsManager_i_factory::s_instance = 0;

SettingsManager_i_factory::SettingsManager_i_factory () {
}

void SettingsManager_i_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	SettingsManagerFactoryManager::register_factory (this, priority);
	s_instance = this;
}

const char* SettingsManager_i_factory::key () const {
	return "SettingsManager_i";
}

SettingsManager* SettingsManager_i_factory::make () /*throw (NoSession)*/ {
	//#UC START# *45EEDBE3011945F11B3D03E7_46235C64032C_IMPL*
	return new SettingsManager_i (new SettingsManager_i::ActiveConfigurationSelector ());
	//#UC END# *45EEDBE3011945F11B3D03E7_46235C64032C_IMPL*
}

SettingsManager_i* SettingsManager_iServantFactory::make () /*throw (NoSession)*/ {
	if (SettingsManager_i_factory::s_instance) {
		return dynamic_cast<SettingsManager_i*>(SettingsManager_i_factory::s_instance->make ());
	} else {
		throw Core::Root::NoActiveFactory ("GblAdapterLib::Settings_i::SettingsManager_i_factory");
	}
}

SettingsManager_i* SettingsManager_iServantFactory::make (const SettingsManager_i::ConfigurationSelector* selector) /*throw (NoSession)*/ {
	//#UC START# *45F11B3D03E745F11B3D03E7_4608EE860317_IMPL*
	SettingsManager_i_var ret = new SettingsManager_i (selector);
	return ret._retn ();
	//#UC END# *45F11B3D03E745F11B3D03E7_4608EE860317_IMPL*
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

