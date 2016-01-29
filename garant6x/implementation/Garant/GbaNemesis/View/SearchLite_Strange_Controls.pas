unit SearchLite_Strange_Controls;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/SearchLite_Strange_Controls.pas"
// Начат: 28.10.2009 14:57
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMControls::Category>> F1 Базовые определения предметной области::SearchLite::View::Strange
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
  BaseTreeSupportUnit,
  DynamicTreeUnit,
  FiltersUnit,
  SearchUnit,
  l3Interfaces,
  l3TreeInterfaces
  {$If defined(Nemesis)}
  ,
  nscNewInterfaces
  {$IfEnd} //Nemesis
  ,
  SearchInterfaces,
  l3CProtoObject
  {$If not defined(NoVCM)}
  ,
  vcmInterfaces
  {$IfEnd} //not NoVCM
  ,
  nsTypes,
  vcmExternalInterfaces {a}
  ;

(* AttributeTree = operations
  {* AttributeTree }
   ['{3D215800-29D1-455B-B866-F680938BDFFD}']
   query ExternalCharPressed(const aChar: Il3CString);
   query SetCurrent(const aNode: Il3SimpleNode;
    aExpand: Boolean = false);
   query DropAllLogicSelection(aDropSelection: Boolean;
    aNotifyMultipleChanges: Boolean = false;
    SetToTop: Boolean = True);
   query Invalidate(aUserType: Integer);
   query DropLogicSelection(const aNode: INodeBase);
   query LoadQuery(const aQuery: IQuery);
   query SetOneLevelCurrent(const aNode: Il3SimpleNode);
   query AddNodeIfEmpty;
 end;//AttributeTree*)

type
 TnsQueryInfo = record
   rQuery : IQuery;
   rFilter : IFilterFromQuery;
   rAskFilters : Boolean;
   rHasErrors : Boolean;
   rIsQueryForFilter : Boolean; // Запрос для создания фильтра
 end;//TnsQueryInfo

(* SearchParameters = operations
  {* SearchParameters }
   ['{B1956C0A-A70B-4FB5-9CEA-96A0BB4FFFF7}']
   query IsQueryEmpty: Boolean;
   query GetQuery(aIgnoreError: Boolean = false): TnsQueryInfo;
   query IsQuerySaved: Boolean;
   query SetQuery(const aQuery: IQuery);
   query ClearQuery;
 end;//SearchParameters*)

(* AttributeTree = operations
   ['{59E55F60-D7F7-4A00-92DC-1A4CDB5F6ED7}']
   query SaveToQuery(const aQuery: IQuery);
 end;//AttributeTree*)

(* Attribute = operations
   ['{ACBED525-C7FB-4DE2-BABF-4FDC399956DF}']
   query DefaultAction(anIndex: Integer = -1);
   operation LogicOr;
   operation LogicAnd;
   operation LogicNot;
   operation LogicOrShortcut;
 end;//Attribute*)

(* Context = operations
   ['{776B1888-0C03-4803-9993-BE43E75F4327}']
   query SetContext(const aState: InscContextFilterState);
   query SyncContextParams(aAdditionalFilter: TnsFilterType);
 end;//Context*)

(* AttributeTree = operations
   ['{4800308D-0923-4F52-A6B3-D3788C9B697D}']
   query SetParent(const aParent: Il3SimpleNode);
   query ExtSetRoot(const aRoot: INodeBase);
 end;//AttributeTree*)

(* AttributeTree = operations
   ['{D857C8D4-FFB2-4505-BA3D-7B96F45862B3}']
   query SetRoot(const aTag: Il3CString);
 end;//AttributeTree*)

(* AttributeTree = operations
   ['{49872F42-CC0B-4818-80D3-D3D8E69CB197}']
   query ChangeRoot(const aTag: Il3CString;
    const aRoot: Il3SimpleNode;
    const aCurrent: Il3SimpleNode);
 end;//AttributeTree*)

(* ContextParams = operations
   ['{6A4523A8-4248-4981-B6DF-B8E0661AAABE}']
   query ContextChanged(const aContextState: InscContextFilterState;
    const aContextTarget: Il3ContextFilterTarget);
 end;//ContextParams*)

(* SelectedList = operations
   ['{6DA4ED8C-E3BF-4A59-B17D-417DA89605AC}']
   query RefreshValues(const aData: InsSelectedAttributesIterators);
 end;//SelectedList*)

(* Folder = operations
   ['{1C1AB013-935D-4B4A-BF54-75CCF2F7CB4B}']
   operation FindFirstSelected;
 end;//Folder*)

(* Result = operations
   ['{D43118C9-6602-47A0-92C9-A937ED1406BF}']
   operation ClearAll;
 end;//Result*)

(* Selection = operations
   ['{209E080E-DD36-4ADA-9BEB-ECA3F022E2F5}']
   operation DropSelection;
 end;//Selection*)

 IAttributeTree_ExternalCharPressed_Params = interface(IUnknown)
  {* Параметры для операции AttributeTree.ExternalCharPressed }
   ['{1E38BBFD-C752-443C-BCCC-EA5C27C57195}']
   function Get_Char: Il3CString;
   property Char: Il3CString
     read Get_Char;
     {* undefined }
 end;//IAttributeTree_ExternalCharPressed_Params

 Op_AttributeTree_ExternalCharPressed = class
  {* Класс для вызова операции AttributeTree.ExternalCharPressed }
 public
 // public methods
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

 IAttributeTree_SetCurrent_Params = interface(IUnknown)
  {* Параметры для операции AttributeTree.SetCurrent }
   ['{A321B03E-4DE4-4A13-92C8-906842BAE015}']
   function Get_Node: Il3SimpleNode;
   function Get_Expand: Boolean;
   property Node: Il3SimpleNode
     read Get_Node;
     {* undefined }
   property Expand: Boolean
     read Get_Expand;
     {* undefined }
 end;//IAttributeTree_SetCurrent_Params

 Op_AttributeTree_SetCurrent = class
  {* Класс для вызова операции AttributeTree.SetCurrent }
 public
 // public methods
   class function Call(const aTarget: IvcmEntity;
    const aNode: Il3SimpleNode;
    aExpand: Boolean = false): Boolean; overload; 
     {* Вызов операции AttributeTree.SetCurrent у сущности }
   class function Call(const aTarget: IvcmAggregate;
    const aNode: Il3SimpleNode;
    aExpand: Boolean = false): Boolean; overload; 
     {* Вызов операции AttributeTree.SetCurrent у агрегации }
   class function Call(const aTarget: IvcmEntityForm;
    const aNode: Il3SimpleNode;
    aExpand: Boolean = false): Boolean; overload; 
     {* Вызов операции AttributeTree.SetCurrent у формы }
   class function Call(const aTarget: IvcmContainer;
    const aNode: Il3SimpleNode;
    aExpand: Boolean = false): Boolean; overload; 
     {* Вызов операции AttributeTree.SetCurrent у контейнера }
 end;//Op_AttributeTree_SetCurrent

 IAttributeTree_DropAllLogicSelection_Params = interface(IUnknown)
  {* Параметры для операции AttributeTree.DropAllLogicSelection }
   ['{5E6D61F3-084D-4A3B-9843-7724733281D5}']
   function Get_DropSelection: Boolean;
   function Get_NotifyMultipleChanges: Boolean;
   function Get_SetToTop: Boolean;
   property DropSelection: Boolean
     read Get_DropSelection;
     {* undefined }
   property NotifyMultipleChanges: Boolean
     read Get_NotifyMultipleChanges;
     {* undefined }
   property SetToTop: Boolean
     read Get_SetToTop;
     {* undefined }
 end;//IAttributeTree_DropAllLogicSelection_Params

 Op_AttributeTree_DropAllLogicSelection = class
  {* Класс для вызова операции AttributeTree.DropAllLogicSelection }
 public
 // public methods
   class function Call(const aTarget: IvcmEntity;
    aDropSelection: Boolean;
    aNotifyMultipleChanges: Boolean = false;
    SetToTop: Boolean = True): Boolean; overload; 
     {* Вызов операции AttributeTree.DropAllLogicSelection у сущности }
   class function Call(const aTarget: IvcmAggregate;
    aDropSelection: Boolean;
    aNotifyMultipleChanges: Boolean = false;
    SetToTop: Boolean = True): Boolean; overload; 
     {* Вызов операции AttributeTree.DropAllLogicSelection у агрегации }
   class function Call(const aTarget: IvcmEntityForm;
    aDropSelection: Boolean;
    aNotifyMultipleChanges: Boolean = false;
    SetToTop: Boolean = True): Boolean; overload; 
     {* Вызов операции AttributeTree.DropAllLogicSelection у формы }
   class function Call(const aTarget: IvcmContainer;
    aDropSelection: Boolean;
    aNotifyMultipleChanges: Boolean = false;
    SetToTop: Boolean = True): Boolean; overload; 
     {* Вызов операции AttributeTree.DropAllLogicSelection у контейнера }
 end;//Op_AttributeTree_DropAllLogicSelection

 IAttributeTree_Invalidate_Params = interface(IUnknown)
  {* Параметры для операции AttributeTree.Invalidate }
   ['{5430FE5C-1557-4462-B774-47585BF7399D}']
   function Get_UserType: Integer;
   property UserType: Integer
     read Get_UserType;
     {* undefined }
 end;//IAttributeTree_Invalidate_Params

 Op_AttributeTree_Invalidate = class
  {* Класс для вызова операции AttributeTree.Invalidate }
 public
 // public methods
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

 IAttributeTree_DropLogicSelection_Params = interface(IUnknown)
  {* Параметры для операции AttributeTree.DropLogicSelection }
   ['{5FD1E8F0-FCE9-4BA1-B967-B9A81F9815F5}']
   function Get_Node: INodeBase;
   property Node: INodeBase
     read Get_Node;
     {* undefined }
 end;//IAttributeTree_DropLogicSelection_Params

 Op_AttributeTree_DropLogicSelection = class
  {* Класс для вызова операции AttributeTree.DropLogicSelection }
 public
 // public methods
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

 IAttributeTree_LoadQuery_Params = interface(IUnknown)
  {* Параметры для операции AttributeTree.LoadQuery }
   ['{086B1D39-95E7-4993-A41C-F5FF17B53ECF}']
   function Get_Query: IQuery;
   property Query: IQuery
     read Get_Query;
     {* undefined }
 end;//IAttributeTree_LoadQuery_Params

 Op_AttributeTree_LoadQuery = class
  {* Класс для вызова операции AttributeTree.LoadQuery }
 public
 // public methods
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

 IAttributeTree_SetOneLevelCurrent_Params = interface(IUnknown)
  {* Параметры для операции AttributeTree.SetOneLevelCurrent }
   ['{7F36E887-EB58-400A-8C0D-6778A9863B92}']
   function Get_Node: Il3SimpleNode;
   property Node: Il3SimpleNode
     read Get_Node;
     {* undefined }
 end;//IAttributeTree_SetOneLevelCurrent_Params

 Op_AttributeTree_SetOneLevelCurrent = class
  {* Класс для вызова операции AttributeTree.SetOneLevelCurrent }
 public
 // public methods
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
 // public methods
   class function Call(const aTarget: IvcmEntity): Boolean; overload; 
     {* Вызов операции AttributeTree.AddNodeIfEmpty у сущности }
   class function Call(const aTarget: IvcmAggregate): Boolean; overload; 
     {* Вызов операции AttributeTree.AddNodeIfEmpty у агрегации }
   class function Call(const aTarget: IvcmEntityForm): Boolean; overload; 
     {* Вызов операции AttributeTree.AddNodeIfEmpty у формы }
   class function Call(const aTarget: IvcmContainer): Boolean; overload; 
     {* Вызов операции AttributeTree.AddNodeIfEmpty у контейнера }
 end;//Op_AttributeTree_AddNodeIfEmpty

 ISearchParameters_IsQueryEmpty_Params = interface(IUnknown)
  {* Параметры для операции SearchParameters.IsQueryEmpty }
   ['{3C78ECD9-AC4F-42FF-A84F-07D1F62F246A}']
   function Get_ResultValue: Boolean;
   procedure Set_ResultValue(aValue: Boolean);
   property ResultValue: Boolean
     read Get_ResultValue
     write Set_ResultValue;
     {* undefined }
 end;//ISearchParameters_IsQueryEmpty_Params

 Op_SearchParameters_IsQueryEmpty = class
  {* Класс для вызова операции SearchParameters.IsQueryEmpty }
 public
 // public methods
   class function Call(const aTarget: IvcmEntity): Boolean; overload; 
     {* Вызов операции SearchParameters.IsQueryEmpty у сущности }
   class function Call(const aTarget: IvcmAggregate): Boolean; overload; 
     {* Вызов операции SearchParameters.IsQueryEmpty у агрегации }
   class function Call(const aTarget: IvcmEntityForm): Boolean; overload; 
     {* Вызов операции SearchParameters.IsQueryEmpty у формы }
   class function Call(const aTarget: IvcmContainer): Boolean; overload; 
     {* Вызов операции SearchParameters.IsQueryEmpty у контейнера }
 end;//Op_SearchParameters_IsQueryEmpty

 ISearchParameters_GetQuery_Params = interface(IUnknown)
  {* Параметры для операции SearchParameters.GetQuery }
   ['{82715820-17F2-4302-8EA1-C1E66CF4ABF3}']
   function Get_IgnoreError: Boolean;
   function Get_ResultValue: TnsQueryInfo;
   procedure Set_ResultValue(const aValue: TnsQueryInfo);
   property IgnoreError: Boolean
     read Get_IgnoreError;
     {* undefined }
   property ResultValue: TnsQueryInfo
     read Get_ResultValue
     write Set_ResultValue;
     {* undefined }
 end;//ISearchParameters_GetQuery_Params

 Op_SearchParameters_GetQuery = class
  {* Класс для вызова операции SearchParameters.GetQuery }
 public
 // public methods
   class function Call(const aTarget: IvcmEntity;
    aIgnoreError: Boolean = false): TnsQueryInfo; overload; 
     {* Вызов операции SearchParameters.GetQuery у сущности }
   class function Call(const aTarget: IvcmAggregate;
    aIgnoreError: Boolean = false): TnsQueryInfo; overload; 
     {* Вызов операции SearchParameters.GetQuery у агрегации }
   class function Call(const aTarget: IvcmEntityForm;
    aIgnoreError: Boolean = false): TnsQueryInfo; overload; 
     {* Вызов операции SearchParameters.GetQuery у формы }
   class function Call(const aTarget: IvcmContainer;
    aIgnoreError: Boolean = false): TnsQueryInfo; overload; 
     {* Вызов операции SearchParameters.GetQuery у контейнера }
 end;//Op_SearchParameters_GetQuery

 ISearchParameters_IsQuerySaved_Params = interface(IUnknown)
  {* Параметры для операции SearchParameters.IsQuerySaved }
   ['{8161B454-2BCB-4276-9E84-C4D77CCF9693}']
   function Get_ResultValue: Boolean;
   procedure Set_ResultValue(aValue: Boolean);
   property ResultValue: Boolean
     read Get_ResultValue
     write Set_ResultValue;
     {* undefined }
 end;//ISearchParameters_IsQuerySaved_Params

 Op_SearchParameters_IsQuerySaved = class
  {* Класс для вызова операции SearchParameters.IsQuerySaved }
 public
 // public methods
   class function Call(const aTarget: IvcmEntity): Boolean; overload; 
     {* Вызов операции SearchParameters.IsQuerySaved у сущности }
   class function Call(const aTarget: IvcmAggregate): Boolean; overload; 
     {* Вызов операции SearchParameters.IsQuerySaved у агрегации }
   class function Call(const aTarget: IvcmEntityForm): Boolean; overload; 
     {* Вызов операции SearchParameters.IsQuerySaved у формы }
   class function Call(const aTarget: IvcmContainer): Boolean; overload; 
     {* Вызов операции SearchParameters.IsQuerySaved у контейнера }
 end;//Op_SearchParameters_IsQuerySaved

 ISearchParameters_SetQuery_Params = interface(IUnknown)
  {* Параметры для операции SearchParameters.SetQuery }
   ['{87C1C3B9-72AA-4DFC-9866-7E1B6E9BEB69}']
   function Get_Query: IQuery;
   property Query: IQuery
     read Get_Query;
     {* undefined }
 end;//ISearchParameters_SetQuery_Params

 Op_SearchParameters_SetQuery = class
  {* Класс для вызова операции SearchParameters.SetQuery }
 public
 // public methods
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
 // public methods
   class function Call(const aTarget: IvcmEntity): Boolean; overload; 
     {* Вызов операции SearchParameters.ClearQuery у сущности }
   class function Call(const aTarget: IvcmAggregate): Boolean; overload; 
     {* Вызов операции SearchParameters.ClearQuery у агрегации }
   class function Call(const aTarget: IvcmEntityForm): Boolean; overload; 
     {* Вызов операции SearchParameters.ClearQuery у формы }
   class function Call(const aTarget: IvcmContainer): Boolean; overload; 
     {* Вызов операции SearchParameters.ClearQuery у контейнера }
 end;//Op_SearchParameters_ClearQuery

 IAttributeTree_SaveToQuery_Params = interface(IUnknown)
  {* Параметры для операции AttributeTree.SaveToQuery }
   ['{171CEFE0-76E8-41E1-9AA2-82418A05CFCA}']
   function Get_Query: IQuery;
   property Query: IQuery
     read Get_Query;
     {* undefined }
 end;//IAttributeTree_SaveToQuery_Params

 Op_AttributeTree_SaveToQuery = class
  {* Класс для вызова операции AttributeTree.SaveToQuery }
 public
 // public methods
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

 IAttribute_DefaultAction_Params = interface(IUnknown)
  {* Параметры для операции Attribute.DefaultAction }
   ['{CEF946DF-8C68-4888-AF51-8B73A52FB790}']
   function Get_NIndex: Integer;
   property nIndex: Integer
     read Get_NIndex;
     {* undefined }
 end;//IAttribute_DefaultAction_Params

 Op_Attribute_DefaultAction = class
  {* Класс для вызова операции Attribute.DefaultAction }
 public
 // public methods
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

 IContext_SetContext_Params = interface(IUnknown)
  {* Параметры для операции Context.SetContext }
   ['{CA1EB54F-63E2-4BB4-A7D4-7136DD5A49E0}']
   function Get_State: InscContextFilterState;
   property State: InscContextFilterState
     read Get_State;
     {* undefined }
 end;//IContext_SetContext_Params

 Op_Context_SetContext = class
  {* Класс для вызова операции Context.SetContext }
 public
 // public methods
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

 IContext_SyncContextParams_Params = interface(IUnknown)
  {* Параметры для операции Context.SyncContextParams }
   ['{AD4F283A-B3DC-4391-AB30-739DBAD4470B}']
   function Get_AdditionalFilter: TnsFilterType;
   property AdditionalFilter: TnsFilterType
     read Get_AdditionalFilter;
     {* undefined }
 end;//IContext_SyncContextParams_Params

 Op_Context_SyncContextParams = class
  {* Класс для вызова операции Context.SyncContextParams }
 public
 // public methods
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

 IAttributeTree_SetParent_Params = interface(IUnknown)
  {* Параметры для операции AttributeTree.SetParent }
   ['{830F9F58-31DB-425B-B0A2-AC19AB497634}']
   function Get_Parent: Il3SimpleNode;
   property Parent: Il3SimpleNode
     read Get_Parent;
     {* undefined }
 end;//IAttributeTree_SetParent_Params

 Op_AttributeTree_SetParent = class
  {* Класс для вызова операции AttributeTree.SetParent }
 public
 // public methods
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

 IAttributeTree_ExtSetRoot_Params = interface(IUnknown)
  {* Параметры для операции AttributeTree.ExtSetRoot }
   ['{06B285A8-91B5-4E2E-8C76-71CA31A57CE0}']
   function Get_Root: INodeBase;
   property Root: INodeBase
     read Get_Root;
     {* undefined }
 end;//IAttributeTree_ExtSetRoot_Params

 Op_AttributeTree_ExtSetRoot = class
  {* Класс для вызова операции AttributeTree.ExtSetRoot }
 public
 // public methods
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

 IAttributeTree_SetRoot_Params = interface(IUnknown)
  {* Параметры для операции AttributeTree.SetRoot }
   ['{2F2E0ADC-9951-434E-B1F4-6125DEFF6DD6}']
   function Get_Tag: Il3CString;
   property Tag: Il3CString
     read Get_Tag;
     {* undefined }
 end;//IAttributeTree_SetRoot_Params

 Op_AttributeTree_SetRoot = class
  {* Класс для вызова операции AttributeTree.SetRoot }
 public
 // public methods
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

 IAttributeTree_ChangeRoot_Params = interface(IUnknown)
  {* Параметры для операции AttributeTree.ChangeRoot }
   ['{77A4E369-2E48-473F-8EE4-3ABC88C1C127}']
   function Get_Tag: Il3CString;
   function Get_Root: Il3SimpleNode;
   function Get_Current: Il3SimpleNode;
   property Tag: Il3CString
     read Get_Tag;
     {* undefined }
   property Root: Il3SimpleNode
     read Get_Root;
     {* undefined }
   property Current: Il3SimpleNode
     read Get_Current;
     {* undefined }
 end;//IAttributeTree_ChangeRoot_Params

 Op_AttributeTree_ChangeRoot = class
  {* Класс для вызова операции AttributeTree.ChangeRoot }
 public
 // public methods
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

 IContextParams_ContextChanged_Params = interface(IUnknown)
  {* Параметры для операции ContextParams.ContextChanged }
   ['{1B63082F-5388-4039-82F1-91E9139413F9}']
   function Get_ContextState: InscContextFilterState;
   function Get_ContextTarget: Il3ContextFilterTarget;
   property ContextState: InscContextFilterState
     read Get_ContextState;
     {* undefined }
   property ContextTarget: Il3ContextFilterTarget
     read Get_ContextTarget;
     {* undefined }
 end;//IContextParams_ContextChanged_Params

 Op_ContextParams_ContextChanged = class
  {* Класс для вызова операции ContextParams.ContextChanged }
 public
 // public methods
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

 ISelectedList_RefreshValues_Params = interface(IUnknown)
  {* Параметры для операции SelectedList.RefreshValues }
   ['{C3428A6F-9C03-4D2C-B279-FBD13C2F869D}']
   function Get_Data: InsSelectedAttributesIterators;
   property Data: InsSelectedAttributesIterators
     read Get_Data;
     {* undefined }
 end;//ISelectedList_RefreshValues_Params

 Op_SelectedList_RefreshValues = class
  {* Класс для вызова операции SelectedList.RefreshValues }
 public
 // public methods
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

implementation

uses
  l3Base {a},
  vcmBase {a},
  StdRes {a}
  ;

type
 TAttributeTree_ExternalCharPressed_Params = class(Tl3CProtoObject, IAttributeTree_ExternalCharPressed_Params)
  {* Реализация IAttributeTree_ExternalCharPressed_Params }
 private
 // private fields
   f_Char : Il3CString;
 protected
 // realized methods
   function Get_Char: Il3CString;
 protected
 // overridden protected methods
   procedure ClearFields; override;
     {* Сигнатура метода ClearFields }
 public
 // public methods
   constructor Create(const aChar: Il3CString); reintroduce;
     {* Конструктор TAttributeTree_ExternalCharPressed_Params }
   class function Make(const aChar: Il3CString): IAttributeTree_ExternalCharPressed_Params; reintroduce;
     {* Фабрика TAttributeTree_ExternalCharPressed_Params }
 end;//TAttributeTree_ExternalCharPressed_Params

// start class TAttributeTree_ExternalCharPressed_Params

constructor TAttributeTree_ExternalCharPressed_Params.Create(const aChar: Il3CString);
 {-}
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
end;

function TAttributeTree_ExternalCharPressed_Params.Get_Char: Il3CString;
 {-}
begin
 Result := f_Char;
end;//TAttributeTree_ExternalCharPressed_Params.Get_Char

procedure TAttributeTree_ExternalCharPressed_Params.ClearFields;
 {-}
begin
 f_Char := nil;
 inherited;
end;//TAttributeTree_ExternalCharPressed_Params.ClearFields
// start class Op_AttributeTree_ExternalCharPressed

class function Op_AttributeTree_ExternalCharPressed.Call(const aTarget: IvcmEntity;
  const aChar: Il3CString): Boolean;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TAttributeTree_ExternalCharPressed_Params.Make(aChar));
  aTarget.Operation(TdmStdRes.opcode_AttributeTree_ExternalCharPressed, l_Params);
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
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TAttributeTree_ExternalCharPressed_Params.Make(aChar));
  aTarget.Operation(TdmStdRes.opcode_AttributeTree_ExternalCharPressed, l_Params);
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
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity, aChar);
end;//Op_AttributeTree_ExternalCharPressed.Call

class function Op_AttributeTree_ExternalCharPressed.Call(const aTarget: IvcmContainer;
  const aChar: Il3CString): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm, aChar);
end;//Op_AttributeTree_ExternalCharPressed.Call

type
 TAttributeTree_SetCurrent_Params = class(Tl3CProtoObject, IAttributeTree_SetCurrent_Params)
  {* Реализация IAttributeTree_SetCurrent_Params }
 private
 // private fields
   f_Node : Il3SimpleNode;
   f_Expand : Boolean;
 protected
 // realized methods
   function Get_Node: Il3SimpleNode;
   function Get_Expand: Boolean;
 protected
 // overridden protected methods
   procedure ClearFields; override;
     {* Сигнатура метода ClearFields }
 public
 // public methods
   constructor Create(const aNode: Il3SimpleNode;
    aExpand: Boolean); reintroduce;
     {* Конструктор TAttributeTree_SetCurrent_Params }
   class function Make(const aNode: Il3SimpleNode;
    aExpand: Boolean): IAttributeTree_SetCurrent_Params; reintroduce;
     {* Фабрика TAttributeTree_SetCurrent_Params }
 end;//TAttributeTree_SetCurrent_Params

// start class TAttributeTree_SetCurrent_Params

constructor TAttributeTree_SetCurrent_Params.Create(const aNode: Il3SimpleNode;
  aExpand: Boolean);
 {-}
begin
 inherited Create;
 f_Node := aNode;
 f_Expand := aExpand;
end;//TAttributeTree_SetCurrent_Params.Create

class function TAttributeTree_SetCurrent_Params.Make(const aNode: Il3SimpleNode;
  aExpand: Boolean): IAttributeTree_SetCurrent_Params;
var
 l_Inst : TAttributeTree_SetCurrent_Params;
begin
 l_Inst := Create(aNode, aExpand);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

function TAttributeTree_SetCurrent_Params.Get_Node: Il3SimpleNode;
 {-}
begin
 Result := f_Node;
end;//TAttributeTree_SetCurrent_Params.Get_Node

function TAttributeTree_SetCurrent_Params.Get_Expand: Boolean;
 {-}
begin
 Result := f_Expand;
end;//TAttributeTree_SetCurrent_Params.Get_Expand

procedure TAttributeTree_SetCurrent_Params.ClearFields;
 {-}
begin
 f_Node := nil;
 inherited;
end;//TAttributeTree_SetCurrent_Params.ClearFields
// start class Op_AttributeTree_SetCurrent

class function Op_AttributeTree_SetCurrent.Call(const aTarget: IvcmEntity;
  const aNode: Il3SimpleNode;
  aExpand: Boolean = false): Boolean;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TAttributeTree_SetCurrent_Params.Make(aNode,aExpand));
  aTarget.Operation(TdmStdRes.opcode_AttributeTree_SetCurrent, l_Params);
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
  aExpand: Boolean = false): Boolean;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TAttributeTree_SetCurrent_Params.Make(aNode,aExpand));
  aTarget.Operation(TdmStdRes.opcode_AttributeTree_SetCurrent, l_Params);
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
  aExpand: Boolean = false): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity, aNode, aExpand);
end;//Op_AttributeTree_SetCurrent.Call

class function Op_AttributeTree_SetCurrent.Call(const aTarget: IvcmContainer;
  const aNode: Il3SimpleNode;
  aExpand: Boolean = false): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm, aNode, aExpand);
end;//Op_AttributeTree_SetCurrent.Call

type
 TAttributeTree_DropAllLogicSelection_Params = class(Tl3CProtoObject, IAttributeTree_DropAllLogicSelection_Params)
  {* Реализация IAttributeTree_DropAllLogicSelection_Params }
 private
 // private fields
   f_DropSelection : Boolean;
   f_NotifyMultipleChanges : Boolean;
   f_SetToTop : Boolean;
 protected
 // realized methods
   function Get_NotifyMultipleChanges: Boolean;
   function Get_SetToTop: Boolean;
   function Get_DropSelection: Boolean;
 public
 // public methods
   constructor Create(aDropSelection: Boolean;
    aNotifyMultipleChanges: Boolean;
    SetToTop: Boolean); reintroduce;
     {* Конструктор TAttributeTree_DropAllLogicSelection_Params }
   class function Make(aDropSelection: Boolean;
    aNotifyMultipleChanges: Boolean;
    SetToTop: Boolean): IAttributeTree_DropAllLogicSelection_Params; reintroduce;
     {* Фабрика TAttributeTree_DropAllLogicSelection_Params }
 end;//TAttributeTree_DropAllLogicSelection_Params

// start class TAttributeTree_DropAllLogicSelection_Params

constructor TAttributeTree_DropAllLogicSelection_Params.Create(aDropSelection: Boolean;
  aNotifyMultipleChanges: Boolean;
  SetToTop: Boolean);
 {-}
begin
 inherited Create;
 f_DropSelection := aDropSelection;
 f_NotifyMultipleChanges := aNotifyMultipleChanges;
 f_SetToTop := SetToTop;
end;//TAttributeTree_DropAllLogicSelection_Params.Create

class function TAttributeTree_DropAllLogicSelection_Params.Make(aDropSelection: Boolean;
  aNotifyMultipleChanges: Boolean;
  SetToTop: Boolean): IAttributeTree_DropAllLogicSelection_Params;
var
 l_Inst : TAttributeTree_DropAllLogicSelection_Params;
begin
 l_Inst := Create(aDropSelection, aNotifyMultipleChanges, SetToTop);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

function TAttributeTree_DropAllLogicSelection_Params.Get_NotifyMultipleChanges: Boolean;
 {-}
begin
 Result := f_NotifyMultipleChanges;
end;//TAttributeTree_DropAllLogicSelection_Params.Get_NotifyMultipleChanges

function TAttributeTree_DropAllLogicSelection_Params.Get_SetToTop: Boolean;
 {-}
begin
 Result := f_SetToTop;
end;//TAttributeTree_DropAllLogicSelection_Params.Get_SetToTop

function TAttributeTree_DropAllLogicSelection_Params.Get_DropSelection: Boolean;
 {-}
begin
 Result := f_DropSelection;
end;//TAttributeTree_DropAllLogicSelection_Params.Get_DropSelection
// start class Op_AttributeTree_DropAllLogicSelection

class function Op_AttributeTree_DropAllLogicSelection.Call(const aTarget: IvcmEntity;
  aDropSelection: Boolean;
  aNotifyMultipleChanges: Boolean = false;
  SetToTop: Boolean = True): Boolean;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TAttributeTree_DropAllLogicSelection_Params.Make(aDropSelection,aNotifyMultipleChanges,SetToTop));
  aTarget.Operation(TdmStdRes.opcode_AttributeTree_DropAllLogicSelection, l_Params);
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
  aNotifyMultipleChanges: Boolean = false;
  SetToTop: Boolean = True): Boolean;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TAttributeTree_DropAllLogicSelection_Params.Make(aDropSelection,aNotifyMultipleChanges,SetToTop));
  aTarget.Operation(TdmStdRes.opcode_AttributeTree_DropAllLogicSelection, l_Params);
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
  aNotifyMultipleChanges: Boolean = false;
  SetToTop: Boolean = True): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity, aDropSelection, aNotifyMultipleChanges, SetToTop);
