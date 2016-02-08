unit PrimTreeAttributeSelect_Form;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\LiteSearch\Forms\PrimTreeAttributeSelect_Form.pas"
// Стереотип: "VCMForm"

{$Include nsDefine.inc}

interface

uses
 l3IntfUses
 , TreeAttribute_Form
 , bsInterfaces
 , SearchLite_Strange_Controls
 , SearchInterfaces
 , SearchDomainInterfaces
 , L10nInterfaces
 , vtPanel
 {$If Defined(Nemesis)}
 , nscContextFilter
 {$IfEnd} // Defined(Nemesis)
 {$If Defined(Nemesis)}
 , nscTreeViewHotTruck
 {$IfEnd} // Defined(Nemesis)
 , l3TreeInterfaces
 , nsTypes
 , Classes
 , l3Interfaces
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , ImgList
 {$IfEnd} // NOT Defined(NoVCL)
 , SearchUnit
 , DynamicTreeUnit
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmControllers
 {$IfEnd} // NOT Defined(NoVCM)
 , l3StringIDEx
 , PrimTreeAttributeSelect_astOneLevel_UserType
;

type
 TPrimTreeAttributeSelectForm = {abstract} class(TTreeAttributeForm, InsTreeDataListener)
  private
   f_CaptionMap: InsStringValueMap;
   f_Painted: Boolean;
   f_LockCurrentChange: Integer;
   f_BackgroundPanel: TvtPanel;
    {* Поле для свойства BackgroundPanel }
   f_ContextFilter: TnscContextFilter;
    {* Поле для свойства ContextFilter }
   f_AttributeTree: TnscTreeViewHotTruck;
    {* Поле для свойства AttributeTree }
  protected
   dsTreeAttributeSelect: IdsTreeAttributeSelect;
   f_NeedRefilterTree: Boolean;
   f_OrState: Boolean;
   f_AndState: Boolean;
   f_NotState: Boolean;
  private
   procedure ContextFilterChange(Sender: TObject);
   procedure ContextFilterWrongContext(Sender: TObject);
   function AttributeTreeIsCommandProcessed(aSender: TObject;
    aOperation: Tl3OperationCode): Boolean;
   procedure AttributeTreeAfterFirstPaint(Sender: TObject);
   procedure AttributeTreeLMouseDown(Sender: TObject;
    Button: TMouseButton;
    Shift: TShiftState;
    X: Integer;
    Y: Integer);
   function AttributeTreeGetItemImage(Sender: TObject;
    Index: Integer;
    var aImages: TCustomImageList): Integer;
   procedure AttributeTreeActionElement(Sender: TObject;
    Index: LongInt);
   procedure AttributeTreeCurrentChanged(aSender: TObject;
    aNewCurrent: Integer;
    aOldCurrent: Integer);
   procedure AttributeTreeTreeChanged(aSender: TObject;
    const anOldTree: Il3SimpleTree;
    const aNewTree: Il3SimpleTree);
   procedure AttributeTreeNewCharPressed(aChar: AnsiChar);
   procedure SendContextChangeMessage;
   procedure SetupNewTreeStruct(const aTree: Il3SimpleTree);
   procedure SetCurrentNode(const aNode: Il3SimpleNode;
    aExpand: Boolean = False);
   procedure DropAllLogicSelection(aDropSelection: Boolean = False); overload;
   procedure NotifyMultipleChanges;
   function SaveToQuery(const aQuery: IQuery): Boolean; overload;
   procedure ActivateElement(anIndex: Integer;
    LogicOperationOnly: Boolean = False);
   procedure LoadFromQuery(const aQuery: IQuery);
   procedure DoContextFilterChange(aSender: TObject);
   procedure SetRootForFullForm(const aTag: Il3CString);
   procedure SetRootForFirstLevelForm(const aTag: Il3CString);
   function GetRootInfo: InsRootInfo;
   procedure CurrentChangedPrim(aNewIndex: Integer;
    aOldIndex: Integer;
    aForceUpdateParent: Boolean = False);
   procedure SetLogicOperationOnNode(const aNode: INodeBase);
   function GetFirstLevelParent(const aNode: Il3SimpleNode): Il3SimpleNode; overload;
   function GetFirstLevelParent(const aNode: INodeBase): INodeBase; overload;
   function GetFirstLevelParent(aIndex: Integer): Il3SimpleNode; overload;
   function CountItemImage(const aNode: INodeBase): Integer;
   procedure vcmEntityFormSaveState(out aState: IvcmBase;
    aStateType: TvcmStateType;
    var Saved: Boolean);
  protected
   function pm_GetDS: IdsTreeAttributeSelect;
   function pm_GetTaggedTreeInfo: InsTaggedTreeInfo;
   function pm_GetRootInfo: InsRootInfo;
   procedure SetFilter(aFilterType: TnsFilterType);
    {* Накладывает фильтр на дерево }
   function IsOldSchoolNone: Boolean;
    {* Аналог проверки TefTreeAttributeSelectUT(UserType) <> astNone, только с учётом astTaxesPublishSearch }
   function EntitiesenAttributeGetTarget(aControl: TComponent;
    aX: Integer;
    aY: Integer;
    out theTarget: IUnknown): Boolean;
   procedure InvalidateOtherTree;
   procedure NotifyOperationChange(const aNode: INodeBase;
    aOldOp: TLogicOperation;
    aNewOp: TLogicOperation);
   procedure FormLogicOperation(const aNode: INodeBase;
    aOp: TLogicOperation;
    aWithNotify: Boolean = True);
   procedure DropSelectedOperation;
   procedure ChangeOperationOnSelected(aNewOp: TLogicOperation);
   procedure LogicOperationTest(const aParams: IvcmTestParamsPrim;
    aOp: TLogicOperation);
   {$If Defined(disabled_function)}
   procedure LOToolbarTest(const aParams: IvcmTestParamsPrim;
    aLO: TLogicOperation);
    {* метод установки параметров в _OnTest для операций публикуемых в toolbar-е. Отличие в том, что они не показываются для ситуаций первого второго уровня.

Отключено при переносе на модель.
Решили, что нет нужды делать разную логику для тулбаров и контекстного меню. }
   {$IfEnd} // Defined(disabled_function)
   procedure Updated;
    {* данные дерева были обновлены. Реакция на обновление данных
            приложения }
   procedure CurrentChangedNotification(const aNode: Il3SimpleNode); override;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure InitFields; override;
   {$If NOT Defined(NoVCM)}
   procedure NotifyDataSourceChanged(const anOld: IvcmViewAreaController;
    const aNew: IvcmViewAreaController); override;
    {* Изменился источник данных. Для перекрытия в потомках }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   function DoLoadState(const aState: IvcmBase;
    aStateType: TvcmStateType): Boolean; override;
    {* Загружает состояние формы. Для перекрытия в потомках }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure InitControls; override;
    {* Процедура инициализации контролов. Для перекрытия в потомках }
   {$IfEnd} // NOT Defined(NoVCM)
  public
   procedure ExternalCharPressed; override;
   procedure SetCurrent; override;
   procedure DropAllLogicSelection; override;
   function IsQueryEmpty: Boolean; override;
   procedure SaveToQuery; override;
   procedure Invalidate; override;
   procedure DefaultAction; override;
   procedure SetQuery; override;
   procedure DropLogicSelection; override;
   procedure LoadQuery; override;
   procedure SetOneLevelCurrent; override;
   procedure SetContext; override;
   procedure SetRoot; override;
   procedure ChangeRoot; override;
   procedure SyncContextParams; override;
   procedure AddNodeIfEmpty; override;
   procedure ClearQuery; override;
   procedure FindFirstSelected; override;
   {$If NOT Defined(NoVCM)}
   procedure NotifyUserTypeSet; override;
   {$IfEnd} // NOT Defined(NoVCM)
  private
   property DS: IdsTreeAttributeSelect
    read pm_GetDS;
   property TaggedTreeInfo: InsTaggedTreeInfo
    read pm_GetTaggedTreeInfo;
   property RootInfo: InsRootInfo
    read pm_GetRootInfo;
  public
   property BackgroundPanel: TvtPanel
    read f_BackgroundPanel;
 end;//TPrimTreeAttributeSelectForm

implementation

uses
 l3ImplUses
 , l3String
 , SysUtils
 , nsLogicOperationToFlags
 , l3Tree
 , nsAttrBranchStruct
 , l3Base
 , nsUtils
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , OvcConst
 , evdTextStyle_Const
 , nsSelectedAttributesIterators
 , nsTreeAttributeNodesNew
 , nsAttributeTreeStruct
 , nsValueMaps
 , nsValueMapsIDs
 , nsFirstLevelStruct
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 , SearchRes
 , dsTreeAttributeSelect
 , deSearch
 {$If NOT Defined(Admin)}
 , nsQuery
 {$IfEnd} // NOT Defined(Admin)
 , DataAdapter
 {$If NOT Defined(Admin)}
 , nsQueryInterfaces
 {$IfEnd} // NOT Defined(Admin)
 , SearchLite_FormDefinitions_Controls
 , tasSaveLoadProxy
 , l3MessageID
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoVCM)}
 , StdRes
 {$IfEnd} // NOT Defined(NoVCM)
 {$If Defined(Nemesis)}
 , nscContextFilterState
 {$IfEnd} // Defined(Nemesis)
;

