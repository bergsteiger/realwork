unit SearchLite_Strange_Controls;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\SearchLite_Strange_Controls.pas"
// Стереотип: "VCMControls"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , SearchUnit
 , FiltersUnit
 , l3Interfaces
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , l3TreeInterfaces
 , DynamicTreeUnit
 {$If Defined(Nemesis)}
 , nscNewInterfaces
 {$IfEnd} // Defined(Nemesis)
 , nsTypes
 , SearchInterfaces
;

type
 // AttributeTree

 TnsQueryInfo = record
  rQuery: IQuery;
  rFilter: IFilterFromQuery;
  rAskFilters: Boolean;
  rHasErrors: Boolean;
  rIsQueryForFilter: Boolean;
   {* Запрос для создания фильтра }
 end;//TnsQueryInfo

 // SearchParameters

 // AttributeTree

 // Attribute

 // Context

 // AttributeTree

 // AttributeTree

 // AttributeTree

 // ContextParams

 // SelectedList

 // Folder

 // Result

 // Selection

 IAttributeTree_ExternalCharPressed_Params = interface
  {* Параметры для операции AttributeTree.ExternalCharPressed }
  ['{1E38BBFD-C752-443C-BCCC-EA5C27C57195}']
  function Get_Char: Il3CString;
  property Char: Il3CString
   read Get_Char;
 end;//IAttributeTree_ExternalCharPressed_Params

 Op_AttributeTree_ExternalCharPressed = class
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
  ['{A321B03E-4DE4-4A13-92C8-906842BAE015}']
  function Get_Node: Il3SimpleNode;
  function Get_Expand: Boolean;
  property Node: Il3SimpleNode
   read Get_Node;
  property Expand: Boolean
   read Get_Expand;
 end;//IAttributeTree_SetCurrent_Params

 Op_AttributeTree_SetCurrent = class
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
  ['{5E6D61F3-084D-4A3B-9843-7724733281D5}']
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

 Op_AttributeTree_DropAllLogicSelection = class
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
  ['{5430FE5C-1557-4462-B774-47585BF7399D}']
  function Get_UserType: Integer;
  property UserType: Integer
   read Get_UserType;
 end;//IAttributeTree_Invalidate_Params

 Op_AttributeTree_Invalidate = class
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
  ['{5FD1E8F0-FCE9-4BA1-B967-B9A81F9815F5}']
  function Get_Node: INodeBase;
  property Node: INodeBase
   read Get_Node;
 end;//IAttributeTree_DropLogicSelection_Params

 Op_AttributeTree_DropLogicSelection = class
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
  ['{086B1D39-95E7-4993-A41C-F5FF17B53ECF}']
  function Get_Query: IQuery;
  property Query: IQuery
   read Get_Query;
 end;//IAttributeTree_LoadQuery_Params

 Op_AttributeTree_LoadQuery = class
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
  ['{7F36E887-EB58-400A-8C0D-6778A9863B92}']
  function Get_Node: Il3SimpleNode;
  property Node: Il3SimpleNode
   read Get_Node;
 end;//IAttributeTree_SetOneLevelCurrent_Params

 Op_AttributeTree_SetOneLevelCurrent = class
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

 Op_AttributeTree_AddNodeIfEmpty = class
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
  ['{3C78ECD9-AC4F-42FF-A84F-07D1F62F246A}']
  function Get_ResultValue: Boolean;
  procedure Set_ResultValue(aValue: Boolean);
  property ResultValue: Boolean
   read Get_ResultValue
   write Set_ResultValue;
 end;//ISearchParameters_IsQueryEmpty_Params

 Op_SearchParameters_IsQueryEmpty = class
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
  ['{82715820-17F2-4302-8EA1-C1E66CF4ABF3}']
  function Get_IgnoreError: Boolean;
  function Get_ResultValue: TnsQueryInfo;
  procedure Set_ResultValue(const aValue: TnsQueryInfo);
  property IgnoreError: Boolean
   read Get_IgnoreError;
  property ResultValue: TnsQueryInfo
   read Get_ResultValue
   write Set_ResultValue;
 end;//ISearchParameters_GetQuery_Params

 Op_SearchParameters_GetQuery = class
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
  ['{8161B454-2BCB-4276-9E84-C4D77CCF9693}']
  function Get_ResultValue: Boolean;
  procedure Set_ResultValue(aValue: Boolean);
  property ResultValue: Boolean
   read Get_ResultValue
   write Set_ResultValue;
 end;//ISearchParameters_IsQuerySaved_Params

 Op_SearchParameters_IsQuerySaved = class
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
  ['{87C1C3B9-72AA-4DFC-9866-7E1B6E9BEB69}']
  function Get_Query: IQuery;
  property Query: IQuery
   read Get_Query;
 end;//ISearchParameters_SetQuery_Params

 Op_SearchParameters_SetQuery = class
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

 Op_SearchParameters_ClearQuery = class
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
  ['{171CEFE0-76E8-41E1-9AA2-82418A05CFCA}']
  function Get_Query: IQuery;
  property Query: IQuery
   read Get_Query;
 end;//IAttributeTree_SaveToQuery_Params

 Op_AttributeTree_SaveToQuery = class
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
  ['{CEF946DF-8C68-4888-AF51-8B73A52FB790}']
  function Get_nIndex: Integer;
  property nIndex: Integer
   read Get_nIndex;
 end;//IAttribute_DefaultAction_Params

 Op_Attribute_DefaultAction = class
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
  ['{CA1EB54F-63E2-4BB4-A7D4-7136DD5A49E0}']
  function Get_State: InscContextFilterState;
  property State: InscContextFilterState
   read Get_State;
 end;//IContext_SetContext_Params

 Op_Context_SetContext = class
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
  ['{AD4F283A-B3DC-4391-AB30-739DBAD4470B}']
  function Get_AdditionalFilter: TnsFilterType;
  property AdditionalFilter: TnsFilterType
   read Get_AdditionalFilter;
 end;//IContext_SyncContextParams_Params

 Op_Context_SyncContextParams = class
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
  ['{830F9F58-31DB-425B-B0A2-AC19AB497634}']
  function Get_Parent: Il3SimpleNode;
  property Parent: Il3SimpleNode
   read Get_Parent;
 end;//IAttributeTree_SetParent_Params

 Op_AttributeTree_SetParent = class
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
  ['{06B285A8-91B5-4E2E-8C76-71CA31A57CE0}']
  function Get_Root: INodeBase;
  property Root: INodeBase
   read Get_Root;
 end;//IAttributeTree_ExtSetRoot_Params

 Op_AttributeTree_ExtSetRoot = class
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
  ['{2F2E0ADC-9951-434E-B1F4-6125DEFF6DD6}']
  function Get_Tag: Il3CString;
  property Tag: Il3CString
   read Get_Tag;
 end;//IAttributeTree_SetRoot_Params

 Op_AttributeTree_SetRoot = class
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
  ['{77A4E369-2E48-473F-8EE4-3ABC88C1C127}']
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

 Op_AttributeTree_ChangeRoot = class
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
  ['{1B63082F-5388-4039-82F1-91E9139413F9}']
  function Get_ContextState: InscContextFilterState;
  function Get_ContextTarget: Il3ContextFilterTarget;
  property ContextState: InscContextFilterState
   read Get_ContextState;
  property ContextTarget: Il3ContextFilterTarget
   read Get_ContextTarget;
 end;//IContextParams_ContextChanged_Params

 Op_ContextParams_ContextChanged = class
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
  ['{C3428A6F-9C03-4D2C-B279-FBD13C2F869D}']
  function Get_Data: InsSelectedAttributesIterators;
  property Data: InsSelectedAttributesIterators
   read Get_Data;
 end;//ISelectedList_RefreshValues_Params

 Op_SelectedList_RefreshValues = class
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

implementation

uses
 l3ImplUses
 , l3CProtoObject
;

