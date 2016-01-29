////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Settings_i/Settings_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Impl::Category>> garant6x::GblAdapterLib::Settings_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Settings_i/Settings_i.h"


namespace GblAdapterLib {

bool ServerSettingData::operator < (const ServerSettingData& y) const {
	//#UC START# *488DD13303A4_LESS*
	if (conf_id == y.conf_id)
		return prop_id < y.prop_id;

	return conf_id < y.conf_id;
	//#UC END# *488DD13303A4_LESS*
}

ServerSettingData::ServerSettingData (
	long conf_id_
	, long prop_id_
	, const SettingsStorage::PropertyValue& prop_value_
	, long long time_
)
//#UC START# *488DD13303A4_INIT_CTOR_BASE_INIT*
: conf_id (conf_id_), prop_id (prop_id_), prop_value (prop_value_), time (time_)
//#UC END# *488DD13303A4_INIT_CTOR_BASE_INIT*
{
	//#UC START# *488DD13303A4_INIT_CTOR*
	//#UC END# *488DD13303A4_INIT_CTOR*
}

// используется для поиска элемента в кешированных данных
ServerSettingData::ServerSettingData (long conf, long prop)
//#UC START# *489816C3023E_INIT_CTOR_BASE_INIT*
: conf_id (conf), prop_id (prop)
//#UC END# *489816C3023E_INIT_CTOR_BASE_INIT*
{
	//#UC START# *489816C3023E_CTOR_BODY*
	//#UC END# *489816C3023E_CTOR_BODY*
}


} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

