////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Settings_i/PropertiesManager_i.cpp"
// ��������� ������ ���������� C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Settings_i::PropertiesManager_i
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/LibHome.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Settings_i/PropertiesManager_i.h"
// by <<uses>> dependencies
#include "garant6x/implementation/Garant/GblAdapterLib/ApplicationHelper/ApplicationHelper.h"
#include "garantServer/src/Global/Defines/DefinesC.h"

namespace GblAdapterLib {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

PropertiesManager_i::PropertiesManager_i ()
//#UC START# *4AC4999D032C_4AC49AB80031_4AC49AFF0348_BASE_INIT*
//#UC END# *4AC4999D032C_4AC49AB80031_4AC49AFF0348_BASE_INIT*
{
	//#UC START# *4AC4999D032C_4AC49AB80031_4AC49AFF0348_BODY*
	m_pid.m_class_id = Defines::CI_USER;
	m_pid.m_object_id = ApplicationHelper::instance ()->get_cached_current_user_id ();
	//#UC END# *4AC4999D032C_4AC49AB80031_4AC49AFF0348_BODY*
}

PropertiesManager_i::~PropertiesManager_i () {
	//#UC START# *4AC49AFF0348_DESTR_BODY*
	//#UC END# *4AC49AFF0348_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors

const GCD::PID& PropertiesManager_i::get_pid () const {
	//#UC START# *4AC49B4B038D_GET_ACCESSOR*
	return m_pid;
	//#UC END# *4AC49B4B038D_GET_ACCESSOR*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from BaseSettingsManager
// ������ �������� ���� Boolean.
// ��� ������ ���������� true.
// ���� �������� �� ���������� ���������� false.
// ���� ��� �������� �� ������������� ���������� ����������� ���������� InvalidValueType
bool PropertiesManager_i::get_bool (PropertyStringID_const id, bool& value) /*throw (InvalidValueType)*/ {
	//#UC START# *4AC4990B0238_4AC49AFF0348*
	return ApplicationHelper::instance ()->get_cached_property_manager ()->get_boolean_property (m_pid, id, value);
	//#UC END# *4AC4990B0238_4AC49AFF0348*
}

// implemented method from BaseSettingsManager
// ������ �������� ���� int64.
// ��� ������ ���������� true.
// ���� �������� �� ���������� ���������� false.
// ���� ��� �������� �� ������������� ���������� ����������� ���������� InvalidValueType
bool PropertiesManager_i::get_int64 (PropertyStringID_const id, long long& value) /*throw (InvalidValueType)*/ {
	//#UC START# *4AC4990F037A_4AC49AFF0348*
	return ApplicationHelper::instance ()->get_cached_property_manager ()->get_longlong_property (m_pid, id, value);
	//#UC END# *4AC4990F037A_4AC49AFF0348*
}

// implemented method from BaseSettingsManager
// ������ �������� ���� long.
// ��� ������ ���������� true.
// ���� �������� �� ���������� ���������� false.
// ���� ��� �������� �� ������������� ���������� ����������� ���������� InvalidValueType
bool PropertiesManager_i::get_long (PropertyStringID_const id, long& value) /*throw (InvalidValueType)*/ {
	//#UC START# *4AC49912024A_4AC49AFF0348*
	CORBA::Long data;
	bool result = ApplicationHelper::instance ()->get_cached_property_manager ()->get_long_property (m_pid, id, data);
	if (result) {
		value = data;
	}

	return result;
	//#UC END# *4AC49912024A_4AC49AFF0348*
}

// implemented method from BaseSettingsManager
// ������ �������� ���� String.
// ��� ������ ���������� true.
// ���� �������� �� ���������� ���������� false.
// ���� ��� �������� �� ������������� ���������� ����������� ���������� InvalidValueType
bool PropertiesManager_i::get_string (
	PropertyStringID_const id
	, GCI::IO::String*& value
) /*throw (
	InvalidValueType
)*/ {
	//#UC START# *4AC499150301_4AC49AFF0348*
	GslSecurity::StringProperty_var data;
	bool result = ApplicationHelper::instance ()->get_cached_property_manager ()->get_string_property (m_pid, id, data);
	if (result) {
		const char* buffer = reinterpret_cast<const char*> (data->get_buffer ());
		size_t buffer_length = data->length ();
		if (!buffer_length) {
			value = GCI::IO::StringFactory::make ("");
		} else if ((buffer[buffer_length - 1] == 0) && (ACE_OS::strlen (buffer) == (buffer_length - 1))) {
			value = GCI::IO::StringFactory::make (buffer);
		} else {
			value = GCI::IO::BinaryStringFactory::make (buffer, buffer_length);
		}
	}

	return result;
	//#UC END# *4AC499150301_4AC49AFF0348*
}

// implemented method from BaseSettingsManager
// ������ �������� ���� unsigned long.
// ��� ������ ���������� true.
// ���� �������� �� ���������� ���������� false.
// ���� ��� �������� �� ������������� ���������� ����������� ���������� InvalidValueType
bool PropertiesManager_i::get_ulong (PropertyStringID_const id, unsigned long& value) /*throw (InvalidValueType)*/ {
	//#UC START# *4AC49919002B_4AC49AFF0348*
	CORBA::ULong data;
	bool result = ApplicationHelper::instance ()->get_cached_property_manager ()->get_ulong_property (m_pid, id, data);
	if (result) {
		value = data;
	}

	return result;
	//#UC END# *4AC49919002B_4AC49AFF0348*
}

// implemented method from BaseSettingsManager
// ���������� true, ���� �������� � ����� ������ ����������
bool PropertiesManager_i::is_exist (PropertyStringID_const id) const {
	//#UC START# *4AC4993302A8_4AC49AFF0348*
	return ApplicationHelper::instance ()->get_cached_property_manager ()->is_property_exist (m_pid, id);
	//#UC END# *4AC4993302A8_4AC49AFF0348*
}

// implemented method from BaseSettingsManager
// ������ �������� ���� Boolean.
// ���� �������� �� ����������, �� ��� ��������� � ������� ������������, value ������������ ���
// �������� �� ��������� � ��� ������� ��������.
// ���� ��� �������� �� ������������� ���������������� ����������� ���������� InvalidValueType
void PropertiesManager_i::set_bool (PropertyStringID_const id, bool value) /*throw (InvalidValueType)*/ {
	//#UC START# *4AC4991C01E1_4AC49AFF0348*
	ApplicationHelper::instance ()->get_cached_property_manager ()->set_boolean_property (m_pid, id, value);
	//#UC END# *4AC4991C01E1_4AC49AFF0348*
}

// implemented method from BaseSettingsManager
// ������ �������� ���� int64.
// ���� �������� �� ����������, �� ��� ��������� � ������� ������������, value ������������ ���
// �������� �� ��������� � ��� ������� ��������.
// ���� ��� �������� �� ������������� ���������������� ����������� ���������� InvalidValueType
void PropertiesManager_i::set_int64 (PropertyStringID_const id, long long value) /*throw (InvalidValueType)*/ {
	//#UC START# *4AC4991F02F1_4AC49AFF0348*
	ApplicationHelper::instance ()->get_cached_property_manager ()->set_longlong_property (m_pid, id, value);
	//#UC END# *4AC4991F02F1_4AC49AFF0348*
}

// implemented method from BaseSettingsManager
// ������ �������� ���� long.
// ���� �������� �� ����������, �� ��� ��������� � ������� ������������, value ������������ ���
// �������� �� ��������� � ��� ������� ��������.
// ���� ��� �������� �� ������������� ���������������� ����������� ���������� InvalidValueType
void PropertiesManager_i::set_long (PropertyStringID_const id, long value) /*throw (InvalidValueType)*/ {
	//#UC START# *4AC499220301_4AC49AFF0348*
	ApplicationHelper::instance ()->get_cached_property_manager ()->set_long_property (m_pid, id, value);
	//#UC END# *4AC499220301_4AC49AFF0348*
}

// implemented method from BaseSettingsManager
// ������ �������� ���� String.
// ���� �������� �� ����������, �� ��� ��������� � ������� ������������, value ������������ ���
// �������� �� ��������� � ��� ������� ��������.
// ���� ��� �������� �� ������������� ���������������� ����������� ���������� InvalidValueType
void PropertiesManager_i::set_string (PropertyStringID_const id, const char* value) /*throw (InvalidValueType)*/ {
	//#UC START# *4AC4992601BC_4AC49AFF0348*
	if (!value) {
		return;
	}
	GslSecurity::StringProperty data;
	data.length (ACE_OS::strlen (value) + 1);
	ACE_OS::memcpy (data.get_buffer (), value, data.length ());
	data[data.length () - 1] = 0;

	ApplicationHelper::instance ()->get_cached_property_manager ()->set_string_property (m_pid, id, data);
	//#UC END# *4AC4992601BC_4AC49AFF0348*
}

// implemented method from BaseSettingsManager
// ������ �������� ���� unsigned long.
// ���� �������� �� ����������, �� ��� ��������� � ������� ������������, value ������������ ���
// �������� �� ��������� � ��� ������� ��������.
// ���� ��� �������� �� ������������� ���������������� ����������� ���������� InvalidValueType
void PropertiesManager_i::set_ulong (PropertyStringID_const id, unsigned long value) /*throw (InvalidValueType)*/ {
	//#UC START# *4AC499290308_4AC49AFF0348*
	ApplicationHelper::instance ()->get_cached_property_manager ()->set_ulong_property (m_pid, id, value);
	//#UC END# *4AC499290308_4AC49AFF0348*
}
} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

