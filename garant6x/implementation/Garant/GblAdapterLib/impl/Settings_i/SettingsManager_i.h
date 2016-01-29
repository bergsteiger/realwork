////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Settings_i/SettingsManager_i.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Settings_i::SettingsManager_i
// ��������� ���������� ������ �������� ��� ��������� SettingsManager
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
#ifndef __GARANT6X_GBLADAPTERLIB_SETTINGS_I_SETTINGSMANAGER_I_H__
#define __GARANT6X_GBLADAPTERLIB_SETTINGS_I_SETTINGSMANAGER_I_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/BaseTypes/BaseTypes.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Settings/Settings.h"

//#UC START# *45F11B3D03E7_CUSTOM_INCLUDES*
//#UC END# *45F11B3D03E7_CUSTOM_INCLUDES*

namespace GblAdapterLib {

class SettingsManager_i; // self forward Var
typedef ::Core::Var<SettingsManager_i> SettingsManager_i_var;
typedef ::Core::Var<const SettingsManager_i> SettingsManager_i_cvar;

class SettingsManager_i_factory;
class SettingsManager_iServantFactory;

// ���������� ���������� ������ � �����������. ������������ �������� ����� ������� � �� ���������.
// �������� ��������������� ��������� ���������������. ��������� ����� ���� ������� ���  ��
// ���������� Common,  � ���� ������ �� ������������ ������ � ��������� �������� ������������, ���
// �� ���������� Configuration, ����� �������������� ������ �� ���������� ���� ������������.
class SettingsManager_i:
	virtual public SettingsManager
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (SettingsManager_i)
	friend class SettingsManager_i_factory; // self factory
	friend class SettingsManager_iServantFactory;

//////////////////////////////////////////////////////////////////////////////////////////
// nested declarations
public:
	class ConfigurationSelector;
	typedef Core::Var<ConfigurationSelector> ConfigurationSelector_var;
	typedef Core::Var<const ConfigurationSelector> ConfigurationSelector_cvar;

	class ConfigurationSelector :
		virtual public Core::RefCountObjectBase
	{
	// virtual void destructor
	public:
		virtual ~ConfigurationSelector () {};

	//////////////////////////////////////////////////////////////////////////////////////////
	// abstarct methods
	public:
		virtual unsigned long get () const = 0;

	}; // class ConfigurationSelector

	class ActiveConfigurationSelector;
	typedef Core::Var<ActiveConfigurationSelector> ActiveConfigurationSelector_var;
	typedef Core::Var<const ActiveConfigurationSelector> ActiveConfigurationSelector_cvar;

	class ActiveConfigurationSelector :
		public ConfigurationSelector
	{
	//////////////////////////////////////////////////////////////////////////////////////////
	// constructors and destructor

	//////////////////////////////////////////////////////////////////////////////////////////
	// implemented interface's methods
	public:

		// implemented method from ConfigurationSelector
		unsigned long get () const;
	}; // class ActiveConfigurationSelector

	class FixedConfigurationSelector;
	typedef Core::Var<FixedConfigurationSelector> FixedConfigurationSelector_var;
	typedef Core::Var<const FixedConfigurationSelector> FixedConfigurationSelector_cvar;

	class FixedConfigurationSelector :
		public ConfigurationSelector
	{
	//////////////////////////////////////////////////////////////////////////////////////////
	// constructors and destructor
public:
		explicit FixedConfigurationSelector (unsigned long id);

	//////////////////////////////////////////////////////////////////////////////////////////
	// self data
	private:
		unsigned long m_id;

	//////////////////////////////////////////////////////////////////////////////////////////
	// implemented interface's methods
	public:

		// implemented method from ConfigurationSelector
		unsigned long get () const;
	}; // class FixedConfigurationSelector

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	explicit SettingsManager_i (const ConfigurationSelector* selector);

	virtual ~SettingsManager_i ();
//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	ConfigurationSelector_var m_configuration_selector;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from BaseSettingsManager
	// ������ �������� ���� Boolean.
	// ��� ������ ���������� true.
	// ���� �������� �� ���������� ���������� false.
	// ���� ��� �������� �� ������������� ���������� ����������� ���������� InvalidValueType
	virtual bool get_bool (PropertyStringID_const id, bool& value) /*throw (InvalidValueType)*/;

	// implemented method from BaseSettingsManager
	// ������ �������� ���� int64.
	// ��� ������ ���������� true.
	// ���� �������� �� ���������� ���������� false.
	// ���� ��� �������� �� ������������� ���������� ����������� ���������� InvalidValueType
	virtual bool get_int64 (PropertyStringID_const id, long long& value) /*throw (InvalidValueType)*/;

