unit SettingsUnit; {$Z4}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "GblAdapterLib"
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/SettingsUnit.pas"
// Delphi интерфейсы для адаптера (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::Settings
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

interface

uses
	SysUtils
	, IOUnit
	, BaseTypesUnit
	//#UC START# *4423F94903C8_45EEAA69036E_UNIT_FOR_Stream*
	//#UC END# *4423F94903C8_45EEAA69036E_UNIT_FOR_Stream*
	;

type

IPropertyStringIDList = interface;
{ - предварительное описание IPropertyStringIDList. }

IBaseSettingsManager = interface;
{ - предварительное описание IBaseSettingsManager. }

ISettingsManager = interface;
{ - предварительное описание ISettingsManager. }

IConfiguration = interface;
{ - предварительное описание IConfiguration. }

IDefaultValuesChangesIndicator = interface;
{ - предварительное описание IDefaultValuesChangesIndicator. }

IConfigurations = interface;
{ - предварительное описание IConfigurations. }

IConfigurationManager = interface;
{ - предварительное описание IConfigurationManager. }

IPermanentSettingsManager = interface;
{ - предварительное описание IPermanentSettingsManager. }


PPropertyStringID = ^TPropertyStringID;
TPropertyStringID = PAnsiChar;

PPropertyType = ^TPropertyType;
TPropertyType = (
	PT_LONG
	, PT_STRING
	, PT_INT64
	, PT_ULONG
	, PT_BOOLEAN
);

// Интерфейс доступа к аттрибутам настройки.
PPropertyDefinition = ^TPropertyDefinition;
TPropertyDefinition = packed record
	rIsUnique: Bytebool; // Определяет "уникальность" своства. Уникальные свойства имеют одинаковое значение во всех конфигурациях, другими словами, уникальное свойство всегда присутствует как бы в одном экземпляре.Уникальные своства должны использоваться для настроек не зависящих от конфигурации.Значение по умолчанию: false
	rIsConstant: Bytebool; // Определяет возможность изменения значения настройки.Значение по умолчанию: false
	rType: TPropertyType;
end;

// Статус  проверки обновления значений настроек в предустановленных конфигурациях
PDefaultValuesChangesState = ^TDefaultValuesChangesState;
TDefaultValuesChangesState = (
	NO_CHANGES // значения не изменялись
	, UPDATED_WITH_COPY_ACTIVE_CONFIGURATION // Пользователь в момент смены настроек по умолчанию работает с одной из стандартных (предустановленных) конфигураций.    - Делается копия текущей конфигурации. Имя: <имя конфигурации> + (сохраненная). Если конфигурация с таким именем уже cуществует -- то  (сохраненная 2).    - Для всех стандартных конфигураций настройки сбрасываются в значения  по умолчанию.
	, UPDATED_WITH_ACTIVATE_PREDEFINED_CONFIGURATION // Пользователь в момент смены настроек работает с собственной конфигурацией (копией стандартной).    - Для всех стандартных конфигураций настройки сбрасываются в значения по умолчанию    - Пользователь переключается с его собственной конфигурации на "Стандартную" (первую в списке предустановленных)
);

// Возвращается при попытке прочитать или присвоить через интерфейс ParameterValues значение по
// типу, который не совпадает с реальным типом значения (реальный тип можно получить через свойство
// value_type).
EInvalidValueType = class (Exception);

// тип конфигурации, различаем две предустановленные: Стандартная и ГАРАНТ 5x, все остальные -
// пользовательские
PConfigurationType = ^TConfigurationType;
TConfigurationType = (
	CT_STANDARD
	, CT_GARANT5X
	, CT_USER
);

EConfigurationIsActiveNow = class (Exception);

EConfigurationsNotDefined = class (Exception);

IPropertyStringIDList = interface(IInterface)
['{DCCE2630-0409-48AF-A7B9-567B081CB9DE}']
    function  pm_GetCount: Integer; stdcall;
    procedure pm_SetCount(aValue: Integer); stdcall;
      { - методы для доступа к свойству Count. }
    procedure Clear; stdcall;
      {* очистить список. }
    procedure Delete(anIndex: Integer); stdcall;
      {* удаляет элемент по индексу Index. }
    property Count: Integer
      read pm_GetCount
      write pm_SetCount;
       {* число элементов в хранилище. }
  // property methods
    procedure  pm_GetItem(anIndex: Integer; out aRet: IString); stdcall;

    procedure pm_SetItem(anIndex: Integer; const anItem: IString); stdcall;
      {-}
  // public methods
    function  Add(const anItem: IString): Integer; stdcall;
      {* - добавляет элемент Item в конец. }
    procedure Insert(anIndex: Integer; const anItem: IString); stdcall;
      {* - вставляет элемент Item по индексу Index. }
end;//IPropertyStringIDList

