////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Prime_i/PrimeSettingsManager_i.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Prime_i::PrimeSettingsManager_i
// Заголовок реализации класса серванта для интерфеса PrimeSettingsManager
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
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
}; // class PrimeSettingsManager_i

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_PRIME_I_PRIMESETTINGSMANAGER_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