type
 // ExcludeExternalCharPressedForOneLevel

 // ExludeFindFirstSelectedForOneLevel

const
 {* Локализуемые строки astNoneLocalConstants }
 str_astNoneCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'astNoneCaption'; rValue : 'Поиск: Выбор реквизита');
  {* Заголовок пользовательского типа "Поиск: Выбор реквизита" }
 {* Локализуемые строки astOneLevelLocalConstants }
 str_astOneLevelCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'astOneLevelCaption'; rValue : 'Ситуации второго уровня');
  {* Заголовок пользовательского типа "Ситуации второго уровня" }
 {* Локализуемые строки astFirstLevelLocalConstants }
 str_astFirstLevelCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'astFirstLevelCaption'; rValue : 'Ситуации первого уровня');
  {* Заголовок пользовательского типа "Ситуации первого уровня" }
 {* Локализуемые строки astTaxesPublishSearchLocalConstants }
 str_astTaxesPublishSearchCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'astTaxesPublishSearchCaption'; rValue : 'СМИ по налогам и бухучету');
  {* Заголовок пользовательского типа "СМИ по налогам и бухучету" }
 {* Локализуемые строки astPharmPublishSearchLocalConstants }
 str_astPharmPublishSearchCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'astPharmPublishSearchCaption'; rValue : 'СМИ по медицине и здравоохранению');
  {* Заголовок пользовательского типа "СМИ по медицине и здравоохранению" }

function TPrimTreeAttributeSelectForm.pm_GetDS: IdsTreeAttributeSelect;
//#UC START# *52774DA600FD_497ECC0E0325get_var*
//#UC END# *52774DA600FD_497ECC0E0325get_var*
begin
//#UC START# *52774DA600FD_497ECC0E0325get_impl*
 // это временная мера пока ППС 5.х не переведена на сборку. Сделано потому, что
 // форма уже опирается на IdsTreeAttributeSelect, но есть случаи использования
 // формы вне сборки
{$If not defined(ADMIN)}
 if not Assigned(DataSource) and Assigned(TaggedTreeInfo) and not (csDestroying in Componentstate) then
  DataSource := TdsTreeAttributeSelect.Make(nil, TdeSearch.Make(TaggedTreeInfo.Tag, nil));
{$IfEnd}
 // Возвращаем честный _DataSource
 Result := dsTreeAttributeSelect;
//#UC END# *52774DA600FD_497ECC0E0325get_impl*
end;//TPrimTreeAttributeSelectForm.pm_GetDS

function TPrimTreeAttributeSelectForm.pm_GetTaggedTreeInfo: InsTaggedTreeInfo;
//#UC START# *52774DDF02AF_497ECC0E0325get_var*
//#UC END# *52774DDF02AF_497ECC0E0325get_var*
begin
//#UC START# *52774DDF02AF_497ECC0E0325get_impl*
 Supports(AttributeTree.TreeStruct, InsTaggedTreeInfo, Result);
//#UC END# *52774DDF02AF_497ECC0E0325get_impl*
end;//TPrimTreeAttributeSelectForm.pm_GetTaggedTreeInfo

function TPrimTreeAttributeSelectForm.pm_GetRootInfo: InsRootInfo;
//#UC START# *52774E0A018E_497ECC0E0325get_var*
//#UC END# *52774E0A018E_497ECC0E0325get_var*
begin
//#UC START# *52774E0A018E_497ECC0E0325get_impl*
 Result := nil;
 Supports(AttributeTree.TreeStruct, InsRootInfo, Result);
//#UC END# *52774E0A018E_497ECC0E0325get_impl*
end;//TPrimTreeAttributeSelectForm.pm_GetRootInfo

procedure TPrimTreeAttributeSelectForm.SetFilter(aFilterType: TnsFilterType);
 {* Накладывает фильтр на дерево }
var l_Filters: InsAttributeTreeFilters;
var l_Tree: Il3FilterableTree;
var l_Index: Integer;
//#UC START# *4ACDE6BF0255_497ECC0E0325_var*
//#UC END# *4ACDE6BF0255_497ECC0E0325_var*
begin
//#UC START# *4ACDE6BF0255_497ECC0E0325_impl*
 if Supports(AttributeTree.TreeStruct, Il3FilterableTree, l_Tree) and
    Supports(l_Tree.CloneFilters, InsAttributeTreeFilters, l_Filters) and
    ((l_Filters.FilterType <> aFilterType) or
     not l3IsNil(l_Filters.Context)) then
 begin
  SetupNewTreeStruct(l_Tree.MakeFiltered(l_Filters.SetFilterType(aFilterType).
                                                   SetContext(nil),
                                         nil,
                                         l_Index,
                                         IsOldSchoolNone,
                                         true));
  ContextFilter.AssignState(TnscContextFilterState.Make(False, nil, 0));
  SendContextChangeMessage;
 end;//Supports(AttributeTree.TreeStruct, Il3FilterableTree, l_Tree)
//#UC END# *4ACDE6BF0255_497ECC0E0325_impl*
end;//TPrimTreeAttributeSelectForm.SetFilter

function TPrimTreeAttributeSelectForm.IsOldSchoolNone: Boolean;
 {* Аналог проверки TefTreeAttributeSelectUT(UserType) <> astNone, только с учётом astTaxesPublishSearch }
//#UC START# *4ACDF3B90238_497ECC0E0325_var*
//#UC END# *4ACDF3B90238_497ECC0E0325_var*
begin
//#UC START# *4ACDF3B90238_497ECC0E0325_impl*
 Result := (UserType in [astNone, astTaxesPublishSearch, astPharmPublishSearch]);
//#UC END# *4ACDF3B90238_497ECC0E0325_impl*
end;//TPrimTreeAttributeSelectForm.IsOldSchoolNone

function TPrimTreeAttributeSelectForm.EntitiesenAttributeGetTarget(aControl: TComponent;
 aX: Integer;
 aY: Integer;
 out theTarget: IUnknown): Boolean;
//#UC START# *4F88602F0276_497ECC0E0325_var*
//#UC END# *4F88602F0276_497ECC0E0325_var*
begin
//#UC START# *4F88602F0276_497ECC0E0325_impl*
 // Это нужно для того, чтобы в логических операциях вызывались OnContextTest
 Result := True;
 // Отдавать нужно обязательно так, поэтому что IInterface может умереть не
 // зависимо от IvcmEntityForm
 theTarget := (Self.as_IvcmEntityForm);
//#UC END# *4F88602F0276_497ECC0E0325_impl*
end;//TPrimTreeAttributeSelectForm.EntitiesenAttributeGetTarget

procedure TPrimTreeAttributeSelectForm.ContextFilterChange(Sender: TObject);
//#UC START# *52774A9A001E_497ECC0E0325_var*
var
 l_Index: Integer;
 l_Tree: Il3FilterableTree;
 l_TreeSource: Il3SimpleTree;
//#UC END# *52774A9A001E_497ECC0E0325_var*
begin
//#UC START# *52774A9A001E_497ECC0E0325_impl*
 if (UserType <> astOneLevel) then
 begin
  if Supports(AttributeTree.TreeStruct, Il3FilterableTree, l_Tree) then
  try
   // получаем _CreateView от рута дерева, а не от рута предыдущего view
   //при пустом Context, l_Index возвращает -2
   l_TreeSource := l_Tree.MakeFiltered(l_Tree.CloneFilters.SetCOntext(ContextFilter.ActiveContext),
                                      nil,
                                      l_Index,
                                      IsOldSchoolNone,
                                      ContextFilter.NeedRefilterTree or f_NeedRefilterTree);
   if l_TreeSource.CountView > 0 then
    SetupNewTreeStruct(l_TreeSource);
  finally
   l_Tree := nil;
  end;{try..finally}
  // Сообщим об изменении контекста
  ContextFilter.UpdateIsContextWrong;
  SendContextChangeMessage;
 end;
//#UC END# *52774A9A001E_497ECC0E0325_impl*
end;//TPrimTreeAttributeSelectForm.ContextFilterChange

procedure TPrimTreeAttributeSelectForm.ContextFilterWrongContext(Sender: TObject);
//#UC START# *52774AA6031C_497ECC0E0325_var*
//#UC END# *52774AA6031C_497ECC0E0325_var*
begin
//#UC START# *52774AA6031C_497ECC0E0325_impl*
 nsBeepWrongContext;
//#UC END# *52774AA6031C_497ECC0E0325_impl*
end;//TPrimTreeAttributeSelectForm.ContextFilterWrongContext

function TPrimTreeAttributeSelectForm.AttributeTreeIsCommandProcessed(aSender: TObject;
 aOperation: Tl3OperationCode): Boolean;
//#UC START# *52774AB301C7_497ECC0E0325_var*
//#UC END# *52774AB301C7_497ECC0E0325_var*
begin
//#UC START# *52774AB301C7_497ECC0E0325_impl*
 Result := True;
 case aOperation of
  ccActionItem: Result := False;
 end;
//#UC END# *52774AB301C7_497ECC0E0325_impl*
end;//TPrimTreeAttributeSelectForm.AttributeTreeIsCommandProcessed

