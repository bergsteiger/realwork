unit Search_Strange_Controls;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Search_Strange_Controls.pas"
// Стереотип: "VCMControls"
// Элемент модели: "Strange" MUID: (4AE89F8A004B)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin)}
uses
 l3IntfUses
 , BaseTreeSupportUnit
 , DynamicTreeUnit
 , FiltersUnit
 , l3TreeInterfaces
 , bsTypes
 , eeInterfaces
 , PrimPrimListInterfaces
 , nsTypes
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TNodesArray = IFiltersFromQuery;

 IQuery_ClearAll_Params = interface
  {* Параметры для операции Query.ClearAll }
  function Get_NotClearRange: Boolean;
  property NotClearRange: Boolean
   read Get_NotClearRange;
 end;//IQuery_ClearAll_Params

 Op_Query_ClearAll = {final} class
  {* Класс для вызова операции Query.ClearAll }
  public
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

 IQuery_SetList_Params = interface
  {* Параметры для операции Query.SetList }
  function Get_List: IdeList;
  function Get_InList: Boolean;
  property List: IdeList
   read Get_List;
  property InList: Boolean
   read Get_InList;
 end;//IQuery_SetList_Params

 Op_Query_SetList = {final} class
  {* Класс для вызова операции Query.SetList }
  public
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

 IQuery_GetList_Params = interface
  {* Параметры для операции Query.GetList }
  function Get_ResultValue: IdeList;
  procedure Set_ResultValue(const aValue: IdeList);
  property ResultValue: IdeList
   read Get_ResultValue
   write Set_ResultValue;
 end;//IQuery_GetList_Params

 Op_Query_GetList = {final} class
  {* Класс для вызова операции Query.GetList }
  public
   class function Call(const aTarget: IvcmEntity): IdeList; overload;
    {* Вызов операции Query.GetList у сущности }
   class function Call(const aTarget: IvcmAggregate): IdeList; overload;
    {* Вызов операции Query.GetList у агрегации }
   class function Call(const aTarget: IvcmEntityForm): IdeList; overload;
    {* Вызов операции Query.GetList у формы }
   class function Call(const aTarget: IvcmContainer): IdeList; overload;
    {* Вызов операции Query.GetList у контейнера }
 end;//Op_Query_GetList

 IFilterable_Add_Params = interface
  {* Параметры для операции Filterable.Add }
  function Get_Filter: IFilterFromQuery;
  function Get_ResultValue: Boolean;
  procedure Set_ResultValue(aValue: Boolean);
  property Filter: IFilterFromQuery
   read Get_Filter;
  property ResultValue: Boolean
   read Get_ResultValue
   write Set_ResultValue;
 end;//IFilterable_Add_Params

 Op_Filterable_Add = {final} class
  {* Класс для вызова операции Filterable.Add }
  public
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

 IFilterable_Delete_Params = interface
  {* Параметры для операции Filterable.Delete }
  function Get_Filter: IFilterFromQuery;
  function Get_ResultValue: Boolean;
  procedure Set_ResultValue(aValue: Boolean);
  property Filter: IFilterFromQuery
   read Get_Filter;
  property ResultValue: Boolean
   read Get_ResultValue
   write Set_ResultValue;
 end;//IFilterable_Delete_Params

 Op_Filterable_Delete = {final} class
  {* Класс для вызова операции Filterable.Delete }
  public
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

 Op_Filterable_ClearAll = {final} class
  {* Класс для вызова операции Filterable.ClearAll }
  public
   class function Call(const aTarget: IvcmEntity): Boolean; overload;
    {* Вызов операции Filterable.ClearAll у сущности }
   class function Call(const aTarget: IvcmAggregate): Boolean; overload;
    {* Вызов операции Filterable.ClearAll у агрегации }
   class function Call(const aTarget: IvcmEntityForm): Boolean; overload;
    {* Вызов операции Filterable.ClearAll у формы }
   class function Call(const aTarget: IvcmContainer): Boolean; overload;
    {* Вызов операции Filterable.ClearAll у контейнера }
 end;//Op_Filterable_ClearAll

 IFilterable_Refresh_Params = interface
  {* Параметры для операции Filterable.Refresh }
  function Get_ResultValue: Boolean;
  procedure Set_ResultValue(aValue: Boolean);
  property ResultValue: Boolean
   read Get_ResultValue
   write Set_ResultValue;
 end;//IFilterable_Refresh_Params

 Op_Filterable_Refresh = {final} class
  {* Класс для вызова операции Filterable.Refresh }
  public
   class function Call(const aTarget: IvcmEntity): Boolean; overload;
    {* Вызов операции Filterable.Refresh у сущности }
   class function Call(const aTarget: IvcmAggregate): Boolean; overload;
    {* Вызов операции Filterable.Refresh у агрегации }
   class function Call(const aTarget: IvcmEntityForm): Boolean; overload;
    {* Вызов операции Filterable.Refresh у формы }
   class function Call(const aTarget: IvcmContainer): Boolean; overload;
    {* Вызов операции Filterable.Refresh у контейнера }
 end;//Op_Filterable_Refresh

 IFilterable_GetListType_Params = interface
  {* Параметры для операции Filterable.GetListType }
  function Get_ResultValue: TbsListType;
  procedure Set_ResultValue(aValue: TbsListType);
  property ResultValue: TbsListType
   read Get_ResultValue
   write Set_ResultValue;
 end;//IFilterable_GetListType_Params

 Op_Filterable_GetListType = {final} class
  {* Класс для вызова операции Filterable.GetListType }
  public
   class function Call(const aTarget: IvcmEntity): TbsListType; overload;
    {* Вызов операции Filterable.GetListType у сущности }
   class function Call(const aTarget: IvcmAggregate): TbsListType; overload;
    {* Вызов операции Filterable.GetListType у агрегации }
   class function Call(const aTarget: IvcmEntityForm): TbsListType; overload;
    {* Вызов операции Filterable.GetListType у формы }
   class function Call(const aTarget: IvcmContainer): TbsListType; overload;
    {* Вызов операции Filterable.GetListType у контейнера }
 end;//Op_Filterable_GetListType

 ILoadable_Load_Params = interface
  {* Параметры для операции Loadable.Load }
  function Get_Node: IeeNode;
  function Get_Data: IUnknown;
  function Get_nOp: TListLogicOperation;
  function Get_ResultValue: Boolean;
  procedure Set_ResultValue(aValue: Boolean);
  property Node: IeeNode
   read Get_Node;
  property Data: IUnknown
   read Get_Data;
  property nOp: TListLogicOperation
   read Get_nOp;
  property ResultValue: Boolean
   read Get_ResultValue
   write Set_ResultValue;
 end;//ILoadable_Load_Params

 Op_Loadable_Load = {final} class
  {* Класс для вызова операции Loadable.Load }
  public
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

