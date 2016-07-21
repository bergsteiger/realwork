unit SearchUnit;

// Модуль: "w:\garant6x\implementation\Garant\tie\Garant\GblAdapterLib\SearchUnit.pas"
// Стереотип: "Interfaces"
// Элемент модели: "Search" MUID: (45EEAA8E034E)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , IOUnit
 , BaseTypesUnit
 , DynamicDocListUnit
 , FoldersUnit
 , DocumentUnit
 , DynamicTreeUnit
 , FiltersUnit
 , ProgressIndicatorSupportUnit
 , SearchDefinesUnit
 , SearchProgressIndicatorUnit
;

const
 {* константы для оболочки - К121160631 }
 AT_CONSULTATION_TEXT: PAnsiChar = AT_CONSULTATION_TEXT;
 AT_LAW_SUPPORT_TEXT: PAnsiChar = AT_LAW_SUPPORT_TEXT;
 AT_TEXT: PAnsiChar = AT_TEXT;
 AT_TEXT_NAME: PAnsiChar = AT_TEXT_NAME;
 AT_TEXT_BODY: PAnsiChar = AT_TEXT_BODY;
 AT_THEMES_NAME: PAnsiChar = AT_THEMES_NAME;
 AT_CONSULTATION_DESCRIPTION: PAnsiChar = AT_CONSULTATION_DESCRIPTION;
 AT_USER_NAME: PAnsiChar = AT_USER_NAME;
 AT_EMAIL: PAnsiChar = AT_EMAIL;
 AT_PHARM_NAME: PAnsiChar = AT_PHARM_NAME;
 AT_PHARM_TEXT: PAnsiChar = AT_PHARM_TEXT;
 AT_SHORT_LIST: PAnsiChar = AT_SHORT_LIST;
 AT_USER_PHONE: PAnsiChar = AT_USER_PHONE;
 QCT_PRIME: PAnsiChar = QCT_PRIME;
  {* карточка прайма }
 QCT_ATTRIBUTE: PAnsiChar = QCT_ATTRIBUTE;
  {* карточка ППР }
 QCT_REVIEW: PAnsiChar = QCT_REVIEW;
  {* карточка поиска по изменениям законодательства }
 QCT_CONSULTING: PAnsiChar = QCT_CONSULTING;
  {* карточка запроса к консалтингу }
 QCT_PHARM: PAnsiChar = QCT_PHARM;
  {* карточка инфарма }

