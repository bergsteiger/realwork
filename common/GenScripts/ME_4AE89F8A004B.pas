unit Search_Strange_Controls;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Search_Strange_Controls.pas"
// Стереотип: "VCMControls"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin)}
uses
 l3IntfUses
 , PrimPrimListInterfaces
 , bsTypes
 , FiltersUnit
 , eeInterfaces
 , nsTypes
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 // Query

 // Filterable

 TNodesArray = IFiltersFromQuery;

 // Loadable

 {$If NOT Defined(Monitorings)}
 // Filters
 {$IfEnd} // NOT Defined(Monitorings)

 // SearchParameter

 // PrintParams

 // List

 // CardOperation

 // File

 // Query

 // Query

 // LogicOperation

 // Filters

 // Preview

 // Document

 // SubPanelSettings

 // Result

 // ColontitulMacro

 // SubPanelSettings

 // SubPanelSettings

 IQuery_ClearAll_Params = interface
  {* Параметры для операции Query.ClearAll }
  ['{B1040795-7346-4058-8A20-921C2AB0E0EC}']
  function Get_NotClearRange: Boolean;
  property NotClearRange: Boolean
   read Get_NotClearRange;
 end;//IQuery_ClearAll_Params

 Op_Query_ClearAll = class
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
  ['{BFF0E7CA-CD4B-44A0-9E3A-0D1DD07627B5}']
  function Get_List: IdeList;
  function Get_InList: Boolean;
  property List: IdeList
   read Get_List;
  property InList: Boolean
   read Get_InList;
 end;//IQuery_SetList_Params

 Op_Query_SetList = class
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
  ['{47F215CF-D56C-46D8-B3AF-7BE79921C789}']
  function Get_ResultValue: IdeList;
  procedure Set_ResultValue(const aValue: IdeList);
  property ResultValue: IdeList
   read Get_ResultValue
   write Set_ResultValue;
 end;//IQuery_GetList_Params

 Op_Query_GetList = class
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
  ['{F5C53356-3803-4BE6-A8BA-D6693C6C3F73}']
  function Get_Filter: IFilterFromQuery;
  function Get_ResultValue: Boolean;
  procedure Set_ResultValue(aValue: Boolean);
  property Filter: IFilterFromQuery
   read Get_Filter;
  property ResultValue: Boolean
   read Get_ResultValue
   write Set_ResultValue;
 end;//IFilterable_Add_Params

 Op_Filterable_Add = class
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
  ['{CE5EC919-6061-42DF-BAAC-01ADDDB5CBE8}']
  function Get_Filter: IFilterFromQuery;
  function Get_ResultValue: Boolean;
  procedure Set_ResultValue(aValue: Boolean);
  property Filter: IFilterFromQuery
   read Get_Filter;
  property ResultValue: Boolean
   read Get_ResultValue
   write Set_ResultValue;
 end;//IFilterable_Delete_Params

 Op_Filterable_Delete = class
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

 Op_Filterable_ClearAll = class
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
  ['{6F9614A1-47A1-4A29-A125-F9F9FC0AC5EB}']
  function Get_ResultValue: Boolean;
  procedure Set_ResultValue(aValue: Boolean);
  property ResultValue: Boolean
   read Get_ResultValue
   write Set_ResultValue;
 end;//IFilterable_Refresh_Params

 Op_Filterable_Refresh = class
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
  ['{6789D87F-5CEF-4D43-B4EE-4DDA12413BC8}']
  function Get_ResultValue: TbsListType;
  procedure Set_ResultValue(aValue: TbsListType);
  property ResultValue: TbsListType
   read Get_ResultValue
   write Set_ResultValue;
 end;//IFilterable_GetListType_Params

 Op_Filterable_GetListType = class
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
  ['{AB4CA4EA-BC8F-4217-B8CF-DDFCF17F2597}']
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

 Op_Loadable_Load = class
  {* Класс для вызова операции Loadable.Load }
  public
   class function Call(const aTarget: IvcmEntity;
    const aNode: IeeNode;
    const aData: IUnknown;
    anOp: TListLogicOperation = nsTypes.LLO_NONE): Boolean; overload;
    {* Вызов операции Loadable.Load у сущности }
   class function Call(const aTarget: IvcmAggregate;
    const aNode: IeeNode;
    const aData: IUnknown;
    anOp: TListLogicOperation = nsTypes.LLO_NONE): Boolean; overload;
    {* Вызов операции Loadable.Load у агрегации }
   class function Call(const aTarget: IvcmEntityForm;
    const aNode: IeeNode;
    const aData: IUnknown;
    anOp: TListLogicOperation = nsTypes.LLO_NONE): Boolean; overload;
    {* Вызов операции Loadable.Load у формы }
   class function Call(const aTarget: IvcmContainer;
    const aNode: IeeNode;
    const aData: IUnknown;
    anOp: TListLogicOperation = nsTypes.LLO_NONE): Boolean; overload;
    {* Вызов операции Loadable.Load у контейнера }
 end;//Op_Loadable_Load

 {$If NOT Defined(Monitorings)}
 IFilters_GetSelected_Params = interface
  {* Параметры для операции Filters.GetSelected }
  ['{45EE1347-680F-49EE-8526-218AE70AC824}']
  function Get_ResultValue: IFiltersFromQuery;
  procedure Set_ResultValue(const aValue: IFiltersFromQuery);
  property ResultValue: IFiltersFromQuery
   read Get_ResultValue
   write Set_ResultValue;
 end;//IFilters_GetSelected_Params
 {$IfEnd} // NOT Defined(Monitorings)

 {$If NOT Defined(Monitorings)}
 Op_Filters_GetSelected = class
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

 Op_SearchParameter_QueryNotSaved = class
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

 Op_SearchParameter_ClearMistakes = class
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

 Op_SearchParameter_QuerySaved = class
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

 Op_PrintParams_UpdatePrinter = class
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

 Op_List_SetNewContent = class
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
{$IfEnd} // NOT Defined(Admin)

implementation

{$If NOT Defined(Admin)}
uses
 l3ImplUses
 , l3CProtoObject
;