end;//Op_AttributeTree_DropAllLogicSelection.Call

class function Op_AttributeTree_DropAllLogicSelection.Call(const aTarget: IvcmContainer;
  aDropSelection: Boolean;
  aNotifyMultipleChanges: Boolean = false;
  SetToTop: Boolean = True): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm, aDropSelection, aNotifyMultipleChanges, SetToTop);
end;//Op_AttributeTree_DropAllLogicSelection.Call

type
 TAttributeTree_Invalidate_Params = class(Tl3CProtoObject, IAttributeTree_Invalidate_Params)
  {* Реализация IAttributeTree_Invalidate_Params }
 private
 // private fields
   f_UserType : Integer;
 protected
 // realized methods
   function Get_UserType: Integer;
 public
 // public methods
   constructor Create(aUserType: Integer); reintroduce;
     {* Конструктор TAttributeTree_Invalidate_Params }
   class function Make(aUserType: Integer): IAttributeTree_Invalidate_Params; reintroduce;
     {* Фабрика TAttributeTree_Invalidate_Params }
 end;//TAttributeTree_Invalidate_Params

// start class TAttributeTree_Invalidate_Params

constructor TAttributeTree_Invalidate_Params.Create(aUserType: Integer);
 {-}
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
end;

function TAttributeTree_Invalidate_Params.Get_UserType: Integer;
 {-}
