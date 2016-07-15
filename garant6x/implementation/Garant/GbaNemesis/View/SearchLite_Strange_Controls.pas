unit SearchLite_Strange_Controls;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\SearchLite_Strange_Controls.pas"
// Стереотип: "VCMControls"
// Элемент модели: "Strange" MUID: (4AE831B30019)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , BaseTreeSupportUnit
 , DynamicTreeUnit
 , FiltersUnit
 , SearchUnit
 , l3Interfaces
 , l3TreeInterfaces
 {$If Defined(Nemesis)}
 , nscNewInterfaces
 {$IfEnd} // Defined(Nemesis)
 , SearchInterfaces
 , nsTypes
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TnsQueryInfo = record
  rQuery: IQuery;
  rFilter: IFilterFromQuery;
  rAskFilters: Boolean;
  rHasErrors: Boolean;
  rIsQueryForFilter: Boolean;
   {* Запрос для создания фильтра }
 end;//TnsQueryInfo

 IAttributeTree_ExternalCharPressed_Params = interface
  {* Параметры для операции AttributeTree.ExternalCharPressed }
  function Get_Char: Il3CString;
  property Char: Il3CString
   read Get_Char;
 end;//IAttributeTree_ExternalCharPressed_Params

 Op_AttributeTree_ExternalCharPressed = {final} class
  {* Класс для вызова операции AttributeTree.ExternalCharPressed }
  public
   class function Call(const aTarget: IvcmEntity;
    const aChar: Il3CString): Boolean; overload;
    {* Вызов операции AttributeTree.ExternalCharPressed у сущности }
   class function Call(const aTarget: IvcmAggregate;
    const aChar: Il3CString): Boolean; overload;
    {* Вызов операции AttributeTree.ExternalCharPressed у агрегации }
   class function Call(const aTarget: IvcmEntityForm;
    const aChar: Il3CString): Boolean; overload;
    {* Вызов операции AttributeTree.ExternalCharPressed у формы }
   class function Call(const aTarget: IvcmContainer;
    const aChar: Il3CString): Boolean; overload;
    {* Вызов операции AttributeTree.ExternalCharPressed у контейнера }
 end;//Op_AttributeTree_ExternalCharPressed

 IAttributeTree_SetCurrent_Params = interface
  {* Параметры для операции AttributeTree.SetCurrent }
  function Get_Node: Il3SimpleNode;
  function Get_Expand: Boolean;
  property Node: Il3SimpleNode
   read Get_Node;
  property Expand: Boolean
   read Get_Expand;
 end;//IAttributeTree_SetCurrent_Params

 Op_AttributeTree_SetCurrent = {final} class
  {* Класс для вызова операции AttributeTree.SetCurrent }
  public
   class function Call(const aTarget: IvcmEntity;
    const aNode: Il3SimpleNode;
    aExpand: Boolean = False): Boolean; overload;
    {* Вызов операции AttributeTree.SetCurrent у сущности }
   class function Call(const aTarget: IvcmAggregate;
    const aNode: Il3SimpleNode;
    aExpand: Boolean = False): Boolean; overload;
    {* Вызов операции AttributeTree.SetCurrent у агрегации }
   class function Call(const aTarget: IvcmEntityForm;
    const aNode: Il3SimpleNode;
    aExpand: Boolean = False): Boolean; overload;
    {* Вызов операции AttributeTree.SetCurrent у формы }
   class function Call(const aTarget: IvcmContainer;
    const aNode: Il3SimpleNode;
    aExpand: Boolean = False): Boolean; overload;
    {* Вызов операции AttributeTree.SetCurrent у контейнера }
 end;//Op_AttributeTree_SetCurrent

 IAttributeTree_DropAllLogicSelection_Params = interface
  {* Параметры для операции AttributeTree.DropAllLogicSelection }
  function Get_DropSelection: Boolean;
  function Get_NotifyMultipleChanges: Boolean;
  function Get_SetToTop: Boolean;
  property DropSelection: Boolean
   read Get_DropSelection;
  property NotifyMultipleChanges: Boolean
   read Get_NotifyMultipleChanges;
  property SetToTop: Boolean
   read Get_SetToTop;
 end;//IAttributeTree_DropAllLogicSelection_Params

 Op_AttributeTree_DropAllLogicSelection = {final} class
  {* Класс для вызова операции AttributeTree.DropAllLogicSelection }
  public
   class function Call(const aTarget: IvcmEntity;
    aDropSelection: Boolean;
    aNotifyMultipleChanges: Boolean = False;
    SetToTop: Boolean = True): Boolean; overload;
    {* Вызов операции AttributeTree.DropAllLogicSelection у сущности }
   class function Call(const aTarget: IvcmAggregate;
    aDropSelection: Boolean;
    aNotifyMultipleChanges: Boolean = False;
    SetToTop: Boolean = True): Boolean; overload;
    {* Вызов операции AttributeTree.DropAllLogicSelection у агрегации }
   class function Call(const aTarget: IvcmEntityForm;
    aDropSelection: Boolean;
    aNotifyMultipleChanges: Boolean = False;
    SetToTop: Boolean = True): Boolean; overload;
    {* Вызов операции AttributeTree.DropAllLogicSelection у формы }
   class function Call(const aTarget: IvcmContainer;
    aDropSelection: Boolean;
    aNotifyMultipleChanges: Boolean = False;
    SetToTop: Boolean = True): Boolean; overload;
    {* Вызов операции AttributeTree.DropAllLogicSelection у контейнера }
 end;//Op_AttributeTree_DropAllLogicSelection

 IAttributeTree_Invalidate_Params = interface
  {* Параметры для операции AttributeTree.Invalidate }
  function Get_UserType: Integer;
  property UserType: Integer
   read Get_UserType;
 end;//IAttributeTree_Invalidate_Params

 Op_AttributeTree_Invalidate = {final} class
  {* Класс для вызова операции AttributeTree.Invalidate }
  public
   class function Call(const aTarget: IvcmEntity;
    aUserType: Integer): Boolean; overload;
    {* Вызов операции AttributeTree.Invalidate у сущности }
   class function Call(const aTarget: IvcmAggregate;
    aUserType: Integer): Boolean; overload;
    {* Вызов операции AttributeTree.Invalidate у агрегации }
   class function Call(const aTarget: IvcmEntityForm;
    aUserType: Integer): Boolean; overload;
    {* Вызов операции AttributeTree.Invalidate у формы }
   class function Call(const aTarget: IvcmContainer;
    aUserType: Integer): Boolean; overload;
    {* Вызов операции AttributeTree.Invalidate у контейнера }
 end;//Op_AttributeTree_Invalidate

 IAttributeTree_DropLogicSelection_Params = interface
  {* Параметры для операции AttributeTree.DropLogicSelection }
  function Get_Node: INodeBase;
  property Node: INodeBase
   read Get_Node;
 end;//IAttributeTree_DropLogicSelection_Params

 Op_AttributeTree_DropLogicSelection = {final} class
  {* Класс для вызова операции AttributeTree.DropLogicSelection }
  public
   class function Call(const aTarget: IvcmEntity;
    const aNode: INodeBase): Boolean; overload;
    {* Вызов операции AttributeTree.DropLogicSelection у сущности }
   class function Call(const aTarget: IvcmAggregate;
    const aNode: INodeBase): Boolean; overload;
    {* Вызов операции AttributeTree.DropLogicSelection у агрегации }
   class function Call(const aTarget: IvcmEntityForm;
    const aNode: INodeBase): Boolean; overload;
    {* Вызов операции AttributeTree.DropLogicSelection у формы }
   class function Call(const aTarget: IvcmContainer;
    const aNode: INodeBase): Boolean; overload;
    {* Вызов операции AttributeTree.DropLogicSelection у контейнера }
 end;//Op_AttributeTree_DropLogicSelection

 IAttributeTree_LoadQuery_Params = interface
  {* Параметры для операции AttributeTree.LoadQuery }
  function Get_Query: IQuery;
  property Query: IQuery
   read Get_Query;
 end;//IAttributeTree_LoadQuery_Params

 Op_AttributeTree_LoadQuery = {final} class
  {* Класс для вызова операции AttributeTree.LoadQuery }
  public
   class function Call(const aTarget: IvcmEntity;
    const aQuery: IQuery): Boolean; overload;
    {* Вызов операции AttributeTree.LoadQuery у сущности }
   class function Call(const aTarget: IvcmAggregate;
    const aQuery: IQuery): Boolean; overload;
    {* Вызов операции AttributeTree.LoadQuery у агрегации }
   class function Call(const aTarget: IvcmEntityForm;
    const aQuery: IQuery): Boolean; overload;
    {* Вызов операции AttributeTree.LoadQuery у формы }
   class function Call(const aTarget: IvcmContainer;
    const aQuery: IQuery): Boolean; overload;
    {* Вызов операции AttributeTree.LoadQuery у контейнера }
 end;//Op_AttributeTree_LoadQuery

 IAttributeTree_SetOneLevelCurrent_Params = interface
  {* Параметры для операции AttributeTree.SetOneLevelCurrent }
  function Get_Node: Il3SimpleNode;
  property Node: Il3SimpleNode
   read Get_Node;
 end;//IAttributeTree_SetOneLevelCurrent_Params

 Op_AttributeTree_SetOneLevelCurrent = {final} class
  {* Класс для вызова операции AttributeTree.SetOneLevelCurrent }
  public
   class function Call(const aTarget: IvcmEntity;
    const aNode: Il3SimpleNode): Boolean; overload;
    {* Вызов операции AttributeTree.SetOneLevelCurrent у сущности }
   class function Call(const aTarget: IvcmAggregate;
    const aNode: Il3SimpleNode): Boolean; overload;
    {* Вызов операции AttributeTree.SetOneLevelCurrent у агрегации }
   class function Call(const aTarget: IvcmEntityForm;
    const aNode: Il3SimpleNode): Boolean; overload;
    {* Вызов операции AttributeTree.SetOneLevelCurrent у формы }
   class function Call(const aTarget: IvcmContainer;
    const aNode: Il3SimpleNode): Boolean; overload;
    {* Вызов операции AttributeTree.SetOneLevelCurrent у контейнера }
 end;//Op_AttributeTree_SetOneLevelCurrent

 Op_AttributeTree_AddNodeIfEmpty = {final} class
  {* Класс для вызова операции AttributeTree.AddNodeIfEmpty }
  public
   class function Call(const aTarget: IvcmEntity): Boolean; overload;
    {* Вызов операции AttributeTree.AddNodeIfEmpty у сущности }
   class function Call(const aTarget: IvcmAggregate): Boolean; overload;
    {* Вызов операции AttributeTree.AddNodeIfEmpty у агрегации }
   class function Call(const aTarget: IvcmEntityForm): Boolean; overload;
    {* Вызов операции AttributeTree.AddNodeIfEmpty у формы }
   class function Call(const aTarget: IvcmContainer): Boolean; overload;
    {* Вызов операции AttributeTree.AddNodeIfEmpty у контейнера }
 end;//Op_AttributeTree_AddNodeIfEmpty

 ISearchParameters_IsQueryEmpty_Params = interface
  {* Параметры для операции SearchParameters.IsQueryEmpty }
  function Get_ResultValue: Boolean;
  procedure Set_ResultValue(aValue: Boolean);
  property ResultValue: Boolean
   read Get_ResultValue
   write Set_ResultValue;
 end;//ISearchParameters_IsQueryEmpty_Params

 Op_SearchParameters_IsQueryEmpty = {final} class
  {* Класс для вызова операции SearchParameters.IsQueryEmpty }
  public
   class function Call(const aTarget: IvcmEntity): Boolean; overload;
    {* Вызов операции SearchParameters.IsQueryEmpty у сущности }
   class function Call(const aTarget: IvcmAggregate): Boolean; overload;
    {* Вызов операции SearchParameters.IsQueryEmpty у агрегации }
   class function Call(const aTarget: IvcmEntityForm): Boolean; overload;
    {* Вызов операции SearchParameters.IsQueryEmpty у формы }
   class function Call(const aTarget: IvcmContainer): Boolean; overload;
    {* Вызов операции SearchParameters.IsQueryEmpty у контейнера }
 end;//Op_SearchParameters_IsQueryEmpty

 ISearchParameters_GetQuery_Params = interface
  {* Параметры для операции SearchParameters.GetQuery }
  function Get_IgnoreError: Boolean;
  function Get_ResultValue: TnsQueryInfo;
  procedure Set_ResultValue(const aValue: TnsQueryInfo);
  property IgnoreError: Boolean
   read Get_IgnoreError;
  property ResultValue: TnsQueryInfo
   read Get_ResultValue
   write Set_ResultValue;
 end;//ISearchParameters_GetQuery_Params

 Op_SearchParameters_GetQuery = {final} class
  {* Класс для вызова операции SearchParameters.GetQuery }
  public
   class function Call(const aTarget: IvcmEntity;
    aIgnoreError: Boolean = False): TnsQueryInfo; overload;
    {* Вызов операции SearchParameters.GetQuery у сущности }
   class function Call(const aTarget: IvcmAggregate;
    aIgnoreError: Boolean = False): TnsQueryInfo; overload;
    {* Вызов операции SearchParameters.GetQuery у агрегации }
   class function Call(const aTarget: IvcmEntityForm;
    aIgnoreError: Boolean = False): TnsQueryInfo; overload;
    {* Вызов операции SearchParameters.GetQuery у формы }
   class function Call(const aTarget: IvcmContainer;
    aIgnoreError: Boolean = False): TnsQueryInfo; overload;
    {* Вызов операции SearchParameters.GetQuery у контейнера }
 end;//Op_SearchParameters_GetQuery

 ISearchParameters_IsQuerySaved_Params = interface
  {* Параметры для операции SearchParameters.IsQuerySaved }
  function Get_ResultValue: Boolean;
  procedure Set_ResultValue(aValue: Boolean);
  property ResultValue: Boolean
   read Get_ResultValue
   write Set_ResultValue;
 end;//ISearchParameters_IsQuerySaved_Params

 Op_SearchParameters_IsQuerySaved = {final} class
  {* Класс для вызова операции SearchParameters.IsQuerySaved }
  public
   class function Call(const aTarget: IvcmEntity): Boolean; overload;
    {* Вызов операции SearchParameters.IsQuerySaved у сущности }
   class function Call(const aTarget: IvcmAggregate): Boolean; overload;
    {* Вызов операции SearchParameters.IsQuerySaved у агрегации }
   class function Call(const aTarget: IvcmEntityForm): Boolean; overload;
    {* Вызов операции SearchParameters.IsQuerySaved у формы }
   class function Call(const aTarget: IvcmContainer): Boolean; overload;
    {* Вызов операции SearchParameters.IsQuerySaved у контейнера }
 end;//Op_SearchParameters_IsQuerySaved

 ISearchParameters_SetQuery_Params = interface
  {* Параметры для операции SearchParameters.SetQuery }
  function Get_Query: IQuery;
  property Query: IQuery
   read Get_Query;
 end;//ISearchParameters_SetQuery_Params

 Op_SearchParameters_SetQuery = {final} class
  {* Класс для вызова операции SearchParameters.SetQuery }
  public
   class function Call(const aTarget: IvcmEntity;
    const aQuery: IQuery): Boolean; overload;
    {* Вызов операции SearchParameters.SetQuery у сущности }
   class function Call(const aTarget: IvcmAggregate;
    const aQuery: IQuery): Boolean; overload;
    {* Вызов операции SearchParameters.SetQuery у агрегации }
   class function Call(const aTarget: IvcmEntityForm;
    const aQuery: IQuery): Boolean; overload;
    {* Вызов операции SearchParameters.SetQuery у формы }
   class function Call(const aTarget: IvcmContainer;
    const aQuery: IQuery): Boolean; overload;
    {* Вызов операции SearchParameters.SetQuery у контейнера }
 end;//Op_SearchParameters_SetQuery

 Op_SearchParameters_ClearQuery = {final} class
  {* Класс для вызова операции SearchParameters.ClearQuery }
  public
   class function Call(const aTarget: IvcmEntity): Boolean; overload;
    {* Вызов операции SearchParameters.ClearQuery у сущности }
   class function Call(const aTarget: IvcmAggregate): Boolean; overload;
    {* Вызов операции SearchParameters.ClearQuery у агрегации }
   class function Call(const aTarget: IvcmEntityForm): Boolean; overload;
    {* Вызов операции SearchParameters.ClearQuery у формы }
   class function Call(const aTarget: IvcmContainer): Boolean; overload;
    {* Вызов операции SearchParameters.ClearQuery у контейнера }
 end;//Op_SearchParameters_ClearQuery

 IAttributeTree_SaveToQuery_Params = interface
  {* Параметры для операции AttributeTree.SaveToQuery }
  function Get_Query: IQuery;
  property Query: IQuery
   read Get_Query;
 end;//IAttributeTree_SaveToQuery_Params

 Op_AttributeTree_SaveToQuery = {final} class
  {* Класс для вызова операции AttributeTree.SaveToQuery }
  public
   class function Call(const aTarget: IvcmEntity;
    const aQuery: IQuery): Boolean; overload;
    {* Вызов операции AttributeTree.SaveToQuery у сущности }
   class function Call(const aTarget: IvcmAggregate;
    const aQuery: IQuery): Boolean; overload;
    {* Вызов операции AttributeTree.SaveToQuery у агрегации }
   class function Call(const aTarget: IvcmEntityForm;
    const aQuery: IQuery): Boolean; overload;
    {* Вызов операции AttributeTree.SaveToQuery у формы }
   class function Call(const aTarget: IvcmContainer;
    const aQuery: IQuery): Boolean; overload;
    {* Вызов операции AttributeTree.SaveToQuery у контейнера }
 end;//Op_AttributeTree_SaveToQuery

 IAttribute_DefaultAction_Params = interface
  {* Параметры для операции Attribute.DefaultAction }
  function Get_nIndex: Integer;
  property nIndex: Integer
   read Get_nIndex;
 end;//IAttribute_DefaultAction_Params

 Op_Attribute_DefaultAction = {final} class
  {* Класс для вызова операции Attribute.DefaultAction }
  public
   class function Call(const aTarget: IvcmEntity;
    anIndex: Integer = -1): Boolean; overload;
    {* Вызов операции Attribute.DefaultAction у сущности }
   class function Call(const aTarget: IvcmAggregate;
    anIndex: Integer = -1): Boolean; overload;
    {* Вызов операции Attribute.DefaultAction у агрегации }
   class function Call(const aTarget: IvcmEntityForm;
    anIndex: Integer = -1): Boolean; overload;
    {* Вызов операции Attribute.DefaultAction у формы }
   class function Call(const aTarget: IvcmContainer;
    anIndex: Integer = -1): Boolean; overload;
    {* Вызов операции Attribute.DefaultAction у контейнера }
 end;//Op_Attribute_DefaultAction

 IContext_SetContext_Params = interface
  {* Параметры для операции Context.SetContext }
  function Get_State: InscContextFilterState;
  property State: InscContextFilterState
   read Get_State;
 end;//IContext_SetContext_Params

 Op_Context_SetContext = {final} class
  {* Класс для вызова операции Context.SetContext }
  public
   class function Call(const aTarget: IvcmEntity;
    const aState: InscContextFilterState): Boolean; overload;
    {* Вызов операции Context.SetContext у сущности }
   class function Call(const aTarget: IvcmAggregate;
    const aState: InscContextFilterState): Boolean; overload;
    {* Вызов операции Context.SetContext у агрегации }
   class function Call(const aTarget: IvcmEntityForm;
    const aState: InscContextFilterState): Boolean; overload;
    {* Вызов операции Context.SetContext у формы }
   class function Call(const aTarget: IvcmContainer;
    const aState: InscContextFilterState): Boolean; overload;
    {* Вызов операции Context.SetContext у контейнера }
 end;//Op_Context_SetContext

 IContext_SyncContextParams_Params = interface
  {* Параметры для операции Context.SyncContextParams }
  function Get_AdditionalFilter: TnsFilterType;
  property AdditionalFilter: TnsFilterType
   read Get_AdditionalFilter;
 end;//IContext_SyncContextParams_Params

 Op_Context_SyncContextParams = {final} class
  {* Класс для вызова операции Context.SyncContextParams }
  public
   class function Call(const aTarget: IvcmEntity;
    aAdditionalFilter: TnsFilterType): Boolean; overload;
    {* Вызов операции Context.SyncContextParams у сущности }
   class function Call(const aTarget: IvcmAggregate;
    aAdditionalFilter: TnsFilterType): Boolean; overload;
    {* Вызов операции Context.SyncContextParams у агрегации }
   class function Call(const aTarget: IvcmEntityForm;
    aAdditionalFilter: TnsFilterType): Boolean; overload;
    {* Вызов операции Context.SyncContextParams у формы }
   class function Call(const aTarget: IvcmContainer;
    aAdditionalFilter: TnsFilterType): Boolean; overload;
    {* Вызов операции Context.SyncContextParams у контейнера }
 end;//Op_Context_SyncContextParams

 IAttributeTree_SetParent_Params = interface
  {* Параметры для операции AttributeTree.SetParent }
  function Get_Parent: Il3SimpleNode;
  property Parent: Il3SimpleNode
   read Get_Parent;
 end;//IAttributeTree_SetParent_Params

 Op_AttributeTree_SetParent = {final} class
  {* Класс для вызова операции AttributeTree.SetParent }
  public
   class function Call(const aTarget: IvcmEntity;
    const aParent: Il3SimpleNode): Boolean; overload;
    {* Вызов операции AttributeTree.SetParent у сущности }
   class function Call(const aTarget: IvcmAggregate;
    const aParent: Il3SimpleNode): Boolean; overload;
    {* Вызов операции AttributeTree.SetParent у агрегации }
   class function Call(const aTarget: IvcmEntityForm;
    const aParent: Il3SimpleNode): Boolean; overload;
    {* Вызов операции AttributeTree.SetParent у формы }
   class function Call(const aTarget: IvcmContainer;
    const aParent: Il3SimpleNode): Boolean; overload;
    {* Вызов операции AttributeTree.SetParent у контейнера }
 end;//Op_AttributeTree_SetParent

 IAttributeTree_ExtSetRoot_Params = interface
  {* Параметры для операции AttributeTree.ExtSetRoot }
  function Get_Root: INodeBase;
  property Root: INodeBase
   read Get_Root;
 end;//IAttributeTree_ExtSetRoot_Params

 Op_AttributeTree_ExtSetRoot = {final} class
  {* Класс для вызова операции AttributeTree.ExtSetRoot }
  public
   class function Call(const aTarget: IvcmEntity;
    const aRoot: INodeBase): Boolean; overload;
    {* Вызов операции AttributeTree.ExtSetRoot у сущности }
   class function Call(const aTarget: IvcmAggregate;
    const aRoot: INodeBase): Boolean; overload;
    {* Вызов операции AttributeTree.ExtSetRoot у агрегации }
   class function Call(const aTarget: IvcmEntityForm;
    const aRoot: INodeBase): Boolean; overload;
    {* Вызов операции AttributeTree.ExtSetRoot у формы }
   class function Call(const aTarget: IvcmContainer;
    const aRoot: INodeBase): Boolean; overload;
    {* Вызов операции AttributeTree.ExtSetRoot у контейнера }
 end;//Op_AttributeTree_ExtSetRoot

 IAttributeTree_SetRoot_Params = interface
  {* Параметры для операции AttributeTree.SetRoot }
  function Get_Tag: Il3CString;
  property Tag: Il3CString
   read Get_Tag;
 end;//IAttributeTree_SetRoot_Params

 Op_AttributeTree_SetRoot = {final} class
  {* Класс для вызова операции AttributeTree.SetRoot }
  public
   class function Call(const aTarget: IvcmEntity;
    const aTag: Il3CString): Boolean; overload;
    {* Вызов операции AttributeTree.SetRoot у сущности }
   class function Call(const aTarget: IvcmAggregate;
    const aTag: Il3CString): Boolean; overload;
    {* Вызов операции AttributeTree.SetRoot у агрегации }
   class function Call(const aTarget: IvcmEntityForm;
    const aTag: Il3CString): Boolean; overload;
    {* Вызов операции AttributeTree.SetRoot у формы }
   class function Call(const aTarget: IvcmContainer;
    const aTag: Il3CString): Boolean; overload;
    {* Вызов операции AttributeTree.SetRoot у контейнера }
 end;//Op_AttributeTree_SetRoot

 IAttributeTree_ChangeRoot_Params = interface
  {* Параметры для операции AttributeTree.ChangeRoot }
  function Get_Tag: Il3CString;
  function Get_Root: Il3SimpleNode;
  function Get_Current: Il3SimpleNode;
  property Tag: Il3CString
   read Get_Tag;
  property Root: Il3SimpleNode
   read Get_Root;
  property Current: Il3SimpleNode
   read Get_Current;
 end;//IAttributeTree_ChangeRoot_Params

 Op_AttributeTree_ChangeRoot = {final} class
  {* Класс для вызова операции AttributeTree.ChangeRoot }
  public
   class function Call(const aTarget: IvcmEntity;
    const aTag: Il3CString;
    const aRoot: Il3SimpleNode;
    const aCurrent: Il3SimpleNode): Boolean; overload;
    {* Вызов операции AttributeTree.ChangeRoot у сущности }
   class function Call(const aTarget: IvcmAggregate;
    const aTag: Il3CString;
    const aRoot: Il3SimpleNode;
    const aCurrent: Il3SimpleNode): Boolean; overload;
    {* Вызов операции AttributeTree.ChangeRoot у агрегации }
   class function Call(const aTarget: IvcmEntityForm;
    const aTag: Il3CString;
    const aRoot: Il3SimpleNode;
    const aCurrent: Il3SimpleNode): Boolean; overload;
    {* Вызов операции AttributeTree.ChangeRoot у формы }
   class function Call(const aTarget: IvcmContainer;
    const aTag: Il3CString;
    const aRoot: Il3SimpleNode;
    const aCurrent: Il3SimpleNode): Boolean; overload;
    {* Вызов операции AttributeTree.ChangeRoot у контейнера }
 end;//Op_AttributeTree_ChangeRoot

 IContextParams_ContextChanged_Params = interface
  {* Параметры для операции ContextParams.ContextChanged }
  function Get_ContextState: InscContextFilterState;
  function Get_ContextTarget: Il3ContextFilterTarget;
  property ContextState: InscContextFilterState
   read Get_ContextState;
  property ContextTarget: Il3ContextFilterTarget
   read Get_ContextTarget;
 end;//IContextParams_ContextChanged_Params

 Op_ContextParams_ContextChanged = {final} class
  {* Класс для вызова операции ContextParams.ContextChanged }
  public
   class function Call(const aTarget: IvcmEntity;
    const aContextState: InscContextFilterState;
    const aContextTarget: Il3ContextFilterTarget): Boolean; overload;
    {* Вызов операции ContextParams.ContextChanged у сущности }
   class function Call(const aTarget: IvcmAggregate;
    const aContextState: InscContextFilterState;
    const aContextTarget: Il3ContextFilterTarget): Boolean; overload;
    {* Вызов операции ContextParams.ContextChanged у агрегации }
   class function Call(const aTarget: IvcmEntityForm;
    const aContextState: InscContextFilterState;
    const aContextTarget: Il3ContextFilterTarget): Boolean; overload;
    {* Вызов операции ContextParams.ContextChanged у формы }
   class function Call(const aTarget: IvcmContainer;
    const aContextState: InscContextFilterState;
    const aContextTarget: Il3ContextFilterTarget): Boolean; overload;
    {* Вызов операции ContextParams.ContextChanged у контейнера }
 end;//Op_ContextParams_ContextChanged

 ISelectedList_RefreshValues_Params = interface
  {* Параметры для операции SelectedList.RefreshValues }
  function Get_Data: InsSelectedAttributesIterators;
  property Data: InsSelectedAttributesIterators
   read Get_Data;
 end;//ISelectedList_RefreshValues_Params

 Op_SelectedList_RefreshValues = {final} class
  {* Класс для вызова операции SelectedList.RefreshValues }
  public
   class function Call(const aTarget: IvcmEntity;
    const aData: InsSelectedAttributesIterators): Boolean; overload;
    {* Вызов операции SelectedList.RefreshValues у сущности }
   class function Call(const aTarget: IvcmAggregate;
    const aData: InsSelectedAttributesIterators): Boolean; overload;
    {* Вызов операции SelectedList.RefreshValues у агрегации }
   class function Call(const aTarget: IvcmEntityForm;
    const aData: InsSelectedAttributesIterators): Boolean; overload;
    {* Вызов операции SelectedList.RefreshValues у формы }
   class function Call(const aTarget: IvcmContainer;
    const aData: InsSelectedAttributesIterators): Boolean; overload;
    {* Вызов операции SelectedList.RefreshValues у контейнера }
 end;//Op_SelectedList_RefreshValues