type
 TQueryType = (
  QT_KEYWORD
  , QT_ATTRIBUTE
  , QT_PUBLISHED_SOURCE
  , QT_COMMENTS
  , QT_REVIEW
  , QT_MAIL_LIST
  , QT_RUBRICATOR
  , QT_CONSULT
  , QT_HANDYCRAFT_CONSULT
  , QT_DETAIL
   {* Детализация СКР }
  , QT_BASE_SEARCH
   {* Карточка базового поиска }
  , QT_PHARM_SEARCH
   {* Поиск в Инфарме }
 );//TQueryType

 TQueryTagType = (
  QTT_CONTEXT
  , QTT_NODE
  , QTT_DATE
  , QTT_PHONE_NUMBER
   {* номер телефона }
 );//TQueryTagType

 IQueryAttribute = interface
  ['{F7B99D7B-8104-4890-A107-57D3524BDEE1}']
  function GetType: TQueryTagType; stdcall;
  procedure Clear; stdcall;
  function GetTag: TAttributeTag; stdcall;
  property Type: TQueryTagType
   read GetType;
 end;//IQueryAttribute

 TQueryLogicOperation = (
  {* Возможные логические операции для объединения поисковых атрибутов и списков. }
  QLO_AND
   {* Логическое И. }
  , QLO_OR
   {* Логическое ИЛИ. }
  , QLO_AND_NOT
   {* Кроме.
Данная логическая операция используется только при получении список карточке запроса - Search::get_query_forms. Для установки этой операции на узлах запросов QueryNode, у них предусмотрен флаг negative. }
 );//TQueryLogicOperation

 IQueryPhoneNumberAttribute = interface(IQueryAttribute)
  {* Телефон юзера }
  ['{D08C1696-445B-4611-93D3-D9B172B925AB}']
  procedure GetPhoneNumber; stdcall;
  procedure SetPhoneNumber(const aValue); stdcall;
  procedure GetCityCode; stdcall;
  procedure SetCityCode(const aValue); stdcall;
  property PhoneNumber: 
   read GetPhoneNumber
   write SetPhoneNumber;
  property CityCode: 
   read GetCityCode
   write SetCityCode;
 end;//IQueryPhoneNumberAttribute

 TQueryNodeValue = record
  node: ;
  operation: TQueryLogicOperation;
 end;//TQueryNodeValue

 TContextValue = record
  context: ;
  operation: TQueryLogicOperation;
 end;//TContextValue

 IContextValueList = array of TContextValue;

 TDateValue = record
  from: ;
  to: ;
  operation: TQueryLogicOperation;
 end;//TDateValue

 IDateValueList = array of TDateValue;

 IQueryDateAttribute = interface(IQueryAttribute)
  ['{3CAD67CD-205A-4E98-9240-49311D9B33D2}']
  procedure GetValues; stdcall;
  procedure AddValue(operation: TQueryLogicOperation;
   const from: TDate;
   const to: TDate); stdcall;
  property Values: 
   read GetValues;
 end;//IQueryDateAttribute

 INodeValueList = array of TQueryNodeValue;

 IQueryNodeAttribute = interface(IQueryAttribute)
  ['{6BD5D1EC-803B-4923-BAB6-DBBC28685620}']
  procedure GetValues; stdcall;
  procedure AddValue(operation: TQueryLogicOperation;
   var node: INodeBase); stdcall;
  property Values: 
   read GetValues;
 end;//IQueryNodeAttribute

 IQueryAttributeList = array of IQueryAttribute;

 IOperationList = array of TQueryLogicOperation;

 IQueryContextAttribute = interface(IQueryAttribute)
  ['{3219EAF4-9E07-4548-9955-B0B8460FB3C8}']
  procedure GetValues; stdcall;
  procedure AddValue(operation: TQueryLogicOperation;
   var context: IString); stdcall;
  property Values: 
   read GetValues;
 end;//IQueryContextAttribute

 IAttributeInfo = interface
  ['{866DFFF9-C146-4174-B3A8-831190DFEA4D}']
  function GetIsExist: ByteBool; stdcall;
  procedure GetAvailableOperations; stdcall;
  procedure GetDefaultValue(out aRet
   {* IQueryAttribute }); stdcall;
   {* Получить дефолтное значение атрибута }
  property IsExist: ByteBool
   read GetIsExist;
  property AvailableOperations: 
   read GetAvailableOperations;
 end;//IAttributeInfo

 IContextWordList = array of IString;
  {* Список слов }

 NoDefaultValue = class
  {* Для атрибута нет значения по умолчанию }
 end;//NoDefaultValue

 IQuery = interface(IEntityBase)
  {* Интерфейс обеспечивающий работу с запросом. Объекты этого интерфейса расположены в узлах навигатора.
Поисковый запрос формируется при помощи узлов QueryOperationNode и QueryAttributeNode, сгруппированных в виде нисходящего бинарного дерева. }
  ['{73F075AC-4899-45B6-8C26-44A4C1EAA2C2}']
  function GetCount: Cardinal; stdcall;
  function GetType: TQueryType; stdcall;
  procedure GetDate; stdcall;
  procedure GetAttributes; stdcall;
  procedure Execute(var filtrate_list: IDynList;
   var progress: IProgressIndicatorForSearch;
   out cancel_process: ICancelSearch); stdcall;
  procedure GetContextAttribute(tag: TAttributeTag;
   out aRet
   {* IQueryContextAttribute }); stdcall;
  procedure GetNodeAttribute(tag: TAttributeTag;
   out aRet
   {* IQueryNodeAttribute }); stdcall;
  procedure GetDateAttribute(tag: TAttributeTag;
   out aRet
   {* IQueryDateAttribute }); stdcall;
  procedure Clear; stdcall;
  procedure AttributesByTag(tag: TAttributeTag;
   out aRet
   {* IQueryAttributeList }); stdcall;
  procedure Clone(out aRet
   {* IQuery }); stdcall;
  procedure SendQuery; stdcall;
   {* Отправить запрос на консультацию }
  procedure GetPhoneNumberAttribute(tag: TAttributeTag;
   out aRet
   {* IQueryPhoneNumberAttribute }); stdcall;
  procedure BuildQuery; stdcall;
  procedure SetName(var name: IString); stdcall;
  procedure GetName(out aRet
   {* IString }); stdcall;
  procedure GetComment(out aRet
   {* IString }); stdcall;
  procedure SetComment(var comment: IString); stdcall;
  function IsFilterQuery: ByteBool; stdcall;
   {* получен ли запрос с фильтра }
  property Count: Cardinal
   read GetCount;
   {* Количество найденных документов при последнем поиске. }
  property Type: TQueryType
   read GetType;
  property Date: 
   read GetDate;
  property Attributes: 
   read GetAttributes;
 end;//IQuery

 IQueryList = array of IQuery;
  {* Список запросов. }

 TAttributeFilterType = (
  AFT_NONE
  , AFT_TRIM
 );//TAttributeFilterType

 ISearch = interface
  {* Поиск. }
  ['{E15D4E0A-900B-460A-BC2C-F35D282B3766}']
  function GetIsMorphoExist: ByteBool; stdcall;
  procedure CreateQuery(type: TQueryType;
   out aRet
   {* IQuery }); stdcall;
   {* Создать новый поисковый запрос. В созданном поисковом запросе по умолчанию создаеться корневой QueryOperationNode с опреацией LO_AND. }
  procedure GetAttributeInfo(tag: TAttributeTag;
   out aRet
   {* IAttributeInfo }); stdcall;
  function GetExampleTextCount: Cardinal; stdcall;
   {* Получить количество примеров }
  procedure GetExampleText(pos: Cardinal;
   out aRet
   {* IString }); stdcall; { can raise CanNotFindData }
   {* получить текст примера по заданной позиции pos }
  procedure GetDocumentsWithoutClass(out aRet
   {* IDynList }); stdcall;
   {* Список документов без команды CLASS }
  procedure GetDocumentsWithoutIncluded(out aRet
   {* IDynList }); stdcall;
   {* Cписок документов с командой vanonced и без команды vincluded }
  procedure GetDocumentsWithoutKey(out aRet
   {* IDynList }); stdcall;
   {* Cписок документов без команды key }
  procedure CorrectContext(const context_for_check: IContextWordList;
   for_inpharm: Boolean;
   out corrected_context: IContextWordList;
   out aRet
   {* IContextWordList }); stdcall;
   {* Возвращает список слов, которые не смогли скорректировать и скорректированную строку }
  property IsMorphoExist: ByteBool
   read GetIsMorphoExist;
 end;//ISearch

 QueryNotExecuted = class
 end;//QueryNotExecuted

 IFullAttributeInfo = interface(IAttributeInfo)
  {* информация об атрибуте для КЗ }
  ['{5898650D-3C1B-4820-AA3E-6C7A9809F267}']
  procedure GetTag; stdcall;
  property Tag: 
   read GetTag;
 end;//IFullAttributeInfo

 IAttributeList = array of IFullAttributeInfo;

 IQueryCardInfo = interface
  {* информация, связанная с карточкой запроса }
  ['{F9D884BA-B356-4A7C-8997-D3E74A8FB8F1}']
  procedure GetEvdCard; stdcall; { can raise CanNotFindData }
  class function Create; stdcall;
  procedure GetExistAttrs(out aRet
   {* IAttributeList }); stdcall;
   {* получить список существующих атрибутов для КЗ }
  property EvdCard: 
   read GetEvdCard;
 end;//IQueryCardInfo

 IAttributesHelper = interface
  {* информация об атрибутах, которая напрямую не касается карточек }
  ['{03CD2930-3AE2-4CC9-9BE4-501A2B758C64}']
  function AttributeKWExists: ByteBool; stdcall;
  function AttributePublishSourceExists: ByteBool; stdcall;
 end;//IAttributesHelper

