unit FakeBox;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VT"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/VT/ComboTree/FakeBox.pas"
// Начат: 19.05.2008 14:40
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<GuiControl::Class>> Shared Delphi::VT::ComboTree::TFakeBox
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\common\components\gui\Garant\VT\vtDefine.inc}

interface

uses
  l3Interfaces,
  l3TreeInterfaces,
  Messages,
  Classes,
  Graphics
  {$If not defined(NoVCL)}
  ,
  Controls
  {$IfEnd} //not NoVCL
  ,
  EditableBox,
  l3VCLStrings,
  l3InternalInterfaces
  ;

type
 TFakeBoxPrim = class(TEditableBox)
 private
 // private fields
  {$If not defined(DesignTimeLibrary)}
   f_IsFirstLoad : Boolean;
    {* для того чтобы при первой закрузке не дергался Execute.}
  {$IfEnd} //not DesignTimeLibrary
   f_TabEaten : Boolean;
   f_SetDroppedLock : Integer;
   f_SetToBeginOnTreeSelect : Boolean;
    {* Поле для свойства SetToBeginOnTreeSelect}
   f_OnAfterProcessKeyDown : TNotifyEvent;
    {* Поле для свойства OnAfterProcessKeyDown}
   f_TextValid : Boolean;
    {* Поле для свойства TextValid}
   f_ErrorColor : TColor;
    {* Поле для свойства ErrorColor}
   f_OnSelect : TNotifyEvent;
    {* Поле для свойства OnSelect}
   f_ShowFullPath : Boolean;
    {* Поле для свойства ShowFullPath}
 private
 // private methods
   function FindCurrent(const aText: Il3CString): Il3SimpleNode;
   function DrawWithErrorColor: Boolean;
   function IsNeedGotoNode(const aNode: Il3SimpleNode): Boolean;
 protected
 // property methods
   procedure pm_SetTextValid(aValue: Boolean);
   {$If not defined(DesignTimeLibrary)}
   function pm_GetChoosenValue: Il3SimpleNode;
   {$IfEnd} //not DesignTimeLibrary
   function pm_GetItems: Tl3Strings;
   procedure pm_SetItems(aValue: Tl3Strings);
   procedure pm_SetErrorColor(aValue: TColor);
   function pm_GetItemIndex: Integer;
   procedure pm_SetItemIndex(aValue: Integer);
 protected
 // overridden property methods
   procedure pm_SetDropped(aValue: Boolean); override;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
   procedure SetTextColor(const aCanvas: Il3Canvas); override;
   function EstimateTreeHeight(aMinSize: Integer;
     aMaxSize: Integer): Integer; override;
   function EstimateTreeWidth(aMaxSizeX: Integer;
     aSizeY: Integer): Integer; override;
   procedure ProcessTreeSelect(ChooseFromTree: Boolean;
     aTriggerSelect: Boolean); override;
   {$If not defined(NoVCL)}
   procedure DoEnter; override;
     {* Сигнатура метода DoEnter }
   {$IfEnd} //not NoVCL
 public
 // overridden public methods
   constructor Create(AOwner: TComponent); override;
 protected
 // protected methods
   procedure LocalUpdateAction; virtual;
     {* Сигнатура метода LocalUpdateAction }
   function DoCreateStrings: Tl3Strings; virtual;
    {$If not defined(DesignTimeLibrary)}
   function IsLockPaint: Boolean;
    {$IfEnd} //not DesignTimeLibrary
   procedure DefilterTree;
     {* Сигнатура метода DefilterTree }
   procedure ActionExecuteHandler; virtual;
     {* Сигнатура метода ActionExecuteHandler }
 public
 // public methods
    {$If not defined(DesignTimeLibrary)}
   procedure ShowNode(const aNode: Il3SimpleNode;
     TriggerSelect: Boolean = False);
     {* Показать узел с последующим выбором (т.е. дерево после вызова нефильтрованое) для Морозова, он передаёт таким образом ноды из ППР. }
    {$IfEnd} //not DesignTimeLibrary
    {$If not defined(DesignTimeLibrary)}
   function FindIndexOf(const aNode: Il3SimpleNode): Integer;
    {$IfEnd} //not DesignTimeLibrary
   procedure SetSimpleTree(const aTree: Il3SimpleTree);
   function IsValid: Boolean;
 protected
 // protected properties
   property SetToBeginOnTreeSelect: Boolean
     read f_SetToBeginOnTreeSelect
     write f_SetToBeginOnTreeSelect;
 public
 // public properties
   property OnAfterProcessKeyDown: TNotifyEvent
     read f_OnAfterProcessKeyDown
     write f_OnAfterProcessKeyDown;
   property TextValid: Boolean
     read f_TextValid
     write pm_SetTextValid;
     {* для ComboStyle = cbEdit определяет будет ли текст рисоваться нормальным цветом или ErrorColor. И что будет возвращать IsValid }
   {$If not defined(DesignTimeLibrary)}
   property ChoosenValue: Il3SimpleNode
     read pm_GetChoosenValue;
   {$IfEnd} //not DesignTimeLibrary
   property Items: Tl3Strings
     read pm_GetItems
     write pm_SetItems;
   property ErrorColor: TColor
     read f_ErrorColor
     write pm_SetErrorColor;
   property OnSelect: TNotifyEvent
     read f_OnSelect
     write f_OnSelect;
   property ItemIndex: Integer
     read pm_GetItemIndex
     write pm_SetItemIndex;
   property ShowFullPath: Boolean
     read f_ShowFullPath
     write f_ShowFullPath;
 end;//TFakeBoxPrim

