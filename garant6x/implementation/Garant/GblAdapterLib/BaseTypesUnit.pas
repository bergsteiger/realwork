unit BaseTypesUnit; {$Z4}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "GblAdapterLib"
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/BaseTypesUnit.pas"
// Delphi интерфейсы для адаптера (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::BaseTypes
//
// Базовые типы, используемые в адаптере
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

interface

uses
	SysUtils
	, IOUnit
	//#UC START# *4423F94903C8_456EA56002BF_UNIT_FOR_Stream*
	//#UC END# *4423F94903C8_456EA56002BF_UNIT_FOR_Stream*
	;

type

INamedElement = interface;
{ - предварительное описание INamedElement. }

IEntityStorage = interface;
{ - предварительное описание IEntityStorage. }

IEntityBase = interface;
{ - предварительное описание IEntityBase. }

ISearchEntity = interface;
{ - предварительное описание ISearchEntity. }

IVariant = interface;
{ - предварительное описание IVariant. }

ILanguagesList = interface;
{ - предварительное описание ILanguagesList. }

IStringList = interface;
{ - предварительное описание IStringList. }


// Идентификатор класса объекта
PClassId = ^TClassId;
TClassId = Longword;

// Идентификатор объекта внутри класса
PObjectId = ^TObjectId;
TObjectId = Longword;

// Persistent ID, тип для идентификации хранимых объектов.
PPId = ^TPId;
TPId = packed record
	rClassId: TClassId; // идентификатор класса
	rObjectId: TObjectId; // идентификатор объекта
end;

// Дата.
PDate = ^TDate;
TDate = packed record
	rDay: Word; // Число
	rMonth: Word; // Месяц
	rYear: Word; // Год.
end;

// Интервал дат (включающий).
PDateInterval = ^TDateInterval;
TDateInterval = packed record
	rStart: TDate; // начальная дата
	rFinish: TDate; // завершающая дата
end;

// Время
PTime = ^TTime;
TTime = packed record
	rHour: Word; // часы
	rMin: Word; // минуты
	rSec: Word; // секунды
end;

// Дата и время
PDateTime = ^TDateTime;
TDateTime = packed record
	rDate: TDate; // Дата
	rTime: TTime; // время
end;

// Языки
PLanguages = ^TLanguages;
TLanguages = (
	LG_RUSSIAN // Русский
	, LG_ENGLISH // Английский
	, LG_FRENCH // Французский
	, LG_GERMAN // Немецкий
	, LG_SPANISH // Испанский
	, LG_ITALIAN // Итальянский
);

// Исключение возникает при попытке изменить константный параметер.
EConstantModify = class (Exception);

// Возбуждается в случае нарушения прав доступа.
EAccessDenied = class (Exception);

// Исключение возбуждается в случае если запрошенная операция не может быть выполнена на сервер, по
// причине неверной метки синхронизации. Возможно необходимо повторить вызов.
EInvalidTimeStamp = class (Exception);

// База блокирована
EStorageLocked = class (Exception);

// Возвращается в случае если вызванная опреация не поддеоживается объектом.
EUnsupported = class (Exception);

// Возвращается при попытке сохранить/восстановить изменения в несохраненном (т.е не привязанном к
// месту хранения, например к папкам) объекте
ENotSaved = class (Exception);

// Папки недоступны.
// Возвращается в случае, если у пользователя нет доступа к папкам.
EFoldersNotAvailable = class (Exception);

// Запрошенные данные не найдены.
// Возвращается в случае, если данные запрошенные по операции get_<something> отсутствуют.
ECanNotFindData = class (Exception);

// Возникает в случае добавления узла в дерево, где уже есть такой же узел. При этом уникальность
// определяется самим узлом.
EDuplicateNode = class (Exception);

// Плохой тип данных
EInvalidType = class (Exception);

// объект не может быть сохранён
ECanNotSave = class (Exception);

// Ошибка при разборе XML
EInvalidXMLType = class (Exception);

// Всё сожержимое отфильтровано, что противоречит бизнес-логике
EAllContentIsFiltered = class (Exception);

// номер кодовой страницы
PCodePage = ^TCodePage;
TCodePage = Smallint;