type
 TQuery_ClearAll_Params = class(Tl3CProtoObject, IQuery_ClearAll_Params)
  {* Реализация IQuery_ClearAll_Params }
  private
   f_NotClearRange: Boolean;
  protected
   function Get_NotClearRange: Boolean;
  public
   constructor Create(aNotClearRange: Boolean); reintroduce;
    {* Конструктор TQuery_ClearAll_Params }
   class function Make(aNotClearRange: Boolean): IQuery_ClearAll_Params; reintroduce;
    {* Фабрика TQuery_ClearAll_Params }
 end;//TQuery_ClearAll_Params

 TQuery_SetList_Params = class(Tl3CProtoObject, IQuery_SetList_Params)
  {* Реализация IQuery_SetList_Params }
  private
   f_List: IdeList;
   f_InList: Boolean;
  protected
   function Get_InList: Boolean;
   function Get_List: IdeList;
   procedure ClearFields; override;
  public
   constructor Create(const aList: IdeList;
    aInList: Boolean); reintroduce;
    {* Конструктор TQuery_SetList_Params }
   class function Make(const aList: IdeList;
    aInList: Boolean): IQuery_SetList_Params; reintroduce;
    {* Фабрика TQuery_SetList_Params }
 end;//TQuery_SetList_Params

 TQuery_GetList_Params = class(Tl3CProtoObject, IQuery_GetList_Params)
  {* Реализация IQuery_GetList_Params }
  private
   f_ResultValue: IdeList;
  protected
   function Get_ResultValue: IdeList;
   procedure Set_ResultValue(const aValue: IdeList);
   procedure ClearFields; override;
  public
   constructor Create; reintroduce;
    {* Конструктор TQuery_GetList_Params }
   class function Make: IQuery_GetList_Params; reintroduce;
    {* Фабрика TQuery_GetList_Params }
 end;//TQuery_GetList_Params

 TFilterable_Add_Params = class(Tl3CProtoObject, IFilterable_Add_Params)
  {* Реализация IFilterable_Add_Params }
  private
   f_Filter: IFilterFromQuery;
   f_ResultValue: Boolean;
  protected
   function Get_ResultValue: Boolean;
   procedure Set_ResultValue(aValue: Boolean);
   function Get_Filter: IFilterFromQuery;
   procedure ClearFields; override;
  public
   constructor Create(const aFilter: IFilterFromQuery); reintroduce;
    {* Конструктор TFilterable_Add_Params }
   class function Make(const aFilter: IFilterFromQuery): IFilterable_Add_Params; reintroduce;
    {* Фабрика TFilterable_Add_Params }
 end;//TFilterable_Add_Params

 TFilterable_Delete_Params = class(Tl3CProtoObject, IFilterable_Delete_Params)
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
    {* Конструктор TFilterable_Delete_Params }
   class function Make(const aFilter: IFilterFromQuery): IFilterable_Delete_Params; reintroduce;
    {* Фабрика TFilterable_Delete_Params }
 end;//TFilterable_Delete_Params

 TFilterable_Refresh_Params = class(Tl3CProtoObject, IFilterable_Refresh_Params)
  {* Реализация IFilterable_Refresh_Params }
  private
   f_ResultValue: Boolean;
  protected
   function Get_ResultValue: Boolean;
   procedure Set_ResultValue(aValue: Boolean);
  public
   constructor Create; reintroduce;
    {* Конструктор TFilterable_Refresh_Params }
   class function Make: IFilterable_Refresh_Params; reintroduce;
    {* Фабрика TFilterable_Refresh_Params }
 end;//TFilterable_Refresh_Params

 TFilterable_GetListType_Params = class(Tl3CProtoObject, IFilterable_GetListType_Params)
  {* Реализация IFilterable_GetListType_Params }
  private
   f_ResultValue: TbsListType;
  protected
   function Get_ResultValue: TbsListType;
   procedure Set_ResultValue(aValue: TbsListType);
  public
   constructor Create; reintroduce;
    {* Конструктор TFilterable_GetListType_Params }
   class function Make: IFilterable_GetListType_Params; reintroduce;
    {* Фабрика TFilterable_GetListType_Params }
 end;//TFilterable_GetListType_Params

 TLoadable_Load_Params = class(Tl3CProtoObject, ILoadable_Load_Params)
  {* Реализация ILoadable_Load_Params }
  private
   f_Node: IeeNode;
   f_Data: IUnknown;
   f_nOp: TListLogicOperation;
   f_ResultValue: Boolean;
  protected
   function Get_Node: IeeNode;
   function Get_ResultValue: Boolean;
   procedure Set_ResultValue(aValue: Boolean);
   function Get_Data: IUnknown;
   function Get_nOp: TListLogicOperation;
   procedure ClearFields; override;
  public
   constructor Create(const aNode: IeeNode;
    const aData: IUnknown;
    anOp: TListLogicOperation); reintroduce;
    {* Конструктор TLoadable_Load_Params }
   class function Make(const aNode: IeeNode;
    const aData: IUnknown;
    anOp: TListLogicOperation): ILoadable_Load_Params; reintroduce;
    {* Фабрика TLoadable_Load_Params }
 end;//TLoadable_Load_Params

 {$If NOT Defined(Monitorings)}
 TFilters_GetSelected_Params = class(Tl3CProtoObject, IFilters_GetSelected_Params)
  {* Реализация IFilters_GetSelected_Params }
  private
   f_ResultValue: IFiltersFromQuery;
  protected
   function Get_ResultValue: IFiltersFromQuery;
   procedure Set_ResultValue(const aValue: IFiltersFromQuery);
   procedure ClearFields; override;
  public
   constructor Create; reintroduce;
    {* Конструктор TFilters_GetSelected_Params }
   class function Make: IFilters_GetSelected_Params; reintroduce;
    {* Фабрика TFilters_GetSelected_Params }
 end;//TFilters_GetSelected_Params
 {$IfEnd} // NOT Defined(Monitorings)

constructor TQuery_ClearAll_Params.Create(aNotClearRange: Boolean);
 {* Конструктор TQuery_ClearAll_Params }
//#UC START# *4B0B81A55684_26380E83DA44_var*
//#UC END# *4B0B81A55684_26380E83DA44_var*
begin
//#UC START# *4B0B81A55684_26380E83DA44_impl*
 !!! Needs to be implemented !!!
//#UC END# *4B0B81A55684_26380E83DA44_impl*
end;//TQuery_ClearAll_Params.Create

class function TQuery_ClearAll_Params.Make(aNotClearRange: Boolean): IQuery_ClearAll_Params;
 {* Фабрика TQuery_ClearAll_Params }
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
//#UC START# *F84BBDD03F94_26380E83DA44get_var*
//#UC END# *F84BBDD03F94_26380E83DA44get_var*
begin
//#UC START# *F84BBDD03F94_26380E83DA44get_impl*
 !!! Needs to be implemented !!!
//#UC END# *F84BBDD03F94_26380E83DA44get_impl*
end;//TQuery_ClearAll_Params.Get_NotClearRange

class function Op_Query_ClearAll.Call(const aTarget: IvcmEntity;
 aNotClearRange: Boolean): Boolean;
 {* Вызов операции Query.ClearAll у сущности }
//#UC START# *AA5A14682839_AF22D56472D6_var*
//#UC END# *AA5A14682839_AF22D56472D6_var*
begin
//#UC START# *AA5A14682839_AF22D56472D6_impl*
 !!! Needs to be implemented !!!
//#UC END# *AA5A14682839_AF22D56472D6_impl*
end;//Op_Query_ClearAll.Call

class function Op_Query_ClearAll.Call(const aTarget: IvcmAggregate;
 aNotClearRange: Boolean): Boolean;
 {* Вызов операции Query.ClearAll у агрегации }
//#UC START# *DA99D457B289_AF22D56472D6_var*
//#UC END# *DA99D457B289_AF22D56472D6_var*
begin
//#UC START# *DA99D457B289_AF22D56472D6_impl*
 !!! Needs to be implemented !!!
//#UC END# *DA99D457B289_AF22D56472D6_impl*
end;//Op_Query_ClearAll.Call

class function Op_Query_ClearAll.Call(const aTarget: IvcmEntityForm;
 aNotClearRange: Boolean): Boolean;
 {* Вызов операции Query.ClearAll у формы }
//#UC START# *2C6B6C415996_AF22D56472D6_var*
//#UC END# *2C6B6C415996_AF22D56472D6_var*
begin
//#UC START# *2C6B6C415996_AF22D56472D6_impl*
 !!! Needs to be implemented !!!
//#UC END# *2C6B6C415996_AF22D56472D6_impl*
end;//Op_Query_ClearAll.Call

class function Op_Query_ClearAll.Call(const aTarget: IvcmContainer;
 aNotClearRange: Boolean): Boolean;
 {* Вызов операции Query.ClearAll у контейнера }
//#UC START# *E1C53C709F87_AF22D56472D6_var*
//#UC END# *E1C53C709F87_AF22D56472D6_var*
begin
//#UC START# *E1C53C709F87_AF22D56472D6_impl*
 !!! Needs to be implemented !!!
//#UC END# *E1C53C709F87_AF22D56472D6_impl*
end;//Op_Query_ClearAll.Call

constructor TQuery_SetList_Params.Create(const aList: IdeList;
 aInList: Boolean);
 {* Конструктор TQuery_SetList_Params }
//#UC START# *F9EA34A79D53_0527389BF9CC_var*
//#UC END# *F9EA34A79D53_0527389BF9CC_var*
begin
//#UC START# *F9EA34A79D53_0527389BF9CC_impl*
 !!! Needs to be implemented !!!
//#UC END# *F9EA34A79D53_0527389BF9CC_impl*
end;//TQuery_SetList_Params.Create

class function TQuery_SetList_Params.Make(const aList: IdeList;
 aInList: Boolean): IQuery_SetList_Params;
 {* Фабрика TQuery_SetList_Params }
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