//#UC START# *483158FD0155ci*
//#UC END# *483158FD0155ci*
//#UC START# *483158FD0155cit*
//#UC END# *483158FD0155cit*
 TFakeBox = {abstract} class(TFakeBoxPrim)
 private
 // private methods
   procedure CNKeyDown(var Message: TWMKeyDown); message CN_KEYDOWN;
   procedure WMChar(var Message: TWMChar); message WM_CHAR;
   procedure WMClear(var Msg: TMessage); message WM_CLEAR;
   procedure WMPaint(var Message: TMessage); message WM_PAINT;
   {$If not defined(DesignTimeLibrary)}
   procedure WMNCPaint(var Message: TMessage); message WM_NCPAINT;
   {$IfEnd} //not DesignTimeLibrary
   {$If not defined(DesignTimeLibrary)}
   procedure WMSetText(var Msg: TMessage); message WM_SETTEXT;
   {$IfEnd} //not DesignTimeLibrary
   procedure CMParentFontChanged(var Message: TMessage); message CM_PARENTFONTCHANGED;
//#UC START# *483158FD0155publ*
  property ErrorColor default clRed;
  property ItemIndex default -1;
//#UC END# *483158FD0155publ*
 end;//TFakeBox

implementation

uses
  SysUtils
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  ,
  ctTypes,
  l3Tree_TLB,
  afwFacade,
  ctFakeBoxStrings,
  l3Nodes,
  nevBase,
  Windows,
  DropDownTree
  {$If not defined(NoVCL)}
  ,
  Forms
  {$IfEnd} //not NoVCL
  ,
  l3String,
  l3Base
  {$If not defined(NoScripts)}
  ,
  vtComboBoxWordsPack
  {$IfEnd} //not NoScripts
  
  ;

type
  THackWinControl = {final} class(TWinControl)
  end;//THackWinControl

// start class TFakeBoxPrim

function TFakeBoxPrim.FindCurrent(const aText: Il3CString): Il3SimpleNode;
//#UC START# *53F47740011A_53FC907B01EC_var*
 function FindCurr(const aIterNode: Il3SimpleNode): boolean;
 begin//FindCurr
  Result := l3Same(aIterNode.Text, aText, true);
 end;//FindCurr
//#UC END# *53F47740011A_53FC907B01EC_var*
begin
//#UC START# *53F47740011A_53FC907B01EC_impl*
 Result := Tree.TreeStruct.SimpleIterateF(l3L2SNA(@FindCurr), imCheckResult);
//#UC END# *53F47740011A_53FC907B01EC_impl*
end;//TFakeBoxPrim.FindCurrent

function TFakeBoxPrim.DrawWithErrorColor: Boolean;
//#UC START# *53F45F5500CC_53FC907B01EC_var*
//#UC END# *53F45F5500CC_53FC907B01EC_var*
begin
//#UC START# *53F45F5500CC_53FC907B01EC_impl*
 case ComboStyle of
  ct_cbEdit:
   Result := not TextValid;
  else
   Result := State = esWrong;
 end;//case ComboStyle
//#UC END# *53F45F5500CC_53FC907B01EC_impl*
end;//TFakeBoxPrim.DrawWithErrorColor

function TFakeBoxPrim.IsNeedGotoNode(const aNode: Il3SimpleNode): Boolean;
//#UC START# *53F45F040009_53FC907B01EC_var*
var
 l_Temp: Il3SimpleNode;
//#UC END# *53F45F040009_53FC907B01EC_var*
begin
//#UC START# *53F45F040009_53FC907B01EC_impl*
 Result := True;
 l_Temp := Tree.GetCurrentNode;
 if Assigned(l_Temp) then
 try
  if l_Temp.IsSame(aNode) then
   Result := False;
 finally
  l_Temp := nil;
 end;
//#UC END# *53F45F040009_53FC907B01EC_impl*
end;//TFakeBoxPrim.IsNeedGotoNode

{$If not defined(DesignTimeLibrary)}
procedure TFakeBoxPrim.ShowNode(const aNode: Il3SimpleNode;
  TriggerSelect: Boolean = False);
//#UC START# *53F460C800DF_53FC907B01EC_var*
//#UC END# *53F460C800DF_53FC907B01EC_var*
begin
//#UC START# *53F460C800DF_53FC907B01EC_impl*
 if (aNode <> nil) then
 begin
  f_TempObjectCompleted := aNode;
  CurrentMode := CurrentMode + [cmSetCurrent];
  try
   ProcessTreeSelect(False, TriggerSelect);
  finally
   CurrentMode := CurrentMode - [cmSetCurrent];
  end;//try..finally
 end//aNode <> nil
 else
  Clear;
//#UC END# *53F460C800DF_53FC907B01EC_impl*
end;//TFakeBoxPrim.ShowNode
{$IfEnd} //not DesignTimeLibrary

