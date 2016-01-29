////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Settings_i/Settings_i.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Impl::Category>> garant6x::GblAdapterLib::Settings_i
//
//
// ��� ����� ����������� ��� ��� "������-������".
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

// ������ ��� ���������� ��������� �� �������
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

	// ������������ ��� ������ �������� � ������������ ������
	ServerSettingData (long conf, long prop);
	bool operator < (const ServerSettingData& y) const;
};

// ������ ��� �������� �� ������
typedef std::set < ServerSettingData > CachedDataForServer;

// ��������� ���������� ��������
enum SettingsSaveStrategy {
	SSS_INTIME // ����� ������ ��������� �� ������
	, SSS_CACHE // ��������� ��������� � ���� � ������������� ������� �� ������
	, SSS_NOTSAVE // �� ��������� ��������� �� �������
};

// ���������, ��������� � �������������� ���� �������� ��� ����������� �� ������. ���� �������
// ������ ����, ���������� �� ������ ������ �� �������, ���� ����� ����, �� ������� ����� ���
// ������������� ����
static const std::string DELTA_OPTION_NAME = "-SettingsFlushTimeout"; // �������� �����, �������� ������� ����������� �������� �� ������
static const long DELTA_OPTION_VALUE = 600; // �������� �������� ��-���������

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_SETTINGS_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

