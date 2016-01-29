////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Settings_i/StoreSettingsToServer.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> garant6x::GblAdapterLib::Settings_i::StoreSettingsToServer
//
// класс периодически сбрасывающий изменённые настройки на сервер
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Settings_i/StoreSettingsToServer.h"
// by <<friend>> dependencies
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Settings_i/ConfigurationManager_i.h"

namespace GblAdapterLib {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

StoreSettingsToServer::~StoreSettingsToServer () {
	//#UC START# *4889E960019F_DESTR_BODY*
	//#UC END# *4889E960019F_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from GCL::TimerHelper
int StoreSettingsToServer::handler (const void* data) {
	//#UC START# *488D8D3C0237_4889E960019F*
	GDS_ASSERT (data);
	ConfigurationManager_i* manager = (ConfigurationManager_i*) data;
	manager->flush_settings_to_server ();

	return 0;
	//#UC END# *488D8D3C0237_4889E960019F*
}
} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

