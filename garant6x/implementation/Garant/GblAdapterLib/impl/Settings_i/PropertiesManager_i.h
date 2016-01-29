////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Settings_i/PropertiesManager_i.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Settings_i::PropertiesManager_i
// Заголовок реализации класса серванта для интерфеса PermanentSettingsManager
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
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
	// идентифкатор текущего пользователя
	GCD::PID m_pid;

//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors
private:
	const GCD::PID& get_pid () const;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from BaseSettingsManager
	// Чтение свойства типа Boolean.
	// При успехе возвращает true.
	// Если свойство не существует возвращает false.
	// Если тип свойства не соответствует требуемому поднимается исключение InvalidValueType
	virtual bool get_bool (PropertyStringID_const id, bool& value) /*throw (InvalidValueType)*/;

	// implemented method from BaseSettingsManager
	// Чтение свойства типа int64.
	// При успехе возвращает true.
	// Если свойство не существует возвращает false.
	// Если тип свойства не соответствует требуемому поднимается исключение InvalidValueType
	virtual bool get_int64 (PropertyStringID_const id, long long& value) /*throw (InvalidValueType)*/;

	// implemented method from BaseSettingsManager
	// Чтение свойства типа long.
	// При успехе возвращает true.
	// Если свойство не существует возвращает false.
	// Если тип свойства не соответствует требуемому поднимается исключение InvalidValueType
	virtual bool get_long (PropertyStringID_const id, long& value) /*throw (InvalidValueType)*/;

	// implemented method from BaseSettingsManager
	// Чтение свойства типа String.
	// При успехе возвращает true.
	// Если свойство не существует возвращает false.
	// Если тип свойства не соответствует требуемому поднимается исключение InvalidValueType
	virtual bool get_string (PropertyStringID_const id, GCI::IO::String*& value) /*throw (InvalidValueType)*/;

	// implemented method from BaseSettingsManager
	// Чтение свойства типа unsigned long.
	// При успехе возвращает true.
	// Если свойство не существует возвращает false.
	// Если тип свойства не соответствует требуемому поднимается исключение InvalidValueType
	virtual bool get_ulong (PropertyStringID_const id, unsigned long& value) /*throw (InvalidValueType)*/;

	// implemented method from BaseSettingsManager
	// возвращает true, если параметр с таким именем существует
	virtual bool is_exist (PropertyStringID_const id) const;

	// implemented method from BaseSettingsManager
	// Запись свойства типа Boolean.
	// Если свойство не существует, то оно создается в текущей конфигурации, value записывается как
	// значение по умолчанию и как текущее значение.
	// Если тип свойства не соответствует устанавливаемому поднимается исключение InvalidValueType
	virtual void set_bool (PropertyStringID_const id, bool value) /*throw (InvalidValueType)*/;

	// implemented method from BaseSettingsManager
	// Запись свойства типа int64.
	// Если свойство не существует, то оно создается в текущей конфигурации, value записывается как
	// значение по умолчанию и как текущее значение.
	// Если тип свойства не соответствует устанавливаемому поднимается исключение InvalidValueType
	virtual void set_int64 (PropertyStringID_const id, long long value) /*throw (InvalidValueType)*/;

	// implemented method from BaseSettingsManager
	// Запись свойства типа long.
	// Если свойство не существует, то оно создается в текущей конфигурации, value записывается как
	// значение по умолчанию и как текущее значение.
	// Если тип свойства не соответствует устанавливаемому поднимается исключение InvalidValueType
	virtual void set_long (PropertyStringID_const id, long value) /*throw (InvalidValueType)*/;

	// implemented method from BaseSettingsManager
	// Запись свойства типа String.
	// Если свойство не существует, то оно создается в текущей конфигурации, value записывается как
	// значение по умолчанию и как текущее значение.
	// Если тип свойства не соответствует устанавливаемому поднимается исключение InvalidValueType
	virtual void set_string (PropertyStringID_const id, const char* value) /*throw (InvalidValueType)*/;

	// implemented method from BaseSettingsManager
	// Запись свойства типа unsigned long.
	// Если свойство не существует, то оно создается в текущей конфигурации, value записывается как
	// значение по умолчанию и как текущее значение.
	// Если тип свойства не соответствует устанавливаемому поднимается исключение InvalidValueType
	virtual void set_ulong (PropertyStringID_const id, unsigned long value) /*throw (InvalidValueType)*/;
}; // class PropertiesManager_i

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_SETTINGS_I_PROPERTIESMANAGER_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