// Возвращается при операции по изменению дерева в случае, если результат получается пустой, и это
// запрещенно логикой конкретеного дерева.
EEmptyResult = class (Exception);

// Статус элемента.
PItemStatus = ^TItemStatus;
TItemStatus = (
	IS_ABOLISHED // Утратил силу
	, IS_ACTIVE // Действующий
	, IS_PREACTIVE // Не вступил в силу
	, IS_UNKNOWN // Неопределен
);

// Возможные типы элементов основного меню.
PNavigatorMenuItemType = ^TNavigatorMenuItemType;
TNavigatorMenuItemType = (
	NM_FOLDER // Псевдоэлемент - папка.
	, NM_RUBRICATOR // Навигатор по классификатору.
	, NM_ATTRIBUTE_SEARCH // Поиск по атрибутам.
	, NM_SITUATION_SEARCH // Поиск по ситуации.
	, NM_PUBLISH_SOURCE_SEARCH // Поиск по источнику опубликования.
	, NM_SINGLE_CONTEXT_SEARCH // Атомарный (простой) поиск по контексту.
	, NM_SINGLE_ATTRIBUTE_SEARCH // Атомарный (простой) поиск по древовидному атрибуту.
	, NM_SINGLE_DATE_NUMBER_SEARCH // Атомарный (простой) поиск по дате и номеру.
	, NM_FILTER_5X // Карточка фильтра а-ля Гарант 5.х.
	, NM_ATTRIBUTE_SEARCH_5X // Карточка поиска по атрибутам а-ля Гарант 5.х.
	, NM_SITUATION_SEARCH_5X // Карточка поиска по ситуациям а-ля Гарант 5.х.
	, NM_UPDATE // Обновление.
	, NM_CONFIGURATION_LIST // Список конфигураций.
	, NM_LIST // Список.
	, NM_COMPLECT_INFO // Информация о комплекте.
	, NM_DOCUMENT // Документ
	, NM_LAW_NAVIGATOR_FOLDER // Папка "Правовой навигатор"
	, NM_BUSINESS_INFO_FOLDER // Папка "Справочная информация"
	, NM_SEARCH_FOLDER // Папка "Поиск"
	, NM_UPDATE_FOLDER // Папка "Обновление"
	, NM_RECENTLY_DOCUMENTS_FOLDER // Папка "Последние открытые документы"
	, NM_EXPLANATORY_DICTIONARY // Толковый словарь
	, NM_NEW_DOCS // Новые документы
	, NM_PRIME_FOLDER // пункт меню ПРАЙМ
	, NM_REVIEW // пункт меню ОБЗОРЫ ЗАКОНОДАТЕЛЬСТВА
	, NM_NEWS_LINE // мониторинги
	, NM_SEARCH_WITH_LAW_SUPPORT // Пункт меню: Поиск с правовой поддержкой
	, NM_LAW_SUPPORT // пункт меню: правовая поддержка
	, NM_CALENDAR
	, NM_BUSINESS_REFERENCES
	, NM_HOT_INFORMATION
	, NM_CODEX // Кодексы
	, NM_FORMS // Формы документа
	, NM_MONITORINGS // Мониторинги
	, NM_PHARM_SEARCH // поиск в инфарме
	, NM_INPHARM // Инфарм
	, NM_PHARM_LEK // Лекарственные препараты
	, NM_PHARM_FIRMS // Фирмы производители
	, NM_PHARM_DICT // Словарь медицинских терминов
	, NM_PHARM_BASIC_SECTION // Основные разделы справочника
	, NM_TAXES_AND_FINANCE // Налоги и финансы
	, NM_BUSINESS_REFERENCES_FOLDER // Папка Бизнес-справки
	, NM_LEGAL_ISSUES // Юридические вопросы
	, NM_HR // Зарплата и кадры
	, NM_BUDGET_ORGS // Гос. и муниципальные учреждения
	, NM_LAW_FOR_ALL // Право для всех
);

// Тип результата поиска
PSearchResultType = ^TSearchResultType;
TSearchResultType = (
	SRT_DOCUMENT_LIST // найден список документов
	, SRT_AUTOREFERAT // найден автореферат
	, SRT_CONSULTATION // найдена консультация
);