procedure TPrimTreeAttributeSelectForm.AttributeTreeAfterFirstPaint(Sender: TObject);
//#UC START# *52774ABF000B_497ECC0E0325_var*
//#UC END# *52774ABF000B_497ECC0E0325_var*
begin
//#UC START# *52774ABF000B_497ECC0E0325_impl*
 // А это грязный хак для борьбы с переключением баз/поднятием из истории и открбчением
 // контекстного фильтра в контейнере для ППС 5х (cfOldSituationSearch)
 if (UserType <> astOneLevel) and not f_Painted then
  SendContextChangeMessage;
 f_Painted := True;
//#UC END# *52774ABF000B_497ECC0E0325_impl*
end;//TPrimTreeAttributeSelectForm.AttributeTreeAfterFirstPaint

procedure TPrimTreeAttributeSelectForm.AttributeTreeLMouseDown(Sender: TObject;
 Button: TMouseButton;
 Shift: TShiftState;
 X: Integer;
 Y: Integer);
//#UC START# *52774ACB00D3_497ECC0E0325_var*
var
 l_Index: Integer;
 l_ItemPart: Byte;
 l_l3Node: Il3SimpleNode;
//#UC END# *52774ACB00D3_497ECC0E0325_var*
begin
//#UC START# *52774ACB00D3_497ECC0E0325_impl*
 AttributeTree.HitTest(Point(X, Y), l_Index, l_ItemPart);
 if  (l_ItemPart = ihtIcon) then
 begin
  l_l3Node := AttributeTree.GetNode(l_Index);
  try
   AttributeTree.Current := l_Index;
   ActivateElement(l_Index, True);
  finally
   l_l3Node := nil;
  end;
 end;
//#UC END# *52774ACB00D3_497ECC0E0325_impl*
end;//TPrimTreeAttributeSelectForm.AttributeTreeLMouseDown

function TPrimTreeAttributeSelectForm.AttributeTreeGetItemImage(Sender: TObject;
 Index: Integer;
 var aImages: TCustomImageList): Integer;
//#UC START# *52774AD4024A_497ECC0E0325_var*
var
 l_Node: Il3SimpleNode;
 l_AdapterNode: INodeBase;
//#UC END# *52774AD4024A_497ECC0E0325_var*
begin
//#UC START# *52774AD4024A_497ECC0E0325_impl*
 Result := -1;
 if Index >= 0 then
 begin
  l_Node := AttributeTree.TreeStruct.Nodes[Index];
  try
   if Supports(l_Node, INodeBase, l_AdapterNode) then
   try
    Result := CountItemImage(l_AdapterNode);
   finally
    l_AdapterNode := nil;
   end;
  finally
   l_Node := nil;
  end;
 end;
//#UC END# *52774AD4024A_497ECC0E0325_impl*
end;//TPrimTreeAttributeSelectForm.AttributeTreeGetItemImage

procedure TPrimTreeAttributeSelectForm.AttributeTreeActionElement(Sender: TObject;
 Index: LongInt);
//#UC START# *52774AF002C7_497ECC0E0325_var*
//#UC END# *52774AF002C7_497ECC0E0325_var*
begin
//#UC START# *52774AF002C7_497ECC0E0325_impl*
 ActivateElement(Index, False);
//#UC END# *52774AF002C7_497ECC0E0325_impl*
end;//TPrimTreeAttributeSelectForm.AttributeTreeActionElement

procedure TPrimTreeAttributeSelectForm.AttributeTreeCurrentChanged(aSender: TObject;
 aNewCurrent: Integer;
 aOldCurrent: Integer);
//#UC START# *52774AF800AF_497ECC0E0325_var*
//#UC END# *52774AF800AF_497ECC0E0325_var*
begin
//#UC START# *52774AF800AF_497ECC0E0325_impl*
 if f_LockCurrentChange > 0 then
  Exit;
 if aNewCurrent <> -1 then
  CurrentChangedPrim(aNewCurrent, aOldCurrent, False);
//#UC END# *52774AF800AF_497ECC0E0325_impl*
end;//TPrimTreeAttributeSelectForm.AttributeTreeCurrentChanged

procedure TPrimTreeAttributeSelectForm.AttributeTreeTreeChanged(aSender: TObject;
 const anOldTree: Il3SimpleTree;
 const aNewTree: Il3SimpleTree);
//#UC START# *52774B01032D_497ECC0E0325_var*
//#UC END# *52774B01032D_497ECC0E0325_var*
begin
//#UC START# *52774B01032D_497ECC0E0325_impl*
 if (anOldTree <> nil) then
  anOldTree.Unsubscribe(InsTreeDataListener(Self));
 if Assigned(DS) then
  DS.SimpleTree := aNewTree;
 if (aNewTree <> nil) then
  aNewTree.Subscribe(InsTreeDataListener(Self));
//#UC END# *52774B01032D_497ECC0E0325_impl*
end;//TPrimTreeAttributeSelectForm.AttributeTreeTreeChanged

procedure TPrimTreeAttributeSelectForm.AttributeTreeNewCharPressed(aChar: AnsiChar);
//#UC START# *52774B080270_497ECC0E0325_var*
//#UC END# *52774B080270_497ECC0E0325_var*
begin
//#UC START# *52774B080270_497ECC0E0325_impl*
 if UserType <> astOneLevel then
  ContextFilter.PressChar(aChar)
 else
  op_AttributeTree_ExternalCharPressed.Call(Aggregate, nsCStr(aChar));
//#UC END# *52774B080270_497ECC0E0325_impl*
end;//TPrimTreeAttributeSelectForm.AttributeTreeNewCharPressed

procedure TPrimTreeAttributeSelectForm.SendContextChangeMessage;
//#UC START# *52775595015F_497ECC0E0325_var*
//#UC END# *52775595015F_497ECC0E0325_var*
begin
//#UC START# *52775595015F_497ECC0E0325_impl*
 {$If not Defined(Admin) AND not Defined(Monitorings) }
 op_ContextParams_ContextChanged.Call(Aggregate, ContextFilter.MakeState, ContextFilter.ContextFilterTarget);
 {$IfEnd}  
//#UC END# *52775595015F_497ECC0E0325_impl*
end;//TPrimTreeAttributeSelectForm.SendContextChangeMessage

procedure TPrimTreeAttributeSelectForm.SetupNewTreeStruct(const aTree: Il3SimpleTree);
//#UC START# *527756DF00E1_497ECC0E0325_var*
var
 l_Root: INodeBase;
 l_NewParent: Il3SimpleNode;
//#UC END# *527756DF00E1_497ECC0E0325_var*
begin
//#UC START# *527756DF00E1_497ECC0E0325_impl*
 //заплатка
 if Supports(aTree.RootNode, INodeBase, l_Root) then
  DropExtraSelection(l_Root, nil);
 Inc(f_LockCurrentChange);
 try
  AttributeTree.Changing;
  try
   AttributeTree.LockChangeSelected;
   try
    AttributeTree.TreeStruct := aTree;
    if (Aggregate <> nil) and
       IsOldSchoolNone then
     op_AttributeTree_ExtSetRoot.Call(Aggregate, AttributeTree.TreeStruct.RootNode As INodeBase);
   finally
    AttributeTree.UnLockChangeSelected;
   end;{try..finally}
  finally
   AttributeTree.Changed;
  end;{try..finally}
 finally
  Dec(f_LockCurrentChange);
 end;{try..finally}
 if (UserType = astFirstLevel) then
 begin
  if AttributeTree.Current >= 0 then
   l_NewParent := AttributeTree.GetCurrentNode
  else
   l_NewParent := nil;
  try
   op_AttributeTree_ChangeRoot.Call(Aggregate,
                                    TaggedTreeInfo.Tag,
                                    AttributeTree.TreeStruct.RootNode,
                                    l_NewParent);
  finally
   l_NewParent := nil;
  end;{try..finally}
 end;//if (UserType = astFirstLevel) then
//#UC END# *527756DF00E1_497ECC0E0325_impl*
end;//TPrimTreeAttributeSelectForm.SetupNewTreeStruct

procedure TPrimTreeAttributeSelectForm.SetCurrentNode(const aNode: Il3SimpleNode;
 aExpand: Boolean = False);
//#UC START# *52775711033A_497ECC0E0325_var*
var
 l_Node        : Il3SimpleNode;
 l_ParentNode  : INodeBase;
 l_AdapterNode : INodeBase;
 l_CurNode     : Il3SimpleNode;
 l_OldIndex    : Integer;
 l_OldParent   : Il3SimpleNode;

 procedure lpFirstLevelParentCollapse(const aNode: Il3SimpleNode);
 var
  l_NodeBase: INodeBase; 
 begin
  if Supports(aNode, INodeBase, l_NodeBase) then
  try
   l_NodeBase.SetFlag(FM_OPEN, False);
  finally
   l_NodeBase := nil;
  end;{try..finally}
 end;//lpFirstLevelParentCollapse