{$If not defined(DesignTimeLibrary)}
function TFakeBoxPrim.FindIndexOf(const aNode: Il3SimpleNode): Integer;
//#UC START# *53F46100000A_53FC907B01EC_var*
var
  l_Count : Integer;

 function FindIndex(const aIterNode: Il3SimpleNode): boolean;
 begin//FindIndex
  Result := aIterNode.IsSame(aNode);
  Inc(l_Count);
 end;//FindIndex
//#UC END# *53F46100000A_53FC907B01EC_var*
begin
//#UC START# *53F46100000A_53FC907B01EC_impl*
 l_Count := -1;
 Result := -1;
 if Tree.TreeStruct.SimpleIterateF(l3L2SNA(@FindIndex), imCheckResult) <> nil then
  Result := l_Count;
//#UC END# *53F46100000A_53FC907B01EC_impl*
end;//TFakeBoxPrim.FindIndexOf
{$IfEnd} //not DesignTimeLibrary

procedure TFakeBoxPrim.SetSimpleTree(const aTree: Il3SimpleTree);
//#UC START# *53F4613C008E_53FC907B01EC_var*
//#UC END# *53F4613C008E_53FC907B01EC_var*
begin
//#UC START# *53F4613C008E_53FC907B01EC_impl*
 Tree.SetSimpleTree(aTree);
//#UC END# *53F4613C008E_53FC907B01EC_impl*
end;//TFakeBoxPrim.SetSimpleTree

procedure TFakeBoxPrim.LocalUpdateAction;
//#UC START# *52A9AAEA0068_53FC907B01EC_var*
//#UC END# *52A9AAEA0068_53FC907B01EC_var*
begin
//#UC START# *52A9AAEA0068_53FC907B01EC_impl*
//#UC END# *52A9AAEA0068_53FC907B01EC_impl*
end;//TFakeBoxPrim.LocalUpdateAction

function TFakeBoxPrim.DoCreateStrings: Tl3Strings;
//#UC START# *53F45F9F030D_53FC907B01EC_var*
//#UC END# *53F45F9F030D_53FC907B01EC_var*
begin
//#UC START# *53F45F9F030D_53FC907B01EC_impl*
 Assert(Self is TFakeBox);
 Result := TctFakeBoxStrings.Create(Self as TFakeBox);
//#UC END# *53F45F9F030D_53FC907B01EC_impl*
end;//TFakeBoxPrim.DoCreateStrings

function TFakeBoxPrim.IsValid: Boolean;
//#UC START# *53F460A302FE_53FC907B01EC_var*
//#UC END# *53F460A302FE_53FC907B01EC_var*
begin
//#UC START# *53F460A302FE_53FC907B01EC_impl*
 case ComboStyle of
  ct_cbEdit:
   Result := TextValid;
  else
   Result := True;
 end;//case ComboStyle
//#UC END# *53F460A302FE_53FC907B01EC_impl*
end;//TFakeBoxPrim.IsValid

{$If not defined(DesignTimeLibrary)}
function TFakeBoxPrim.IsLockPaint: Boolean;
//#UC START# *53F46070029D_53FC907B01EC_var*
//#UC END# *53F46070029D_53FC907B01EC_var*
begin
//#UC START# *53F46070029D_53FC907B01EC_impl*
 Result := afw.IsObjectLocked(Self);
//#UC END# *53F46070029D_53FC907B01EC_impl*
end;//TFakeBoxPrim.IsLockPaint
{$IfEnd} //not DesignTimeLibrary

procedure TFakeBoxPrim.DefilterTree;
//#UC START# *53F4601A00BD_53FC907B01EC_var*
{$IfNDef DesignTimeLibrary}
var
 l_Tree: Il3Tree;
 l_FilterableTree: Il3FilterableTree;
 l_SyncIndex: Integer;
{$EndIf DesignTimeLibrary}
//#UC END# *53F4601A00BD_53FC907B01EC_var*
begin
//#UC START# *53F4601A00BD_53FC907B01EC_impl*
{$IfNDef DesignTimeLibrary}
 if f_TreeIsFiltered then
 begin
  Il3ChangeRecipient(Tree).Changing;
  try
   if Supports(Tree.TreeStruct, Il3Tree, l_Tree) then
    if not Tree.TreeStruct.RootNode.IsSame(RootNode) then
     Tree.TreeStruct.RootNode := RootNode as Il3SimpleRootNode
    else
     l_Tree.SetAllFlag(sbDeselect, nfHidden)
   else
    if Supports(Tree.TreeStruct, Il3FilterableTree, l_FilterableTree) then
     Tree.TreeStruct := l_FilterableTree.MakeFiltered(l_FilterableTree.CloneFilters.SetContext(nil),
                                                      Tree.GetCurrentNode,
                                                      l_SyncIndex,
                                                      False);
  finally
   Il3ChangeRecipient(Tree).Changed;
  end;//try..finally
  f_TreeIsFiltered := False;
 end;//f_TreeIsFiltered
{$EndIf DesignTimeLibrary}
//#UC END# *53F4601A00BD_53FC907B01EC_impl*
end;//TFakeBoxPrim.DefilterTree