{$If NOT Defined(Monitorings)}
 IFilters_GetSelected_Params = interface
  {* Параметры для операции Filters.GetSelected }
  function Get_ResultValue: IFiltersFromQuery;
  procedure Set_ResultValue(const aValue: IFiltersFromQuery);
  property ResultValue: IFiltersFromQuery
   read Get_ResultValue
   write Set_ResultValue;
 end;//IFilters_GetSelected_Params
{$IfEnd} // NOT Defined(Monitorings)

{$If NOT Defined(Monitorings)}
 Op_Filters_GetSelected = {final} class
  {* Класс для вызова операции Filters.GetSelected }
  public
   class function Call(const aTarget: IvcmEntity): IFiltersFromQuery; overload;
    {* Вызов операции Filters.GetSelected у сущности }
   class function Call(const aTarget: IvcmAggregate): IFiltersFromQuery; overload;
    {* Вызов операции Filters.GetSelected у агрегации }
   class function Call(const aTarget: IvcmEntityForm): IFiltersFromQuery; overload;
    {* Вызов операции Filters.GetSelected у формы }
   class function Call(const aTarget: IvcmContainer): IFiltersFromQuery; overload;
    {* Вызов операции Filters.GetSelected у контейнера }
 end;//Op_Filters_GetSelected
{$IfEnd} // NOT Defined(Monitorings)

 Op_SearchParameter_QueryNotSaved = {final} class
  {* Класс для вызова операции SearchParameter.QueryNotSaved }
  public
   class function Call(const aTarget: IvcmEntity): Boolean; overload;
    {* Вызов операции SearchParameter.QueryNotSaved у сущности }
   class function Call(const aTarget: IvcmAggregate): Boolean; overload;
    {* Вызов операции SearchParameter.QueryNotSaved у агрегации }
   class function Call(const aTarget: IvcmEntityForm): Boolean; overload;
    {* Вызов операции SearchParameter.QueryNotSaved у формы }
   class function Call(const aTarget: IvcmContainer): Boolean; overload;
    {* Вызов операции SearchParameter.QueryNotSaved у контейнера }
 end;//Op_SearchParameter_QueryNotSaved

 Op_SearchParameter_ClearMistakes = {final} class
  {* Класс для вызова операции SearchParameter.ClearMistakes }
  public
   class function Call(const aTarget: IvcmEntity): Boolean; overload;
    {* Вызов операции SearchParameter.ClearMistakes у сущности }
   class function Call(const aTarget: IvcmAggregate): Boolean; overload;
    {* Вызов операции SearchParameter.ClearMistakes у агрегации }
   class function Call(const aTarget: IvcmEntityForm): Boolean; overload;
    {* Вызов операции SearchParameter.ClearMistakes у формы }
   class function Call(const aTarget: IvcmContainer): Boolean; overload;
    {* Вызов операции SearchParameter.ClearMistakes у контейнера }
 end;//Op_SearchParameter_ClearMistakes

 Op_SearchParameter_QuerySaved = {final} class
  {* Класс для вызова операции SearchParameter.QuerySaved }
  public
   class function Call(const aTarget: IvcmEntity): Boolean; overload;
    {* Вызов операции SearchParameter.QuerySaved у сущности }
   class function Call(const aTarget: IvcmAggregate): Boolean; overload;
    {* Вызов операции SearchParameter.QuerySaved у агрегации }
   class function Call(const aTarget: IvcmEntityForm): Boolean; overload;
    {* Вызов операции SearchParameter.QuerySaved у формы }
   class function Call(const aTarget: IvcmContainer): Boolean; overload;
    {* Вызов операции SearchParameter.QuerySaved у контейнера }
 end;//Op_SearchParameter_QuerySaved

 Op_PrintParams_UpdatePrinter = {final} class
  {* Класс для вызова операции PrintParams.UpdatePrinter }
  public
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

 Op_List_SetNewContent = {final} class
  {* Класс для вызова операции List.SetNewContent }
  public
   class function Call(const aTarget: IvcmEntity): Boolean; overload;
    {* Вызов операции List.SetNewContent у сущности }
   class function Call(const aTarget: IvcmAggregate): Boolean; overload;
    {* Вызов операции List.SetNewContent у агрегации }
   class function Call(const aTarget: IvcmEntityForm): Boolean; overload;
    {* Вызов операции List.SetNewContent у формы }
   class function Call(const aTarget: IvcmContainer): Boolean; overload;
    {* Вызов операции List.SetNewContent у контейнера }
 end;//Op_List_SetNewContent

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
{$IfEnd} // NOT Defined(Admin)