IBaseSettingsManager = interface (IInterface) ['{6BC8FA39-42F0-45D2-8211-D14043AD16DD}']
	function DontUseMe: Pointer;
	// Чтение свойства типа Boolean.
	// При успехе возвращает true.
	// Если свойство не существует возвращает false.
	// Если тип свойства не соответствует требуемому поднимается исключение InvalidValueType
	function GetBool (
		const aId: TPropertyStringID;
		out aValue: Bytebool
	): Bytebool; stdcall; // can raise EInvalidValueType

	// Чтение свойства типа int64.
	// При успехе возвращает true.
	// Если свойство не существует возвращает false.
	// Если тип свойства не соответствует требуемому поднимается исключение InvalidValueType
	function GetInt64 (
		const aId: TPropertyStringID;
		out aValue: Int64
	): Bytebool; stdcall; // can raise EInvalidValueType

	// Чтение свойства типа long.
	// При успехе возвращает true.
	// Если свойство не существует возвращает false.
	// Если тип свойства не соответствует требуемому поднимается исключение InvalidValueType
	function GetLong (
		const aId: TPropertyStringID;
		out aValue: Longint
	): Bytebool; stdcall; // can raise EInvalidValueType

	// Чтение свойства типа String.
	// При успехе возвращает true.
	// Если свойство не существует возвращает false.
	// Если тип свойства не соответствует требуемому поднимается исключение InvalidValueType
	function GetString (
		const aId: TPropertyStringID;
		out aValue {: IString}
	): Bytebool; stdcall; // can raise EInvalidValueType

	// Чтение свойства типа unsigned long.
	// При успехе возвращает true.
	// Если свойство не существует возвращает false.
	// Если тип свойства не соответствует требуемому поднимается исключение InvalidValueType
	function GetUlong (
		const aId: TPropertyStringID;
		out aValue: Longword
	): Bytebool; stdcall; // can raise EInvalidValueType

	// возвращает true, если параметр с таким именем существует
	function IsExist (
		const aId: TPropertyStringID
	): Bytebool; stdcall;

	// Запись свойства типа Boolean.
	// Если свойство не существует, то оно создается в текущей конфигурации, value записывается как
	// значение по умолчанию и как текущее значение.
	// Если тип свойства не соответствует устанавливаемому поднимается исключение InvalidValueType
	procedure SetBool (
		const aId: TPropertyStringID;
		aValue: Bytebool
	); stdcall; // can raise EInvalidValueType

	// Запись свойства типа int64.
	// Если свойство не существует, то оно создается в текущей конфигурации, value записывается как
	// значение по умолчанию и как текущее значение.
	// Если тип свойства не соответствует устанавливаемому поднимается исключение InvalidValueType
	procedure SetInt64 (
		const aId: TPropertyStringID;
		aValue: Int64
	); stdcall; // can raise EInvalidValueType

	// Запись свойства типа long.
	// Если свойство не существует, то оно создается в текущей конфигурации, value записывается как
	// значение по умолчанию и как текущее значение.
	// Если тип свойства не соответствует устанавливаемому поднимается исключение InvalidValueType
	procedure SetLong (
		const aId: TPropertyStringID;
		aValue: Longint
	); stdcall; // can raise EInvalidValueType

	// Запись свойства типа String.
	// Если свойство не существует, то оно создается в текущей конфигурации, value записывается как
	// значение по умолчанию и как текущее значение.
	// Если тип свойства не соответствует устанавливаемому поднимается исключение InvalidValueType
	procedure SetString (
		const aId: TPropertyStringID;
		const aValue: PAnsiChar
	); stdcall; // can raise EInvalidValueType

	// Запись свойства типа unsigned long.
	// Если свойство не существует, то оно создается в текущей конфигурации, value записывается как
	// значение по умолчанию и как текущее значение.
	// Если тип свойства не соответствует устанавливаемому поднимается исключение InvalidValueType
	procedure SetUlong (
		const aId: TPropertyStringID;
		aValue: Longword
	); stdcall; // can raise EInvalidValueType
end;

// Интерфейс работы с настройками. Обеспечивает создание новых свойств и их получение. Свойство
// характеризуется строковым идентификатором.
// Интерфейс может быть получен
// 1. Из интерфейса Common, в этом случае он обеспечивает доступ к свойствам активной конфигурации.
// 2. Из интерфейса Configuration, в этом случае обеспечивается работа со свойствами конкретной
// конфигурации.
ISettingsManager = interface (IBaseSettingsManager) ['{C2012FB8-DEC6-408A-8937-3D7E13CBC830}']
	// возвращает структуру с атрибутами настройки
	function GetDefinition (
		const aId: TPropertyStringID;
		const aDefinition: TPropertyDefinition
	): Bytebool; stdcall;

	// возвращает true, если текущее значение НЕ равно значению по умолчанию, в противном случае
	// возвращает false
	function IsChanged (
		const aId: TPropertyStringID
	): Bytebool; stdcall;

	function IsChangedSet (
		const aIdList: IPropertyStringIDList
	): Bytebool; stdcall;

	// Устанавливает указанному свойству текущее значение равными значению по умолчанию
	procedure RestoreDefault (
		const aId: TPropertyStringID
	); stdcall; // can raise ECanNotFindData

	// записывает текущее значение свойства в качестве  его значения по умолчанию
	procedure SaveAsDefault (
		const aId: TPropertyStringID
	); stdcall; // can raise ECanNotFindData
