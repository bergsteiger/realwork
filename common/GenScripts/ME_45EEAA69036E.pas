unit SettingsUnit;

// Модуль: "w:\garant6x\implementation\Garant\tie\Garant\GblAdapterLib\SettingsUnit.pas"
// Стереотип: "Interfaces"
// Элемент модели: "Settings" MUID: (45EEAA69036E)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , IOUnit
 , BaseTypesUnit
;

type
 TPropertyStringID = PAnsiChar;

 TPropertyType = (
  PT_LONG
  , PT_STRING
  , PT_INT64
  , PT_ULONG
  , PT_BOOLEAN
 );//TPropertyType

 TPropertyDefinition = record
  {* Интерфейс доступа к аттрибутам настройки. }
  is_unique: Boolean;
   {* Определяет "уникальность" своства. Уникальные свойства имеют одинаковое значение во всех конфигурациях, другими словами, уникальное свойство всегда присутствует как бы в одном экземпляре.
Уникальные своства должны использоваться для настроек не зависящих от конфигурации.
Значение по умолчанию: false }
  is_constant: Boolean;
   {* Определяет возможность изменения значения настройки.
Значение по умолчанию: false }
  type: TPropertyType;
 end;//TPropertyDefinition

 TDefaultValuesChangesState = (
  {* Статус  проверки обновления значений настроек в предустановленных конфигурациях }
  NO_CHANGES
   {* значения не изменялись }
  , UPDATED_WITH_COPY_ACTIVE_CONFIGURATION
   {* Пользователь в момент смены настроек по умолчанию работает с одной из стандартных (предустановленных) конфигураций.

  - Делается копия текущей конфигурации. Имя: <имя конфигурации> + (сохраненная). Если конфигурация с таким именем уже cуществует -- то  (сохраненная 2).

  - Для всех стандартных конфигураций настройки сбрасываются в значения  по умолчанию. }
  , UPDATED_WITH_ACTIVATE_PREDEFINED_CONFIGURATION
   {* Пользователь в момент смены настроек работает с собственной конфигурацией (копией стандартной). 
  - Для всех стандартных конфигураций настройки сбрасываются в значения по умолчанию 
  - Пользователь переключается с его собственной конфигурации на "Стандартную" (первую в списке предустановленных) }
 );//TDefaultValuesChangesState

 InvalidValueType = class
  {* Возвращается при попытке прочитать или присвоить через интерфейс ParameterValues значение по типу, который не совпадает с реальным типом значения (реальный тип можно получить через свойство value_type). }
 end;//InvalidValueType

 TConfigurationType = (
  {* тип конфигурации, различаем две предустановленные: Стандартная и ГАРАНТ 5x, все остальные - пользовательские }
  CT_STANDARD
  , CT_GARANT5X
  , CT_USER
 );//TConfigurationType

 IPropertyStringIDList = array of IString;

 IBaseSettingsManager = interface
  ['{6BC8FA39-42F0-45D2-8211-D14043AD16DD}']
  function get_bool(id: TPropertyStringID;
   out value: Boolean): Boolean; { can raise InvalidValueType }
   {* Чтение свойства типа Boolean.
При успехе возвращает true.
Если свойство не существует возвращает false.
Если тип свойства не соответствует требуемому поднимается исключение InvalidValueType }
  function get_int64(id: TPropertyStringID;
   out value: Int64): Boolean; { can raise InvalidValueType }
   {* Чтение свойства типа int64.
При успехе возвращает true.
Если свойство не существует возвращает false.
Если тип свойства не соответствует требуемому поднимается исключение InvalidValueType }
  function get_long(id: TPropertyStringID;
   out value: Integer): Boolean; { can raise InvalidValueType }
   {* Чтение свойства типа long.
При успехе возвращает true.
Если свойство не существует возвращает false.
Если тип свойства не соответствует требуемому поднимается исключение InvalidValueType }
  function get_string(id: TPropertyStringID;
   out value: IString): Boolean; { can raise InvalidValueType }
   {* Чтение свойства типа String.
При успехе возвращает true.
Если свойство не существует возвращает false.
Если тип свойства не соответствует требуемому поднимается исключение InvalidValueType }
  function get_ulong(id: TPropertyStringID;
   out value: Cardinal): Boolean; { can raise InvalidValueType }
   {* Чтение свойства типа unsigned long.
При успехе возвращает true.
Если свойство не существует возвращает false.
Если тип свойства не соответствует требуемому поднимается исключение InvalidValueType }
  procedure set_bool(id: TPropertyStringID;
   value: Boolean); { can raise InvalidValueType }
   {* Запись свойства типа Boolean.
Если свойство не существует, то оно создается в текущей конфигурации, value записывается как значение по умолчанию и как текущее значение.
Если тип свойства не соответствует устанавливаемому поднимается исключение InvalidValueType }
  procedure set_int64(id: TPropertyStringID;
   value: Int64); { can raise InvalidValueType }
   {* Запись свойства типа int64.
Если свойство не существует, то оно создается в текущей конфигурации, value записывается как значение по умолчанию и как текущее значение.
Если тип свойства не соответствует устанавливаемому поднимается исключение InvalidValueType }
  procedure set_long(id: TPropertyStringID;
   value: Integer); { can raise InvalidValueType }
   {* Запись свойства типа long.
Если свойство не существует, то оно создается в текущей конфигурации, value записывается как значение по умолчанию и как текущее значение.
Если тип свойства не соответствует устанавливаемому поднимается исключение InvalidValueType }
  procedure set_string(id: TPropertyStringID;
   value: PAnsiChar); { can raise InvalidValueType }
   {* Запись свойства типа String.
Если свойство не существует, то оно создается в текущей конфигурации, value записывается как значение по умолчанию и как текущее значение.
Если тип свойства не соответствует устанавливаемому поднимается исключение InvalidValueType }
  procedure set_ulong(id: TPropertyStringID;
   value: Cardinal); { can raise InvalidValueType }
   {* Запись свойства типа unsigned long.
Если свойство не существует, то оно создается в текущей конфигурации, value записывается как значение по умолчанию и как текущее значение.
Если тип свойства не соответствует устанавливаемому поднимается исключение InvalidValueType }
  function is_exist(id: TPropertyStringID): Boolean;
   {* возвращает true, если параметр с таким именем существует }
 end;//IBaseSettingsManager

 ISettingsManager = interface(IBaseSettingsManager)
  {* Интерфейс работы с настройками. Обеспечивает создание новых свойств и их получение. Свойство характеризуется строковым идентификатором. 
Интерфейс может быть получен 
1. Из интерфейса Common, в этом случае он обеспечивает доступ к свойствам активной конфигурации.
2. Из интерфейса Configuration, в этом случае обеспечивается работа со свойствами конкретной конфигурации. }
  ['{C2012FB8-DEC6-408A-8937-3D7E13CBC830}']
  procedure restore_default(id: TPropertyStringID); { can raise CanNotFindData }
   {* Устанавливает указанному свойству текущее значение равными значению по умолчанию }
  procedure save_as_default(id: TPropertyStringID); { can raise CanNotFindData }
   {* записывает текущее значение свойства в качестве  его значения по умолчанию }
  function get_definition(id: TPropertyStringID;
   var definition: TPropertyDefinition): Boolean;
   {* возвращает структуру с атрибутами настройки }
  function is_changed(id: TPropertyStringID): Boolean;
   {* возвращает true, если текущее значение НЕ равно значению по умолчанию, в противном случае возвращает false }
  function is_changed_set(const id_list: IPropertyStringIDList): Boolean;
 end;//ISettingsManager

 ConfigurationIsActiveNow = class
 end;//ConfigurationIsActiveNow

 IConfiguration = interface
  {* Интерфейс обеспечивающий работу с конкретной конфигурацией, является элементом списка конфигураций. }
  ['{CB09ACB5-D582-477A-8D4F-98FC3766A1F9}']
  function Get_name: IString;
  procedure Set_name(const aValue: IString);
  function Get_hint: IString;
  procedure Set_hint(const aValue: IString);
  function Get_type: TConfigurationType;
  function Get_is_readonly: Boolean;
  function Get_id: Cardinal;
  procedure restore_default_values;
   {* устанавливает для всех свойств конфигурации начальные значения }
  procedure save_values_as_default;
   {* записывает текущие значения для всех свойств в качестве значений по умолчанию }
  function copy: IConfiguration;
   {* возвращает копию конфигурации }
  function get_settings: ISettingsManager;
  property name: IString
   read Get_name
   write Set_name;
   {* Имя конфигурации }
  property hint: IString
   read Get_hint
   write Set_hint;
   {* Комментарий или пояснение к конфигурации }
  property type: TConfigurationType
   read Get_type;
  property is_readonly: Boolean
   read Get_is_readonly;
   {* определяет возможность изменения значений по умолчанию для конфигурации }
  property id: Cardinal
   read Get_id;
 end;//IConfiguration

 ConfigurationsNotDefined = class
 end;//ConfigurationsNotDefined

 IDefaultValuesChangesIndicator = interface
  {* Результат проверки обновления значений настроек в предустановленных конфигурациях

если sate == UPDATED_WITH_COPY_ACTIVE_CONFIGURATION, то configuration содержит вновь созданную пользовательскую конфигурацию - копию активной предустановленной

если state == UPDATED_WITH_ACTIVATE_PREDEFINED_CONFIGURATION, то configuration содержит предустановленную, на которую переключили пользователя }
  ['{168D579E-071E-4626-93BD-7566FCAB780E}']
  function Get_state: TDefaultValuesChangesState;
  function Get_configuration: IConfiguration;
  property state: TDefaultValuesChangesState
   read Get_state;
  property configuration: IConfiguration
   read Get_configuration;
 end;//IDefaultValuesChangesIndicator

 IConfigurations = array of IConfiguration;

 IConfigurationManager = interface
  {* Интерфейс обеспечивающий работу со списком конфигураций. Доступен через интерфейс Common. }
  ['{C0C7A25C-7378-40EA-9593-32B590CC6D8E}']
  function Get_configurations: IConfigurations;
  procedure set_active(const configuration: IConfiguration);
   {* Устанавливает заданную конфигурацией активной (текущей для интерфейса Settings, полученного через Common) }
  procedure remove(const configuration: IConfiguration); { can raise ConstantModify, ConfigurationIsActiveNow }
   {* Удаляет заданную конфигурацию. В случае попытки удалить активную конфигурацию возбуждает исключение ConfigurationIsActiveNow }
  function get_active: IConfiguration;
   {* возвращает активную конфигурацию }
  function default_values_update_check: IDefaultValuesChangesIndicator;
  function get_active_id: Integer;
   {* возвращает идентификатор активной конфигурации }
  procedure logout;
   {* метод дёргается при выходе из системы }
  property configurations: IConfigurations
   read Get_configurations;
 end;//IConfigurationManager

 IPermanentSettingsManager = interface(IBaseSettingsManager)
  {* настройки, не зависящие от конфигураций }
  ['{4983A1B9-5021-4CE1-8C13-912831395FB8}']
 end;//IPermanentSettingsManager

class function make: BadFactoryType; { can raise NoSession }
class function make(id: Integer;
 const name: IString;
 const hint: IString;
 readonly: Boolean): BadFactoryType;
class function make(state: TDefaultValuesChangesState;
 const configuration: IConfiguration): BadFactoryType;
class function make: BadFactoryType;
class function make: BadFactoryType;

implementation

uses
 l3ImplUses
;

class function make: BadFactoryType; { can raise NoSession }
var
 l_Inst : ISettingsManager;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//make

class function make(id: Integer;
 const name: IString;
 const hint: IString;
 readonly: Boolean): BadFactoryType;
var
 l_Inst : IConfiguration;
begin
 l_Inst := Create(id, name, hint, readonly);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//make

class function make(state: TDefaultValuesChangesState;
 const configuration: IConfiguration): BadFactoryType;
var
 l_Inst : IDefaultValuesChangesIndicator;
begin
 l_Inst := Create(state, configuration);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//make

class function make: BadFactoryType;
var
 l_Inst : IConfigurationManager;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//make

class function make: BadFactoryType;
var
 l_Inst : IPermanentSettingsManager;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//make

end.