//#UC END# *52775711033A_497ECC0E0325_var*
begin
//#UC START# *52775711033A_497ECC0E0325_impl*
 l_Node := aNode;
 if UserType = astFirstLevel then
 begin
  if Supports(l_Node, INodeBase, l_AdapterNode) then
  begin
   l_Node := nil;
   l_ParentNode := GetFirstLevelParent(l_AdapterNode);
   if l_ParentNode <> nil then
    l_Node := TnsSelectedNode.Make(l_ParentNode);
  end;
 end;

 if (l_Node <> nil) then
 begin
  if (AttributeTree.GetCurrentNode <> nil) and
     AttributeTree.GetCurrentNode.IsSame(l_Node) then
  begin
   AttributeTree.vlbMakeItemVisible(AttributeTree.Current);
   CurrentChangedPrim(AttributeTree.Current, AttributeTree.Current, True)
  end
  else
  begin
   l_OldIndex := AttributeTree.Current;
   l_OldParent := GetFirstLevelParent(l_OldIndex);
   if AttributeTree.GotoOnNode(l_Node) < 0 then
    Exit;
   if (l_OldParent <> nil) and
      l_OldParent.IsSame(GetFirstLevelParent(AttributeTree.Current)) then
    CurrentChangedPrim(AttributeTree.Current, l_OldIndex, True);
  end;

 // второе условие - проверка, а нормальная ли нода к нам пришла (не И, ИЛИ, ..)
  if aExpand and IsOldSchoolNone then
  begin
   l_CurNode := AttributeTree.GetCurrentNode;
   AttributeTree.ExpandNode(l_CurNode, True);
   AttributeTree.TopIndex := AttributeTree.TreeStruct.GetIndex(l_CurNode);
  end;//if aExpand and
  if (UserType = astFirstLevel) and
     (Aggregate <> nil) then
  begin
   op_AttributeTree_SetOneLevelCurrent.Call(Aggregate, aNode);
   // После позиционирования в one level дереве, родитель развернется после
   // вызова Parent.GetVisibleDelta, что не допустимо для нашего рукотворного
   // одноуровненго дереве, в котором все родители должны быть свернуты, иначе
   // GetVisibleDelta будет возвращаеть результаты с учетом детей развернутых
   // родителей и позиционирование будет не правильным
   lpFirstLevelParentCollapse(l_Node);
  end;//if (UserType = astFirstLevel)
 end;//if (l_Node <> nil) then
//#UC END# *52775711033A_497ECC0E0325_impl*
end;//TPrimTreeAttributeSelectForm.SetCurrentNode

procedure TPrimTreeAttributeSelectForm.DropAllLogicSelection(aDropSelection: Boolean = False);
//#UC START# *52775732027C_497ECC0E0325_var*
var
 l_Root, l_AdapterNode: INodeBase;
 l_CurNode: Il3SimpleNode;
//#UC END# *52775732027C_497ECC0E0325_var*
begin
//#UC START# *52775732027C_497ECC0E0325_impl*
 if Supports(AttributeTree.TreeStruct.RootNode, INodeBase, l_Root) then
 begin
  DropAllOperations(l_Root);
  if aDropSelection then
  begin
   l_CurNode := AttributeTree.GetCurrentNode;
   if not Supports(l_CurNode, INodeBase, l_AdapterNode) then
    l_AdapterNode := nil;
   DropExtraSelection(l_Root, l_AdapterNode);
  end;
  AttributeTree.Invalidate;
  InvalidateOtherTree;
 end;
//#UC END# *52775732027C_497ECC0E0325_impl*
end;//TPrimTreeAttributeSelectForm.DropAllLogicSelection

procedure TPrimTreeAttributeSelectForm.NotifyMultipleChanges;
//#UC START# *52775768034C_497ECC0E0325_var*
var
 l_Params: IvcmExecuteParams;
 l_Root: INodeBase;
//#UC END# *52775768034C_497ECC0E0325_var*
begin
//#UC START# *52775768034C_497ECC0E0325_impl*
 // Для формы входящую в сборку
 if Assigned(DS) and Assigned(DS.UseCaseController) then
  DS.UpdateSelectedAttributes
 // Для форм не входящих в сборку
 else
 begin
  if (UserType = astOneLevel) and (RootInfo <> nil) then
   l_Root := RootInfo.Root
  else
   Supports(AttributeTree.TreeStruct.RootNode, INodeBase, l_Root);

  if (l_Root <> nil) then
   op_SelectedList_RefreshValues.Call(Aggregate,
                                      TnsSelectedAttributesIterators.Make(
                                       GetOperationIterator(l_Root, loOr),
                                       GetOperationIterator(l_Root, loAnd),
                                       GetOperationIterator(l_Root, loNot)));
 end;
//#UC END# *52775768034C_497ECC0E0325_impl*
end;//TPrimTreeAttributeSelectForm.NotifyMultipleChanges

function TPrimTreeAttributeSelectForm.SaveToQuery(const aQuery: IQuery): Boolean;
//#UC START# *52775777039C_497ECC0E0325_var*
var
 l_TaggedTreeInfo: InsTaggedTreeInfo;
//#UC END# *52775777039C_497ECC0E0325_var*
begin
//#UC START# *52775777039C_497ECC0E0325_impl*
{$If not defined(Admin)}
 Result := False;
 l_TaggedTreeInfo := TaggedTreeInfo;
 if Assigned(l_TaggedTreeInfo) then
 try
  Result := //SaveLogicToQuery(aQuery, l_TaggedTreeInfo.Tag, AttributeTree.TreeStruct);
            TtasSaveLoadProxy.Instance.SaveToQuery(aQuery, l_TaggedTreeInfo.Tag, AttributeTree.TreeStruct);
 finally
  l_TaggedTreeInfo := nil;
 end;
{$else}
 Assert(False);
{$IfEnd} //not Admin
//#UC END# *52775777039C_497ECC0E0325_impl*
end;//TPrimTreeAttributeSelectForm.SaveToQuery

procedure TPrimTreeAttributeSelectForm.ActivateElement(anIndex: Integer;
 LogicOperationOnly: Boolean = False);
//#UC START# *5277579C0100_497ECC0E0325_var*
var
 l_l3Node: Il3SimpleNode;
 l_Node: INodeBase;
//#UC END# *5277579C0100_497ECC0E0325_var*
begin
//#UC START# *5277579C0100_497ECC0E0325_impl*
 if anIndex >= 0
  then l_l3Node := AttributeTree.GetNode(anIndex)
  else l_l3Node := AttributeTree.GetCurrentNode;

 if Supports(l_l3Node, INodeBase, l_Node) then
  if LogicOperationOnly or
     not l_Node.HasChildren then
  begin
   SetLogicOperationOnNode(l_Node);
   AttributeTree.Invalidate;
   InvalidateOtherTree;
  end else
   AttributeTree.ExpandNode(l_l3Node, not AttributeTree.TreeStruct.IsExpanded(l_l3Node));
//#UC END# *5277579C0100_497ECC0E0325_impl*
end;//TPrimTreeAttributeSelectForm.ActivateElement

procedure TPrimTreeAttributeSelectForm.LoadFromQuery(const aQuery: IQuery);
//#UC START# *527757CF036E_497ECC0E0325_var*
//#UC END# *527757CF036E_497ECC0E0325_var*
begin
//#UC START# *527757CF036E_497ECC0E0325_impl*
{$If not defined(Admin)}
 if Assigned(aQuery) then
  //LoadLogicFromQuery(aQuery, TaggedTreeInfo.Tag, AttributeTree.TreeStruct);
  TtasSaveLoadProxy.Instance.LoadFromQuery(aQuery, TaggedTreeInfo.Tag, AttributeTree.TreeStruct);
{$else}
 Assert(False);
{$IfEnd} //not Admin
//#UC END# *527757CF036E_497ECC0E0325_impl*
end;//TPrimTreeAttributeSelectForm.LoadFromQuery

procedure TPrimTreeAttributeSelectForm.DoContextFilterChange(aSender: TObject);
//#UC START# *527757EA030A_497ECC0E0325_var*
//#UC END# *527757EA030A_497ECC0E0325_var*
begin
//#UC START# *527757EA030A_497ECC0E0325_impl*
 ContextFilterChange(aSender);
//#UC END# *527757EA030A_497ECC0E0325_impl*
end;//TPrimTreeAttributeSelectForm.DoContextFilterChange

procedure TPrimTreeAttributeSelectForm.InvalidateOtherTree;
//#UC START# *527757FE02EE_497ECC0E0325_var*
//#UC END# *527757FE02EE_497ECC0E0325_var*
begin
//#UC START# *527757FE02EE_497ECC0E0325_impl*
 case UserType of
  astOneLevel: Op_AttributeTree_Invalidate.Call(Aggregate, Ord(astFirstLevel));
  astFirstLevel: Op_AttributeTree_Invalidate.Call(Aggregate, Ord(astOneLevel));
 end;//astOneLevel
//#UC END# *527757FE02EE_497ECC0E0325_impl*
end;//TPrimTreeAttributeSelectForm.InvalidateOtherTree

procedure TPrimTreeAttributeSelectForm.SetRootForFullForm(const aTag: Il3CString);
//#UC START# *52775827028F_497ECC0E0325_var*
var
 l_TreeSource: Il3SimpleTree;