procedure TFakeBoxPrim.ActionExecuteHandler;
//#UC START# *52A9AADF0289_53FC907B01EC_var*
//#UC END# *52A9AADF0289_53FC907B01EC_var*
begin
//#UC START# *52A9AADF0289_53FC907B01EC_impl*
//#UC END# *52A9AADF0289_53FC907B01EC_impl*
end;//TFakeBoxPrim.ActionExecuteHandler

procedure TFakeBoxPrim.pm_SetTextValid(aValue: Boolean);
//#UC START# *53F45B29001D_53FC907B01ECset_var*
//#UC END# *53F45B29001D_53FC907B01ECset_var*
begin
//#UC START# *53F45B29001D_53FC907B01ECset_impl*
 Assert(ComboStyle = ct_cbEdit);
 if (f_TextValid <> aValue) and (ComboStyle = ct_cbEdit) then
 begin
  f_TextValid := aValue;
  SetTextColor(Canvas);
  SetFlag(ev_uwfBlock);
  Invalidate;
 end;//f_TextValid <> aValue
//#UC END# *53F45B29001D_53FC907B01ECset_impl*
end;//TFakeBoxPrim.pm_SetTextValid

{$If not defined(DesignTimeLibrary)}
function TFakeBoxPrim.pm_GetChoosenValue: Il3SimpleNode;
//#UC START# *53F45B880294_53FC907B01ECget_var*
//#UC END# *53F45B880294_53FC907B01ECget_var*
begin
//#UC START# *53F45B880294_53FC907B01ECget_impl*
 if (ComboStyle in [ct_cbDropDownList, ct_cbDropDown]) then
  Result := f_TempObjectCompleted
 else
  Result := nil;
//#UC END# *53F45B880294_53FC907B01ECget_impl*
end;//TFakeBoxPrim.pm_GetChoosenValue
{$IfEnd} //not DesignTimeLibrary

function TFakeBoxPrim.pm_GetItems: Tl3Strings;
//#UC START# *53F45BE201E1_53FC907B01ECget_var*
//#UC END# *53F45BE201E1_53FC907B01ECget_var*
begin
//#UC START# *53F45BE201E1_53FC907B01ECget_impl*
 Result := f_Items;
//#UC END# *53F45BE201E1_53FC907B01ECget_impl*
end;//TFakeBoxPrim.pm_GetItems

procedure TFakeBoxPrim.pm_SetItems(aValue: Tl3Strings);
//#UC START# *53F45BE201E1_53FC907B01ECset_var*
//#UC END# *53F45BE201E1_53FC907B01ECset_var*
begin
//#UC START# *53F45BE201E1_53FC907B01ECset_impl*
 f_Items.Assign(aValue);
//#UC END# *53F45BE201E1_53FC907B01ECset_impl*
end;//TFakeBoxPrim.pm_SetItems

procedure TFakeBoxPrim.pm_SetErrorColor(aValue: TColor);
//#UC START# *53F45C5001BD_53FC907B01ECset_var*
//#UC END# *53F45C5001BD_53FC907B01ECset_var*
begin
//#UC START# *53F45C5001BD_53FC907B01ECset_impl*
 if (f_ErrorColor <> aValue) then
 begin
  f_ErrorColor := aValue;
  Invalidate;
 end;//f_ErrorColor <> aValue
//#UC END# *53F45C5001BD_53FC907B01ECset_impl*
end;//TFakeBoxPrim.pm_SetErrorColor

function TFakeBoxPrim.pm_GetItemIndex: Integer;
//#UC START# *53F45C970310_53FC907B01ECget_var*
//#UC END# *53F45C970310_53FC907B01ECget_var*
begin
//#UC START# *53F45C970310_53FC907B01ECget_impl*
 Result := f_ItemIndex;
//#UC END# *53F45C970310_53FC907B01ECget_impl*
end;//TFakeBoxPrim.pm_GetItemIndex

procedure TFakeBoxPrim.pm_SetItemIndex(aValue: Integer);
//#UC START# *53F45C970310_53FC907B01ECset_var*
{$IfNDef DesignTimeLibrary}
var
 l_Node: Il3SimpleNode;
{$EndIf DesignTimeLibrary}
//#UC END# *53F45C970310_53FC907B01ECset_var*
begin
//#UC START# *53F45C970310_53FC907B01ECset_impl*
{$IfNDef DesignTimeLibrary}
 Inc(FRestrictOnTextChange);
 try
  Lock(Self);
  try
   if (aValue = -1) then
   begin
    Tree.SetNoCurrent;
    f_TempObjectCompleted := nil;
    Paras.ParagraphStrings[0] := nil;
    Repaint;
    f_ItemIndex := aValue;
    Exit;
   end;//aValue = -1

   if (f_Items.Count > 0) and (f_ItemIndex <> aValue) {and (f_RootNode <> nil)} and
      (aValue >= 0) and not Dropped{and (aValue < f_RootNode.AllChildrenCount)}{and IsList} then
   // условие о Dropped нужно, т.к. vcm'вских update'ах мне постоянно выставляют Itemindex
   // и если его убрать, в vcm'овских комбобоксах нельзя будет "ходить" кнопками
   begin
    f_IsFirstLoad := (f_ItemIndex = -1);
    MakeNodesFromItems;
    with Tree, Tree.TreeStruct do
    begin
     l_Node := GetNode(aValue);
     if Assigned(l_Node) then
      try
       GotoOnNode(l_Node);
       ProcessTreeSelect(True, True);
      finally
       l_Node := nil;
      end;//try..finally
     f_ItemIndex := aValue;
    end;//with Tree
    f_IsFirstLoad := False;
   end;//f_Items.Count > 0..
  finally
   Unlock(Self);
  end;//try..finally
 finally
  Dec(FRestrictOnTextChange);
 end;//try..finally
{$EndIf DesignTimeLibrary}
//#UC END# *53F45C970310_53FC907B01ECset_impl*
end;//TFakeBoxPrim.pm_SetItemIndex