type
 TAttributeTree_ExternalCharPressed_Params = class(Tl3CProtoObject, IAttributeTree_ExternalCharPressed_Params)
  {* Реализация IAttributeTree_ExternalCharPressed_Params }
  private
   f_Char: Il3CString;
  protected
   function Get_Char: Il3CString;
   procedure ClearFields; override;
  public
   constructor Create(const aChar: Il3CString); reintroduce;
    {* Конструктор TAttributeTree_ExternalCharPressed_Params }
   class function Make(const aChar: Il3CString): IAttributeTree_ExternalCharPressed_Params; reintroduce;
    {* Фабрика TAttributeTree_ExternalCharPressed_Params }
 end;//TAttributeTree_ExternalCharPressed_Params

 TAttributeTree_SetCurrent_Params = class(Tl3CProtoObject, IAttributeTree_SetCurrent_Params)
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
    aExpand: Boolean); reintroduce;
    {* Конструктор TAttributeTree_SetCurrent_Params }
   class function Make(const aNode: Il3SimpleNode;
    aExpand: Boolean): IAttributeTree_SetCurrent_Params; reintroduce;
    {* Фабрика TAttributeTree_SetCurrent_Params }
 end;//TAttributeTree_SetCurrent_Params

 TAttributeTree_DropAllLogicSelection_Params = class(Tl3CProtoObject, IAttributeTree_DropAllLogicSelection_Params)
  {* Реализация IAttributeTree_DropAllLogicSelection_Params }
  private
   f_DropSelection: Boolean;
   f_NotifyMultipleChanges: Boolean;
   f_SetToTop: Boolean;
  protected
   function Get_NotifyMultipleChanges: Boolean;
   function Get_SetToTop: Boolean;
   function Get_DropSelection: Boolean;
  public
   constructor Create(aDropSelection: Boolean;
    aNotifyMultipleChanges: Boolean;
    SetToTop: Boolean); reintroduce;
    {* Конструктор TAttributeTree_DropAllLogicSelection_Params }
   class function Make(aDropSelection: Boolean;
    aNotifyMultipleChanges: Boolean;
    SetToTop: Boolean): IAttributeTree_DropAllLogicSelection_Params; reintroduce;
    {* Фабрика TAttributeTree_DropAllLogicSelection_Params }
 end;//TAttributeTree_DropAllLogicSelection_Params

 TAttributeTree_Invalidate_Params = class(Tl3CProtoObject, IAttributeTree_Invalidate_Params)
  {* Реализация IAttributeTree_Invalidate_Params }
  private
   f_UserType: Integer;
  protected
   function Get_UserType: Integer;
  public
   constructor Create(aUserType: Integer); reintroduce;
    {* Конструктор TAttributeTree_Invalidate_Params }
   class function Make(aUserType: Integer): IAttributeTree_Invalidate_Params; reintroduce;
    {* Фабрика TAttributeTree_Invalidate_Params }
 end;//TAttributeTree_Invalidate_Params

 TAttributeTree_DropLogicSelection_Params = class(Tl3CProtoObject, IAttributeTree_DropLogicSelection_Params)
  {* Реализация IAttributeTree_DropLogicSelection_Params }
  private
   f_Node: INodeBase;
  protected
   function Get_Node: INodeBase;
   procedure ClearFields; override;
  public
   constructor Create(const aNode: INodeBase); reintroduce;
    {* Конструктор TAttributeTree_DropLogicSelection_Params }
   class function Make(const aNode: INodeBase): IAttributeTree_DropLogicSelection_Params; reintroduce;
    {* Фабрика TAttributeTree_DropLogicSelection_Params }
 end;//TAttributeTree_DropLogicSelection_Params

 TAttributeTree_LoadQuery_Params = class(Tl3CProtoObject, IAttributeTree_LoadQuery_Params)
  {* Реализация IAttributeTree_LoadQuery_Params }
  private
   f_Query: IQuery;
  protected
   function Get_Query: IQuery;
   procedure ClearFields; override;
  public
   constructor Create(const aQuery: IQuery); reintroduce;
    {* Конструктор TAttributeTree_LoadQuery_Params }
   class function Make(const aQuery: IQuery): IAttributeTree_LoadQuery_Params; reintroduce;
    {* Фабрика TAttributeTree_LoadQuery_Params }
 end;//TAttributeTree_LoadQuery_Params

 TAttributeTree_SetOneLevelCurrent_Params = class(Tl3CProtoObject, IAttributeTree_SetOneLevelCurrent_Params)
  {* Реализация IAttributeTree_SetOneLevelCurrent_Params }
  private
   f_Node: Il3SimpleNode;
  protected
   function Get_Node: Il3SimpleNode;
   procedure ClearFields; override;
  public
   constructor Create(const aNode: Il3SimpleNode); reintroduce;
    {* Конструктор TAttributeTree_SetOneLevelCurrent_Params }
   class function Make(const aNode: Il3SimpleNode): IAttributeTree_SetOneLevelCurrent_Params; reintroduce;
    {* Фабрика TAttributeTree_SetOneLevelCurrent_Params }
 end;//TAttributeTree_SetOneLevelCurrent_Params

 TSearchParameters_IsQueryEmpty_Params = class(Tl3CProtoObject, ISearchParameters_IsQueryEmpty_Params)
  {* Реализация ISearchParameters_IsQueryEmpty_Params }
  private
   f_ResultValue: Boolean;
  protected
   function Get_ResultValue: Boolean;
   procedure Set_ResultValue(aValue: Boolean);
  public
   constructor Create; reintroduce;
    {* Конструктор TSearchParameters_IsQueryEmpty_Params }
   class function Make: ISearchParameters_IsQueryEmpty_Params; reintroduce;
    {* Фабрика TSearchParameters_IsQueryEmpty_Params }
 end;//TSearchParameters_IsQueryEmpty_Params

 TSearchParameters_GetQuery_Params = class(Tl3CProtoObject, ISearchParameters_GetQuery_Params)
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
   constructor Create(aIgnoreError: Boolean); reintroduce;
    {* Конструктор TSearchParameters_GetQuery_Params }
   class function Make(aIgnoreError: Boolean): ISearchParameters_GetQuery_Params; reintroduce;
    {* Фабрика TSearchParameters_GetQuery_Params }
 end;//TSearchParameters_GetQuery_Params

 TSearchParameters_IsQuerySaved_Params = class(Tl3CProtoObject, ISearchParameters_IsQuerySaved_Params)
  {* Реализация ISearchParameters_IsQuerySaved_Params }
  private
   f_ResultValue: Boolean;
  protected
   function Get_ResultValue: Boolean;
   procedure Set_ResultValue(aValue: Boolean);
  public
   constructor Create; reintroduce;
    {* Конструктор TSearchParameters_IsQuerySaved_Params }
   class function Make: ISearchParameters_IsQuerySaved_Params; reintroduce;
    {* Фабрика TSearchParameters_IsQuerySaved_Params }
 end;//TSearchParameters_IsQuerySaved_Params

 TSearchParameters_SetQuery_Params = class(Tl3CProtoObject, ISearchParameters_SetQuery_Params)
  {* Реализация ISearchParameters_SetQuery_Params }
  private
   f_Query: IQuery;
  protected
   function Get_Query: IQuery;
   procedure ClearFields; override;
  public
   constructor Create(const aQuery: IQuery); reintroduce;
    {* Конструктор TSearchParameters_SetQuery_Params }
   class function Make(const aQuery: IQuery): ISearchParameters_SetQuery_Params; reintroduce;
    {* Фабрика TSearchParameters_SetQuery_Params }
 end;//TSearchParameters_SetQuery_Params

 TAttributeTree_SaveToQuery_Params = class(Tl3CProtoObject, IAttributeTree_SaveToQuery_Params)
  {* Реализация IAttributeTree_SaveToQuery_Params }
  private
   f_Query: IQuery;
  protected
   function Get_Query: IQuery;
   procedure ClearFields; override;
  public
   constructor Create(const aQuery: IQuery); reintroduce;
    {* Конструктор TAttributeTree_SaveToQuery_Params }
   class function Make(const aQuery: IQuery): IAttributeTree_SaveToQuery_Params; reintroduce;
    {* Фабрика TAttributeTree_SaveToQuery_Params }
 end;//TAttributeTree_SaveToQuery_Params

 TAttribute_DefaultAction_Params = class(Tl3CProtoObject, IAttribute_DefaultAction_Params)
  {* Реализация IAttribute_DefaultAction_Params }
  private
   f_nIndex: Integer;
  protected
   function Get_nIndex: Integer;
  public
   constructor Create(anIndex: Integer); reintroduce;
    {* Конструктор TAttribute_DefaultAction_Params }
   class function Make(anIndex: Integer): IAttribute_DefaultAction_Params; reintroduce;
    {* Фабрика TAttribute_DefaultAction_Params }
 end;//TAttribute_DefaultAction_Params

 TContext_SetContext_Params = class(Tl3CProtoObject, IContext_SetContext_Params)
  {* Реализация IContext_SetContext_Params }
  private
   f_State: InscContextFilterState;
  protected
   function Get_State: InscContextFilterState;
   procedure ClearFields; override;
  public
   constructor Create(const aState: InscContextFilterState); reintroduce;
    {* Конструктор TContext_SetContext_Params }
   class function Make(const aState: InscContextFilterState): IContext_SetContext_Params; reintroduce;
    {* Фабрика TContext_SetContext_Params }
 end;//TContext_SetContext_Params

 TContext_SyncContextParams_Params = class(Tl3CProtoObject, IContext_SyncContextParams_Params)
  {* Реализация IContext_SyncContextParams_Params }
  private
   f_AdditionalFilter: TnsFilterType;
  protected
   function Get_AdditionalFilter: TnsFilterType;
  public
   constructor Create(aAdditionalFilter: TnsFilterType); reintroduce;
    {* Конструктор TContext_SyncContextParams_Params }
   class function Make(aAdditionalFilter: TnsFilterType): IContext_SyncContextParams_Params; reintroduce;
    {* Фабрика TContext_SyncContextParams_Params }
 end;//TContext_SyncContextParams_Params

 TAttributeTree_SetParent_Params = class(Tl3CProtoObject, IAttributeTree_SetParent_Params)
  {* Реализация IAttributeTree_SetParent_Params }
  private
   f_Parent: Il3SimpleNode;
  protected
   function Get_Parent: Il3SimpleNode;
   procedure ClearFields; override;
  public
   constructor Create(const aParent: Il3SimpleNode); reintroduce;
    {* Конструктор TAttributeTree_SetParent_Params }
   class function Make(const aParent: Il3SimpleNode): IAttributeTree_SetParent_Params; reintroduce;
    {* Фабрика TAttributeTree_SetParent_Params }
 end;//TAttributeTree_SetParent_Params

 TAttributeTree_ExtSetRoot_Params = class(Tl3CProtoObject, IAttributeTree_ExtSetRoot_Params)
  {* Реализация IAttributeTree_ExtSetRoot_Params }
  private
   f_Root: INodeBase;
  protected
   function Get_Root: INodeBase;
   procedure ClearFields; override;
  public
   constructor Create(const aRoot: INodeBase); reintroduce;
    {* Конструктор TAttributeTree_ExtSetRoot_Params }
   class function Make(const aRoot: INodeBase): IAttributeTree_ExtSetRoot_Params; reintroduce;
    {* Фабрика TAttributeTree_ExtSetRoot_Params }
 end;//TAttributeTree_ExtSetRoot_Params

 TAttributeTree_SetRoot_Params = class(Tl3CProtoObject, IAttributeTree_SetRoot_Params)
  {* Реализация IAttributeTree_SetRoot_Params }
  private
   f_Tag: Il3CString;
  protected
   function Get_Tag: Il3CString;
   procedure ClearFields; override;
  public
   constructor Create(const aTag: Il3CString); reintroduce;
    {* Конструктор TAttributeTree_SetRoot_Params }
   class function Make(const aTag: Il3CString): IAttributeTree_SetRoot_Params; reintroduce;
    {* Фабрика TAttributeTree_SetRoot_Params }
 end;//TAttributeTree_SetRoot_Params

 TAttributeTree_ChangeRoot_Params = class(Tl3CProtoObject, IAttributeTree_ChangeRoot_Params)
  {* Реализация IAttributeTree_ChangeRoot_Params }
  private
   f_Tag: Il3CString;
   f_Root: Il3SimpleNode;
   f_Current: Il3SimpleNode;
  protected
   function Get_Root: Il3SimpleNode;
   function Get_Current: Il3SimpleNode;
   function Get_Tag: Il3CString;
   procedure ClearFields; override;
  public
   constructor Create(const aTag: Il3CString;
    const aRoot: Il3SimpleNode;
    const aCurrent: Il3SimpleNode); reintroduce;
    {* Конструктор TAttributeTree_ChangeRoot_Params }
   class function Make(const aTag: Il3CString;
    const aRoot: Il3SimpleNode;
    const aCurrent: Il3SimpleNode): IAttributeTree_ChangeRoot_Params; reintroduce;
    {* Фабрика TAttributeTree_ChangeRoot_Params }
 end;//TAttributeTree_ChangeRoot_Params

 TContextParams_ContextChanged_Params = class(Tl3CProtoObject, IContextParams_ContextChanged_Params)
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
    {* Конструктор TContextParams_ContextChanged_Params }
   class function Make(const aContextState: InscContextFilterState;
    const aContextTarget: Il3ContextFilterTarget): IContextParams_ContextChanged_Params; reintroduce;
    {* Фабрика TContextParams_ContextChanged_Params }
 end;//TContextParams_ContextChanged_Params

 TSelectedList_RefreshValues_Params = class(Tl3CProtoObject, ISelectedList_RefreshValues_Params)
  {* Реализация ISelectedList_RefreshValues_Params }
  private
   f_Data: InsSelectedAttributesIterators;
  protected
   function Get_Data: InsSelectedAttributesIterators;
   procedure ClearFields; override;
  public
   constructor Create(const aData: InsSelectedAttributesIterators); reintroduce;
    {* Конструктор TSelectedList_RefreshValues_Params }
   class function Make(const aData: InsSelectedAttributesIterators): ISelectedList_RefreshValues_Params; reintroduce;
    {* Фабрика TSelectedList_RefreshValues_Params }
 end;//TSelectedList_RefreshValues_Params

constructor TAttributeTree_ExternalCharPressed_Params.Create(const aChar: Il3CString);
 {* Конструктор TAttributeTree_ExternalCharPressed_Params }
//#UC START# *B72DF8213579_19619D84F84A_var*
//#UC END# *B72DF8213579_19619D84F84A_var*
begin
//#UC START# *B72DF8213579_19619D84F84A_impl*
 !!! Needs to be implemented !!!
//#UC END# *B72DF8213579_19619D84F84A_impl*
end;//TAttributeTree_ExternalCharPressed_Params.Create

class function TAttributeTree_ExternalCharPressed_Params.Make(const aChar: Il3CString): IAttributeTree_ExternalCharPressed_Params;
 {* Фабрика TAttributeTree_ExternalCharPressed_Params }
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
//#UC START# *3A6C70CEC645_19619D84F84Aget_var*
//#UC END# *3A6C70CEC645_19619D84F84Aget_var*
begin
//#UC START# *3A6C70CEC645_19619D84F84Aget_impl*
 !!! Needs to be implemented !!!
//#UC END# *3A6C70CEC645_19619D84F84Aget_impl*
end;//TAttributeTree_ExternalCharPressed_Params.Get_Char

procedure TAttributeTree_ExternalCharPressed_Params.ClearFields;
begin
 f_Char := nil;
 inherited;
end;//TAttributeTree_ExternalCharPressed_Params.ClearFields

class function Op_AttributeTree_ExternalCharPressed.Call(const aTarget: IvcmEntity;
 const aChar: Il3CString): Boolean;
 {* Вызов операции AttributeTree.ExternalCharPressed у сущности }
//#UC START# *FFB60C38D9F6_4B69F9959ED9_var*
//#UC END# *FFB60C38D9F6_4B69F9959ED9_var*
begin
//#UC START# *FFB60C38D9F6_4B69F9959ED9_impl*
 !!! Needs to be implemented !!!
//#UC END# *FFB60C38D9F6_4B69F9959ED9_impl*
end;//Op_AttributeTree_ExternalCharPressed.Call

class function Op_AttributeTree_ExternalCharPressed.Call(const aTarget: IvcmAggregate;
 const aChar: Il3CString): Boolean;
 {* Вызов операции AttributeTree.ExternalCharPressed у агрегации }
//#UC START# *2FF5CC286447_4B69F9959ED9_var*
//#UC END# *2FF5CC286447_4B69F9959ED9_var*
begin
//#UC START# *2FF5CC286447_4B69F9959ED9_impl*
 !!! Needs to be implemented !!!
//#UC END# *2FF5CC286447_4B69F9959ED9_impl*
end;//Op_AttributeTree_ExternalCharPressed.Call

class function Op_AttributeTree_ExternalCharPressed.Call(const aTarget: IvcmEntityForm;
 const aChar: Il3CString): Boolean;
 {* Вызов операции AttributeTree.ExternalCharPressed у формы }
//#UC START# *4046CA89969F_4B69F9959ED9_var*
//#UC END# *4046CA89969F_4B69F9959ED9_var*
begin
//#UC START# *4046CA89969F_4B69F9959ED9_impl*
 !!! Needs to be implemented !!!
//#UC END# *4046CA89969F_4B69F9959ED9_impl*
end;//Op_AttributeTree_ExternalCharPressed.Call

class function Op_AttributeTree_ExternalCharPressed.Call(const aTarget: IvcmContainer;
 const aChar: Il3CString): Boolean;
 {* Вызов операции AttributeTree.ExternalCharPressed у контейнера }
//#UC START# *382F4F3C0BB7_4B69F9959ED9_var*
//#UC END# *382F4F3C0BB7_4B69F9959ED9_var*
begin
//#UC START# *382F4F3C0BB7_4B69F9959ED9_impl*
 !!! Needs to be implemented !!!
//#UC END# *382F4F3C0BB7_4B69F9959ED9_impl*
end;//Op_AttributeTree_ExternalCharPressed.Call

constructor TAttributeTree_SetCurrent_Params.Create(const aNode: Il3SimpleNode;
 aExpand: Boolean);
 {* Конструктор TAttributeTree_SetCurrent_Params }
//#UC START# *2F02A6CE80DF_1C00314F1D3B_var*
//#UC END# *2F02A6CE80DF_1C00314F1D3B_var*
begin
//#UC START# *2F02A6CE80DF_1C00314F1D3B_impl*
 !!! Needs to be implemented !!!
//#UC END# *2F02A6CE80DF_1C00314F1D3B_impl*
end;//TAttributeTree_SetCurrent_Params.Create

class function TAttributeTree_SetCurrent_Params.Make(const aNode: Il3SimpleNode;
 aExpand: Boolean): IAttributeTree_SetCurrent_Params;
 {* Фабрика TAttributeTree_SetCurrent_Params }
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
//#UC START# *157207BA07DD_1C00314F1D3Bget_var*
//#UC END# *157207BA07DD_1C00314F1D3Bget_var*
begin
//#UC START# *157207BA07DD_1C00314F1D3Bget_impl*
 !!! Needs to be implemented !!!
//#UC END# *157207BA07DD_1C00314F1D3Bget_impl*
end;//TAttributeTree_SetCurrent_Params.Get_Node

function TAttributeTree_SetCurrent_Params.Get_Expand: Boolean;
//#UC START# *78198CFA4400_1C00314F1D3Bget_var*
//#UC END# *78198CFA4400_1C00314F1D3Bget_var*
begin
//#UC START# *78198CFA4400_1C00314F1D3Bget_impl*
 !!! Needs to be implemented !!!