implementation

{$If NOT Defined(Admin)}
uses
 l3ImplUses
 , l3CProtoObject
 , l3Base
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , StdRes
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TQuery_ClearAll_Params = {final} class(Tl3CProtoObject, IQuery_ClearAll_Params)
  {* Реализация IQuery_ClearAll_Params }
  private
   f_NotClearRange: Boolean;
  protected
   function Get_NotClearRange: Boolean;
  public
   constructor Create(aNotClearRange: Boolean); reintroduce;
   class function Make(aNotClearRange: Boolean): IQuery_ClearAll_Params; reintroduce;
 end;//TQuery_ClearAll_Params

 TQuery_SetList_Params = {final} class(Tl3CProtoObject, IQuery_SetList_Params)
  {* Реализация IQuery_SetList_Params }
  private
   f_List: IdeList;
   f_InList: Boolean;
  protected
   function Get_List: IdeList;
   function Get_InList: Boolean;
   procedure ClearFields; override;
  public
   constructor Create(const aList: IdeList;
    aInList: Boolean); reintroduce;
   class function Make(const aList: IdeList;
    aInList: Boolean): IQuery_SetList_Params; reintroduce;
 end;//TQuery_SetList_Params

 TQuery_GetList_Params = {final} class(Tl3CProtoObject, IQuery_GetList_Params)
  {* Реализация IQuery_GetList_Params }
  private
   f_ResultValue: IdeList;
  protected
   function Get_ResultValue: IdeList;
   procedure Set_ResultValue(const aValue: IdeList);
   procedure ClearFields; override;
  public
   class function Make: IQuery_GetList_Params; reintroduce;
 end;//TQuery_GetList_Params

 TFilterable_Add_Params = {final} class(Tl3CProtoObject, IFilterable_Add_Params)
  {* Реализация IFilterable_Add_Params }
  private
   f_Filter: IFilterFromQuery;
   f_ResultValue: Boolean;
  protected
   function Get_Filter: IFilterFromQuery;
   function Get_ResultValue: Boolean;
   procedure Set_ResultValue(aValue: Boolean);
   procedure ClearFields; override;
  public
   constructor Create(const aFilter: IFilterFromQuery); reintroduce;
   class function Make(const aFilter: IFilterFromQuery): IFilterable_Add_Params; reintroduce;
 end;//TFilterable_Add_Params

 TFilterable_Delete_Params = {final} class(Tl3CProtoObject, IFilterable_Delete_Params)
  {* Реализация IFilterable_Delete_Params }
  private
   f_Filter: IFilterFromQuery;
   f_ResultValue: Boolean;
  protected
   function Get_Filter: IFilterFromQuery;
   function Get_ResultValue: Boolean;
   procedure Set_ResultValue(aValue: Boolean);
   procedure ClearFields; override;
  public
   constructor Create(const aFilter: IFilterFromQuery); reintroduce;
   class function Make(const aFilter: IFilterFromQuery): IFilterable_Delete_Params; reintroduce;
 end;//TFilterable_Delete_Params

 TFilterable_Refresh_Params = {final} class(Tl3CProtoObject, IFilterable_Refresh_Params)
  {* Реализация IFilterable_Refresh_Params }
  private
   f_ResultValue: Boolean;
  protected
   function Get_ResultValue: Boolean;
   procedure Set_ResultValue(aValue: Boolean);
  public
   class function Make: IFilterable_Refresh_Params; reintroduce;
 end;//TFilterable_Refresh_Params

 TFilterable_GetListType_Params = {final} class(Tl3CProtoObject, IFilterable_GetListType_Params)
  {* Реализация IFilterable_GetListType_Params }
  private
   f_ResultValue: TbsListType;
  protected
   function Get_ResultValue: TbsListType;
   procedure Set_ResultValue(aValue: TbsListType);
  public
   class function Make: IFilterable_GetListType_Params; reintroduce;
 end;//TFilterable_GetListType_Params

 TLoadable_Load_Params = {final} class(Tl3CProtoObject, ILoadable_Load_Params)
  {* Реализация ILoadable_Load_Params }
  private
   f_Node: IeeNode;
   f_Data: IUnknown;
   f_nOp: TListLogicOperation;
   f_ResultValue: Boolean;
  protected
   function Get_Node: IeeNode;
   function Get_Data: IUnknown;
   function Get_nOp: TListLogicOperation;
   function Get_ResultValue: Boolean;
   procedure Set_ResultValue(aValue: Boolean);
   procedure ClearFields; override;
  public
   constructor Create(const aNode: IeeNode;
    const aData: IUnknown;
    anOp: TListLogicOperation = LLO_NONE); reintroduce;
   class function Make(const aNode: IeeNode;
    const aData: IUnknown;
    anOp: TListLogicOperation = LLO_NONE): ILoadable_Load_Params; reintroduce;
 end;//TLoadable_Load_Params