procedure TFakeBoxPrim.Cleanup;
//#UC START# *479731C50290_53FC907B01EC_var*
//#UC END# *479731C50290_53FC907B01EC_var*
begin
//#UC START# *479731C50290_53FC907B01EC_impl*
 inherited;
 FreeAndNil(f_Items);
//#UC END# *479731C50290_53FC907B01EC_impl*
end;//TFakeBoxPrim.Cleanup

constructor TFakeBoxPrim.Create(AOwner: TComponent);
//#UC START# *47D1602000C6_53FC907B01EC_var*
//#UC END# *47D1602000C6_53FC907B01EC_var*
begin
//#UC START# *47D1602000C6_53FC907B01EC_impl*
 inherited Create(AOwner);
 FArrowsSelect := True;

 ComboStyle := ct_cbDropDown;

 f_Items := DoCreateStrings;
 ShowHint := True;

 f_NeedDropFiltering := False;
 f_NeedGotoNode := False;
 f_TabEaten := False;
 f_TreeIsFiltered := False;
 AutoSelect := False;
 f_SetToBeginOnTreeSelect := False;
 f_ErrorColor := clRed;
 f_TextValid := True;
 f_ShowFullPath := True;
//#UC END# *47D1602000C6_53FC907B01EC_impl*
end;//TFakeBoxPrim.Create

procedure TFakeBoxPrim.SetTextColor(const aCanvas: Il3Canvas);
//#UC START# *4831634B00FF_53FC907B01EC_var*
//#UC END# *4831634B00FF_53FC907B01EC_var*
begin
//#UC START# *4831634B00FF_53FC907B01EC_impl*
 inherited;
 if DrawWithErrorColor then
  aCanvas.Font.ForeColor := ErrorColor;
 if not Enabled then
 begin
  if (BorderStyle = bsNone) and (Parent <> nil) then
   aCanvas.Font.BackColor := THackWinControl(Parent).Color
  else
   aCanvas.Font.BackColor := clBtnFace;
  aCanvas.Font.ForeColor := clWindowText;
 end;//not Enabled
//#UC END# *4831634B00FF_53FC907B01EC_impl*
end;//TFakeBoxPrim.SetTextColor

procedure TFakeBoxPrim.pm_SetDropped(aValue: Boolean);
//#UC START# *53ECD12B0045_53FC907B01ECset_var*
{$IfNDef DesignTimeLibrary}
var
 l_Node: Il3SimpleNode;
{$EndIf}
//#UC END# *53ECD12B0045_53FC907B01ECset_var*
begin
//#UC START# *53ECD12B0045_53FC907B01ECset_impl*
{$IfNDef DesignTimeLibrary}
 if (FRestrictOnTextChange = 0) and (ComboStyle <> ct_cbEdit) then
 begin
  if (f_SetDroppedLock = 0) then
  begin
   Inc(f_SetDroppedLock);
   try
    if (aValue <> Dropped) then
    begin
     if aValue then
     begin
      if (Windows.GetFocus <> Self.Handle) then
        Windows.SetFocus(Self.Handle);
      if (f_Items.Count > 0) then
      begin
       MakeNodesFromItems;
       l_Node := FindCurrent(Text);
       if (l_Node <> nil) then
        Tree.GotoOnNode(l_Node);
      end//f_Items.Count > 0
      else
      if f_NeedDropFiltering and f_TreeIsFiltered then
      begin
       Tree.TreeStruct.Changing;
       try
        DefilterTree;
       finally
        Tree.TreeStruct.Changed;
       end;//try..finally
      end;//f_NeedDropFiltering
      if f_NeedGotoNode then
      begin
       Tree.GotoOnNode(f_TempObjectCompleted);
       f_NeedGotoNode := False;
      end;//f_NeedGotoNode
      CalcDropDimensions;
      // CalcDropDimensions нельзя ставить перед предыдущим блоком
     end//aValue
     else
     begin
     end;//aValue
    end;//aValue <> Dropped
    inherited;
   finally
    Dec(f_SetDroppedLock);
   end;//try..finally
  end;//f_SetDroppedLock = 0
 end;//ComboStyle <> cbEdit
{$EndIf}
//#UC END# *53ECD12B0045_53FC907B01ECset_impl*
end;//TFakeBoxPrim.pm_SetDropped