function TQuery_SetList_Params.Get_InList: Boolean;
//#UC START# *1B80B489B34E_0527389BF9CCget_var*
//#UC END# *1B80B489B34E_0527389BF9CCget_var*
begin
//#UC START# *1B80B489B34E_0527389BF9CCget_impl*
 !!! Needs to be implemented !!!
//#UC END# *1B80B489B34E_0527389BF9CCget_impl*
end;//TQuery_SetList_Params.Get_InList

function TQuery_SetList_Params.Get_List: IdeList;
//#UC START# *4ADE45A30772_0527389BF9CCget_var*
//#UC END# *4ADE45A30772_0527389BF9CCget_var*
begin
//#UC START# *4ADE45A30772_0527389BF9CCget_impl*
 !!! Needs to be implemented !!!
//#UC END# *4ADE45A30772_0527389BF9CCget_impl*
end;//TQuery_SetList_Params.Get_List

procedure TQuery_SetList_Params.ClearFields;
begin
 f_List := nil;
 inherited;
end;//TQuery_SetList_Params.ClearFields

class function Op_Query_SetList.Call(const aTarget: IvcmEntity;
 const aList: IdeList;
 aInList: Boolean): Boolean;
 {* Вызов операции Query.SetList у сущности }
//#UC START# *6AD1C03C3FB3_F943B05D3AA0_var*
//#UC END# *6AD1C03C3FB3_F943B05D3AA0_var*
begin
//#UC START# *6AD1C03C3FB3_F943B05D3AA0_impl*
 !!! Needs to be implemented !!!
//#UC END# *6AD1C03C3FB3_F943B05D3AA0_impl*
end;//Op_Query_SetList.Call

class function Op_Query_SetList.Call(const aTarget: IvcmAggregate;
 const aList: IdeList;
 aInList: Boolean): Boolean;
 {* Вызов операции Query.SetList у агрегации }
//#UC START# *9B11802ACA03_F943B05D3AA0_var*
//#UC END# *9B11802ACA03_F943B05D3AA0_var*
begin
//#UC START# *9B11802ACA03_F943B05D3AA0_impl*
 !!! Needs to be implemented !!!
//#UC END# *9B11802ACA03_F943B05D3AA0_impl*
end;//Op_Query_SetList.Call

class function Op_Query_SetList.Call(const aTarget: IvcmEntityForm;
 const aList: IdeList;
 aInList: Boolean): Boolean;
 {* Вызов операции Query.SetList у формы }
//#UC START# *38B33B5801A6_F943B05D3AA0_var*
//#UC END# *38B33B5801A6_F943B05D3AA0_var*
begin
//#UC START# *38B33B5801A6_F943B05D3AA0_impl*
 !!! Needs to be implemented !!!
//#UC END# *38B33B5801A6_F943B05D3AA0_impl*
end;//Op_Query_SetList.Call

class function Op_Query_SetList.Call(const aTarget: IvcmContainer;
 const aList: IdeList;
 aInList: Boolean): Boolean;
 {* Вызов операции Query.SetList у контейнера }
//#UC START# *5A2026DB8504_F943B05D3AA0_var*
//#UC END# *5A2026DB8504_F943B05D3AA0_var*
begin
//#UC START# *5A2026DB8504_F943B05D3AA0_impl*
 !!! Needs to be implemented !!!
//#UC END# *5A2026DB8504_F943B05D3AA0_impl*
end;//Op_Query_SetList.Call

constructor TQuery_GetList_Params.Create;
 {* Конструктор TQuery_GetList_Params }
//#UC START# *985895464316_91596A0DE58C_var*
//#UC END# *985895464316_91596A0DE58C_var*
begin
//#UC START# *985895464316_91596A0DE58C_impl*
 !!! Needs to be implemented !!!
//#UC END# *985895464316_91596A0DE58C_impl*
end;//TQuery_GetList_Params.Create

class function TQuery_GetList_Params.Make: IQuery_GetList_Params;
 {* Фабрика TQuery_GetList_Params }
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
//#UC START# *8776CEB648C1_91596A0DE58Cget_var*
//#UC END# *8776CEB648C1_91596A0DE58Cget_var*
begin
//#UC START# *8776CEB648C1_91596A0DE58Cget_impl*
 !!! Needs to be implemented !!!
//#UC END# *8776CEB648C1_91596A0DE58Cget_impl*
end;//TQuery_GetList_Params.Get_ResultValue

procedure TQuery_GetList_Params.Set_ResultValue(const aValue: IdeList);
//#UC START# *8776CEB648C1_91596A0DE58Cset_var*
//#UC END# *8776CEB648C1_91596A0DE58Cset_var*
begin
//#UC START# *8776CEB648C1_91596A0DE58Cset_impl*
 !!! Needs to be implemented !!!
//#UC END# *8776CEB648C1_91596A0DE58Cset_impl*
end;//TQuery_GetList_Params.Set_ResultValue

procedure TQuery_GetList_Params.ClearFields;
begin
 f_ResultValue := nil;
 inherited;
end;//TQuery_GetList_Params.ClearFields

class function Op_Query_GetList.Call(const aTarget: IvcmEntity): IdeList;
 {* Вызов операции Query.GetList у сущности }
//#UC START# *4974D3E91A9B_C293BA5D4F59_var*
//#UC END# *4974D3E91A9B_C293BA5D4F59_var*
begin
//#UC START# *4974D3E91A9B_C293BA5D4F59_impl*
 !!! Needs to be implemented !!!
//#UC END# *4974D3E91A9B_C293BA5D4F59_impl*
end;//Op_Query_GetList.Call

class function Op_Query_GetList.Call(const aTarget: IvcmAggregate): IdeList;
 {* Вызов операции Query.GetList у агрегации }
//#UC START# *2C7890CCA4EC_C293BA5D4F59_var*
//#UC END# *2C7890CCA4EC_C293BA5D4F59_var*
begin
//#UC START# *2C7890CCA4EC_C293BA5D4F59_impl*
 !!! Needs to be implemented !!!
//#UC END# *2C7890CCA4EC_C293BA5D4F59_impl*
end;//Op_Query_GetList.Call

class function Op_Query_GetList.Call(const aTarget: IvcmEntityForm): IdeList;
 {* Вызов операции Query.GetList у формы }
//#UC START# *E8AB84B99857_C293BA5D4F59_var*
//#UC END# *E8AB84B99857_C293BA5D4F59_var*
begin
//#UC START# *E8AB84B99857_C293BA5D4F59_impl*
 !!! Needs to be implemented !!!
//#UC END# *E8AB84B99857_C293BA5D4F59_impl*
end;//Op_Query_GetList.Call

class function Op_Query_GetList.Call(const aTarget: IvcmContainer): IdeList;
 {* Вызов операции Query.GetList у контейнера }
//#UC START# *D0BC1262EB0D_C293BA5D4F59_var*
//#UC END# *D0BC1262EB0D_C293BA5D4F59_var*
begin
//#UC START# *D0BC1262EB0D_C293BA5D4F59_impl*
 !!! Needs to be implemented !!!
//#UC END# *D0BC1262EB0D_C293BA5D4F59_impl*
end;//Op_Query_GetList.Call

constructor TFilterable_Add_Params.Create(const aFilter: IFilterFromQuery);
 {* Конструктор TFilterable_Add_Params }
//#UC START# *DFDFD80C8371_BCE5C0A2AB61_var*
//#UC END# *DFDFD80C8371_BCE5C0A2AB61_var*
begin
//#UC START# *DFDFD80C8371_BCE5C0A2AB61_impl*
 !!! Needs to be implemented !!!
//#UC END# *DFDFD80C8371_BCE5C0A2AB61_impl*
end;//TFilterable_Add_Params.Create

class function TFilterable_Add_Params.Make(const aFilter: IFilterFromQuery): IFilterable_Add_Params;
 {* Фабрика TFilterable_Add_Params }
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