begin
 Result := f_UserType;
end;//TAttributeTree_Invalidate_Params.Get_UserType
// start class Op_AttributeTree_Invalidate

class function Op_AttributeTree_Invalidate.Call(const aTarget: IvcmEntity;
  aUserType: Integer): Boolean;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TAttributeTree_Invalidate_Params.Make(aUserType));
  aTarget.Operation(TdmStdRes.opcode_AttributeTree_Invalidate, l_Params);
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
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TAttributeTree_Invalidate_Params.Make(aUserType));
  aTarget.Operation(TdmStdRes.opcode_AttributeTree_Invalidate, l_Params);
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
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity, aUserType);
end;//Op_AttributeTree_Invalidate.Call

class function Op_AttributeTree_Invalidate.Call(const aTarget: IvcmContainer;
  aUserType: Integer): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm, aUserType);
end;//Op_AttributeTree_Invalidate.Call

type
 TAttributeTree_DropLogicSelection_Params = class(Tl3CProtoObject, IAttributeTree_DropLogicSelection_Params)
  {* Реализация IAttributeTree_DropLogicSelection_Params }
 private
 // private fields
   f_Node : INodeBase;
 protected
 // realized methods
   function Get_Node: INodeBase;
 protected
 // overridden protected methods
   procedure ClearFields; override;
     {* Сигнатура метода ClearFields }
 public
 // public methods
   constructor Create(const aNode: INodeBase); reintroduce;
     {* Конструктор TAttributeTree_DropLogicSelection_Params }
   class function Make(const aNode: INodeBase): IAttributeTree_DropLogicSelection_Params; reintroduce;
     {* Фабрика TAttributeTree_DropLogicSelection_Params }
 end;//TAttributeTree_DropLogicSelection_Params