function Make(var node_: INodeBase;
 operation_: TQueryLogicOperation); overload; stdcall;
function Make; overload; stdcall;
 {* конструктор по умолчанию }
function Make(var context_: IString); overload; stdcall;
function Make; overload; stdcall;
 {* конструктор по умолчанию }
function Make; stdcall;
 {* конструктор по умолчанию }

implementation

uses
 l3ImplUses
;

function Make(var node_: INodeBase;
 operation_: TQueryLogicOperation);
//#UC START# *46151C4A0238_45EEE65400FB_var*
//#UC END# *46151C4A0238_45EEE65400FB_var*
begin
 Finalize(Result);
 System.FillChar(Result, SizeOf(Result), 0);
//#UC START# *46151C4A0238_45EEE65400FB_impl*
 !!! Needs to be implemented !!!
//#UC END# *46151C4A0238_45EEE65400FB_impl*
end;//Make

function Make;
 {* конструктор по умолчанию }
//#UC START# *473064CF02EE_45EEE65400FB_var*
//#UC END# *473064CF02EE_45EEE65400FB_var*
begin
 Finalize(Result);
 System.FillChar(Result, SizeOf(Result), 0);
//#UC START# *473064CF02EE_45EEE65400FB_impl*
 !!! Needs to be implemented !!!
//#UC END# *473064CF02EE_45EEE65400FB_impl*
end;//Make

function Make(var context_: IString);
//#UC START# *461A637E0017_45EEE4310209_var*
//#UC END# *461A637E0017_45EEE4310209_var*
begin
 Finalize(Result);
 System.FillChar(Result, SizeOf(Result), 0);
//#UC START# *461A637E0017_45EEE4310209_impl*
 !!! Needs to be implemented !!!
//#UC END# *461A637E0017_45EEE4310209_impl*
end;//Make

function Make;
 {* конструктор по умолчанию }
//#UC START# *4730657502FD_45EEE4310209_var*
//#UC END# *4730657502FD_45EEE4310209_var*
begin
 Finalize(Result);
 System.FillChar(Result, SizeOf(Result), 0);
//#UC START# *4730657502FD_45EEE4310209_impl*
 !!! Needs to be implemented !!!
//#UC END# *4730657502FD_45EEE4310209_impl*
end;//Make

function Make;
 {* конструктор по умолчанию }
//#UC START# *47306DD6030D_45EEE5C6012B_var*
//#UC END# *47306DD6030D_45EEE5C6012B_var*
begin
 Finalize(Result);
 System.FillChar(Result, SizeOf(Result), 0);
//#UC START# *47306DD6030D_45EEE5C6012B_impl*
 !!! Needs to be implemented !!!
//#UC END# *47306DD6030D_45EEE5C6012B_impl*
end;//Make

end.