	// implemented method from BaseSettingsManager
	// ������ �������� ���� long.
	// ��� ������ ���������� true.
	// ���� �������� �� ���������� ���������� false.
	// ���� ��� �������� �� ������������� ���������� ����������� ���������� InvalidValueType
	virtual bool get_long (PropertyStringID_const id, long& value) /*throw (InvalidValueType)*/;

	// implemented method from BaseSettingsManager
	// ������ �������� ���� String.
	// ��� ������ ���������� true.
	// ���� �������� �� ���������� ���������� false.
	// ���� ��� �������� �� ������������� ���������� ����������� ���������� InvalidValueType
	virtual bool get_string (PropertyStringID_const id, GCI::IO::String*& value) /*throw (InvalidValueType)*/;

	// implemented method from BaseSettingsManager
	// ������ �������� ���� unsigned long.
	// ��� ������ ���������� true.
	// ���� �������� �� ���������� ���������� false.
	// ���� ��� �������� �� ������������� ���������� ����������� ���������� InvalidValueType
	virtual bool get_ulong (PropertyStringID_const id, unsigned long& value) /*throw (InvalidValueType)*/;

	// implemented method from BaseSettingsManager
	// ���������� true, ���� �������� � ����� ������ ����������
	virtual bool is_exist (PropertyStringID_const id) const;

	// implemented method from BaseSettingsManager
	// ������ �������� ���� Boolean.
	// ���� �������� �� ����������, �� ��� ��������� � ������� ������������, value ������������ ���
	// �������� �� ��������� � ��� ������� ��������.
	// ���� ��� �������� �� ������������� ���������������� ����������� ���������� InvalidValueType
	virtual void set_bool (PropertyStringID_const id, bool value) /*throw (InvalidValueType)*/;

	// implemented method from BaseSettingsManager
	// ������ �������� ���� int64.
	// ���� �������� �� ����������, �� ��� ��������� � ������� ������������, value ������������ ���
	// �������� �� ��������� � ��� ������� ��������.
	// ���� ��� �������� �� ������������� ���������������� ����������� ���������� InvalidValueType
	virtual void set_int64 (PropertyStringID_const id, long long value) /*throw (InvalidValueType)*/;

	// implemented method from BaseSettingsManager
	// ������ �������� ���� long.
	// ���� �������� �� ����������, �� ��� ��������� � ������� ������������, value ������������ ���
	// �������� �� ��������� � ��� ������� ��������.
	// ���� ��� �������� �� ������������� ���������������� ����������� ���������� InvalidValueType
	virtual void set_long (PropertyStringID_const id, long value) /*throw (InvalidValueType)*/;

	// implemented method from BaseSettingsManager
	// ������ �������� ���� String.
	// ���� �������� �� ����������, �� ��� ��������� � ������� ������������, value ������������ ���
	// �������� �� ��������� � ��� ������� ��������.
	// ���� ��� �������� �� ������������� ���������������� ����������� ���������� InvalidValueType
	virtual void set_string (PropertyStringID_const id, const char* value) /*throw (InvalidValueType)*/;

	// implemented method from BaseSettingsManager
	// ������ �������� ���� unsigned long.
	// ���� �������� �� ����������, �� ��� ��������� � ������� ������������, value ������������ ���
	// �������� �� ��������� � ��� ������� ��������.
	// ���� ��� �������� �� ������������� ���������������� ����������� ���������� InvalidValueType
	virtual void set_ulong (PropertyStringID_const id, unsigned long value) /*throw (InvalidValueType)*/;

	// implemented method from SettingsManager
	// ���������� ��������� � ���������� ���������
	virtual bool get_definition (PropertyStringID_const id, PropertyDefinition& definition) const;

	// implemented method from SettingsManager
	// ���������� true, ���� ������� �������� �� ����� �������� �� ���������, � ��������� ������
	// ���������� false
	virtual bool is_changed (PropertyStringID_const id) const;

	// implemented method from SettingsManager
	virtual bool is_changed_set (const PropertyStringIDList& id_list) const;

	// implemented method from SettingsManager
	// ������������� ���������� �������� ������� �������� ������� �������� �� ���������
	virtual void restore_default (PropertyStringID_const id) const /*throw (CanNotFindData)*/;

	// implemented method from SettingsManager
	// ���������� ������� �������� �������� � ��������  ��� �������� �� ���������
	virtual void save_as_default (PropertyStringID_const id) const /*throw (CanNotFindData)*/;

//#UC START# *45F11B3D03E7*
//#UC END# *45F11B3D03E7*
}; // class SettingsManager_i

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_SETTINGS_I_SETTINGSMANAGER_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