// start class TAttributeTree_DropLogicSelection_Params

constructor TAttributeTree_DropLogicSelection_Params.Create(const aNode: INodeBase);
 {-}
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
end;

function TAttributeTree_DropLogicSelection_Params.Get_Node: INodeBase;
 {-}
begin
 Result := f_Node;
end;//TAttributeTree_DropLogicSelection_Params.Get_Node

procedure TAttributeTree_DropLogicSelection_Params.ClearFields;
 {-}
begin
 f_Node := nil;
 inherited;
end;//TAttributeTree_DropLogicSelection_Params.ClearFields
// start class Op_AttributeTree_DropLogicSelection

class function Op_AttributeTree_DropLogicSelection.Call(const aTarget: IvcmEntity;
  const aNode: INodeBase): Boolean;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TAttributeTree_DropLogicSelection_Params.Make(aNode));
  aTarget.Operation(TdmStdRes.opcode_AttributeTree_DropLogicSelection, l_Params);
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
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TAttributeTree_DropLogicSelection_Params.Make(aNode));
  aTarget.Operation(TdmStdRes.opcode_AttributeTree_DropLogicSelection, l_Params);
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
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity, aNode);
end;//Op_AttributeTree_DropLogicSelection.Call

class function Op_AttributeTree_DropLogicSelection.Call(const aTarget: IvcmContainer;
  const aNode: INodeBase): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm, aNode);
end;//Op_AttributeTree_DropLogicSelection.Call

type
 TAttributeTree_LoadQuery_Params = class(Tl3CProtoObject, IAttributeTree_LoadQuery_Params)
  {* Реализация IAttributeTree_LoadQuery_Params }
 private
 // private fields
   f_Query : IQuery;
 protected
 // realized methods
   function Get_Query: IQuery;
 protected
 // overridden protected methods
   procedure ClearFields; override;
     {* Сигнатура метода ClearFields }
 public
 // public methods
   constructor Create(const aQuery: IQuery); reintroduce;
     {* Конструктор TAttributeTree_LoadQuery_Params }
   class function Make(const aQuery: IQuery): IAttributeTree_LoadQuery_Params; reintroduce;
     {* Фабрика TAttributeTree_LoadQuery_Params }
 end;//TAttributeTree_LoadQuery_Params

// start class TAttributeTree_LoadQuery_Params

constructor TAttributeTree_LoadQuery_Params.Create(const aQuery: IQuery);
 {-}
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
end;

