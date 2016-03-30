unit BaseTypesUnit;
 {* Базовые типы, используемые в адаптере }

// Модуль: "w:\garant6x\implementation\Garant\tie\Garant\GblAdapterLib\BaseTypesUnit.pas"
// Стереотип: "Interfaces"
// Элемент модели: "BaseTypes" MUID: (456EA56002BF)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , IOUnit
 //#UC START# *456EA56002BFintf_uses*
 //#UC END# *456EA56002BFintf_uses*
;

const
 {* Общие константы, используемые в GblAdapter }
 NODE_FLAG_STORABLE_ENTITY: Integer = 1;
  {* маска, применяемая к Node::flags. Если BaseEntity::storable == true, то (Node::flags AND NODE_FLAG_STORABLE_ENTITY) возвращает true }
 PROPERTY_PATH_DELIMITER: PAnsiChar = /;
  {* символ - разделитель частей пути }
 DEFAULT_PRELOAD_CACHE: Cardinal = 50;
  {* Размер по умолчанию при подгрузке фильтрованных эелментов дерева атрибутов. }
 LIBRARY_NAME: PAnsiChar = GblAdapter.dll;
  {* Название библиотеки }
 ALL_DOCUMENTS_KIND: unsigned long long = -1;

type
 TClassId = Cardinal;
  {* Идентификатор класса объекта }

 TObjectId = Cardinal;
  {* Идентификатор объекта внутри класса }

 TPId = record
  {* Persistent ID, тип для идентификации хранимых объектов. }
  class_id: TClassId;
   {* идентификатор класса }
  object_id: TObjectId;
   {* идентификатор объекта }
 end;//TPId

 TDate = record
  {* Дата. }
  day: unsigned short;
   {* Число }
  month: unsigned short;
   {* Месяц }
  year: unsigned short;
   {* Год. }
 //#UC START# *456EA6F00109publ*
 //#UC END# *456EA6F00109publ*
 end;//TDate

 TDateInterval = record
  {* Интервал дат (включающий). }
  start: TDate;
   {* начальная дата }
  finish: TDate;
   {* завершающая дата }
 end;//TDateInterval

 TTime = record
  {* Время }
  hour: unsigned short;
   {* часы }
  min: unsigned short;
   {* минуты }
  sec: unsigned short;
   {* секунды }
 end;//TTime

 TDateTime = record
  {* Дата и время }
  date: TDate;
   {* Дата }
  time: TTime;
   {* время }
 end;//TDateTime

 TLanguages = (
  {* Языки }
  LG_RUSSIAN
   {* Русский }
  , LG_ENGLISH
   {* Английский }
  , LG_FRENCH
   {* Французский }
  , LG_GERMAN
   {* Немецкий }
  , LG_SPANISH
   {* Испанский }
  , LG_ITALIAN
   {* Итальянский }
 );//TLanguages

 INamedElement = interface
  {* Именованный элемент. }
  ['{E6AAFF18-FAD7-4E46-A586-CEEC45905094}']
  function GetName: IString; stdcall;
  procedure SetName(const aValue: IString); stdcall;
  function GetComment: IString; stdcall;
  procedure SetComment(const aValue: IString); stdcall;
  property Name: IString
   read GetName
   write SetName;
   {* имя }
  property Comment: IString
   read GetComment
   write SetComment;
   {* комментарий }
 end;//INamedElement

 ConstantModify = class
  {* Исключение возникает при попытке изменить константный параметер. }
 end;//ConstantModify

 AccessDenied = class
  {* Возбуждается в случае нарушения прав доступа. }
 end;//AccessDenied

 InvalidTimeStamp = class
  {* Исключение возбуждается в случае если запрошенная операция не может быть выполнена на сервер, по причине неверной метки синхронизации. Возможно необходимо повторить вызов. }
 end;//InvalidTimeStamp

 StorageLocked = class
  {* База блокирована }
 end;//StorageLocked

 Unsupported = class
  {* Возвращается в случае если вызванная опреация не поддеоживается объектом. }
 end;//Unsupported

 NotSaved = class
  {* Возвращается при попытке сохранить/восстановить изменения в несохраненном (т.е не привязанном к месту хранения, например к папкам) объекте }
 end;//NotSaved

 FoldersNotAvailable = class
  {* Папки недоступны.
Возвращается в случае, если у пользователя нет доступа к папкам. }
 end;//FoldersNotAvailable

 CanNotFindData = class
  {* Запрошенные данные не найдены.
Возвращается в случае, если данные запрошенные по операции get_<something> отсутствуют. }
 end;//CanNotFindData

 DuplicateNode = class
  {* Возникает в случае добавления узла в дерево, где уже есть такой же узел. При этом уникальность определяется самим узлом. }
 end;//DuplicateNode

 InvalidType = class
  {* Плохой тип данных }
 end;//InvalidType

 CanNotSave = class
  {* объект не может быть сохранён }
 end;//CanNotSave

 InvalidXMLType = class
  {* Ошибка при разборе XML }
 end;//InvalidXMLType

 AllContentIsFiltered = class
  {* Всё сожержимое отфильтровано, что противоречит бизнес-логике }
 end;//AllContentIsFiltered

 TCodePage = short;
  {* номер кодовой страницы }

 IEntityStorage = interface
  {* Хранилище сущностей }
  ['{D4613491-81A1-4AD8-B51E-95923E4DA97A}']
  procedure GetContentType; stdcall;
   {* получить тип содержимого }
  procedure GetCachedContent; stdcall;
   {* получить содежимое }
 end;//IEntityStorage

 IEntityBase = interface
  {* Базовый абстрактный интерфейс для сущностей. Данный интерфейс должен заменить устаревыший BaseTreeSupport::BaseEntity . }
  ['{AC2E64E2-18A5-4F4A-B16F-A186B4F6BB37}']
  function GetIsSaved: ByteBool; stdcall;
  function GetIsChanged: ByteBool; stdcall;
  function GetEid: Cardinal; stdcall; { can raise Unsupported }
  function SaveTo(var storage: IEntityStorage): IEntityStorage; stdcall; { can raise AccessDenied, Unsupported, NotSaved, DuplicateNode, CanNotSave }
   {* Перезаписать сущность текущей сущностью. }
  function AppendTo(var storage: IEntityStorage): IEntityStorage; stdcall; { can raise ConstantModify, AccessDenied, Unsupported, CanNotSave }
   {* Сохраняет в базе  измененное состояние объекта.
Объеденяя с с ранее сохраненными данными }
  property IsSaved: ByteBool
   read GetIsSaved;
   {* Признак того что данный объект уже сохранен в базе данных. Для не сохраненный объекта сначало необходимо указать место хранения (чаще всего папки). Для не сохраненных объектов операция save вернет исключение. }
  property IsChanged: ByteBool
   read GetIsChanged;
   {* свойство изменённости }
  property Eid: Cardinal
   read GetEid;
   {* идентификатор }
 end;//IEntityBase

 EmptyResult = class
  {* Возвращается при операции по изменению дерева в случае, если результат получается пустой, и это запрещенно логикой конкретеного дерева. }
 end;//EmptyResult

 TItemStatus = (
  {* Статус элемента. }
  IS_ABOLISHED
   {* Утратил силу }
  , IS_ACTIVE
   {* Действующий }
  , IS_PREACTIVE
   {* Не вступил в силу }
  , IS_UNKNOWN
   {* Неопределен }
 );//TItemStatus

 TNavigatorMenuItemType = (
  {* Возможные типы элементов основного меню. }
  NM_FOLDER
   {* Псевдоэлемент - папка. }
  , NM_RUBRICATOR
   {* Навигатор по классификатору. }
  , NM_ATTRIBUTE_SEARCH
   {* Поиск по атрибутам. }
  , NM_SITUATION_SEARCH
   {* Поиск по ситуации. }
  , NM_PUBLISH_SOURCE_SEARCH
   {* Поиск по источнику опубликования. }
  , NM_SINGLE_CONTEXT_SEARCH
   {* Атомарный (простой) поиск по контексту. }
  , NM_SINGLE_ATTRIBUTE_SEARCH
   {* Атомарный (простой) поиск по древовидному атрибуту. }
  , NM_SINGLE_DATE_NUMBER_SEARCH
   {* Атомарный (простой) поиск по дате и номеру. }
  , NM_FILTER_5X
   {* Карточка фильтра а-ля Гарант 5.х. }
  , NM_ATTRIBUTE_SEARCH_5X
   {* Карточка поиска по атрибутам а-ля Гарант 5.х. }
  , NM_SITUATION_SEARCH_5X
   {* Карточка поиска по ситуациям а-ля Гарант 5.х. }
  , NM_UPDATE
   {* Обновление. }
  , NM_CONFIGURATION_LIST
   {* Список конфигураций. }
  , NM_LIST
   {* Список. }
  , NM_COMPLECT_INFO
   {* Информация о комплекте. }
  , NM_DOCUMENT
   {* Документ }
  , NM_LAW_NAVIGATOR_FOLDER
   {* Папка "Правовой навигатор" }
  , NM_BUSINESS_INFO_FOLDER
   {* Папка "Справочная информация" }
  , NM_SEARCH_FOLDER
   {* Папка "Поиск" }
  , NM_UPDATE_FOLDER
   {* Папка "Обновление" }
  , NM_RECENTLY_DOCUMENTS_FOLDER
   {* Папка "Последние открытые документы" }
  , NM_EXPLANATORY_DICTIONARY
   {* Толковый словарь }
  , NM_NEW_DOCS
   {* Новые документы }
  , NM_PRIME_FOLDER
   {* пункт меню ПРАЙМ }
  , NM_REVIEW
   {* пункт меню ОБЗОРЫ ЗАКОНОДАТЕЛЬСТВА }
  , NM_NEWS_LINE
   {* мониторинги }
  , NM_SEARCH_WITH_LAW_SUPPORT
   {* Пункт меню: Поиск с правовой поддержкой }
  , NM_LAW_SUPPORT
   {* пункт меню: правовая поддержка }
  , NM_CALENDAR
  , NM_BUSINESS_REFERENCES
  , NM_HOT_INFORMATION
  , NM_CODEX
   {* Кодексы }
  , NM_FORMS
   {* Формы документа }
  , NM_MONITORINGS
   {* Мониторинги }
  , NM_PHARM_SEARCH
   {* поиск в инфарме }
  , NM_INPHARM
   {* Инфарм }
  , NM_PHARM_LEK
   {* Лекарственные препараты }
  , NM_PHARM_FIRMS
   {* Фирмы производители }
  , NM_PHARM_DICT
   {* Словарь медицинских терминов }
  , NM_PHARM_BASIC_SECTION
   {* Основные разделы справочника }
  , NM_TAXES_AND_FINANCE
   {* Налоги и финансы }
  , NM_BUSINESS_REFERENCES_FOLDER
   {* Папка Бизнес-справки }
  , NM_LEGAL_ISSUES
   {* Юридические вопросы }
  , NM_HR
   {* Зарплата и кадры }
  , NM_BUDGET_ORGS
   {* Гос. и муниципальные учреждения }
  , NM_LAW_FOR_ALL
   {* Право для всех }
  , NM_GOS_ZAKUPKI
 );//TNavigatorMenuItemType

 TSearchResultType = (
  {* Тип результата поиска }
  SRT_DOCUMENT_LIST
   {* найден список документов }
  , SRT_AUTOREFERAT
   {* найден автореферат }
  , SRT_CONSULTATION
   {* найдена консультация }
 );//TSearchResultType

 ISearchEntity = interface
  {* Сущность, передаваемая в метод finish_process на прогресс индикаторе, как результат поиска }
  ['{8299FB1B-C061-4407-84D9-AF61A0E35754}']
  function GetResultType: TSearchResultType; stdcall;
  function GetDocumentCount: size; stdcall;
  function GetEntryCount: size; stdcall;
  function GetEditionCount: size; stdcall;
  property ResultType: TSearchResultType
   read GetResultType;
   {* Тип результата поиска (список, автореферат, консультация) }
  property DocumentCount: size
   read GetDocumentCount;
   {* Количество найденных документов }
  property EntryCount: size
   read GetEntryCount;
   {* Количество вхождений }
  property EditionCount: size
   read GetEditionCount;
   {* количество редакций }
 end;//ISearchEntity

 TSortOrder = (
  {* Направление сортировки. }
  SO_ASCENDING
   {* По возрастанию значений. }
  , SO_DESCENDING
   {* По убыванию значений. }
 );//TSortOrder

 TSortType = (
  {* Тип сортировки. }
  ST_PRIORITY
   {* Сортировка по юридической силе }
  , ST_CREATE_DATE
   {* Сортировка по дате создания }
  , ST_LAST_EDIT_DATE
   {* Сортировка по дате последнего изменения }
  , ST_NOT_SORTED
   {* Не отсортирован }
  , ST_RELEVANCE
   {* сортировка по релевантности }
 );//TSortType

 TSortParams = record
  {* Параметры сортировки. }
  sort_order: TSortOrder;
   {* порядок сортировки }
  sort_type: TSortType;
   {* тип сортивровки }
 end;//TSortParams

 TTextSearchOptionType = (
  {* Типы поиска по контексту }
  TSO_TEXT
   {* поиск по тексту }
  , TSO_NAME
   {* поиск по заголовку }
  , TSO_PARA
   {* поиск по параграфу }
  , TSO_SENTENCE
   {* поиск по предложению }
 );//TTextSearchOptionType

 IVariant = interface
  {* тип данных для нотификации }
  ['{0B872568-888B-4CC1-B7ED-D0E555EDA7B7}']
  function GetLong: Integer; stdcall; { can raise InvalidType }
   {* вернуть целое }
  function GetBool: ByteBool; stdcall; { can raise InvalidType }
   {* вернуть булево значение }
  function GetString: IString; stdcall; { can raise InvalidType }
   {* вернуть строку }
  function GetObject: IUnknown; stdcall; { can raise InvalidType }
   {* вернуть объект }
 end;//IVariant

 ILanguagesList = array of TLanguages;
  {* Список языков }

 IStringList = array of IString;
  {* контейнер строк }

 InternalDatabaseError = class
  {* Произошла внутреняя ошибка при обращении к базе }
 end;//InternalDatabaseError

 NoSession = class
  {* выбрасывается из методов, которые могут дергаться только в контексте сессии, т.е. после логина }
 end;//NoSession

 DuplicateName = class
  {* Элемент с таким именем уже существует, а два и более созадвать нельзя }
 end;//DuplicateName

 TUid = Integer;
  {* идентификатор пользователя или группы }

 TListNodeType = (
  LNT_SUB
   {* Саб }
  , LNT_PARA
   {* Параграф }
  , LNT_EXTERNAL_OBJECT
   {* Объект, открываемый во внешнем приложении }
  , LNT_EXTERNAL_LINK
  , LNT_DOCUMENT_ABOLISHED
   {* Утративший силу документ }
  , LNT_DOCUMENT_ACTIVE
   {* Документ }
  , LNT_DOCUMENT_PREACTIVE
   {* Не вступивший в силу документ }
  , LNT_DOCUMENT_UNKNOWN
   {* Неизвестный тип }
  , LNT_EDITION_ABOLISHED
   {* Утратившая силу редакция }
  , LNT_EDITION_ACTIVE
   {* Актуальная редакция }
  , LNT_EDITION_PREACTIVE
   {* Редакция, которая еще не действует }
  , LNT_EDITION_UNKNOWN
   {* Неизвестный тип редакции }
  , LNT_EDITIONS_GROUP
   {* Узел Редакции }
  , LNT_BLOCK
   {* Блок }
  , LNT_DRUG_ANNULED
   {* препарат аннулирован }
  , LNT_DRUG_NARCOTIC
   {* наркотический препарат }
  , LNT_DRUG_NONANNULED_NONNARCOTIC
   {* разрешённый ненаркотический препарат }
  , LNT_FORM_ANNULED
   {* аннулированная форма препарата }
  , LNT_FORM_RUSSIAN_IMPORTANT
   {* жизненноважный российский препарат }
  , LNT_FORM_NONRUSSIAN_IMPORTANT
   {* жизненноважный иностранный препарат }
  , LNT_FORM_RUSSIAN_NONIMPORTANT
   {* российский препарат }
  , LNT_FORM_NONRUSSIAN_NONIMPORTANT
   {* иностранный препарат }
  , LNT_FIRM
   {* Фирма }
  , LNT_AAK
   {* Документ ААК }
 );//TListNodeType

 TBaseTypesObjectId = TObjectId;
  {* Это создал Шура, т.к. были коллизии с модулем ActiveX и его ObjectId в модуле Document }

