unit Search_Strange_Controls;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View$Strange"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Search_Strange_Controls.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMControls::Category>> F1 Common For Shell And Monitoring::Search::View$Strange::Strange
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin)}
uses
  BaseTreeSupportUnit,
  DynamicTreeUnit,
  FiltersUnit,
  l3TreeInterfaces,
  bsTypes,
  eeInterfaces,
  l3CProtoObject,
  PrimPrimListInterfaces
  {$If not defined(NoVCM)}
  ,
  vcmInterfaces
  {$IfEnd} //not NoVCM
  ,
  nsTypes,
  vcmExternalInterfaces {a}
  ;

(* Query = operations
   ['{4D3030AC-CE2A-487B-ACD9-5EB1603C3F80}']
   query ClearAll(aNotClearRange: Boolean);
   query SetList(const aList: IdeList;
    aInList: Boolean);
   query GetList: IdeList;
 end;//Query*)

(* Filterable = operations
   ['{13468E48-6D0B-432A-A6C9-E089AF750D0D}']
   query Add(const aFilter: IFilterFromQuery): Boolean;
   query Delete(const aFilter: IFilterFromQuery): Boolean;
   query ClearAll;
   query Refresh: Boolean;
   query GetListType: TbsListType;
 end;//Filterable*)

type
 TNodesArray = FiltersUnit.IFiltersFromQuery;

(* Loadable = operations
  {* Это первый кандидат на превращение в Facet. Который нужно вызвать вот тут:
f_RequestingForm.Entity.Operation(op_Loadable_Load, l_Params).Done }
   ['{3C25769E-FA27-45C8-97EF-5E52A273714E}']
   query Load(const aNode: IeeNode;
    const aData: IUnknown;
    anOp: TListLogicOperation = LLO_NONE): Boolean;
     {* Коллеги, кто может описать этот метод? }
 end;//Loadable*)

(* Filters = operations
   ['{DF0EEF98-0017-4445-AEE1-0CFA57C9624B}']
   query GetSelected: IFiltersFromQuery;
 end;//Filters*)

(* SearchParameter = operations
   ['{9DAC2ADD-C8E1-4908-9F83-31763A7C087E}']
   query QueryNotSaved;
   query ClearMistakes;
   query QuerySaved;
 end;//SearchParameter*)

(* PrintParams = operations
   ['{077B9F06-53E8-419A-9E4E-1C36335E3140}']
   query UpdatePrinter;
 end;//PrintParams*)

(* List = operations
   ['{A6A1A464-41A6-439B-98A5-F3D1C441D28D}']
   query SetNewContent;
 end;//List*)

(* CardOperation = operations
   ['{9039CBD4-8118-4718-85C6-D95A0BD6548B}']
   operation ExpandCollapse;
   operation DeleteAll;
   operation CreateAttr;
   operation OpenTreeSelection;
 end;//CardOperation*)

(* File = operations
  {* Файл }
   ['{DDC6DA32-5AF2-4FC0-ABD4-433B443BDDCB}']
   operation SaveToFolder;
     {* Сохранить в папки }
   operation LoadFromFolder;
     {* Загрузить из папок }
 end;//File*)

(* Query = operations
   ['{457BED7E-08D2-42CB-9D85-FB2B96D0677F}']
   operation GetOldQuery;
 end;//Query*)

(* Query = operations
   ['{BCD8067B-B9F4-42A1-B794-BD7A10F2FCDA}']
   operation SearchType;
 end;//Query*)

(* LogicOperation = operations
   ['{F3596909-B46F-4BAB-9893-F404B9D49A75}']
   operation LogicOr;
   operation LogicAnd;
   operation LogicNot;
 end;//LogicOperation*)

(* Filters = operations
   ['{E4F00C72-42BD-42DE-979A-B772E1C88942}']
   operation FiltersListOpen;
     {* Фильтры (вкладка) }
 end;//Filters*)

(* Preview = operations
   ['{145D1C16-AE8C-4760-A84E-CC5DDA10AF76}']
   operation ZoomIn;
   operation ZoomOut;
   operation ZoomWidth;
   operation ZoomPage;
 end;//Preview*)

(* Document = operations
   ['{2C206E2B-4F55-4EA9-B5FB-34E5517A15BF}']
   operation FullSelectedSwitch;
   operation RGBGrayscaleSwitch;
   operation PrintInfoSwitch;
 end;//Document*)

(* SubPanelSettings = operations
  {* Настройки панели меток }
   ['{506BDFEF-8C39-4B7B-A8A3-DAFEFEDC3A29}']
   operation ShowSpecial;
     {* Показывать спецсимволы }
   operation ShowInfo;
     {* Показывать блоки }
 end;//SubPanelSettings*)

(* Result = operations
   ['{9E6D8340-4F08-4E03-BF9D-F033F4F4E4E1}']
   operation Restore;
   operation SaveAsDefault;
 end;//Result*)

(* ColontitulMacro = operations
   ['{FF29DA32-08EE-4CAD-AB01-EDC60301EE03}']
   query AppTitle;
   query DocName;
   query DocFullName;
   query DocRedactionDate;
   query DocCurrentPage;
   query DocPagesCount;
   query CurrentDate;
   query CurrentTime;
   operation InternalDocNumber;
   query DocumentSIze;
   operation FilePosition;
 end;//ColontitulMacro*)

(* SubPanelSettings = operations
  {* Настройки панели меток }
   ['{F2556E2B-1428-461E-917F-1423A637B84C}']
   operation Show;
     {* Показывать метки }
 end;//SubPanelSettings*)

(* SubPanelSettings = operations
   ['{ADE11F8F-9B63-40AF-947F-8441F8EC65FC}']
   query ShowByShortCut;
 end;//SubPanelSettings*)

 IQuery_ClearAll_Params = interface(IUnknown)
  {* Параметры для операции Query.ClearAll }
   ['{B1040795-7346-4058-8A20-921C2AB0E0EC}']
   function Get_NotClearRange: Boolean;
   property NotClearRange: Boolean
     read Get_NotClearRange;
     {* undefined }
 end;//IQuery_ClearAll_Params

 Op_Query_ClearAll = class
  {* Класс для вызова операции Query.ClearAll }
 public
 // public methods
   class function Call(const aTarget: IvcmEntity;
    aNotClearRange: Boolean): Boolean; overload; 
     {* Вызов операции Query.ClearAll у сущности }
   class function Call(const aTarget: IvcmAggregate;
    aNotClearRange: Boolean): Boolean; overload; 
     {* Вызов операции Query.ClearAll у агрегации }
   class function Call(const aTarget: IvcmEntityForm;
    aNotClearRange: Boolean): Boolean; overload; 
     {* Вызов операции Query.ClearAll у формы }
   class function Call(const aTarget: IvcmContainer;
    aNotClearRange: Boolean): Boolean; overload; 
     {* Вызов операции Query.ClearAll у контейнера }
 end;//Op_Query_ClearAll

 IQuery_SetList_Params = interface(IUnknown)
  {* Параметры для операции Query.SetList }
   ['{BFF0E7CA-CD4B-44A0-9E3A-0D1DD07627B5}']
   function Get_List: IdeList;
   function Get_InList: Boolean;
   property List: IdeList
     read Get_List;
     {* undefined }
   property InList: Boolean
     read Get_InList;
     {* undefined }
 end;//IQuery_SetList_Params

 Op_Query_SetList = class
  {* Класс для вызова операции Query.SetList }
 public
 // public methods
   class function Call(const aTarget: IvcmEntity;
    const aList: IdeList;
    aInList: Boolean): Boolean; overload; 
     {* Вызов операции Query.SetList у сущности }
   class function Call(const aTarget: IvcmAggregate;
    const aList: IdeList;
    aInList: Boolean): Boolean; overload; 
     {* Вызов операции Query.SetList у агрегации }
   class function Call(const aTarget: IvcmEntityForm;
    const aList: IdeList;
    aInList: Boolean): Boolean; overload; 
     {* Вызов операции Query.SetList у формы }
   class function Call(const aTarget: IvcmContainer;
    const aList: IdeList;
    aInList: Boolean): Boolean; overload; 
     {* Вызов операции Query.SetList у контейнера }
 end;//Op_Query_SetList

 IQuery_GetList_Params = interface(IUnknown)
  {* Параметры для операции Query.GetList }
   ['{47F215CF-D56C-46D8-B3AF-7BE79921C789}']
   function Get_ResultValue: IdeList;
   procedure Set_ResultValue(const aValue: IdeList);
   property ResultValue: IdeList
     read Get_ResultValue
     write Set_ResultValue;
     {* undefined }
 end;//IQuery_GetList_Params

 Op_Query_GetList = class
  {* Класс для вызова операции Query.GetList }
 public
 // public methods
   class function Call(const aTarget: IvcmEntity): IdeList; overload; 
     {* Вызов операции Query.GetList у сущности }
   class function Call(const aTarget: IvcmAggregate): IdeList; overload; 
     {* Вызов операции Query.GetList у агрегации }
   class function Call(const aTarget: IvcmEntityForm): IdeList; overload; 
     {* Вызов операции Query.GetList у формы }
   class function Call(const aTarget: IvcmContainer): IdeList; overload; 
     {* Вызов операции Query.GetList у контейнера }
 end;//Op_Query_GetList

 IFilterable_Add_Params = interface(IUnknown)
  {* Параметры для операции Filterable.Add }
   ['{F5C53356-3803-4BE6-A8BA-D6693C6C3F73}']
   function Get_Filter: IFilterFromQuery;
   function Get_ResultValue: Boolean;
   procedure Set_ResultValue(aValue: Boolean);
   property Filter: IFilterFromQuery
     read Get_Filter;
     {* undefined }
   property ResultValue: Boolean
     read Get_ResultValue
     write Set_ResultValue;
     {* undefined }
 end;//IFilterable_Add_Params

 Op_Filterable_Add = class
  {* Класс для вызова операции Filterable.Add }
 public
 // public methods
   class function Call(const aTarget: IvcmEntity;
    const aFilter: IFilterFromQuery): Boolean; overload; 
     {* Вызов операции Filterable.Add у сущности }
   class function Call(const aTarget: IvcmAggregate;
    const aFilter: IFilterFromQuery): Boolean; overload; 
     {* Вызов операции Filterable.Add у агрегации }
   class function Call(const aTarget: IvcmEntityForm;
    const aFilter: IFilterFromQuery): Boolean; overload; 
     {* Вызов операции Filterable.Add у формы }
   class function Call(const aTarget: IvcmContainer;
    const aFilter: IFilterFromQuery): Boolean; overload; 
     {* Вызов операции Filterable.Add у контейнера }
 end;//Op_Filterable_Add

 IFilterable_Delete_Params = interface(IUnknown)
  {* Параметры для операции Filterable.Delete }
   ['{CE5EC919-6061-42DF-BAAC-01ADDDB5CBE8}']
   function Get_Filter: IFilterFromQuery;
   function Get_ResultValue: Boolean;
   procedure Set_ResultValue(aValue: Boolean);
   property Filter: IFilterFromQuery
     read Get_Filter;
     {* undefined }
   property ResultValue: Boolean
     read Get_ResultValue
     write Set_ResultValue;
     {* undefined }
 end;//IFilterable_Delete_Params

 Op_Filterable_Delete = class
  {* Класс для вызова операции Filterable.Delete }
 public
 // public methods
   class function Call(const aTarget: IvcmEntity;
    const aFilter: IFilterFromQuery): Boolean; overload; 
     {* Вызов операции Filterable.Delete у сущности }
   class function Call(const aTarget: IvcmAggregate;
    const aFilter: IFilterFromQuery): Boolean; overload; 
     {* Вызов операции Filterable.Delete у агрегации }
   class function Call(const aTarget: IvcmEntityForm;
    const aFilter: IFilterFromQuery): Boolean; overload; 
     {* Вызов операции Filterable.Delete у формы }
   class function Call(const aTarget: IvcmContainer;
    const aFilter: IFilterFromQuery): Boolean; overload; 
     {* Вызов операции Filterable.Delete у контейнера }
 end;//Op_Filterable_Delete

 Op_Filterable_ClearAll = class
  {* Класс для вызова операции Filterable.ClearAll }
 public
 // public methods
   class function Call(const aTarget: IvcmEntity): Boolean; overload; 
     {* Вызов операции Filterable.ClearAll у сущности }
   class function Call(const aTarget: IvcmAggregate): Boolean; overload; 
     {* Вызов операции Filterable.ClearAll у агрегации }
   class function Call(const aTarget: IvcmEntityForm): Boolean; overload; 
     {* Вызов операции Filterable.ClearAll у формы }
   class function Call(const aTarget: IvcmContainer): Boolean; overload; 
     {* Вызов операции Filterable.ClearAll у контейнера }
 end;//Op_Filterable_ClearAll

 IFilterable_Refresh_Params = interface(IUnknown)
  {* Параметры для операции Filterable.Refresh }
   ['{6F9614A1-47A1-4A29-A125-F9F9FC0AC5EB}']
   function Get_ResultValue: Boolean;
   procedure Set_ResultValue(aValue: Boolean);
   property ResultValue: Boolean
     read Get_ResultValue
     write Set_ResultValue;
     {* undefined }
 end;//IFilterable_Refresh_Params

 Op_Filterable_Refresh = class
  {* Класс для вызова операции Filterable.Refresh }
 public
 // public methods
   class function Call(const aTarget: IvcmEntity): Boolean; overload; 
     {* Вызов операции Filterable.Refresh у сущности }
   class function Call(const aTarget: IvcmAggregate): Boolean; overload; 
     {* Вызов операции Filterable.Refresh у агрегации }
   class function Call(const aTarget: IvcmEntityForm): Boolean; overload; 
     {* Вызов операции Filterable.Refresh у формы }
   class function Call(const aTarget: IvcmContainer): Boolean; overload; 
     {* Вызов операции Filterable.Refresh у контейнера }
 end;//Op_Filterable_Refresh

 IFilterable_GetListType_Params = interface(IUnknown)
  {* Параметры для операции Filterable.GetListType }
   ['{6789D87F-5CEF-4D43-B4EE-4DDA12413BC8}']
   function Get_ResultValue: TbsListType;
   procedure Set_ResultValue(aValue: TbsListType);
   property ResultValue: TbsListType
     read Get_ResultValue
     write Set_ResultValue;
     {* undefined }
 end;//IFilterable_GetListType_Params

 Op_Filterable_GetListType = class
  {* Класс для вызова операции Filterable.GetListType }
 public
 // public methods
   class function Call(const aTarget: IvcmEntity): TbsListType; overload; 
     {* Вызов операции Filterable.GetListType у сущности }
   class function Call(const aTarget: IvcmAggregate): TbsListType; overload; 
     {* Вызов операции Filterable.GetListType у агрегации }
   class function Call(const aTarget: IvcmEntityForm): TbsListType; overload; 
     {* Вызов операции Filterable.GetListType у формы }
   class function Call(const aTarget: IvcmContainer): TbsListType; overload; 
     {* Вызов операции Filterable.GetListType у контейнера }
 end;//Op_Filterable_GetListType

 ILoadable_Load_Params = interface(IUnknown)
  {* Параметры для операции Loadable.Load }
   ['{AB4CA4EA-BC8F-4217-B8CF-DDFCF17F2597}']
   function Get_Node: IeeNode;
   function Get_Data: IUnknown;
   function Get_NOp: TListLogicOperation;
   function Get_ResultValue: Boolean;
   procedure Set_ResultValue(aValue: Boolean);
   property Node: IeeNode
     read Get_Node;
     {* undefined }
   property Data: IUnknown
     read Get_Data;
     {* undefined }
   property nOp: TListLogicOperation
     read Get_NOp;
     {* undefined }
   property ResultValue: Boolean
     read Get_ResultValue
     write Set_ResultValue;
     {* undefined }
 end;//ILoadable_Load_Params

 Op_Loadable_Load = class
  {* Класс для вызова операции Loadable.Load }
 public
 // public methods
   class function Call(const aTarget: IvcmEntity;
    const aNode: IeeNode;
    const aData: IUnknown;
    anOp: TListLogicOperation = LLO_NONE): Boolean; overload; 
     {* Вызов операции Loadable.Load у сущности }
   class function Call(const aTarget: IvcmAggregate;
    const aNode: IeeNode;
    const aData: IUnknown;
    anOp: TListLogicOperation = LLO_NONE): Boolean; overload; 
     {* Вызов операции Loadable.Load у агрегации }
   class function Call(const aTarget: IvcmEntityForm;
    const aNode: IeeNode;
    const aData: IUnknown;
    anOp: TListLogicOperation = LLO_NONE): Boolean; overload; 
     {* Вызов операции Loadable.Load у формы }
   class function Call(const aTarget: IvcmContainer;
    const aNode: IeeNode;
    const aData: IUnknown;
    anOp: TListLogicOperation = LLO_NONE): Boolean; overload; 
     {* Вызов операции Loadable.Load у контейнера }
 end;//Op_Loadable_Load

{$If not defined(Admin) AND not defined(Monitorings)}
 IFilters_GetSelected_Params = interface(IUnknown)
  {* Параметры для операции Filters.GetSelected }
   ['{45EE1347-680F-49EE-8526-218AE70AC824}']
   function Get_ResultValue: IFiltersFromQuery;
   procedure Set_ResultValue(const aValue: IFiltersFromQuery);
   property ResultValue: IFiltersFromQuery
     read Get_ResultValue
     write Set_ResultValue;
     {* undefined }
 end;//IFilters_GetSelected_Params
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
 Op_Filters_GetSelected = class
  {* Класс для вызова операции Filters.GetSelected }
 public
 // public methods
   class function Call(const aTarget: IvcmEntity): IFiltersFromQuery; overload; 
     {* Вызов операции Filters.GetSelected у сущности }
   class function Call(const aTarget: IvcmAggregate): IFiltersFromQuery; overload; 
     {* Вызов операции Filters.GetSelected у агрегации }
   class function Call(const aTarget: IvcmEntityForm): IFiltersFromQuery; overload; 
     {* Вызов операции Filters.GetSelected у формы }
   class function Call(const aTarget: IvcmContainer): IFiltersFromQuery; overload; 
     {* Вызов операции Filters.GetSelected у контейнера }
 end;//Op_Filters_GetSelected
{$IfEnd} //not Admin AND not Monitorings

 Op_SearchParameter_QueryNotSaved = class
  {* Класс для вызова операции SearchParameter.QueryNotSaved }
 public
 // public methods
   class function Call(const aTarget: IvcmEntity): Boolean; overload; 
     {* Вызов операции SearchParameter.QueryNotSaved у сущности }
   class function Call(const aTarget: IvcmAggregate): Boolean; overload; 
     {* Вызов операции SearchParameter.QueryNotSaved у агрегации }
   class function Call(const aTarget: IvcmEntityForm): Boolean; overload; 
     {* Вызов операции SearchParameter.QueryNotSaved у формы }
   class function Call(const aTarget: IvcmContainer): Boolean; overload; 
     {* Вызов операции SearchParameter.QueryNotSaved у контейнера }
 end;//Op_SearchParameter_QueryNotSaved

 Op_SearchParameter_ClearMistakes = class
  {* Класс для вызова операции SearchParameter.ClearMistakes }
 public
 // public methods
   class function Call(const aTarget: IvcmEntity): Boolean; overload; 
     {* Вызов операции SearchParameter.ClearMistakes у сущности }
   class function Call(const aTarget: IvcmAggregate): Boolean; overload; 
     {* Вызов операции SearchParameter.ClearMistakes у агрегации }
   class function Call(const aTarget: IvcmEntityForm): Boolean; overload; 
     {* Вызов операции SearchParameter.ClearMistakes у формы }
   class function Call(const aTarget: IvcmContainer): Boolean; overload; 
     {* Вызов операции SearchParameter.ClearMistakes у контейнера }
 end;//Op_SearchParameter_ClearMistakes

 Op_SearchParameter_QuerySaved = class
  {* Класс для вызова операции SearchParameter.QuerySaved }
 public
 // public methods
   class function Call(const aTarget: IvcmEntity): Boolean; overload; 
     {* Вызов операции SearchParameter.QuerySaved у сущности }
   class function Call(const aTarget: IvcmAggregate): Boolean; overload; 
     {* Вызов операции SearchParameter.QuerySaved у агрегации }
   class function Call(const aTarget: IvcmEntityForm): Boolean; overload; 
     {* Вызов операции SearchParameter.QuerySaved у формы }
   class function Call(const aTarget: IvcmContainer): Boolean; overload; 
     {* Вызов операции SearchParameter.QuerySaved у контейнера }
 end;//Op_SearchParameter_QuerySaved

 Op_PrintParams_UpdatePrinter = class
  {* Класс для вызова операции PrintParams.UpdatePrinter }
 public
 // public methods
   class function Call(const aTarget: IvcmEntity): Boolean; overload; 
     {* Вызов операции PrintParams.UpdatePrinter у сущности }
   class function Call(const aTarget: IvcmAggregate): Boolean; overload; 
     {* Вызов операции PrintParams.UpdatePrinter у агрегации }
   class function Call(const aTarget: IvcmEntityForm): Boolean; overload; 
     {* Вызов операции PrintParams.UpdatePrinter у формы }
   class function Call(const aTarget: IvcmContainer): Boolean; overload; 
     {* Вызов операции PrintParams.UpdatePrinter у контейнера }
   class procedure Broadcast;
     {* Вызов операции PrintParams.UpdatePrinter у всех зарегистрированных сущностей }
 end;//Op_PrintParams_UpdatePrinter

 Op_List_SetNewContent = class
  {* Класс для вызова операции List.SetNewContent }
 public
 // public methods
   class function Call(const aTarget: IvcmEntity): Boolean; overload; 
     {* Вызов операции List.SetNewContent у сущности }
   class function Call(const aTarget: IvcmAggregate): Boolean; overload; 
     {* Вызов операции List.SetNewContent у агрегации }
   class function Call(const aTarget: IvcmEntityForm): Boolean; overload; 
     {* Вызов операции List.SetNewContent у формы }
   class function Call(const aTarget: IvcmContainer): Boolean; overload; 
     {* Вызов операции List.SetNewContent у контейнера }
 end;//Op_List_SetNewContent
{$IfEnd} //not Admin

{$If not defined(Admin)}
const
 en_Query = 'Query';
 en_capQuery = '';
 op_ClearAll = 'ClearAll';
 op_capClearAll = '';
 op_SetList = 'SetList';
 op_capSetList = '';
 op_GetList = 'GetList';
 op_capGetList = '';
 en_Filterable = 'Filterable';
 en_capFilterable = '';
 op_Add = 'Add';
 op_capAdd = '';
 op_Delete = 'Delete';
 op_capDelete = '';
 op_Refresh = 'Refresh';
 op_capRefresh = '';
 op_GetListType = 'GetListType';
 op_capGetListType = '';
 en_Loadable = 'Loadable';
 en_capLoadable = 'Это первый кандидат на превращение в Facet. Который нужно вызвать вот тут: f_RequestingForm.Entity.Operation(op_Loadable_Load, l_Params).Done';
 op_Load = 'Load';
 op_capLoad = 'Коллеги, кто может описать этот метод?';
 en_Filters = 'Filters';
 en_capFilters = '';
 op_GetSelected = 'GetSelected';
 op_capGetSelected = '';
 en_SearchParameter = 'SearchParameter';
 en_capSearchParameter = '';
 op_QueryNotSaved = 'QueryNotSaved';
 op_capQueryNotSaved = '';
 op_ClearMistakes = 'ClearMistakes';
 op_capClearMistakes = '';
 op_QuerySaved = 'QuerySaved';
 op_capQuerySaved = '';
 en_PrintParams = 'PrintParams';
 en_capPrintParams = '';
 op_UpdatePrinter = 'UpdatePrinter';
 op_capUpdatePrinter = '';
 en_List = 'List';
 en_capList = '';
 op_SetNewContent = 'SetNewContent';
 op_capSetNewContent = '';
 en_CardOperation = 'CardOperation';
 en_capCardOperation = '';
 op_ExpandCollapse = 'ExpandCollapse';
 op_capExpandCollapse = '';
 op_DeleteAll = 'DeleteAll';
 op_capDeleteAll = '';
 op_CreateAttr = 'CreateAttr';
 op_capCreateAttr = '';
 op_OpenTreeSelection = 'OpenTreeSelection';
 op_capOpenTreeSelection = '';
 en_File = 'File';
 en_capFile = 'Файл';
 op_SaveToFolder = 'SaveToFolder';
 op_capSaveToFolder = 'Сохранить в папки';
 op_LoadFromFolder = 'LoadFromFolder';
 op_capLoadFromFolder = 'Загрузить из папок';
 op_GetOldQuery = 'GetOldQuery';
 op_capGetOldQuery = '';
 op_SearchType = 'SearchType';
 op_capSearchType = '';
 en_LogicOperation = 'LogicOperation';
 en_capLogicOperation = '';
 op_LogicOr = 'LogicOr';
 op_capLogicOr = '';
 op_LogicAnd = 'LogicAnd';
 op_capLogicAnd = '';
 op_LogicNot = 'LogicNot';
 op_capLogicNot = '';
 op_FiltersListOpen = 'FiltersListOpen';
 op_capFiltersListOpen = 'Фильтры (вкладка)';
 en_Preview = 'Preview';
 en_capPreview = '';
 op_ZoomIn = 'ZoomIn';
 op_capZoomIn = '';
 op_ZoomOut = 'ZoomOut';
 op_capZoomOut = '';
 op_ZoomWidth = 'ZoomWidth';
 op_capZoomWidth = '';
 op_ZoomPage = 'ZoomPage';
 op_capZoomPage = '';
 en_Document = 'Document';
 en_capDocument = '';
 op_FullSelectedSwitch = 'FullSelectedSwitch';
 op_capFullSelectedSwitch = '';
 op_RGBGrayscaleSwitch = 'RGBGrayscaleSwitch';
 op_capRGBGrayscaleSwitch = '';
 op_PrintInfoSwitch = 'PrintInfoSwitch';
 op_capPrintInfoSwitch = '';
 en_SubPanelSettings = 'SubPanelSettings';
 en_capSubPanelSettings = 'Настройки панели меток';
 op_ShowSpecial = 'ShowSpecial';
 op_capShowSpecial = 'Показывать спецсимволы';
 op_ShowInfo = 'ShowInfo';
 op_capShowInfo = 'Показывать блоки';
 en_Result = 'Result';
 en_capResult = '';
 op_Restore = 'Restore';
 op_capRestore = '';
 op_SaveAsDefault = 'SaveAsDefault';
 op_capSaveAsDefault = '';
 en_ColontitulMacro = 'ColontitulMacro';
 en_capColontitulMacro = '';
 op_AppTitle = 'AppTitle';
 op_capAppTitle = '';
 op_DocName = 'DocName';
 op_capDocName = '';
 op_DocFullName = 'DocFullName';
 op_capDocFullName = '';
 op_DocRedactionDate = 'DocRedactionDate';
 op_capDocRedactionDate = '';
 op_DocCurrentPage = 'DocCurrentPage';
 op_capDocCurrentPage = '';
 op_DocPagesCount = 'DocPagesCount';
 op_capDocPagesCount = '';
 op_CurrentDate = 'CurrentDate';
 op_capCurrentDate = '';
 op_CurrentTime = 'CurrentTime';
 op_capCurrentTime = '';
 op_InternalDocNumber = 'InternalDocNumber';
 op_capInternalDocNumber = '';
 op_DocumentSIze = 'DocumentSIze';
 op_capDocumentSIze = '';
 op_FilePosition = 'FilePosition';
 op_capFilePosition = '';
 op_Show = 'Show';
 op_capShow = 'Показывать метки';
 op_ShowByShortCut = 'ShowByShortCut';
 op_capShowByShortCut = '';
{$IfEnd} //not Admin

implementation

{$If not defined(Admin)}
uses
  l3Base {a},
  vcmBase {a},
  StdRes {a}
  ;

type
 TQuery_ClearAll_Params = class(Tl3CProtoObject, IQuery_ClearAll_Params)
  {* Реализация IQuery_ClearAll_Params }
 private
 // private fields
   f_NotClearRange : Boolean;
 protected
 // realized methods
   function Get_NotClearRange: Boolean;
 public
 // public methods
   constructor Create(aNotClearRange: Boolean); reintroduce;
     {* Конструктор TQuery_ClearAll_Params }
   class function Make(aNotClearRange: Boolean): IQuery_ClearAll_Params; reintroduce;
     {* Фабрика TQuery_ClearAll_Params }
 end;//TQuery_ClearAll_Params

// start class TQuery_ClearAll_Params

constructor TQuery_ClearAll_Params.Create(aNotClearRange: Boolean);
 {-}
begin
 inherited Create;
 f_NotClearRange := aNotClearRange;
end;//TQuery_ClearAll_Params.Create

class function TQuery_ClearAll_Params.Make(aNotClearRange: Boolean): IQuery_ClearAll_Params;
var
 l_Inst : TQuery_ClearAll_Params;
begin
 l_Inst := Create(aNotClearRange);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

function TQuery_ClearAll_Params.Get_NotClearRange: Boolean;
 {-}
begin
 Result := f_NotClearRange;
end;//TQuery_ClearAll_Params.Get_NotClearRange
// start class Op_Query_ClearAll

class function Op_Query_ClearAll.Call(const aTarget: IvcmEntity;
  aNotClearRange: Boolean): Boolean;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TQuery_ClearAll_Params.Make(aNotClearRange));
  aTarget.Operation(TdmStdRes.opcode_Query_ClearAll, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Query_ClearAll.Call

class function Op_Query_ClearAll.Call(const aTarget: IvcmAggregate;
  aNotClearRange: Boolean): Boolean;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TQuery_ClearAll_Params.Make(aNotClearRange));
  aTarget.Operation(TdmStdRes.opcode_Query_ClearAll, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Query_ClearAll.Call

class function Op_Query_ClearAll.Call(const aTarget: IvcmEntityForm;
  aNotClearRange: Boolean): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity, aNotClearRange);
end;//Op_Query_ClearAll.Call

class function Op_Query_ClearAll.Call(const aTarget: IvcmContainer;
  aNotClearRange: Boolean): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm, aNotClearRange);
end;//Op_Query_ClearAll.Call

type
 TQuery_SetList_Params = class(Tl3CProtoObject, IQuery_SetList_Params)
  {* Реализация IQuery_SetList_Params }
 private
 // private fields
   f_List : IdeList;
   f_InList : Boolean;
 protected
 // realized methods
   function Get_InList: Boolean;
   function Get_List: IdeList;
 protected
 // overridden protected methods
   procedure ClearFields; override;
     {* Сигнатура метода ClearFields }
 public
 // public methods
   constructor Create(const aList: IdeList;
    aInList: Boolean); reintroduce;
     {* Конструктор TQuery_SetList_Params }
   class function Make(const aList: IdeList;
    aInList: Boolean): IQuery_SetList_Params; reintroduce;
     {* Фабрика TQuery_SetList_Params }
 end;//TQuery_SetList_Params

// start class TQuery_SetList_Params

constructor TQuery_SetList_Params.Create(const aList: IdeList;
  aInList: Boolean);
 {-}
begin
 inherited Create;
 f_List := aList;
 f_InList := aInList;
end;//TQuery_SetList_Params.Create

class function TQuery_SetList_Params.Make(const aList: IdeList;
  aInList: Boolean): IQuery_SetList_Params;
var
 l_Inst : TQuery_SetList_Params;
begin
 l_Inst := Create(aList, aInList);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

function TQuery_SetList_Params.Get_InList: Boolean;
 {-}
begin
 Result := f_InList;
end;//TQuery_SetList_Params.Get_InList

function TQuery_SetList_Params.Get_List: IdeList;
 {-}
begin
 Result := f_List;
end;//TQuery_SetList_Params.Get_List

procedure TQuery_SetList_Params.ClearFields;
 {-}
begin
 {$If not defined(Admin)}
 f_List := nil;
 {$IfEnd} //not Admin
 inherited;
end;//TQuery_SetList_Params.ClearFields
// start class Op_Query_SetList

class function Op_Query_SetList.Call(const aTarget: IvcmEntity;
  const aList: IdeList;
  aInList: Boolean): Boolean;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TQuery_SetList_Params.Make(aList,aInList));
  aTarget.Operation(TdmStdRes.opcode_Query_SetList, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Query_SetList.Call

class function Op_Query_SetList.Call(const aTarget: IvcmAggregate;
  const aList: IdeList;
  aInList: Boolean): Boolean;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TQuery_SetList_Params.Make(aList,aInList));
  aTarget.Operation(TdmStdRes.opcode_Query_SetList, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Query_SetList.Call

class function Op_Query_SetList.Call(const aTarget: IvcmEntityForm;
  const aList: IdeList;
  aInList: Boolean): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity, aList, aInList);
end;//Op_Query_SetList.Call

class function Op_Query_SetList.Call(const aTarget: IvcmContainer;
  const aList: IdeList;
  aInList: Boolean): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm, aList, aInList);
end;//Op_Query_SetList.Call

type
 TQuery_GetList_Params = class(Tl3CProtoObject, IQuery_GetList_Params)
  {* Реализация IQuery_GetList_Params }
 private
 // private fields
   f_ResultValue : IdeList;
 protected
 // realized methods
   function Get_ResultValue: IdeList;
   procedure Set_ResultValue(const aValue: IdeList);
 protected
 // overridden protected methods
   procedure ClearFields; override;
     {* Сигнатура метода ClearFields }
 public
 // public methods
   constructor Create; reintroduce;
     {* Конструктор TQuery_GetList_Params }
   class function Make: IQuery_GetList_Params; reintroduce;
     {* Фабрика TQuery_GetList_Params }
 end;//TQuery_GetList_Params

// start class TQuery_GetList_Params

constructor TQuery_GetList_Params.Create;
 {-}
begin
 inherited Create;
end;//TQuery_GetList_Params.Create

class function TQuery_GetList_Params.Make: IQuery_GetList_Params;
var
 l_Inst : TQuery_GetList_Params;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

function TQuery_GetList_Params.Get_ResultValue: IdeList;
 {-}
begin
 Result := f_ResultValue;
end;//TQuery_GetList_Params.Get_ResultValue

procedure TQuery_GetList_Params.Set_ResultValue(const aValue: IdeList);
 {-}
begin
 f_ResultValue := aValue;
end;//TQuery_GetList_Params.Set_ResultValue

procedure TQuery_GetList_Params.ClearFields;
 {-}
begin
 {$If not defined(Admin)}
 f_ResultValue := nil;
 {$IfEnd} //not Admin
 inherited;
end;//TQuery_GetList_Params.ClearFields
// start class Op_Query_GetList

class function Op_Query_GetList.Call(const aTarget: IvcmEntity): IdeList;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TQuery_GetList_Params.Make);
  aTarget.Operation(TdmStdRes.opcode_Query_GetList, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := IQuery_GetList_Params(Data).ResultValue;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Query_GetList.Call

class function Op_Query_GetList.Call(const aTarget: IvcmAggregate): IdeList;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TQuery_GetList_Params.Make);
  aTarget.Operation(TdmStdRes.opcode_Query_GetList, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := IQuery_GetList_Params(Data).ResultValue;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Query_GetList.Call

class function Op_Query_GetList.Call(const aTarget: IvcmEntityForm): IdeList;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity);
end;//Op_Query_GetList.Call

class function Op_Query_GetList.Call(const aTarget: IvcmContainer): IdeList;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm);
end;//Op_Query_GetList.Call

type
 TFilterable_Add_Params = class(Tl3CProtoObject, IFilterable_Add_Params)
  {* Реализация IFilterable_Add_Params }
 private
 // private fields
   f_Filter : IFilterFromQuery;
   f_ResultValue : Boolean;
 protected
 // realized methods
   function Get_ResultValue: Boolean;
   procedure Set_ResultValue(aValue: Boolean);
   function Get_Filter: IFilterFromQuery;
 protected
 // overridden protected methods
   procedure ClearFields; override;
     {* Сигнатура метода ClearFields }
 public
 // public methods
   constructor Create(const aFilter: IFilterFromQuery); reintroduce;
     {* Конструктор TFilterable_Add_Params }
   class function Make(const aFilter: IFilterFromQuery): IFilterable_Add_Params; reintroduce;
     {* Фабрика TFilterable_Add_Params }
 end;//TFilterable_Add_Params

// start class TFilterable_Add_Params

constructor TFilterable_Add_Params.Create(const aFilter: IFilterFromQuery);
 {-}
begin
 inherited Create;
 f_Filter := aFilter;
end;//TFilterable_Add_Params.Create

class function TFilterable_Add_Params.Make(const aFilter: IFilterFromQuery): IFilterable_Add_Params;
var
 l_Inst : TFilterable_Add_Params;
begin
 l_Inst := Create(aFilter);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

function TFilterable_Add_Params.Get_ResultValue: Boolean;
 {-}
begin
 Result := f_ResultValue;
end;//TFilterable_Add_Params.Get_ResultValue

procedure TFilterable_Add_Params.Set_ResultValue(aValue: Boolean);
 {-}
begin
 f_ResultValue := aValue;
end;//TFilterable_Add_Params.Set_ResultValue

function TFilterable_Add_Params.Get_Filter: IFilterFromQuery;
 {-}
begin
 Result := f_Filter;
end;//TFilterable_Add_Params.Get_Filter

procedure TFilterable_Add_Params.ClearFields;
 {-}
begin
 {$If not defined(Admin)}
 f_Filter := nil;
 {$IfEnd} //not Admin
 inherited;
end;//TFilterable_Add_Params.ClearFields
// start class Op_Filterable_Add

class function Op_Filterable_Add.Call(const aTarget: IvcmEntity;
  const aFilter: IFilterFromQuery): Boolean;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TFilterable_Add_Params.Make(aFilter));
  aTarget.Operation(TdmStdRes.opcode_Filterable_Add, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := IFilterable_Add_Params(Data).ResultValue;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Filterable_Add.Call

class function Op_Filterable_Add.Call(const aTarget: IvcmAggregate;
  const aFilter: IFilterFromQuery): Boolean;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TFilterable_Add_Params.Make(aFilter));
  aTarget.Operation(TdmStdRes.opcode_Filterable_Add, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := IFilterable_Add_Params(Data).ResultValue;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Filterable_Add.Call

class function Op_Filterable_Add.Call(const aTarget: IvcmEntityForm;
  const aFilter: IFilterFromQuery): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity, aFilter);
end;//Op_Filterable_Add.Call

class function Op_Filterable_Add.Call(const aTarget: IvcmContainer;
  const aFilter: IFilterFromQuery): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm, aFilter);
end;//Op_Filterable_Add.Call

type
 TFilterable_Delete_Params = class(Tl3CProtoObject, IFilterable_Delete_Params)
  {* Реализация IFilterable_Delete_Params }
 private
 // private fields
   f_Filter : IFilterFromQuery;
   f_ResultValue : Boolean;
 protected
 // realized methods
   function Get_Filter: IFilterFromQuery;
   function Get_ResultValue: Boolean;
   procedure Set_ResultValue(aValue: Boolean);
 protected
 // overridden protected methods
   procedure ClearFields; override;
     {* Сигнатура метода ClearFields }
 public
 // public methods
   constructor Create(const aFilter: IFilterFromQuery); reintroduce;
     {* Конструктор TFilterable_Delete_Params }
   class function Make(const aFilter: IFilterFromQuery): IFilterable_Delete_Params; reintroduce;
     {* Фабрика TFilterable_Delete_Params }
 end;//TFilterable_Delete_Params

// start class TFilterable_Delete_Params

constructor TFilterable_Delete_Params.Create(const aFilter: IFilterFromQuery);
 {-}
begin
 inherited Create;
 f_Filter := aFilter;
end;//TFilterable_Delete_Params.Create

class function TFilterable_Delete_Params.Make(const aFilter: IFilterFromQuery): IFilterable_Delete_Params;
var
 l_Inst : TFilterable_Delete_Params;
begin
 l_Inst := Create(aFilter);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

function TFilterable_Delete_Params.Get_Filter: IFilterFromQuery;
 {-}
begin
 Result := f_Filter;
end;//TFilterable_Delete_Params.Get_Filter

function TFilterable_Delete_Params.Get_ResultValue: Boolean;
 {-}
begin
 Result := f_ResultValue;
end;//TFilterable_Delete_Params.Get_ResultValue

procedure TFilterable_Delete_Params.Set_ResultValue(aValue: Boolean);
 {-}
begin
 f_ResultValue := aValue;
end;//TFilterable_Delete_Params.Set_ResultValue

procedure TFilterable_Delete_Params.ClearFields;
 {-}
begin
 {$If not defined(Admin)}
 f_Filter := nil;
 {$IfEnd} //not Admin
 inherited;
end;//TFilterable_Delete_Params.ClearFields
// start class Op_Filterable_Delete

class function Op_Filterable_Delete.Call(const aTarget: IvcmEntity;
  const aFilter: IFilterFromQuery): Boolean;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TFilterable_Delete_Params.Make(aFilter));
  aTarget.Operation(TdmStdRes.opcode_Filterable_Delete, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := IFilterable_Delete_Params(Data).ResultValue;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Filterable_Delete.Call

class function Op_Filterable_Delete.Call(const aTarget: IvcmAggregate;
  const aFilter: IFilterFromQuery): Boolean;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TFilterable_Delete_Params.Make(aFilter));
  aTarget.Operation(TdmStdRes.opcode_Filterable_Delete, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := IFilterable_Delete_Params(Data).ResultValue;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Filterable_Delete.Call

class function Op_Filterable_Delete.Call(const aTarget: IvcmEntityForm;
  const aFilter: IFilterFromQuery): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity, aFilter);
end;//Op_Filterable_Delete.Call

class function Op_Filterable_Delete.Call(const aTarget: IvcmContainer;
  const aFilter: IFilterFromQuery): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm, aFilter);
end;//Op_Filterable_Delete.Call
// start class Op_Filterable_ClearAll

class function Op_Filterable_ClearAll.Call(const aTarget: IvcmEntity): Boolean;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := vcmParams;
  aTarget.Operation(TdmStdRes.opcode_Filterable_ClearAll, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Filterable_ClearAll.Call

class function Op_Filterable_ClearAll.Call(const aTarget: IvcmAggregate): Boolean;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := vcmParams;
  aTarget.Operation(TdmStdRes.opcode_Filterable_ClearAll, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Filterable_ClearAll.Call

class function Op_Filterable_ClearAll.Call(const aTarget: IvcmEntityForm): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity);
end;//Op_Filterable_ClearAll.Call

class function Op_Filterable_ClearAll.Call(const aTarget: IvcmContainer): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm);
end;//Op_Filterable_ClearAll.Call

type
 TFilterable_Refresh_Params = class(Tl3CProtoObject, IFilterable_Refresh_Params)
  {* Реализация IFilterable_Refresh_Params }
 private
 // private fields
   f_ResultValue : Boolean;
 protected
 // realized methods
   function Get_ResultValue: Boolean;
   procedure Set_ResultValue(aValue: Boolean);
 public
 // public methods
   constructor Create; reintroduce;
     {* Конструктор TFilterable_Refresh_Params }
   class function Make: IFilterable_Refresh_Params; reintroduce;
     {* Фабрика TFilterable_Refresh_Params }
 end;//TFilterable_Refresh_Params

// start class TFilterable_Refresh_Params

constructor TFilterable_Refresh_Params.Create;
 {-}
begin
 inherited Create;
end;//TFilterable_Refresh_Params.Create

class function TFilterable_Refresh_Params.Make: IFilterable_Refresh_Params;
var
 l_Inst : TFilterable_Refresh_Params;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

function TFilterable_Refresh_Params.Get_ResultValue: Boolean;
 {-}
begin
 Result := f_ResultValue;
end;//TFilterable_Refresh_Params.Get_ResultValue

procedure TFilterable_Refresh_Params.Set_ResultValue(aValue: Boolean);
 {-}
begin
 f_ResultValue := aValue;
end;//TFilterable_Refresh_Params.Set_ResultValue
// start class Op_Filterable_Refresh

class function Op_Filterable_Refresh.Call(const aTarget: IvcmEntity): Boolean;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TFilterable_Refresh_Params.Make);
  aTarget.Operation(TdmStdRes.opcode_Filterable_Refresh, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := IFilterable_Refresh_Params(Data).ResultValue;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Filterable_Refresh.Call

class function Op_Filterable_Refresh.Call(const aTarget: IvcmAggregate): Boolean;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TFilterable_Refresh_Params.Make);
  aTarget.Operation(TdmStdRes.opcode_Filterable_Refresh, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := IFilterable_Refresh_Params(Data).ResultValue;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Filterable_Refresh.Call

class function Op_Filterable_Refresh.Call(const aTarget: IvcmEntityForm): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity);
end;//Op_Filterable_Refresh.Call

class function Op_Filterable_Refresh.Call(const aTarget: IvcmContainer): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm);
end;//Op_Filterable_Refresh.Call

type
 TFilterable_GetListType_Params = class(Tl3CProtoObject, IFilterable_GetListType_Params)
  {* Реализация IFilterable_GetListType_Params }
 private
 // private fields
   f_ResultValue : TbsListType;
 protected
 // realized methods
   function Get_ResultValue: TbsListType;
   procedure Set_ResultValue(aValue: TbsListType);
 public
 // public methods
   constructor Create; reintroduce;
     {* Конструктор TFilterable_GetListType_Params }
   class function Make: IFilterable_GetListType_Params; reintroduce;
     {* Фабрика TFilterable_GetListType_Params }
 end;//TFilterable_GetListType_Params

// start class TFilterable_GetListType_Params

constructor TFilterable_GetListType_Params.Create;
 {-}
begin
 inherited Create;
end;//TFilterable_GetListType_Params.Create

class function TFilterable_GetListType_Params.Make: IFilterable_GetListType_Params;
var
 l_Inst : TFilterable_GetListType_Params;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

function TFilterable_GetListType_Params.Get_ResultValue: TbsListType;
 {-}
begin
 Result := f_ResultValue;
end;//TFilterable_GetListType_Params.Get_ResultValue

procedure TFilterable_GetListType_Params.Set_ResultValue(aValue: TbsListType);
 {-}
begin
 f_ResultValue := aValue;
end;//TFilterable_GetListType_Params.Set_ResultValue
// start class Op_Filterable_GetListType

class function Op_Filterable_GetListType.Call(const aTarget: IvcmEntity): TbsListType;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TFilterable_GetListType_Params.Make);
  aTarget.Operation(TdmStdRes.opcode_Filterable_GetListType, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := IFilterable_GetListType_Params(Data).ResultValue;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Filterable_GetListType.Call

class function Op_Filterable_GetListType.Call(const aTarget: IvcmAggregate): TbsListType;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TFilterable_GetListType_Params.Make);
  aTarget.Operation(TdmStdRes.opcode_Filterable_GetListType, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := IFilterable_GetListType_Params(Data).ResultValue;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Filterable_GetListType.Call

class function Op_Filterable_GetListType.Call(const aTarget: IvcmEntityForm): TbsListType;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity);
end;//Op_Filterable_GetListType.Call

class function Op_Filterable_GetListType.Call(const aTarget: IvcmContainer): TbsListType;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm);
end;//Op_Filterable_GetListType.Call

type
 TLoadable_Load_Params = class(Tl3CProtoObject, ILoadable_Load_Params)
  {* Реализация ILoadable_Load_Params }
 private
 // private fields
   f_Node : IeeNode;
   f_Data : IUnknown;
   f_nOp : TListLogicOperation;
   f_ResultValue : Boolean;
 protected
 // realized methods
   function Get_Node: IeeNode;
   function Get_ResultValue: Boolean;
   procedure Set_ResultValue(aValue: Boolean);
   function Get_Data: IUnknown;
   function Get_NOp: TListLogicOperation;
 protected
 // overridden protected methods
   procedure ClearFields; override;
     {* Сигнатура метода ClearFields }
 public
 // public methods
   constructor Create(const aNode: IeeNode;
    const aData: IUnknown;
    anOp: TListLogicOperation); reintroduce;
     {* Конструктор TLoadable_Load_Params }
   class function Make(const aNode: IeeNode;
    const aData: IUnknown;
    anOp: TListLogicOperation): ILoadable_Load_Params; reintroduce;
     {* Фабрика TLoadable_Load_Params }
 end;//TLoadable_Load_Params

// start class TLoadable_Load_Params

constructor TLoadable_Load_Params.Create(const aNode: IeeNode;
  const aData: IUnknown;
  anOp: TListLogicOperation);
 {-}
begin
 inherited Create;
 f_Node := aNode;
 f_Data := aData;
 f_nOp := anOp;
end;//TLoadable_Load_Params.Create

class function TLoadable_Load_Params.Make(const aNode: IeeNode;
  const aData: IUnknown;
  anOp: TListLogicOperation): ILoadable_Load_Params;
var
 l_Inst : TLoadable_Load_Params;
begin
 l_Inst := Create(aNode, aData, anOp);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

function TLoadable_Load_Params.Get_Node: IeeNode;
 {-}
begin
 Result := f_Node;
end;//TLoadable_Load_Params.Get_Node

function TLoadable_Load_Params.Get_ResultValue: Boolean;
 {-}
begin
 Result := f_ResultValue;
end;//TLoadable_Load_Params.Get_ResultValue

procedure TLoadable_Load_Params.Set_ResultValue(aValue: Boolean);
 {-}
begin
 f_ResultValue := aValue;
end;//TLoadable_Load_Params.Set_ResultValue

function TLoadable_Load_Params.Get_Data: IUnknown;
 {-}
begin
 Result := f_Data;
end;//TLoadable_Load_Params.Get_Data

function TLoadable_Load_Params.Get_NOp: TListLogicOperation;
 {-}
begin
 Result := f_nOp;
end;//TLoadable_Load_Params.Get_NOp

procedure TLoadable_Load_Params.ClearFields;
 {-}
begin
 {$If not defined(Admin)}
 f_Node := nil;
 {$IfEnd} //not Admin
 {$If not defined(Admin)}
 f_Data := nil;
 {$IfEnd} //not Admin
 inherited;
end;//TLoadable_Load_Params.ClearFields
// start class Op_Loadable_Load

class function Op_Loadable_Load.Call(const aTarget: IvcmEntity;
  const aNode: IeeNode;
  const aData: IUnknown;
  anOp: TListLogicOperation = LLO_NONE): Boolean;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TLoadable_Load_Params.Make(aNode,aData,anOp));
  aTarget.Operation(TdmStdRes.opcode_Loadable_Load, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := ILoadable_Load_Params(Data).ResultValue;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Loadable_Load.Call

class function Op_Loadable_Load.Call(const aTarget: IvcmAggregate;
  const aNode: IeeNode;
  const aData: IUnknown;
  anOp: TListLogicOperation = LLO_NONE): Boolean;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TLoadable_Load_Params.Make(aNode,aData,anOp));
  aTarget.Operation(TdmStdRes.opcode_Loadable_Load, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := ILoadable_Load_Params(Data).ResultValue;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Loadable_Load.Call

class function Op_Loadable_Load.Call(const aTarget: IvcmEntityForm;
  const aNode: IeeNode;
  const aData: IUnknown;
  anOp: TListLogicOperation = LLO_NONE): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity, aNode, aData, anOp);
end;//Op_Loadable_Load.Call

class function Op_Loadable_Load.Call(const aTarget: IvcmContainer;
  const aNode: IeeNode;
  const aData: IUnknown;
  anOp: TListLogicOperation = LLO_NONE): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm, aNode, aData, anOp);
end;//Op_Loadable_Load.Call
{$If not defined(Admin) AND not defined(Monitorings)}

type
 TFilters_GetSelected_Params = class(Tl3CProtoObject, IFilters_GetSelected_Params)
  {* Реализация IFilters_GetSelected_Params }
 private
 // private fields
   f_ResultValue : IFiltersFromQuery;
 protected
 // realized methods
   function Get_ResultValue: IFiltersFromQuery;
   procedure Set_ResultValue(const aValue: IFiltersFromQuery);
 protected
 // overridden protected methods
   procedure ClearFields; override;
     {* Сигнатура метода ClearFields }
 public
 // public methods
   constructor Create; reintroduce;
     {* Конструктор TFilters_GetSelected_Params }
   class function Make: IFilters_GetSelected_Params; reintroduce;
     {* Фабрика TFilters_GetSelected_Params }
 end;//TFilters_GetSelected_Params
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

// start class TFilters_GetSelected_Params

constructor TFilters_GetSelected_Params.Create;
 {-}
begin
 inherited Create;
end;//TFilters_GetSelected_Params.Create

class function TFilters_GetSelected_Params.Make: IFilters_GetSelected_Params;
var
 l_Inst : TFilters_GetSelected_Params;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

function TFilters_GetSelected_Params.Get_ResultValue: IFiltersFromQuery;
 {-}
begin
 Result := f_ResultValue;
end;//TFilters_GetSelected_Params.Get_ResultValue

procedure TFilters_GetSelected_Params.Set_ResultValue(const aValue: IFiltersFromQuery);
 {-}
begin
 f_ResultValue := aValue;
end;//TFilters_GetSelected_Params.Set_ResultValue

procedure TFilters_GetSelected_Params.ClearFields;
 {-}
begin
 {$If not defined(Admin) AND not defined(Monitorings)}
 f_ResultValue := nil;
 {$IfEnd} //not Admin AND not Monitorings
 inherited;
end;//TFilters_GetSelected_Params.ClearFields

{$IfEnd} //not Admin AND not Monitorings
{$If not defined(Admin) AND not defined(Monitorings)}

// start class Op_Filters_GetSelected

class function Op_Filters_GetSelected.Call(const aTarget: IvcmEntity): IFiltersFromQuery;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TFilters_GetSelected_Params.Make);
  aTarget.Operation(TdmStdRes.opcode_Filters_GetSelected, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := IFilters_GetSelected_Params(Data).ResultValue;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Filters_GetSelected.Call

class function Op_Filters_GetSelected.Call(const aTarget: IvcmAggregate): IFiltersFromQuery;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TFilters_GetSelected_Params.Make);
  aTarget.Operation(TdmStdRes.opcode_Filters_GetSelected, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := IFilters_GetSelected_Params(Data).ResultValue;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Filters_GetSelected.Call

class function Op_Filters_GetSelected.Call(const aTarget: IvcmEntityForm): IFiltersFromQuery;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity);
end;//Op_Filters_GetSelected.Call

class function Op_Filters_GetSelected.Call(const aTarget: IvcmContainer): IFiltersFromQuery;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm);
end;//Op_Filters_GetSelected.Call

{$IfEnd} //not Admin AND not Monitorings
// start class Op_SearchParameter_QueryNotSaved

class function Op_SearchParameter_QueryNotSaved.Call(const aTarget: IvcmEntity): Boolean;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := vcmParams;
  aTarget.Operation(TdmStdRes.opcode_SearchParameter_QueryNotSaved, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_SearchParameter_QueryNotSaved.Call

class function Op_SearchParameter_QueryNotSaved.Call(const aTarget: IvcmAggregate): Boolean;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := vcmParams;
  aTarget.Operation(TdmStdRes.opcode_SearchParameter_QueryNotSaved, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_SearchParameter_QueryNotSaved.Call

class function Op_SearchParameter_QueryNotSaved.Call(const aTarget: IvcmEntityForm): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity);
end;//Op_SearchParameter_QueryNotSaved.Call

class function Op_SearchParameter_QueryNotSaved.Call(const aTarget: IvcmContainer): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm);
end;//Op_SearchParameter_QueryNotSaved.Call
// start class Op_SearchParameter_ClearMistakes

class function Op_SearchParameter_ClearMistakes.Call(const aTarget: IvcmEntity): Boolean;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := vcmParams;
  aTarget.Operation(TdmStdRes.opcode_SearchParameter_ClearMistakes, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_SearchParameter_ClearMistakes.Call

class function Op_SearchParameter_ClearMistakes.Call(const aTarget: IvcmAggregate): Boolean;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := vcmParams;
  aTarget.Operation(TdmStdRes.opcode_SearchParameter_ClearMistakes, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_SearchParameter_ClearMistakes.Call

class function Op_SearchParameter_ClearMistakes.Call(const aTarget: IvcmEntityForm): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity);
end;//Op_SearchParameter_ClearMistakes.Call

class function Op_SearchParameter_ClearMistakes.Call(const aTarget: IvcmContainer): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm);
end;//Op_SearchParameter_ClearMistakes.Call
// start class Op_SearchParameter_QuerySaved

class function Op_SearchParameter_QuerySaved.Call(const aTarget: IvcmEntity): Boolean;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := vcmParams;
  aTarget.Operation(TdmStdRes.opcode_SearchParameter_QuerySaved, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_SearchParameter_QuerySaved.Call

class function Op_SearchParameter_QuerySaved.Call(const aTarget: IvcmAggregate): Boolean;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := vcmParams;
  aTarget.Operation(TdmStdRes.opcode_SearchParameter_QuerySaved, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_SearchParameter_QuerySaved.Call

class function Op_SearchParameter_QuerySaved.Call(const aTarget: IvcmEntityForm): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity);
end;//Op_SearchParameter_QuerySaved.Call

class function Op_SearchParameter_QuerySaved.Call(const aTarget: IvcmContainer): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm);
end;//Op_SearchParameter_QuerySaved.Call
// start class Op_PrintParams_UpdatePrinter

class function Op_PrintParams_UpdatePrinter.Call(const aTarget: IvcmEntity): Boolean;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := vcmParams;
  aTarget.Operation(TdmStdRes.opcode_PrintParams_UpdatePrinter, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_PrintParams_UpdatePrinter.Call

class function Op_PrintParams_UpdatePrinter.Call(const aTarget: IvcmAggregate): Boolean;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := vcmParams;
  aTarget.Operation(TdmStdRes.opcode_PrintParams_UpdatePrinter, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_PrintParams_UpdatePrinter.Call

class function Op_PrintParams_UpdatePrinter.Call(const aTarget: IvcmEntityForm): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity);
end;//Op_PrintParams_UpdatePrinter.Call

class function Op_PrintParams_UpdatePrinter.Call(const aTarget: IvcmContainer): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm);
end;//Op_PrintParams_UpdatePrinter.Call

class procedure Op_PrintParams_UpdatePrinter.Broadcast;
var
 l_Params : IvcmExecuteParams;
begin
 if (vcmDispatcher <> nil) then
 begin
  l_Params := vcmParams;
  vcmDispatcher.EntityOperationBroadcast(TdmStdRes.opcode_PrintParams_UpdatePrinter, l_Params);
 end;//vcmDispatcher <> nil
end;//Op_PrintParams_UpdatePrinter.Broadcast
// start class Op_List_SetNewContent

class function Op_List_SetNewContent.Call(const aTarget: IvcmEntity): Boolean;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := vcmParams;
  aTarget.Operation(TdmStdRes.opcode_List_SetNewContent, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_List_SetNewContent.Call

class function Op_List_SetNewContent.Call(const aTarget: IvcmAggregate): Boolean;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := vcmParams;
  aTarget.Operation(TdmStdRes.opcode_List_SetNewContent, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_List_SetNewContent.Call

class function Op_List_SetNewContent.Call(const aTarget: IvcmEntityForm): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity);
end;//Op_List_SetNewContent.Call

class function Op_List_SetNewContent.Call(const aTarget: IvcmContainer): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm);
end;//Op_List_SetNewContent.Call
{$IfEnd} //not Admin


end.