function TAttributeTree_LoadQuery_Params.Get_Query: IQuery;
 {-}
begin
 Result := f_Query;
end;//TAttributeTree_LoadQuery_Params.Get_Query

procedure TAttributeTree_LoadQuery_Params.ClearFields;
 {-}
begin
 f_Query := nil;
 inherited;
end;//TAttributeTree_LoadQuery_Params.ClearFields
// start class Op_AttributeTree_LoadQuery

class function Op_AttributeTree_LoadQuery.Call(const aTarget: IvcmEntity;
  const aQuery: IQuery): Boolean;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TAttributeTree_LoadQuery_Params.Make(aQuery));
  aTarget.Operation(TdmStdRes.opcode_AttributeTree_LoadQuery, l_Params);
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
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TAttributeTree_LoadQuery_Params.Make(aQuery));
  aTarget.Operation(TdmStdRes.opcode_AttributeTree_LoadQuery, l_Params);
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
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity, aQuery);
end;//Op_AttributeTree_LoadQuery.Call

class function Op_AttributeTree_LoadQuery.Call(const aTarget: IvcmContainer;
  const aQuery: IQuery): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm, aQuery);
end;//Op_AttributeTree_LoadQuery.Call

type
 TAttributeTree_SetOneLevelCurrent_Params = class(Tl3CProtoObject, IAttributeTree_SetOneLevelCurrent_Params)
  {* Реализация IAttributeTree_SetOneLevelCurrent_Params }
 private
 // private fields
   f_Node : Il3SimpleNode;
 protected
 // realized methods
   function Get_Node: Il3SimpleNode;
 protected
 // overridden protected methods
   procedure ClearFields; override;
     {* Сигнатура метода ClearFields }
 public
 // public methods
   constructor Create(const aNode: Il3SimpleNode); reintroduce;
     {* Конструктор TAttributeTree_SetOneLevelCurrent_Params }
   class function Make(const aNode: Il3SimpleNode): IAttributeTree_SetOneLevelCurrent_Params; reintroduce;
     {* Фабрика TAttributeTree_SetOneLevelCurrent_Params }
 end;//TAttributeTree_SetOneLevelCurrent_Params

// start class TAttributeTree_SetOneLevelCurrent_Params

constructor TAttributeTree_SetOneLevelCurrent_Params.Create(const aNode: Il3SimpleNode);
 {-}
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
end;

function TAttributeTree_SetOneLevelCurrent_Params.Get_Node: Il3SimpleNode;
 {-}
begin
 Result := f_Node;
end;//TAttributeTree_SetOneLevelCurrent_Params.Get_Node

procedure TAttributeTree_SetOneLevelCurrent_Params.ClearFields;
 {-}
begin
 f_Node := nil;
 inherited;
end;//TAttributeTree_SetOneLevelCurrent_Params.ClearFields
// start class Op_AttributeTree_SetOneLevelCurrent

class function Op_AttributeTree_SetOneLevelCurrent.Call(const aTarget: IvcmEntity;
  const aNode: Il3SimpleNode): Boolean;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TAttributeTree_SetOneLevelCurrent_Params.Make(aNode));
  aTarget.Operation(TdmStdRes.opcode_AttributeTree_SetOneLevelCurrent, l_Params);
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
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TAttributeTree_SetOneLevelCurrent_Params.Make(aNode));
  aTarget.Operation(TdmStdRes.opcode_AttributeTree_SetOneLevelCurrent, l_Params);
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
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity, aNode);
end;//Op_AttributeTree_SetOneLevelCurrent.Call

class function Op_AttributeTree_SetOneLevelCurrent.Call(const aTarget: IvcmContainer;
  const aNode: Il3SimpleNode): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm, aNode);
end;//Op_AttributeTree_SetOneLevelCurrent.Call
// start class Op_AttributeTree_AddNodeIfEmpty

class function Op_AttributeTree_AddNodeIfEmpty.Call(const aTarget: IvcmEntity): Boolean;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := vcmParams;
  aTarget.Operation(TdmStdRes.opcode_AttributeTree_AddNodeIfEmpty, l_Params);
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
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := vcmParams;
  aTarget.Operation(TdmStdRes.opcode_AttributeTree_AddNodeIfEmpty, l_Params);
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
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity);
end;//Op_AttributeTree_AddNodeIfEmpty.Call

class function Op_AttributeTree_AddNodeIfEmpty.Call(const aTarget: IvcmContainer): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm);
end;//Op_AttributeTree_AddNodeIfEmpty.Call

type
 TSearchParameters_IsQueryEmpty_Params = class(Tl3CProtoObject, ISearchParameters_IsQueryEmpty_Params)
  {* Реализация ISearchParameters_IsQueryEmpty_Params }
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
     {* Конструктор TSearchParameters_IsQueryEmpty_Params }
   class function Make: ISearchParameters_IsQueryEmpty_Params; reintroduce;
     {* Фабрика TSearchParameters_IsQueryEmpty_Params }
 end;//TSearchParameters_IsQueryEmpty_Params

// start class TSearchParameters_IsQueryEmpty_Params

constructor TSearchParameters_IsQueryEmpty_Params.Create;
 {-}
begin
 inherited Create;
end;//TSearchParameters_IsQueryEmpty_Params.Create

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
end;

function TSearchParameters_IsQueryEmpty_Params.Get_ResultValue: Boolean;
 {-}
begin
 Result := f_ResultValue;
end;//TSearchParameters_IsQueryEmpty_Params.Get_ResultValue

procedure TSearchParameters_IsQueryEmpty_Params.Set_ResultValue(aValue: Boolean);
 {-}
begin
 f_ResultValue := aValue;
end;//TSearchParameters_IsQueryEmpty_Params.Set_ResultValue
// start class Op_SearchParameters_IsQueryEmpty

class function Op_SearchParameters_IsQueryEmpty.Call(const aTarget: IvcmEntity): Boolean;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TSearchParameters_IsQueryEmpty_Params.Make);
  aTarget.Operation(TdmStdRes.opcode_SearchParameters_IsQueryEmpty, l_Params);
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
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TSearchParameters_IsQueryEmpty_Params.Make);
  aTarget.Operation(TdmStdRes.opcode_SearchParameters_IsQueryEmpty, l_Params);
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
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity);
end;//Op_SearchParameters_IsQueryEmpty.Call

class function Op_SearchParameters_IsQueryEmpty.Call(const aTarget: IvcmContainer): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm);
end;//Op_SearchParameters_IsQueryEmpty.Call

type
 TSearchParameters_GetQuery_Params = class(Tl3CProtoObject, ISearchParameters_GetQuery_Params)
  {* Реализация ISearchParameters_GetQuery_Params }
 private
 // private fields
   f_IgnoreError : Boolean;
   f_ResultValue : TnsQueryInfo;
 protected
 // realized methods
   function Get_IgnoreError: Boolean;
   function Get_ResultValue: TnsQueryInfo;
   procedure Set_ResultValue(const aValue: TnsQueryInfo);
 protected
 // overridden protected methods
   procedure ClearFields; override;
     {* Сигнатура метода ClearFields }
 public
 // public methods
   constructor Create(aIgnoreError: Boolean); reintroduce;
     {* Конструктор TSearchParameters_GetQuery_Params }
   class function Make(aIgnoreError: Boolean): ISearchParameters_GetQuery_Params; reintroduce;
     {* Фабрика TSearchParameters_GetQuery_Params }
 end;//TSearchParameters_GetQuery_Params

// start class TSearchParameters_GetQuery_Params

constructor TSearchParameters_GetQuery_Params.Create(aIgnoreError: Boolean);
 {-}
begin
 inherited Create;
 f_IgnoreError := aIgnoreError;
end;//TSearchParameters_GetQuery_Params.Create

class function TSearchParameters_GetQuery_Params.Make(aIgnoreError: Boolean): ISearchParameters_GetQuery_Params;
var
 l_Inst : TSearchParameters_GetQuery_Params;
begin
 l_Inst := Create(aIgnoreError);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

function TSearchParameters_GetQuery_Params.Get_IgnoreError: Boolean;
 {-}
begin
 Result := f_IgnoreError;
end;//TSearchParameters_GetQuery_Params.Get_IgnoreError

function TSearchParameters_GetQuery_Params.Get_ResultValue: TnsQueryInfo;
 {-}
begin
 Result := f_ResultValue;
end;//TSearchParameters_GetQuery_Params.Get_ResultValue

procedure TSearchParameters_GetQuery_Params.Set_ResultValue(const aValue: TnsQueryInfo);
 {-}
begin
 f_ResultValue := aValue;
end;//TSearchParameters_GetQuery_Params.Set_ResultValue

procedure TSearchParameters_GetQuery_Params.ClearFields;
 {-}
begin
 Finalize(f_ResultValue);
 inherited;
end;//TSearchParameters_GetQuery_Params.ClearFields
// start class Op_SearchParameters_GetQuery

class function Op_SearchParameters_GetQuery.Call(const aTarget: IvcmEntity;
  aIgnoreError: Boolean = false): TnsQueryInfo;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TSearchParameters_GetQuery_Params.Make(aIgnoreError));
  aTarget.Operation(TdmStdRes.opcode_SearchParameters_GetQuery, l_Params);
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
  aIgnoreError: Boolean = false): TnsQueryInfo;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TSearchParameters_GetQuery_Params.Make(aIgnoreError));
  aTarget.Operation(TdmStdRes.opcode_SearchParameters_GetQuery, l_Params);
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
  aIgnoreError: Boolean = false): TnsQueryInfo;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity, aIgnoreError);