//#UC END# *52775827028F_497ECC0E0325_var*
begin
//#UC START# *52775827028F_497ECC0E0325_impl*
 l_TreeSource := TnsAttributeTreeStruct.Make(aTag, AttributeTree.ShowRoot);

 with AttributeTree do 
 begin
  TreeStruct := l_TreeSource;
  if (Container.AsForm.ZoneType = vcm_ztParent) then
  begin
   if f_CaptionMap = nil then
    f_CaptionMap := nsStringMapManager.Map[smap_ContextParamsCaptions];
   if (l3Same(aTag, AT_KW)) then
   begin
    CCaption := f_CaptionMap.ValueToDisplayName(aTag);
    ExpandNode(GetCurrentNode, True);
   end else
   if (l3Same(aTag, AT_PUBLISH_SOURCE)) then
   begin
    if UserType = astTaxesPublishSearch then
     CCaption := CurUserTypeDef.Caption
    else
     CCaption := f_CaptionMap.ValueToDisplayName(aTag);
   end else//l3Same(aTag, AT_PUBLISH_SOURCE)
   if (l3Same(aTag, AT_PUBLISH_SOURCE_PHARM)) then
   begin
    if UserType = astPharmPublishSearch then
     CCaption := CurUserTypeDef.Caption
    else
     //CCaption := f_CaptionMap.ValueToDisplayName(aTag);
     Assert(False);
   end//l3Same(aTag, AT_PUBLISH_SOURCE_PHARM)
   else
    CCaption := l3CStr(TreeStruct.RootNode);
  end//Container.AsForm.ZoneType = vcm_ztParent
  else
   CCaption := nil;
 end; //with AttributeTree
//#UC END# *52775827028F_497ECC0E0325_impl*
end;//TPrimTreeAttributeSelectForm.SetRootForFullForm

procedure TPrimTreeAttributeSelectForm.SetRootForFirstLevelForm(const aTag: Il3CString);
//#UC START# *5277584002E5_497ECC0E0325_var*
//#UC END# *5277584002E5_497ECC0E0325_var*
begin
//#UC START# *5277584002E5_497ECC0E0325_impl*
 AttributeTree.TreeStruct := TnsFirstLevelStruct.Make(aTag, AttributeTree.ShowRoot);
 CCaption := vcmCStr(str_SituationTitle);
 op_AttributeTree_ChangeRoot.Call(Aggregate, TaggedTreeInfo.Tag, AttributeTree.TreeStruct.RootNode, AttributeTree.TreeStruct.RootNode.Child);
//#UC END# *5277584002E5_497ECC0E0325_impl*
end;//TPrimTreeAttributeSelectForm.SetRootForFirstLevelForm

function TPrimTreeAttributeSelectForm.GetRootInfo: InsRootInfo;
//#UC START# *5277585E00BE_497ECC0E0325_var*
//#UC END# *5277585E00BE_497ECC0E0325_var*
begin
//#UC START# *5277585E00BE_497ECC0E0325_impl*
 Result := RootInfo;
//#UC END# *5277585E00BE_497ECC0E0325_impl*
end;//TPrimTreeAttributeSelectForm.GetRootInfo

procedure TPrimTreeAttributeSelectForm.NotifyOperationChange(const aNode: INodeBase;
 aOldOp: TLogicOperation;
 aNewOp: TLogicOperation);
//#UC START# *527758940054_497ECC0E0325_var*
//#UC END# *527758940054_497ECC0E0325_var*
begin
//#UC START# *527758940054_497ECC0E0325_impl*
{
 if (Aggregate <> nil) then
 begin
  if aOldOp = loNone then
   Aggregate.Operation(op_SelectedList_Add,
                       vcmParams.Add(aNode).Add(Byte(aNewOp)))
  else
   if aNewOp = loNone then
    Aggregate.Operation(op_SelectedList_Delete,
                        vcmParams.Add(aNode))
   else
    Aggregate.Operation(op_SelectedList_ChangeOperation,
                        vcmParams.Add(aNode).Add(Byte(aNewOp)));
 end;
}
 NotifyMultipleChanges;
//#UC END# *527758940054_497ECC0E0325_impl*
end;//TPrimTreeAttributeSelectForm.NotifyOperationChange

procedure TPrimTreeAttributeSelectForm.FormLogicOperation(const aNode: INodeBase;
 aOp: TLogicOperation;
 aWithNotify: Boolean = True);
//#UC START# *527758E80127_497ECC0E0325_var*
var
 l_OldOp: TLogicOperation;
//#UC END# *527758E80127_497ECC0E0325_var*
begin
//#UC START# *527758E80127_497ECC0E0325_impl*
 l_OldOp := GetLogicOperation(aNode);
 if l_OldOp = aOp then
  aOp := loNone;

 if (aOp = loNone) or not aNode.HasFilteredChildren then
 begin
  SetLogicOperation(aNode, aOp);
  if aWithNotify then
   NotifyOperationChange(aNode, l_OldOp, aOp);
 end;
//#UC END# *527758E80127_497ECC0E0325_impl*
end;//TPrimTreeAttributeSelectForm.FormLogicOperation

procedure TPrimTreeAttributeSelectForm.DropSelectedOperation;
//#UC START# *5277590003E1_497ECC0E0325_var*
//#UC END# *5277590003E1_497ECC0E0325_var*
begin
//#UC START# *5277590003E1_497ECC0E0325_impl*
 ChangeOperationOnSelected(loNone);
//#UC END# *5277590003E1_497ECC0E0325_impl*
end;//TPrimTreeAttributeSelectForm.DropSelectedOperation

procedure TPrimTreeAttributeSelectForm.ChangeOperationOnSelected(aNewOp: TLogicOperation);
//#UC START# *527759200129_497ECC0E0325_var*
var
 l_Node, l_Root: INodeBase;
 l_Iterator: INodeIterator;
//#UC END# *527759200129_497ECC0E0325_var*
begin
//#UC START# *527759200129_497ECC0E0325_impl*
 if (AttributeTree.TreeStruct.SelectCount > 0) and
    Supports(AttributeTree.TreeStruct.RootNode, INodeBase, l_Root) then
 begin
  l_Root.IterateNodes(FM_SELECTION, l_Iterator);
  try
   l_Iterator.GetNext(l_Node);
   while l_Node <> nil do
   begin
    if not l_Node.HasFilteredChildren then
     SetLogicOperation(l_Node, aNewOp);
    l_Iterator.GetNext(l_Node);
   end;
   NotifyMultipleChanges;
  finally
   l_Root := nil;
  end;
 end;
//#UC END# *527759200129_497ECC0E0325_impl*
end;//TPrimTreeAttributeSelectForm.ChangeOperationOnSelected

procedure TPrimTreeAttributeSelectForm.CurrentChangedPrim(aNewIndex: Integer;
 aOldIndex: Integer;
 aForceUpdateParent: Boolean = False);
//#UC START# *527759B902F8_497ECC0E0325_var*
var
 l_NewParent: Il3SimpleNode;
 l_Root: INodeBase;
//#UC END# *527759B902F8_497ECC0E0325_var*
begin
//#UC START# *527759B902F8_497ECC0E0325_impl*
 case UserType of
  astFirstLevel:
  begin
   op_AttributeTree_ChangeRoot.Call(Aggregate,
                                    TaggedTreeInfo.Tag,
                                    AttributeTree.TreeStruct.RootNode,
                                    AttributeTree.GetNode(aNewIndex));
  end;//astFirstLevel
  astOneLevel:
  begin
   {!! можно выбросить, когда FirstLevel и OneLevel станут разными view }
   if Supports(AttributeTree.TreeStruct.RootNode, INodeBase, l_Root) then
    l_Root.SetFlag(FM_SELECTION, True);
  end;//astOneLevel
  else
   if (aNewIndex >= 0) then
   begin
    l_NewParent := GetFirstLevelParent(aNewIndex);
    try
     if (l_NewParent <> nil) and (Aggregate <> nil) and
       (aForceUpdateParent or not l_NewParent.
        IsSame(GetFirstLevelParent(aOldIndex))) then
      DS.CurrentChanged(l_NewParent);
    finally
     l_NewParent := nil;
    end;//try..finally
   end;//if (aNewIndex >= 0) then
 end;//case UserType of
//#UC END# *527759B902F8_497ECC0E0325_impl*
end;//TPrimTreeAttributeSelectForm.CurrentChangedPrim

procedure TPrimTreeAttributeSelectForm.SetLogicOperationOnNode(const aNode: INodeBase);
//#UC START# *527759E3016D_497ECC0E0325_var*
var
 l_ParentOperation: TLogicOperation;
 l_OldOperation: TLogicOperation;
 l_CurOperation: TLogicOperation;
//#UC END# *527759E3016D_497ECC0E0325_var*
begin
//#UC START# *527759E3016D_497ECC0E0325_impl*
 l_CurOperation := loNone;
 if not aNode.HasFilteredChildren then
 begin
  l_ParentOperation := GetParentsOperation(aNode);
  if l_ParentOperation <> loNot then
  begin
   l_OldOperation := GetLogicOperation(aNode);
   if l_OldOperation = High(TLogicOperation) then
    l_CurOperation := loNone
   else
   begin
    // Включаем\выключаем только первую разрешенную для узла операцию:
    if (l_ParentOperation = loNone) then
    begin
     // Выключаем операцию:
     if l_OldOperation <> loNone then
      l_CurOperation := loNone
     // Включаем операцию:
     else
     begin
      l_CurOperation := Succ(l_OldOperation);
      if Assigned(DS) then
       while (l_CurOperation <> loNone) and
         not (l_CurOperation in DS.Operations) do
       begin
        if l_CurOperation = High(TLogicOperation) then
         l_CurOperation := Low(TLogicOperation)
        else
         l_CurOperation := Succ(l_CurOperation);
       end;//while (l_CurOperation <> loNone) and...
     end;//if l_OldOperation <> loNone then
    end//if (l_ParentOperation = loNone) then
    else
     if Assigned(DS) then
      if loNot in DS.Operations then
       l_CurOperation := loNot
      else
       l_CurOperation := loNone;
   end;//if l_OldOperation = High(TLogicOperation) then
   SetLogicOperation(aNode, l_CurOperation);
   NotifyOperationChange(aNode, l_OldOperation, l_CurOperation);
  end;//if l_ParentOperation <> loNot then
 end//if not aNode.HasFilteredChildren then
 else
 begin
  l_OldOperation := GetLogicOperation(aNode);
  if l_OldOperation <> loNone then
  begin
   SetLogicOperation(aNode, loNone);
   NotifyOperationChange(aNode, l_OldOperation, loNone);
  end;//if l_OldOperation <> loNone then
 end;//if not aNode.HasFilteredChildren then