const
 en_AttributeTree = 'AttributeTree';
 en_capAttributeTree = 'AttributeTree';
 op_ExternalCharPressed = 'ExternalCharPressed';
 op_capExternalCharPressed = '';
 op_SetCurrent = 'SetCurrent';
 op_capSetCurrent = '';
 op_DropAllLogicSelection = 'DropAllLogicSelection';
 op_capDropAllLogicSelection = '';
 op_Invalidate = 'Invalidate';
 op_capInvalidate = '';
 op_DropLogicSelection = 'DropLogicSelection';
 op_capDropLogicSelection = '';
 op_LoadQuery = 'LoadQuery';
 op_capLoadQuery = '';
 op_SetOneLevelCurrent = 'SetOneLevelCurrent';
 op_capSetOneLevelCurrent = '';
 op_AddNodeIfEmpty = 'AddNodeIfEmpty';
 op_capAddNodeIfEmpty = '';
 en_SearchParameters = 'SearchParameters';
 en_capSearchParameters = 'SearchParameters';
 op_IsQueryEmpty = 'IsQueryEmpty';
 op_capIsQueryEmpty = '';
 op_GetQuery = 'GetQuery';
 op_capGetQuery = '';
 op_IsQuerySaved = 'IsQuerySaved';
 op_capIsQuerySaved = '';
 op_SetQuery = 'SetQuery';
 op_capSetQuery = '';
 op_ClearQuery = 'ClearQuery';
 op_capClearQuery = '';
 op_SaveToQuery = 'SaveToQuery';
 op_capSaveToQuery = '';
 en_Attribute = 'Attribute';
 en_capAttribute = '';
 op_DefaultAction = 'DefaultAction';
 op_capDefaultAction = '';
 op_LogicOr = 'LogicOr';
 op_capLogicOr = '';
 op_LogicAnd = 'LogicAnd';
 op_capLogicAnd = '';
 op_LogicNot = 'LogicNot';
 op_capLogicNot = '';
 op_LogicOrShortcut = 'LogicOrShortcut';
 op_capLogicOrShortcut = '';
 en_Context = 'Context';
 en_capContext = '';
 op_SetContext = 'SetContext';
 op_capSetContext = '';
 op_SyncContextParams = 'SyncContextParams';
 op_capSyncContextParams = '';
 op_SetParent = 'SetParent';
 op_capSetParent = '';
 op_ExtSetRoot = 'ExtSetRoot';
 op_capExtSetRoot = '';
 op_SetRoot = 'SetRoot';
 op_capSetRoot = '';
 op_ChangeRoot = 'ChangeRoot';
 op_capChangeRoot = '';
 en_ContextParams = 'ContextParams';
 en_capContextParams = '';
 op_ContextChanged = 'ContextChanged';
 op_capContextChanged = '';
 en_SelectedList = 'SelectedList';
 en_capSelectedList = '';
 op_RefreshValues = 'RefreshValues';
 op_capRefreshValues = '';
 en_Folder = 'Folder';
 en_capFolder = '';
 op_FindFirstSelected = 'FindFirstSelected';
 op_capFindFirstSelected = '';
 en_Result = 'Result';
 en_capResult = '';
 op_ClearAll = 'ClearAll';
 op_capClearAll = '';
 en_Selection = 'Selection';
 en_capSelection = '';
 op_DropSelection = 'DropSelection';
 op_capDropSelection = '';