function TFilterable_Add_Params.Get_ResultValue: Boolean;
//#UC START# *6F2956910C17_BCE5C0A2AB61get_var*
//#UC END# *6F2956910C17_BCE5C0A2AB61get_var*
begin
//#UC START# *6F2956910C17_BCE5C0A2AB61get_impl*
 !!! Needs to be implemented !!!
//#UC END# *6F2956910C17_BCE5C0A2AB61get_impl*
end;//TFilterable_Add_Params.Get_ResultValue

procedure TFilterable_Add_Params.Set_ResultValue(aValue: Boolean);
//#UC START# *6F2956910C17_BCE5C0A2AB61set_var*
//#UC END# *6F2956910C17_BCE5C0A2AB61set_var*
begin
//#UC START# *6F2956910C17_BCE5C0A2AB61set_impl*
 !!! Needs to be implemented !!!
//#UC END# *6F2956910C17_BCE5C0A2AB61set_impl*
end;//TFilterable_Add_Params.Set_ResultValue

function TFilterable_Add_Params.Get_Filter: IFilterFromQuery;
//#UC START# *B0302A564BD0_BCE5C0A2AB61get_var*
//#UC END# *B0302A564BD0_BCE5C0A2AB61get_var*
begin
//#UC START# *B0302A564BD0_BCE5C0A2AB61get_impl*
 !!! Needs to be implemented !!!
//#UC END# *B0302A564BD0_BCE5C0A2AB61get_impl*
end;//TFilterable_Add_Params.Get_Filter

procedure TFilterable_Add_Params.ClearFields;
begin
 f_Filter := nil;
 inherited;
end;//TFilterable_Add_Params.ClearFields

class function Op_Filterable_Add.Call(const aTarget: IvcmEntity;
 const aFilter: IFilterFromQuery): Boolean;
 {* Вызов операции Filterable.Add у сущности }
//#UC START# *483AF9E6B196_28D03FE2C7BD_var*
//#UC END# *483AF9E6B196_28D03FE2C7BD_var*
begin
//#UC START# *483AF9E6B196_28D03FE2C7BD_impl*
 !!! Needs to be implemented !!!
//#UC END# *483AF9E6B196_28D03FE2C7BD_impl*
end;//Op_Filterable_Add.Call

class function Op_Filterable_Add.Call(const aTarget: IvcmAggregate;
 const aFilter: IFilterFromQuery): Boolean;
 {* Вызов операции Filterable.Add у агрегации }
//#UC START# *787AB9D63BE6_28D03FE2C7BD_var*
//#UC END# *787AB9D63BE6_28D03FE2C7BD_var*
begin
//#UC START# *787AB9D63BE6_28D03FE2C7BD_impl*
 !!! Needs to be implemented !!!
//#UC END# *787AB9D63BE6_28D03FE2C7BD_impl*
end;//Op_Filterable_Add.Call

class function Op_Filterable_Add.Call(const aTarget: IvcmEntityForm;
 const aFilter: IFilterFromQuery): Boolean;
 {* Вызов операции Filterable.Add у формы }
//#UC START# *74EE31B6C21B_28D03FE2C7BD_var*
//#UC END# *74EE31B6C21B_28D03FE2C7BD_var*
begin
//#UC START# *74EE31B6C21B_28D03FE2C7BD_impl*
 !!! Needs to be implemented !!!
//#UC END# *74EE31B6C21B_28D03FE2C7BD_impl*
end;//Op_Filterable_Add.Call

class function Op_Filterable_Add.Call(const aTarget: IvcmContainer;
 const aFilter: IFilterFromQuery): Boolean;
 {* Вызов операции Filterable.Add у контейнера }
//#UC START# *5E62F21A402B_28D03FE2C7BD_var*
//#UC END# *5E62F21A402B_28D03FE2C7BD_var*
begin
//#UC START# *5E62F21A402B_28D03FE2C7BD_impl*
 !!! Needs to be implemented !!!
//#UC END# *5E62F21A402B_28D03FE2C7BD_impl*
end;//Op_Filterable_Add.Call

constructor TFilterable_Delete_Params.Create(const aFilter: IFilterFromQuery);
 {* Конструктор TFilterable_Delete_Params }
//#UC START# *ECB894B739F7_3DC7EADDB21D_var*
//#UC END# *ECB894B739F7_3DC7EADDB21D_var*
begin
//#UC START# *ECB894B739F7_3DC7EADDB21D_impl*
 !!! Needs to be implemented !!!
//#UC END# *ECB894B739F7_3DC7EADDB21D_impl*
end;//TFilterable_Delete_Params.Create

class function TFilterable_Delete_Params.Make(const aFilter: IFilterFromQuery): IFilterable_Delete_Params;
 {* Фабрика TFilterable_Delete_Params }
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
//#UC START# *154DBFBF4A65_3DC7EADDB21Dget_var*
//#UC END# *154DBFBF4A65_3DC7EADDB21Dget_var*
begin
//#UC START# *154DBFBF4A65_3DC7EADDB21Dget_impl*
 !!! Needs to be implemented !!!
//#UC END# *154DBFBF4A65_3DC7EADDB21Dget_impl*
end;//TFilterable_Delete_Params.Get_Filter

function TFilterable_Delete_Params.Get_ResultValue: Boolean;
//#UC START# *75CABD471215_3DC7EADDB21Dget_var*
//#UC END# *75CABD471215_3DC7EADDB21Dget_var*
begin
//#UC START# *75CABD471215_3DC7EADDB21Dget_impl*
 !!! Needs to be implemented !!!
//#UC END# *75CABD471215_3DC7EADDB21Dget_impl*
end;//TFilterable_Delete_Params.Get_ResultValue

procedure TFilterable_Delete_Params.Set_ResultValue(aValue: Boolean);
//#UC START# *75CABD471215_3DC7EADDB21Dset_var*
//#UC END# *75CABD471215_3DC7EADDB21Dset_var*
begin
//#UC START# *75CABD471215_3DC7EADDB21Dset_impl*
 !!! Needs to be implemented !!!
//#UC END# *75CABD471215_3DC7EADDB21Dset_impl*
end;//TFilterable_Delete_Params.Set_ResultValue

procedure TFilterable_Delete_Params.ClearFields;
begin
 f_Filter := nil;
 inherited;
end;//TFilterable_Delete_Params.ClearFields

class function Op_Filterable_Delete.Call(const aTarget: IvcmEntity;
 const aFilter: IFilterFromQuery): Boolean;
 {* Вызов операции Filterable.Delete у сущности }
//#UC START# *BA7B6FA09D05_DD4274BF7286_var*
//#UC END# *BA7B6FA09D05_DD4274BF7286_var*
begin
//#UC START# *BA7B6FA09D05_DD4274BF7286_impl*
 !!! Needs to be implemented !!!
//#UC END# *BA7B6FA09D05_DD4274BF7286_impl*
end;//Op_Filterable_Delete.Call

class function Op_Filterable_Delete.Call(const aTarget: IvcmAggregate;
 const aFilter: IFilterFromQuery): Boolean;
 {* Вызов операции Filterable.Delete у агрегации }
//#UC START# *EABB2F8F2755_DD4274BF7286_var*
//#UC END# *EABB2F8F2755_DD4274BF7286_var*
begin
//#UC START# *EABB2F8F2755_DD4274BF7286_impl*
 !!! Needs to be implemented !!!
//#UC END# *EABB2F8F2755_DD4274BF7286_impl*
end;//Op_Filterable_Delete.Call

class function Op_Filterable_Delete.Call(const aTarget: IvcmEntityForm;
 const aFilter: IFilterFromQuery): Boolean;
 {* Вызов операции Filterable.Delete у формы }
//#UC START# *8F4E1715FE92_DD4274BF7286_var*
//#UC END# *8F4E1715FE92_DD4274BF7286_var*
begin
//#UC START# *8F4E1715FE92_DD4274BF7286_impl*
 !!! Needs to be implemented !!!
//#UC END# *8F4E1715FE92_DD4274BF7286_impl*
end;//Op_Filterable_Delete.Call

