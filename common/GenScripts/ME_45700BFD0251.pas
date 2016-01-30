unit DynamicDocListUnit;

// Модуль: "w:\garant6x\implementation\Garant\tie\Garant\GblAdapterLib\DynamicDocListUnit.pas"
// Стереотип: "Interfaces"

{$Include nsDefine.inc}

interface

uses
 l3IntfUses
 , BaseTypesUnit
 , DocumentUnit
 , DynamicTreeUnit
 , FiltersUnit
 , IOUnit
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
  function Get_type: TPositionType;
  function Get_position: Cardinal;
  function Get_relevance: short;
  function Get_pid: TPId;
  function Get_doc: IDocument;
  procedure get_entry_list;
  procedure get_relevance_words_list;
  property type: TPositionType
   read Get_type;
  property position: Cardinal
   read Get_position;
  property relevance: short
   read Get_relevance;
   {* Релевантность. Для списков без релевантности всегда 0. }
  property pid: TPId
   read Get_pid;
  property doc: IDocument
   read Get_doc;
 end;//IListEntryInfo

 TSpecialListKey = (
  SLK_ALL_ALLOWED_DRUGS
   {* Все неаннулированные препараты }
 );//TSpecialListKey

 IDynList = interface(IEntityBase)
  ['{00B91ACF-6CDD-437F-935A-07287C0E2DF0}']
  function Get_history: IString;
  function Get_is_filtered: Boolean;
  function Get_content_type: TDynListContent;
  function Get_is_short: Boolean;
  function Get_is_snippet: Boolean;
  function Get_current_sort_params: TSortParams;
  function Get_available_sort_types: ISortTypes;
  procedure sort(const params: TSortParams);
  procedure set_context_filter(var context: IContextFilter);
  procedure save_to_file(path: PAnsiChar;
   const nodes: INodesClipboard);
   {* Сохранить список или его выделенные элементы в файл. }
  function as_evd(style: TEVDGeneratorStyle): IStream;
  function get_short_name: IString;
   {* получить "короткое" имя списка, используется при выводе на печать }
  procedure set_list_storage(saved_list);
  procedure get_full_list(var progress: IProgressIndicatorForSearch;
   out cancel_process: ICancelSearch); { can raise CanNotFindData }
   {* Получить полный список }
  function get_analysis_tree: INodeBase; { can raise CanNotFindData }
   {* получить дерево анализа для списка }
  function get_full_list_size: Cardinal;
   {* Получить длину полного для базового списка }
  function As_ICatalogBase: ICatalogBase;
   {* Метод приведения нашего интерфейса к ICatalogBase }
  property history: IString
   read Get_history;
  property is_filtered: Boolean
   read Get_is_filtered;
  property content_type: TDynListContent
   read Get_content_type;
  property is_short: Boolean
   read Get_is_short;
   {* Это короткий список (сниппеты) }
  property is_snippet: Boolean
   read Get_is_snippet;
   {* Признак, является ли список сниппетом }
  property current_sort_params: TSortParams
   read Get_current_sort_params;
  property available_sort_types: ISortTypes
   read Get_available_sort_types;
 end;//IDynList

 ISearchDynList = interface(ISearchEntity)
  {* Список - результат поиска }
  ['{DB91FE90-832B-4753-9222-4313AB5CA667}']
  function get_dyn_list: IDynList;
 end;//ISearchDynList

 TDynListFlags = (
  DLF_ANALYSIS_NODE_HAS_DATA
   {* может быть построен список }
  , DLF_ANALYSIS_NODE_EMPTY
 );//TDynListFlags

 IDocListFactory = interface
  {* фабрика для создания списков }
  ['{C894D5B5-37CF-4463-A426-E30550F408F8}']
  function make_list(file_name: PAnsiChar;
   inner_numbers: Boolean): IDynList; { can raise AccessDenied, InvalidType }
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
  function get_document_id: TObjectId;
   {* Получить идентифкатор документа из ноды списка }
 end;//IDynListNode

class function make(info;
 const root: INodeBase): BadFactoryType; overload;
class function make(info): BadFactoryType; overload;
class function make(server_list): ICatalogBase; overload;
class function make(legal_document;
 query;
 type: TDynListType): ICatalogBase; overload;
class function make(key: TSpecialListKey): ICatalogBase; overload;
class function make(search_doc_list): BadFactoryType;
class function make: BadFactoryType;
class function make(var owner_tree: IFakeFacetForFactory;
 snode): BadFactoryType;

implementation

uses
 l3ImplUses
;

class function make(info;
 const root: INodeBase): BadFactoryType;
var
 l_Inst : IListEntryInfo;
begin
 l_Inst := Create(info, root);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//make

class function make(info): BadFactoryType;
var
 l_Inst : IListEntryInfo;
begin
 l_Inst := Create(info);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//make

class function make(server_list): ICatalogBase;
var
 l_Inst : IDynList;
begin
 l_Inst := Create(server_list);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//make

class function make(legal_document;
 query;
 type: TDynListType): ICatalogBase;
var
 l_Inst : IDynList;
begin
 l_Inst := Create(legal_document, query, type);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//make

class function make(key: TSpecialListKey): ICatalogBase;
var
 l_Inst : IDynList;
begin
 l_Inst := Create(key);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//make

class function make(search_doc_list): BadFactoryType;
var
 l_Inst : ISearchDynList;
begin
 l_Inst := Create(search_doc_list);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//make

class function make: BadFactoryType;
var
 l_Inst : IDocListFactory;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//make

class function make(var owner_tree: IFakeFacetForFactory;
 snode): BadFactoryType;
var
 l_Inst : IDynListNode;
begin
 l_Inst := Create(owner_tree, snode);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//make

end.