//#UC END# *527759E3016D_497ECC0E0325_impl*
end;//TPrimTreeAttributeSelectForm.SetLogicOperationOnNode

procedure TPrimTreeAttributeSelectForm.LogicOperationTest(const aParams: IvcmTestParamsPrim;
 aOp: TLogicOperation);
//#UC START# *52775A88036E_497ECC0E0325_var*
var
 l_l3Node: Il3SimpleNode;
 l_Node: INodeBase;
//#UC END# *52775A88036E_497ECC0E0325_var*
begin
//#UC START# *52775A88036E_497ECC0E0325_impl*
 case aOp of
  loOr: f_OrState := False;
  loAnd: f_AndState := False;
  loNot: f_NotState := False;
 end;

 if Assigned(DS) and not (aOp in DS.Operations) then
  aParams.Op.Flag[vcm_ofEnabled] := False
 else
 if AttributeTree.Current >= 0 then
 begin
  l_l3Node := AttributeTree.GetCurrentNode;
  if Supports(l_l3Node, INodeBase, l_Node) and
     not l_Node.HasFilteredChildren then
  begin
   if GetLogicOperation(l_Node) = aOp then
   begin
    case aOp of
     loOr: f_OrState := True;
     loAnd: f_AndState := True;
     loNot: f_NotState := True;
    end;
    aParams.Op.Flag[vcm_ofChecked] := True
   end
   else
   if ((aOp <> loNot) and (GetParentsOperation(l_Node) <> loNone)) or
      ((aOp = loNot) and  (GetParentsOperation(l_Node) = loNot)) then
   begin
    aParams.Op.Flag[vcm_ofChecked] := False;
    aParams.Op.Flag[vcm_ofEnabled] := False;
   end else
   begin
    aParams.Op.Flag[vcm_ofChecked] := False;
    aParams.Op.Flag[vcm_ofEnabled] := True;
   end;
  end
  else
   aParams.Op.Flag[vcm_ofEnabled] := False;
 end
 else
  aParams.Op.Flag[vcm_ofEnabled] := False;
//#UC END# *52775A88036E_497ECC0E0325_impl*
end;//TPrimTreeAttributeSelectForm.LogicOperationTest

function TPrimTreeAttributeSelectForm.GetFirstLevelParent(const aNode: Il3SimpleNode): Il3SimpleNode;
//#UC START# *52775B27001A_497ECC0E0325_var*
var
 l_Parent : Il3SimpleNode;
//#UC END# *52775B27001A_497ECC0E0325_var*
begin
//#UC START# *52775B27001A_497ECC0E0325_impl*
 if (aNode = nil) then
  Result := nil
 else
  if (UserType = astOneLevel) then
   Result := AttributeTree.TreeStruct.RootNode
  else
  begin
   l_Parent := aNode.Parent;
   try
    if l_Parent = nil then
     Result := nil
    else
     if l_Parent.IsSame(AttributeTree.TreeStruct.RootNode) then
      Result := aNode
     else
     begin
      while not l_Parent.Parent.IsSame(AttributeTree.TreeStruct.RootNode) do
       l_Parent := l_Parent.Parent;
      Result := l_Parent;
     end;
   finally
    l_Parent := nil;
   end;
  end;
//#UC END# *52775B27001A_497ECC0E0325_impl*
end;//TPrimTreeAttributeSelectForm.GetFirstLevelParent

function TPrimTreeAttributeSelectForm.GetFirstLevelParent(const aNode: INodeBase): INodeBase;
//#UC START# *52775B3700D4_497ECC0E0325_var*
var
 l_Parent, l_Node: INodeBase;
//#UC END# *52775B3700D4_497ECC0E0325_var*
begin
//#UC START# *52775B3700D4_497ECC0E0325_impl*
 Result := nil;
 if (aNode <> nil) and (UserType = astOneLevel) then
  Supports(AttributeTree.TreeStruct.RootNode, INodeBase, Result)
 else
 begin
  l_Node := aNode;
  try
   while l_Node.GetLevel > 1 do
   begin
    l_Node.GetParent(l_Parent);
    l_Node := nil;
    if l_Parent = nil then
     exit;
    l_Node := l_Parent;
    l_Parent := nil;
   end;
   Result := l_Node;
  finally
   l_Node := nil;
  end;
 end;
//#UC END# *52775B3700D4_497ECC0E0325_impl*
end;//TPrimTreeAttributeSelectForm.GetFirstLevelParent

function TPrimTreeAttributeSelectForm.GetFirstLevelParent(aIndex: Integer): Il3SimpleNode;
//#UC START# *52775B3F025E_497ECC0E0325_var*
var
 l_l3Node : Il3SimpleNode;
//#UC END# *52775B3F025E_497ECC0E0325_var*
begin
//#UC START# *52775B3F025E_497ECC0E0325_impl*
 Result := nil;
 if (UserType = astOneLevel) then
  Result := AttributeTree.TreeStruct.RootNode
 else
 begin
  l_l3Node := AttributeTree.GetNode(aIndex);
  try
   Result := GetFirstLevelParent(l_l3Node);
  finally
   l_l3Node := nil;
  end;
 end;
//#UC END# *52775B3F025E_497ECC0E0325_impl*
end;//TPrimTreeAttributeSelectForm.GetFirstLevelParent

{$If Defined(disabled_function)}
procedure TPrimTreeAttributeSelectForm.LOToolbarTest(const aParams: IvcmTestParamsPrim;
 aLO: TLogicOperation);
 {* метод установки параметров в _OnTest для операций публикуемых в toolbar-е. Отличие в том, что они не показываются для ситуаций первого второго уровня.

Отключено при переносе на модель.
Решили, что нет нужды делать разную логику для тулбаров и контекстного меню. }
//#UC START# *52775B9402B2_497ECC0E0325_var*
//#UC END# *52775B9402B2_497ECC0E0325_var*
begin
//#UC START# *52775B9402B2_497ECC0E0325_impl*
 // Обязательно нужно выполнить, потому, что для ситуаций первого второго уровня
 // кнопка не видима, но Test используется контейнером cfSaveLoad для установки
 // состония кнопки
 LogicOperationTest(aParams, aLO);
 // !!! Нельзя заменять на ExcludeType, т.к. вызов идет с другой формы-контейнера
 aParams.Op.Flag[vcm_ofVisible] := not (UserType in [astOneLevel, astFirstLevel]);
//#UC END# *52775B9402B2_497ECC0E0325_impl*
end;//TPrimTreeAttributeSelectForm.LOToolbarTest
{$IfEnd} // Defined(disabled_function)

function TPrimTreeAttributeSelectForm.CountItemImage(const aNode: INodeBase): Integer;
//#UC START# *52777B680276_497ECC0E0325_var*
var
 l_Operation: TLogicOperation;
 l_ParentOperation: TLogicOperation;
 l_FilteredNode: Boolean;
//#UC END# *52777B680276_497ECC0E0325_var*
begin
//#UC START# *52777B680276_497ECC0E0325_impl*
 l_Operation := GetLogicOperation(aNode);
 l_ParentOperation := GetParentsOperation(aNode);
 l_FilteredNode := aNode.HasFilteredChildren;
 if (l_Operation <> loNone) or
    (l_ParentOperation = loNone) then
 begin
  if aNode.HasChildren or (UserType = astFirstLevel) then
  begin
   if (l_Operation = loNone) and HasAnyChildOperation(aNode) then
    if (l_FilteredNode) then
      Result := c_saFilteredFolderHasSelectChild
    else
      Result := c_saFolderHasSelectChild
   else
    if (l_FilteredNode) then
      Result := c_saFilteredFolderStart + Byte(l_Operation)
    else
      Result := c_saFolderStart + Byte(l_Operation);
  end
  else
   Result := c_saElementStart + Byte(l_Operation);
 end else
 begin
  if (l_ParentOperation = loNot) then
  begin
   if aNode.HasChildren then
     if (l_FilteredNode) then
      Result := c_saFilteredFolderInSelectFolderDisable
     else
      Result := c_saFolderInSelectFolderDisable
   else
    Result := c_saChildInSelectFolderDisable;
  end
  else
  begin
   if aNode.HasChildren then
    if (l_FilteredNode) then
      Result := c_saFilteredFolderInSelectFolderEnable
    else
      Result := c_saFolderInSelectFolderEnable
   else
    Result := c_saChildInSelectFolderEnable;
  end;
 end;
//#UC END# *52777B680276_497ECC0E0325_impl*
end;//TPrimTreeAttributeSelectForm.CountItemImage

procedure TPrimTreeAttributeSelectForm.vcmEntityFormSaveState(out aState: IvcmBase;
 aStateType: TvcmStateType;
 var Saved: Boolean);