class function Op_Filterable_Delete.Call(const aTarget: IvcmContainer;
 const aFilter: IFilterFromQuery): Boolean;
 {* Вызов операции Filterable.Delete у контейнера }
//#UC START# *1DFCDA920C0A_DD4274BF7286_var*
//#UC END# *1DFCDA920C0A_DD4274BF7286_var*
begin
//#UC START# *1DFCDA920C0A_DD4274BF7286_impl*
 !!! Needs to be implemented !!!
//#UC END# *1DFCDA920C0A_DD4274BF7286_impl*
end;//Op_Filterable_Delete.Call

class function Op_Filterable_ClearAll.Call(const aTarget: IvcmEntity): Boolean;
 {* Вызов операции Filterable.ClearAll у сущности }
//#UC START# *B1D92B2753F0_C53C53060F28_var*
//#UC END# *B1D92B2753F0_C53C53060F28_var*
begin
//#UC START# *B1D92B2753F0_C53C53060F28_impl*
 !!! Needs to be implemented !!!
//#UC END# *B1D92B2753F0_C53C53060F28_impl*
end;//Op_Filterable_ClearAll.Call

class function Op_Filterable_ClearAll.Call(const aTarget: IvcmAggregate): Boolean;
 {* Вызов операции Filterable.ClearAll у агрегации }
//#UC START# *E218EB15DE40_C53C53060F28_var*
//#UC END# *E218EB15DE40_C53C53060F28_var*
begin
//#UC START# *E218EB15DE40_C53C53060F28_impl*
 !!! Needs to be implemented !!!
//#UC END# *E218EB15DE40_C53C53060F28_impl*
end;//Op_Filterable_ClearAll.Call

class function Op_Filterable_ClearAll.Call(const aTarget: IvcmEntityForm): Boolean;
 {* Вызов операции Filterable.ClearAll у формы }
//#UC START# *C0CDDB8CB55B_C53C53060F28_var*
//#UC END# *C0CDDB8CB55B_C53C53060F28_var*
begin
//#UC START# *C0CDDB8CB55B_C53C53060F28_impl*
 !!! Needs to be implemented !!!
//#UC END# *C0CDDB8CB55B_C53C53060F28_impl*
end;//Op_Filterable_ClearAll.Call

class function Op_Filterable_ClearAll.Call(const aTarget: IvcmContainer): Boolean;
 {* Вызов операции Filterable.ClearAll у контейнера }
//#UC START# *DB48ACC9905D_C53C53060F28_var*
//#UC END# *DB48ACC9905D_C53C53060F28_var*
begin
//#UC START# *DB48ACC9905D_C53C53060F28_impl*
 !!! Needs to be implemented !!!
//#UC END# *DB48ACC9905D_C53C53060F28_impl*
end;//Op_Filterable_ClearAll.Call

constructor TFilterable_Refresh_Params.Create;
 {* Конструктор TFilterable_Refresh_Params }
//#UC START# *CA1CA04931DA_C7169C345BA0_var*
//#UC END# *CA1CA04931DA_C7169C345BA0_var*
begin
//#UC START# *CA1CA04931DA_C7169C345BA0_impl*
 !!! Needs to be implemented !!!
//#UC END# *CA1CA04931DA_C7169C345BA0_impl*
end;//TFilterable_Refresh_Params.Create

class function TFilterable_Refresh_Params.Make: IFilterable_Refresh_Params;
 {* Фабрика TFilterable_Refresh_Params }
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
//#UC START# *9C4792A97B5B_C7169C345BA0get_var*
//#UC END# *9C4792A97B5B_C7169C345BA0get_var*
begin
//#UC START# *9C4792A97B5B_C7169C345BA0get_impl*
 !!! Needs to be implemented !!!
//#UC END# *9C4792A97B5B_C7169C345BA0get_impl*
end;//TFilterable_Refresh_Params.Get_ResultValue

procedure TFilterable_Refresh_Params.Set_ResultValue(aValue: Boolean);
//#UC START# *9C4792A97B5B_C7169C345BA0set_var*
//#UC END# *9C4792A97B5B_C7169C345BA0set_var*
begin
//#UC START# *9C4792A97B5B_C7169C345BA0set_impl*
 !!! Needs to be implemented !!!
//#UC END# *9C4792A97B5B_C7169C345BA0set_impl*
end;//TFilterable_Refresh_Params.Set_ResultValue

class function Op_Filterable_Refresh.Call(const aTarget: IvcmEntity): Boolean;
 {* Вызов операции Filterable.Refresh у сущности }
//#UC START# *3EB17DD0346B_5FF6726F2A10_var*
//#UC END# *3EB17DD0346B_5FF6726F2A10_var*
begin
//#UC START# *3EB17DD0346B_5FF6726F2A10_impl*
 !!! Needs to be implemented !!!
//#UC END# *3EB17DD0346B_5FF6726F2A10_impl*
end;//Op_Filterable_Refresh.Call

class function Op_Filterable_Refresh.Call(const aTarget: IvcmAggregate): Boolean;
 {* Вызов операции Filterable.Refresh у агрегации }
//#UC START# *6EF13DBEBEBB_5FF6726F2A10_var*
//#UC END# *6EF13DBEBEBB_5FF6726F2A10_var*
begin
//#UC START# *6EF13DBEBEBB_5FF6726F2A10_impl*
 !!! Needs to be implemented !!!
//#UC END# *6EF13DBEBEBB_5FF6726F2A10_impl*
end;//Op_Filterable_Refresh.Call

class function Op_Filterable_Refresh.Call(const aTarget: IvcmEntityForm): Boolean;
 {* Вызов операции Filterable.Refresh у формы }
//#UC START# *1D473E14703C_5FF6726F2A10_var*
//#UC END# *1D473E14703C_5FF6726F2A10_var*
begin
//#UC START# *1D473E14703C_5FF6726F2A10_impl*
 !!! Needs to be implemented !!!
//#UC END# *1D473E14703C_5FF6726F2A10_impl*
end;//Op_Filterable_Refresh.Call

class function Op_Filterable_Refresh.Call(const aTarget: IvcmContainer): Boolean;
 {* Вызов операции Filterable.Refresh у контейнера }
//#UC START# *899325AB3D1A_5FF6726F2A10_var*
//#UC END# *899325AB3D1A_5FF6726F2A10_var*
begin
//#UC START# *899325AB3D1A_5FF6726F2A10_impl*
 !!! Needs to be implemented !!!
//#UC END# *899325AB3D1A_5FF6726F2A10_impl*
end;//Op_Filterable_Refresh.Call

constructor TFilterable_GetListType_Params.Create;
 {* Конструктор TFilterable_GetListType_Params }
//#UC START# *3419BA94AF0B_24D539CEBDE0_var*
//#UC END# *3419BA94AF0B_24D539CEBDE0_var*
begin
//#UC START# *3419BA94AF0B_24D539CEBDE0_impl*
 !!! Needs to be implemented !!!
//#UC END# *3419BA94AF0B_24D539CEBDE0_impl*
end;//TFilterable_GetListType_Params.Create

class function TFilterable_GetListType_Params.Make: IFilterable_GetListType_Params;
 {* Фабрика TFilterable_GetListType_Params }
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
//#UC START# *37E535CCE119_24D539CEBDE0get_var*
//#UC END# *37E535CCE119_24D539CEBDE0get_var*
begin
//#UC START# *37E535CCE119_24D539CEBDE0get_impl*
 !!! Needs to be implemented !!!
//#UC END# *37E535CCE119_24D539CEBDE0get_impl*
end;//TFilterable_GetListType_Params.Get_ResultValue

procedure TFilterable_GetListType_Params.Set_ResultValue(aValue: TbsListType);
//#UC START# *37E535CCE119_24D539CEBDE0set_var*
//#UC END# *37E535CCE119_24D539CEBDE0set_var*
begin
//#UC START# *37E535CCE119_24D539CEBDE0set_impl*
 !!! Needs to be implemented !!!