{$If NOT Defined(Monitorings)}
 TFilters_GetSelected_Params = {final} class(Tl3CProtoObject, IFilters_GetSelected_Params)
  {* Реализация IFilters_GetSelected_Params }
  private
   f_ResultValue: IFiltersFromQuery;
  protected
   function Get_ResultValue: IFiltersFromQuery;
   procedure Set_ResultValue(const aValue: IFiltersFromQuery);
   procedure ClearFields; override;
  public
   class function Make: IFilters_GetSelected_Params; reintroduce;
 end;//TFilters_GetSelected_Params
{$IfEnd} // NOT Defined(Monitorings)

constructor TQuery_ClearAll_Params.Create(aNotClearRange: Boolean);
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
end;//TQuery_ClearAll_Params.Make

function TQuery_ClearAll_Params.Get_NotClearRange: Boolean;
begin
 Result := f_NotClearRange;
end;//TQuery_ClearAll_Params.Get_NotClearRange

class function Op_Query_ClearAll.Call(const aTarget: IvcmEntity;
 aNotClearRange: Boolean): Boolean;
 {* Вызов операции Query.ClearAll у сущности }
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
 {* Вызов операции Query.ClearAll у агрегации }
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
 {* Вызов операции Query.ClearAll у формы }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity, aNotClearRange);