//#UC START# *5279F70F0146_497ECC0E0325_var*
var
 l_Query: IQuery;
 {$If not Defined(Admin)}
 l_Container: TnsQueryContainer;
 {$IfEnd}
//#UC END# *5279F70F0146_497ECC0E0325_var*
begin
//#UC START# *5279F70F0146_497ECC0E0325_impl*
 if IsOldSchoolNone then
 begin
  // В этом месте запрос носит чисто транспортные функции, поэтому его тип не
  // играет роли и задан "от фонаря":
  {$If not Defined(Admin)}
  defDataAdapter.Search.CreateQuery(QT_ATTRIBUTE, l_Query);
  try
    l_Container := TnsQueryContainer.Create;
    try
     if SaveToQuery(l_Query)
      then InsQueryContainer(l_Container).Query := l_Query
      else InsQueryContainer(l_Container).Query := nil;
     aState := l_Container as IvcmBase;
    finally
     vcmFree(l_Container);
    end;{try..finally}
  finally
   l_Query := nil;
  end;//try..finally
  {$Else}
  Saved := false;
  {$ifEnd}
 end;//IsOldSchoolNone
//#UC END# *5279F70F0146_497ECC0E0325_impl*
end;//TPrimTreeAttributeSelectForm.vcmEntityFormSaveState

procedure TPrimTreeAttributeSelectForm.Updated;
 {* данные дерева были обновлены. Реакция на обновление данных
            приложения }
//#UC START# *48FF6D200201_497ECC0E0325_var*
//#UC END# *48FF6D200201_497ECC0E0325_var*
begin
//#UC START# *48FF6D200201_497ECC0E0325_impl*
 SendContextChangeMessage;
//#UC END# *48FF6D200201_497ECC0E0325_impl*
end;//TPrimTreeAttributeSelectForm.Updated

procedure TPrimTreeAttributeSelectForm.CurrentChangedNotification(const aNode: Il3SimpleNode);
//#UC START# *497465F501B7_497ECC0E0325_var*
//#UC END# *497465F501B7_497ECC0E0325_var*
begin
//#UC START# *497465F501B7_497ECC0E0325_impl*
 SetCurrentNode(aNode, True);
//#UC END# *497465F501B7_497ECC0E0325_impl*
end;//TPrimTreeAttributeSelectForm.CurrentChangedNotification

procedure TPrimTreeAttributeSelectForm.ExternalCharPressed;
//#UC START# *4AE831FA00F9_497ECC0E0325_var*
//#UC END# *4AE831FA00F9_497ECC0E0325_var*
begin
//#UC START# *4AE831FA00F9_497ECC0E0325_impl*
 !!! Needs to be implemented !!!
//#UC END# *4AE831FA00F9_497ECC0E0325_impl*
end;//TPrimTreeAttributeSelectForm.ExternalCharPressed

procedure TPrimTreeAttributeSelectForm.SetCurrent;
//#UC START# *4AE8703B02A2_497ECC0E0325_var*
//#UC END# *4AE8703B02A2_497ECC0E0325_var*
begin
//#UC START# *4AE8703B02A2_497ECC0E0325_impl*
 !!! Needs to be implemented !!!
//#UC END# *4AE8703B02A2_497ECC0E0325_impl*
end;//TPrimTreeAttributeSelectForm.SetCurrent

procedure TPrimTreeAttributeSelectForm.DropAllLogicSelection;
//#UC START# *4AE870DD01D0_497ECC0E0325_var*
//#UC END# *4AE870DD01D0_497ECC0E0325_var*
begin
//#UC START# *4AE870DD01D0_497ECC0E0325_impl*
 !!! Needs to be implemented !!!
//#UC END# *4AE870DD01D0_497ECC0E0325_impl*
end;//TPrimTreeAttributeSelectForm.DropAllLogicSelection

function TPrimTreeAttributeSelectForm.IsQueryEmpty: Boolean;
//#UC START# *4AE879D00143_497ECC0E0325_var*
//#UC END# *4AE879D00143_497ECC0E0325_var*
begin
//#UC START# *4AE879D00143_497ECC0E0325_impl*
 !!! Needs to be implemented !!!
//#UC END# *4AE879D00143_497ECC0E0325_impl*
end;//TPrimTreeAttributeSelectForm.IsQueryEmpty

procedure TPrimTreeAttributeSelectForm.SaveToQuery;
//#UC START# *4AE8913D00A7_497ECC0E0325_var*
//#UC END# *4AE8913D00A7_497ECC0E0325_var*
begin
//#UC START# *4AE8913D00A7_497ECC0E0325_impl*
 !!! Needs to be implemented !!!
//#UC END# *4AE8913D00A7_497ECC0E0325_impl*
end;//TPrimTreeAttributeSelectForm.SaveToQuery

procedure TPrimTreeAttributeSelectForm.Invalidate;
//#UC START# *4AEAE67802ED_497ECC0E0325_var*
//#UC END# *4AEAE67802ED_497ECC0E0325_var*
begin
//#UC START# *4AEAE67802ED_497ECC0E0325_impl*
 !!! Needs to be implemented !!!
//#UC END# *4AEAE67802ED_497ECC0E0325_impl*
end;//TPrimTreeAttributeSelectForm.Invalidate

procedure TPrimTreeAttributeSelectForm.DefaultAction;
//#UC START# *4AEAEABF034E_497ECC0E0325_var*
//#UC END# *4AEAEABF034E_497ECC0E0325_var*
begin
//#UC START# *4AEAEABF034E_497ECC0E0325_impl*
 !!! Needs to be implemented !!!
//#UC END# *4AEAEABF034E_497ECC0E0325_impl*
end;//TPrimTreeAttributeSelectForm.DefaultAction

procedure TPrimTreeAttributeSelectForm.SetQuery;
//#UC START# *4AEF213001F0_497ECC0E0325_var*
//#UC END# *4AEF213001F0_497ECC0E0325_var*
begin
//#UC START# *4AEF213001F0_497ECC0E0325_impl*
 !!! Needs to be implemented !!!
//#UC END# *4AEF213001F0_497ECC0E0325_impl*
end;//TPrimTreeAttributeSelectForm.SetQuery

procedure TPrimTreeAttributeSelectForm.DropLogicSelection;
//#UC START# *4AEF38310030_497ECC0E0325_var*
//#UC END# *4AEF38310030_497ECC0E0325_var*
begin
//#UC START# *4AEF38310030_497ECC0E0325_impl*
 !!! Needs to be implemented !!!
//#UC END# *4AEF38310030_497ECC0E0325_impl*
end;//TPrimTreeAttributeSelectForm.DropLogicSelection

procedure TPrimTreeAttributeSelectForm.LoadQuery;
//#UC START# *4AEF3857010A_497ECC0E0325_var*
//#UC END# *4AEF3857010A_497ECC0E0325_var*
begin
//#UC START# *4AEF3857010A_497ECC0E0325_impl*
 !!! Needs to be implemented !!!
//#UC END# *4AEF3857010A_497ECC0E0325_impl*
end;//TPrimTreeAttributeSelectForm.LoadQuery

procedure TPrimTreeAttributeSelectForm.SetOneLevelCurrent;
//#UC START# *4AEF3871010E_497ECC0E0325_var*
//#UC END# *4AEF3871010E_497ECC0E0325_var*
begin
//#UC START# *4AEF3871010E_497ECC0E0325_impl*
 !!! Needs to be implemented !!!
//#UC END# *4AEF3871010E_497ECC0E0325_impl*
end;//TPrimTreeAttributeSelectForm.SetOneLevelCurrent

procedure TPrimTreeAttributeSelectForm.SetContext;
//#UC START# *4AEF38920247_497ECC0E0325_var*
//#UC END# *4AEF38920247_497ECC0E0325_var*
begin
//#UC START# *4AEF38920247_497ECC0E0325_impl*
 !!! Needs to be implemented !!!
//#UC END# *4AEF38920247_497ECC0E0325_impl*
end;//TPrimTreeAttributeSelectForm.SetContext

procedure TPrimTreeAttributeSelectForm.SetRoot;
//#UC START# *4AF3EBC001C4_497ECC0E0325_var*
//#UC END# *4AF3EBC001C4_497ECC0E0325_var*
begin
//#UC START# *4AF3EBC001C4_497ECC0E0325_impl*
 !!! Needs to be implemented !!!
//#UC END# *4AF3EBC001C4_497ECC0E0325_impl*
end;//TPrimTreeAttributeSelectForm.SetRoot

procedure TPrimTreeAttributeSelectForm.ChangeRoot;
//#UC START# *4AF3FE7D0138_497ECC0E0325_var*
//#UC END# *4AF3FE7D0138_497ECC0E0325_var*
begin
//#UC START# *4AF3FE7D0138_497ECC0E0325_impl*
 !!! Needs to be implemented !!!
//#UC END# *4AF3FE7D0138_497ECC0E0325_impl*
end;//TPrimTreeAttributeSelectForm.ChangeRoot

procedure TPrimTreeAttributeSelectForm.SyncContextParams;
//#UC START# *4AF40A0E01D3_497ECC0E0325_var*
//#UC END# *4AF40A0E01D3_497ECC0E0325_var*
begin
//#UC START# *4AF40A0E01D3_497ECC0E0325_impl*
 !!! Needs to be implemented !!!
//#UC END# *4AF40A0E01D3_497ECC0E0325_impl*
end;//TPrimTreeAttributeSelectForm.SyncContextParams