var opcode_AttributeTree_ExternalCharPressed: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_AttributeTree_SetCurrent: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_AttributeTree_DropAllLogicSelection: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_AttributeTree_Invalidate: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_AttributeTree_DropLogicSelection: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_AttributeTree_LoadQuery: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_AttributeTree_SetOneLevelCurrent: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_AttributeTree_AddNodeIfEmpty: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_SearchParameters_IsQueryEmpty: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_SearchParameters_GetQuery: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_SearchParameters_IsQuerySaved: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_SearchParameters_SetQuery: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_SearchParameters_ClearQuery: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_AttributeTree_SaveToQuery: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_Attribute_DefaultAction: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_Attribute_LogicOr: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_Attribute_LogicAnd: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_Attribute_LogicNot: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_Attribute_LogicOrShortcut: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_Context_SetContext: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_Context_SyncContextParams: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_AttributeTree_SetParent: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_AttributeTree_ExtSetRoot: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_AttributeTree_SetRoot: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_AttributeTree_ChangeRoot: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_ContextParams_ContextChanged: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_SelectedList_RefreshValues: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_Folder_FindFirstSelected: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_Result_ClearAll: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_Selection_DropSelection: TvcmOPID = (rEnID : -1; rOpID : -1);

implementation

uses
 l3ImplUses
 , l3CProtoObject
 {$If NOT Defined(NoVCM)}
 , vcmOperationsForRegister
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmOperationStatesForRegister
 {$IfEnd} // NOT Defined(NoVCM)
 , l3Base
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TAttributeTree_ExternalCharPressed_Params = {final} class(Tl3CProtoObject, IAttributeTree_ExternalCharPressed_Params)
  {* Реализация IAttributeTree_ExternalCharPressed_Params }
  private
   f_Char: Il3CString;
  protected
   function Get_Char: Il3CString;
   procedure ClearFields; override;
  public
   constructor Create(const aChar: Il3CString); reintroduce;
   class function Make(const aChar: Il3CString): IAttributeTree_ExternalCharPressed_Params; reintroduce;
 end;//TAttributeTree_ExternalCharPressed_Params

 TAttributeTree_SetCurrent_Params = {final} class(Tl3CProtoObject, IAttributeTree_SetCurrent_Params)
  {* Реализация IAttributeTree_SetCurrent_Params }
  private
   f_Node: Il3SimpleNode;
   f_Expand: Boolean;
  protected
   function Get_Node: Il3SimpleNode;
   function Get_Expand: Boolean;
   procedure ClearFields; override;
  public
   constructor Create(const aNode: Il3SimpleNode;
    aExpand: Boolean = False); reintroduce;
   class function Make(const aNode: Il3SimpleNode;
    aExpand: Boolean = False): IAttributeTree_SetCurrent_Params; reintroduce;
 end;//TAttributeTree_SetCurrent_Params

 TAttributeTree_DropAllLogicSelection_Params = {final} class(Tl3CProtoObject, IAttributeTree_DropAllLogicSelection_Params)
  {* Реализация IAttributeTree_DropAllLogicSelection_Params }
  private
   f_DropSelection: Boolean;
   f_NotifyMultipleChanges: Boolean;
   f_SetToTop: Boolean;
  protected
   function Get_DropSelection: Boolean;
   function Get_NotifyMultipleChanges: Boolean;
   function Get_SetToTop: Boolean;
  public
   constructor Create(aDropSelection: Boolean;
    aNotifyMultipleChanges: Boolean = False;
    SetToTop: Boolean = True); reintroduce;
   class function Make(aDropSelection: Boolean;
    aNotifyMultipleChanges: Boolean = False;
    SetToTop: Boolean = True): IAttributeTree_DropAllLogicSelection_Params; reintroduce;
 end;//TAttributeTree_DropAllLogicSelection_Params

 TAttributeTree_Invalidate_Params = {final} class(Tl3CProtoObject, IAttributeTree_Invalidate_Params)
  {* Реализация IAttributeTree_Invalidate_Params }
  private
   f_UserType: Integer;
  protected
   function Get_UserType: Integer;
  public
   constructor Create(aUserType: Integer); reintroduce;
   class function Make(aUserType: Integer): IAttributeTree_Invalidate_Params; reintroduce;
 end;//TAttributeTree_Invalidate_Params

 TAttributeTree_DropLogicSelection_Params = {final} class(Tl3CProtoObject, IAttributeTree_DropLogicSelection_Params)
  {* Реализация IAttributeTree_DropLogicSelection_Params }
  private
   f_Node: INodeBase;
  protected
   function Get_Node: INodeBase;
   procedure ClearFields; override;
  public
   constructor Create(const aNode: INodeBase); reintroduce;
   class function Make(const aNode: INodeBase): IAttributeTree_DropLogicSelection_Params; reintroduce;
 end;//TAttributeTree_DropLogicSelection_Params

 TAttributeTree_LoadQuery_Params = {final} class(Tl3CProtoObject, IAttributeTree_LoadQuery_Params)
  {* Реализация IAttributeTree_LoadQuery_Params }
  private
   f_Query: IQuery;
  protected
   function Get_Query: IQuery;
   procedure ClearFields; override;
  public
   constructor Create(const aQuery: IQuery); reintroduce;
   class function Make(const aQuery: IQuery): IAttributeTree_LoadQuery_Params; reintroduce;
 end;//TAttributeTree_LoadQuery_Params

 TAttributeTree_SetOneLevelCurrent_Params = {final} class(Tl3CProtoObject, IAttributeTree_SetOneLevelCurrent_Params)
  {* Реализация IAttributeTree_SetOneLevelCurrent_Params }
  private
   f_Node: Il3SimpleNode;
  protected
   function Get_Node: Il3SimpleNode;
   procedure ClearFields; override;
  public
   constructor Create(const aNode: Il3SimpleNode); reintroduce;
   class function Make(const aNode: Il3SimpleNode): IAttributeTree_SetOneLevelCurrent_Params; reintroduce;
 end;//TAttributeTree_SetOneLevelCurrent_Params

 TSearchParameters_IsQueryEmpty_Params = {final} class(Tl3CProtoObject, ISearchParameters_IsQueryEmpty_Params)
  {* Реализация ISearchParameters_IsQueryEmpty_Params }
  private
   f_ResultValue: Boolean;
  protected
   function Get_ResultValue: Boolean;
   procedure Set_ResultValue(aValue: Boolean);
  public
   class function Make: ISearchParameters_IsQueryEmpty_Params; reintroduce;
 end;//TSearchParameters_IsQueryEmpty_Params

 TSearchParameters_GetQuery_Params = {final} class(Tl3CProtoObject, ISearchParameters_GetQuery_Params)
  {* Реализация ISearchParameters_GetQuery_Params }
  private
   f_IgnoreError: Boolean;
   f_ResultValue: TnsQueryInfo;
  protected
   function Get_IgnoreError: Boolean;
   function Get_ResultValue: TnsQueryInfo;
   procedure Set_ResultValue(const aValue: TnsQueryInfo);
   procedure ClearFields; override;
  public
   constructor Create(aIgnoreError: Boolean = False); reintroduce;
   class function Make(aIgnoreError: Boolean = False): ISearchParameters_GetQuery_Params; reintroduce;
 end;//TSearchParameters_GetQuery_Params

 TSearchParameters_IsQuerySaved_Params = {final} class(Tl3CProtoObject, ISearchParameters_IsQuerySaved_Params)
  {* Реализация ISearchParameters_IsQuerySaved_Params }
  private
   f_ResultValue: Boolean;
  protected
   function Get_ResultValue: Boolean;
   procedure Set_ResultValue(aValue: Boolean);
  public
   class function Make: ISearchParameters_IsQuerySaved_Params; reintroduce;
 end;//TSearchParameters_IsQuerySaved_Params

 TSearchParameters_SetQuery_Params = {final} class(Tl3CProtoObject, ISearchParameters_SetQuery_Params)
  {* Реализация ISearchParameters_SetQuery_Params }
  private
   f_Query: IQuery;
  protected
   function Get_Query: IQuery;
   procedure ClearFields; override;
  public
   constructor Create(const aQuery: IQuery); reintroduce;
   class function Make(const aQuery: IQuery): ISearchParameters_SetQuery_Params; reintroduce;
 end;//TSearchParameters_SetQuery_Params

 TAttributeTree_SaveToQuery_Params = {final} class(Tl3CProtoObject, IAttributeTree_SaveToQuery_Params)
  {* Реализация IAttributeTree_SaveToQuery_Params }
  private
   f_Query: IQuery;
  protected
   function Get_Query: IQuery;
   procedure ClearFields; override;
  public
   constructor Create(const aQuery: IQuery); reintroduce;
   class function Make(const aQuery: IQuery): IAttributeTree_SaveToQuery_Params; reintroduce;
 end;//TAttributeTree_SaveToQuery_Params

 TAttribute_DefaultAction_Params = {final} class(Tl3CProtoObject, IAttribute_DefaultAction_Params)
  {* Реализация IAttribute_DefaultAction_Params }
  private
   f_nIndex: Integer;
  protected
   function Get_nIndex: Integer;
  public
   constructor Create(anIndex: Integer = -1); reintroduce;
   class function Make(anIndex: Integer = -1): IAttribute_DefaultAction_Params; reintroduce;
 end;//TAttribute_DefaultAction_Params

 TContext_SetContext_Params = {final} class(Tl3CProtoObject, IContext_SetContext_Params)
  {* Реализация IContext_SetContext_Params }
  private
   f_State: InscContextFilterState;
  protected
   function Get_State: InscContextFilterState;
   procedure ClearFields; override;
  public
   constructor Create(const aState: InscContextFilterState); reintroduce;
   class function Make(const aState: InscContextFilterState): IContext_SetContext_Params; reintroduce;
 end;//TContext_SetContext_Params

 TContext_SyncContextParams_Params = {final} class(Tl3CProtoObject, IContext_SyncContextParams_Params)
  {* Реализация IContext_SyncContextParams_Params }
  private
   f_AdditionalFilter: TnsFilterType;
  protected
   function Get_AdditionalFilter: TnsFilterType;
  public
   constructor Create(aAdditionalFilter: TnsFilterType); reintroduce;
   class function Make(aAdditionalFilter: TnsFilterType): IContext_SyncContextParams_Params; reintroduce;
 end;//TContext_SyncContextParams_Params

 TAttributeTree_SetParent_Params = {final} class(Tl3CProtoObject, IAttributeTree_SetParent_Params)
  {* Реализация IAttributeTree_SetParent_Params }
  private
   f_Parent: Il3SimpleNode;
  protected
   function Get_Parent: Il3SimpleNode;
   procedure ClearFields; override;
  public
   constructor Create(const aParent: Il3SimpleNode); reintroduce;
   class function Make(const aParent: Il3SimpleNode): IAttributeTree_SetParent_Params; reintroduce;
 end;//TAttributeTree_SetParent_Params

 TAttributeTree_ExtSetRoot_Params = {final} class(Tl3CProtoObject, IAttributeTree_ExtSetRoot_Params)
  {* Реализация IAttributeTree_ExtSetRoot_Params }
  private
   f_Root: INodeBase;
  protected
   function Get_Root: INodeBase;
   procedure ClearFields; override;
  public
   constructor Create(const aRoot: INodeBase); reintroduce;
   class function Make(const aRoot: INodeBase): IAttributeTree_ExtSetRoot_Params; reintroduce;
 end;//TAttributeTree_ExtSetRoot_Params

 TAttributeTree_SetRoot_Params = {final} class(Tl3CProtoObject, IAttributeTree_SetRoot_Params)
  {* Реализация IAttributeTree_SetRoot_Params }
  private
   f_Tag: Il3CString;
  protected
   function Get_Tag: Il3CString;
   procedure ClearFields; override;
  public
   constructor Create(const aTag: Il3CString); reintroduce;
   class function Make(const aTag: Il3CString): IAttributeTree_SetRoot_Params; reintroduce;
 end;//TAttributeTree_SetRoot_Params

 TAttributeTree_ChangeRoot_Params = {final} class(Tl3CProtoObject, IAttributeTree_ChangeRoot_Params)
  {* Реализация IAttributeTree_ChangeRoot_Params }
  private
   f_Tag: Il3CString;
   f_Root: Il3SimpleNode;
   f_Current: Il3SimpleNode;
  protected
   function Get_Tag: Il3CString;
   function Get_Root: Il3SimpleNode;
   function Get_Current: Il3SimpleNode;
   procedure ClearFields; override;
  public
   constructor Create(const aTag: Il3CString;
    const aRoot: Il3SimpleNode;
    const aCurrent: Il3SimpleNode); reintroduce;
   class function Make(const aTag: Il3CString;
    const aRoot: Il3SimpleNode;
    const aCurrent: Il3SimpleNode): IAttributeTree_ChangeRoot_Params; reintroduce;
 end;//TAttributeTree_ChangeRoot_Params

 TContextParams_ContextChanged_Params = {final} class(Tl3CProtoObject, IContextParams_ContextChanged_Params)
  {* Реализация IContextParams_ContextChanged_Params }
  private
   f_ContextState: InscContextFilterState;
   f_ContextTarget: Il3ContextFilterTarget;
  protected
   function Get_ContextState: InscContextFilterState;
   function Get_ContextTarget: Il3ContextFilterTarget;
   procedure ClearFields; override;
  public
   constructor Create(const aContextState: InscContextFilterState;
    const aContextTarget: Il3ContextFilterTarget); reintroduce;
   class function Make(const aContextState: InscContextFilterState;
    const aContextTarget: Il3ContextFilterTarget): IContextParams_ContextChanged_Params; reintroduce;
 end;//TContextParams_ContextChanged_Params

 TSelectedList_RefreshValues_Params = {final} class(Tl3CProtoObject, ISelectedList_RefreshValues_Params)
  {* Реализация ISelectedList_RefreshValues_Params }
  private
   f_Data: InsSelectedAttributesIterators;
  protected
   function Get_Data: InsSelectedAttributesIterators;
   procedure ClearFields; override;
  public
   constructor Create(const aData: InsSelectedAttributesIterators); reintroduce;
   class function Make(const aData: InsSelectedAttributesIterators): ISelectedList_RefreshValues_Params; reintroduce;
 end;//TSelectedList_RefreshValues_Params