// Направление сортировки.
PSortOrder = ^TSortOrder;
TSortOrder = (
	SO_ASCENDING // По возрастанию значений.
	, SO_DESCENDING // По убыванию значений.
);

// Тип сортировки.
PSortType = ^TSortType;
TSortType = (
	ST_PRIORITY // Сортировка по юридической силе
	, ST_CREATE_DATE // Сортировка по дате создания
	, ST_LAST_EDIT_DATE // Сортировка по дате последнего изменения
	, ST_NOT_SORTED // Не отсортирован
	, ST_RELEVANCE // сортировка по релевантности
);

// Параметры сортировки.
PSortParams = ^TSortParams;
TSortParams = packed record
	rSortOrder: TSortOrder; // порядок сортировки
	rSortType: TSortType; // тип сортивровки
end;

// Типы поиска по контексту
PTextSearchOptionType = ^TTextSearchOptionType;
TTextSearchOptionType = (
	TSO_TEXT // поиск по тексту
	, TSO_NAME // поиск по заголовку
	, TSO_PARA // поиск по параграфу
	, TSO_SENTENCE // поиск по предложению
);

// Произошла внутреняя ошибка при обращении к базе
EInternalDatabaseError = class (Exception);

// выбрасывается из методов, которые могут дергаться только в контексте сессии, т.е. после логина
ENoSession = class (Exception);

// Элемент с таким именем уже существует, а два и более созадвать нельзя
EDuplicateName = class (Exception);

// идентификатор пользователя или группы
PUid = ^TUid;
TUid = Longint;

PListNodeType = ^TListNodeType;
TListNodeType = (
	LNT_SUB // Саб
	, LNT_PARA // Параграф
	, LNT_EXTERNAL_OBJECT // Объект, открываемый во внешнем приложении
	, LNT_EXTERNAL_LINK
	, LNT_DOCUMENT_ABOLISHED // Утративший силу документ
	, LNT_DOCUMENT_ACTIVE // Документ
	, LNT_DOCUMENT_PREACTIVE // Не вступивший в силу документ
	, LNT_DOCUMENT_UNKNOWN // Неизвестный тип
	, LNT_EDITION_ABOLISHED // Утратившая силу редакция
	, LNT_EDITION_ACTIVE // Актуальная редакция
	, LNT_EDITION_PREACTIVE // Редакция, которая еще не действует
	, LNT_EDITION_UNKNOWN // Неизвестный тип редакции
	, LNT_EDITIONS_GROUP // Узел Редакции
	, LNT_BLOCK // Блок
	, LNT_DRUG_ANNULED // препарат аннулирован
	, LNT_DRUG_NARCOTIC // наркотический препарат
	, LNT_DRUG_NONANNULED_NONNARCOTIC // разрешённый ненаркотический препарат
	, LNT_FORM_ANNULED // аннулированная форма препарата
	, LNT_FORM_RUSSIAN_IMPORTANT // жизненноважный российский препарат
	, LNT_FORM_NONRUSSIAN_IMPORTANT // жизненноважный иностранный препарат
	, LNT_FORM_RUSSIAN_NONIMPORTANT // российский препарат
	, LNT_FORM_NONRUSSIAN_NONIMPORTANT // иностранный препарат
	, LNT_FIRM // Фирма
	, LNT_AAK // Документ ААК
);

// Это создал Шура, т.к. были коллизии с модулем ActiveX и его ObjectId в модуле Document
PBaseTypesObjectId = ^TBaseTypesObjectId;
TBaseTypesObjectId = TObjectId;

// Именованный элемент.
INamedElement = interface (IInterface) ['{E6AAFF18-FAD7-4E46-A586-CEEC45905094}']
	function DontUseMe: Pointer;
	// комментарий
	procedure GetComment (out aRet {: IString}); stdcall;
	procedure SetComment (const aComment: IString); stdcall;

	// имя
	procedure GetName (out aRet {: IString}); stdcall;
	procedure SetName (const aName: IString); stdcall;
end;

// Хранилище сущностей
IEntityStorage = interface (IInterface) ['{D4613491-81A1-4AD8-B51E-95923E4DA97A}']
	function DontUseMe: Pointer;

end;