end;//Op_SearchParameters_GetQuery.Call

class function Op_SearchParameters_GetQuery.Call(const aTarget: IvcmContainer;
  aIgnoreError: Boolean = false): TnsQueryInfo;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm, aIgnoreError);
end;//Op_SearchParameters_GetQuery.Call

type
 TSearchParameters_IsQuerySaved_Params = class(Tl3CProtoObject, ISearchParameters_IsQuerySaved_Params)
  {* Реализация ISearchParameters_IsQuerySaved_Params }
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
     {* Конструктор TSearchParameters_IsQuerySaved_Params }
   class function Make: ISearchParameters_IsQuerySaved_Params; reintroduce;
     {* Фабрика TSearchParameters_IsQuerySaved_Params }
 end;//TSearchParameters_IsQuerySaved_Params

// start class TSearchParameters_IsQuerySaved_Params

constructor TSearchParameters_IsQuerySaved_Params.Create;
 {-}
begin
 inherited Create;
end;//TSearchParameters_IsQuerySaved_Params.Create

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
end;

function TSearchParameters_IsQuerySaved_Params.Get_ResultValue: Boolean;
 {-}
begin
 Result := f_ResultValue;
end;//TSearchParameters_IsQuerySaved_Params.Get_ResultValue

procedure TSearchParameters_IsQuerySaved_Params.Set_ResultValue(aValue: Boolean);
 {-}
begin
 f_ResultValue := aValue;
end;//TSearchParameters_IsQuerySaved_Params.Set_ResultValue
// start class Op_SearchParameters_IsQuerySaved

class function Op_SearchParameters_IsQuerySaved.Call(const aTarget: IvcmEntity): Boolean;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TSearchParameters_IsQuerySaved_Params.Make);
  aTarget.Operation(TdmStdRes.opcode_SearchParameters_IsQuerySaved, l_Params);
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
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TSearchParameters_IsQuerySaved_Params.Make);
  aTarget.Operation(TdmStdRes.opcode_SearchParameters_IsQuerySaved, l_Params);
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
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity);
end;//Op_SearchParameters_IsQuerySaved.Call

class function Op_SearchParameters_IsQuerySaved.Call(const aTarget: IvcmContainer): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm);
end;//Op_SearchParameters_IsQuerySaved.Call

type
 TSearchParameters_SetQuery_Params = class(Tl3CProtoObject, ISearchParameters_SetQuery_Params)
  {* Реализация ISearchParameters_SetQuery_Params }
 private
 // private fields
   f_Query : IQuery;
 protected
 // realized methods
   function Get_Query: IQuery;
 protected
 // overridden protected methods
   procedure ClearFields; override;
     {* Сигнатура метода ClearFields }
 public
 // public methods
   constructor Create(const aQuery: IQuery); reintroduce;
     {* Конструктор TSearchParameters_SetQuery_Params }
   class function Make(const aQuery: IQuery): ISearchParameters_SetQuery_Params; reintroduce;
     {* Фабрика TSearchParameters_SetQuery_Params }
 end;//TSearchParameters_SetQuery_Params

// start class TSearchParameters_SetQuery_Params

constructor TSearchParameters_SetQuery_Params.Create(const aQuery: IQuery);
 {-}
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
end;

function TSearchParameters_SetQuery_Params.Get_Query: IQuery;
 {-}
begin
 Result := f_Query;
end;//TSearchParameters_SetQuery_Params.Get_Query

procedure TSearchParameters_SetQuery_Params.ClearFields;
 {-}
begin
 f_Query := nil;
 inherited;
end;//TSearchParameters_SetQuery_Params.ClearFields
// start class Op_SearchParameters_SetQuery

class function Op_SearchParameters_SetQuery.Call(const aTarget: IvcmEntity;
  const aQuery: IQuery): Boolean;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TSearchParameters_SetQuery_Params.Make(aQuery));
  aTarget.Operation(TdmStdRes.opcode_SearchParameters_SetQuery, l_Params);
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
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TSearchParameters_SetQuery_Params.Make(aQuery));
  aTarget.Operation(TdmStdRes.opcode_SearchParameters_SetQuery, l_Params);
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
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity, aQuery);
end;//Op_SearchParameters_SetQuery.Call

class function Op_SearchParameters_SetQuery.Call(const aTarget: IvcmContainer;
  const aQuery: IQuery): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm, aQuery);
end;//Op_SearchParameters_SetQuery.Call
// start class Op_SearchParameters_ClearQuery

class function Op_SearchParameters_ClearQuery.Call(const aTarget: IvcmEntity): Boolean;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := vcmParams;
  aTarget.Operation(TdmStdRes.opcode_SearchParameters_ClearQuery, l_Params);
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
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := vcmParams;
  aTarget.Operation(TdmStdRes.opcode_SearchParameters_ClearQuery, l_Params);
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
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity);
end;//Op_SearchParameters_ClearQuery.Call

class function Op_SearchParameters_ClearQuery.Call(const aTarget: IvcmContainer): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm);
end;//Op_SearchParameters_ClearQuery.Call

type
 TAttributeTree_SaveToQuery_Params = class(Tl3CProtoObject, IAttributeTree_SaveToQuery_Params)
  {* Реализация IAttributeTree_SaveToQuery_Params }
 private
 // private fields
   f_Query : IQuery;
 protected
 // realized methods
   function Get_Query: IQuery;
 protected
 // overridden protected methods
   procedure ClearFields; override;
     {* Сигнатура метода ClearFields }
 public
 // public methods
   constructor Create(const aQuery: IQuery); reintroduce;
     {* Конструктор TAttributeTree_SaveToQuery_Params }
   class function Make(const aQuery: IQuery): IAttributeTree_SaveToQuery_Params; reintroduce;
     {* Фабрика TAttributeTree_SaveToQuery_Params }
 end;//TAttributeTree_SaveToQuery_Params

// start class TAttributeTree_SaveToQuery_Params

constructor TAttributeTree_SaveToQuery_Params.Create(const aQuery: IQuery);
 {-}
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
end;

function TAttributeTree_SaveToQuery_Params.Get_Query: IQuery;
 {-}
begin
 Result := f_Query;
end;//TAttributeTree_SaveToQuery_Params.Get_Query

procedure TAttributeTree_SaveToQuery_Params.ClearFields;
 {-}
begin
 f_Query := nil;
 inherited;
end;//TAttributeTree_SaveToQuery_Params.ClearFields
// start class Op_AttributeTree_SaveToQuery

class function Op_AttributeTree_SaveToQuery.Call(const aTarget: IvcmEntity;
  const aQuery: IQuery): Boolean;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TAttributeTree_SaveToQuery_Params.Make(aQuery));
  aTarget.Operation(TdmStdRes.opcode_AttributeTree_SaveToQuery, l_Params);
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
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TAttributeTree_SaveToQuery_Params.Make(aQuery));
  aTarget.Operation(TdmStdRes.opcode_AttributeTree_SaveToQuery, l_Params);
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
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity, aQuery);
end;//Op_AttributeTree_SaveToQuery.Call

class function Op_AttributeTree_SaveToQuery.Call(const aTarget: IvcmContainer;
  const aQuery: IQuery): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm, aQuery);
end;//Op_AttributeTree_SaveToQuery.Call

type
 TAttribute_DefaultAction_Params = class(Tl3CProtoObject, IAttribute_DefaultAction_Params)
  {* Реализация IAttribute_DefaultAction_Params }
 private
 // private fields
   f_nIndex : Integer;
 protected
 // realized methods
   function Get_NIndex: Integer;
 public
 // public methods
   constructor Create(anIndex: Integer); reintroduce;
     {* Конструктор TAttribute_DefaultAction_Params }
   class function Make(anIndex: Integer): IAttribute_DefaultAction_Params; reintroduce;
     {* Фабрика TAttribute_DefaultAction_Params }
 end;//TAttribute_DefaultAction_Params

// start class TAttribute_DefaultAction_Params

constructor TAttribute_DefaultAction_Params.Create(anIndex: Integer);
 {-}
begin
 inherited Create;
 f_nIndex := anIndex;
end;//TAttribute_DefaultAction_Params.Create

class function TAttribute_DefaultAction_Params.Make(anIndex: Integer): IAttribute_DefaultAction_Params;
var
 l_Inst : TAttribute_DefaultAction_Params;
begin
 l_Inst := Create(anIndex);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

function TAttribute_DefaultAction_Params.Get_NIndex: Integer;
 {-}
begin
 Result := f_nIndex;
end;//TAttribute_DefaultAction_Params.Get_NIndex
// start class Op_Attribute_DefaultAction

class function Op_Attribute_DefaultAction.Call(const aTarget: IvcmEntity;
  anIndex: Integer = -1): Boolean;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TAttribute_DefaultAction_Params.Make(anIndex));
  aTarget.Operation(TdmStdRes.opcode_Attribute_DefaultAction, l_Params);
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
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TAttribute_DefaultAction_Params.Make(anIndex));
  aTarget.Operation(TdmStdRes.opcode_Attribute_DefaultAction, l_Params);
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
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity, anIndex);
end;//Op_Attribute_DefaultAction.Call

class function Op_Attribute_DefaultAction.Call(const aTarget: IvcmContainer;
  anIndex: Integer = -1): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm, anIndex);
end;//Op_Attribute_DefaultAction.Call

