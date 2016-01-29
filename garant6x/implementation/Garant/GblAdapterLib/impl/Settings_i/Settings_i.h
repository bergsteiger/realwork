////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Settings_i/Settings_i.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Impl::Category>> garant6x::GblAdapterLib::Settings_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_SETTINGS_I_H__
#define __GARANT6X_GBLADAPTERLIB_SETTINGS_I_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include <set>
#include "shared/GCI/IO/IO.h"
#include "garantServer/src/Global/Core/gcdC.h"
#include "garant6x/implementation/Garant/GblAdapterLib/BaseTypes/BaseTypes.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Start_i/Start_i.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Settings/Settings.h"
#include "garantServer/src/Business/GblSettings/SettingsStorageC.h"
#include "garantServer/src/Business/GblSettings/GblSettingsC.h"
#include "garantServer/src/Business/GblLogging/GblLoggingC.h"
#include "garantServer/src/Global/Defines/DefinesC.h"


namespace GblAdapterLib {

// данные для сохранения настройки на сервере
struct ServerSettingData {
	long conf_id;
	long prop_id;
	SettingsStorage::PropertyValue prop_value;
	long long time;

	ServerSettingData (
		long conf_id_
		, long prop_id_
		, const SettingsStorage::PropertyValue& prop_value_
		, long long time_
	);

	// используется для поиска элемента в кешированных данных
	ServerSettingData (long conf, long prop);
	bool operator < (const ServerSettingData& y) const;
};

// данные для отправки на сервер
typedef std::set < ServerSettingData > CachedDataForServer;

// стратегия сохранения настроек
enum SettingsSaveStrategy {
	SSS_INTIME // сразу писать настройки на сервер
	, SSS_CACHE // сохранять настройки в кеше с периодическим сбросом на сервер
	, SSS_NOTSAVE // не сохранять настройки на сервере
};

// константы, связанные с использованием кеша настроек для сбрасывания на сервер. Если таймаут
// меньше нуля, настройеки на сервер вообще не пишутся, если равен нулю, то пишутся сразу без
// использования кеша
static const std::string DELTA_OPTION_NAME = "-SettingsFlushTimeout"; // название опции, задающей таймаут сбрасывания настроек на сервер
static const long DELTA_OPTION_VALUE = 600; // значение таймаута по-умолчанию

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_SETTINGS_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

