////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Prime_i/PrimeSettingsManager_i.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Prime_i::PrimeSettingsManager_i
// ��������� ���������� ������ �������� ��� ��������� PrimeSettingsManager
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_PRIME_I_PRIMESETTINGSMANAGER_I_H__
#define __GARANT6X_GBLADAPTERLIB_PRIME_I_PRIMESETTINGSMANAGER_I_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Prime/Prime.h"

namespace GblAdapterLib {

class PrimeSettingsManager_i; // self forward Var
typedef ::Core::Var<PrimeSettingsManager_i> PrimeSettingsManager_i_var;
typedef ::Core::Var<const PrimeSettingsManager_i> PrimeSettingsManager_i_cvar;

class PrimeSettingsManager_i_factory;

class PrimeSettingsManager_i:
	virtual public PrimeSettingsManager
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (PrimeSettingsManager_i)
	friend class PrimeSettingsManager_i_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	PrimeSettingsManager_i ();

	virtual ~PrimeSettingsManager_i ();

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
}; // class PrimeSettingsManager_i

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_PRIME_I_PRIMESETTINGSMANAGER_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
