////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/Settings/Settings.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::Settings
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_SETTINGS_H__
#define __GARANT6X_GBLADAPTERLIB_SETTINGS_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include <vector>
#include "garant6x/implementation/Garant/GblAdapterLib/BaseTypes/BaseTypes.h"
#include "shared/GCI/IO/IO.h"

namespace GblAdapterLib {

typedef char* PropertyStringID;
typedef const char* PropertyStringID_const;


enum PropertyType {
	PT_LONG
	, PT_STRING
	, PT_INT64
	, PT_ULONG
	, PT_BOOLEAN
};

#pragma pack (push, 1)

// Интерфейс доступа к аттрибутам настройки.
struct PropertyDefinition {
	// Определяет "уникальность" своства. Уникальные свойства имеют одинаковое значение во всех
	// конфигурациях, другими словами, уникальное свойство всегда присутствует как бы в одном
	// экземпляре.
	// Уникальные своства должны использоваться для настроек не зависящих от конфигурации.
	// Значение по умолчанию: false
	bool is_unique;
	// Определяет возможность изменения значения настройки.
	// Значение по умолчанию: false
	bool is_constant;
	PropertyType type;
};

#pragma pack (pop)

// Статус  проверки обновления значений настроек в предустановленных конфигурациях
enum DefaultValuesChangesState {
	NO_CHANGES // значения не изменялись
	, UPDATED_WITH_COPY_ACTIVE_CONFIGURATION // Пользователь в момент смены настроек по умолчанию работает с одной из стандартных (предустановленных) конфигураций.    - Делается копия текущей конфигурации. Имя: <имя конфигурации> + (сохраненная). Если конфигурация с таким именем уже cуществует -- то  (сохраненная 2).    - Для всех стандартных конфигураций настройки сбрасываются в значения  по умолчанию.
	, UPDATED_WITH_ACTIVATE_PREDEFINED_CONFIGURATION // Пользователь в момент смены настроек работает с собственной конфигурацией (копией стандартной).    - Для всех стандартных конфигураций настройки сбрасываются в значения по умолчанию    - Пользователь переключается с его собственной конфигурации на "Стандартную" (первую в списке предустановленных)
};

// Возвращается при попытке прочитать или присвоить через интерфейс ParameterValues значение по
// типу, который не совпадает с реальным типом значения (реальный тип можно получить через свойство
// value_type).
class InvalidValueType : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

// тип конфигурации, различаем две предустановленные: Стандартная и ГАРАНТ 5x, все остальные -
// пользовательские
enum ConfigurationType {
	CT_STANDARD
	, CT_GARANT5X
	, CT_USER
};

typedef std::vector < GCI::IO::String_var > PropertyStringIDList;

class BaseSettingsManager;
typedef ::Core::Var<BaseSettingsManager> BaseSettingsManager_var;
typedef ::Core::Var<const BaseSettingsManager> BaseSettingsManager_cvar;
class BaseSettingsManager
	: virtual public ::Core::IObject
{
public:
	// Чтение свойства типа Boolean.
	// При успехе возвращает true.
	// Если свойство не существует возвращает false.
	// Если тип свойства не соответствует требуемому поднимается исключение InvalidValueType
	virtual bool get_bool (PropertyStringID_const id, bool& value) /*throw (InvalidValueType)*/ = 0;

	// Чтение свойства типа int64.
	// При успехе возвращает true.
	// Если свойство не существует возвращает false.
	// Если тип свойства не соответствует требуемому поднимается исключение InvalidValueType
	virtual bool get_int64 (PropertyStringID_const id, long long& value) /*throw (InvalidValueType)*/ = 0;

	// Чтение свойства типа long.
	// При успехе возвращает true.
	// Если свойство не существует возвращает false.
	// Если тип свойства не соответствует требуемому поднимается исключение InvalidValueType
	virtual bool get_long (PropertyStringID_const id, long& value) /*throw (InvalidValueType)*/ = 0;

	// Чтение свойства типа String.
	// При успехе возвращает true.
	// Если свойство не существует возвращает false.
	// Если тип свойства не соответствует требуемому поднимается исключение InvalidValueType
	virtual bool get_string (PropertyStringID_const id, GCI::IO::String*& value) /*throw (InvalidValueType)*/ = 0;

	// Чтение свойства типа unsigned long.
	// При успехе возвращает true.
	// Если свойство не существует возвращает false.
	// Если тип свойства не соответствует требуемому поднимается исключение InvalidValueType
	virtual bool get_ulong (PropertyStringID_const id, unsigned long& value) /*throw (InvalidValueType)*/ = 0;

	// Запись свойства типа Boolean.
	// Если свойство не существует, то оно создается в текущей конфигурации, value записывается как
	// значение по умолчанию и как текущее значение.
	// Если тип свойства не соответствует устанавливаемому поднимается исключение InvalidValueType
	virtual void set_bool (PropertyStringID_const id, bool value) /*throw (InvalidValueType)*/ = 0;

	// Запись свойства типа int64.
	// Если свойство не существует, то оно создается в текущей конфигурации, value записывается как
	// значение по умолчанию и как текущее значение.
	// Если тип свойства не соответствует устанавливаемому поднимается исключение InvalidValueType
	virtual void set_int64 (PropertyStringID_const id, long long value) /*throw (InvalidValueType)*/ = 0;

	// Запись свойства типа long.
	// Если свойство не существует, то оно создается в текущей конфигурации, value записывается как
	// значение по умолчанию и как текущее значение.
	// Если тип свойства не соответствует устанавливаемому поднимается исключение InvalidValueType
	virtual void set_long (PropertyStringID_const id, long value) /*throw (InvalidValueType)*/ = 0;

	// Запись свойства типа String.
	// Если свойство не существует, то оно создается в текущей конфигурации, value записывается как
	// значение по умолчанию и как текущее значение.
	// Если тип свойства не соответствует устанавливаемому поднимается исключение InvalidValueType
	virtual void set_string (PropertyStringID_const id, const char* value) /*throw (InvalidValueType)*/ = 0;

	// Запись свойства типа unsigned long.
	// Если свойство не существует, то оно создается в текущей конфигурации, value записывается как
	// значение по умолчанию и как текущее значение.
	// Если тип свойства не соответствует устанавливаемому поднимается исключение InvalidValueType
	virtual void set_ulong (PropertyStringID_const id, unsigned long value) /*throw (InvalidValueType)*/ = 0;

	// возвращает true, если параметр с таким именем существует
	virtual bool is_exist (PropertyStringID_const id) const = 0;
};

class SettingsManager;
typedef ::Core::Var<SettingsManager> SettingsManager_var;
typedef ::Core::Var<const SettingsManager> SettingsManager_cvar;
// Интерфейс работы с настройками. Обеспечивает создание новых свойств и их получение. Свойство
// характеризуется строковым идентификатором.
// Интерфейс может быть получен
// 1. Из интерфейса Common, в этом случае он обеспечивает доступ к свойствам активной конфигурации.
// 2. Из интерфейса Configuration, в этом случае обеспечивается работа со свойствами конкретной
// конфигурации.
class SettingsManager
	: virtual public BaseSettingsManager
{
public:
	// Устанавливает указанному свойству текущее значение равными значению по умолчанию
	virtual void restore_default (PropertyStringID_const id) const /*throw (CanNotFindData)*/ = 0;

	// записывает текущее значение свойства в качестве  его значения по умолчанию
	virtual void save_as_default (PropertyStringID_const id) const /*throw (CanNotFindData)*/ = 0;

	// возвращает структуру с атрибутами настройки
	virtual bool get_definition (PropertyStringID_const id, PropertyDefinition& definition) const = 0;

	// возвращает true, если текущее значение НЕ равно значению по умолчанию, в противном случае
	// возвращает false
	virtual bool is_changed (PropertyStringID_const id) const = 0;

	virtual bool is_changed_set (const PropertyStringIDList& id_list) const = 0;
};

/// factory interface for SettingsManager
class SettingsManagerFactory {
public:
	static SettingsManager* make ()
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed, NoSession)*/;
};