//#UC END# *37E535CCE119_24D539CEBDE0set_impl*
end;//TFilterable_GetListType_Params.Set_ResultValue

class function Op_Filterable_GetListType.Call(const aTarget: IvcmEntity): TbsListType;
 {* Вызов операции Filterable.GetListType у сущности }
//#UC START# *9A8CDB10DE70_4C841BEBC825_var*
//#UC END# *9A8CDB10DE70_4C841BEBC825_var*
begin
//#UC START# *9A8CDB10DE70_4C841BEBC825_impl*
 !!! Needs to be implemented !!!
//#UC END# *9A8CDB10DE70_4C841BEBC825_impl*
end;//Op_Filterable_GetListType.Call

class function Op_Filterable_GetListType.Call(const aTarget: IvcmAggregate): TbsListType;
 {* Вызов операции Filterable.GetListType у агрегации }
//#UC START# *CACC9B0068C0_4C841BEBC825_var*
//#UC END# *CACC9B0068C0_4C841BEBC825_var*
begin
//#UC START# *CACC9B0068C0_4C841BEBC825_impl*
 !!! Needs to be implemented !!!
//#UC END# *CACC9B0068C0_4C841BEBC825_impl*
end;//Op_Filterable_GetListType.Call

class function Op_Filterable_GetListType.Call(const aTarget: IvcmEntityForm): TbsListType;
 {* Вызов операции Filterable.GetListType у формы }
//#UC START# *61F5544DB1CE_4C841BEBC825_var*
//#UC END# *61F5544DB1CE_4C841BEBC825_var*
begin
//#UC START# *61F5544DB1CE_4C841BEBC825_impl*
 !!! Needs to be implemented !!!
//#UC END# *61F5544DB1CE_4C841BEBC825_impl*
end;//Op_Filterable_GetListType.Call

class function Op_Filterable_GetListType.Call(const aTarget: IvcmContainer): TbsListType;
 {* Вызов операции Filterable.GetListType у контейнера }
//#UC START# *6B91C9D5E47F_4C841BEBC825_var*
//#UC END# *6B91C9D5E47F_4C841BEBC825_var*
begin
//#UC START# *6B91C9D5E47F_4C841BEBC825_impl*
 !!! Needs to be implemented !!!
//#UC END# *6B91C9D5E47F_4C841BEBC825_impl*
end;//Op_Filterable_GetListType.Call

constructor TLoadable_Load_Params.Create(const aNode: IeeNode;
 const aData: IUnknown;
 anOp: TListLogicOperation);
 {* Конструктор TLoadable_Load_Params }
//#UC START# *F7AF7F0AB91D_FB0182F0ED90_var*
//#UC END# *F7AF7F0AB91D_FB0182F0ED90_var*
begin
//#UC START# *F7AF7F0AB91D_FB0182F0ED90_impl*
 !!! Needs to be implemented !!!
//#UC END# *F7AF7F0AB91D_FB0182F0ED90_impl*
end;//TLoadable_Load_Params.Create

class function TLoadable_Load_Params.Make(const aNode: IeeNode;
 const aData: IUnknown;
 anOp: TListLogicOperation): ILoadable_Load_Params;
 {* Фабрика TLoadable_Load_Params }
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
//#UC START# *0F66BD1D3613_FB0182F0ED90get_var*
//#UC END# *0F66BD1D3613_FB0182F0ED90get_var*
begin
//#UC START# *0F66BD1D3613_FB0182F0ED90get_impl*
 !!! Needs to be implemented !!!
//#UC END# *0F66BD1D3613_FB0182F0ED90get_impl*
end;//TLoadable_Load_Params.Get_Node

function TLoadable_Load_Params.Get_ResultValue: Boolean;
//#UC START# *3F4281AEF00F_FB0182F0ED90get_var*
//#UC END# *3F4281AEF00F_FB0182F0ED90get_var*
begin
//#UC START# *3F4281AEF00F_FB0182F0ED90get_impl*
 !!! Needs to be implemented !!!
//#UC END# *3F4281AEF00F_FB0182F0ED90get_impl*
end;//TLoadable_Load_Params.Get_ResultValue

procedure TLoadable_Load_Params.Set_ResultValue(aValue: Boolean);
//#UC START# *3F4281AEF00F_FB0182F0ED90set_var*
//#UC END# *3F4281AEF00F_FB0182F0ED90set_var*
begin
//#UC START# *3F4281AEF00F_FB0182F0ED90set_impl*
 !!! Needs to be implemented !!!
//#UC END# *3F4281AEF00F_FB0182F0ED90set_impl*
end;//TLoadable_Load_Params.Set_ResultValue

function TLoadable_Load_Params.Get_Data: IUnknown;
//#UC START# *B61D968AA3C8_FB0182F0ED90get_var*
//#UC END# *B61D968AA3C8_FB0182F0ED90get_var*
begin
//#UC START# *B61D968AA3C8_FB0182F0ED90get_impl*
 !!! Needs to be implemented !!!
//#UC END# *B61D968AA3C8_FB0182F0ED90get_impl*
end;//TLoadable_Load_Params.Get_Data

function TLoadable_Load_Params.Get_nOp: TListLogicOperation;
//#UC START# *BDC8C92C149D_FB0182F0ED90get_var*
//#UC END# *BDC8C92C149D_FB0182F0ED90get_var*
begin
//#UC START# *BDC8C92C149D_FB0182F0ED90get_impl*
 !!! Needs to be implemented !!!
//#UC END# *BDC8C92C149D_FB0182F0ED90get_impl*
end;//TLoadable_Load_Params.Get_nOp

procedure TLoadable_Load_Params.ClearFields;
begin
 f_Node := nil;
 f_Data := nil;
 inherited;
end;//TLoadable_Load_Params.ClearFields

class function Op_Loadable_Load.Call(const aTarget: IvcmEntity;
 const aNode: IeeNode;
 const aData: IUnknown;
 anOp: TListLogicOperation = nsTypes.LLO_NONE): Boolean;
 {* Вызов операции Loadable.Load у сущности }
//#UC START# *2AA9C5E3617A_D5342FDC6257_var*
//#UC END# *2AA9C5E3617A_D5342FDC6257_var*
begin
//#UC START# *2AA9C5E3617A_D5342FDC6257_impl*
 !!! Needs to be implemented !!!
//#UC END# *2AA9C5E3617A_D5342FDC6257_impl*
end;//Op_Loadable_Load.Call

class function Op_Loadable_Load.Call(const aTarget: IvcmAggregate;
 const aNode: IeeNode;
 const aData: IUnknown;
 anOp: TListLogicOperation = nsTypes.LLO_NONE): Boolean;
 {* Вызов операции Loadable.Load у агрегации }
//#UC START# *5AE985D1EBCA_D5342FDC6257_var*
//#UC END# *5AE985D1EBCA_D5342FDC6257_var*
begin
//#UC START# *5AE985D1EBCA_D5342FDC6257_impl*
 !!! Needs to be implemented !!!
//#UC END# *5AE985D1EBCA_D5342FDC6257_impl*
end;//Op_Loadable_Load.Call

class function Op_Loadable_Load.Call(const aTarget: IvcmEntityForm;
 const aNode: IeeNode;
 const aData: IUnknown;
 anOp: TListLogicOperation = nsTypes.LLO_NONE): Boolean;
 {* Вызов операции Loadable.Load у формы }
//#UC START# *7C79B405A668_D5342FDC6257_var*
//#UC END# *7C79B405A668_D5342FDC6257_var*
begin
//#UC START# *7C79B405A668_D5342FDC6257_impl*
 !!! Needs to be implemented !!!
//#UC END# *7C79B405A668_D5342FDC6257_impl*
end;//Op_Loadable_Load.Call

class function Op_Loadable_Load.Call(const aTarget: IvcmContainer;
 const aNode: IeeNode;
 const aData: IUnknown;
 anOp: TListLogicOperation = nsTypes.LLO_NONE): Boolean;
 {* Вызов операции Loadable.Load у контейнера }
