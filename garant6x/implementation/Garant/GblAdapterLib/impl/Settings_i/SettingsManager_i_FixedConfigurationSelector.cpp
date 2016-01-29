////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Settings_i/SettingsManager_i_FixedConfigurationSelector.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> garant6x::GblAdapterLib::Settings_i::SettingsManager_i::FixedConfigurationSelector
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

SettingsManager_i::FixedConfigurationSelector::FixedConfigurationSelector (unsigned long id)
//#UC START# *4608F287024B_BASE_INIT*
	: m_id (id)
//#UC END# *4608F287024B_BASE_INIT*
{
	//#UC START# *4608F287024B_BODY*
	//#UC END# *4608F287024B_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from ConfigurationSelector
unsigned long SettingsManager_i::FixedConfigurationSelector::get () const {
	//#UC START# *4608F10F02B9_4608F23B0029*
	return m_id;
	//#UC END# *4608F10F02B9_4608F23B0029*
}
} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