end;//Op_Query_ClearAll.Call

class function Op_Query_ClearAll.Call(const aTarget: IvcmContainer;
 aNotClearRange: Boolean): Boolean;
 {* Вызов операции Query.ClearAll у контейнера }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm, aNotClearRange);
end;//Op_Query_ClearAll.Call

constructor TQuery_SetList_Params.Create(const aList: IdeList;
 aInList: Boolean);
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
end;//TQuery_SetList_Params.Make

function TQuery_SetList_Params.Get_List: IdeList;
begin
 Result := f_List;
end;//TQuery_SetList_Params.Get_List

function TQuery_SetList_Params.Get_InList: Boolean;
begin
 Result := f_InList;
end;//TQuery_SetList_Params.Get_InList

procedure TQuery_SetList_Params.ClearFields;
begin
 f_List := nil;
 inherited;
end;//TQuery_SetList_Params.ClearFields

class function Op_Query_SetList.Call(const aTarget: IvcmEntity;
 const aList: IdeList;
 aInList: Boolean): Boolean;
 {* Вызов операции Query.SetList у сущности }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TQuery_SetList_Params.Make(aList, aInList));
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
 {* Вызов операции Query.SetList у агрегации }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TQuery_SetList_Params.Make(aList, aInList));
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
 {* Вызов операции Query.SetList у формы }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity, aList, aInList);
end;//Op_Query_SetList.Call

class function Op_Query_SetList.Call(const aTarget: IvcmContainer;
 const aList: IdeList;
 aInList: Boolean): Boolean;
 {* Вызов операции Query.SetList у контейнера }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm, aList, aInList);
end;//Op_Query_SetList.Call

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
end;//TQuery_GetList_Params.Make

function TQuery_GetList_Params.Get_ResultValue: IdeList;
begin
 Result := f_ResultValue;
end;//TQuery_GetList_Params.Get_ResultValue

procedure TQuery_GetList_Params.Set_ResultValue(const aValue: IdeList);
begin
 f_ResultValue := aValue;
end;//TQuery_GetList_Params.Set_ResultValue

procedure TQuery_GetList_Params.ClearFields;
begin
 f_ResultValue := nil;
 inherited;
end;//TQuery_GetList_Params.ClearFields

class function Op_Query_GetList.Call(const aTarget: IvcmEntity): IdeList;
 {* Вызов операции Query.GetList у сущности }
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
 {* Вызов операции Query.GetList у агрегации }
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
 {* Вызов операции Query.GetList у формы }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity);
end;//Op_Query_GetList.Call

class function Op_Query_GetList.Call(const aTarget: IvcmContainer): IdeList;
 {* Вызов операции Query.GetList у контейнера }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm);
end;//Op_Query_GetList.Call

constructor TFilterable_Add_Params.Create(const aFilter: IFilterFromQuery);
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
end;//TFilterable_Add_Params.Make

function TFilterable_Add_Params.Get_Filter: IFilterFromQuery;
begin
 Result := f_Filter;
end;//TFilterable_Add_Params.Get_Filter

function TFilterable_Add_Params.Get_ResultValue: Boolean;
begin
 Result := f_ResultValue;
end;//TFilterable_Add_Params.Get_ResultValue

procedure TFilterable_Add_Params.Set_ResultValue(aValue: Boolean);
begin
 f_ResultValue := aValue;
end;//TFilterable_Add_Params.Set_ResultValue

procedure TFilterable_Add_Params.ClearFields;
begin
 f_Filter := nil;
 inherited;