//#UC END# *78198CFA4400_1C00314F1D3Bget_impl*
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
//#UC START# *0353C65667C3_02196BA5F0BB_var*
//#UC END# *0353C65667C3_02196BA5F0BB_var*
begin
//#UC START# *0353C65667C3_02196BA5F0BB_impl*
 !!! Needs to be implemented !!!
//#UC END# *0353C65667C3_02196BA5F0BB_impl*
end;//Op_AttributeTree_SetCurrent.Call

class function Op_AttributeTree_SetCurrent.Call(const aTarget: IvcmAggregate;
 const aNode: Il3SimpleNode;
 aExpand: Boolean = False): Boolean;
 {* Вызов операции AttributeTree.SetCurrent у агрегации }
//#UC START# *33938644F213_02196BA5F0BB_var*
//#UC END# *33938644F213_02196BA5F0BB_var*
begin
//#UC START# *33938644F213_02196BA5F0BB_impl*
 !!! Needs to be implemented !!!
//#UC END# *33938644F213_02196BA5F0BB_impl*
end;//Op_AttributeTree_SetCurrent.Call

class function Op_AttributeTree_SetCurrent.Call(const aTarget: IvcmEntityForm;
 const aNode: Il3SimpleNode;
 aExpand: Boolean = False): Boolean;
 {* Вызов операции AttributeTree.SetCurrent у формы }
//#UC START# *0736598FF0B3_02196BA5F0BB_var*
//#UC END# *0736598FF0B3_02196BA5F0BB_var*
begin
//#UC START# *0736598FF0B3_02196BA5F0BB_impl*
 !!! Needs to be implemented !!!
//#UC END# *0736598FF0B3_02196BA5F0BB_impl*
end;//Op_AttributeTree_SetCurrent.Call

class function Op_AttributeTree_SetCurrent.Call(const aTarget: IvcmContainer;
 const aNode: Il3SimpleNode;
 aExpand: Boolean = False): Boolean;
 {* Вызов операции AttributeTree.SetCurrent у контейнера }
//#UC START# *AEFEA71453AE_02196BA5F0BB_var*
//#UC END# *AEFEA71453AE_02196BA5F0BB_var*
begin
//#UC START# *AEFEA71453AE_02196BA5F0BB_impl*
 !!! Needs to be implemented !!!
//#UC END# *AEFEA71453AE_02196BA5F0BB_impl*
end;//Op_AttributeTree_SetCurrent.Call

constructor TAttributeTree_DropAllLogicSelection_Params.Create(aDropSelection: Boolean;
 aNotifyMultipleChanges: Boolean;
 SetToTop: Boolean);
 {* Конструктор TAttributeTree_DropAllLogicSelection_Params }
//#UC START# *EF014E2D1DDF_AF2580BBE0F5_var*
//#UC END# *EF014E2D1DDF_AF2580BBE0F5_var*
begin
//#UC START# *EF014E2D1DDF_AF2580BBE0F5_impl*
 !!! Needs to be implemented !!!
//#UC END# *EF014E2D1DDF_AF2580BBE0F5_impl*
end;//TAttributeTree_DropAllLogicSelection_Params.Create

class function TAttributeTree_DropAllLogicSelection_Params.Make(aDropSelection: Boolean;
 aNotifyMultipleChanges: Boolean;
 SetToTop: Boolean): IAttributeTree_DropAllLogicSelection_Params;
 {* Фабрика TAttributeTree_DropAllLogicSelection_Params }
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

function TAttributeTree_DropAllLogicSelection_Params.Get_NotifyMultipleChanges: Boolean;
//#UC START# *1CDD0BF4DDC7_AF2580BBE0F5get_var*
//#UC END# *1CDD0BF4DDC7_AF2580BBE0F5get_var*
begin
//#UC START# *1CDD0BF4DDC7_AF2580BBE0F5get_impl*
 !!! Needs to be implemented !!!
//#UC END# *1CDD0BF4DDC7_AF2580BBE0F5get_impl*
end;//TAttributeTree_DropAllLogicSelection_Params.Get_NotifyMultipleChanges

function TAttributeTree_DropAllLogicSelection_Params.Get_SetToTop: Boolean;
//#UC START# *1E4BD87CFA5D_AF2580BBE0F5get_var*
//#UC END# *1E4BD87CFA5D_AF2580BBE0F5get_var*
begin
//#UC START# *1E4BD87CFA5D_AF2580BBE0F5get_impl*
 !!! Needs to be implemented !!!
//#UC END# *1E4BD87CFA5D_AF2580BBE0F5get_impl*
end;//TAttributeTree_DropAllLogicSelection_Params.Get_SetToTop

function TAttributeTree_DropAllLogicSelection_Params.Get_DropSelection: Boolean;
//#UC START# *E476629AFD04_AF2580BBE0F5get_var*
//#UC END# *E476629AFD04_AF2580BBE0F5get_var*
begin
//#UC START# *E476629AFD04_AF2580BBE0F5get_impl*
 !!! Needs to be implemented !!!
//#UC END# *E476629AFD04_AF2580BBE0F5get_impl*
end;//TAttributeTree_DropAllLogicSelection_Params.Get_DropSelection

class function Op_AttributeTree_DropAllLogicSelection.Call(const aTarget: IvcmEntity;
 aDropSelection: Boolean;
 aNotifyMultipleChanges: Boolean = False;
 SetToTop: Boolean = True): Boolean;
 {* Вызов операции AttributeTree.DropAllLogicSelection у сущности }
//#UC START# *0FBC530C349F_D0D862CA0CA2_var*
//#UC END# *0FBC530C349F_D0D862CA0CA2_var*
begin
//#UC START# *0FBC530C349F_D0D862CA0CA2_impl*
 !!! Needs to be implemented !!!
//#UC END# *0FBC530C349F_D0D862CA0CA2_impl*
end;//Op_AttributeTree_DropAllLogicSelection.Call

class function Op_AttributeTree_DropAllLogicSelection.Call(const aTarget: IvcmAggregate;
 aDropSelection: Boolean;
 aNotifyMultipleChanges: Boolean = False;
 SetToTop: Boolean = True): Boolean;
 {* Вызов операции AttributeTree.DropAllLogicSelection у агрегации }
//#UC START# *3FFC12FABEEF_D0D862CA0CA2_var*
//#UC END# *3FFC12FABEEF_D0D862CA0CA2_var*
begin
//#UC START# *3FFC12FABEEF_D0D862CA0CA2_impl*
 !!! Needs to be implemented !!!
//#UC END# *3FFC12FABEEF_D0D862CA0CA2_impl*
end;//Op_AttributeTree_DropAllLogicSelection.Call

class function Op_AttributeTree_DropAllLogicSelection.Call(const aTarget: IvcmEntityForm;
 aDropSelection: Boolean;
 aNotifyMultipleChanges: Boolean = False;
 SetToTop: Boolean = True): Boolean;
 {* Вызов операции AttributeTree.DropAllLogicSelection у формы }
//#UC START# *739C46617986_D0D862CA0CA2_var*
//#UC END# *739C46617986_D0D862CA0CA2_var*
begin
//#UC START# *739C46617986_D0D862CA0CA2_impl*
 !!! Needs to be implemented !!!
//#UC END# *739C46617986_D0D862CA0CA2_impl*
end;//Op_AttributeTree_DropAllLogicSelection.Call

class function Op_AttributeTree_DropAllLogicSelection.Call(const aTarget: IvcmContainer;
 aDropSelection: Boolean;
 aNotifyMultipleChanges: Boolean = False;
 SetToTop: Boolean = True): Boolean;
 {* Вызов операции AttributeTree.DropAllLogicSelection у контейнера }
//#UC START# *BD744DC42BB3_D0D862CA0CA2_var*
//#UC END# *BD744DC42BB3_D0D862CA0CA2_var*
begin
//#UC START# *BD744DC42BB3_D0D862CA0CA2_impl*
 !!! Needs to be implemented !!!
//#UC END# *BD744DC42BB3_D0D862CA0CA2_impl*
end;//Op_AttributeTree_DropAllLogicSelection.Call

constructor TAttributeTree_Invalidate_Params.Create(aUserType: Integer);
 {* Конструктор TAttributeTree_Invalidate_Params }
//#UC START# *06DECFBD0E5E_178F7C52214E_var*
//#UC END# *06DECFBD0E5E_178F7C52214E_var*
begin
//#UC START# *06DECFBD0E5E_178F7C52214E_impl*
 !!! Needs to be implemented !!!
//#UC END# *06DECFBD0E5E_178F7C52214E_impl*
end;//TAttributeTree_Invalidate_Params.Create

class function TAttributeTree_Invalidate_Params.Make(aUserType: Integer): IAttributeTree_Invalidate_Params;
 {* Фабрика TAttributeTree_Invalidate_Params }
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
//#UC START# *4ADEB6E2D2BF_178F7C52214Eget_var*
//#UC END# *4ADEB6E2D2BF_178F7C52214Eget_var*
begin
//#UC START# *4ADEB6E2D2BF_178F7C52214Eget_impl*
 !!! Needs to be implemented !!!
//#UC END# *4ADEB6E2D2BF_178F7C52214Eget_impl*
end;//TAttributeTree_Invalidate_Params.Get_UserType

class function Op_AttributeTree_Invalidate.Call(const aTarget: IvcmEntity;
 aUserType: Integer): Boolean;
 {* Вызов операции AttributeTree.Invalidate у сущности }
//#UC START# *E54508CD9F98_20CFE07287E7_var*
//#UC END# *E54508CD9F98_20CFE07287E7_var*
begin
//#UC START# *E54508CD9F98_20CFE07287E7_impl*
 !!! Needs to be implemented !!!
//#UC END# *E54508CD9F98_20CFE07287E7_impl*
end;//Op_AttributeTree_Invalidate.Call

class function Op_AttributeTree_Invalidate.Call(const aTarget: IvcmAggregate;
 aUserType: Integer): Boolean;
 {* Вызов операции AttributeTree.Invalidate у агрегации }
//#UC START# *1584C8BC29E9_20CFE07287E7_var*
//#UC END# *1584C8BC29E9_20CFE07287E7_var*
begin
//#UC START# *1584C8BC29E9_20CFE07287E7_impl*
 !!! Needs to be implemented !!!
//#UC END# *1584C8BC29E9_20CFE07287E7_impl*
end;//Op_AttributeTree_Invalidate.Call

class function Op_AttributeTree_Invalidate.Call(const aTarget: IvcmEntityForm;
 aUserType: Integer): Boolean;
 {* Вызов операции AttributeTree.Invalidate у формы }
//#UC START# *947B7F4E9393_20CFE07287E7_var*
//#UC END# *947B7F4E9393_20CFE07287E7_var*
begin
//#UC START# *947B7F4E9393_20CFE07287E7_impl*
 !!! Needs to be implemented !!!
//#UC END# *947B7F4E9393_20CFE07287E7_impl*
end;//Op_AttributeTree_Invalidate.Call

class function Op_AttributeTree_Invalidate.Call(const aTarget: IvcmContainer;
 aUserType: Integer): Boolean;
 {* Вызов операции AttributeTree.Invalidate у контейнера }
//#UC START# *D98D37E4D9E8_20CFE07287E7_var*
//#UC END# *D98D37E4D9E8_20CFE07287E7_var*
begin
//#UC START# *D98D37E4D9E8_20CFE07287E7_impl*
 !!! Needs to be implemented !!!
//#UC END# *D98D37E4D9E8_20CFE07287E7_impl*
end;//Op_AttributeTree_Invalidate.Call

constructor TAttributeTree_DropLogicSelection_Params.Create(const aNode: INodeBase);
 {* Конструктор TAttributeTree_DropLogicSelection_Params }
//#UC START# *A583DC5F7A5D_852B5287573D_var*
//#UC END# *A583DC5F7A5D_852B5287573D_var*
begin
//#UC START# *A583DC5F7A5D_852B5287573D_impl*
 !!! Needs to be implemented !!!
//#UC END# *A583DC5F7A5D_852B5287573D_impl*
end;//TAttributeTree_DropLogicSelection_Params.Create

class function TAttributeTree_DropLogicSelection_Params.Make(const aNode: INodeBase): IAttributeTree_DropLogicSelection_Params;
 {* Фабрика TAttributeTree_DropLogicSelection_Params }
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
//#UC START# *CD2AA7D7B471_852B5287573Dget_var*
//#UC END# *CD2AA7D7B471_852B5287573Dget_var*
begin
//#UC START# *CD2AA7D7B471_852B5287573Dget_impl*
 !!! Needs to be implemented !!!
//#UC END# *CD2AA7D7B471_852B5287573Dget_impl*
end;//TAttributeTree_DropLogicSelection_Params.Get_Node

procedure TAttributeTree_DropLogicSelection_Params.ClearFields;
begin
 f_Node := nil;
 inherited;
end;//TAttributeTree_DropLogicSelection_Params.ClearFields

class function Op_AttributeTree_DropLogicSelection.Call(const aTarget: IvcmEntity;
 const aNode: INodeBase): Boolean;
 {* Вызов операции AttributeTree.DropLogicSelection у сущности }
//#UC START# *CF6AE137246F_27D2BA5A20F6_var*
//#UC END# *CF6AE137246F_27D2BA5A20F6_var*
begin
//#UC START# *CF6AE137246F_27D2BA5A20F6_impl*
 !!! Needs to be implemented !!!
//#UC END# *CF6AE137246F_27D2BA5A20F6_impl*
end;//Op_AttributeTree_DropLogicSelection.Call

class function Op_AttributeTree_DropLogicSelection.Call(const aTarget: IvcmAggregate;
 const aNode: INodeBase): Boolean;
 {* Вызов операции AttributeTree.DropLogicSelection у агрегации }
//#UC START# *FFAAA125AEBF_27D2BA5A20F6_var*
//#UC END# *FFAAA125AEBF_27D2BA5A20F6_var*
begin
//#UC START# *FFAAA125AEBF_27D2BA5A20F6_impl*
 !!! Needs to be implemented !!!
