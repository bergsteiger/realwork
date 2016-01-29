////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Settings_i/SettingsManager_i.cpp"
// ��������� ������ ���������� C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Settings_i::SettingsManager_i
//
// ���������� ���������� ������ � �����������. ������������ �������� ����� ������� � �� ���������.
// �������� ��������������� ��������� ���������������. ��������� ����� ���� ������� ���  ��
// ���������� Common,  � ���� ������ �� ������������ ������ � ��������� �������� ������������, ���
// �� ���������� Configuration, ����� �������������� ������ �� ���������� ���� ������������.
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/LibHome.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Settings_i/SettingsManager_i.h"
// by <<uses>> dependencies
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Settings_i/ConfigurationManager_i.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Settings_i/ConfigurationManager_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/ApplicationHelper/SessionHelper.h"

//#UC START# *45F11B3D03E7_CUSTOM_INCLUDES*
#define GET_BODY(OPERATION, TYPE)                                                                        \
	try {                                                                                                  \
		const SettingsStorage::PropertyValue* property_value                                                 \
			= ConfigurationManager_iServantFactory::make ()->get_property_value (m_configuration_selector->get (), id, TYPE); \
		if (property_value) {                                                                                \
			value = OPERATION;                                                  \
			return true;                                                                                       \
		}                                                                                                    \
	} catch (InvalidValueType&) {                                                                          \
		throw;                                                                                               \
	}                                                                                                      \
	return false;


#define SET_BODY(OPERATION)                            \
	SettingsStorage::PropertyValue property_value;       \
	property_value.OPERATION (value);                    \
	ConfigurationManager_iServantFactory::make ()->set_property_value ( \
		m_configuration_selector->get ()                   \
		, id                                               \
		, property_value                                   \
	);
//#UC END# *45F11B3D03E7_CUSTOM_INCLUDES*