end;//TFilterable_Add_Params.ClearFields

class function Op_Filterable_Add.Call(const aTarget: IvcmEntity;
 const aFilter: IFilterFromQuery): Boolean;
 {* Вызов операции Filterable.Add у сущности }
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
 {* Вызов операции Filterable.Add у агрегации }
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
 {* Вызов операции Filterable.Add у формы }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity, aFilter);
end;//Op_Filterable_Add.Call

class function Op_Filterable_Add.Call(const aTarget: IvcmContainer;
 const aFilter: IFilterFromQuery): Boolean;
 {* Вызов операции Filterable.Add у контейнера }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm, aFilter);
end;//Op_Filterable_Add.Call

constructor TFilterable_Delete_Params.Create(const aFilter: IFilterFromQuery);
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
end;//TFilterable_Delete_Params.Make

function TFilterable_Delete_Params.Get_Filter: IFilterFromQuery;
begin
 Result := f_Filter;
end;//TFilterable_Delete_Params.Get_Filter

function TFilterable_Delete_Params.Get_ResultValue: Boolean;
begin
 Result := f_ResultValue;
end;//TFilterable_Delete_Params.Get_ResultValue

procedure TFilterable_Delete_Params.Set_ResultValue(aValue: Boolean);
begin
 f_ResultValue := aValue;
end;//TFilterable_Delete_Params.Set_ResultValue

procedure TFilterable_Delete_Params.ClearFields;
begin
 f_Filter := nil;
 inherited;
end;//TFilterable_Delete_Params.ClearFields

class function Op_Filterable_Delete.Call(const aTarget: IvcmEntity;
 const aFilter: IFilterFromQuery): Boolean;
 {* Вызов операции Filterable.Delete у сущности }
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
 {* Вызов операции Filterable.Delete у агрегации }
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
 {* Вызов операции Filterable.Delete у формы }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity, aFilter);
end;//Op_Filterable_Delete.Call

class function Op_Filterable_Delete.Call(const aTarget: IvcmContainer;
 const aFilter: IFilterFromQuery): Boolean;
 {* Вызов операции Filterable.Delete у контейнера }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm, aFilter);
end;//Op_Filterable_Delete.Call

class function Op_Filterable_ClearAll.Call(const aTarget: IvcmEntity): Boolean;
 {* Вызов операции Filterable.ClearAll у сущности }
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
 {* Вызов операции Filterable.ClearAll у агрегации }
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
 {* Вызов операции Filterable.ClearAll у формы }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity);
end;//Op_Filterable_ClearAll.Call

class function Op_Filterable_ClearAll.Call(const aTarget: IvcmContainer): Boolean;
 {* Вызов операции Filterable.ClearAll у контейнера }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm);
end;//Op_Filterable_ClearAll.Call

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
end;//TFilterable_Refresh_Params.Make

function TFilterable_Refresh_Params.Get_ResultValue: Boolean;
begin
 Result := f_ResultValue;
end;//TFilterable_Refresh_Params.Get_ResultValue

procedure TFilterable_Refresh_Params.Set_ResultValue(aValue: Boolean);
begin
 f_ResultValue := aValue;
end;//TFilterable_Refresh_Params.Set_ResultValue

class function Op_Filterable_Refresh.Call(const aTarget: IvcmEntity): Boolean;
 {* Вызов операции Filterable.Refresh у сущности }
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
 {* Вызов операции Filterable.Refresh у агрегации }
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
 {* Вызов операции Filterable.Refresh у формы }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity);
end;//Op_Filterable_Refresh.Call

class function Op_Filterable_Refresh.Call(const aTarget: IvcmContainer): Boolean;
 {* Вызов операции Filterable.Refresh у контейнера }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm);
end;//Op_Filterable_Refresh.Call

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
end;//TFilterable_GetListType_Params.Make

function TFilterable_GetListType_Params.Get_ResultValue: TbsListType;
begin
 Result := f_ResultValue;
end;//TFilterable_GetListType_Params.Get_ResultValue

procedure TFilterable_GetListType_Params.Set_ResultValue(aValue: TbsListType);
begin
 f_ResultValue := aValue;
end;//TFilterable_GetListType_Params.Set_ResultValue

