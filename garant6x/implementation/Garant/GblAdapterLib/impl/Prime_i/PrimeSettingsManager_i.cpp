////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Prime_i/PrimeSettingsManager_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Prime_i::PrimeSettingsManager_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/LibHome.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Prime_i/PrimeSettingsManager_i.h"

namespace GblAdapterLib {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

PrimeSettingsManager_i::PrimeSettingsManager_i ()
//#UC START# *4C98A5F102DA_4C98A6130388_4C98A69E00F0_BASE_INIT*
//#UC END# *4C98A5F102DA_4C98A6130388_4C98A69E00F0_BASE_INIT*
{
	//#UC START# *4C98A5F102DA_4C98A6130388_4C98A69E00F0_BODY*
	//#UC END# *4C98A5F102DA_4C98A6130388_4C98A69E00F0_BODY*
}

PrimeSettingsManager_i::~PrimeSettingsManager_i () {
	//#UC START# *4C98A69E00F0_DESTR_BODY*
	//#UC END# *4C98A69E00F0_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from BaseSettingsManager
// Чтение свойства типа Boolean.
// При успехе возвращает true.
// Если свойство не существует возвращает false.
// Если тип свойства не соответствует требуемому поднимается исключение InvalidValueType
bool PrimeSettingsManager_i::get_bool (PropertyStringID_const id, bool& value) /*throw (InvalidValueType)*/ {
	//#UC START# *4AC4990B0238_4C98A69E00F0*
	return false;
	//#UC END# *4AC4990B0238_4C98A69E00F0*
}

// implemented method from BaseSettingsManager
// Чтение свойства типа int64.
// При успехе возвращает true.
// Если свойство не существует возвращает false.
// Если тип свойства не соответствует требуемому поднимается исключение InvalidValueType
bool PrimeSettingsManager_i::get_int64 (PropertyStringID_const id, long long& value) /*throw (InvalidValueType)*/ {
	//#UC START# *4AC4990F037A_4C98A69E00F0*
	return false;
	//#UC END# *4AC4990F037A_4C98A69E00F0*
}

// implemented method from BaseSettingsManager
// Чтение свойства типа long.
// При успехе возвращает true.
// Если свойство не существует возвращает false.
// Если тип свойства не соответствует требуемому поднимается исключение InvalidValueType
bool PrimeSettingsManager_i::get_long (PropertyStringID_const id, long& value) /*throw (InvalidValueType)*/ {
	//#UC START# *4AC49912024A_4C98A69E00F0*
	return false;
	//#UC END# *4AC49912024A_4C98A69E00F0*
}

// implemented method from BaseSettingsManager
// Чтение свойства типа String.
// При успехе возвращает true.
// Если свойство не существует возвращает false.
// Если тип свойства не соответствует требуемому поднимается исключение InvalidValueType
bool PrimeSettingsManager_i::get_string (
	PropertyStringID_const id
	, GCI::IO::String*& value
) /*throw (
	InvalidValueType
)*/ {
	//#UC START# *4AC499150301_4C98A69E00F0*
	return false;
	//#UC END# *4AC499150301_4C98A69E00F0*
}

// implemented method from BaseSettingsManager
// Чтение свойства типа unsigned long.
// При успехе возвращает true.
// Если свойство не существует возвращает false.
// Если тип свойства не соответствует требуемому поднимается исключение InvalidValueType
bool PrimeSettingsManager_i::get_ulong (PropertyStringID_const id, unsigned long& value) /*throw (InvalidValueType)*/ {
	//#UC START# *4AC49919002B_4C98A69E00F0*
	return false;
	//#UC END# *4AC49919002B_4C98A69E00F0*
}

// implemented method from BaseSettingsManager
// возвращает true, если параметр с таким именем существует
bool PrimeSettingsManager_i::is_exist (PropertyStringID_const id) const {
	//#UC START# *4AC4993302A8_4C98A69E00F0*
	return false;
	//#UC END# *4AC4993302A8_4C98A69E00F0*
}

// implemented method from BaseSettingsManager
// Запись свойства типа Boolean.
// Если свойство не существует, то оно создается в текущей конфигурации, value записывается как
// значение по умолчанию и как текущее значение.
// Если тип свойства не соответствует устанавливаемому поднимается исключение InvalidValueType
void PrimeSettingsManager_i::set_bool (PropertyStringID_const id, bool value) /*throw (InvalidValueType)*/ {
	//#UC START# *4AC4991C01E1_4C98A69E00F0*
	//#UC END# *4AC4991C01E1_4C98A69E00F0*
}

// implemented method from BaseSettingsManager
// Запись свойства типа int64.
// Если свойство не существует, то оно создается в текущей конфигурации, value записывается как
// значение по умолчанию и как текущее значение.
// Если тип свойства не соответствует устанавливаемому поднимается исключение InvalidValueType
void PrimeSettingsManager_i::set_int64 (PropertyStringID_const id, long long value) /*throw (InvalidValueType)*/ {
	//#UC START# *4AC4991F02F1_4C98A69E00F0*
	//#UC END# *4AC4991F02F1_4C98A69E00F0*
}

// implemented method from BaseSettingsManager
// Запись свойства типа long.
// Если свойство не существует, то оно создается в текущей конфигурации, value записывается как
// значение по умолчанию и как текущее значение.
// Если тип свойства не соответствует устанавливаемому поднимается исключение InvalidValueType
void PrimeSettingsManager_i::set_long (PropertyStringID_const id, long value) /*throw (InvalidValueType)*/ {
	//#UC START# *4AC499220301_4C98A69E00F0*
	//#UC END# *4AC499220301_4C98A69E00F0*
}

// implemented method from BaseSettingsManager
// Запись свойства типа String.
// Если свойство не существует, то оно создается в текущей конфигурации, value записывается как
// значение по умолчанию и как текущее значение.
// Если тип свойства не соответствует устанавливаемому поднимается исключение InvalidValueType
void PrimeSettingsManager_i::set_string (PropertyStringID_const id, const char* value) /*throw (InvalidValueType)*/ {
	//#UC START# *4AC4992601BC_4C98A69E00F0*
	//#UC END# *4AC4992601BC_4C98A69E00F0*
}

// implemented method from BaseSettingsManager
// Запись свойства типа unsigned long.
// Если свойство не существует, то оно создается в текущей конфигурации, value записывается как
// значение по умолчанию и как текущее значение.
// Если тип свойства не соответствует устанавливаемому поднимается исключение InvalidValueType
void PrimeSettingsManager_i::set_ulong (PropertyStringID_const id, unsigned long value) /*throw (InvalidValueType)*/ {
	//#UC START# *4AC499290308_4C98A69E00F0*
	//#UC END# *4AC499290308_4C98A69E00F0*
}
} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