//#UC END# *FFAAA125AEBF_27D2BA5A20F6_impl*
end;//Op_AttributeTree_DropLogicSelection.Call

class function Op_AttributeTree_DropLogicSelection.Call(const aTarget: IvcmEntityForm;
 const aNode: INodeBase): Boolean;
 {* Вызов операции AttributeTree.DropLogicSelection у формы }
//#UC START# *CBC46D7C5097_27D2BA5A20F6_var*
//#UC END# *CBC46D7C5097_27D2BA5A20F6_var*
begin
//#UC START# *CBC46D7C5097_27D2BA5A20F6_impl*
 !!! Needs to be implemented !!!
//#UC END# *CBC46D7C5097_27D2BA5A20F6_impl*
end;//Op_AttributeTree_DropLogicSelection.Call

class function Op_AttributeTree_DropLogicSelection.Call(const aTarget: IvcmContainer;
 const aNode: INodeBase): Boolean;
 {* Вызов операции AttributeTree.DropLogicSelection у контейнера }
//#UC START# *A543BF1AC325_27D2BA5A20F6_var*
//#UC END# *A543BF1AC325_27D2BA5A20F6_var*
begin
//#UC START# *A543BF1AC325_27D2BA5A20F6_impl*
 !!! Needs to be implemented !!!
//#UC END# *A543BF1AC325_27D2BA5A20F6_impl*
end;//Op_AttributeTree_DropLogicSelection.Call

constructor TAttributeTree_LoadQuery_Params.Create(const aQuery: IQuery);
 {* Конструктор TAttributeTree_LoadQuery_Params }
//#UC START# *B92B623F01DE_0B19A88CE8A2_var*
//#UC END# *B92B623F01DE_0B19A88CE8A2_var*
begin
//#UC START# *B92B623F01DE_0B19A88CE8A2_impl*
 !!! Needs to be implemented !!!
//#UC END# *B92B623F01DE_0B19A88CE8A2_impl*
end;//TAttributeTree_LoadQuery_Params.Create

class function TAttributeTree_LoadQuery_Params.Make(const aQuery: IQuery): IAttributeTree_LoadQuery_Params;
 {* Фабрика TAttributeTree_LoadQuery_Params }
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
//#UC START# *ED368647BA93_0B19A88CE8A2get_var*
//#UC END# *ED368647BA93_0B19A88CE8A2get_var*
begin
//#UC START# *ED368647BA93_0B19A88CE8A2get_impl*
 !!! Needs to be implemented !!!
//#UC END# *ED368647BA93_0B19A88CE8A2get_impl*
end;//TAttributeTree_LoadQuery_Params.Get_Query

procedure TAttributeTree_LoadQuery_Params.ClearFields;
begin
 f_Query := nil;
 inherited;
end;//TAttributeTree_LoadQuery_Params.ClearFields

class function Op_AttributeTree_LoadQuery.Call(const aTarget: IvcmEntity;
 const aQuery: IQuery): Boolean;
 {* Вызов операции AttributeTree.LoadQuery у сущности }
//#UC START# *3E194E280AC2_57BCCAD7CBFD_var*
//#UC END# *3E194E280AC2_57BCCAD7CBFD_var*
begin
//#UC START# *3E194E280AC2_57BCCAD7CBFD_impl*
 !!! Needs to be implemented !!!
//#UC END# *3E194E280AC2_57BCCAD7CBFD_impl*
end;//Op_AttributeTree_LoadQuery.Call

class function Op_AttributeTree_LoadQuery.Call(const aTarget: IvcmAggregate;
 const aQuery: IQuery): Boolean;
 {* Вызов операции AttributeTree.LoadQuery у агрегации }
//#UC START# *6E590E169512_57BCCAD7CBFD_var*
//#UC END# *6E590E169512_57BCCAD7CBFD_var*
begin
//#UC START# *6E590E169512_57BCCAD7CBFD_impl*
 !!! Needs to be implemented !!!
//#UC END# *6E590E169512_57BCCAD7CBFD_impl*
end;//Op_AttributeTree_LoadQuery.Call

class function Op_AttributeTree_LoadQuery.Call(const aTarget: IvcmEntityForm;
 const aQuery: IQuery): Boolean;
 {* Вызов операции AttributeTree.LoadQuery у формы }
//#UC START# *5BB5556CF40C_57BCCAD7CBFD_var*
//#UC END# *5BB5556CF40C_57BCCAD7CBFD_var*
begin
//#UC START# *5BB5556CF40C_57BCCAD7CBFD_impl*
 !!! Needs to be implemented !!!
//#UC END# *5BB5556CF40C_57BCCAD7CBFD_impl*
end;//Op_AttributeTree_LoadQuery.Call

class function Op_AttributeTree_LoadQuery.Call(const aTarget: IvcmContainer;
 const aQuery: IQuery): Boolean;
 {* Вызов операции AttributeTree.LoadQuery у контейнера }
//#UC START# *E016648CAF82_57BCCAD7CBFD_var*
//#UC END# *E016648CAF82_57BCCAD7CBFD_var*
begin
//#UC START# *E016648CAF82_57BCCAD7CBFD_impl*
 !!! Needs to be implemented !!!
//#UC END# *E016648CAF82_57BCCAD7CBFD_impl*
end;//Op_AttributeTree_LoadQuery.Call

constructor TAttributeTree_SetOneLevelCurrent_Params.Create(const aNode: Il3SimpleNode);
 {* Конструктор TAttributeTree_SetOneLevelCurrent_Params }
//#UC START# *4C6C7F0F5799_BA9200FA574C_var*
//#UC END# *4C6C7F0F5799_BA9200FA574C_var*
begin
//#UC START# *4C6C7F0F5799_BA9200FA574C_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C6C7F0F5799_BA9200FA574C_impl*
end;//TAttributeTree_SetOneLevelCurrent_Params.Create

class function TAttributeTree_SetOneLevelCurrent_Params.Make(const aNode: Il3SimpleNode): IAttributeTree_SetOneLevelCurrent_Params;
 {* Фабрика TAttributeTree_SetOneLevelCurrent_Params }
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
//#UC START# *CECB42062514_BA9200FA574Cget_var*
//#UC END# *CECB42062514_BA9200FA574Cget_var*
begin
//#UC START# *CECB42062514_BA9200FA574Cget_impl*
 !!! Needs to be implemented !!!
//#UC END# *CECB42062514_BA9200FA574Cget_impl*
end;//TAttributeTree_SetOneLevelCurrent_Params.Get_Node

procedure TAttributeTree_SetOneLevelCurrent_Params.ClearFields;
begin
 f_Node := nil;
 inherited;
end;//TAttributeTree_SetOneLevelCurrent_Params.ClearFields

class function Op_AttributeTree_SetOneLevelCurrent.Call(const aTarget: IvcmEntity;
 const aNode: Il3SimpleNode): Boolean;
 {* Вызов операции AttributeTree.SetOneLevelCurrent у сущности }
//#UC START# *F5223B4B74C7_A2B96CAD0ED7_var*
//#UC END# *F5223B4B74C7_A2B96CAD0ED7_var*
begin
//#UC START# *F5223B4B74C7_A2B96CAD0ED7_impl*
 !!! Needs to be implemented !!!
//#UC END# *F5223B4B74C7_A2B96CAD0ED7_impl*
end;//Op_AttributeTree_SetOneLevelCurrent.Call

class function Op_AttributeTree_SetOneLevelCurrent.Call(const aTarget: IvcmAggregate;
 const aNode: Il3SimpleNode): Boolean;
 {* Вызов операции AttributeTree.SetOneLevelCurrent у агрегации }
//#UC START# *2561FB39FF18_A2B96CAD0ED7_var*
//#UC END# *2561FB39FF18_A2B96CAD0ED7_var*
begin
//#UC START# *2561FB39FF18_A2B96CAD0ED7_impl*
 !!! Needs to be implemented !!!
//#UC END# *2561FB39FF18_A2B96CAD0ED7_impl*
end;//Op_AttributeTree_SetOneLevelCurrent.Call

class function Op_AttributeTree_SetOneLevelCurrent.Call(const aTarget: IvcmEntityForm;
 const aNode: Il3SimpleNode): Boolean;
 {* Вызов операции AttributeTree.SetOneLevelCurrent у формы }
//#UC START# *CAEFF7483DF8_A2B96CAD0ED7_var*
//#UC END# *CAEFF7483DF8_A2B96CAD0ED7_var*
begin
//#UC START# *CAEFF7483DF8_A2B96CAD0ED7_impl*
 !!! Needs to be implemented !!!
//#UC END# *CAEFF7483DF8_A2B96CAD0ED7_impl*
end;//Op_AttributeTree_SetOneLevelCurrent.Call

class function Op_AttributeTree_SetOneLevelCurrent.Call(const aTarget: IvcmContainer;
 const aNode: Il3SimpleNode): Boolean;
 {* Вызов операции AttributeTree.SetOneLevelCurrent у контейнера }
//#UC START# *332FAAB69248_A2B96CAD0ED7_var*
//#UC END# *332FAAB69248_A2B96CAD0ED7_var*
begin
//#UC START# *332FAAB69248_A2B96CAD0ED7_impl*
 !!! Needs to be implemented !!!
//#UC END# *332FAAB69248_A2B96CAD0ED7_impl*
end;//Op_AttributeTree_SetOneLevelCurrent.Call

class function Op_AttributeTree_AddNodeIfEmpty.Call(const aTarget: IvcmEntity): Boolean;
 {* Вызов операции AttributeTree.AddNodeIfEmpty у сущности }
//#UC START# *63308BEFD283_711925FD2E51_var*
//#UC END# *63308BEFD283_711925FD2E51_var*
begin
//#UC START# *63308BEFD283_711925FD2E51_impl*
 !!! Needs to be implemented !!!
//#UC END# *63308BEFD283_711925FD2E51_impl*
end;//Op_AttributeTree_AddNodeIfEmpty.Call

class function Op_AttributeTree_AddNodeIfEmpty.Call(const aTarget: IvcmAggregate): Boolean;
 {* Вызов операции AttributeTree.AddNodeIfEmpty у агрегации }
//#UC START# *463448D35CD4_711925FD2E51_var*
//#UC END# *463448D35CD4_711925FD2E51_var*
begin
//#UC START# *463448D35CD4_711925FD2E51_impl*
 !!! Needs to be implemented !!!
//#UC END# *463448D35CD4_711925FD2E51_impl*
end;//Op_AttributeTree_AddNodeIfEmpty.Call

class function Op_AttributeTree_AddNodeIfEmpty.Call(const aTarget: IvcmEntityForm): Boolean;
 {* Вызов операции AttributeTree.AddNodeIfEmpty у формы }
//#UC START# *DCEC7053B5EC_711925FD2E51_var*
//#UC END# *DCEC7053B5EC_711925FD2E51_var*
begin
//#UC START# *DCEC7053B5EC_711925FD2E51_impl*
 !!! Needs to be implemented !!!
//#UC END# *DCEC7053B5EC_711925FD2E51_impl*
end;//Op_AttributeTree_AddNodeIfEmpty.Call

class function Op_AttributeTree_AddNodeIfEmpty.Call(const aTarget: IvcmContainer): Boolean;
 {* Вызов операции AttributeTree.AddNodeIfEmpty у контейнера }
//#UC START# *F340EC2612BD_711925FD2E51_var*
//#UC END# *F340EC2612BD_711925FD2E51_var*
begin
//#UC START# *F340EC2612BD_711925FD2E51_impl*
 !!! Needs to be implemented !!!
//#UC END# *F340EC2612BD_711925FD2E51_impl*
end;//Op_AttributeTree_AddNodeIfEmpty.Call

constructor TSearchParameters_IsQueryEmpty_Params.Create;
 {* Конструктор TSearchParameters_IsQueryEmpty_Params }
//#UC START# *DBAAAE537DC7_CF7A2565583C_var*
//#UC END# *DBAAAE537DC7_CF7A2565583C_var*
begin
//#UC START# *DBAAAE537DC7_CF7A2565583C_impl*
 !!! Needs to be implemented !!!
//#UC END# *DBAAAE537DC7_CF7A2565583C_impl*
end;//TSearchParameters_IsQueryEmpty_Params.Create

class function TSearchParameters_IsQueryEmpty_Params.Make: ISearchParameters_IsQueryEmpty_Params;
 {* Фабрика TSearchParameters_IsQueryEmpty_Params }
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
//#UC START# *0661731A00F5_CF7A2565583Cget_var*
//#UC END# *0661731A00F5_CF7A2565583Cget_var*
begin
//#UC START# *0661731A00F5_CF7A2565583Cget_impl*
 !!! Needs to be implemented !!!
//#UC END# *0661731A00F5_CF7A2565583Cget_impl*
end;//TSearchParameters_IsQueryEmpty_Params.Get_ResultValue

procedure TSearchParameters_IsQueryEmpty_Params.Set_ResultValue(aValue: Boolean);
//#UC START# *0661731A00F5_CF7A2565583Cset_var*
//#UC END# *0661731A00F5_CF7A2565583Cset_var*
begin
//#UC START# *0661731A00F5_CF7A2565583Cset_impl*
 !!! Needs to be implemented !!!
//#UC END# *0661731A00F5_CF7A2565583Cset_impl*
end;//TSearchParameters_IsQueryEmpty_Params.Set_ResultValue

class function Op_SearchParameters_IsQueryEmpty.Call(const aTarget: IvcmEntity): Boolean;
 {* Вызов операции SearchParameters.IsQueryEmpty у сущности }
//#UC START# *A21AAD6E2CBF_87B57515F73C_var*
//#UC END# *A21AAD6E2CBF_87B57515F73C_var*
begin
//#UC START# *A21AAD6E2CBF_87B57515F73C_impl*
 !!! Needs to be implemented !!!