class function Op_Filterable_GetListType.Call(const aTarget: IvcmEntity): TbsListType;
 {* Вызов операции Filterable.GetListType у сущности }
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
 {* Вызов операции Filterable.GetListType у агрегации }
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
 {* Вызов операции Filterable.GetListType у формы }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity);
end;//Op_Filterable_GetListType.Call

class function Op_Filterable_GetListType.Call(const aTarget: IvcmContainer): TbsListType;
 {* Вызов операции Filterable.GetListType у контейнера }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm);
end;//Op_Filterable_GetListType.Call

constructor TLoadable_Load_Params.Create(const aNode: IeeNode;
 const aData: IUnknown;
 anOp: TListLogicOperation = LLO_NONE);
begin
 inherited Create;
 f_Node := aNode;
 f_Data := aData;
 f_nOp := anOp;
end;//TLoadable_Load_Params.Create

class function TLoadable_Load_Params.Make(const aNode: IeeNode;
 const aData: IUnknown;
 anOp: TListLogicOperation = LLO_NONE): ILoadable_Load_Params;
var
 l_Inst : TLoadable_Load_Params;
begin
 l_Inst := Create(aNode, aData, anOp);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TLoadable_Load_Params.Make

function TLoadable_Load_Params.Get_Node: IeeNode;
begin
 Result := f_Node;
end;//TLoadable_Load_Params.Get_Node

function TLoadable_Load_Params.Get_Data: IUnknown;
begin
 Result := f_Data;
end;//TLoadable_Load_Params.Get_Data

function TLoadable_Load_Params.Get_nOp: TListLogicOperation;
begin
 Result := f_nOp;
end;//TLoadable_Load_Params.Get_nOp

function TLoadable_Load_Params.Get_ResultValue: Boolean;
begin
 Result := f_ResultValue;
end;//TLoadable_Load_Params.Get_ResultValue

procedure TLoadable_Load_Params.Set_ResultValue(aValue: Boolean);
begin
 f_ResultValue := aValue;
end;//TLoadable_Load_Params.Set_ResultValue

procedure TLoadable_Load_Params.ClearFields;
begin
 f_Node := nil;
 f_Data := nil;
 inherited;
end;//TLoadable_Load_Params.ClearFields

class function Op_Loadable_Load.Call(const aTarget: IvcmEntity;
 const aNode: IeeNode;
 const aData: IUnknown;
 anOp: TListLogicOperation = LLO_NONE): Boolean;
 {* Вызов операции Loadable.Load у сущности }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TLoadable_Load_Params.Make(aNode, aData, anOp));
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
 {* Вызов операции Loadable.Load у агрегации }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TLoadable_Load_Params.Make(aNode, aData, anOp));
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
 {* Вызов операции Loadable.Load у формы }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity, aNode, aData, anOp);
end;//Op_Loadable_Load.Call

class function Op_Loadable_Load.Call(const aTarget: IvcmContainer;
 const aNode: IeeNode;
 const aData: IUnknown;
 anOp: TListLogicOperation = LLO_NONE): Boolean;
 {* Вызов операции Loadable.Load у контейнера }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm, aNode, aData, anOp);
end;//Op_Loadable_Load.Call

{$If NOT Defined(Monitorings)}
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
end;//TFilters_GetSelected_Params.Make

function TFilters_GetSelected_Params.Get_ResultValue: IFiltersFromQuery;
begin
 Result := f_ResultValue;
end;//TFilters_GetSelected_Params.Get_ResultValue

procedure TFilters_GetSelected_Params.Set_ResultValue(const aValue: IFiltersFromQuery);
begin
 f_ResultValue := aValue;
end;//TFilters_GetSelected_Params.Set_ResultValue

procedure TFilters_GetSelected_Params.ClearFields;
begin
 Finalize(f_ResultValue);
 inherited;
end;//TFilters_GetSelected_Params.ClearFields
{$IfEnd} // NOT Defined(Monitorings)

{$If NOT Defined(Monitorings)}
class function Op_Filters_GetSelected.Call(const aTarget: IvcmEntity): IFiltersFromQuery;
 {* Вызов операции Filters.GetSelected у сущности }
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
 {* Вызов операции Filters.GetSelected у агрегации }
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
 {* Вызов операции Filters.GetSelected у формы }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity);