constructor TAttributeTree_ExternalCharPressed_Params.Create(const aChar: Il3CString);
begin
 inherited Create;
 f_Char := aChar;
end;//TAttributeTree_ExternalCharPressed_Params.Create

class function TAttributeTree_ExternalCharPressed_Params.Make(const aChar: Il3CString): IAttributeTree_ExternalCharPressed_Params;
var
 l_Inst : TAttributeTree_ExternalCharPressed_Params;
begin
 l_Inst := Create(aChar);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TAttributeTree_ExternalCharPressed_Params.Make

function TAttributeTree_ExternalCharPressed_Params.Get_Char: Il3CString;
begin
 Result := f_Char;
end;//TAttributeTree_ExternalCharPressed_Params.Get_Char

procedure TAttributeTree_ExternalCharPressed_Params.ClearFields;
begin
 f_Char := nil;
 inherited;
end;//TAttributeTree_ExternalCharPressed_Params.ClearFields

class function Op_AttributeTree_ExternalCharPressed.Call(const aTarget: IvcmEntity;
 const aChar: Il3CString): Boolean;
 {* Вызов операции AttributeTree.ExternalCharPressed у сущности }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TAttributeTree_ExternalCharPressed_Params.Make(aChar));
  aTarget.Operation(opcode_AttributeTree_ExternalCharPressed, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_AttributeTree_ExternalCharPressed.Call

class function Op_AttributeTree_ExternalCharPressed.Call(const aTarget: IvcmAggregate;
 const aChar: Il3CString): Boolean;
 {* Вызов операции AttributeTree.ExternalCharPressed у агрегации }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TAttributeTree_ExternalCharPressed_Params.Make(aChar));
  aTarget.Operation(opcode_AttributeTree_ExternalCharPressed, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_AttributeTree_ExternalCharPressed.Call

class function Op_AttributeTree_ExternalCharPressed.Call(const aTarget: IvcmEntityForm;
 const aChar: Il3CString): Boolean;
 {* Вызов операции AttributeTree.ExternalCharPressed у формы }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity, aChar);
end;//Op_AttributeTree_ExternalCharPressed.Call

class function Op_AttributeTree_ExternalCharPressed.Call(const aTarget: IvcmContainer;
 const aChar: Il3CString): Boolean;
 {* Вызов операции AttributeTree.ExternalCharPressed у контейнера }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm, aChar);
end;//Op_AttributeTree_ExternalCharPressed.Call

constructor TAttributeTree_SetCurrent_Params.Create(const aNode: Il3SimpleNode;
 aExpand: Boolean = False);
begin
 inherited Create;
 f_Node := aNode;
 f_Expand := aExpand;
end;//TAttributeTree_SetCurrent_Params.Create

class function TAttributeTree_SetCurrent_Params.Make(const aNode: Il3SimpleNode;
 aExpand: Boolean = False): IAttributeTree_SetCurrent_Params;
var
 l_Inst : TAttributeTree_SetCurrent_Params;
begin
 l_Inst := Create(aNode, aExpand);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TAttributeTree_SetCurrent_Params.Make

function TAttributeTree_SetCurrent_Params.Get_Node: Il3SimpleNode;
begin
 Result := f_Node;
end;//TAttributeTree_SetCurrent_Params.Get_Node

function TAttributeTree_SetCurrent_Params.Get_Expand: Boolean;
begin
 Result := f_Expand;
end;//TAttributeTree_SetCurrent_Params.Get_Expand

procedure TAttributeTree_SetCurrent_Params.ClearFields;
begin
 f_Node := nil;
 inherited;
end;//TAttributeTree_SetCurrent_Params.ClearFields

class function Op_AttributeTree_SetCurrent.Call(const aTarget: IvcmEntity;
 const aNode: Il3SimpleNode;
 aExpand: Boolean = False): Boolean;
 {* Вызов операции AttributeTree.SetCurrent у сущности }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TAttributeTree_SetCurrent_Params.Make(aNode, aExpand));
  aTarget.Operation(opcode_AttributeTree_SetCurrent, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_AttributeTree_SetCurrent.Call

class function Op_AttributeTree_SetCurrent.Call(const aTarget: IvcmAggregate;
 const aNode: Il3SimpleNode;
 aExpand: Boolean = False): Boolean;
 {* Вызов операции AttributeTree.SetCurrent у агрегации }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TAttributeTree_SetCurrent_Params.Make(aNode, aExpand));
  aTarget.Operation(opcode_AttributeTree_SetCurrent, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_AttributeTree_SetCurrent.Call

class function Op_AttributeTree_SetCurrent.Call(const aTarget: IvcmEntityForm;
 const aNode: Il3SimpleNode;
 aExpand: Boolean = False): Boolean;
 {* Вызов операции AttributeTree.SetCurrent у формы }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity, aNode, aExpand);
end;//Op_AttributeTree_SetCurrent.Call

class function Op_AttributeTree_SetCurrent.Call(const aTarget: IvcmContainer;
 const aNode: Il3SimpleNode;
 aExpand: Boolean = False): Boolean;
 {* Вызов операции AttributeTree.SetCurrent у контейнера }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm, aNode, aExpand);
end;//Op_AttributeTree_SetCurrent.Call

constructor TAttributeTree_DropAllLogicSelection_Params.Create(aDropSelection: Boolean;
 aNotifyMultipleChanges: Boolean = False;
 SetToTop: Boolean = True);