//#UC START# *D84A269495D4_D5342FDC6257_var*
//#UC END# *D84A269495D4_D5342FDC6257_var*
begin
//#UC START# *D84A269495D4_D5342FDC6257_impl*
 !!! Needs to be implemented !!!
//#UC END# *D84A269495D4_D5342FDC6257_impl*
end;//Op_Loadable_Load.Call

{$If NOT Defined(Monitorings)}
constructor TFilters_GetSelected_Params.Create;
 {* Конструктор TFilters_GetSelected_Params }
//#UC START# *FD69D90EA0AA_FA17E90269B4_var*
//#UC END# *FD69D90EA0AA_FA17E90269B4_var*
begin
//#UC START# *FD69D90EA0AA_FA17E90269B4_impl*
 !!! Needs to be implemented !!!
//#UC END# *FD69D90EA0AA_FA17E90269B4_impl*
end;//TFilters_GetSelected_Params.Create

class function TFilters_GetSelected_Params.Make: IFilters_GetSelected_Params;
 {* Фабрика TFilters_GetSelected_Params }
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
//#UC START# *9E9C3B7101C7_FA17E90269B4get_var*
//#UC END# *9E9C3B7101C7_FA17E90269B4get_var*
begin
//#UC START# *9E9C3B7101C7_FA17E90269B4get_impl*
 !!! Needs to be implemented !!!
//#UC END# *9E9C3B7101C7_FA17E90269B4get_impl*
end;//TFilters_GetSelected_Params.Get_ResultValue

procedure TFilters_GetSelected_Params.Set_ResultValue(const aValue: IFiltersFromQuery);
//#UC START# *9E9C3B7101C7_FA17E90269B4set_var*
//#UC END# *9E9C3B7101C7_FA17E90269B4set_var*
begin
//#UC START# *9E9C3B7101C7_FA17E90269B4set_impl*
 !!! Needs to be implemented !!!
//#UC END# *9E9C3B7101C7_FA17E90269B4set_impl*
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
//#UC START# *2BFD88BD4C44_5412E29D88CA_var*
//#UC END# *2BFD88BD4C44_5412E29D88CA_var*
begin
//#UC START# *2BFD88BD4C44_5412E29D88CA_impl*
 !!! Needs to be implemented !!!
//#UC END# *2BFD88BD4C44_5412E29D88CA_impl*
end;//Op_Filters_GetSelected.Call

class function Op_Filters_GetSelected.Call(const aTarget: IvcmAggregate): IFiltersFromQuery;
 {* Вызов операции Filters.GetSelected у агрегации }
//#UC START# *5C3D48ABD694_5412E29D88CA_var*
//#UC END# *5C3D48ABD694_5412E29D88CA_var*
begin
//#UC START# *5C3D48ABD694_5412E29D88CA_impl*
 !!! Needs to be implemented !!!
//#UC END# *5C3D48ABD694_5412E29D88CA_impl*
end;//Op_Filters_GetSelected.Call

class function Op_Filters_GetSelected.Call(const aTarget: IvcmEntityForm): IFiltersFromQuery;
 {* Вызов операции Filters.GetSelected у формы }
//#UC START# *4278F3FECAD6_5412E29D88CA_var*
//#UC END# *4278F3FECAD6_5412E29D88CA_var*
begin
//#UC START# *4278F3FECAD6_5412E29D88CA_impl*
 !!! Needs to be implemented !!!
//#UC END# *4278F3FECAD6_5412E29D88CA_impl*
end;//Op_Filters_GetSelected.Call

class function Op_Filters_GetSelected.Call(const aTarget: IvcmContainer): IFiltersFromQuery;
 {* Вызов операции Filters.GetSelected у контейнера }
//#UC START# *411F034B11B9_5412E29D88CA_var*
//#UC END# *411F034B11B9_5412E29D88CA_var*
begin
//#UC START# *411F034B11B9_5412E29D88CA_impl*
 !!! Needs to be implemented !!!
//#UC END# *411F034B11B9_5412E29D88CA_impl*
end;//Op_Filters_GetSelected.Call
{$IfEnd} // NOT Defined(Monitorings)

class function Op_SearchParameter_QueryNotSaved.Call(const aTarget: IvcmEntity): Boolean;
 {* Вызов операции SearchParameter.QueryNotSaved у сущности }
//#UC START# *5DDE3D1661B8_0162D650D011_var*
//#UC END# *5DDE3D1661B8_0162D650D011_var*
begin
//#UC START# *5DDE3D1661B8_0162D650D011_impl*
 !!! Needs to be implemented !!!
//#UC END# *5DDE3D1661B8_0162D650D011_impl*
end;//Op_SearchParameter_QueryNotSaved.Call

class function Op_SearchParameter_QueryNotSaved.Call(const aTarget: IvcmAggregate): Boolean;
 {* Вызов операции SearchParameter.QueryNotSaved у агрегации }
//#UC START# *8E1DFD05EC08_0162D650D011_var*
//#UC END# *8E1DFD05EC08_0162D650D011_var*
begin
//#UC START# *8E1DFD05EC08_0162D650D011_impl*
 !!! Needs to be implemented !!!
//#UC END# *8E1DFD05EC08_0162D650D011_impl*
end;//Op_SearchParameter_QueryNotSaved.Call

class function Op_SearchParameter_QueryNotSaved.Call(const aTarget: IvcmEntityForm): Boolean;
 {* Вызов операции SearchParameter.QueryNotSaved у формы }
//#UC START# *296ACD2603A6_0162D650D011_var*
//#UC END# *296ACD2603A6_0162D650D011_var*
begin
//#UC START# *296ACD2603A6_0162D650D011_impl*
 !!! Needs to be implemented !!!
//#UC END# *296ACD2603A6_0162D650D011_impl*
end;//Op_SearchParameter_QueryNotSaved.Call

class function Op_SearchParameter_QueryNotSaved.Call(const aTarget: IvcmContainer): Boolean;
 {* Вызов операции SearchParameter.QueryNotSaved у контейнера }
//#UC START# *34D4CD1F3C0A_0162D650D011_var*
//#UC END# *34D4CD1F3C0A_0162D650D011_var*
begin
//#UC START# *34D4CD1F3C0A_0162D650D011_impl*
 !!! Needs to be implemented !!!
//#UC END# *34D4CD1F3C0A_0162D650D011_impl*
end;//Op_SearchParameter_QueryNotSaved.Call

class function Op_SearchParameter_ClearMistakes.Call(const aTarget: IvcmEntity): Boolean;
 {* Вызов операции SearchParameter.ClearMistakes у сущности }
//#UC START# *3E2264E33551_D46134017F77_var*
//#UC END# *3E2264E33551_D46134017F77_var*
begin
//#UC START# *3E2264E33551_D46134017F77_impl*
 !!! Needs to be implemented !!!
//#UC END# *3E2264E33551_D46134017F77_impl*
end;//Op_SearchParameter_ClearMistakes.Call

class function Op_SearchParameter_ClearMistakes.Call(const aTarget: IvcmAggregate): Boolean;
 {* Вызов операции SearchParameter.ClearMistakes у агрегации }
//#UC START# *6E6224D1BFA1_D46134017F77_var*
//#UC END# *6E6224D1BFA1_D46134017F77_var*
begin
//#UC START# *6E6224D1BFA1_D46134017F77_impl*
 !!! Needs to be implemented !!!
//#UC END# *6E6224D1BFA1_D46134017F77_impl*
end;//Op_SearchParameter_ClearMistakes.Call

class function Op_SearchParameter_ClearMistakes.Call(const aTarget: IvcmEntityForm): Boolean;
 {* Вызов операции SearchParameter.ClearMistakes у формы }
//#UC START# *0A6DA23005B9_D46134017F77_var*
//#UC END# *0A6DA23005B9_D46134017F77_var*
begin
//#UC START# *0A6DA23005B9_D46134017F77_impl*
 !!! Needs to be implemented !!!