// Базовый абстрактный интерфейс для сущностей. Данный интерфейс должен заменить устаревыший
// BaseTreeSupport::BaseEntity .
IEntityBase = interface (IInterface) ['{AC2E64E2-18A5-4F4A-B16F-A186B4F6BB37}']
	function DontUseMe: Pointer;
	// Сохраняет в базе  измененное состояние объекта.
	// Объеденяя с с ранее сохраненными данными
	procedure AppendTo (
		const aStorage: IEntityStorage;
		out aRet {: IEntityStorage}
	); stdcall; // can raise EConstantModify, EAccessDenied, EUnsupported, ECanNotSave

	// идентификатор
	function GetEid (): Longword; stdcall;

	// свойство изменённости
	function GetIsChanged (): Bytebool; stdcall;

	// Признак того что данный объект уже сохранен в базе данных. Для не сохраненный объекта сначало
	// необходимо указать место хранения (чаще всего папки). Для не сохраненных объектов операция save
	// вернет исключение.
	function GetIsSaved (): Bytebool; stdcall;

	// Перезаписать сущность текущей сущностью.
	procedure SaveTo (
		const aStorage: IEntityStorage;
		out aRet {: IEntityStorage}
	); stdcall; // can raise EAccessDenied, EUnsupported, ENotSaved, EDuplicateNode, ECanNotSave
end;

// Сущность, передаваемая в метод finish_process на прогресс индикаторе, как результат поиска
ISearchEntity = interface (IInterface) ['{8299FB1B-C061-4407-84D9-AF61A0E35754}']
	function DontUseMe: Pointer;
	// Количество найденных документов
	function GetDocumentCount (): Cardinal; stdcall;

	// количество редакций
	function GetEditionCount (): Cardinal; stdcall;

	// Количество вхождений
	function GetEntryCount (): Cardinal; stdcall;

	// Тип результата поиска (список, автореферат, консультация)
	function GetResultType (): TSearchResultType; stdcall;
end;

// тип данных для нотификации
IVariant = interface (IInterface) ['{0B872568-888B-4CC1-B7ED-D0E555EDA7B7}']
	function DontUseMe: Pointer;
	// вернуть булево значение
	function GetBool (): Bytebool; stdcall; // can raise EInvalidType

	// вернуть целое
	function GetLong (): Longint; stdcall; // can raise EInvalidType

	// вернуть объект
	procedure GetObject (
		out aRet {: IUnknown}
	); stdcall; // can raise EInvalidType

	// вернуть строку
	procedure GetString (
		out aRet {: IString}
	); stdcall; // can raise EInvalidType
end;

ILanguagesList = interface(IInterface)
['{47BCBDD9-CFDB-45E8-9F95-F36B63C7D91B}']
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
    function  pm_GetItem(anIndex: Integer): TLanguages; stdcall;

    procedure pm_SetItem(anIndex: Integer; const anItem: TLanguages); stdcall;
      {-}
  // public methods
    function  Add(const anItem: TLanguages): Integer; stdcall;
      {* - добавляет элемент Item в конец. }
    procedure Insert(anIndex: Integer; const anItem: TLanguages); stdcall;
      {* - вставляет элемент Item по индексу Index. }
  // public properties
    property  Items[anIndex: Integer]: TLanguages
      read pm_GetItem
      write pm_SetItem;
      default;
      {* - элементы списка. }
end;//ILanguagesList

IStringList = interface(IInterface)
['{A315F0A6-6BEE-4779-936A-D3E119E97C7D}']
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
end;//IStringList

const

 { Общие константы, используемые в GblAdapter }
	NODE_FLAG_STORABLE_ENTITY = Longint(1);
 { маска, применяемая к Node::flags. Если BaseEntity::storable == true, то (Node::flags AND NODE_FLAG_STORABLE_ENTITY) возвращает true }
	PROPERTY_PATH_DELIMITER = '/';
 { символ - разделитель частей пути }
	DEFAULT_PRELOAD_CACHE = Longword(50);
 { Размер по умолчанию при подгрузке фильтрованных эелментов дерева атрибутов. }
	LIBRARY_NAME = 'GblAdapter.dll';
 { Название библиотеки }

 { KindConstants }
	ALL_DOCUMENTS_KIND = Int64(-1);

implementation
end.