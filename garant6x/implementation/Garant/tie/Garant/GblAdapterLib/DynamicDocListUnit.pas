unit DynamicDocListUnit;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "GblAdapterLib"
// Модуль: "w:/garant6x/implementation/Garant/tie/Garant/GblAdapterLib/DynamicDocListUnit.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::DynamicDocList
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
  BaseTypesUnit,
  DocumentUnit,
  DynamicTreeUnit,
  FiltersUnit,
  DynamicTreeDefinesUnit,
  SearchProgressIndicatorUnit
  ;

type
 ISortTypes = array of TSortType;

 TDynListType = (
   T_RESPONDENT
 , T_CORRESPONDENT
 , T_RESPONDENT_TO_PART
 , T_CORRESPONDENT_TO_PART
 , T_SAME_DOCUMENTS // Похожие документы
 );//TDynListType

 TDynListContent = (
  {* задаёт вид списка }
   DLC_LEGAL_DOCUMENTS // юридические документы
 , DLC_MEDICAL_DOCUMENTS // документы инфарма
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
   property type: TPositionType
     read GetType;
   property position: Cardinal
     read GetPosition;
   property relevance: short
     read GetRelevance;
     {* Релевантность. Для списков без релевантности всегда 0. }
   property pid: TPId
     read GetPid;
   property doc: IDocument
     read GetDoc;
 end;//IListEntryInfo

 TSpecialListKey = (
   SLK_ALL_ALLOWED_DRUGS // Все неаннулированные препараты
 );//TSpecialListKey

 IDynList = interface(IEntityBase{, ICatalogBase})
   ['{00B91ACF-6CDD-437F-935A-07287C0E2DF0}']
   function GetHistory: IString; stdcall;
   function GetIsFiltered: ByteBool; stdcall;
   function GetContentType: TDynListContent; stdcall;
   function GetIsShort: ByteBool; stdcall;
   function GetIsSnippet: ByteBool; stdcall;
   function GetCurrentSortParams: TSortParams; stdcall;
   function GetAvailableSortTypes: ISortTypes; stdcall;
   procedure Sort(const aParams: TSortParams); stdcall;
   procedure SetContextFilter(var aContext: IContextFilter); stdcall;
   procedure SaveToFile(aPath: PAnsiChar;
    const aNodes: INodesClipboard); stdcall;
     {* Сохранить список или его выделенные элементы в файл. }
   procedure AsEvd(aStyle: TEVDGeneratorStyle; out aRet {: IStream}); stdcall;
   procedure GetShortName(out aRet {: IString}); stdcall;
     {* получить "короткое" имя списка, используется при выводе на печать }
   procedure SetListStorage(aSavedList); stdcall;
   procedure GetFullList(var aProgress: IProgressIndicatorForSearch;
    out aCancelProcess: ICancelSearch); stdcall; // can raise CanNotFindData
     {* Получить полный список }
   procedure GetAnalysisTree(out aRet {: INodeBase}); stdcall; // can raise CanNotFindData
     {* получить дерево анализа для списка }
   function GetFullListSize: Cardinal; stdcall;
     {* Получить длину полного для базового списка }
   property history: IString
     read GetHistory;
   property is_filtered: ByteBool
     read GetIsFiltered;
   property content_type: TDynListContent
     read GetContentType;
   property is_short: ByteBool
     read GetIsShort;
     {* Это короткий список (сниппеты) }
   property is_snippet: ByteBool
     read GetIsSnippet;
     {* Признак, является ли список сниппетом }
   property current_sort_params: TSortParams
     read GetCurrentSortParams;
   property available_sort_types: ISortTypes
     read GetAvailableSortTypes;
 end;//IDynList

 ISearchDynList = interface(ISearchEntity)
  {* Список - результат поиска }
   ['{DB91FE90-832B-4753-9222-4313AB5CA667}']
   procedure GetDynList(out aRet {: IDynList}); stdcall;
 end;//ISearchDynList

 TDynListFlags = (
   DLF_ANALYSIS_NODE_HAS_DATA // может быть построен список
 , DLF_ANALYSIS_NODE_EMPTY
 );//TDynListFlags

 IDocListFactory = interface(IUnknown)
  {* фабрика для создания списков }
   ['{C894D5B5-37CF-4463-A426-E30550F408F8}']
   procedure MakeList(aFileName: PAnsiChar;
    aInnerNumbers: Boolean; out aRet {: IDynList}); stdcall; // can raise AccessDenied, InvalidType
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

 IDynListNode = interface(IUnknown)
   ['{FAE957F6-A5EA-4AB6-9EC2-8514B696A1C1}']
   function GetDocumentId: TObjectId; stdcall;
     {* Получить идентифкатор документа из ноды списка }
 end;//IDynListNode

implementation

end.