type
 TContext_SetContext_Params = class(Tl3CProtoObject, IContext_SetContext_Params)
  {* Реализация IContext_SetContext_Params }
 private
 // private fields
   f_State : InscContextFilterState;
 protected
 // realized methods
   function Get_State: InscContextFilterState;
 protected
 // overridden protected methods
   procedure ClearFields; override;
     {* Сигнатура метода ClearFields }
 public
 // public methods
   constructor Create(const aState: InscContextFilterState); reintroduce;
     {* Конструктор TContext_SetContext_Params }
   class function Make(const aState: InscContextFilterState): IContext_SetContext_Params; reintroduce;
     {* Фабрика TContext_SetContext_Params }
 end;//TContext_SetContext_Params

// start class TContext_SetContext_Params

constructor TContext_SetContext_Params.Create(const aState: InscContextFilterState);
 {-}
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
end;

function TContext_SetContext_Params.Get_State: InscContextFilterState;
 {-}
begin
 Result := f_State;
end;//TContext_SetContext_Params.Get_State

procedure TContext_SetContext_Params.ClearFields;
 {-}
begin
 f_State := nil;
 inherited;
end;//TContext_SetContext_Params.ClearFields
// start class Op_Context_SetContext

class function Op_Context_SetContext.Call(const aTarget: IvcmEntity;
  const aState: InscContextFilterState): Boolean;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TContext_SetContext_Params.Make(aState));
  aTarget.Operation(TdmStdRes.opcode_Context_SetContext, l_Params);
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
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TContext_SetContext_Params.Make(aState));
  aTarget.Operation(TdmStdRes.opcode_Context_SetContext, l_Params);
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
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity, aState);
end;//Op_Context_SetContext.Call

class function Op_Context_SetContext.Call(const aTarget: IvcmContainer;
  const aState: InscContextFilterState): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm, aState);
end;//Op_Context_SetContext.Call

type
 TContext_SyncContextParams_Params = class(Tl3CProtoObject, IContext_SyncContextParams_Params)
  {* Реализация IContext_SyncContextParams_Params }
 private
 // private fields
   f_AdditionalFilter : TnsFilterType;
 protected
 // realized methods
   function Get_AdditionalFilter: TnsFilterType;
 public
 // public methods
   constructor Create(aAdditionalFilter: TnsFilterType); reintroduce;
     {* Конструктор TContext_SyncContextParams_Params }
   class function Make(aAdditionalFilter: TnsFilterType): IContext_SyncContextParams_Params; reintroduce;
     {* Фабрика TContext_SyncContextParams_Params }
 end;//TContext_SyncContextParams_Params

// start class TContext_SyncContextParams_Params

constructor TContext_SyncContextParams_Params.Create(aAdditionalFilter: TnsFilterType);
 {-}
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
end;

function TContext_SyncContextParams_Params.Get_AdditionalFilter: TnsFilterType;
 {-}
begin
 Result := f_AdditionalFilter;
end;//TContext_SyncContextParams_Params.Get_AdditionalFilter
// start class Op_Context_SyncContextParams

class function Op_Context_SyncContextParams.Call(const aTarget: IvcmEntity;
  aAdditionalFilter: TnsFilterType): Boolean;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TContext_SyncContextParams_Params.Make(aAdditionalFilter));
  aTarget.Operation(TdmStdRes.opcode_Context_SyncContextParams, l_Params);
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
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TContext_SyncContextParams_Params.Make(aAdditionalFilter));
  aTarget.Operation(TdmStdRes.opcode_Context_SyncContextParams, l_Params);
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
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity, aAdditionalFilter);
end;//Op_Context_SyncContextParams.Call

class function Op_Context_SyncContextParams.Call(const aTarget: IvcmContainer;
  aAdditionalFilter: TnsFilterType): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm, aAdditionalFilter);
end;//Op_Context_SyncContextParams.Call

type
 TAttributeTree_SetParent_Params = class(Tl3CProtoObject, IAttributeTree_SetParent_Params)
  {* Реализация IAttributeTree_SetParent_Params }
 private
 // private fields
   f_Parent : Il3SimpleNode;
 protected
 // realized methods
   function Get_Parent: Il3SimpleNode;
 protected
 // overridden protected methods
   procedure ClearFields; override;
     {* Сигнатура метода ClearFields }
 public
 // public methods
   constructor Create(const aParent: Il3SimpleNode); reintroduce;
     {* Конструктор TAttributeTree_SetParent_Params }
   class function Make(const aParent: Il3SimpleNode): IAttributeTree_SetParent_Params; reintroduce;
     {* Фабрика TAttributeTree_SetParent_Params }
 end;//TAttributeTree_SetParent_Params

// start class TAttributeTree_SetParent_Params

constructor TAttributeTree_SetParent_Params.Create(const aParent: Il3SimpleNode);
 {-}
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
end;

function TAttributeTree_SetParent_Params.Get_Parent: Il3SimpleNode;
 {-}
begin
 Result := f_Parent;
end;//TAttributeTree_SetParent_Params.Get_Parent

procedure TAttributeTree_SetParent_Params.ClearFields;
 {-}
begin
 f_Parent := nil;
 inherited;
end;//TAttributeTree_SetParent_Params.ClearFields
// start class Op_AttributeTree_SetParent

class function Op_AttributeTree_SetParent.Call(const aTarget: IvcmEntity;
  const aParent: Il3SimpleNode): Boolean;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TAttributeTree_SetParent_Params.Make(aParent));
  aTarget.Operation(TdmStdRes.opcode_AttributeTree_SetParent, l_Params);
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
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TAttributeTree_SetParent_Params.Make(aParent));
  aTarget.Operation(TdmStdRes.opcode_AttributeTree_SetParent, l_Params);
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
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity, aParent);
end;//Op_AttributeTree_SetParent.Call

class function Op_AttributeTree_SetParent.Call(const aTarget: IvcmContainer;
  const aParent: Il3SimpleNode): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm, aParent);
end;//Op_AttributeTree_SetParent.Call

type
 TAttributeTree_ExtSetRoot_Params = class(Tl3CProtoObject, IAttributeTree_ExtSetRoot_Params)
  {* Реализация IAttributeTree_ExtSetRoot_Params }
 private
 // private fields
   f_Root : INodeBase;
 protected
 // realized methods
   function Get_Root: INodeBase;
 protected
 // overridden protected methods
   procedure ClearFields; override;
     {* Сигнатура метода ClearFields }
 public
 // public methods
   constructor Create(const aRoot: INodeBase); reintroduce;
     {* Конструктор TAttributeTree_ExtSetRoot_Params }
   class function Make(const aRoot: INodeBase): IAttributeTree_ExtSetRoot_Params; reintroduce;
     {* Фабрика TAttributeTree_ExtSetRoot_Params }
 end;//TAttributeTree_ExtSetRoot_Params

// start class TAttributeTree_ExtSetRoot_Params

constructor TAttributeTree_ExtSetRoot_Params.Create(const aRoot: INodeBase);
 {-}
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
end;

function TAttributeTree_ExtSetRoot_Params.Get_Root: INodeBase;
 {-}
begin
 Result := f_Root;
end;//TAttributeTree_ExtSetRoot_Params.Get_Root

procedure TAttributeTree_ExtSetRoot_Params.ClearFields;
 {-}
begin
 f_Root := nil;
 inherited;
end;//TAttributeTree_ExtSetRoot_Params.ClearFields
// start class Op_AttributeTree_ExtSetRoot

class function Op_AttributeTree_ExtSetRoot.Call(const aTarget: IvcmEntity;
  const aRoot: INodeBase): Boolean;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TAttributeTree_ExtSetRoot_Params.Make(aRoot));
  aTarget.Operation(TdmStdRes.opcode_AttributeTree_ExtSetRoot, l_Params);
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
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TAttributeTree_ExtSetRoot_Params.Make(aRoot));
  aTarget.Operation(TdmStdRes.opcode_AttributeTree_ExtSetRoot, l_Params);
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
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity, aRoot);
end;//Op_AttributeTree_ExtSetRoot.Call

class function Op_AttributeTree_ExtSetRoot.Call(const aTarget: IvcmContainer;
  const aRoot: INodeBase): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm, aRoot);
end;//Op_AttributeTree_ExtSetRoot.Call

type
 TAttributeTree_SetRoot_Params = class(Tl3CProtoObject, IAttributeTree_SetRoot_Params)
  {* Реализация IAttributeTree_SetRoot_Params }
 private
 // private fields
   f_Tag : Il3CString;
 protected
 // realized methods
   function Get_Tag: Il3CString;
 protected
 // overridden protected methods
   procedure ClearFields; override;
     {* Сигнатура метода ClearFields }
 public
 // public methods
   constructor Create(const aTag: Il3CString); reintroduce;
     {* Конструктор TAttributeTree_SetRoot_Params }
   class function Make(const aTag: Il3CString): IAttributeTree_SetRoot_Params; reintroduce;
     {* Фабрика TAttributeTree_SetRoot_Params }
 end;//TAttributeTree_SetRoot_Params

// start class TAttributeTree_SetRoot_Params

constructor TAttributeTree_SetRoot_Params.Create(const aTag: Il3CString);
 {-}
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
end;

function TAttributeTree_SetRoot_Params.Get_Tag: Il3CString;
 {-}
begin
 Result := f_Tag;
end;//TAttributeTree_SetRoot_Params.Get_Tag

procedure TAttributeTree_SetRoot_Params.ClearFields;
 {-}
begin
 f_Tag := nil;
 inherited;