begin
 inherited Create;
 f_DropSelection := aDropSelection;
 f_NotifyMultipleChanges := aNotifyMultipleChanges;
 f_SetToTop := SetToTop;
end;//TAttributeTree_DropAllLogicSelection_Params.Create

class function TAttributeTree_DropAllLogicSelection_Params.Make(aDropSelection: Boolean;
 aNotifyMultipleChanges: Boolean = False;
 SetToTop: Boolean = True): IAttributeTree_DropAllLogicSelection_Params;
var
 l_Inst : TAttributeTree_DropAllLogicSelection_Params;
begin
 l_Inst := Create(aDropSelection, aNotifyMultipleChanges, SetToTop);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TAttributeTree_DropAllLogicSelection_Params.Make

function TAttributeTree_DropAllLogicSelection_Params.Get_DropSelection: Boolean;
begin
 Result := f_DropSelection;
end;//TAttributeTree_DropAllLogicSelection_Params.Get_DropSelection

function TAttributeTree_DropAllLogicSelection_Params.Get_NotifyMultipleChanges: Boolean;
begin
 Result := f_NotifyMultipleChanges;
end;//TAttributeTree_DropAllLogicSelection_Params.Get_NotifyMultipleChanges

function TAttributeTree_DropAllLogicSelection_Params.Get_SetToTop: Boolean;
begin
 Result := f_SetToTop;
end;//TAttributeTree_DropAllLogicSelection_Params.Get_SetToTop

class function Op_AttributeTree_DropAllLogicSelection.Call(const aTarget: IvcmEntity;
 aDropSelection: Boolean;
 aNotifyMultipleChanges: Boolean = False;
 SetToTop: Boolean = True): Boolean;
 {* Вызов операции AttributeTree.DropAllLogicSelection у сущности }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TAttributeTree_DropAllLogicSelection_Params.Make(aDropSelection, aNotifyMultipleChanges, SetToTop));
  aTarget.Operation(opcode_AttributeTree_DropAllLogicSelection, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_AttributeTree_DropAllLogicSelection.Call

class function Op_AttributeTree_DropAllLogicSelection.Call(const aTarget: IvcmAggregate;
 aDropSelection: Boolean;
 aNotifyMultipleChanges: Boolean = False;
 SetToTop: Boolean = True): Boolean;
 {* Вызов операции AttributeTree.DropAllLogicSelection у агрегации }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TAttributeTree_DropAllLogicSelection_Params.Make(aDropSelection, aNotifyMultipleChanges, SetToTop));
  aTarget.Operation(opcode_AttributeTree_DropAllLogicSelection, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_AttributeTree_DropAllLogicSelection.Call

class function Op_AttributeTree_DropAllLogicSelection.Call(const aTarget: IvcmEntityForm;
 aDropSelection: Boolean;
 aNotifyMultipleChanges: Boolean = False;
 SetToTop: Boolean = True): Boolean;
 {* Вызов операции AttributeTree.DropAllLogicSelection у формы }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity, aDropSelection, aNotifyMultipleChanges, SetToTop);
end;//Op_AttributeTree_DropAllLogicSelection.Call

class function Op_AttributeTree_DropAllLogicSelection.Call(const aTarget: IvcmContainer;
 aDropSelection: Boolean;
 aNotifyMultipleChanges: Boolean = False;
 SetToTop: Boolean = True): Boolean;
 {* Вызов операции AttributeTree.DropAllLogicSelection у контейнера }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm, aDropSelection, aNotifyMultipleChanges, SetToTop);
end;//Op_AttributeTree_DropAllLogicSelection.Call

constructor TAttributeTree_Invalidate_Params.Create(aUserType: Integer);
begin
 inherited Create;
 f_UserType := aUserType;
end;//TAttributeTree_Invalidate_Params.Create

class function TAttributeTree_Invalidate_Params.Make(aUserType: Integer): IAttributeTree_Invalidate_Params;
var
 l_Inst : TAttributeTree_Invalidate_Params;
begin
 l_Inst := Create(aUserType);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TAttributeTree_Invalidate_Params.Make

function TAttributeTree_Invalidate_Params.Get_UserType: Integer;
begin
 Result := f_UserType;
end;//TAttributeTree_Invalidate_Params.Get_UserType

class function Op_AttributeTree_Invalidate.Call(const aTarget: IvcmEntity;
 aUserType: Integer): Boolean;
 {* Вызов операции AttributeTree.Invalidate у сущности }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TAttributeTree_Invalidate_Params.Make(aUserType));
  aTarget.Operation(opcode_AttributeTree_Invalidate, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_AttributeTree_Invalidate.Call

class function Op_AttributeTree_Invalidate.Call(const aTarget: IvcmAggregate;
 aUserType: Integer): Boolean;
 {* Вызов операции AttributeTree.Invalidate у агрегации }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TAttributeTree_Invalidate_Params.Make(aUserType));
  aTarget.Operation(opcode_AttributeTree_Invalidate, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_AttributeTree_Invalidate.Call

class function Op_AttributeTree_Invalidate.Call(const aTarget: IvcmEntityForm;
 aUserType: Integer): Boolean;
 {* Вызов операции AttributeTree.Invalidate у формы }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity, aUserType);
end;//Op_AttributeTree_Invalidate.Call

class function Op_AttributeTree_Invalidate.Call(const aTarget: IvcmContainer;
 aUserType: Integer): Boolean;
 {* Вызов операции AttributeTree.Invalidate у контейнера }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm, aUserType);
end;//Op_AttributeTree_Invalidate.Call

constructor TAttributeTree_DropLogicSelection_Params.Create(const aNode: INodeBase);
begin
 inherited Create;
 f_Node := aNode;
end;//TAttributeTree_DropLogicSelection_Params.Create

class function TAttributeTree_DropLogicSelection_Params.Make(const aNode: INodeBase): IAttributeTree_DropLogicSelection_Params;
var
 l_Inst : TAttributeTree_DropLogicSelection_Params;
begin
 l_Inst := Create(aNode);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TAttributeTree_DropLogicSelection_Params.Make

function TAttributeTree_DropLogicSelection_Params.Get_Node: INodeBase;
begin
 Result := f_Node;
end;//TAttributeTree_DropLogicSelection_Params.Get_Node

procedure TAttributeTree_DropLogicSelection_Params.ClearFields;
begin
 f_Node := nil;
 inherited;
end;//TAttributeTree_DropLogicSelection_Params.ClearFields

class function Op_AttributeTree_DropLogicSelection.Call(const aTarget: IvcmEntity;
 const aNode: INodeBase): Boolean;
 {* Вызов операции AttributeTree.DropLogicSelection у сущности }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TAttributeTree_DropLogicSelection_Params.Make(aNode));
  aTarget.Operation(opcode_AttributeTree_DropLogicSelection, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_AttributeTree_DropLogicSelection.Call

class function Op_AttributeTree_DropLogicSelection.Call(const aTarget: IvcmAggregate;
 const aNode: INodeBase): Boolean;
 {* Вызов операции AttributeTree.DropLogicSelection у агрегации }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TAttributeTree_DropLogicSelection_Params.Make(aNode));
  aTarget.Operation(opcode_AttributeTree_DropLogicSelection, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_AttributeTree_DropLogicSelection.Call

class function Op_AttributeTree_DropLogicSelection.Call(const aTarget: IvcmEntityForm;
 const aNode: INodeBase): Boolean;
 {* Вызов операции AttributeTree.DropLogicSelection у формы }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity, aNode);
end;//Op_AttributeTree_DropLogicSelection.Call

class function Op_AttributeTree_DropLogicSelection.Call(const aTarget: IvcmContainer;
 const aNode: INodeBase): Boolean;
 {* Вызов операции AttributeTree.DropLogicSelection у контейнера }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm, aNode);
end;//Op_AttributeTree_DropLogicSelection.Call

constructor TAttributeTree_LoadQuery_Params.Create(const aQuery: IQuery);
begin
 inherited Create;
 f_Query := aQuery;
end;//TAttributeTree_LoadQuery_Params.Create

class function TAttributeTree_LoadQuery_Params.Make(const aQuery: IQuery): IAttributeTree_LoadQuery_Params;
var
 l_Inst : TAttributeTree_LoadQuery_Params;
begin
 l_Inst := Create(aQuery);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TAttributeTree_LoadQuery_Params.Make

function TAttributeTree_LoadQuery_Params.Get_Query: IQuery;
begin
 Result := f_Query;
end;//TAttributeTree_LoadQuery_Params.Get_Query

procedure TAttributeTree_LoadQuery_Params.ClearFields;
begin
 f_Query := nil;
 inherited;
end;//TAttributeTree_LoadQuery_Params.ClearFields

class function Op_AttributeTree_LoadQuery.Call(const aTarget: IvcmEntity;
 const aQuery: IQuery): Boolean;
 {* Вызов операции AttributeTree.LoadQuery у сущности }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TAttributeTree_LoadQuery_Params.Make(aQuery));
  aTarget.Operation(opcode_AttributeTree_LoadQuery, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_AttributeTree_LoadQuery.Call

class function Op_AttributeTree_LoadQuery.Call(const aTarget: IvcmAggregate;
 const aQuery: IQuery): Boolean;
 {* Вызов операции AttributeTree.LoadQuery у агрегации }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TAttributeTree_LoadQuery_Params.Make(aQuery));
  aTarget.Operation(opcode_AttributeTree_LoadQuery, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_AttributeTree_LoadQuery.Call

class function Op_AttributeTree_LoadQuery.Call(const aTarget: IvcmEntityForm;
 const aQuery: IQuery): Boolean;
 {* Вызов операции AttributeTree.LoadQuery у формы }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity, aQuery);
end;//Op_AttributeTree_LoadQuery.Call

class function Op_AttributeTree_LoadQuery.Call(const aTarget: IvcmContainer;
 const aQuery: IQuery): Boolean;
 {* Вызов операции AttributeTree.LoadQuery у контейнера }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm, aQuery);
end;//Op_AttributeTree_LoadQuery.Call

constructor TAttributeTree_SetOneLevelCurrent_Params.Create(const aNode: Il3SimpleNode);
begin
 inherited Create;
 f_Node := aNode;
end;//TAttributeTree_SetOneLevelCurrent_Params.Create

class function TAttributeTree_SetOneLevelCurrent_Params.Make(const aNode: Il3SimpleNode): IAttributeTree_SetOneLevelCurrent_Params;
var
 l_Inst : TAttributeTree_SetOneLevelCurrent_Params;
begin
 l_Inst := Create(aNode);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TAttributeTree_SetOneLevelCurrent_Params.Make

function TAttributeTree_SetOneLevelCurrent_Params.Get_Node: Il3SimpleNode;
begin
 Result := f_Node;
end;//TAttributeTree_SetOneLevelCurrent_Params.Get_Node

procedure TAttributeTree_SetOneLevelCurrent_Params.ClearFields;
begin
 f_Node := nil;
 inherited;
end;//TAttributeTree_SetOneLevelCurrent_Params.ClearFields

class function Op_AttributeTree_SetOneLevelCurrent.Call(const aTarget: IvcmEntity;
 const aNode: Il3SimpleNode): Boolean;
 {* Вызов операции AttributeTree.SetOneLevelCurrent у сущности }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TAttributeTree_SetOneLevelCurrent_Params.Make(aNode));
  aTarget.Operation(opcode_AttributeTree_SetOneLevelCurrent, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_AttributeTree_SetOneLevelCurrent.Call

class function Op_AttributeTree_SetOneLevelCurrent.Call(const aTarget: IvcmAggregate;
 const aNode: Il3SimpleNode): Boolean;
 {* Вызов операции AttributeTree.SetOneLevelCurrent у агрегации }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TAttributeTree_SetOneLevelCurrent_Params.Make(aNode));
  aTarget.Operation(opcode_AttributeTree_SetOneLevelCurrent, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_AttributeTree_SetOneLevelCurrent.Call

class function Op_AttributeTree_SetOneLevelCurrent.Call(const aTarget: IvcmEntityForm;
 const aNode: Il3SimpleNode): Boolean;
 {* Вызов операции AttributeTree.SetOneLevelCurrent у формы }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity, aNode);
end;//Op_AttributeTree_SetOneLevelCurrent.Call

class function Op_AttributeTree_SetOneLevelCurrent.Call(const aTarget: IvcmContainer;
 const aNode: Il3SimpleNode): Boolean;
 {* Вызов операции AttributeTree.SetOneLevelCurrent у контейнера }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm, aNode);
end;//Op_AttributeTree_SetOneLevelCurrent.Call