//#UC END# *A21AAD6E2CBF_87B57515F73C_impl*
end;//Op_SearchParameters_IsQueryEmpty.Call

class function Op_SearchParameters_IsQueryEmpty.Call(const aTarget: IvcmAggregate): Boolean;
 {* Вызов операции SearchParameters.IsQueryEmpty у агрегации }
//#UC START# *D25A6D5DB70F_87B57515F73C_var*
//#UC END# *D25A6D5DB70F_87B57515F73C_var*
begin
//#UC START# *D25A6D5DB70F_87B57515F73C_impl*
 !!! Needs to be implemented !!!
//#UC END# *D25A6D5DB70F_87B57515F73C_impl*
end;//Op_SearchParameters_IsQueryEmpty.Call

class function Op_SearchParameters_IsQueryEmpty.Call(const aTarget: IvcmEntityForm): Boolean;
 {* Вызов операции SearchParameters.IsQueryEmpty у формы }
//#UC START# *4ED1F0AF2D5F_87B57515F73C_var*
//#UC END# *4ED1F0AF2D5F_87B57515F73C_var*
begin
//#UC START# *4ED1F0AF2D5F_87B57515F73C_impl*
 !!! Needs to be implemented !!!
//#UC END# *4ED1F0AF2D5F_87B57515F73C_impl*
end;//Op_SearchParameters_IsQueryEmpty.Call

class function Op_SearchParameters_IsQueryEmpty.Call(const aTarget: IvcmContainer): Boolean;
 {* Вызов операции SearchParameters.IsQueryEmpty у контейнера }
//#UC START# *195AF6706B86_87B57515F73C_var*
//#UC END# *195AF6706B86_87B57515F73C_var*
begin
//#UC START# *195AF6706B86_87B57515F73C_impl*
 !!! Needs to be implemented !!!
//#UC END# *195AF6706B86_87B57515F73C_impl*
end;//Op_SearchParameters_IsQueryEmpty.Call

constructor TSearchParameters_GetQuery_Params.Create(aIgnoreError: Boolean);
 {* Конструктор TSearchParameters_GetQuery_Params }
//#UC START# *7F8CC20F3789_EA3D2D4B0C3A_var*
//#UC END# *7F8CC20F3789_EA3D2D4B0C3A_var*
begin
//#UC START# *7F8CC20F3789_EA3D2D4B0C3A_impl*
 !!! Needs to be implemented !!!
//#UC END# *7F8CC20F3789_EA3D2D4B0C3A_impl*
end;//TSearchParameters_GetQuery_Params.Create

class function TSearchParameters_GetQuery_Params.Make(aIgnoreError: Boolean): ISearchParameters_GetQuery_Params;
 {* Фабрика TSearchParameters_GetQuery_Params }
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
//#UC START# *1F53F3B24725_EA3D2D4B0C3Aget_var*
//#UC END# *1F53F3B24725_EA3D2D4B0C3Aget_var*
begin
//#UC START# *1F53F3B24725_EA3D2D4B0C3Aget_impl*
 !!! Needs to be implemented !!!
//#UC END# *1F53F3B24725_EA3D2D4B0C3Aget_impl*
end;//TSearchParameters_GetQuery_Params.Get_IgnoreError

function TSearchParameters_GetQuery_Params.Get_ResultValue: TnsQueryInfo;
//#UC START# *A07E4872343D_EA3D2D4B0C3Aget_var*
//#UC END# *A07E4872343D_EA3D2D4B0C3Aget_var*
begin
//#UC START# *A07E4872343D_EA3D2D4B0C3Aget_impl*
 !!! Needs to be implemented !!!
//#UC END# *A07E4872343D_EA3D2D4B0C3Aget_impl*
end;//TSearchParameters_GetQuery_Params.Get_ResultValue

procedure TSearchParameters_GetQuery_Params.Set_ResultValue(const aValue: TnsQueryInfo);
//#UC START# *A07E4872343D_EA3D2D4B0C3Aset_var*
//#UC END# *A07E4872343D_EA3D2D4B0C3Aset_var*
begin
//#UC START# *A07E4872343D_EA3D2D4B0C3Aset_impl*
 !!! Needs to be implemented !!!
//#UC END# *A07E4872343D_EA3D2D4B0C3Aset_impl*
end;//TSearchParameters_GetQuery_Params.Set_ResultValue

procedure TSearchParameters_GetQuery_Params.ClearFields;
begin
 Finalize(f_ResultValue);
 inherited;
end;//TSearchParameters_GetQuery_Params.ClearFields

class function Op_SearchParameters_GetQuery.Call(const aTarget: IvcmEntity;
 aIgnoreError: Boolean = False): TnsQueryInfo;
 {* Вызов операции SearchParameters.GetQuery у сущности }
//#UC START# *593F4AD95416_17F2F5C5319E_var*
//#UC END# *593F4AD95416_17F2F5C5319E_var*
begin
//#UC START# *593F4AD95416_17F2F5C5319E_impl*
 !!! Needs to be implemented !!!
//#UC END# *593F4AD95416_17F2F5C5319E_impl*
end;//Op_SearchParameters_GetQuery.Call

class function Op_SearchParameters_GetQuery.Call(const aTarget: IvcmAggregate;
 aIgnoreError: Boolean = False): TnsQueryInfo;
 {* Вызов операции SearchParameters.GetQuery у агрегации }
//#UC START# *897F0AC7DE66_17F2F5C5319E_var*
//#UC END# *897F0AC7DE66_17F2F5C5319E_var*
begin
//#UC START# *897F0AC7DE66_17F2F5C5319E_impl*
 !!! Needs to be implemented !!!
//#UC END# *897F0AC7DE66_17F2F5C5319E_impl*
end;//Op_SearchParameters_GetQuery.Call

class function Op_SearchParameters_GetQuery.Call(const aTarget: IvcmEntityForm;
 aIgnoreError: Boolean = False): TnsQueryInfo;
 {* Вызов операции SearchParameters.GetQuery у формы }
//#UC START# *A3A17B836213_17F2F5C5319E_var*
//#UC END# *A3A17B836213_17F2F5C5319E_var*
begin
//#UC START# *A3A17B836213_17F2F5C5319E_impl*
 !!! Needs to be implemented !!!
//#UC END# *A3A17B836213_17F2F5C5319E_impl*
end;//Op_SearchParameters_GetQuery.Call

class function Op_SearchParameters_GetQuery.Call(const aTarget: IvcmContainer;
 aIgnoreError: Boolean = False): TnsQueryInfo;
 {* Вызов операции SearchParameters.GetQuery у контейнера }
//#UC START# *2D789F8ECDE6_17F2F5C5319E_var*
//#UC END# *2D789F8ECDE6_17F2F5C5319E_var*
begin
//#UC START# *2D789F8ECDE6_17F2F5C5319E_impl*
 !!! Needs to be implemented !!!
//#UC END# *2D789F8ECDE6_17F2F5C5319E_impl*
end;//Op_SearchParameters_GetQuery.Call

constructor TSearchParameters_IsQuerySaved_Params.Create;
 {* Конструктор TSearchParameters_IsQuerySaved_Params }
//#UC START# *D8C0FB506418_3AB4E9343759_var*
//#UC END# *D8C0FB506418_3AB4E9343759_var*
begin
//#UC START# *D8C0FB506418_3AB4E9343759_impl*
 !!! Needs to be implemented !!!
//#UC END# *D8C0FB506418_3AB4E9343759_impl*
end;//TSearchParameters_IsQuerySaved_Params.Create

class function TSearchParameters_IsQuerySaved_Params.Make: ISearchParameters_IsQuerySaved_Params;
 {* Фабрика TSearchParameters_IsQuerySaved_Params }
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
//#UC START# *A10F4091A71E_3AB4E9343759get_var*
//#UC END# *A10F4091A71E_3AB4E9343759get_var*
begin
//#UC START# *A10F4091A71E_3AB4E9343759get_impl*
 !!! Needs to be implemented !!!
//#UC END# *A10F4091A71E_3AB4E9343759get_impl*
end;//TSearchParameters_IsQuerySaved_Params.Get_ResultValue

procedure TSearchParameters_IsQuerySaved_Params.Set_ResultValue(aValue: Boolean);
//#UC START# *A10F4091A71E_3AB4E9343759set_var*
//#UC END# *A10F4091A71E_3AB4E9343759set_var*
begin
//#UC START# *A10F4091A71E_3AB4E9343759set_impl*
 !!! Needs to be implemented !!!
//#UC END# *A10F4091A71E_3AB4E9343759set_impl*
end;//TSearchParameters_IsQuerySaved_Params.Set_ResultValue

class function Op_SearchParameters_IsQuerySaved.Call(const aTarget: IvcmEntity): Boolean;
 {* Вызов операции SearchParameters.IsQuerySaved у сущности }
//#UC START# *8E6C80795C85_13A938592F3B_var*
//#UC END# *8E6C80795C85_13A938592F3B_var*
begin
//#UC START# *8E6C80795C85_13A938592F3B_impl*
 !!! Needs to be implemented !!!
//#UC END# *8E6C80795C85_13A938592F3B_impl*
end;//Op_SearchParameters_IsQuerySaved.Call

class function Op_SearchParameters_IsQuerySaved.Call(const aTarget: IvcmAggregate): Boolean;
 {* Вызов операции SearchParameters.IsQuerySaved у агрегации }
//#UC START# *BEAC4068E6D5_13A938592F3B_var*
//#UC END# *BEAC4068E6D5_13A938592F3B_var*
begin
//#UC START# *BEAC4068E6D5_13A938592F3B_impl*
 !!! Needs to be implemented !!!
//#UC END# *BEAC4068E6D5_13A938592F3B_impl*
end;//Op_SearchParameters_IsQuerySaved.Call

class function Op_SearchParameters_IsQuerySaved.Call(const aTarget: IvcmEntityForm): Boolean;
 {* Вызов операции SearchParameters.IsQuerySaved у формы }
//#UC START# *C89D1CB24887_13A938592F3B_var*
//#UC END# *C89D1CB24887_13A938592F3B_var*
begin
//#UC START# *C89D1CB24887_13A938592F3B_impl*
 !!! Needs to be implemented !!!
//#UC END# *C89D1CB24887_13A938592F3B_impl*
end;//Op_SearchParameters_IsQuerySaved.Call

class function Op_SearchParameters_IsQuerySaved.Call(const aTarget: IvcmContainer): Boolean;
 {* Вызов операции SearchParameters.IsQuerySaved у контейнера }
//#UC START# *23BB0AE9A315_13A938592F3B_var*
//#UC END# *23BB0AE9A315_13A938592F3B_var*
begin
//#UC START# *23BB0AE9A315_13A938592F3B_impl*
 !!! Needs to be implemented !!!
//#UC END# *23BB0AE9A315_13A938592F3B_impl*
end;//Op_SearchParameters_IsQuerySaved.Call

constructor TSearchParameters_SetQuery_Params.Create(const aQuery: IQuery);
 {* Конструктор TSearchParameters_SetQuery_Params }
//#UC START# *62B9A7A675B3_FCBDE25889D4_var*
//#UC END# *62B9A7A675B3_FCBDE25889D4_var*
begin
//#UC START# *62B9A7A675B3_FCBDE25889D4_impl*
 !!! Needs to be implemented !!!
//#UC END# *62B9A7A675B3_FCBDE25889D4_impl*
end;//TSearchParameters_SetQuery_Params.Create

class function TSearchParameters_SetQuery_Params.Make(const aQuery: IQuery): ISearchParameters_SetQuery_Params;
 {* Фабрика TSearchParameters_SetQuery_Params }
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
//#UC START# *A067AE842254_FCBDE25889D4get_var*
//#UC END# *A067AE842254_FCBDE25889D4get_var*
begin
//#UC START# *A067AE842254_FCBDE25889D4get_impl*
 !!! Needs to be implemented !!!
//#UC END# *A067AE842254_FCBDE25889D4get_impl*
end;//TSearchParameters_SetQuery_Params.Get_Query

procedure TSearchParameters_SetQuery_Params.ClearFields;
begin
 f_Query := nil;
 inherited;
end;//TSearchParameters_SetQuery_Params.ClearFields

class function Op_SearchParameters_SetQuery.Call(const aTarget: IvcmEntity;
 const aQuery: IQuery): Boolean;
 {* Вызов операции SearchParameters.SetQuery у сущности }
//#UC START# *7880BF80C7F4_4FE4D66A87E3_var*
//#UC END# *7880BF80C7F4_4FE4D66A87E3_var*
begin
//#UC START# *7880BF80C7F4_4FE4D66A87E3_impl*
 !!! Needs to be implemented !!!
//#UC END# *7880BF80C7F4_4FE4D66A87E3_impl*
end;//Op_SearchParameters_SetQuery.Call

class function Op_SearchParameters_SetQuery.Call(const aTarget: IvcmAggregate;
 const aQuery: IQuery): Boolean;
 {* Вызов операции SearchParameters.SetQuery у агрегации }
//#UC START# *A8C07F705244_4FE4D66A87E3_var*
//#UC END# *A8C07F705244_4FE4D66A87E3_var*
begin
//#UC START# *A8C07F705244_4FE4D66A87E3_impl*
 !!! Needs to be implemented !!!
//#UC END# *A8C07F705244_4FE4D66A87E3_impl*
end;//Op_SearchParameters_SetQuery.Call

class function Op_SearchParameters_SetQuery.Call(const aTarget: IvcmEntityForm;
 const aQuery: IQuery): Boolean;
 {* Вызов операции SearchParameters.SetQuery у формы }
//#UC START# *220F281BE7E2_4FE4D66A87E3_var*
//#UC END# *220F281BE7E2_4FE4D66A87E3_var*
begin
//#UC START# *220F281BE7E2_4FE4D66A87E3_impl*
 !!! Needs to be implemented !!!