end;//TAttributeTree_SetRoot_Params.ClearFields
// start class Op_AttributeTree_SetRoot

class function Op_AttributeTree_SetRoot.Call(const aTarget: IvcmEntity;
  const aTag: Il3CString): Boolean;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TAttributeTree_SetRoot_Params.Make(aTag));
  aTarget.Operation(TdmStdRes.opcode_AttributeTree_SetRoot, l_Params);
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
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TAttributeTree_SetRoot_Params.Make(aTag));
  aTarget.Operation(TdmStdRes.opcode_AttributeTree_SetRoot, l_Params);
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
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity, aTag);
end;//Op_AttributeTree_SetRoot.Call

class function Op_AttributeTree_SetRoot.Call(const aTarget: IvcmContainer;
  const aTag: Il3CString): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm, aTag);
end;//Op_AttributeTree_SetRoot.Call

type
 TAttributeTree_ChangeRoot_Params = class(Tl3CProtoObject, IAttributeTree_ChangeRoot_Params)
  {* Реализация IAttributeTree_ChangeRoot_Params }
 private
 // private fields
   f_Tag : Il3CString;
   f_Root : Il3SimpleNode;
   f_Current : Il3SimpleNode;
 protected
 // realized methods
   function Get_Root: Il3SimpleNode;
   function Get_Current: Il3SimpleNode;
   function Get_Tag: Il3CString;
 protected
 // overridden protected methods
   procedure ClearFields; override;
     {* Сигнатура метода ClearFields }
 public
 // public methods
   constructor Create(const aTag: Il3CString;
    const aRoot: Il3SimpleNode;
    const aCurrent: Il3SimpleNode); reintroduce;
     {* Конструктор TAttributeTree_ChangeRoot_Params }
   class function Make(const aTag: Il3CString;
    const aRoot: Il3SimpleNode;
    const aCurrent: Il3SimpleNode): IAttributeTree_ChangeRoot_Params; reintroduce;
     {* Фабрика TAttributeTree_ChangeRoot_Params }
 end;//TAttributeTree_ChangeRoot_Params

// start class TAttributeTree_ChangeRoot_Params

constructor TAttributeTree_ChangeRoot_Params.Create(const aTag: Il3CString;
  const aRoot: Il3SimpleNode;
  const aCurrent: Il3SimpleNode);
 {-}
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
end;

function TAttributeTree_ChangeRoot_Params.Get_Root: Il3SimpleNode;
 {-}
begin
 Result := f_Root;
end;//TAttributeTree_ChangeRoot_Params.Get_Root

function TAttributeTree_ChangeRoot_Params.Get_Current: Il3SimpleNode;
 {-}
begin
 Result := f_Current;
end;//TAttributeTree_ChangeRoot_Params.Get_Current

function TAttributeTree_ChangeRoot_Params.Get_Tag: Il3CString;
 {-}
begin
 Result := f_Tag;
end;//TAttributeTree_ChangeRoot_Params.Get_Tag

procedure TAttributeTree_ChangeRoot_Params.ClearFields;
 {-}
begin
 f_Tag := nil;
 f_Root := nil;
 f_Current := nil;
 inherited;
end;//TAttributeTree_ChangeRoot_Params.ClearFields
// start class Op_AttributeTree_ChangeRoot

class function Op_AttributeTree_ChangeRoot.Call(const aTarget: IvcmEntity;
  const aTag: Il3CString;
  const aRoot: Il3SimpleNode;
  const aCurrent: Il3SimpleNode): Boolean;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TAttributeTree_ChangeRoot_Params.Make(aTag,aRoot,aCurrent));
  aTarget.Operation(TdmStdRes.opcode_AttributeTree_ChangeRoot, l_Params);
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
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TAttributeTree_ChangeRoot_Params.Make(aTag,aRoot,aCurrent));
  aTarget.Operation(TdmStdRes.opcode_AttributeTree_ChangeRoot, l_Params);
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
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity, aTag, aRoot, aCurrent);
end;//Op_AttributeTree_ChangeRoot.Call

class function Op_AttributeTree_ChangeRoot.Call(const aTarget: IvcmContainer;
  const aTag: Il3CString;
  const aRoot: Il3SimpleNode;
  const aCurrent: Il3SimpleNode): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm, aTag, aRoot, aCurrent);
end;//Op_AttributeTree_ChangeRoot.Call

type
 TContextParams_ContextChanged_Params = class(Tl3CProtoObject, IContextParams_ContextChanged_Params)
  {* Реализация IContextParams_ContextChanged_Params }
 private
 // private fields
   f_ContextState : InscContextFilterState;
   f_ContextTarget : Il3ContextFilterTarget;
 protected
 // realized methods
   function Get_ContextState: InscContextFilterState;
   function Get_ContextTarget: Il3ContextFilterTarget;
 protected
 // overridden protected methods
   procedure ClearFields; override;
     {* Сигнатура метода ClearFields }
 public
 // public methods
   constructor Create(const aContextState: InscContextFilterState;
    const aContextTarget: Il3ContextFilterTarget); reintroduce;
     {* Конструктор TContextParams_ContextChanged_Params }
   class function Make(const aContextState: InscContextFilterState;
    const aContextTarget: Il3ContextFilterTarget): IContextParams_ContextChanged_Params; reintroduce;
     {* Фабрика TContextParams_ContextChanged_Params }
 end;//TContextParams_ContextChanged_Params

// start class TContextParams_ContextChanged_Params

constructor TContextParams_ContextChanged_Params.Create(const aContextState: InscContextFilterState;
  const aContextTarget: Il3ContextFilterTarget);
 {-}
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
end;

function TContextParams_ContextChanged_Params.Get_ContextState: InscContextFilterState;
 {-}
begin
 Result := f_ContextState;
end;//TContextParams_ContextChanged_Params.Get_ContextState

function TContextParams_ContextChanged_Params.Get_ContextTarget: Il3ContextFilterTarget;
 {-}
begin
 Result := f_ContextTarget;
end;//TContextParams_ContextChanged_Params.Get_ContextTarget

procedure TContextParams_ContextChanged_Params.ClearFields;
 {-}
begin
 f_ContextState := nil;
 f_ContextTarget := nil;
 inherited;
end;//TContextParams_ContextChanged_Params.ClearFields
// start class Op_ContextParams_ContextChanged

class function Op_ContextParams_ContextChanged.Call(const aTarget: IvcmEntity;
  const aContextState: InscContextFilterState;
  const aContextTarget: Il3ContextFilterTarget): Boolean;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TContextParams_ContextChanged_Params.Make(aContextState,aContextTarget));
  aTarget.Operation(TdmStdRes.opcode_ContextParams_ContextChanged, l_Params);
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
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TContextParams_ContextChanged_Params.Make(aContextState,aContextTarget));
  aTarget.Operation(TdmStdRes.opcode_ContextParams_ContextChanged, l_Params);
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
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity, aContextState, aContextTarget);
end;//Op_ContextParams_ContextChanged.Call

class function Op_ContextParams_ContextChanged.Call(const aTarget: IvcmContainer;
  const aContextState: InscContextFilterState;
  const aContextTarget: Il3ContextFilterTarget): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm, aContextState, aContextTarget);
end;//Op_ContextParams_ContextChanged.Call

type
 TSelectedList_RefreshValues_Params = class(Tl3CProtoObject, ISelectedList_RefreshValues_Params)
  {* Реализация ISelectedList_RefreshValues_Params }
 private
 // private fields
   f_Data : InsSelectedAttributesIterators;
 protected
 // realized methods
   function Get_Data: InsSelectedAttributesIterators;
 protected
 // overridden protected methods
   procedure ClearFields; override;
     {* Сигнатура метода ClearFields }
 public
 // public methods
   constructor Create(const aData: InsSelectedAttributesIterators); reintroduce;
     {* Конструктор TSelectedList_RefreshValues_Params }
   class function Make(const aData: InsSelectedAttributesIterators): ISelectedList_RefreshValues_Params; reintroduce;
     {* Фабрика TSelectedList_RefreshValues_Params }
 end;//TSelectedList_RefreshValues_Params

// start class TSelectedList_RefreshValues_Params

constructor TSelectedList_RefreshValues_Params.Create(const aData: InsSelectedAttributesIterators);
 {-}
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
end;

function TSelectedList_RefreshValues_Params.Get_Data: InsSelectedAttributesIterators;
 {-}
begin
 Result := f_Data;
end;//TSelectedList_RefreshValues_Params.Get_Data

procedure TSelectedList_RefreshValues_Params.ClearFields;
 {-}
begin
 f_Data := nil;
 inherited;
end;//TSelectedList_RefreshValues_Params.ClearFields
// start class Op_SelectedList_RefreshValues

class function Op_SelectedList_RefreshValues.Call(const aTarget: IvcmEntity;
  const aData: InsSelectedAttributesIterators): Boolean;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TSelectedList_RefreshValues_Params.Make(aData));
  aTarget.Operation(TdmStdRes.opcode_SelectedList_RefreshValues, l_Params);
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
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TSelectedList_RefreshValues_Params.Make(aData));
  aTarget.Operation(TdmStdRes.opcode_SelectedList_RefreshValues, l_Params);
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
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity, aData);
end;//Op_SelectedList_RefreshValues.Call

class function Op_SelectedList_RefreshValues.Call(const aTarget: IvcmContainer;
  const aData: InsSelectedAttributesIterators): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm, aData);
end;//Op_SelectedList_RefreshValues.Call

end.