function Make; overload; stdcall;
 {* создать нулевую дату }
function Make(y: unsigned short;
 m: unsigned short;
 d: unsigned short); overload; stdcall;
 {* создать заданную дату }

implementation

uses
 l3ImplUses
 //#UC START# *456EA56002BFimpl_uses*
 //#UC END# *456EA56002BFimpl_uses*
;

function Make;
 {* создать нулевую дату }
//#UC START# *462C9BE5030D_456EA6F00109_var*
//#UC END# *462C9BE5030D_456EA6F00109_var*
begin
 System.FillChar(Result, SizeOf(Result), 0);
//#UC START# *462C9BE5030D_456EA6F00109_impl*
 !!! Needs to be implemented !!!
//#UC END# *462C9BE5030D_456EA6F00109_impl*
end;//Make

function Make(y: unsigned short;
 m: unsigned short;
 d: unsigned short);
 {* создать заданную дату }
//#UC START# *462C9BF10128_456EA6F00109_var*
//#UC END# *462C9BF10128_456EA6F00109_var*
begin
 System.FillChar(Result, SizeOf(Result), 0);
//#UC START# *462C9BF10128_456EA6F00109_impl*
 !!! Needs to be implemented !!!
//#UC END# *462C9BF10128_456EA6F00109_impl*
end;//Make

end.
