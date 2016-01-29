////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Settings_i/PropertiesManager_i.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Settings_i::PropertiesManager_i
// ��������� ���������� ������ �������� ��� ��������� PermanentSettingsManager
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_SETTINGS_I_PROPERTIESMANAGER_I_H__
#define __GARANT6X_GBLADAPTERLIB_SETTINGS_I_PROPERTIESMANAGER_I_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "ace/Singleton.h"
#include "garantServer/src/Global/Core/gcdC.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Settings/Settings.h"

namespace GblAdapterLib {

class PropertiesManager_i; // self forward Var
typedef ::Core::Var<PropertiesManager_i> PropertiesManager_i_var;
typedef ::Core::Var<const PropertiesManager_i> PropertiesManager_i_cvar;

class PropertiesManager_i_factory;

class PropertiesManager_i:
	virtual public PermanentSettingsManager
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (PropertiesManager_i)
	friend class PropertiesManager_i_factory; // self factory

	// singleton declaration
	typedef ACE_Singleton <PropertiesManager_i, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <PropertiesManager_i, ACE_SYNCH_RECURSIVE_MUTEX>;

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	PropertiesManager_i ();

	virtual ~PropertiesManager_i ();
//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	// ������������ �������� ������������
	GCD::PID m_pid;

//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors
private:
	const GCD::PID& get_pid () const;

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
}; // class PropertiesManager_i

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_SETTINGS_I_PROPERTIESMANAGER_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
