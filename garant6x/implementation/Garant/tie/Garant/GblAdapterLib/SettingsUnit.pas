unit SettingsUnit;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "GblAdapterLib"
// Модуль: "w:/garant6x/implementation/Garant/tie/Garant/GblAdapterLib/SettingsUnit.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::Settings
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
  IOUnit,
  BaseTypesUnit
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
   is_unique : Boolean; // Определяет "уникальность" своства. Уникальные свойства имеют одинаковое значение во всех конфигурациях, другими словами, уникальное свойство всегда присутствует как бы в одном экземпляре.
Уникальные своства должны использоваться для настроек не зависящих от конфигурации.
Значение по умолчанию: false
   is_constant : Boolean; // Определяет возможность изменения значения настройки.
Значение по умолчанию: false
   type : TPropertyType;
 end;//TPropertyDefinition

 TDefaultValuesChangesState = (
  {* Статус  проверки обновления значений настроек в предустановленных конфигурациях }
   NO_CHANGES // значения не изменялись
 , UPDATED_WITH_COPY_ACTIVE_CONFIGURATION // Пользователь в момент смены настроек по умолчанию работает с одной из стандартных (предустановленных) конфигураций.    - Делается копия текущей конфигурации. Имя: <имя конфигурации> + (сохраненная). Если конфигурация с таким именем уже cуществует -- то  (сохраненная 2).    - Для всех стандартных конфигураций настройки сбрасываются в значения  по умолчанию.
 , UPDATED_WITH_ACTIVATE_PREDEFINED_CONFIGURATION // Пользователь в момент смены настроек работает с собственной конфигурацией (копией стандартной).    - Для всех стандартных конфигураций настройки сбрасываются в значения по умолчанию    - Пользователь переключается с его собственной конфигурации на "Стандартную" (первую в списке предустановленных)
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

 IBaseSettingsManager = interface(IUnknown)
   ['{6BC8FA39-42F0-45D2-8211-D14043AD16DD}']
   function GetBool(aId: TPropertyStringID;
    out aValue: Boolean): ByteBool; stdcall; // can raise InvalidValueType
     {* Чтение свойства типа Boolean.
При успехе возвращает true.
Если свойство не существует возвращает false.
Если тип свойства не соответствует требуемому поднимается исключение InvalidValueType }
   function GetInt64(aId: TPropertyStringID;
    out aValue: Int64): ByteBool; stdcall; // can raise InvalidValueType
     {* Чтение свойства типа int64.
При успехе возвращает true.
Если свойство не существует возвращает false.
Если тип свойства не соответствует требуемому поднимается исключение InvalidValueType }
   function GetLong(aId: TPropertyStringID;
    out aValue: Integer): ByteBool; stdcall; // can raise InvalidValueType
     {* Чтение свойства типа long.
При успехе возвращает true.
Если свойство не существует возвращает false.
Если тип свойства не соответствует требуемому поднимается исключение InvalidValueType }
   function GetString(aId: TPropertyStringID;
    out aValue: IString): ByteBool; stdcall; // can raise InvalidValueType
     {* Чтение свойства типа String.
При успехе возвращает true.
Если свойство не существует возвращает false.
Если тип свойства не соответствует требуемому поднимается исключение InvalidValueType }
   function GetUlong(aId: TPropertyStringID;
    out aValue: Cardinal): ByteBool; stdcall; // can raise InvalidValueType
     {* Чтение свойства типа unsigned long.
При успехе возвращает true.
Если свойство не существует возвращает false.
Если тип свойства не соответствует требуемому поднимается исключение InvalidValueType }
   procedure SetBool(aId: TPropertyStringID;
    aValue: Boolean); stdcall; // can raise InvalidValueType
     {* Запись свойства типа Boolean.
Если свойство не существует, то оно создается в текущей конфигурации, value записывается как значение по умолчанию и как текущее значение.
Если тип свойства не соответствует устанавливаемому поднимается исключение InvalidValueType }
   procedure SetInt64(aId: TPropertyStringID;
    aValue: Int64); stdcall; // can raise InvalidValueType
     {* Запись свойства типа int64.
Если свойство не существует, то оно создается в текущей конфигурации, value записывается как значение по умолчанию и как текущее значение.
Если тип свойства не соответствует устанавливаемому поднимается исключение InvalidValueType }
   procedure SetLong(aId: TPropertyStringID;
    aValue: Integer); stdcall; // can raise InvalidValueType
     {* Запись свойства типа long.
Если свойство не существует, то оно создается в текущей конфигурации, value записывается как значение по умолчанию и как текущее значение.
Если тип свойства не соответствует устанавливаемому поднимается исключение InvalidValueType }
   procedure SetString(aId: TPropertyStringID;
    aValue: PAnsiChar); stdcall; // can raise InvalidValueType
     {* Запись свойства типа String.
Если свойство не существует, то оно создается в текущей конфигурации, value записывается как значение по умолчанию и как текущее значение.
Если тип свойства не соответствует устанавливаемому поднимается исключение InvalidValueType }
   procedure SetUlong(aId: TPropertyStringID;
    aValue: Cardinal); stdcall; // can raise InvalidValueType
     {* Запись свойства типа unsigned long.
Если свойство не существует, то оно создается в текущей конфигурации, value записывается как значение по умолчанию и как текущее значение.
Если тип свойства не соответствует устанавливаемому поднимается исключение InvalidValueType }
   function IsExist(aId: TPropertyStringID): ByteBool; stdcall;
     {* возвращает true, если параметр с таким именем существует }
 end;//IBaseSettingsManager

 ISettingsManager = interface(IBaseSettingsManager)
  {* Интерфейс работы с настройками. Обеспечивает создание новых свойств и их получение. Свойство характеризуется строковым идентификатором. 
Интерфейс может быть получен 
1. Из интерфейса Common, в этом случае он обеспечивает доступ к свойствам активной конфигурации.
2. Из интерфейса Configuration, в этом случае обеспечивается работа со свойствами конкретной конфигурации. }
   ['{C2012FB8-DEC6-408A-8937-3D7E13CBC830}']
   procedure RestoreDefault(aId: TPropertyStringID); stdcall; // can raise CanNotFindData
     {* Устанавливает указанному свойству текущее значение равными значению по умолчанию }
   procedure SaveAsDefault(aId: TPropertyStringID); stdcall; // can raise CanNotFindData
     {* записывает текущее значение свойства в качестве  его значения по умолчанию }
   function GetDefinition(aId: TPropertyStringID;
    var aDefinition: TPropertyDefinition): ByteBool; stdcall;
     {* возвращает структуру с атрибутами настройки }
   function IsChanged(aId: TPropertyStringID): ByteBool; stdcall;
     {* возвращает true, если текущее значение НЕ равно значению по умолчанию, в противном случае возвращает false }
   function IsChangedSet(const aIdList: IPropertyStringIDList): ByteBool; stdcall;
 end;//ISettingsManager

 ConfigurationIsActiveNow = class
 end;//ConfigurationIsActiveNow

 IConfiguration = interface(IUnknown)
  {* Интерфейс обеспечивающий работу с конкретной конфигурацией, является элементом списка конфигураций. }
   ['{CB09ACB5-D582-477A-8D4F-98FC3766A1F9}']
   function GetName: IString; stdcall;
   procedure SetName(const aValue: IString); stdcall;
   function GetHint: IString; stdcall;
   procedure SetHint(const aValue: IString); stdcall;
   function GetType: TConfigurationType; stdcall;
   function GetIsReadonly: ByteBool; stdcall;
   function GetId: Cardinal; stdcall;
   procedure RestoreDefaultValues; stdcall;
     {* устанавливает для всех свойств конфигурации начальные значения }
   procedure SaveValuesAsDefault; stdcall;
     {* записывает текущие значения для всех свойств в качестве значений по умолчанию }
   procedure Copy(out aRet {: IConfiguration}); stdcall;
     {* возвращает копию конфигурации }
   procedure GetSettings(out aRet {: ISettingsManager}); stdcall;
   property name: IString
     read GetName
     write SetName;
     {* Имя конфигурации }
   property hint: IString
     read GetHint
     write SetHint;
     {* Комментарий или пояснение к конфигурации }
   property type: TConfigurationType
     read GetType;
   property is_readonly: ByteBool
     read GetIsReadonly;
     {* определяет возможность изменения значений по умолчанию для конфигурации }
   property id: Cardinal
     read GetId;
 end;//IConfiguration

 ConfigurationsNotDefined = class
 end;//ConfigurationsNotDefined

 IDefaultValuesChangesIndicator = interface(IUnknown)
  {* Результат проверки обновления значений настроек в предустановленных конфигурациях

если sate == UPDATED_WITH_COPY_ACTIVE_CONFIGURATION, то configuration содержит вновь созданную пользовательскую конфигурацию - копию активной предустановленной

если state == UPDATED_WITH_ACTIVATE_PREDEFINED_CONFIGURATION, то configuration содержит предустановленную, на которую переключили пользователя }
   ['{168D579E-071E-4626-93BD-7566FCAB780E}']
   function GetState: TDefaultValuesChangesState; stdcall;
   function GetConfiguration: IConfiguration; stdcall;
   property state: TDefaultValuesChangesState
     read GetState;
   property configuration: IConfiguration
     read GetConfiguration;
 end;//IDefaultValuesChangesIndicator

 IConfigurations = array of IConfiguration;

 IConfigurationManager = interface(IUnknown)
  {* Интерфейс обеспечивающий работу со списком конфигураций. Доступен через интерфейс Common. }
   ['{C0C7A25C-7378-40EA-9593-32B590CC6D8E}']
   function GetConfigurations: IConfigurations; stdcall;
   procedure SetActive(const aConfiguration: IConfiguration); stdcall;
     {* Устанавливает заданную конфигурацией активной (текущей для интерфейса Settings, полученного через Common) }
   procedure Remove(const aConfiguration: IConfiguration); stdcall; // can raise ConstantModify, ConfigurationIsActiveNow
     {* Удаляет заданную конфигурацию. В случае попытки удалить активную конфигурацию возбуждает исключение ConfigurationIsActiveNow }
   procedure GetActive(out aRet {: IConfiguration}); stdcall;
     {* возвращает активную конфигурацию }
   procedure DefaultValuesUpdateCheck(out aRet {: IDefaultValuesChangesIndicator}); stdcall;
   function GetActiveId: Integer; stdcall;
     {* возвращает идентификатор активной конфигурации }
   procedure Logout; stdcall;
     {* метод дёргается при выходе из системы }
   property configurations: IConfigurations
     read GetConfigurations;
 end;//IConfigurationManager

 IPermanentSettingsManager = interface(IBaseSettingsManager)
  {* настройки, не зависящие от конфигураций }
   ['{4983A1B9-5021-4CE1-8C13-912831395FB8}']
 end;//IPermanentSettingsManager

implementation

end.