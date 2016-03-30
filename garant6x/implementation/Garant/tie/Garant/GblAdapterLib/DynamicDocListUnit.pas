unit DynamicDocListUnit;

// Модуль: "w:\garant6x\implementation\Garant\tie\Garant\GblAdapterLib\DynamicDocListUnit.pas"
// Стереотип: "Interfaces"
// Элемент модели: "DynamicDocList" MUID: (45700BFD0251)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , IOUnit
 , BaseTypesUnit
 , DocumentUnit
 , DynamicTreeUnit
 , FiltersUnit
 , DynamicTreeDefinesUnit
 , SearchProgressIndicatorUnit
;

type
 ISortTypes = array of TSortType;

 TDynListType = (
  T_RESPONDENT
  , T_CORRESPONDENT
  , T_RESPONDENT_TO_PART
  , T_CORRESPONDENT_TO_PART
  , T_SAME_DOCUMENTS
   {* Похожие документы }
 );//TDynListType

 TDynListContent = (
  {* задаёт вид списка }
  DLC_LEGAL_DOCUMENTS
   {* юридические документы }
  , DLC_MEDICAL_DOCUMENTS
   {* документы инфарма }
 );//TDynListContent

 IListEntryInfo = interface(IEntityBase)
  ['{5B3CE8D5-3CB9-4EA6-B3AC-37EADA8FDF9C}']
  function GetType: TPositionType; stdcall;
  function GetPosition: Cardinal; stdcall;
  function GetRelevance: short; stdcall;
  function GetPid: TPId; stdcall;
  function GetDoc: IDocument; stdcall;
  procedure GetEntryList; stdcall;
  procedure GetRelevanceWordsList; stdcall;
  property Type: TPositionType
   read GetType;
  property Position: Cardinal
   read GetPosition;
  property Relevance: short
   read GetRelevance;
   {* Релевантность. Для списков без релевантности всегда 0. }
  property Pid: TPId
   read GetPid;
  property Doc: IDocument
   read GetDoc;
 end;//IListEntryInfo

 TSpecialListKey = (
  SLK_ALL_ALLOWED_DRUGS
   {* Все неаннулированные препараты }
 );//TSpecialListKey

 IDynList = interface(IEntityBase)
  ['{00B91ACF-6CDD-437F-935A-07287C0E2DF0}']
  function GetHistory: IString; stdcall;
  function GetIsFiltered: ByteBool; stdcall;
  function GetContentType: TDynListContent; stdcall;
  function GetIsShort: ByteBool; stdcall;
  function GetIsSnippet: ByteBool; stdcall;
  function GetCurrentSortParams: TSortParams; stdcall;
  function GetAvailableSortTypes: ISortTypes; stdcall;
  procedure Sort(const params: TSortParams); stdcall;
  procedure SetContextFilter(var context: IContextFilter); stdcall;
  procedure SaveToFile(path: PAnsiChar;
   const nodes: INodesClipboard); stdcall;
   {* Сохранить список или его выделенные элементы в файл. }
  function AsEvd(style: TEVDGeneratorStyle): IStream; stdcall;
  function GetShortName: IString; stdcall;
   {* получить "короткое" имя списка, используется при выводе на печать }
  procedure SetListStorage(const saved_list); stdcall;
  procedure GetFullList(var progress: IProgressIndicatorForSearch;
   out cancel_process: ICancelSearch); stdcall; { can raise CanNotFindData }
   {* Получить полный список }
  function GetAnalysisTree: INodeBase; stdcall; { can raise CanNotFindData }
   {* получить дерево анализа для списка }
  function GetFullListSize: Cardinal; stdcall;
   {* Получить длину полного для базового списка }
  property History: IString
   read GetHistory;
  property IsFiltered: ByteBool
   read GetIsFiltered;
  property ContentType: TDynListContent
   read GetContentType;
  property IsShort: ByteBool
   read GetIsShort;
   {* Это короткий список (сниппеты) }
  property IsSnippet: ByteBool
   read GetIsSnippet;
   {* Признак, является ли список сниппетом }
  property CurrentSortParams: TSortParams
   read GetCurrentSortParams;
  property AvailableSortTypes: ISortTypes
   read GetAvailableSortTypes;
 end;//IDynList

 ISearchDynList = interface(ISearchEntity)
  {* Список - результат поиска }
  ['{DB91FE90-832B-4753-9222-4313AB5CA667}']
  function GetDynList: IDynList; stdcall;
 end;//ISearchDynList

 TDynListFlags = (
  DLF_ANALYSIS_NODE_HAS_DATA
   {* может быть построен список }
  , DLF_ANALYSIS_NODE_EMPTY
 );//TDynListFlags

 IDocListFactory = interface
  {* фабрика для создания списков }
  ['{C894D5B5-37CF-4463-A426-E30550F408F8}']
  function MakeList(file_name: PAnsiChar;
   inner_numbers: Boolean): IDynList; stdcall; { can raise AccessDenied, InvalidType }
   {* построить список по данным из файла file_name.
 inner_numbers - флаг указывающий какие номера документов используются (если inner_numbers=true - внутренние)

Формат файла (К195757811):
<номер топика>[.<номер саба/блока>][<пробел или табуляция><любые символы>]
<номер топика>[.<номер саба/блока>][<пробел или табуляция><любые символы>]
<номер топика>[.<номер саба/блока>][<пробел или табуляция><любые символы>]
...

Исключения:
AccessDenied - не смогли прочитать данные из файла
InvalidType - в файле некорректные данные }
 end;//IDocListFactory

 IDynListNode = interface
  ['{FAE957F6-A5EA-4AB6-9EC2-8514B696A1C1}']
  function GetDocumentId: TObjectId; stdcall;
   {* Получить идентифкатор документа из ноды списка }
  function GetSnippetText: IString; stdcall;
 end;//IDynListNode

implementation

uses
 l3ImplUses
;

end.