class function Op_AttributeTree_AddNodeIfEmpty.Call(const aTarget: IvcmEntity): Boolean;
 {* Вызов операции AttributeTree.AddNodeIfEmpty у сущности }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := vcmParams;
  aTarget.Operation(opcode_AttributeTree_AddNodeIfEmpty, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_AttributeTree_AddNodeIfEmpty.Call

class function Op_AttributeTree_AddNodeIfEmpty.Call(const aTarget: IvcmAggregate): Boolean;
 {* Вызов операции AttributeTree.AddNodeIfEmpty у агрегации }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := vcmParams;
  aTarget.Operation(opcode_AttributeTree_AddNodeIfEmpty, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_AttributeTree_AddNodeIfEmpty.Call

class function Op_AttributeTree_AddNodeIfEmpty.Call(const aTarget: IvcmEntityForm): Boolean;
 {* Вызов операции AttributeTree.AddNodeIfEmpty у формы }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity);
end;//Op_AttributeTree_AddNodeIfEmpty.Call

class function Op_AttributeTree_AddNodeIfEmpty.Call(const aTarget: IvcmContainer): Boolean;
 {* Вызов операции AttributeTree.AddNodeIfEmpty у контейнера }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm);
end;//Op_AttributeTree_AddNodeIfEmpty.Call

class function TSearchParameters_IsQueryEmpty_Params.Make: ISearchParameters_IsQueryEmpty_Params;
var
 l_Inst : TSearchParameters_IsQueryEmpty_Params;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TSearchParameters_IsQueryEmpty_Params.Make

function TSearchParameters_IsQueryEmpty_Params.Get_ResultValue: Boolean;
begin
 Result := f_ResultValue;
end;//TSearchParameters_IsQueryEmpty_Params.Get_ResultValue

procedure TSearchParameters_IsQueryEmpty_Params.Set_ResultValue(aValue: Boolean);
begin
 f_ResultValue := aValue;
end;//TSearchParameters_IsQueryEmpty_Params.Set_ResultValue

class function Op_SearchParameters_IsQueryEmpty.Call(const aTarget: IvcmEntity): Boolean;
 {* Вызов операции SearchParameters.IsQueryEmpty у сущности }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TSearchParameters_IsQueryEmpty_Params.Make);
  aTarget.Operation(opcode_SearchParameters_IsQueryEmpty, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := ISearchParameters_IsQueryEmpty_Params(Data).ResultValue;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_SearchParameters_IsQueryEmpty.Call

class function Op_SearchParameters_IsQueryEmpty.Call(const aTarget: IvcmAggregate): Boolean;
 {* Вызов операции SearchParameters.IsQueryEmpty у агрегации }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TSearchParameters_IsQueryEmpty_Params.Make);
  aTarget.Operation(opcode_SearchParameters_IsQueryEmpty, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := ISearchParameters_IsQueryEmpty_Params(Data).ResultValue;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_SearchParameters_IsQueryEmpty.Call

class function Op_SearchParameters_IsQueryEmpty.Call(const aTarget: IvcmEntityForm): Boolean;
 {* Вызов операции SearchParameters.IsQueryEmpty у формы }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity);
end;//Op_SearchParameters_IsQueryEmpty.Call

class function Op_SearchParameters_IsQueryEmpty.Call(const aTarget: IvcmContainer): Boolean;
 {* Вызов операции SearchParameters.IsQueryEmpty у контейнера }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm);
end;//Op_SearchParameters_IsQueryEmpty.Call

constructor TSearchParameters_GetQuery_Params.Create(aIgnoreError: Boolean = False);
begin
 inherited Create;
 f_IgnoreError := aIgnoreError;
end;//TSearchParameters_GetQuery_Params.Create

class function TSearchParameters_GetQuery_Params.Make(aIgnoreError: Boolean = False): ISearchParameters_GetQuery_Params;
var
 l_Inst : TSearchParameters_GetQuery_Params;
begin
 l_Inst := Create(aIgnoreError);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TSearchParameters_GetQuery_Params.Make

function TSearchParameters_GetQuery_Params.Get_IgnoreError: Boolean;
begin
 Result := f_IgnoreError;
end;//TSearchParameters_GetQuery_Params.Get_IgnoreError

function TSearchParameters_GetQuery_Params.Get_ResultValue: TnsQueryInfo;
begin
 Result := f_ResultValue;
end;//TSearchParameters_GetQuery_Params.Get_ResultValue

procedure TSearchParameters_GetQuery_Params.Set_ResultValue(const aValue: TnsQueryInfo);
begin
 f_ResultValue := aValue;
end;//TSearchParameters_GetQuery_Params.Set_ResultValue

procedure TSearchParameters_GetQuery_Params.ClearFields;
begin
 Finalize(f_ResultValue);
 inherited;
end;//TSearchParameters_GetQuery_Params.ClearFields

class function Op_SearchParameters_GetQuery.Call(const aTarget: IvcmEntity;
 aIgnoreError: Boolean = False): TnsQueryInfo;
 {* Вызов операции SearchParameters.GetQuery у сущности }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TSearchParameters_GetQuery_Params.Make(aIgnoreError));
  aTarget.Operation(opcode_SearchParameters_GetQuery, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := ISearchParameters_GetQuery_Params(Data).ResultValue;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_SearchParameters_GetQuery.Call

class function Op_SearchParameters_GetQuery.Call(const aTarget: IvcmAggregate;
 aIgnoreError: Boolean = False): TnsQueryInfo;
 {* Вызов операции SearchParameters.GetQuery у агрегации }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TSearchParameters_GetQuery_Params.Make(aIgnoreError));
  aTarget.Operation(opcode_SearchParameters_GetQuery, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := ISearchParameters_GetQuery_Params(Data).ResultValue;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_SearchParameters_GetQuery.Call

class function Op_SearchParameters_GetQuery.Call(const aTarget: IvcmEntityForm;
 aIgnoreError: Boolean = False): TnsQueryInfo;
 {* Вызов операции SearchParameters.GetQuery у формы }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity, aIgnoreError);
end;//Op_SearchParameters_GetQuery.Call

class function Op_SearchParameters_GetQuery.Call(const aTarget: IvcmContainer;
 aIgnoreError: Boolean = False): TnsQueryInfo;
 {* Вызов операции SearchParameters.GetQuery у контейнера }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm, aIgnoreError);
end;//Op_SearchParameters_GetQuery.Call

class function TSearchParameters_IsQuerySaved_Params.Make: ISearchParameters_IsQuerySaved_Params;
var
 l_Inst : TSearchParameters_IsQuerySaved_Params;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TSearchParameters_IsQuerySaved_Params.Make

function TSearchParameters_IsQuerySaved_Params.Get_ResultValue: Boolean;
begin
 Result := f_ResultValue;
end;//TSearchParameters_IsQuerySaved_Params.Get_ResultValue

procedure TSearchParameters_IsQuerySaved_Params.Set_ResultValue(aValue: Boolean);
begin
 f_ResultValue := aValue;
end;//TSearchParameters_IsQuerySaved_Params.Set_ResultValue

class function Op_SearchParameters_IsQuerySaved.Call(const aTarget: IvcmEntity): Boolean;
 {* Вызов операции SearchParameters.IsQuerySaved у сущности }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TSearchParameters_IsQuerySaved_Params.Make);
  aTarget.Operation(opcode_SearchParameters_IsQuerySaved, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := ISearchParameters_IsQuerySaved_Params(Data).ResultValue;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_SearchParameters_IsQuerySaved.Call

class function Op_SearchParameters_IsQuerySaved.Call(const aTarget: IvcmAggregate): Boolean;
 {* Вызов операции SearchParameters.IsQuerySaved у агрегации }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TSearchParameters_IsQuerySaved_Params.Make);
  aTarget.Operation(opcode_SearchParameters_IsQuerySaved, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := ISearchParameters_IsQuerySaved_Params(Data).ResultValue;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_SearchParameters_IsQuerySaved.Call

class function Op_SearchParameters_IsQuerySaved.Call(const aTarget: IvcmEntityForm): Boolean;
 {* Вызов операции SearchParameters.IsQuerySaved у формы }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity);
end;//Op_SearchParameters_IsQuerySaved.Call

class function Op_SearchParameters_IsQuerySaved.Call(const aTarget: IvcmContainer): Boolean;
 {* Вызов операции SearchParameters.IsQuerySaved у контейнера }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm);
end;//Op_SearchParameters_IsQuerySaved.Call

constructor TSearchParameters_SetQuery_Params.Create(const aQuery: IQuery);
begin
 inherited Create;
 f_Query := aQuery;
end;//TSearchParameters_SetQuery_Params.Create

class function TSearchParameters_SetQuery_Params.Make(const aQuery: IQuery): ISearchParameters_SetQuery_Params;
var
 l_Inst : TSearchParameters_SetQuery_Params;
begin
 l_Inst := Create(aQuery);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TSearchParameters_SetQuery_Params.Make

function TSearchParameters_SetQuery_Params.Get_Query: IQuery;
begin
 Result := f_Query;
end;//TSearchParameters_SetQuery_Params.Get_Query

procedure TSearchParameters_SetQuery_Params.ClearFields;
begin
 f_Query := nil;
 inherited;
end;//TSearchParameters_SetQuery_Params.ClearFields

class function Op_SearchParameters_SetQuery.Call(const aTarget: IvcmEntity;
 const aQuery: IQuery): Boolean;
 {* Вызов операции SearchParameters.SetQuery у сущности }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TSearchParameters_SetQuery_Params.Make(aQuery));
  aTarget.Operation(opcode_SearchParameters_SetQuery, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_SearchParameters_SetQuery.Call

class function Op_SearchParameters_SetQuery.Call(const aTarget: IvcmAggregate;
 const aQuery: IQuery): Boolean;
 {* Вызов операции SearchParameters.SetQuery у агрегации }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TSearchParameters_SetQuery_Params.Make(aQuery));
  aTarget.Operation(opcode_SearchParameters_SetQuery, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_SearchParameters_SetQuery.Call

class function Op_SearchParameters_SetQuery.Call(const aTarget: IvcmEntityForm;
 const aQuery: IQuery): Boolean;
 {* Вызов операции SearchParameters.SetQuery у формы }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity, aQuery);
end;//Op_SearchParameters_SetQuery.Call

class function Op_SearchParameters_SetQuery.Call(const aTarget: IvcmContainer;
 const aQuery: IQuery): Boolean;
 {* Вызов операции SearchParameters.SetQuery у контейнера }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm, aQuery);
end;//Op_SearchParameters_SetQuery.Call

class function Op_SearchParameters_ClearQuery.Call(const aTarget: IvcmEntity): Boolean;
 {* Вызов операции SearchParameters.ClearQuery у сущности }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := vcmParams;
  aTarget.Operation(opcode_SearchParameters_ClearQuery, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_SearchParameters_ClearQuery.Call

class function Op_SearchParameters_ClearQuery.Call(const aTarget: IvcmAggregate): Boolean;
 {* Вызов операции SearchParameters.ClearQuery у агрегации }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := vcmParams;
  aTarget.Operation(opcode_SearchParameters_ClearQuery, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_SearchParameters_ClearQuery.Call

class function Op_SearchParameters_ClearQuery.Call(const aTarget: IvcmEntityForm): Boolean;
 {* Вызов операции SearchParameters.ClearQuery у формы }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity);
end;//Op_SearchParameters_ClearQuery.Call

class function Op_SearchParameters_ClearQuery.Call(const aTarget: IvcmContainer): Boolean;
 {* Вызов операции SearchParameters.ClearQuery у контейнера }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm);
end;//Op_SearchParameters_ClearQuery.Call

constructor TAttributeTree_SaveToQuery_Params.Create(const aQuery: IQuery);
begin
 inherited Create;
 f_Query := aQuery;
end;//TAttributeTree_SaveToQuery_Params.Create

class function TAttributeTree_SaveToQuery_Params.Make(const aQuery: IQuery): IAttributeTree_SaveToQuery_Params;
var
 l_Inst : TAttributeTree_SaveToQuery_Params;
begin
 l_Inst := Create(aQuery);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TAttributeTree_SaveToQuery_Params.Make

function TAttributeTree_SaveToQuery_Params.Get_Query: IQuery;
begin
 Result := f_Query;
end;//TAttributeTree_SaveToQuery_Params.Get_Query

procedure TAttributeTree_SaveToQuery_Params.ClearFields;
begin
 f_Query := nil;
 inherited;
end;//TAttributeTree_SaveToQuery_Params.ClearFields

class function Op_AttributeTree_SaveToQuery.Call(const aTarget: IvcmEntity;
 const aQuery: IQuery): Boolean;
 {* Вызов операции AttributeTree.SaveToQuery у сущности }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TAttributeTree_SaveToQuery_Params.Make(aQuery));
  aTarget.Operation(opcode_AttributeTree_SaveToQuery, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_AttributeTree_SaveToQuery.Call

class function Op_AttributeTree_SaveToQuery.Call(const aTarget: IvcmAggregate;
 const aQuery: IQuery): Boolean;
 {* Вызов операции AttributeTree.SaveToQuery у агрегации }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TAttributeTree_SaveToQuery_Params.Make(aQuery));
  aTarget.Operation(opcode_AttributeTree_SaveToQuery, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_AttributeTree_SaveToQuery.Call

class function Op_AttributeTree_SaveToQuery.Call(const aTarget: IvcmEntityForm;
 const aQuery: IQuery): Boolean;
 {* Вызов операции AttributeTree.SaveToQuery у формы }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity, aQuery);