//#UC END# *220F281BE7E2_4FE4D66A87E3_impl*
end;//Op_SearchParameters_SetQuery.Call

class function Op_SearchParameters_SetQuery.Call(const aTarget: IvcmContainer;
 const aQuery: IQuery): Boolean;
 {* Вызов операции SearchParameters.SetQuery у контейнера }
//#UC START# *95B61809041C_4FE4D66A87E3_var*
//#UC END# *95B61809041C_4FE4D66A87E3_var*
begin
//#UC START# *95B61809041C_4FE4D66A87E3_impl*
 !!! Needs to be implemented !!!
//#UC END# *95B61809041C_4FE4D66A87E3_impl*
end;//Op_SearchParameters_SetQuery.Call

class function Op_SearchParameters_ClearQuery.Call(const aTarget: IvcmEntity): Boolean;
 {* Вызов операции SearchParameters.ClearQuery у сущности }
//#UC START# *07B1187FD198_A24A82191079_var*
//#UC END# *07B1187FD198_A24A82191079_var*
begin
//#UC START# *07B1187FD198_A24A82191079_impl*
 !!! Needs to be implemented !!!
//#UC END# *07B1187FD198_A24A82191079_impl*
end;//Op_SearchParameters_ClearQuery.Call

class function Op_SearchParameters_ClearQuery.Call(const aTarget: IvcmAggregate): Boolean;
 {* Вызов операции SearchParameters.ClearQuery у агрегации }
//#UC START# *37F0D86E5BE8_A24A82191079_var*
//#UC END# *37F0D86E5BE8_A24A82191079_var*
begin
//#UC START# *37F0D86E5BE8_A24A82191079_impl*
 !!! Needs to be implemented !!!
//#UC END# *37F0D86E5BE8_A24A82191079_impl*
end;//Op_SearchParameters_ClearQuery.Call

class function Op_SearchParameters_ClearQuery.Call(const aTarget: IvcmEntityForm): Boolean;
 {* Вызов операции SearchParameters.ClearQuery у формы }
//#UC START# *6BEFD06CF848_A24A82191079_var*
//#UC END# *6BEFD06CF848_A24A82191079_var*
begin
//#UC START# *6BEFD06CF848_A24A82191079_impl*
 !!! Needs to be implemented !!!
//#UC END# *6BEFD06CF848_A24A82191079_impl*
end;//Op_SearchParameters_ClearQuery.Call

class function Op_SearchParameters_ClearQuery.Call(const aTarget: IvcmContainer): Boolean;
 {* Вызов операции SearchParameters.ClearQuery у контейнера }
//#UC START# *389A45BC5694_A24A82191079_var*
//#UC END# *389A45BC5694_A24A82191079_var*
begin
//#UC START# *389A45BC5694_A24A82191079_impl*
 !!! Needs to be implemented !!!
//#UC END# *389A45BC5694_A24A82191079_impl*
end;//Op_SearchParameters_ClearQuery.Call

constructor TAttributeTree_SaveToQuery_Params.Create(const aQuery: IQuery);
 {* Конструктор TAttributeTree_SaveToQuery_Params }
//#UC START# *638A22DA96AD_31C05080768E_var*
//#UC END# *638A22DA96AD_31C05080768E_var*
begin
//#UC START# *638A22DA96AD_31C05080768E_impl*
 !!! Needs to be implemented !!!
//#UC END# *638A22DA96AD_31C05080768E_impl*
end;//TAttributeTree_SaveToQuery_Params.Create

class function TAttributeTree_SaveToQuery_Params.Make(const aQuery: IQuery): IAttributeTree_SaveToQuery_Params;
 {* Фабрика TAttributeTree_SaveToQuery_Params }
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
//#UC START# *6B7E150B1135_31C05080768Eget_var*
//#UC END# *6B7E150B1135_31C05080768Eget_var*
begin
//#UC START# *6B7E150B1135_31C05080768Eget_impl*
 !!! Needs to be implemented !!!
//#UC END# *6B7E150B1135_31C05080768Eget_impl*
end;//TAttributeTree_SaveToQuery_Params.Get_Query

procedure TAttributeTree_SaveToQuery_Params.ClearFields;
begin
 f_Query := nil;
 inherited;
end;//TAttributeTree_SaveToQuery_Params.ClearFields

class function Op_AttributeTree_SaveToQuery.Call(const aTarget: IvcmEntity;
 const aQuery: IQuery): Boolean;
 {* Вызов операции AttributeTree.SaveToQuery у сущности }
//#UC START# *ECB468B7B16C_DADF9EA450BE_var*
//#UC END# *ECB468B7B16C_DADF9EA450BE_var*
begin
//#UC START# *ECB468B7B16C_DADF9EA450BE_impl*
 !!! Needs to be implemented !!!
//#UC END# *ECB468B7B16C_DADF9EA450BE_impl*
end;//Op_AttributeTree_SaveToQuery.Call

class function Op_AttributeTree_SaveToQuery.Call(const aTarget: IvcmAggregate;
 const aQuery: IQuery): Boolean;
 {* Вызов операции AttributeTree.SaveToQuery у агрегации }
//#UC START# *1CF428A73BBD_DADF9EA450BE_var*
//#UC END# *1CF428A73BBD_DADF9EA450BE_var*
begin
//#UC START# *1CF428A73BBD_DADF9EA450BE_impl*
 !!! Needs to be implemented !!!
//#UC END# *1CF428A73BBD_DADF9EA450BE_impl*
end;//Op_AttributeTree_SaveToQuery.Call

class function Op_AttributeTree_SaveToQuery.Call(const aTarget: IvcmEntityForm;
 const aQuery: IQuery): Boolean;
 {* Вызов операции AttributeTree.SaveToQuery у формы }
//#UC START# *56B0E8C24F8A_DADF9EA450BE_var*
//#UC END# *56B0E8C24F8A_DADF9EA450BE_var*
begin
//#UC START# *56B0E8C24F8A_DADF9EA450BE_impl*
 !!! Needs to be implemented !!!
//#UC END# *56B0E8C24F8A_DADF9EA450BE_impl*
end;//Op_AttributeTree_SaveToQuery.Call

class function Op_AttributeTree_SaveToQuery.Call(const aTarget: IvcmContainer;
 const aQuery: IQuery): Boolean;
 {* Вызов операции AttributeTree.SaveToQuery у контейнера }
//#UC START# *8F4641F256CC_DADF9EA450BE_var*
//#UC END# *8F4641F256CC_DADF9EA450BE_var*
begin
//#UC START# *8F4641F256CC_DADF9EA450BE_impl*
 !!! Needs to be implemented !!!
//#UC END# *8F4641F256CC_DADF9EA450BE_impl*
end;//Op_AttributeTree_SaveToQuery.Call

constructor TAttribute_DefaultAction_Params.Create(anIndex: Integer);
 {* Конструктор TAttribute_DefaultAction_Params }
//#UC START# *AB213BAB7C89_794010DE7D7D_var*
//#UC END# *AB213BAB7C89_794010DE7D7D_var*
begin
//#UC START# *AB213BAB7C89_794010DE7D7D_impl*
 !!! Needs to be implemented !!!
//#UC END# *AB213BAB7C89_794010DE7D7D_impl*
end;//TAttribute_DefaultAction_Params.Create

class function TAttribute_DefaultAction_Params.Make(anIndex: Integer): IAttribute_DefaultAction_Params;
 {* Фабрика TAttribute_DefaultAction_Params }
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
//#UC START# *D71A1B90BB77_794010DE7D7Dget_var*
//#UC END# *D71A1B90BB77_794010DE7D7Dget_var*
begin
//#UC START# *D71A1B90BB77_794010DE7D7Dget_impl*
 !!! Needs to be implemented !!!
//#UC END# *D71A1B90BB77_794010DE7D7Dget_impl*
end;//TAttribute_DefaultAction_Params.Get_nIndex

class function Op_Attribute_DefaultAction.Call(const aTarget: IvcmEntity;
 anIndex: Integer = -1): Boolean;
 {* Вызов операции Attribute.DefaultAction у сущности }
//#UC START# *546DB3B9E60F_67B77E13D314_var*
//#UC END# *546DB3B9E60F_67B77E13D314_var*
begin
//#UC START# *546DB3B9E60F_67B77E13D314_impl*
 !!! Needs to be implemented !!!
//#UC END# *546DB3B9E60F_67B77E13D314_impl*
end;//Op_Attribute_DefaultAction.Call

class function Op_Attribute_DefaultAction.Call(const aTarget: IvcmAggregate;
 anIndex: Integer = -1): Boolean;
 {* Вызов операции Attribute.DefaultAction у агрегации }
//#UC START# *84AD73A8705F_67B77E13D314_var*
//#UC END# *84AD73A8705F_67B77E13D314_var*
begin
//#UC START# *84AD73A8705F_67B77E13D314_impl*
 !!! Needs to be implemented !!!
//#UC END# *84AD73A8705F_67B77E13D314_impl*
end;//Op_Attribute_DefaultAction.Call

class function Op_Attribute_DefaultAction.Call(const aTarget: IvcmEntityForm;
 anIndex: Integer = -1): Boolean;
 {* Вызов операции Attribute.DefaultAction у формы }
//#UC START# *1BFACD0FA821_67B77E13D314_var*
//#UC END# *1BFACD0FA821_67B77E13D314_var*
begin
//#UC START# *1BFACD0FA821_67B77E13D314_impl*
 !!! Needs to be implemented !!!
//#UC END# *1BFACD0FA821_67B77E13D314_impl*
end;//Op_Attribute_DefaultAction.Call

class function Op_Attribute_DefaultAction.Call(const aTarget: IvcmContainer;
 anIndex: Integer = -1): Boolean;
 {* Вызов операции Attribute.DefaultAction у контейнера }
//#UC START# *772F81E4F9C9_67B77E13D314_var*
//#UC END# *772F81E4F9C9_67B77E13D314_var*
begin
//#UC START# *772F81E4F9C9_67B77E13D314_impl*
 !!! Needs to be implemented !!!
//#UC END# *772F81E4F9C9_67B77E13D314_impl*
end;//Op_Attribute_DefaultAction.Call

constructor TContext_SetContext_Params.Create(const aState: InscContextFilterState);
 {* Конструктор TContext_SetContext_Params }
//#UC START# *8A592D91791B_8F378E4D73EA_var*
//#UC END# *8A592D91791B_8F378E4D73EA_var*
begin
//#UC START# *8A592D91791B_8F378E4D73EA_impl*
 !!! Needs to be implemented !!!
//#UC END# *8A592D91791B_8F378E4D73EA_impl*
end;//TContext_SetContext_Params.Create

class function TContext_SetContext_Params.Make(const aState: InscContextFilterState): IContext_SetContext_Params;
 {* Фабрика TContext_SetContext_Params }
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
//#UC START# *D9120C2D397A_8F378E4D73EAget_var*
//#UC END# *D9120C2D397A_8F378E4D73EAget_var*
begin
//#UC START# *D9120C2D397A_8F378E4D73EAget_impl*
 !!! Needs to be implemented !!!
//#UC END# *D9120C2D397A_8F378E4D73EAget_impl*
end;//TContext_SetContext_Params.Get_State

procedure TContext_SetContext_Params.ClearFields;
begin
 f_State := nil;
 inherited;
end;//TContext_SetContext_Params.ClearFields

class function Op_Context_SetContext.Call(const aTarget: IvcmEntity;
 const aState: InscContextFilterState): Boolean;
 {* Вызов операции Context.SetContext у сущности }
//#UC START# *9C8CD3DC1E5B_825C134E71BD_var*
//#UC END# *9C8CD3DC1E5B_825C134E71BD_var*
begin
//#UC START# *9C8CD3DC1E5B_825C134E71BD_impl*
 !!! Needs to be implemented !!!
//#UC END# *9C8CD3DC1E5B_825C134E71BD_impl*
end;//Op_Context_SetContext.Call

class function Op_Context_SetContext.Call(const aTarget: IvcmAggregate;
 const aState: InscContextFilterState): Boolean;
 {* Вызов операции Context.SetContext у агрегации }
//#UC START# *CCCC93CBA8AB_825C134E71BD_var*
//#UC END# *CCCC93CBA8AB_825C134E71BD_var*
begin
//#UC START# *CCCC93CBA8AB_825C134E71BD_impl*
 !!! Needs to be implemented !!!
//#UC END# *CCCC93CBA8AB_825C134E71BD_impl*
end;//Op_Context_SetContext.Call

class function Op_Context_SetContext.Call(const aTarget: IvcmEntityForm;
 const aState: InscContextFilterState): Boolean;
 {* Вызов операции Context.SetContext у формы }
//#UC START# *045C791F600B_825C134E71BD_var*
//#UC END# *045C791F600B_825C134E71BD_var*
begin
//#UC START# *045C791F600B_825C134E71BD_impl*
 !!! Needs to be implemented !!!
//#UC END# *045C791F600B_825C134E71BD_impl*
end;//Op_Context_SetContext.Call

class function Op_Context_SetContext.Call(const aTarget: IvcmContainer;
 const aState: InscContextFilterState): Boolean;
 {* Вызов операции Context.SetContext у контейнера }
//#UC START# *9CD18BA024FE_825C134E71BD_var*
//#UC END# *9CD18BA024FE_825C134E71BD_var*
begin
//#UC START# *9CD18BA024FE_825C134E71BD_impl*
 !!! Needs to be implemented !!!
//#UC END# *9CD18BA024FE_825C134E71BD_impl*
end;//Op_Context_SetContext.Call

constructor TContext_SyncContextParams_Params.Create(aAdditionalFilter: TnsFilterType);
 {* Конструктор TContext_SyncContextParams_Params }