//#UC END# *0A6DA23005B9_D46134017F77_impl*
end;//Op_SearchParameter_ClearMistakes.Call

class function Op_SearchParameter_ClearMistakes.Call(const aTarget: IvcmContainer): Boolean;
 {* Вызов операции SearchParameter.ClearMistakes у контейнера }
//#UC START# *339492F0CD95_D46134017F77_var*
//#UC END# *339492F0CD95_D46134017F77_var*
begin
//#UC START# *339492F0CD95_D46134017F77_impl*
 !!! Needs to be implemented !!!
//#UC END# *339492F0CD95_D46134017F77_impl*
end;//Op_SearchParameter_ClearMistakes.Call

class function Op_SearchParameter_QuerySaved.Call(const aTarget: IvcmEntity): Boolean;
 {* Вызов операции SearchParameter.QuerySaved у сущности }
//#UC START# *65DABB70416D_BC5EACC49125_var*
//#UC END# *65DABB70416D_BC5EACC49125_var*
begin
//#UC START# *65DABB70416D_BC5EACC49125_impl*
 !!! Needs to be implemented !!!
//#UC END# *65DABB70416D_BC5EACC49125_impl*
end;//Op_SearchParameter_QuerySaved.Call

class function Op_SearchParameter_QuerySaved.Call(const aTarget: IvcmAggregate): Boolean;
 {* Вызов операции SearchParameter.QuerySaved у агрегации }
//#UC START# *961A7B5ECBBD_BC5EACC49125_var*
//#UC END# *961A7B5ECBBD_BC5EACC49125_var*
begin
//#UC START# *961A7B5ECBBD_BC5EACC49125_impl*
 !!! Needs to be implemented !!!
//#UC END# *961A7B5ECBBD_BC5EACC49125_impl*
end;//Op_SearchParameter_QuerySaved.Call

class function Op_SearchParameter_QuerySaved.Call(const aTarget: IvcmEntityForm): Boolean;
 {* Вызов операции SearchParameter.QuerySaved у формы }
//#UC START# *4263FFCEEC3E_BC5EACC49125_var*
//#UC END# *4263FFCEEC3E_BC5EACC49125_var*
begin
//#UC START# *4263FFCEEC3E_BC5EACC49125_impl*
 !!! Needs to be implemented !!!
//#UC END# *4263FFCEEC3E_BC5EACC49125_impl*
end;//Op_SearchParameter_QuerySaved.Call

class function Op_SearchParameter_QuerySaved.Call(const aTarget: IvcmContainer): Boolean;
 {* Вызов операции SearchParameter.QuerySaved у контейнера }
//#UC START# *527559CE7E19_BC5EACC49125_var*
//#UC END# *527559CE7E19_BC5EACC49125_var*
begin
//#UC START# *527559CE7E19_BC5EACC49125_impl*
 !!! Needs to be implemented !!!
//#UC END# *527559CE7E19_BC5EACC49125_impl*
end;//Op_SearchParameter_QuerySaved.Call

class function Op_PrintParams_UpdatePrinter.Call(const aTarget: IvcmEntity): Boolean;
 {* Вызов операции PrintParams.UpdatePrinter у сущности }
//#UC START# *EDE528FAE008_5260E2A845F0_var*
//#UC END# *EDE528FAE008_5260E2A845F0_var*
begin
//#UC START# *EDE528FAE008_5260E2A845F0_impl*
 !!! Needs to be implemented !!!
//#UC END# *EDE528FAE008_5260E2A845F0_impl*
end;//Op_PrintParams_UpdatePrinter.Call

class function Op_PrintParams_UpdatePrinter.Call(const aTarget: IvcmAggregate): Boolean;
 {* Вызов операции PrintParams.UpdatePrinter у агрегации }
//#UC START# *1E24E8EA6A59_5260E2A845F0_var*
//#UC END# *1E24E8EA6A59_5260E2A845F0_var*
begin
//#UC START# *1E24E8EA6A59_5260E2A845F0_impl*
 !!! Needs to be implemented !!!
//#UC END# *1E24E8EA6A59_5260E2A845F0_impl*
end;//Op_PrintParams_UpdatePrinter.Call

class function Op_PrintParams_UpdatePrinter.Call(const aTarget: IvcmEntityForm): Boolean;
 {* Вызов операции PrintParams.UpdatePrinter у формы }
//#UC START# *7E15D37D2E87_5260E2A845F0_var*
//#UC END# *7E15D37D2E87_5260E2A845F0_var*
begin
//#UC START# *7E15D37D2E87_5260E2A845F0_impl*
 !!! Needs to be implemented !!!
//#UC END# *7E15D37D2E87_5260E2A845F0_impl*
end;//Op_PrintParams_UpdatePrinter.Call

class function Op_PrintParams_UpdatePrinter.Call(const aTarget: IvcmContainer): Boolean;
 {* Вызов операции PrintParams.UpdatePrinter у контейнера }
//#UC START# *64F01184BBCD_5260E2A845F0_var*
//#UC END# *64F01184BBCD_5260E2A845F0_var*
begin
//#UC START# *64F01184BBCD_5260E2A845F0_impl*
 !!! Needs to be implemented !!!
//#UC END# *64F01184BBCD_5260E2A845F0_impl*
end;//Op_PrintParams_UpdatePrinter.Call

class procedure Op_PrintParams_UpdatePrinter.Broadcast;
 {* Вызов операции PrintParams.UpdatePrinter у всех зарегистрированных сущностей }
//#UC START# *9EF735C41D6A_5260E2A845F0_var*
//#UC END# *9EF735C41D6A_5260E2A845F0_var*
begin
//#UC START# *9EF735C41D6A_5260E2A845F0_impl*
 !!! Needs to be implemented !!!
//#UC END# *9EF735C41D6A_5260E2A845F0_impl*
end;//Op_PrintParams_UpdatePrinter.Broadcast

class function Op_List_SetNewContent.Call(const aTarget: IvcmEntity): Boolean;
 {* Вызов операции List.SetNewContent у сущности }
//#UC START# *082D4BD6C217_6A389B232D6E_var*
//#UC END# *082D4BD6C217_6A389B232D6E_var*
begin
//#UC START# *082D4BD6C217_6A389B232D6E_impl*
 !!! Needs to be implemented !!!
//#UC END# *082D4BD6C217_6A389B232D6E_impl*
end;//Op_List_SetNewContent.Call

class function Op_List_SetNewContent.Call(const aTarget: IvcmAggregate): Boolean;
 {* Вызов операции List.SetNewContent у агрегации }
//#UC START# *386D0BC64C67_6A389B232D6E_var*
//#UC END# *386D0BC64C67_6A389B232D6E_var*
begin
//#UC START# *386D0BC64C67_6A389B232D6E_impl*
 !!! Needs to be implemented !!!
//#UC END# *386D0BC64C67_6A389B232D6E_impl*
end;//Op_List_SetNewContent.Call

class function Op_List_SetNewContent.Call(const aTarget: IvcmEntityForm): Boolean;
 {* Вызов операции List.SetNewContent у формы }
//#UC START# *A64278B83E3E_6A389B232D6E_var*
//#UC END# *A64278B83E3E_6A389B232D6E_var*
begin
//#UC START# *A64278B83E3E_6A389B232D6E_impl*
 !!! Needs to be implemented !!!
//#UC END# *A64278B83E3E_6A389B232D6E_impl*
end;//Op_List_SetNewContent.Call

class function Op_List_SetNewContent.Call(const aTarget: IvcmContainer): Boolean;
 {* Вызов операции List.SetNewContent у контейнера }
//#UC START# *86336FA52647_6A389B232D6E_var*
//#UC END# *86336FA52647_6A389B232D6E_var*
begin
//#UC START# *86336FA52647_6A389B232D6E_impl*
 !!! Needs to be implemented !!!
//#UC END# *86336FA52647_6A389B232D6E_impl*
end;//Op_List_SetNewContent.Call
{$IfEnd} // NOT Defined(Admin)

end.