namespace GblAdapterLib {

//#UC START# *45F11B3D03E7*
//#UC END# *45F11B3D03E7*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

SettingsManager_i::SettingsManager_i (const ConfigurationSelector* selector)
//#UC START# *4608EE860317_BASE_INIT*
 	: m_configuration_selector (const_cast<ConfigurationSelector*> (selector))
//#UC END# *4608EE860317_BASE_INIT*
{
	//#UC START# *4608EE860317_BODY*
	if (!SessionHelper::instance()->get_is_session_active ()) {
		throw NoSession ();
	}
	//#UC END# *4608EE860317_BODY*
}

SettingsManager_i::~SettingsManager_i () {
	//#UC START# *45F11B3D03E7_DESTR_BODY*
	//#UC END# *45F11B3D03E7_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from BaseSettingsManager
// ������ �������� ���� Boolean.
// ��� ������ ���������� true.
// ���� �������� �� ���������� ���������� false.
// ���� ��� �������� �� ������������� ���������� ����������� ���������� InvalidValueType
bool SettingsManager_i::get_bool (PropertyStringID_const id, bool& value) /*throw (InvalidValueType)*/ {
	//#UC START# *4AC4990B0238_45F11B3D03E7*
	GET_BODY ((property_value->bool_value () ? true : false), PT_BOOLEAN)
	//#UC END# *4AC4990B0238_45F11B3D03E7*
}

// implemented method from BaseSettingsManager
// ������ �������� ���� int64.
// ��� ������ ���������� true.
// ���� �������� �� ���������� ���������� false.
// ���� ��� �������� �� ������������� ���������� ����������� ���������� InvalidValueType
bool SettingsManager_i::get_int64 (PropertyStringID_const id, long long& value) /*throw (InvalidValueType)*/ {
	//#UC START# *4AC4990F037A_45F11B3D03E7*
	GET_BODY ((property_value->int64_value ()), PT_INT64)
	//#UC END# *4AC4990F037A_45F11B3D03E7*
}

// implemented method from BaseSettingsManager
// ������ �������� ���� long.
// ��� ������ ���������� true.
// ���� �������� �� ���������� ���������� false.
// ���� ��� �������� �� ������������� ���������� ����������� ���������� InvalidValueType
bool SettingsManager_i::get_long (PropertyStringID_const id, long& value) /*throw (InvalidValueType)*/ {
	//#UC START# *4AC49912024A_45F11B3D03E7*
	GET_BODY ((property_value->long_value ()), PT_LONG)
	//#UC END# *4AC49912024A_45F11B3D03E7*
}

// implemented method from BaseSettingsManager
// ������ �������� ���� String.
// ��� ������ ���������� true.
// ���� �������� �� ���������� ���������� false.
// ���� ��� �������� �� ������������� ���������� ����������� ���������� InvalidValueType
bool SettingsManager_i::get_string (PropertyStringID_const id, GCI::IO::String*& value) /*throw (InvalidValueType)*/ {
	//#UC START# *4AC499150301_45F11B3D03E7*
	GET_BODY (GCI::IO::StringFactory::make (static_cast<const char*> (property_value->string_value ())), PT_STRING)
	//#UC END# *4AC499150301_45F11B3D03E7*
}

// implemented method from BaseSettingsManager
// ������ �������� ���� unsigned long.
// ��� ������ ���������� true.
// ���� �������� �� ���������� ���������� false.
// ���� ��� �������� �� ������������� ���������� ����������� ���������� InvalidValueType
bool SettingsManager_i::get_ulong (PropertyStringID_const id, unsigned long& value) /*throw (InvalidValueType)*/ {
	//#UC START# *4AC49919002B_45F11B3D03E7*
	GET_BODY ((property_value->ulong_value ()), PT_ULONG)
	//#UC END# *4AC49919002B_45F11B3D03E7*
}

// implemented method from BaseSettingsManager
// ���������� true, ���� �������� � ����� ������ ����������
bool SettingsManager_i::is_exist (PropertyStringID_const id) const {
	//#UC START# *4AC4993302A8_45F11B3D03E7*
	return ConfigurationManager_iServantFactory::make ()->is_exist (m_configuration_selector->get (), id);
	//#UC END# *4AC4993302A8_45F11B3D03E7*
}

// implemented method from BaseSettingsManager
// ������ �������� ���� Boolean.
// ���� �������� �� ����������, �� ��� ��������� � ������� ������������, value ������������ ���
// �������� �� ��������� � ��� ������� ��������.
// ���� ��� �������� �� ������������� ���������������� ����������� ���������� InvalidValueType
void SettingsManager_i::set_bool (PropertyStringID_const id, bool value) /*throw (InvalidValueType)*/ {
	//#UC START# *4AC4991C01E1_45F11B3D03E7*
	SET_BODY (bool_value)
	//#UC END# *4AC4991C01E1_45F11B3D03E7*
}

// implemented method from BaseSettingsManager
// ������ �������� ���� int64.
// ���� �������� �� ����������, �� ��� ��������� � ������� ������������, value ������������ ���
// �������� �� ��������� � ��� ������� ��������.
// ���� ��� �������� �� ������������� ���������������� ����������� ���������� InvalidValueType
void SettingsManager_i::set_int64 (PropertyStringID_const id, long long value) /*throw (InvalidValueType)*/ {
	//#UC START# *4AC4991F02F1_45F11B3D03E7*
	SET_BODY (int64_value)
	//#UC END# *4AC4991F02F1_45F11B3D03E7*
}

// implemented method from BaseSettingsManager
// ������ �������� ���� long.
// ���� �������� �� ����������, �� ��� ��������� � ������� ������������, value ������������ ���
// �������� �� ��������� � ��� ������� ��������.
// ���� ��� �������� �� ������������� ���������������� ����������� ���������� InvalidValueType
void SettingsManager_i::set_long (PropertyStringID_const id, long value) /*throw (InvalidValueType)*/ {
	//#UC START# *4AC499220301_45F11B3D03E7*
	SET_BODY (long_value)
	//#UC END# *4AC499220301_45F11B3D03E7*
}

// implemented method from BaseSettingsManager
// ������ �������� ���� String.
// ���� �������� �� ����������, �� ��� ��������� � ������� ������������, value ������������ ���
// �������� �� ��������� � ��� ������� ��������.
// ���� ��� �������� �� ������������� ���������������� ����������� ���������� InvalidValueType
void SettingsManager_i::set_string (PropertyStringID_const id, const char* value) /*throw (InvalidValueType)*/ {
	//#UC START# *4AC4992601BC_45F11B3D03E7*
	if (!value) {
		value = "";
	}
	SET_BODY (string_value)
	//#UC END# *4AC4992601BC_45F11B3D03E7*
}

// implemented method from BaseSettingsManager
// ������ �������� ���� unsigned long.
// ���� �������� �� ����������, �� ��� ��������� � ������� ������������, value ������������ ���
// �������� �� ��������� � ��� ������� ��������.
// ���� ��� �������� �� ������������� ���������������� ����������� ���������� InvalidValueType
void SettingsManager_i::set_ulong (PropertyStringID_const id, unsigned long value) /*throw (InvalidValueType)*/ {
	//#UC START# *4AC499290308_45F11B3D03E7*
	SET_BODY (ulong_value)
	//#UC END# *4AC499290308_45F11B3D03E7*
}

// implemented method from SettingsManager
// ���������� ��������� � ���������� ���������
bool SettingsManager_i::get_definition (PropertyStringID_const id, PropertyDefinition& definition) const {
	//#UC START# *45EEDBE3011E_45F11B3D03E7*
	return ConfigurationManager_iServantFactory::make ()->get_definition (id, definition);
	//#UC END# *45EEDBE3011E_45F11B3D03E7*
}

// implemented method from SettingsManager
// ���������� true, ���� ������� �������� �� ����� �������� �� ���������, � ��������� ������
// ���������� false
bool SettingsManager_i::is_changed (PropertyStringID_const id) const {
	//#UC START# *45EEDBE3013F_45F11B3D03E7*
	return ConfigurationManager_iServantFactory::make ()->is_changed (m_configuration_selector->get (), id);
	//#UC END# *45EEDBE3013F_45F11B3D03E7*
}

// implemented method from SettingsManager
bool SettingsManager_i::is_changed_set (const PropertyStringIDList& id_list) const {
	//#UC START# *4979D8CA0243_45F11B3D03E7*
	return ConfigurationManager_iServantFactory::make ()->is_changed_set (m_configuration_selector->get (), id_list);
	//#UC END# *4979D8CA0243_45F11B3D03E7*
}

// implemented method from SettingsManager
// ������������� ���������� �������� ������� �������� ������� �������� �� ���������
void SettingsManager_i::restore_default (PropertyStringID_const id) const /*throw (CanNotFindData)*/ {
	//#UC START# *45EEDBE3011A_45F11B3D03E7*
	ConfigurationManager_iServantFactory::make ()->restore_default (m_configuration_selector->get (), id);
	//#UC END# *45EEDBE3011A_45F11B3D03E7*
}

// implemented method from SettingsManager
// ���������� ������� �������� �������� � ��������  ��� �������� �� ���������
void SettingsManager_i::save_as_default (PropertyStringID_const id) const /*throw (CanNotFindData)*/ {
	//#UC START# *45EEDBE3011C_45F11B3D03E7*
	ConfigurationManager_iServantFactory::make ()->save_as_default (m_configuration_selector->get (), id);
	//#UC END# *45EEDBE3011C_45F11B3D03E7*
}
} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