procedure TPrimTreeAttributeSelectForm.AddNodeIfEmpty;
//#UC START# *4AF8604B021E_497ECC0E0325_var*
//#UC END# *4AF8604B021E_497ECC0E0325_var*
begin
//#UC START# *4AF8604B021E_497ECC0E0325_impl*
 !!! Needs to be implemented !!!
//#UC END# *4AF8604B021E_497ECC0E0325_impl*
end;//TPrimTreeAttributeSelectForm.AddNodeIfEmpty

procedure TPrimTreeAttributeSelectForm.ClearQuery;
//#UC START# *4AF92B09017F_497ECC0E0325_var*
//#UC END# *4AF92B09017F_497ECC0E0325_var*
begin
//#UC START# *4AF92B09017F_497ECC0E0325_impl*
 !!! Needs to be implemented !!!
//#UC END# *4AF92B09017F_497ECC0E0325_impl*
end;//TPrimTreeAttributeSelectForm.ClearQuery

procedure TPrimTreeAttributeSelectForm.FindFirstSelected;
//#UC START# *4C2B1B9100B5_497ECC0E0325_var*
//#UC END# *4C2B1B9100B5_497ECC0E0325_var*
begin
//#UC START# *4C2B1B9100B5_497ECC0E0325_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C2B1B9100B5_497ECC0E0325_impl*
end;//TPrimTreeAttributeSelectForm.FindFirstSelected

procedure TPrimTreeAttributeSelectForm.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_497ECC0E0325_var*
//#UC END# *479731C50290_497ECC0E0325_var*
begin
//#UC START# *479731C50290_497ECC0E0325_impl*
 if (AttributeTree.TreeStruct <> nil) then
  AttributeTree.TreeStruct.Unsubscribe(InsTreeDataListener(Self));
 f_CaptionMap := nil;
 inherited;
//#UC END# *479731C50290_497ECC0E0325_impl*
end;//TPrimTreeAttributeSelectForm.Cleanup

procedure TPrimTreeAttributeSelectForm.InitFields;
//#UC START# *47A042E100E2_497ECC0E0325_var*
//#UC END# *47A042E100E2_497ECC0E0325_var*
begin
//#UC START# *47A042E100E2_497ECC0E0325_impl*
 inherited;
 (* задел на будущее чтобы в ResultopOk в aParams.Control было установлено
    дерево и нас бы не пришлось использовать GetFocus и FindControl  *)
// Entities.LinkControlToEntity(AttributeTree, 'enResult');
 ContextFilter.Images := dmStdRes.SmallImageList;
 AttributeTree.Images := nsSearchRes.ilSelectAttribute;

 OnSaveState := VcmEntityFormSaveState;
//#UC END# *47A042E100E2_497ECC0E0325_impl*
end;//TPrimTreeAttributeSelectForm.InitFields

{$If NOT Defined(NoVCM)}
procedure TPrimTreeAttributeSelectForm.NotifyDataSourceChanged(const anOld: IvcmViewAreaController;
 const aNew: IvcmViewAreaController);
 {* Изменился источник данных. Для перекрытия в потомках }
//#UC START# *497469C90140_497ECC0E0325_var*
//#UC END# *497469C90140_497ECC0E0325_var*
begin
//#UC START# *497469C90140_497ECC0E0325_impl*
 inherited;
 // Для формы с фиктивным DS, которая не входит в сборку ничего не делаем
 if Assigned(DS) and Assigned(DS.UseCaseController) then
 begin
  // Борьба с фильтром vs. история vs. _datasource
  if not Dispatcher.History.InBF then
  begin
   with AttributeTree do
   begin
    // Дерево:
    TreeStruct := DS.SimpleTree;
    // Разворачивает первый узел:
    ExpandNode(GetCurrentNode, True);
   end;//with AttributeTree do
   // Загрузим запрос:
   LoadFromQuery(DS.Search.Query);
   InvalidateOtherTree;
   NotifyMultipleChanges;
  end//not aFromHistory
  else
  if Assigned(anOld) and Assigned(aNew) and (TaggedTreeInfo <> nil) then
   DS.SimpleTree := TnsAttributeTreeStruct.Make(TaggedTreeInfo.Tag, False);
  CCaption := DS.DisplayName;
 end;//if Assigned(DS) and Assigned(DS.UseCaseController) then
//#UC END# *497469C90140_497ECC0E0325_impl*
end;//TPrimTreeAttributeSelectForm.NotifyDataSourceChanged
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
function TPrimTreeAttributeSelectForm.DoLoadState(const aState: IvcmBase;
 aStateType: TvcmStateType): Boolean;
 {* Загружает состояние формы. Для перекрытия в потомках }
//#UC START# *49807428008C_497ECC0E0325_var*
{$ifndef admin}
var
 l_Container: InsQueryContainer;
{$endif}
//#UC END# *49807428008C_497ECC0E0325_var*
begin
//#UC START# *49807428008C_497ECC0E0325_impl*
{$ifndef admin}
 if (aStateType = vcm_stContent) and IsOldSchoolNone then
 begin
  if Supports(aState, InsQueryContainer, l_Container) then
  try
   DropAllLogicSelection;
   if (l_Container.Query <> nil) then
    LoadFromQuery(l_Container.Query);
  finally
   l_Container := nil;
  end;{try..finally}
 end;//if (aStateType = vcm_stContent) and
{$endif}
//#UC END# *49807428008C_497ECC0E0325_impl*
end;//TPrimTreeAttributeSelectForm.DoLoadState
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimTreeAttributeSelectForm.InitControls;
 {* Процедура инициализации контролов. Для перекрытия в потомках }
//#UC START# *4A8E8F2E0195_497ECC0E0325_var*
//#UC END# *4A8E8F2E0195_497ECC0E0325_var*
begin
//#UC START# *4A8E8F2E0195_497ECC0E0325_impl*
 inherited;

 ActiveControl := AttributeTree;

 with BackgroundPanel do
 begin
  Align := alClient;
  BevelOuter := bvNone;
 end;
 with ContextFilter do
 begin
  ImageIndex := 77;
  ContextFilterTarget := AttributeTree;
  OnChange := ContextFilterChange;
  OnWrongContext := ContextFilterWrongContext;
 end;
 with AttributeTree do
 begin
  Align := alClient;
  FooterVisible := False;
  ShowHeader := False;
  PickedList := False;
  DblClickOnFolder := False;
  MultiSelect := True;
  MultiStrokeItem := True;
  ActionElementMode := l3_amDoubleClick;
  ViewOptions := [voShowInterRowSpace, voShowIcons, voShowExpandable, voShowLines, voShowOpenChip];
  AllowWithoutCurrent := False;
  BorderStyle := bsNone;

  OnIsCommandProcessed := AttributeTreeIsCommandProcessed;
  OnAfterFirstPaint := AttributeTreeAfterFirstPaint;
  OnLMouseDown := AttributeTreeLMouseDown;
  OnGetItemImage := AttributeTreeGetItemImage;
  OnActionElement := AttributeTreeActionElement;
  OnCurrentChanged := AttributeTreeCurrentChanged;
  OnTreeChanged := AttributeTreeTreeChanged;
  OnNewCharPressed := AttributeTreeNewCharPressed;

  StyleId := evd_saInterface;
  FooterStyleID := evd_saHyperLink;
  FooterActiveStyleID := evd_saActiveHyperLink;

  SettingId := 'stidAttributeTree';
 end;
//#UC END# *4A8E8F2E0195_497ECC0E0325_impl*
end;//TPrimTreeAttributeSelectForm.InitControls
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimTreeAttributeSelectForm.NotifyUserTypeSet;
//#UC START# *4D78E2BB0211_497ECC0E0325_var*
//#UC END# *4D78E2BB0211_497ECC0E0325_var*
begin
//#UC START# *4D78E2BB0211_497ECC0E0325_impl*
 inherited;
 if UserType = astOneLevel then
  AttributeTree.ViewOptions := AttributeTree.ViewOptions - [voShowOpenChip]
 else
 if UserType = astFirstLevel then
 begin
  AttributeTree.ViewOptions := AttributeTree.ViewOptions - [voShowOpenChip];
  AttributeTree.EditOptions := AttributeTree.EditOptions - [eoItemExpand];
 end;
 // Видимость контекстного поиска
 if not IsOldSchoolNone then
 begin
  ContextFilter.Visible := False;
  ContextFilter.Enabled := False;
 end;//not IsOldSchoolNone
//#UC END# *4D78E2BB0211_497ECC0E0325_impl*
end;//TPrimTreeAttributeSelectForm.NotifyUserTypeSet
{$IfEnd} // NOT Defined(NoVCM)

initialization
 str_astNoneCaption.Init;
 {* Инициализация str_astNoneCaption }
 str_astOneLevelCaption.Init;
 {* Инициализация str_astOneLevelCaption }
 str_astFirstLevelCaption.Init;
 {* Инициализация str_astFirstLevelCaption }
 str_astTaxesPublishSearchCaption.Init;
 {* Инициализация str_astTaxesPublishSearchCaption }
 str_astPharmPublishSearchCaption.Init;
 {* Инициализация str_astPharmPublishSearchCaption }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimTreeAttributeSelectForm);
 {* Регистрация PrimTreeAttributeSelect }
{$IfEnd} // NOT Defined(NoScripts)

end.