end;

// Интерфейс обеспечивающий работу с конкретной конфигурацией, является элементом списка
// конфигураций.
IConfiguration = interface (IInterface) ['{CB09ACB5-D582-477A-8D4F-98FC3766A1F9}']
	function DontUseMe: Pointer;
	// возвращает копию конфигурации
	procedure Copy (
		out aRet {: IConfiguration}
	); stdcall;

	procedure GetSettings (
		out aRet {: ISettingsManager}
	); stdcall;

	// Комментарий или пояснение к конфигурации
	procedure GetHint (out aRet {: IString}); stdcall;
	procedure SetHint (const aHint: IString); stdcall;

	function GetId (): Longword; stdcall;

	// определяет возможность изменения значений по умолчанию для конфигурации
	function GetIsReadonly (): Bytebool; stdcall;

	// Имя конфигурации
	procedure GetName (out aRet {: IString}); stdcall;
	procedure SetName (const aName: IString); stdcall;

	// устанавливает для всех свойств конфигурации начальные значения
	procedure RestoreDefaultValues (); stdcall;

	// записывает текущие значения для всех свойств в качестве значений по умолчанию
	procedure SaveValuesAsDefault (); stdcall;

	function GetType (): TConfigurationType; stdcall;
end;

// Результат проверки обновления значений настроек в предустановленных конфигурациях
// 
// если sate == UPDATED_WITH_COPY_ACTIVE_CONFIGURATION, то configuration содержит вновь созданную
// пользовательскую конфигурацию - копию активной предустановленной
// 
// если state == UPDATED_WITH_ACTIVATE_PREDEFINED_CONFIGURATION, то configuration содержит
// предустановленную, на которую переключили пользователя
IDefaultValuesChangesIndicator = interface (IInterface) ['{168D579E-071E-4626-93BD-7566FCAB780E}']
	function DontUseMe: Pointer;
	procedure GetConfiguration (out aRet {: IConfiguration}); stdcall;

	function GetState (): TDefaultValuesChangesState; stdcall;
end;

IConfigurations = interface(IInterface)
['{CD0617AF-269F-4D25-9A15-52659D329272}']
    function  pm_GetCount: Integer; stdcall;
    procedure pm_SetCount(aValue: Integer); stdcall;
      { - методы для доступа к свойству Count. }
    procedure Clear; stdcall;
      {* очистить список. }
    procedure Delete(anIndex: Integer); stdcall;
      {* удаляет элемент по индексу Index. }
    property Count: Integer
      read pm_GetCount
      write pm_SetCount;
       {* число элементов в хранилище. }
  // property methods
    procedure  pm_GetItem(anIndex: Integer; out aRet: IConfiguration); stdcall;

    procedure pm_SetItem(anIndex: Integer; const anItem: IConfiguration); stdcall;
      {-}
  // public methods
    function  Add(const anItem: IConfiguration): Integer; stdcall;
      {* - добавляет элемент Item в конец. }
    procedure Insert(anIndex: Integer; const anItem: IConfiguration); stdcall;
      {* - вставляет элемент Item по индексу Index. }
end;//IConfigurations

// Интерфейс обеспечивающий работу со списком конфигураций. Доступен через интерфейс Common.
IConfigurationManager = interface (IInterface) ['{C0C7A25C-7378-40EA-9593-32B590CC6D8E}']
	function DontUseMe: Pointer;
	procedure GetConfigurations (out aRet {: IConfigurations}); stdcall;

	procedure DefaultValuesUpdateCheck (
		out aRet {: IDefaultValuesChangesIndicator}
	); stdcall;

	// возвращает активную конфигурацию
	procedure GetActive (
		out aRet {: IConfiguration}
	); stdcall;

	// Удаляет заданную конфигурацию. В случае попытки удалить активную конфигурацию возбуждает
	// исключение ConfigurationIsActiveNow
	procedure Remove (
		const aConfiguration: IConfiguration
	); stdcall; // can raise EConstantModify, EConfigurationIsActiveNow

	// Устанавливает заданную конфигурацией активной (текущей для интерфейса Settings, полученного
	// через Common)
	procedure SetActive (
		const aConfiguration: IConfiguration
	); stdcall;
end;

// настройки, не зависящие от конфигураций
IPermanentSettingsManager = interface (IBaseSettingsManager) ['{4983A1B9-5021-4CE1-8C13-912831395FB8}']

end;

implementation
end.