end;//Op_AttributeTree_SaveToQuery.Call

class function Op_AttributeTree_SaveToQuery.Call(const aTarget: IvcmContainer;
 const aQuery: IQuery): Boolean;
 {* Вызов операции AttributeTree.SaveToQuery у контейнера }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm, aQuery);
end;//Op_AttributeTree_SaveToQuery.Call

constructor TAttribute_DefaultAction_Params.Create(anIndex: Integer = -1);
begin
 inherited Create;
 f_nIndex := anIndex;
end;//TAttribute_DefaultAction_Params.Create

class function TAttribute_DefaultAction_Params.Make(anIndex: Integer = -1): IAttribute_DefaultAction_Params;
var
 l_Inst : TAttribute_DefaultAction_Params;
begin
 l_Inst := Create(anIndex);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TAttribute_DefaultAction_Params.Make

function TAttribute_DefaultAction_Params.Get_nIndex: Integer;
begin
 Result := f_nIndex;
end;//TAttribute_DefaultAction_Params.Get_nIndex

class function Op_Attribute_DefaultAction.Call(const aTarget: IvcmEntity;
 anIndex: Integer = -1): Boolean;
 {* Вызов операции Attribute.DefaultAction у сущности }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TAttribute_DefaultAction_Params.Make(anIndex));
  aTarget.Operation(opcode_Attribute_DefaultAction, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Attribute_DefaultAction.Call

class function Op_Attribute_DefaultAction.Call(const aTarget: IvcmAggregate;
 anIndex: Integer = -1): Boolean;
 {* Вызов операции Attribute.DefaultAction у агрегации }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TAttribute_DefaultAction_Params.Make(anIndex));
  aTarget.Operation(opcode_Attribute_DefaultAction, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Attribute_DefaultAction.Call

class function Op_Attribute_DefaultAction.Call(const aTarget: IvcmEntityForm;
 anIndex: Integer = -1): Boolean;
 {* Вызов операции Attribute.DefaultAction у формы }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity, anIndex);
end;//Op_Attribute_DefaultAction.Call

class function Op_Attribute_DefaultAction.Call(const aTarget: IvcmContainer;
 anIndex: Integer = -1): Boolean;
 {* Вызов операции Attribute.DefaultAction у контейнера }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm, anIndex);
end;//Op_Attribute_DefaultAction.Call

constructor TContext_SetContext_Params.Create(const aState: InscContextFilterState);
begin
 inherited Create;
 f_State := aState;
end;//TContext_SetContext_Params.Create

class function TContext_SetContext_Params.Make(const aState: InscContextFilterState): IContext_SetContext_Params;
var
 l_Inst : TContext_SetContext_Params;
begin
 l_Inst := Create(aState);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TContext_SetContext_Params.Make

function TContext_SetContext_Params.Get_State: InscContextFilterState;
begin
 Result := f_State;
end;//TContext_SetContext_Params.Get_State

procedure TContext_SetContext_Params.ClearFields;
begin
 f_State := nil;
 inherited;
end;//TContext_SetContext_Params.ClearFields

class function Op_Context_SetContext.Call(const aTarget: IvcmEntity;
 const aState: InscContextFilterState): Boolean;
 {* Вызов операции Context.SetContext у сущности }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TContext_SetContext_Params.Make(aState));
  aTarget.Operation(opcode_Context_SetContext, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Context_SetContext.Call

class function Op_Context_SetContext.Call(const aTarget: IvcmAggregate;
 const aState: InscContextFilterState): Boolean;
 {* Вызов операции Context.SetContext у агрегации }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TContext_SetContext_Params.Make(aState));
  aTarget.Operation(opcode_Context_SetContext, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Context_SetContext.Call

class function Op_Context_SetContext.Call(const aTarget: IvcmEntityForm;
 const aState: InscContextFilterState): Boolean;
 {* Вызов операции Context.SetContext у формы }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity, aState);
end;//Op_Context_SetContext.Call

class function Op_Context_SetContext.Call(const aTarget: IvcmContainer;
 const aState: InscContextFilterState): Boolean;
 {* Вызов операции Context.SetContext у контейнера }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm, aState);
end;//Op_Context_SetContext.Call

constructor TContext_SyncContextParams_Params.Create(aAdditionalFilter: TnsFilterType);
begin
 inherited Create;
 f_AdditionalFilter := aAdditionalFilter;
end;//TContext_SyncContextParams_Params.Create

class function TContext_SyncContextParams_Params.Make(aAdditionalFilter: TnsFilterType): IContext_SyncContextParams_Params;
var
 l_Inst : TContext_SyncContextParams_Params;
begin
 l_Inst := Create(aAdditionalFilter);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TContext_SyncContextParams_Params.Make

function TContext_SyncContextParams_Params.Get_AdditionalFilter: TnsFilterType;
begin
 Result := f_AdditionalFilter;
end;//TContext_SyncContextParams_Params.Get_AdditionalFilter

class function Op_Context_SyncContextParams.Call(const aTarget: IvcmEntity;
 aAdditionalFilter: TnsFilterType): Boolean;
 {* Вызов операции Context.SyncContextParams у сущности }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TContext_SyncContextParams_Params.Make(aAdditionalFilter));
  aTarget.Operation(opcode_Context_SyncContextParams, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Context_SyncContextParams.Call

class function Op_Context_SyncContextParams.Call(const aTarget: IvcmAggregate;
 aAdditionalFilter: TnsFilterType): Boolean;
 {* Вызов операции Context.SyncContextParams у агрегации }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TContext_SyncContextParams_Params.Make(aAdditionalFilter));
  aTarget.Operation(opcode_Context_SyncContextParams, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Context_SyncContextParams.Call

class function Op_Context_SyncContextParams.Call(const aTarget: IvcmEntityForm;
 aAdditionalFilter: TnsFilterType): Boolean;
 {* Вызов операции Context.SyncContextParams у формы }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity, aAdditionalFilter);
end;//Op_Context_SyncContextParams.Call

class function Op_Context_SyncContextParams.Call(const aTarget: IvcmContainer;
 aAdditionalFilter: TnsFilterType): Boolean;
 {* Вызов операции Context.SyncContextParams у контейнера }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm, aAdditionalFilter);
end;//Op_Context_SyncContextParams.Call

constructor TAttributeTree_SetParent_Params.Create(const aParent: Il3SimpleNode);
begin
 inherited Create;
 f_Parent := aParent;
end;//TAttributeTree_SetParent_Params.Create

class function TAttributeTree_SetParent_Params.Make(const aParent: Il3SimpleNode): IAttributeTree_SetParent_Params;
var
 l_Inst : TAttributeTree_SetParent_Params;
begin
 l_Inst := Create(aParent);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TAttributeTree_SetParent_Params.Make

function TAttributeTree_SetParent_Params.Get_Parent: Il3SimpleNode;
begin
 Result := f_Parent;
end;//TAttributeTree_SetParent_Params.Get_Parent

procedure TAttributeTree_SetParent_Params.ClearFields;
begin
 f_Parent := nil;
 inherited;
end;//TAttributeTree_SetParent_Params.ClearFields

class function Op_AttributeTree_SetParent.Call(const aTarget: IvcmEntity;
 const aParent: Il3SimpleNode): Boolean;
 {* Вызов операции AttributeTree.SetParent у сущности }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TAttributeTree_SetParent_Params.Make(aParent));
  aTarget.Operation(opcode_AttributeTree_SetParent, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_AttributeTree_SetParent.Call

class function Op_AttributeTree_SetParent.Call(const aTarget: IvcmAggregate;
 const aParent: Il3SimpleNode): Boolean;
 {* Вызов операции AttributeTree.SetParent у агрегации }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TAttributeTree_SetParent_Params.Make(aParent));
  aTarget.Operation(opcode_AttributeTree_SetParent, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_AttributeTree_SetParent.Call

class function Op_AttributeTree_SetParent.Call(const aTarget: IvcmEntityForm;
 const aParent: Il3SimpleNode): Boolean;
 {* Вызов операции AttributeTree.SetParent у формы }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity, aParent);
end;//Op_AttributeTree_SetParent.Call

class function Op_AttributeTree_SetParent.Call(const aTarget: IvcmContainer;
 const aParent: Il3SimpleNode): Boolean;
 {* Вызов операции AttributeTree.SetParent у контейнера }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm, aParent);
end;//Op_AttributeTree_SetParent.Call

constructor TAttributeTree_ExtSetRoot_Params.Create(const aRoot: INodeBase);
begin
 inherited Create;
 f_Root := aRoot;
end;//TAttributeTree_ExtSetRoot_Params.Create

class function TAttributeTree_ExtSetRoot_Params.Make(const aRoot: INodeBase): IAttributeTree_ExtSetRoot_Params;
var
 l_Inst : TAttributeTree_ExtSetRoot_Params;
begin
 l_Inst := Create(aRoot);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TAttributeTree_ExtSetRoot_Params.Make

function TAttributeTree_ExtSetRoot_Params.Get_Root: INodeBase;
begin
 Result := f_Root;
end;//TAttributeTree_ExtSetRoot_Params.Get_Root

procedure TAttributeTree_ExtSetRoot_Params.ClearFields;
begin
 f_Root := nil;
 inherited;
end;//TAttributeTree_ExtSetRoot_Params.ClearFields

class function Op_AttributeTree_ExtSetRoot.Call(const aTarget: IvcmEntity;
 const aRoot: INodeBase): Boolean;
 {* Вызов операции AttributeTree.ExtSetRoot у сущности }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TAttributeTree_ExtSetRoot_Params.Make(aRoot));
  aTarget.Operation(opcode_AttributeTree_ExtSetRoot, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_AttributeTree_ExtSetRoot.Call

class function Op_AttributeTree_ExtSetRoot.Call(const aTarget: IvcmAggregate;
 const aRoot: INodeBase): Boolean;
 {* Вызов операции AttributeTree.ExtSetRoot у агрегации }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TAttributeTree_ExtSetRoot_Params.Make(aRoot));
  aTarget.Operation(opcode_AttributeTree_ExtSetRoot, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_AttributeTree_ExtSetRoot.Call

class function Op_AttributeTree_ExtSetRoot.Call(const aTarget: IvcmEntityForm;
 const aRoot: INodeBase): Boolean;
 {* Вызов операции AttributeTree.ExtSetRoot у формы }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity, aRoot);
end;//Op_AttributeTree_ExtSetRoot.Call

class function Op_AttributeTree_ExtSetRoot.Call(const aTarget: IvcmContainer;
 const aRoot: INodeBase): Boolean;
 {* Вызов операции AttributeTree.ExtSetRoot у контейнера }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm, aRoot);
end;//Op_AttributeTree_ExtSetRoot.Call

constructor TAttributeTree_SetRoot_Params.Create(const aTag: Il3CString);
begin
 inherited Create;
 f_Tag := aTag;
end;//TAttributeTree_SetRoot_Params.Create

class function TAttributeTree_SetRoot_Params.Make(const aTag: Il3CString): IAttributeTree_SetRoot_Params;
var
 l_Inst : TAttributeTree_SetRoot_Params;
begin
 l_Inst := Create(aTag);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TAttributeTree_SetRoot_Params.Make

function TAttributeTree_SetRoot_Params.Get_Tag: Il3CString;
begin
 Result := f_Tag;
end;//TAttributeTree_SetRoot_Params.Get_Tag

procedure TAttributeTree_SetRoot_Params.ClearFields;
begin
 f_Tag := nil;
 inherited;
end;//TAttributeTree_SetRoot_Params.ClearFields

class function Op_AttributeTree_SetRoot.Call(const aTarget: IvcmEntity;
 const aTag: Il3CString): Boolean;
 {* Вызов операции AttributeTree.SetRoot у сущности }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TAttributeTree_SetRoot_Params.Make(aTag));
  aTarget.Operation(opcode_AttributeTree_SetRoot, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_AttributeTree_SetRoot.Call

class function Op_AttributeTree_SetRoot.Call(const aTarget: IvcmAggregate;
 const aTag: Il3CString): Boolean;
 {* Вызов операции AttributeTree.SetRoot у агрегации }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TAttributeTree_SetRoot_Params.Make(aTag));
  aTarget.Operation(opcode_AttributeTree_SetRoot, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_AttributeTree_SetRoot.Call

class function Op_AttributeTree_SetRoot.Call(const aTarget: IvcmEntityForm;
 const aTag: Il3CString): Boolean;
 {* Вызов операции AttributeTree.SetRoot у формы }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity, aTag);
end;//Op_AttributeTree_SetRoot.Call

class function Op_AttributeTree_SetRoot.Call(const aTarget: IvcmContainer;
 const aTag: Il3CString): Boolean;
 {* Вызов операции AttributeTree.SetRoot у контейнера }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm, aTag);
end;//Op_AttributeTree_SetRoot.Call