class ConfigurationIsActiveNow : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

class Configuration;
typedef ::Core::Var<Configuration> Configuration_var;
typedef ::Core::Var<const Configuration> Configuration_cvar;
// Интерфейс обеспечивающий работу с конкретной конфигурацией, является элементом списка
// конфигураций.
class Configuration
	: virtual public ::Core::IObject
{
public:
	// Имя конфигурации
	virtual const GCI::IO::String* get_name () const = 0;
	virtual GCI::IO::String* get_name () = 0;

	virtual void set_name (GCI::IO::String* name) = 0;

	// Комментарий или пояснение к конфигурации
	virtual const GCI::IO::String* get_hint () const = 0;
	virtual GCI::IO::String* get_hint () = 0;

	virtual void set_hint (GCI::IO::String* hint) = 0;

	virtual ConfigurationType get_type () const = 0;

	// определяет возможность изменения значений по умолчанию для конфигурации
	virtual bool get_is_readonly () const = 0;

	virtual unsigned long get_id () const = 0;

	// устанавливает для всех свойств конфигурации начальные значения
	virtual void restore_default_values () const = 0;

	// записывает текущие значения для всех свойств в качестве значений по умолчанию
	virtual void save_values_as_default () const = 0;

	// возвращает копию конфигурации
	virtual Configuration* copy () const = 0;

	virtual SettingsManager* get_settings () const = 0;
};

