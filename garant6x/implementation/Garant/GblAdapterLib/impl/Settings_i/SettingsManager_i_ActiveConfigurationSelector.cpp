////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Settings_i/SettingsManager_i_ActiveConfigurationSelector.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> garant6x::GblAdapterLib::Settings_i::SettingsManager_i::ActiveConfigurationSelector
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Settings_i/SettingsManager_i.h"

namespace GblAdapterLib {
class SettingsManager_i;
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from ConfigurationSelector
unsigned long SettingsManager_i::ActiveConfigurationSelector::get () const {
	//#UC START# *4608F10F02B9_4608F1470384*
	ConfigurationManager_var configuration_manager (ConfigurationManagerFactory::make ());
	return configuration_manager->get_active_id ();
	//#UC END# *4608F10F02B9_4608F1470384*
}
} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