end;//Op_Filters_GetSelected.Call

class function Op_Filters_GetSelected.Call(const aTarget: IvcmContainer): IFiltersFromQuery;
 {* Вызов операции Filters.GetSelected у контейнера }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm);
end;//Op_Filters_GetSelected.Call
{$IfEnd} // NOT Defined(Monitorings)

class function Op_SearchParameter_QueryNotSaved.Call(const aTarget: IvcmEntity): Boolean;
 {* Вызов операции SearchParameter.QueryNotSaved у сущности }
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
 {* Вызов операции SearchParameter.QueryNotSaved у агрегации }
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
 {* Вызов операции SearchParameter.QueryNotSaved у формы }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity);
end;//Op_SearchParameter_QueryNotSaved.Call

class function Op_SearchParameter_QueryNotSaved.Call(const aTarget: IvcmContainer): Boolean;
 {* Вызов операции SearchParameter.QueryNotSaved у контейнера }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm);
end;//Op_SearchParameter_QueryNotSaved.Call

class function Op_SearchParameter_ClearMistakes.Call(const aTarget: IvcmEntity): Boolean;
 {* Вызов операции SearchParameter.ClearMistakes у сущности }
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
 {* Вызов операции SearchParameter.ClearMistakes у агрегации }
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
 {* Вызов операции SearchParameter.ClearMistakes у формы }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity);
end;//Op_SearchParameter_ClearMistakes.Call

class function Op_SearchParameter_ClearMistakes.Call(const aTarget: IvcmContainer): Boolean;
 {* Вызов операции SearchParameter.ClearMistakes у контейнера }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm);
end;//Op_SearchParameter_ClearMistakes.Call

class function Op_SearchParameter_QuerySaved.Call(const aTarget: IvcmEntity): Boolean;
 {* Вызов операции SearchParameter.QuerySaved у сущности }
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
 {* Вызов операции SearchParameter.QuerySaved у агрегации }
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
 {* Вызов операции SearchParameter.QuerySaved у формы }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity);
end;//Op_SearchParameter_QuerySaved.Call

class function Op_SearchParameter_QuerySaved.Call(const aTarget: IvcmContainer): Boolean;
 {* Вызов операции SearchParameter.QuerySaved у контейнера }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm);
end;//Op_SearchParameter_QuerySaved.Call

class function Op_PrintParams_UpdatePrinter.Call(const aTarget: IvcmEntity): Boolean;
 {* Вызов операции PrintParams.UpdatePrinter у сущности }
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
 {* Вызов операции PrintParams.UpdatePrinter у агрегации }
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
 {* Вызов операции PrintParams.UpdatePrinter у формы }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity);
end;//Op_PrintParams_UpdatePrinter.Call

class function Op_PrintParams_UpdatePrinter.Call(const aTarget: IvcmContainer): Boolean;
 {* Вызов операции PrintParams.UpdatePrinter у контейнера }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm);
end;//Op_PrintParams_UpdatePrinter.Call

class procedure Op_PrintParams_UpdatePrinter.Broadcast;
 {* Вызов операции PrintParams.UpdatePrinter у всех зарегистрированных сущностей }
var
 l_Params : IvcmExecuteParams;
begin
 if (vcmDispatcher <> nil) then
 begin
  l_Params := vcmParams;
  vcmDispatcher.EntityOperationBroadcast(TdmStdRes.opcode_PrintParams_UpdatePrinter, l_Params);
 end//vcmDispatcher <> nil
end;//Op_PrintParams_UpdatePrinter.Broadcast

class function Op_List_SetNewContent.Call(const aTarget: IvcmEntity): Boolean;
 {* Вызов операции List.SetNewContent у сущности }
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
 {* Вызов операции List.SetNewContent у агрегации }
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
 {* Вызов операции List.SetNewContent у формы }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity);
end;//Op_List_SetNewContent.Call

class function Op_List_SetNewContent.Call(const aTarget: IvcmContainer): Boolean;
 {* Вызов операции List.SetNewContent у контейнера }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm);
end;//Op_List_SetNewContent.Call
{$IfEnd} // NOT Defined(Admin)

end.