/// factory interface for Configuration
class ConfigurationFactory {
public:
	static Configuration* make (long id, const GCI::IO::String* name, const GCI::IO::String* hint, bool readonly)
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

class ConfigurationsNotDefined : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

class DefaultValuesChangesIndicator;
typedef ::Core::Var<DefaultValuesChangesIndicator> DefaultValuesChangesIndicator_var;
typedef ::Core::Var<const DefaultValuesChangesIndicator> DefaultValuesChangesIndicator_cvar;
// Результат проверки обновления значений настроек в предустановленных конфигурациях
// 
// если sate == UPDATED_WITH_COPY_ACTIVE_CONFIGURATION, то configuration содержит вновь созданную
// пользовательскую конфигурацию - копию активной предустановленной
// 
// если state == UPDATED_WITH_ACTIVATE_PREDEFINED_CONFIGURATION, то configuration содержит
// предустановленную, на которую переключили пользователя
class DefaultValuesChangesIndicator
	: virtual public ::Core::IObject
{
public:
	virtual DefaultValuesChangesState get_state () const = 0;

	virtual const Configuration* get_configuration () const = 0;
	virtual Configuration* get_configuration () = 0;
};

/// factory interface for DefaultValuesChangesIndicator
class DefaultValuesChangesIndicatorFactory {
public:
	static DefaultValuesChangesIndicator* make (DefaultValuesChangesState state, const Configuration* configuration)
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

typedef std::vector < Configuration_var > Configurations;

class ConfigurationManager;
typedef ::Core::Var<ConfigurationManager> ConfigurationManager_var;
typedef ::Core::Var<const ConfigurationManager> ConfigurationManager_cvar;
// Интерфейс обеспечивающий работу со списком конфигураций. Доступен через интерфейс Common.
class ConfigurationManager
	: virtual public ::Core::IObject
{
public:
	virtual const Configurations& get_configurations () const = 0;

	// Устанавливает заданную конфигурацией активной (текущей для интерфейса Settings, полученного
	// через Common)
	virtual void set_active (const Configuration* configuration) = 0;

	// Удаляет заданную конфигурацию. В случае попытки удалить активную конфигурацию возбуждает
	// исключение ConfigurationIsActiveNow
	virtual void remove (const Configuration* configuration) /*throw (ConstantModify, ConfigurationIsActiveNow)*/ = 0;

	// возвращает активную конфигурацию
	virtual Configuration* get_active () = 0;

	virtual DefaultValuesChangesIndicator* default_values_update_check () = 0;

	// возвращает идентификатор активной конфигурации
	virtual long get_active_id () const = 0;

	// метод дёргается при выходе из системы
	virtual void logout () = 0;
};

/// factory interface for ConfigurationManager
class ConfigurationManagerFactory {
public:
	static ConfigurationManager* make ()
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

class PermanentSettingsManager;
typedef ::Core::Var<PermanentSettingsManager> PermanentSettingsManager_var;
typedef ::Core::Var<const PermanentSettingsManager> PermanentSettingsManager_cvar;
// настройки, не зависящие от конфигураций
class PermanentSettingsManager
	: virtual public BaseSettingsManager
{
};

/// factory interface for PermanentSettingsManager
class PermanentSettingsManagerFactory {
public:
	static PermanentSettingsManager* make ()
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

} // namespace GblAdapterLib

// TypeTraits specializations
namespace Core {	
template <>
struct TypeTraits <GblAdapterLib::SettingsManager> {
	typedef GblAdapterLib::SettingsManagerFactory Factory;
};
template <>
struct TypeTraits <GblAdapterLib::Configuration> {
	typedef GblAdapterLib::ConfigurationFactory Factory;
};
template <>
struct TypeTraits <GblAdapterLib::DefaultValuesChangesIndicator> {
	typedef GblAdapterLib::DefaultValuesChangesIndicatorFactory Factory;
};
template <>
struct TypeTraits <GblAdapterLib::ConfigurationManager> {
	typedef GblAdapterLib::ConfigurationManagerFactory Factory;
};
template <>
struct TypeTraits <GblAdapterLib::PermanentSettingsManager> {
	typedef GblAdapterLib::PermanentSettingsManagerFactory Factory;
};
} // namespace Core


#endif //__GARANT6X_GBLADAPTERLIB_SETTINGS_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