constructor TAttributeTree_ChangeRoot_Params.Create(const aTag: Il3CString;
 const aRoot: Il3SimpleNode;
 const aCurrent: Il3SimpleNode);
begin
 inherited Create;
 f_Tag := aTag;
 f_Root := aRoot;
 f_Current := aCurrent;
end;//TAttributeTree_ChangeRoot_Params.Create

class function TAttributeTree_ChangeRoot_Params.Make(const aTag: Il3CString;
 const aRoot: Il3SimpleNode;
 const aCurrent: Il3SimpleNode): IAttributeTree_ChangeRoot_Params;
var
 l_Inst : TAttributeTree_ChangeRoot_Params;
begin
 l_Inst := Create(aTag, aRoot, aCurrent);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TAttributeTree_ChangeRoot_Params.Make

function TAttributeTree_ChangeRoot_Params.Get_Tag: Il3CString;
begin
 Result := f_Tag;
end;//TAttributeTree_ChangeRoot_Params.Get_Tag

function TAttributeTree_ChangeRoot_Params.Get_Root: Il3SimpleNode;
begin
 Result := f_Root;
end;//TAttributeTree_ChangeRoot_Params.Get_Root

function TAttributeTree_ChangeRoot_Params.Get_Current: Il3SimpleNode;
begin
 Result := f_Current;
end;//TAttributeTree_ChangeRoot_Params.Get_Current

procedure TAttributeTree_ChangeRoot_Params.ClearFields;
begin
 f_Tag := nil;
 f_Root := nil;
 f_Current := nil;
 inherited;
end;//TAttributeTree_ChangeRoot_Params.ClearFields

class function Op_AttributeTree_ChangeRoot.Call(const aTarget: IvcmEntity;
 const aTag: Il3CString;
 const aRoot: Il3SimpleNode;
 const aCurrent: Il3SimpleNode): Boolean;
 {* Вызов операции AttributeTree.ChangeRoot у сущности }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TAttributeTree_ChangeRoot_Params.Make(aTag, aRoot, aCurrent));
  aTarget.Operation(opcode_AttributeTree_ChangeRoot, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_AttributeTree_ChangeRoot.Call

class function Op_AttributeTree_ChangeRoot.Call(const aTarget: IvcmAggregate;
 const aTag: Il3CString;
 const aRoot: Il3SimpleNode;
 const aCurrent: Il3SimpleNode): Boolean;
 {* Вызов операции AttributeTree.ChangeRoot у агрегации }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TAttributeTree_ChangeRoot_Params.Make(aTag, aRoot, aCurrent));
  aTarget.Operation(opcode_AttributeTree_ChangeRoot, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_AttributeTree_ChangeRoot.Call

class function Op_AttributeTree_ChangeRoot.Call(const aTarget: IvcmEntityForm;
 const aTag: Il3CString;
 const aRoot: Il3SimpleNode;
 const aCurrent: Il3SimpleNode): Boolean;
 {* Вызов операции AttributeTree.ChangeRoot у формы }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity, aTag, aRoot, aCurrent);
end;//Op_AttributeTree_ChangeRoot.Call

class function Op_AttributeTree_ChangeRoot.Call(const aTarget: IvcmContainer;
 const aTag: Il3CString;
 const aRoot: Il3SimpleNode;
 const aCurrent: Il3SimpleNode): Boolean;
 {* Вызов операции AttributeTree.ChangeRoot у контейнера }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm, aTag, aRoot, aCurrent);
end;//Op_AttributeTree_ChangeRoot.Call

constructor TContextParams_ContextChanged_Params.Create(const aContextState: InscContextFilterState;
 const aContextTarget: Il3ContextFilterTarget);
begin
 inherited Create;
 f_ContextState := aContextState;
 f_ContextTarget := aContextTarget;
end;//TContextParams_ContextChanged_Params.Create

class function TContextParams_ContextChanged_Params.Make(const aContextState: InscContextFilterState;
 const aContextTarget: Il3ContextFilterTarget): IContextParams_ContextChanged_Params;
var
 l_Inst : TContextParams_ContextChanged_Params;
begin
 l_Inst := Create(aContextState, aContextTarget);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TContextParams_ContextChanged_Params.Make

function TContextParams_ContextChanged_Params.Get_ContextState: InscContextFilterState;
begin
 Result := f_ContextState;
end;//TContextParams_ContextChanged_Params.Get_ContextState

function TContextParams_ContextChanged_Params.Get_ContextTarget: Il3ContextFilterTarget;
begin
 Result := f_ContextTarget;
end;//TContextParams_ContextChanged_Params.Get_ContextTarget

procedure TContextParams_ContextChanged_Params.ClearFields;
begin
 f_ContextState := nil;
 f_ContextTarget := nil;
 inherited;
end;//TContextParams_ContextChanged_Params.ClearFields

class function Op_ContextParams_ContextChanged.Call(const aTarget: IvcmEntity;
 const aContextState: InscContextFilterState;
 const aContextTarget: Il3ContextFilterTarget): Boolean;
 {* Вызов операции ContextParams.ContextChanged у сущности }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TContextParams_ContextChanged_Params.Make(aContextState, aContextTarget));
  aTarget.Operation(opcode_ContextParams_ContextChanged, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_ContextParams_ContextChanged.Call

class function Op_ContextParams_ContextChanged.Call(const aTarget: IvcmAggregate;
 const aContextState: InscContextFilterState;
 const aContextTarget: Il3ContextFilterTarget): Boolean;
 {* Вызов операции ContextParams.ContextChanged у агрегации }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TContextParams_ContextChanged_Params.Make(aContextState, aContextTarget));
  aTarget.Operation(opcode_ContextParams_ContextChanged, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_ContextParams_ContextChanged.Call

class function Op_ContextParams_ContextChanged.Call(const aTarget: IvcmEntityForm;
 const aContextState: InscContextFilterState;
 const aContextTarget: Il3ContextFilterTarget): Boolean;
 {* Вызов операции ContextParams.ContextChanged у формы }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity, aContextState, aContextTarget);
end;//Op_ContextParams_ContextChanged.Call

class function Op_ContextParams_ContextChanged.Call(const aTarget: IvcmContainer;
 const aContextState: InscContextFilterState;
 const aContextTarget: Il3ContextFilterTarget): Boolean;
 {* Вызов операции ContextParams.ContextChanged у контейнера }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm, aContextState, aContextTarget);
end;//Op_ContextParams_ContextChanged.Call

constructor TSelectedList_RefreshValues_Params.Create(const aData: InsSelectedAttributesIterators);
begin
 inherited Create;
 f_Data := aData;
end;//TSelectedList_RefreshValues_Params.Create

class function TSelectedList_RefreshValues_Params.Make(const aData: InsSelectedAttributesIterators): ISelectedList_RefreshValues_Params;
var
 l_Inst : TSelectedList_RefreshValues_Params;
begin
 l_Inst := Create(aData);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TSelectedList_RefreshValues_Params.Make

function TSelectedList_RefreshValues_Params.Get_Data: InsSelectedAttributesIterators;
begin
 Result := f_Data;
end;//TSelectedList_RefreshValues_Params.Get_Data

procedure TSelectedList_RefreshValues_Params.ClearFields;
begin
 f_Data := nil;
 inherited;
end;//TSelectedList_RefreshValues_Params.ClearFields

class function Op_SelectedList_RefreshValues.Call(const aTarget: IvcmEntity;
 const aData: InsSelectedAttributesIterators): Boolean;
 {* Вызов операции SelectedList.RefreshValues у сущности }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TSelectedList_RefreshValues_Params.Make(aData));
  aTarget.Operation(opcode_SelectedList_RefreshValues, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_SelectedList_RefreshValues.Call

class function Op_SelectedList_RefreshValues.Call(const aTarget: IvcmAggregate;
 const aData: InsSelectedAttributesIterators): Boolean;
 {* Вызов операции SelectedList.RefreshValues у агрегации }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TSelectedList_RefreshValues_Params.Make(aData));
  aTarget.Operation(opcode_SelectedList_RefreshValues, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_SelectedList_RefreshValues.Call

class function Op_SelectedList_RefreshValues.Call(const aTarget: IvcmEntityForm;
 const aData: InsSelectedAttributesIterators): Boolean;
 {* Вызов операции SelectedList.RefreshValues у формы }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity, aData);
end;//Op_SelectedList_RefreshValues.Call

class function Op_SelectedList_RefreshValues.Call(const aTarget: IvcmContainer;
 const aData: InsSelectedAttributesIterators): Boolean;
 {* Вызов операции SelectedList.RefreshValues у контейнера }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm, aData);
end;//Op_SelectedList_RefreshValues.Call

initialization
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_AttributeTree, op_ExternalCharPressed, en_capAttributeTree, op_capExternalCharPressed, True, False, opcode_AttributeTree_ExternalCharPressed)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_AttributeTree, op_SetCurrent, en_capAttributeTree, op_capSetCurrent, True, False, opcode_AttributeTree_SetCurrent)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_AttributeTree, op_DropAllLogicSelection, en_capAttributeTree, op_capDropAllLogicSelection, True, False, opcode_AttributeTree_DropAllLogicSelection)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_AttributeTree, op_Invalidate, en_capAttributeTree, op_capInvalidate, True, False, opcode_AttributeTree_Invalidate)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_AttributeTree, op_DropLogicSelection, en_capAttributeTree, op_capDropLogicSelection, True, False, opcode_AttributeTree_DropLogicSelection)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_AttributeTree, op_LoadQuery, en_capAttributeTree, op_capLoadQuery, True, False, opcode_AttributeTree_LoadQuery)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_AttributeTree, op_SetOneLevelCurrent, en_capAttributeTree, op_capSetOneLevelCurrent, True, False, opcode_AttributeTree_SetOneLevelCurrent)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_AttributeTree, op_AddNodeIfEmpty, en_capAttributeTree, op_capAddNodeIfEmpty, True, False, opcode_AttributeTree_AddNodeIfEmpty)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_SearchParameters, op_IsQueryEmpty, en_capSearchParameters, op_capIsQueryEmpty, True, False, opcode_SearchParameters_IsQueryEmpty)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_SearchParameters, op_GetQuery, en_capSearchParameters, op_capGetQuery, True, False, opcode_SearchParameters_GetQuery)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_SearchParameters, op_IsQuerySaved, en_capSearchParameters, op_capIsQuerySaved, True, False, opcode_SearchParameters_IsQuerySaved)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_SearchParameters, op_SetQuery, en_capSearchParameters, op_capSetQuery, True, False, opcode_SearchParameters_SetQuery)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_SearchParameters, op_ClearQuery, en_capSearchParameters, op_capClearQuery, True, False, opcode_SearchParameters_ClearQuery)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_AttributeTree, op_SaveToQuery, en_capAttributeTree, op_capSaveToQuery, True, False, opcode_AttributeTree_SaveToQuery)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Attribute, op_DefaultAction, en_capAttribute, op_capDefaultAction, True, False, opcode_Attribute_DefaultAction)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Attribute, op_LogicOr, en_capAttribute, op_capLogicOr, False, False, opcode_Attribute_LogicOr)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Attribute, op_LogicAnd, en_capAttribute, op_capLogicAnd, False, False, opcode_Attribute_LogicAnd)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Attribute, op_LogicNot, en_capAttribute, op_capLogicNot, False, False, opcode_Attribute_LogicNot)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Attribute, op_LogicOrShortcut, en_capAttribute, op_capLogicOrShortcut, False, False, opcode_Attribute_LogicOrShortcut)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Context, op_SetContext, en_capContext, op_capSetContext, True, False, opcode_Context_SetContext)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Context, op_SyncContextParams, en_capContext, op_capSyncContextParams, True, False, opcode_Context_SyncContextParams)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_AttributeTree, op_SetParent, en_capAttributeTree, op_capSetParent, True, False, opcode_AttributeTree_SetParent)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_AttributeTree, op_ExtSetRoot, en_capAttributeTree, op_capExtSetRoot, True, False, opcode_AttributeTree_ExtSetRoot)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_AttributeTree, op_SetRoot, en_capAttributeTree, op_capSetRoot, True, False, opcode_AttributeTree_SetRoot)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_AttributeTree, op_ChangeRoot, en_capAttributeTree, op_capChangeRoot, True, False, opcode_AttributeTree_ChangeRoot)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_ContextParams, op_ContextChanged, en_capContextParams, op_capContextChanged, True, False, opcode_ContextParams_ContextChanged)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_SelectedList, op_RefreshValues, en_capSelectedList, op_capRefreshValues, True, False, opcode_SelectedList_RefreshValues)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Folder, op_FindFirstSelected, en_capFolder, op_capFindFirstSelected, False, False, opcode_Folder_FindFirstSelected)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Result, op_ClearAll, en_capResult, op_capClearAll, False, False, opcode_Result_ClearAll)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_Selection, op_DropSelection, en_capSelection, op_capDropSelection, False, False, opcode_Selection_DropSelection)) do
 begin
 end;


end.