function TFakeBoxPrim.EstimateTreeHeight(aMinSize: Integer;
  aMaxSize: Integer): Integer;
//#UC START# *53EE09AA0268_53FC907B01EC_var*
//#UC END# *53EE09AA0268_53FC907B01EC_var*
begin
//#UC START# *53EE09AA0268_53FC907B01EC_impl*
{$IfNDef DesignTimeLibrary}
 Result := Tree.RowHeight * Tree.TreeStruct.CountView;
 if (Result > aMaxSize) then
  Result := aMaxSize
 else
 if (Result < aMinSize) then
  Result := aMinSize;
 Inc(Result, 4);
{$EndIf DesignTimeLibrary}
//#UC END# *53EE09AA0268_53FC907B01EC_impl*
end;//TFakeBoxPrim.EstimateTreeHeight

function TFakeBoxPrim.EstimateTreeWidth(aMaxSizeX: Integer;
  aSizeY: Integer): Integer;
//#UC START# *53EE09D70249_53FC907B01EC_var*
{$IfNDef DesignTimeLibrary}
var
 l_Width : Integer;
 l_Index : Integer;
{$EndIf  DesignTimeLibrary}
//#UC END# *53EE09D70249_53FC907B01EC_var*
begin
//#UC START# *53EE09D70249_53FC907B01EC_impl*
{$IfNDef DesignTimeLibrary}
 Result := Tree.GetMinSizeX;
 if (Tree.RowHeight > 0) then
  for l_Index := 0 to ((aSizeY - Tree.GetBorderSize ) div Tree.RowHeight) - 1 do
  begin
   l_Width := Tree.GetItemDim(l_Index).X;
   if l_Width > Result then
    Result := l_Width;
   if (l_Width > aMaxSizeX) and (aMaxSizeX>=0) then
   begin
    Result := aMaxSizeX;
    exit;
   end;//l_Width > aMaxSizeX..
  end;//for l_Index
 Result := Result + Tree.Width - Tree.ClientWidth + 2;
 // - видимо тут учитывается ширина скроллера
 if (Result > aMaxSizeX) and (aMaxSizeX>=0) then
  Result := aMaxSizeX;
{$EndIf  DesignTimeLibrary}
//#UC END# *53EE09D70249_53FC907B01EC_impl*
end;//TFakeBoxPrim.EstimateTreeWidth

procedure TFakeBoxPrim.ProcessTreeSelect(ChooseFromTree: Boolean;
  aTriggerSelect: Boolean);