//#UC START# *3D8D92BE3974_1648B4095FD2_var*
//#UC END# *3D8D92BE3974_1648B4095FD2_var*
begin
//#UC START# *3D8D92BE3974_1648B4095FD2_impl*
 !!! Needs to be implemented !!!
//#UC END# *3D8D92BE3974_1648B4095FD2_impl*
end;//TContext_SyncContextParams_Params.Create

class function TContext_SyncContextParams_Params.Make(aAdditionalFilter: TnsFilterType): IContext_SyncContextParams_Params;
 {* Фабрика TContext_SyncContextParams_Params }
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
//#UC START# *E492356BEB1B_1648B4095FD2get_var*
//#UC END# *E492356BEB1B_1648B4095FD2get_var*
begin
//#UC START# *E492356BEB1B_1648B4095FD2get_impl*
 !!! Needs to be implemented !!!
//#UC END# *E492356BEB1B_1648B4095FD2get_impl*
end;//TContext_SyncContextParams_Params.Get_AdditionalFilter

class function Op_Context_SyncContextParams.Call(const aTarget: IvcmEntity;
 aAdditionalFilter: TnsFilterType): Boolean;
 {* Вызов операции Context.SyncContextParams у сущности }
//#UC START# *86C443FCC39B_AE60113DB7F3_var*
//#UC END# *86C443FCC39B_AE60113DB7F3_var*
begin
//#UC START# *86C443FCC39B_AE60113DB7F3_impl*
 !!! Needs to be implemented !!!
//#UC END# *86C443FCC39B_AE60113DB7F3_impl*
end;//Op_Context_SyncContextParams.Call

class function Op_Context_SyncContextParams.Call(const aTarget: IvcmAggregate;
 aAdditionalFilter: TnsFilterType): Boolean;
 {* Вызов операции Context.SyncContextParams у агрегации }
//#UC START# *B70403EC4DEB_AE60113DB7F3_var*
//#UC END# *B70403EC4DEB_AE60113DB7F3_var*
begin
//#UC START# *B70403EC4DEB_AE60113DB7F3_impl*
 !!! Needs to be implemented !!!
//#UC END# *B70403EC4DEB_AE60113DB7F3_impl*
end;//Op_Context_SyncContextParams.Call

class function Op_Context_SyncContextParams.Call(const aTarget: IvcmEntityForm;
 aAdditionalFilter: TnsFilterType): Boolean;
 {* Вызов операции Context.SyncContextParams у формы }
//#UC START# *58D8C459FD78_AE60113DB7F3_var*
//#UC END# *58D8C459FD78_AE60113DB7F3_var*
begin
//#UC START# *58D8C459FD78_AE60113DB7F3_impl*
 !!! Needs to be implemented !!!
//#UC END# *58D8C459FD78_AE60113DB7F3_impl*
end;//Op_Context_SyncContextParams.Call

class function Op_Context_SyncContextParams.Call(const aTarget: IvcmContainer;
 aAdditionalFilter: TnsFilterType): Boolean;
 {* Вызов операции Context.SyncContextParams у контейнера }
//#UC START# *6AE75D7758D7_AE60113DB7F3_var*
//#UC END# *6AE75D7758D7_AE60113DB7F3_var*
begin
//#UC START# *6AE75D7758D7_AE60113DB7F3_impl*
 !!! Needs to be implemented !!!
//#UC END# *6AE75D7758D7_AE60113DB7F3_impl*
end;//Op_Context_SyncContextParams.Call

constructor TAttributeTree_SetParent_Params.Create(const aParent: Il3SimpleNode);
 {* Конструктор TAttributeTree_SetParent_Params }
//#UC START# *E77A065E39CE_14831EE7BE4F_var*
//#UC END# *E77A065E39CE_14831EE7BE4F_var*
begin
//#UC START# *E77A065E39CE_14831EE7BE4F_impl*
 !!! Needs to be implemented !!!
//#UC END# *E77A065E39CE_14831EE7BE4F_impl*
end;//TAttributeTree_SetParent_Params.Create

class function TAttributeTree_SetParent_Params.Make(const aParent: Il3SimpleNode): IAttributeTree_SetParent_Params;
 {* Фабрика TAttributeTree_SetParent_Params }
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
//#UC START# *3260BD9B6733_14831EE7BE4Fget_var*
//#UC END# *3260BD9B6733_14831EE7BE4Fget_var*
begin
//#UC START# *3260BD9B6733_14831EE7BE4Fget_impl*
 !!! Needs to be implemented !!!
//#UC END# *3260BD9B6733_14831EE7BE4Fget_impl*
end;//TAttributeTree_SetParent_Params.Get_Parent

procedure TAttributeTree_SetParent_Params.ClearFields;
begin
 f_Parent := nil;
 inherited;
end;//TAttributeTree_SetParent_Params.ClearFields

class function Op_AttributeTree_SetParent.Call(const aTarget: IvcmEntity;
 const aParent: Il3SimpleNode): Boolean;
 {* Вызов операции AttributeTree.SetParent у сущности }
//#UC START# *B97CAA5F96D6_2873C9A72DC0_var*
//#UC END# *B97CAA5F96D6_2873C9A72DC0_var*
begin
//#UC START# *B97CAA5F96D6_2873C9A72DC0_impl*
 !!! Needs to be implemented !!!
//#UC END# *B97CAA5F96D6_2873C9A72DC0_impl*
end;//Op_AttributeTree_SetParent.Call

class function Op_AttributeTree_SetParent.Call(const aTarget: IvcmAggregate;
 const aParent: Il3SimpleNode): Boolean;
 {* Вызов операции AttributeTree.SetParent у агрегации }
//#UC START# *E9BC6A4E2126_2873C9A72DC0_var*
//#UC END# *E9BC6A4E2126_2873C9A72DC0_var*
begin
//#UC START# *E9BC6A4E2126_2873C9A72DC0_impl*
 !!! Needs to be implemented !!!
//#UC END# *E9BC6A4E2126_2873C9A72DC0_impl*
end;//Op_AttributeTree_SetParent.Call

class function Op_AttributeTree_SetParent.Call(const aTarget: IvcmEntityForm;
 const aParent: Il3SimpleNode): Boolean;
 {* Вызов операции AttributeTree.SetParent у формы }
//#UC START# *4BAC94755AB6_2873C9A72DC0_var*
//#UC END# *4BAC94755AB6_2873C9A72DC0_var*
begin
//#UC START# *4BAC94755AB6_2873C9A72DC0_impl*
 !!! Needs to be implemented !!!
//#UC END# *4BAC94755AB6_2873C9A72DC0_impl*
end;//Op_AttributeTree_SetParent.Call

class function Op_AttributeTree_SetParent.Call(const aTarget: IvcmContainer;
 const aParent: Il3SimpleNode): Boolean;
 {* Вызов операции AttributeTree.SetParent у контейнера }
//#UC START# *C7F497E31537_2873C9A72DC0_var*
//#UC END# *C7F497E31537_2873C9A72DC0_var*
begin
//#UC START# *C7F497E31537_2873C9A72DC0_impl*
 !!! Needs to be implemented !!!
//#UC END# *C7F497E31537_2873C9A72DC0_impl*
end;//Op_AttributeTree_SetParent.Call

constructor TAttributeTree_ExtSetRoot_Params.Create(const aRoot: INodeBase);
 {* Конструктор TAttributeTree_ExtSetRoot_Params }
//#UC START# *316D2D7D5764_A12BA1BE8988_var*
//#UC END# *316D2D7D5764_A12BA1BE8988_var*
begin
//#UC START# *316D2D7D5764_A12BA1BE8988_impl*
 !!! Needs to be implemented !!!
//#UC END# *316D2D7D5764_A12BA1BE8988_impl*
end;//TAttributeTree_ExtSetRoot_Params.Create

class function TAttributeTree_ExtSetRoot_Params.Make(const aRoot: INodeBase): IAttributeTree_ExtSetRoot_Params;
 {* Фабрика TAttributeTree_ExtSetRoot_Params }
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
//#UC START# *8613B018A4EE_A12BA1BE8988get_var*
//#UC END# *8613B018A4EE_A12BA1BE8988get_var*
begin
//#UC START# *8613B018A4EE_A12BA1BE8988get_impl*
 !!! Needs to be implemented !!!
//#UC END# *8613B018A4EE_A12BA1BE8988get_impl*
end;//TAttributeTree_ExtSetRoot_Params.Get_Root

procedure TAttributeTree_ExtSetRoot_Params.ClearFields;
begin
 f_Root := nil;
 inherited;
end;//TAttributeTree_ExtSetRoot_Params.ClearFields

class function Op_AttributeTree_ExtSetRoot.Call(const aTarget: IvcmEntity;
 const aRoot: INodeBase): Boolean;
 {* Вызов операции AttributeTree.ExtSetRoot у сущности }
//#UC START# *4CED3C9FD348_7EE02834F3AE_var*
//#UC END# *4CED3C9FD348_7EE02834F3AE_var*
begin
//#UC START# *4CED3C9FD348_7EE02834F3AE_impl*
 !!! Needs to be implemented !!!
//#UC END# *4CED3C9FD348_7EE02834F3AE_impl*
end;//Op_AttributeTree_ExtSetRoot.Call

class function Op_AttributeTree_ExtSetRoot.Call(const aTarget: IvcmAggregate;
 const aRoot: INodeBase): Boolean;
 {* Вызов операции AttributeTree.ExtSetRoot у агрегации }
//#UC START# *7D2CFC8E5D98_7EE02834F3AE_var*
//#UC END# *7D2CFC8E5D98_7EE02834F3AE_var*
begin
//#UC START# *7D2CFC8E5D98_7EE02834F3AE_impl*
 !!! Needs to be implemented !!!
//#UC END# *7D2CFC8E5D98_7EE02834F3AE_impl*
end;//Op_AttributeTree_ExtSetRoot.Call

class function Op_AttributeTree_ExtSetRoot.Call(const aTarget: IvcmEntityForm;
 const aRoot: INodeBase): Boolean;
 {* Вызов операции AttributeTree.ExtSetRoot у формы }
//#UC START# *7E6C13E59EE4_7EE02834F3AE_var*
//#UC END# *7E6C13E59EE4_7EE02834F3AE_var*
begin
//#UC START# *7E6C13E59EE4_7EE02834F3AE_impl*
 !!! Needs to be implemented !!!
//#UC END# *7E6C13E59EE4_7EE02834F3AE_impl*
end;//Op_AttributeTree_ExtSetRoot.Call

class function Op_AttributeTree_ExtSetRoot.Call(const aTarget: IvcmContainer;
 const aRoot: INodeBase): Boolean;
 {* Вызов операции AttributeTree.ExtSetRoot у контейнера }
//#UC START# *7BAF1DB48D8C_7EE02834F3AE_var*
//#UC END# *7BAF1DB48D8C_7EE02834F3AE_var*
begin
//#UC START# *7BAF1DB48D8C_7EE02834F3AE_impl*
 !!! Needs to be implemented !!!
//#UC END# *7BAF1DB48D8C_7EE02834F3AE_impl*
end;//Op_AttributeTree_ExtSetRoot.Call

constructor TAttributeTree_SetRoot_Params.Create(const aTag: Il3CString);
 {* Конструктор TAttributeTree_SetRoot_Params }
//#UC START# *C248CB7F3266_7C6A4DACDF09_var*
//#UC END# *C248CB7F3266_7C6A4DACDF09_var*
begin
//#UC START# *C248CB7F3266_7C6A4DACDF09_impl*
 !!! Needs to be implemented !!!
//#UC END# *C248CB7F3266_7C6A4DACDF09_impl*
end;//TAttributeTree_SetRoot_Params.Create

class function TAttributeTree_SetRoot_Params.Make(const aTag: Il3CString): IAttributeTree_SetRoot_Params;
 {* Фабрика TAttributeTree_SetRoot_Params }
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
//#UC START# *2C570E5278CC_7C6A4DACDF09get_var*
//#UC END# *2C570E5278CC_7C6A4DACDF09get_var*
begin
//#UC START# *2C570E5278CC_7C6A4DACDF09get_impl*
 !!! Needs to be implemented !!!
//#UC END# *2C570E5278CC_7C6A4DACDF09get_impl*
end;//TAttributeTree_SetRoot_Params.Get_Tag

procedure TAttributeTree_SetRoot_Params.ClearFields;
begin
 f_Tag := nil;
 inherited;
end;//TAttributeTree_SetRoot_Params.ClearFields

class function Op_AttributeTree_SetRoot.Call(const aTarget: IvcmEntity;
 const aTag: Il3CString): Boolean;
 {* Вызов операции AttributeTree.SetRoot у сущности }
//#UC START# *79AA1DF95936_5288A1E58BF8_var*
//#UC END# *79AA1DF95936_5288A1E58BF8_var*
begin
//#UC START# *79AA1DF95936_5288A1E58BF8_impl*
 !!! Needs to be implemented !!!
//#UC END# *79AA1DF95936_5288A1E58BF8_impl*
end;//Op_AttributeTree_SetRoot.Call

class function Op_AttributeTree_SetRoot.Call(const aTarget: IvcmAggregate;
 const aTag: Il3CString): Boolean;
 {* Вызов операции AttributeTree.SetRoot у агрегации }
//#UC START# *A9E9DDE7E386_5288A1E58BF8_var*
//#UC END# *A9E9DDE7E386_5288A1E58BF8_var*
begin
//#UC START# *A9E9DDE7E386_5288A1E58BF8_impl*
 !!! Needs to be implemented !!!
//#UC END# *A9E9DDE7E386_5288A1E58BF8_impl*
end;//Op_AttributeTree_SetRoot.Call

class function Op_AttributeTree_SetRoot.Call(const aTarget: IvcmEntityForm;
 const aTag: Il3CString): Boolean;
 {* Вызов операции AttributeTree.SetRoot у формы }