//#UC START# *53EE0A730393_53FC907B01EC_var*
{$IfNDef DesignTimeLibrary} //morozov
var
  lNode  : Il3SimpleNode;
  l_Tree : Il3Tree;
  l_S    : Il3CString;
{$EndIf DesignTimeLibrary} //morozov
//#UC END# *53EE0A730393_53FC907B01EC_var*
begin
//#UC START# *53EE0A730393_53FC907B01EC_impl*
 {$IfNDef DesignTimeLibrary}
 Inc(FRestrictOnTextChange);
 try
  if ComboStyle <> ct_cbEdit then
  begin
   inherited;
   f_TabEaten := false;
   if ChooseFromTree then
   begin
    if (Tree.GetCurrentNode = nil) then
     exit;
    f_TempObjectCompleted := Tree.GetCurrentNode;
   end;//ChooseFromTree

   if ChooseFromTree or (cmSetCurrent in CurrentMode) or
      (cmClear in CurrentMode) or (cmVcmExecute in CurrentMode) then
   begin
    if (f_TempObjectCompleted <> nil) then
    begin
     if f_ShowFullPath then
      l_S := getFullPath(f_TempObjectCompleted)
     else
      l_S := l3CStr(f_TempObjectCompleted.Text);
     l3Replace(l_S, #10, l3PCharLen(#32));
     // - http://mdp.garant.ru/pages/viewpage.action?pageId=114065443&focusedCommentId=114065453#comment-114065453
     Paras.ParagraphStrings[0] := l_S;
     f_NeedGotoNode := IsNeedGotoNode(f_TempObjectCompleted);
     //if not f_NeedGotoNode then
      State := esCompleted;
    end//f_TempObjectCompleted <> nil
    else
     Paras.ParagraphStrings[0] := nil;
   end;//ChooseFromTree or

   DoUnselect;
   LocalUpdateAction;
   AdjustWidth;

   // в обычных комбобоксах скроллим вправо
   case ComboStyle of
    ct_cbDropDown:
     f_Border := TextLen;
    else
     f_Border := 0;
   end;//case ComboStyle

   DoMoveCursor(f_Border);
   DoSelect(f_Border, f_Border);
   InternalSetText(Text);
   SaveState;

   {/}
   if aTriggerSelect then
   begin
    if Assigned(f_OnSelect) then
     if not f_IsFirstLoad then
      ActionExecuteHandler;

    if IsList then
    begin
     if (f_TempObjectCompleted <> nil) then
      f_ItemIndex := FindIndexOf(f_TempObjectCompleted);
    end;//IsList
    // Раньше был прямой вызов DoChange
    // Но по ходу K-137463980 сильно потребовалось возможность давить вызов обработчика.
    Change;
   end;//aTriggerSelect
  end;//ComboStyle <> ct_cbEdit
  if SetToBeginOnTreeSelect then
   SelStart := 0
  else
   SelStart := TextLen;
  Repaint;
 finally
  Dec(FRestrictOnTextChange);
 end;//try..finally 
 {$EndIf DesignTimeLibrary}
//#UC END# *53EE0A730393_53FC907B01EC_impl*
end;//TFakeBoxPrim.ProcessTreeSelect

{$If not defined(NoVCL)}
procedure TFakeBoxPrim.DoEnter;
//#UC START# *53F45A560187_53FC907B01EC_var*
//#UC END# *53F45A560187_53FC907B01EC_var*
begin
//#UC START# *53F45A560187_53FC907B01EC_impl*
 inherited;
 if not ReadOnly then
 begin
  DoMoveCursor(TextLen);
  DoSelect(0, TextLen);
  Repaint;
 end;//not ReadOnly
//#UC END# *53F45A560187_53FC907B01EC_impl*
end;//TFakeBoxPrim.DoEnter
{$IfEnd} //not NoVCL

procedure TFakeBox.CNKeyDown(var Message: TWMKeyDown);
//#UC START# *53F4619402EA_483158FD0155_var*
var
 l_CurrentNode: Il3SimpleNode;
//#UC END# *53F4619402EA_483158FD0155_var*
begin
//#UC START# *53F4619402EA_483158FD0155_impl*
 afw.BeginOp;
 try
  try
   if (Message.CharCode = VK_DELETE) and (ComboStyle = ct_cbDropDown) then
    Dropped := False;

   if (Message.CharCode = VK_RETURN) then
   begin
    DoUnselect;
    Repaint;
    DoMoveCursor(TextLen);
   end;//Message.CharCode = VK_RETURN

   if (Message.CharCode = VK_TAB) then
   begin
    if (State = esCompleted) then
    begin
     inherited;
     Exit;
    end//State = esCompleted
    else
    if ((State = esSemiCompleted) or
        (State = esCompleted)) and
        not Selection.Collapsed
        then
    begin
     f_Border := TextLen;
     DoMoveCursor(f_Border);
     DoSelect(f_Border, f_Border);
     Repaint;
     Message.CharCode := 0;
     Message.Result := 1;
     Exit;
    end//State = esSemiCompleted..
    else
    if (State = esSemiCompleted) and
       Selection.Collapsed
       and not f_TabEaten then
    begin
     f_TabEaten := True;
     Message.CharCode := 0;
     Message.Result := 1;
     Exit;
    end//State = esSemiCompleted..
    else
      f_TabEaten := False; // хотя и при выходе, по идее это произойдёт
   end;//Message.CharCode = VK_TAB

   if (ComboStyle <> ct_cbEdit) and (not IsList) and
      ((Message.CharCode = VK_ADD) or (Message.CharCode = VK_SUBTRACT)) and
      (GetActiveSub is TSubTree) then
   begin
    if Dropped and (Tree.GetCurrentNode <> nil) then
    begin
     if (Message.CharCode = VK_ADD) then
      { нажали "+" }
      Tree.ExpandNode(Tree.GetCurrentNode, True)
     else
     begin
      { нажали "-" }
      if Tree.GetCurrentNode.HasChild then
       Tree.ExpandNode(Tree.GetCurrentNode, False)
      else
      begin
       l_CurrentNode := Tree.GetCurrentNode;
       try
        if Assigned(l_CurrentNode) and
         Assigned(l_CurrentNode.Parent) and
         not l_CurrentNode.Parent.IsSame(Tree.TreeStruct.RootNode) then
        begin
         Tree.ExpandNode(l_CurrentNode.Parent, False);
         Tree.GotoOnNode(l_CurrentNode);
        end;
       finally
        l_CurrentNode := nil;
       end;//try..finally
      end;//Tree.GetCurrentNode.HasChild
     end;//Message.CharCode = VK_ADD
    end;//Dropped

    Message.CharCode := 0;
    Message.Result := 1;

    CurrentMode:=CurrentMode+[cmKeyProhibited];
    Exit;
   end;//ComboStyle <> cbEdit..

   {$IfNDef DesignTimeLibrary}
   if (ComboStyle <> ct_cbEdit) and
      (Message.CharCode = VK_RETURN) then
   begin
    if Dropped then
    begin
     Dropped:=False;
     ProcessTreeSelect(True, True);
    end//Dropped
    else
    begin
     if (State = esCompleted) or (ComboStyle = ct_cbDropDown) then
      ProcessTreeSelect(False, True);
     // - здесь обрабатываем ShortCut'ы.
     inherited;
     Exit;
    end;//Dropped

    Message.CharCode := 0;
    Message.Result := 1;
    Exit;
   end;//ComboboxStyle <> cbEdit..
   {$EndIf DesignTimeLibrary}
   inherited;
  finally
   if Assigned(f_OnAfterProcessKeyDown) then
    f_OnAfterProcessKeyDown(Self);
  end;//try..finally
 finally
  afw.EndOp;
 end;//try..finally
//#UC END# *53F4619402EA_483158FD0155_impl*
end;//TFakeBox.CNKeyDown

procedure TFakeBox.WMChar(var Message: TWMChar);
//#UC START# *53F461AE02E8_483158FD0155_var*
//#UC END# *53F461AE02E8_483158FD0155_var*
begin
//#UC START# *53F461AE02E8_483158FD0155_impl*
 if not (cmKeyProhibited in CurrentMode) then
 begin
  inherited;
  if (ComboStyle = ct_cbDropDown) then
  begin
   if (Message.CharCode <> VK_BACK) and
      (Message.CharCode <> VK_DELETE) and
      (Message.CharCode <> VK_ESCAPE) then
    DropDownCompletion
   else
    Dropped := False;
  end;//ComboStyle = cbDropDown
 end//not (cmKeyProhibited in CurrentMode)
 else
  CurrentMode := CurrentMode - [cmKeyProhibited];
//#UC END# *53F461AE02E8_483158FD0155_impl*
end;//TFakeBox.WMChar

procedure TFakeBox.WMClear(var Msg: TMessage);
//#UC START# *53F461E0032F_483158FD0155_var*
//#UC END# *53F461E0032F_483158FD0155_var*
begin
//#UC START# *53F461E0032F_483158FD0155_impl*
 if not ReadOnly then
 begin
  Inc(FRestrictOnTextChange);
  try
   Text := nil;
  finally
   Dec(FRestrictOnTextChange);
  end;//try..finally
 end;//not ReadOnly
//#UC END# *53F461E0032F_483158FD0155_impl*
end;//TFakeBox.WMClear

procedure TFakeBox.WMPaint(var Message: TMessage);
//#UC START# *53F46277004F_483158FD0155_var*
{$IfNDef DesignTimeLibrary}
var
 PS: TPaintStruct;
{$EndIf DesignTimeLibrary}
//#UC END# *53F46277004F_483158FD0155_var*
begin
//#UC START# *53F46277004F_483158FD0155_impl*
 {$IfNDef DesignTimeLibrary}
 if not IsLockPaint then
  inherited
 else
 begin
  BeginPaint(Handle, PS);
  EndPaint(Handle, PS);
 end;//not IsLockPaint
 {$Else  DesignTimeLibrary}
 inherited;
 {$EndIf DesignTimeLibrary}
//#UC END# *53F46277004F_483158FD0155_impl*
end;//TFakeBox.WMPaint

{$If not defined(DesignTimeLibrary)}
procedure TFakeBox.WMNCPaint(var Message: TMessage);
//#UC START# *53F4628E039C_483158FD0155_var*
//#UC END# *53F4628E039C_483158FD0155_var*
begin
//#UC START# *53F4628E039C_483158FD0155_impl*
 if not IsLockPaint then
  inherited;
//#UC END# *53F4628E039C_483158FD0155_impl*
end;//TFakeBox.WMNCPaint
{$IfEnd} //not DesignTimeLibrary

{$If not defined(DesignTimeLibrary)}
procedure TFakeBox.WMSetText(var Msg: TMessage);
//#UC START# *53F462AF0296_483158FD0155_var*
var
 l_Node: Il3SimpleNode;
 l_OldCaretX: Integer;
//#UC END# *53F462AF0296_483158FD0155_var*
begin
//#UC START# *53F462AF0296_483158FD0155_impl*
 // сохраняем положение каретки в случае edit'ов. Из-за того, что в OnTest часто выставляется текст,
 // а в inherited CaretX выставится в 0
 if (ComboStyle = ct_cbEdit) then
 begin
  l_OldCaretX := CaretX;
  inherited;
  CaretX := l_OldCaretX;
 end//ComboStyle = cbEdit
 else
  inherited;
 InternalSetText(Text, CaretX); // поскольку вызов происходит очень нечасто (один раз?) - можно
 // как вариант - вытащить код из inherited сюда, не будет одной лишней перерисовки
 l_Node := nil;
 if (f_Items.Count > 0) then
 begin
  MakeNodesFromItems;
  l_Node := FindCurrent(Text);
  if (l_Node <> nil) then
   Tree.GotoOnNode(l_Node);
 end;//f_Items.Count > 0
 AdjustWidth;
 CurrentMode := CurrentMode + [cmWMSetText];
//#UC END# *53F462AF0296_483158FD0155_impl*
end;//TFakeBox.WMSetText
{$IfEnd} //not DesignTimeLibrary

procedure TFakeBox.CMParentFontChanged(var Message: TMessage);
//#UC START# *53F462D00123_483158FD0155_var*
//#UC END# *53F462D00123_483158FD0155_var*
begin
//#UC START# *53F462D00123_483158FD0155_impl*
 inherited;
 if (ComboStyle <> ct_cbEdit) then
  Tree.Font := Self.Font;
//#UC END# *53F462D00123_483158FD0155_impl*
end;//TFakeBox.CMParentFontChanged

//#UC START# *483158FD0155impl*
//#UC END# *483158FD0155impl*

initialization
{$If not defined(NoScripts)}
// Регистрация TFakeBoxPrim
 TtfwClassRef.Register(TFakeBoxPrim);
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// Регистрация TFakeBox
 TtfwClassRef.Register(TFakeBox);
{$IfEnd} //not NoScripts

end.