//#UC START# *BE183782AC9D_5288A1E58BF8_var*
//#UC END# *BE183782AC9D_5288A1E58BF8_var*
begin
//#UC START# *BE183782AC9D_5288A1E58BF8_impl*
 !!! Needs to be implemented !!!
//#UC END# *BE183782AC9D_5288A1E58BF8_impl*
end;//Op_AttributeTree_SetRoot.Call

class function Op_AttributeTree_SetRoot.Call(const aTarget: IvcmContainer;
 const aTag: Il3CString): Boolean;
 {* Вызов операции AttributeTree.SetRoot у контейнера }
//#UC START# *65C72929E7BC_5288A1E58BF8_var*
//#UC END# *65C72929E7BC_5288A1E58BF8_var*
begin
//#UC START# *65C72929E7BC_5288A1E58BF8_impl*
 !!! Needs to be implemented !!!
//#UC END# *65C72929E7BC_5288A1E58BF8_impl*
end;//Op_AttributeTree_SetRoot.Call

constructor TAttributeTree_ChangeRoot_Params.Create(const aTag: Il3CString;
 const aRoot: Il3SimpleNode;
 const aCurrent: Il3SimpleNode);
 {* Конструктор TAttributeTree_ChangeRoot_Params }
//#UC START# *78AA164E828D_A5EEED6A3CB7_var*
//#UC END# *78AA164E828D_A5EEED6A3CB7_var*
begin
//#UC START# *78AA164E828D_A5EEED6A3CB7_impl*
 !!! Needs to be implemented !!!
//#UC END# *78AA164E828D_A5EEED6A3CB7_impl*
end;//TAttributeTree_ChangeRoot_Params.Create

class function TAttributeTree_ChangeRoot_Params.Make(const aTag: Il3CString;
 const aRoot: Il3SimpleNode;
 const aCurrent: Il3SimpleNode): IAttributeTree_ChangeRoot_Params;
 {* Фабрика TAttributeTree_ChangeRoot_Params }
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

function TAttributeTree_ChangeRoot_Params.Get_Root: Il3SimpleNode;
//#UC START# *7FBE3283B4BA_A5EEED6A3CB7get_var*
//#UC END# *7FBE3283B4BA_A5EEED6A3CB7get_var*
begin
//#UC START# *7FBE3283B4BA_A5EEED6A3CB7get_impl*
 !!! Needs to be implemented !!!
//#UC END# *7FBE3283B4BA_A5EEED6A3CB7get_impl*
end;//TAttributeTree_ChangeRoot_Params.Get_Root

function TAttributeTree_ChangeRoot_Params.Get_Current: Il3SimpleNode;
//#UC START# *B22632C33EB5_A5EEED6A3CB7get_var*
//#UC END# *B22632C33EB5_A5EEED6A3CB7get_var*
begin
//#UC START# *B22632C33EB5_A5EEED6A3CB7get_impl*
 !!! Needs to be implemented !!!
//#UC END# *B22632C33EB5_A5EEED6A3CB7get_impl*
end;//TAttributeTree_ChangeRoot_Params.Get_Current

function TAttributeTree_ChangeRoot_Params.Get_Tag: Il3CString;
//#UC START# *E3F34CDA8250_A5EEED6A3CB7get_var*
//#UC END# *E3F34CDA8250_A5EEED6A3CB7get_var*
begin
//#UC START# *E3F34CDA8250_A5EEED6A3CB7get_impl*
 !!! Needs to be implemented !!!
//#UC END# *E3F34CDA8250_A5EEED6A3CB7get_impl*
end;//TAttributeTree_ChangeRoot_Params.Get_Tag

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
//#UC START# *373370DBD9A2_42760C1AEA85_var*
//#UC END# *373370DBD9A2_42760C1AEA85_var*
begin
//#UC START# *373370DBD9A2_42760C1AEA85_impl*
 !!! Needs to be implemented !!!
//#UC END# *373370DBD9A2_42760C1AEA85_impl*
end;//Op_AttributeTree_ChangeRoot.Call

class function Op_AttributeTree_ChangeRoot.Call(const aTarget: IvcmAggregate;
 const aTag: Il3CString;
 const aRoot: Il3SimpleNode;
 const aCurrent: Il3SimpleNode): Boolean;
 {* Вызов операции AttributeTree.ChangeRoot у агрегации }
//#UC START# *677330CA63F2_42760C1AEA85_var*
//#UC END# *677330CA63F2_42760C1AEA85_var*
begin
//#UC START# *677330CA63F2_42760C1AEA85_impl*
 !!! Needs to be implemented !!!
//#UC END# *677330CA63F2_42760C1AEA85_impl*
end;//Op_AttributeTree_ChangeRoot.Call

class function Op_AttributeTree_ChangeRoot.Call(const aTarget: IvcmEntityForm;
 const aTag: Il3CString;
 const aRoot: Il3SimpleNode;
 const aCurrent: Il3SimpleNode): Boolean;
 {* Вызов операции AttributeTree.ChangeRoot у формы }
//#UC START# *24B7E4811784_42760C1AEA85_var*
//#UC END# *24B7E4811784_42760C1AEA85_var*
begin
//#UC START# *24B7E4811784_42760C1AEA85_impl*
 !!! Needs to be implemented !!!
//#UC END# *24B7E4811784_42760C1AEA85_impl*
end;//Op_AttributeTree_ChangeRoot.Call

class function Op_AttributeTree_ChangeRoot.Call(const aTarget: IvcmContainer;
 const aTag: Il3CString;
 const aRoot: Il3SimpleNode;
 const aCurrent: Il3SimpleNode): Boolean;
 {* Вызов операции AttributeTree.ChangeRoot у контейнера }
//#UC START# *037FF80919BE_42760C1AEA85_var*
//#UC END# *037FF80919BE_42760C1AEA85_var*
begin
//#UC START# *037FF80919BE_42760C1AEA85_impl*
 !!! Needs to be implemented !!!
//#UC END# *037FF80919BE_42760C1AEA85_impl*
end;//Op_AttributeTree_ChangeRoot.Call

constructor TContextParams_ContextChanged_Params.Create(const aContextState: InscContextFilterState;
 const aContextTarget: Il3ContextFilterTarget);
 {* Конструктор TContextParams_ContextChanged_Params }
//#UC START# *6A99CC5B93CF_66741C61D27E_var*
//#UC END# *6A99CC5B93CF_66741C61D27E_var*
begin
//#UC START# *6A99CC5B93CF_66741C61D27E_impl*
 !!! Needs to be implemented !!!
//#UC END# *6A99CC5B93CF_66741C61D27E_impl*
end;//TContextParams_ContextChanged_Params.Create

class function TContextParams_ContextChanged_Params.Make(const aContextState: InscContextFilterState;
 const aContextTarget: Il3ContextFilterTarget): IContextParams_ContextChanged_Params;
 {* Фабрика TContextParams_ContextChanged_Params }
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
//#UC START# *6539DCD7EA58_66741C61D27Eget_var*
//#UC END# *6539DCD7EA58_66741C61D27Eget_var*
begin
//#UC START# *6539DCD7EA58_66741C61D27Eget_impl*
 !!! Needs to be implemented !!!
//#UC END# *6539DCD7EA58_66741C61D27Eget_impl*
end;//TContextParams_ContextChanged_Params.Get_ContextState

function TContextParams_ContextChanged_Params.Get_ContextTarget: Il3ContextFilterTarget;
//#UC START# *9E1806E56CE3_66741C61D27Eget_var*
//#UC END# *9E1806E56CE3_66741C61D27Eget_var*
begin
//#UC START# *9E1806E56CE3_66741C61D27Eget_impl*
 !!! Needs to be implemented !!!
//#UC END# *9E1806E56CE3_66741C61D27Eget_impl*
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
//#UC START# *747256772824_9C6CB66FE42D_var*
//#UC END# *747256772824_9C6CB66FE42D_var*
begin
//#UC START# *747256772824_9C6CB66FE42D_impl*
 !!! Needs to be implemented !!!
//#UC END# *747256772824_9C6CB66FE42D_impl*
end;//Op_ContextParams_ContextChanged.Call

class function Op_ContextParams_ContextChanged.Call(const aTarget: IvcmAggregate;
 const aContextState: InscContextFilterState;
 const aContextTarget: Il3ContextFilterTarget): Boolean;
 {* Вызов операции ContextParams.ContextChanged у агрегации }
//#UC START# *A4B21665B274_9C6CB66FE42D_var*
//#UC END# *A4B21665B274_9C6CB66FE42D_var*
begin
//#UC START# *A4B21665B274_9C6CB66FE42D_impl*
 !!! Needs to be implemented !!!
//#UC END# *A4B21665B274_9C6CB66FE42D_impl*
end;//Op_ContextParams_ContextChanged.Call

class function Op_ContextParams_ContextChanged.Call(const aTarget: IvcmEntityForm;
 const aContextState: InscContextFilterState;
 const aContextTarget: Il3ContextFilterTarget): Boolean;
 {* Вызов операции ContextParams.ContextChanged у формы }
//#UC START# *285AD8AED58F_9C6CB66FE42D_var*
//#UC END# *285AD8AED58F_9C6CB66FE42D_var*
begin
//#UC START# *285AD8AED58F_9C6CB66FE42D_impl*
 !!! Needs to be implemented !!!
//#UC END# *285AD8AED58F_9C6CB66FE42D_impl*
end;//Op_ContextParams_ContextChanged.Call

class function Op_ContextParams_ContextChanged.Call(const aTarget: IvcmContainer;
 const aContextState: InscContextFilterState;
 const aContextTarget: Il3ContextFilterTarget): Boolean;
 {* Вызов операции ContextParams.ContextChanged у контейнера }
//#UC START# *6CEB293ABFC8_9C6CB66FE42D_var*
//#UC END# *6CEB293ABFC8_9C6CB66FE42D_var*
begin
//#UC START# *6CEB293ABFC8_9C6CB66FE42D_impl*
 !!! Needs to be implemented !!!
//#UC END# *6CEB293ABFC8_9C6CB66FE42D_impl*
end;//Op_ContextParams_ContextChanged.Call

constructor TSelectedList_RefreshValues_Params.Create(const aData: InsSelectedAttributesIterators);
 {* Конструктор TSelectedList_RefreshValues_Params }
//#UC START# *530F1E44D110_B85870A02575_var*
//#UC END# *530F1E44D110_B85870A02575_var*
begin
//#UC START# *530F1E44D110_B85870A02575_impl*
 !!! Needs to be implemented !!!
//#UC END# *530F1E44D110_B85870A02575_impl*
end;//TSelectedList_RefreshValues_Params.Create

class function TSelectedList_RefreshValues_Params.Make(const aData: InsSelectedAttributesIterators): ISelectedList_RefreshValues_Params;
 {* Фабрика TSelectedList_RefreshValues_Params }
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
//#UC START# *865586F82E56_B85870A02575get_var*
//#UC END# *865586F82E56_B85870A02575get_var*
begin
//#UC START# *865586F82E56_B85870A02575get_impl*
 !!! Needs to be implemented !!!
//#UC END# *865586F82E56_B85870A02575get_impl*
end;//TSelectedList_RefreshValues_Params.Get_Data

procedure TSelectedList_RefreshValues_Params.ClearFields;
begin
 f_Data := nil;
 inherited;
end;//TSelectedList_RefreshValues_Params.ClearFields

class function Op_SelectedList_RefreshValues.Call(const aTarget: IvcmEntity;
 const aData: InsSelectedAttributesIterators): Boolean;
 {* Вызов операции SelectedList.RefreshValues у сущности }
//#UC START# *3A1C5A901C7B_59EC52A370A8_var*
//#UC END# *3A1C5A901C7B_59EC52A370A8_var*
begin
//#UC START# *3A1C5A901C7B_59EC52A370A8_impl*
 !!! Needs to be implemented !!!
//#UC END# *3A1C5A901C7B_59EC52A370A8_impl*
end;//Op_SelectedList_RefreshValues.Call

class function Op_SelectedList_RefreshValues.Call(const aTarget: IvcmAggregate;
 const aData: InsSelectedAttributesIterators): Boolean;
 {* Вызов операции SelectedList.RefreshValues у агрегации }
//#UC START# *6A5C1A7EA6CB_59EC52A370A8_var*
//#UC END# *6A5C1A7EA6CB_59EC52A370A8_var*
begin
//#UC START# *6A5C1A7EA6CB_59EC52A370A8_impl*
 !!! Needs to be implemented !!!
//#UC END# *6A5C1A7EA6CB_59EC52A370A8_impl*
end;//Op_SelectedList_RefreshValues.Call

class function Op_SelectedList_RefreshValues.Call(const aTarget: IvcmEntityForm;
 const aData: InsSelectedAttributesIterators): Boolean;
 {* Вызов операции SelectedList.RefreshValues у формы }
//#UC START# *AAACC4AB046B_59EC52A370A8_var*
//#UC END# *AAACC4AB046B_59EC52A370A8_var*
begin
//#UC START# *AAACC4AB046B_59EC52A370A8_impl*
 !!! Needs to be implemented !!!
//#UC END# *AAACC4AB046B_59EC52A370A8_impl*
end;//Op_SelectedList_RefreshValues.Call

class function Op_SelectedList_RefreshValues.Call(const aTarget: IvcmContainer;
 const aData: InsSelectedAttributesIterators): Boolean;
 {* Вызов операции SelectedList.RefreshValues у контейнера }
//#UC START# *FC1B1CDA11B0_59EC52A370A8_var*
//#UC END# *FC1B1CDA11B0_59EC52A370A8_var*
begin
//#UC START# *FC1B1CDA11B0_59EC52A370A8_impl*
 !!! Needs to be implemented !!!
//#UC END# *FC1B1CDA11B0_59EC52A370A8_impl*
end;//Op_SelectedList_RefreshValues.Call

end.
