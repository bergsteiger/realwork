unit evDropCombo;

// Модуль: "w:\common\components\gui\Garant\Everest\qf\evDropCombo.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TevDropCombo" MUID: (48D399A20288)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
 l3IntfUses
 , evDropControl
 , evQueryCardInt
 , evQueryCardDropControlsInt
 , nevBase
 , l3Interfaces
 , l3TreeInterfaces
 , nevTools
;

type
 TEditableState = (
  esNone
  , esSemiCompleted
  , esCompleted
  , esWrong
 );//TEditableState

 TevDropCombo = class(TevDropControl, IevEditorFieldWithTree, IevDropCombo)
  private
   f_SelectedValue: InevSimpleNode;
    {* Выбранное пользователем значение }
   f_State: TEditableState;
    {* Состояние редактора }
   f_IsAsterisk: Boolean;
    {* Есть ли символ звездочки. Выставляется только для полей с признаком IsNumList! }
   f_IsAsteriskLastChar: Boolean;
    {* Символ звездочки - последний символ в тексте }
   f_ComboStyle: TevComboStyle;
   f_NeedAdd: Boolean;
   f_ItemCachedText: Il3CString;
    {* Текст выбранного значения (чтобы лишний раз не фильтровать дерево) }
   f_Tree: InevSimpleTree;
    {* Дерево реквизитов }
   f_TreeInit: Boolean;
    {* Дерево было загружено из реквизитов }
   f_RootNode: InevNode;
    {* Корневой узел }
   f_TreeIsFiltered: Boolean;
    {* Дерево было отфильтровано (чтобы не делать лишний раз Deselect Hidden) }
   f_Asterisk: AnsiChar;
    {* Символ звездочки }
   f_LastGoodContext: Il3CString;
   f_HistoryRoot: InevNode;
   f_PromptTree: InevSimpleTree;
   f_ShowHistoryList: Boolean;
   f_LockShowPrompts: Integer;
   f_SavedText: Il3CString;
   f_LockSaveText: Boolean;
   f_InputWithTree: Boolean;
    {* Режим ввода с выпадающим деревом }
  private
   function GetFullPath(const aNode: InevSimpleNode): Il3CString;
   procedure CheckAsterisk;
   function ComboReq: IevComboReq;
   procedure InitTree;
   function MakeNodesFromItems: Boolean;
   procedure ChangeDropTreeForHistory(ForHistory: Boolean);
   procedure SetRootNode(const Value: InevNode);
   procedure Change(const aView: InevView;
    const aPara: InevPara);
   procedure DefilterTree;
   procedure SetRoot(const aRoot: InevNode);
   procedure ChooseMean(NeedHide: Boolean);
   procedure FilterPromptTree;
   procedure FilterNewTree;
   function Filter(const aExpTree: Il3FilterableTree;
    const aContext: Il3CString;
    out anIndex: Integer;
    AutoOpen: Boolean;
    NeedRefilter: Boolean): Il3SimpleTree;
   procedure DoSetContextText(const aText: Il3CString);
  protected
   procedure SetNodeByIndex(aIndex: Integer);
   function GetNodeIndex(const aNode: InevSimpleNode): Integer;
    {* Возвращает номер узла. }
   procedure ShowNode(const aNode: InevSimpleNode);
    {* Отображает узел в поле. }
   function Get_Value: InevSimpleNode;
   function Get_IsAsterisk: Boolean;
   function Get_DefaultNode: InevSimpleNode;
   function Get_Asterisk: AnsiChar;
   procedure Set_Asterisk(aValue: AnsiChar);
   function Get_SourceTree: InevSimpleTree;
   function Get_ComboStyle: TevComboStyle;
   procedure Set_ComboStyle(aValue: TevComboStyle);
   function Get_LogicalState: Integer;
   procedure Set_LogicalState(aValue: Integer);
   function Get_Down: Boolean;
   procedure Set_Down(aValue: Boolean);
   procedure CheckTextVersusValue;
    {* Заточка на тот случай когда после Undo текст в контроле не совпадает
        с выбранной нодой - в этом случае очищаем все. }
   function GetNode(anIndex: Integer): InevSimpleNode;
    {* Возвращает узел. }
   procedure ChooseNode(const Value: InevSimpleNode;
    NeedHide: Boolean = True);
    {* Обработчик выбора узла в дереве при его закрытии. }
   function Get_IsList: Boolean;
   function NeedClearOnEscape: Boolean;
   procedure DoDrop(const aPoint: TPoint;
    AInvert: Boolean;
    AWidth: Integer;
    ByUser: Boolean); override;
    {* Вываливает выпадающий виджет по указанным координатам }
   function Get_IsLogicalStateButtonEnabled: Boolean;
   procedure SetMaskText(const aText: Il3CString);
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure SetText(const Value: Il3CString); override;
   procedure DoTextChange(const aView: InevView;
    const aPara: InevPara;
    const anOp: InevOp); override;
   procedure DoInsertRow(const aView: InevView); override;
   procedure AfterSetText(const Value: Il3CString); override;
   function GetSelectAllOnFocus: Boolean; override;
   procedure DoClearText; override;
   function DoAnalyzeString(const aValue: Il3CString;
    aPos: Integer;
    out aRslt: Il3CString): Boolean; override;
   procedure DoEscPressed; override;
   procedure DoDropDownCurrentChanged(const aNode: InevSimpleNode); override;
   procedure DoAfterHideControl; override;
   procedure DoSynchronizeSelectedValueWithText; override;
  public
   constructor Create(const aPara: InevPara); override;
 end;//TevDropCombo

implementation

uses
 l3ImplUses
 , SysUtils
 , l3Chars
 , evControlParaTools
 , l3String
 , l3Const
 , k2Tags
 {$If Defined(k2ForEditor)}
 , evParaTools
 {$IfEnd} // Defined(k2ForEditor)
 , l3Tree
 , l3Base
 , l3Nodes
 , evTextStyle_Const
 , l3Types
 {$If Defined(k2ForEditor)}
 , evTextParaTools
 {$IfEnd} // Defined(k2ForEditor)
 , evdTextStyle_Const
 , l3Tree_TLB
;

function TevDropCombo.GetFullPath(const aNode: InevSimpleNode): Il3CString;
//#UC START# *48D3A26202FD_48D399A20288_var*
//#UC END# *48D3A26202FD_48D399A20288_var*
begin
//#UC START# *48D3A26202FD_48D399A20288_impl*
 if (aNode = nil) then //пусть эта проверка будет. :-)
  Result := nil
 else
  Result := evGetFullPathStr(Get_SourceTree, aNode);
//#UC END# *48D3A26202FD_48D399A20288_impl*
end;//TevDropCombo.GetFullPath

procedure TevDropCombo.CheckAsterisk;
//#UC START# *48D3A3D800BB_48D399A20288_var*
var
 l_Pos  : Integer;
 l_Text : Il3Cstring;
//#UC END# *48D3A3D800BB_48D399A20288_var*
begin
//#UC START# *48D3A3D800BB_48D399A20288_impl*
 l_Text := Get_Caption;
 l_Pos := l3Pos(l_Text, f_Asterisk);
 if (l_Pos <> l3NotFound) then
 begin
  f_IsAsterisk := ComboReq.NeedAsterisk and (l_Pos <> l3NotFound);
  f_IsAsteriskLastChar := (l_Pos = l3Len(l_Text) - 1);
 end//l_Pos <> l3NotFound
 else
 begin
  f_IsAsterisk := false;
  f_IsAsteriskLastChar := false;
 end;//l_Pos <> l3NotFound
//#UC END# *48D3A3D800BB_48D399A20288_impl*
end;//TevDropCombo.CheckAsterisk

function TevDropCombo.ComboReq: IevComboReq;
//#UC START# *48D3A51B02F0_48D399A20288_var*
//#UC END# *48D3A51B02F0_48D399A20288_var*
begin
//#UC START# *48D3A51B02F0_48D399A20288_impl*
 Supports(Get_Req, IevComboReq, Result);
//#UC END# *48D3A51B02F0_48D399A20288_impl*
end;//TevDropCombo.ComboReq

procedure TevDropCombo.InitTree;
//#UC START# *48D3A67D02B2_48D399A20288_var*
{$IFDEF TEST_MODEL}
var
 l_Tree : Tl3Tree;
{$ENDIF TEST_MODEL}

 function Search(const anIntf: InevNode): Boolean;
 begin
  Result := l3Same(anIntf.Text, Get_Caption);
 end;

//#UC END# *48D3A67D02B2_48D399A20288_var*
begin
//#UC START# *48D3A67D02B2_48D399A20288_impl*
{$IFDEF TEST_MODEL}
 l_Tree := Tl3Tree.Create;
 try
  with l_Tree.RootNode do
  begin
   with InsertChild(MakeNode('Node 1')) do
   begin
    InsertChild(MakeNode('Child 1'));
    InsertChild(MakeNode('Child 2'));
   end;//with InsertChild(MakeNode('Node1'))
   InsertChild(MakeNode('Node 2'));   
  end;//with l_Tree.RootNode
  f_Tree := l_Tree;
 finally
  l3Free(l_Tree);
 end;//try..finally
{$ELSE}
 if ComboReq.IsContext then
 begin
  f_PromptTree := ComboReq.GetPromptTreeFromAdapter;
  MakeNodesFromItems;
  f_TreeInit := True;
 end//ComboReq.IsContext
 else
 begin
  f_Tree := ComboReq.GetTreeFromAdapter;
  f_LastGoodContext := nil;
  if (f_Tree <> nil) then
  begin
   f_TreeInit := True;
   f_TreeIsFiltered := True;
   DefilterTree;
  end//f_Tree <> nil
  else
  begin
   if MakeNodesFromItems then
    SetRootNode(f_HistoryRoot)
   else
   begin
    if Assigned(f_RootNode) then
     f_SelectedValue := f_RootNode.IterateF(l3L2NA(@Search), imOneLevel or imCheckResult)
    else
     f_SelectedValue := nil;
   end;//MakeNodesFromItems
   if f_SelectedValue = nil then
    DropContainer.Current := 0;
   f_TreeInit := (f_Tree <> nil);
  end;//f_Tree <> nil
 end;//ComboReq.IsContext 
{$ENDIF TEST_MODEL}
//#UC END# *48D3A67D02B2_48D399A20288_impl*
end;//TevDropCombo.InitTree

function TevDropCombo.MakeNodesFromItems: Boolean;
//#UC START# *48D3A6C30115_48D399A20288_var*
var
 i             : Integer;
 l_Root        : Tl3UsualNode;
 l_SubNode     : Tl3UsualNode;
 l_Count       : Integer;
 l_HistoryList : Il3StringsEx;
 l_Text        : string;
//#UC END# *48D3A6C30115_48D399A20288_var*
begin
//#UC START# *48D3A6C30115_48D399A20288_impl*
{$IFNDEF TEST_MODEL}
 Result := False;
 l_HistoryList := ComboReq.HistoryList;
 if (l_HistoryList = nil) OR (l_HistoryList.Items = nil) then
  Exit;
 l_Text := l_HistoryList.Items.Text;
 if not l3Same(f_ItemCachedText, l_Text) then
 begin
  f_SelectedValue := nil;
  Result := true;
  l_Root := Tl3UsualNode.Create;
  try
   l_Count := l_HistoryList.Count - 1;
   for i := 0 to l_Count do
   begin
    l_SubNode := Tl3UsualNode.Create;
    try
     l_SubNode.Text := l3PCharLen(l_HistoryList.ItemC[i]);
     if (f_SelectedValue = nil) and l3Same(l_HistoryList.ItemC[i], Get_Caption) then
      f_SelectedValue := l_SubNode;
     Il3Node(l_Root).InsertChild(l_SubNode);
    finally
     l3Free(l_SubNode);
    end;//try..finally
   end;//for i
   f_HistoryRoot := l_Root;
   f_ItemCachedText := l3CStr(l_Text);
  finally
   l3Free(l_Root);
  end;//try..finally
 end//not l3Same(f_ItemCachedText, l_Text)
{$ENDIF TEST_MODEL} 
//#UC END# *48D3A6C30115_48D399A20288_impl*
end;//TevDropCombo.MakeNodesFromItems

procedure TevDropCombo.ChangeDropTreeForHistory(ForHistory: Boolean);
//#UC START# *48D3A6D703E0_48D399A20288_var*
//#UC END# *48D3A6D703E0_48D399A20288_var*
begin
//#UC START# *48D3A6D703E0_48D399A20288_impl*
 if ForHistory then
 begin
  if DropContainer.Tree = f_PromptTree then
  begin
   f_Tree := nil;
   DropContainer.Tree := nil;
   DropContainer.DropTextStyle := evd_saGUI;
   DropContainer.AllowEmptyCurrent := False;
  end;
 end
 else
 begin
  if DropContainer.Tree <> f_PromptTree then
  begin
   f_Tree := f_PromptTree;
   DropContainer.Tree := f_PromptTree;
   DropContainer.DropTextStyle := ev_saPromptTree;
   DropContainer.AllowEmptyCurrent := True;
   DropContainer.Current := -1;
  end;
 end;
//#UC END# *48D3A6D703E0_48D399A20288_impl*
end;//TevDropCombo.ChangeDropTreeForHistory

procedure TevDropCombo.SetRootNode(const Value: InevNode);
//#UC START# *48D3A70201C8_48D399A20288_var*
//#UC END# *48D3A70201C8_48D399A20288_var*
begin
//#UC START# *48D3A70201C8_48D399A20288_impl*
 if (Value <> nil) and not Value.IsSame(f_RootNode) then 
 begin
  f_RootNode := Value;
  SetRoot(Value);
 end;//Value <> nil
//#UC END# *48D3A70201C8_48D399A20288_impl*
end;//TevDropCombo.SetRootNode

procedure TevDropCombo.Change(const aView: InevView;
 const aPara: InevPara);
//#UC START# *48D3A7710129_48D399A20288_var*

(* function FindCurrent(const aTree : InevSimpleTree;
                      const aText : Il3CString): Il3SimpleNode;

  function FindCurr(const aIterNode: Il3SimpleNode): boolean;
  begin//FindCurr
   Result := l3Same(aIterNode.Text, aText, true);
  end;//FindCurr

 begin
  if (aTree = nil) then
   Result := nil
  else
   Result := aTree.SimpleIterateF(l3L2SNA(@FindCurr), imCheckResult);
 end;*)

 procedure lp_SelectTail(aStartPos: Integer; aEndPos: Integer; const aSelection: InevSelection);
 var
  l_Start: InevBasePoint;
  l_End: InevBasePoint;
  l_StartMI: InevBasePoint;
  l_EndMI: InevBasePoint;
  l_View: InevView;
 begin//lp_SelectTail
  l_View := aSelection.View;
  Assert(aSelection.Point.MostInner.AsObject.IsSame(Self.Para.AsObject));
  // http://mdp.garant.ru/pages/viewpage.action?pageId=290952615
  // http://mdp.garant.ru/pages/viewpage.action?pageId=290951667&focusedCommentId=290953794#comment-290953794
  l_Start := aSelection.Point.ClonePoint(l_View);
  l_End := aSelection.Point.ClonePoint(l_View);
  l_StartMI := l_Start.MostInner;
  l_StartMI.PositionW := aStartPos;
  l_EndMI := l_End.MostInner;
  l_EndMI.PositionW := aEndPos;
  l_EndMI.SetAtEnd(l_View, True);
  aSelection.Select(Para.Range(l_StartMI, l_EndMI), false);
 end;//lp_SelectTail

var
 l_Text: Tl3PCharLen;
 l_Selection: InevSelection;
 l_EditorControl: InevControl;
 l_Editor: IevQueryCardEditor;

//#UC END# *48D3A7710129_48D399A20288_var*
begin
//#UC START# *48D3A7710129_48D399A20288_impl*
 if ComboReq.IsContext then
 begin
  if f_LockSaveText then
   Exit;
  f_SavedText := l3CStr(Get_Caption.AsWStr);
  if not f_TreeInit then
   InitTree;
  if Assigned(f_PromptTree) and not l3IsNil(Get_Caption) and (f_LockShowPrompts = 0) then
  begin
   FilterPromptTree;
   if Assigned(f_PromptTree) and (f_PromptTree.CountView > 0) then
   begin
    if DropContainer.IsDropTreeVisible and f_ShowHistoryList then
     CloseTree;
    f_ShowHistoryList := False;
    if not DropContainer.IsDropTreeVisible then
     DropDown(aView, aPara, False);
   end//Assigned(f_PromptTree)
   else
    CloseTree;
  end;//Assigned(f_PromptTree)
  if l3IsNil(Get_Caption) and not f_ShowHistoryList then
   CloseTree;
 end//ComboReq.IsContext
 else
 begin
  FilterNewTree;
  if f_IsAsterisk then
   Set_Valid(f_IsAsteriskLastChar)
  else
   Set_Valid(f_State <> esWrong);
  if (f_State = esWrong) then
  begin
   l_EditorControl := Get_Req.QueryCard.Editor;
   l_Selection := l_EditorControl.Selection;
   with l_Selection.Point.MostInner do
   begin
    l_Text := Para.AsObject.PCharLenA[k2_tiText];
    Supports(l_EditorControl, IevQueryCardEditor, l_Editor);
    Assert(Assigned(l_Editor));
    if (Position >= l_Text.SLen) or l_Editor.DroppingData then
    begin
     l_Editor.SignalDisableUnselectAfterDrop;
     lp_SelectTail(l3CommonPartLen(l3CStr(l_Text), f_LastGoodContext), l_Text.SLen, l_Selection);
     ComboReq.NotifyContextWrong;
    end;//Position >= l_Text.SLen
   end;//with l_Selection.Point.MostInner
  end//f_State = esWrong
  else
  if (f_State = esSemiCompleted) then
  begin
  // - ничего не надо, см. SynchronizeSelectedValueWithText
  // - иначе наступает рассинхронизация текста и данных
  // http://mdp.garant.ru/pages/viewpage.action?pageId=290952615
  // http://mdp.garant.ru/pages/viewpage.action?pageId=290951667&focusedCommentId=290953794#comment-290953794
//   f_SelectedValue := FindCurrent(f_Tree, Get_Caption);
(*   if not f_LockSaveText then
   begin
    if DropContainer.IsDropTreeVisible then
     CloseTree;
    if not DropContainer.IsDropTreeVisible then
     DropDown(aView, aPara, False);
    // - чтобы выбрать нужную ноду
   end;//not f_LockSaveText*)
  end;//f_State = esSemiCompleted
 end;//ComboReq.IsContext
 inherited;
//#UC END# *48D3A7710129_48D399A20288_impl*
end;//TevDropCombo.Change

procedure TevDropCombo.DefilterTree;
//#UC START# *48D3A9340213_48D399A20288_var*
{$IFNDEF TEST_MODEL}
var
 l_Tree    : InevTree;
 l_ExpTree : Il3FilterableTree;
 l_Index: Integer;
{$ENDIF TEST_MODEL}
//#UC END# *48D3A9340213_48D399A20288_var*
begin
//#UC START# *48D3A9340213_48D399A20288_impl*
{$IFNDEF TEST_MODEL}
 if f_TreeIsFiltered then
 begin
  if Supports(f_Tree, InevTree, l_Tree) then
   try
    if not f_Tree.RootNode.IsSame(f_RootNode) then
     f_Tree.RootNode := f_RootNode as Il3SimpleRootNode
    else
     l_Tree.SetAllFlag(sbDeselect, nfHidden)
   finally
    l_Tree := nil;
   end//try..finally
  else
  begin
   if Supports(f_Tree, Il3FilterableTree, l_ExpTree) then
    try
     f_Tree := Filter(l_ExpTree, nil, l_Index, false, False);
    finally
     l_ExpTree := nil;
    end;//try..finally
  end;
  f_TreeIsFiltered := False;
 end;//f_TreeIsFiltered
{$ENDIF TEST_MODEL}
//#UC END# *48D3A9340213_48D399A20288_impl*
end;//TevDropCombo.DefilterTree

procedure TevDropCombo.SetRoot(const aRoot: InevNode);
//#UC START# *48D3AC90019B_48D399A20288_var*
var
 l_Tree: InevTree;
//#UC END# *48D3AC90019B_48D399A20288_var*
begin
//#UC START# *48D3AC90019B_48D399A20288_impl*
 with DropContainer do
  if not IsSameTreeRoot(aRoot) then
  begin
   if f_Tree = nil then
    f_Tree := Tl3Tree.Make;
   if Supports(f_Tree, InevTree, l_Tree) then
    l_Tree.SetRootAndCountView(aRoot as InevRootNode, l3_DelayedCountView)
   else
    f_Tree.RootNode := aRoot as Il3SimpleRootNode;
   f_TreeIsFiltered := False;
  end;//not IsSameTreeRoot(aRoot)
//#UC END# *48D3AC90019B_48D399A20288_impl*
end;//TevDropCombo.SetRoot

procedure TevDropCombo.ChooseMean(NeedHide: Boolean);
//#UC START# *48D3ACC90036_48D399A20288_var*
//#UC END# *48D3ACC90036_48D399A20288_var*
begin
//#UC START# *48D3ACC90036_48D399A20288_impl*
 if f_InputWithTree and (not l3IsNil(Get_Caption)) then
  ChooseNode(DropContainer.GetCurrentNode, NeedHide);
//#UC END# *48D3ACC90036_48D399A20288_impl*
end;//TevDropCombo.ChooseMean

procedure TevDropCombo.FilterPromptTree;
//#UC START# *48D3AEF40349_48D399A20288_var*
var
 l_FilterableTree : Il3FilterableTree;
 l_SyncIndex      : Integer;
//#UC END# *48D3AEF40349_48D399A20288_var*
begin
//#UC START# *48D3AEF40349_48D399A20288_impl*
 if Supports(f_PromptTree, Il3FilterableTree, l_FilterableTree) then
 begin
  f_PromptTree := l_FilterableTree.MakeFiltered(l_FilterableTree.
                                                CloneFilters.
                                                SetContext(Get_Caption),
                                                nil,
                                                l_SyncIndex);
  ChangeDropTreeForHistory(False);
  f_RootNode := nil;
 end//if Supports(f_PromptTree, Il3FilterableTree, l_FilterableTree)
//#UC END# *48D3AEF40349_48D399A20288_impl*
end;//TevDropCombo.FilterPromptTree

procedure TevDropCombo.FilterNewTree;
//#UC START# *48D3AF010084_48D399A20288_var*
var
 l_ExpTree : Il3FilterableTree;
 l_Index   : Integer;
 l_Tree    : Il3SimpleTree;
 l_NeedCalcNewFilter: Boolean;
//#UC END# *48D3AF010084_48D399A20288_var*
begin
//#UC START# *48D3AF010084_48D399A20288_impl*
 f_TreeIsFiltered := not l3IsNil(Get_Caption);
 with DropContainer do
  if Supports(Tree, Il3FilterableTree, l_ExpTree) then
  try
   if not Assigned(f_LastGoodContext) then
   begin
    l_Tree := Filter(l_ExpTree, Get_Caption, l_Index, True, True);
    Supports(l_Tree, Il3FilterableTree, l_ExpTree);
    f_LastGoodContext := l_ExpTree.CloneFilters.Context;
    Assert(Assigned(l_ExpTree));
    Tree := l_Tree;
   end;
   l_Tree := Filter(l_ExpTree, Get_Caption, l_Index, True, False);
   try
    if (l_Tree.CountView > 0) then
    begin
     f_LastGoodContext := l3CStr(Get_Caption.AsWStr);
     Tree := l_Tree;
     if (l_Index >= 0) then
      Current := l_Index;
     if (Tree.CountView = 1) then
      f_State := esCompleted
     else
      f_State := esSemiCompleted;
    end//Tree.CountView > 0
    else
     f_State := esWrong;
   finally
    l_Tree := nil;
   end;//try..finally
  finally
   l_ExpTree := nil;
  end;//try..finally
//#UC END# *48D3AF010084_48D399A20288_impl*
end;//TevDropCombo.FilterNewTree

function TevDropCombo.Filter(const aExpTree: Il3FilterableTree;
 const aContext: Il3CString;
 out anIndex: Integer;
 AutoOpen: Boolean;
 NeedRefilter: Boolean): Il3SimpleTree;
//#UC START# *48D3AF180338_48D399A20288_var*
//#UC END# *48D3AF180338_48D399A20288_var*
begin
//#UC START# *48D3AF180338_48D399A20288_impl*
 Result := aExpTree.MakeFiltered(aExpTree.CloneFilters.SetContext(aContext),
                                 nil,
                                 anIndex,
                                 AutoOpen,
                                 NeedRefilter);
//#UC END# *48D3AF180338_48D399A20288_impl*
end;//TevDropCombo.Filter

procedure TevDropCombo.DoSetContextText(const aText: Il3CString);
//#UC START# *48D3B15501B0_48D399A20288_var*
//#UC END# *48D3B15501B0_48D399A20288_var*
begin
//#UC START# *48D3B15501B0_48D399A20288_impl*
 if not l3Same(Get_Caption, aText) then
  SetText(aText);
//#UC END# *48D3B15501B0_48D399A20288_impl*
end;//TevDropCombo.DoSetContextText

procedure TevDropCombo.SetNodeByIndex(aIndex: Integer);
//#UC START# *47CD7C460280_48D399A20288_var*
//#UC END# *47CD7C460280_48D399A20288_var*
begin
//#UC START# *47CD7C460280_48D399A20288_impl*
 if Get_SourceTree.ShowRoot then
  ShowNode(Get_SourceTree.Nodes[aIndex + 1])
 else
  ShowNode(Get_SourceTree.Nodes[aIndex]);
//#UC END# *47CD7C460280_48D399A20288_impl*
end;//TevDropCombo.SetNodeByIndex

function TevDropCombo.GetNodeIndex(const aNode: InevSimpleNode): Integer;
 {* Возвращает номер узла. }
//#UC START# *47CD7C53028D_48D399A20288_var*
//#UC END# *47CD7C53028D_48D399A20288_var*
begin
//#UC START# *47CD7C53028D_48D399A20288_impl*
 Result := f_Tree.GetIndex(aNode);
//#UC END# *47CD7C53028D_48D399A20288_impl*
end;//TevDropCombo.GetNodeIndex

procedure TevDropCombo.ShowNode(const aNode: InevSimpleNode);
 {* Отображает узел в поле. }
//#UC START# *47CD7C6C0211_48D399A20288_var*
//#UC END# *47CD7C6C0211_48D399A20288_var*
begin
//#UC START# *47CD7C6C0211_48D399A20288_impl*
 if (aNode <> f_SelectedValue) then
 begin
  f_SelectedValue := aNode;
  f_State := esCompleted; //Именно это значение, т.к. будет UpdateState с
  Set_Valid(True);
  //вызовом Value
  if aNode <> nil then
   SetText(GetFullPath(aNode));
 end;//aNode <> f_SelectedValue
//#UC END# *47CD7C6C0211_48D399A20288_impl*
end;//TevDropCombo.ShowNode

function TevDropCombo.Get_Value: InevSimpleNode;
//#UC START# *47CD7C8200EF_48D399A20288get_var*
//#UC END# *47CD7C8200EF_48D399A20288get_var*
begin
//#UC START# *47CD7C8200EF_48D399A20288get_impl*
 if ((Get_ComboStyle = ev_cbFilterable) and ((f_State = esCompleted) or
   (f_State = esSemiCompleted))) then
  Result := f_SelectedValue
 else
  Result := nil;
//#UC END# *47CD7C8200EF_48D399A20288get_impl*
end;//TevDropCombo.Get_Value

function TevDropCombo.Get_IsAsterisk: Boolean;
//#UC START# *47CD7C9601D6_48D399A20288get_var*
//#UC END# *47CD7C9601D6_48D399A20288get_var*
begin
//#UC START# *47CD7C9601D6_48D399A20288get_impl*
 CheckAsterisk;
 Result := f_IsAsterisk;
//#UC END# *47CD7C9601D6_48D399A20288get_impl*
end;//TevDropCombo.Get_IsAsterisk

function TevDropCombo.Get_DefaultNode: InevSimpleNode;
//#UC START# *47CD7CA301A9_48D399A20288get_var*
var
 l_Req : IevReq;
//#UC END# *47CD7CA301A9_48D399A20288get_var*
begin
//#UC START# *47CD7CA301A9_48D399A20288get_impl*
 l_Req := Get_Req;
 if (l_Req = nil) then
  Result := nil
 else
  Supports(l_Req.Para.AsObject.Attr[k2_tiDefaultNode], InevSimpleNode, Result);
//#UC END# *47CD7CA301A9_48D399A20288get_impl*
end;//TevDropCombo.Get_DefaultNode

function TevDropCombo.Get_Asterisk: AnsiChar;
//#UC START# *47CD7CB7026F_48D399A20288get_var*
//#UC END# *47CD7CB7026F_48D399A20288get_var*
begin
//#UC START# *47CD7CB7026F_48D399A20288get_impl*
 Result := f_Asterisk;
//#UC END# *47CD7CB7026F_48D399A20288get_impl*
end;//TevDropCombo.Get_Asterisk

procedure TevDropCombo.Set_Asterisk(aValue: AnsiChar);
//#UC START# *47CD7CB7026F_48D399A20288set_var*
//#UC END# *47CD7CB7026F_48D399A20288set_var*
begin
//#UC START# *47CD7CB7026F_48D399A20288set_impl*
 f_Asterisk := aValue;
//#UC END# *47CD7CB7026F_48D399A20288set_impl*
end;//TevDropCombo.Set_Asterisk

function TevDropCombo.Get_SourceTree: InevSimpleTree;
//#UC START# *47CD7CD10203_48D399A20288get_var*
//#UC END# *47CD7CD10203_48D399A20288get_var*
begin
//#UC START# *47CD7CD10203_48D399A20288get_impl*
 if not f_TreeInit then 
  InitTree;
 Result := f_Tree;
//#UC END# *47CD7CD10203_48D399A20288get_impl*
end;//TevDropCombo.Get_SourceTree

function TevDropCombo.Get_ComboStyle: TevComboStyle;
//#UC START# *47CD7CEE0396_48D399A20288get_var*
//#UC END# *47CD7CEE0396_48D399A20288get_var*
begin
//#UC START# *47CD7CEE0396_48D399A20288get_impl*
 Result := f_ComboStyle;
//#UC END# *47CD7CEE0396_48D399A20288get_impl*
end;//TevDropCombo.Get_ComboStyle

procedure TevDropCombo.Set_ComboStyle(aValue: TevComboStyle);
//#UC START# *47CD7CEE0396_48D399A20288set_var*
//#UC END# *47CD7CEE0396_48D399A20288set_var*
begin
//#UC START# *47CD7CEE0396_48D399A20288set_impl*
 f_ComboStyle := aValue;
//#UC END# *47CD7CEE0396_48D399A20288set_impl*
end;//TevDropCombo.Set_ComboStyle

function TevDropCombo.Get_LogicalState: Integer;
//#UC START# *47CD7CFB0250_48D399A20288get_var*
var
 l_Control : IevEditorControl;
 l_BTN     : IevEditorStateButton;
//#UC END# *47CD7CFB0250_48D399A20288get_var*
begin
//#UC START# *47CD7CFB0250_48D399A20288get_impl*
 Result := 0;
 l_Control := FindButton(ev_btLogical);
 if (l_Control <> nil) and
  Supports(l_Control, IevEditorStateButton, l_BTN) then
  try
   Result := l_BTN.GetStateIndex;
  finally
   l_Control := nil;
  end;
//#UC END# *47CD7CFB0250_48D399A20288get_impl*
end;//TevDropCombo.Get_LogicalState

procedure TevDropCombo.Set_LogicalState(aValue: Integer);
//#UC START# *47CD7CFB0250_48D399A20288set_var*
var
 l_Control : IevEditorControl;
 l_BTN     : IevEditorStateButton;
//#UC END# *47CD7CFB0250_48D399A20288set_var*
begin
//#UC START# *47CD7CFB0250_48D399A20288set_impl*
 l_Control := FindButton(ev_btLogical);
 if Supports(l_Control, IevEditorStateButton, l_BTN) then
  try
   Assert((aValue >= 0) or (aValue <= l_BTN.StateCount), 'Неподдерживаемое логическое значение!');
   l_BTN.CurrentIndex := l_BTN.ImageIndex + aValue;
  finally
   l_Control := nil;
  end;
//#UC END# *47CD7CFB0250_48D399A20288set_impl*
end;//TevDropCombo.Set_LogicalState

function TevDropCombo.Get_Down: Boolean;
//#UC START# *47CD7D0700F5_48D399A20288get_var*
//#UC END# *47CD7D0700F5_48D399A20288get_var*
begin
//#UC START# *47CD7D0700F5_48D399A20288get_impl*
 Result := inherited Get_Down;
//#UC END# *47CD7D0700F5_48D399A20288get_impl*
end;//TevDropCombo.Get_Down

procedure TevDropCombo.Set_Down(aValue: Boolean);
//#UC START# *47CD7D0700F5_48D399A20288set_var*
//#UC END# *47CD7D0700F5_48D399A20288set_var*
begin
//#UC START# *47CD7D0700F5_48D399A20288set_impl*
 inherited Set_Down(aValue);
//#UC END# *47CD7D0700F5_48D399A20288set_impl*
end;//TevDropCombo.Set_Down

procedure TevDropCombo.CheckTextVersusValue;
 {* Заточка на тот случай когда после Undo текст в контроле не совпадает
        с выбранной нодой - в этом случае очищаем все. }
//#UC START# *47CD9A1B00EC_48D399A20288_var*
var
 l_Node: InevSimpleNode;
//#UC END# *47CD9A1B00EC_48D399A20288_var*
begin
//#UC START# *47CD9A1B00EC_48D399A20288_impl*
 l_Node := Get_Value;
 if (Get_ComboStyle = ev_cbFilterable) and not l3Same(GetFullPath(l_Node), Get_Caption) then
 begin
  evDir_DeleteText(Para as InevTextPara, 0, MaxInt);
  f_State := esNone;
  Set_Valid(True);
  Set_ErrorColor(False);
  f_SelectedValue := nil;
 end;//Get_ComboStyle = ev_cbFilterable
//#UC END# *47CD9A1B00EC_48D399A20288_impl*
end;//TevDropCombo.CheckTextVersusValue

function TevDropCombo.GetNode(anIndex: Integer): InevSimpleNode;
 {* Возвращает узел. }
//#UC START# *47CEA0C8006E_48D399A20288_var*
//#UC END# *47CEA0C8006E_48D399A20288_var*
begin
//#UC START# *47CEA0C8006E_48D399A20288_impl*
 if DropContainer.IsDropTreeVisible then
  Result := DropContainer.GetDropTreeNode(anIndex)
 else
   Result := f_Tree.Nodes[anIndex];    
//#UC END# *47CEA0C8006E_48D399A20288_impl*
end;//TevDropCombo.GetNode

procedure TevDropCombo.ChooseNode(const Value: InevSimpleNode;
 NeedHide: Boolean = True);
 {* Обработчик выбора узла в дереве при его закрытии. }
//#UC START# *47CEA0D903B6_48D399A20288_var*
var
 l_Op : InevOp;
//#UC END# *47CEA0D903B6_48D399A20288_var*
begin
//#UC START# *47CEA0D903B6_48D399A20288_impl*
 with Get_Req.QueryCard do
 begin
  l_Op := GetDocumentContainer.Processor.StartOp;
  Inc(f_LockShowPrompts);
  try
   f_SelectedValue := Value;
   f_State := esCompleted;
   if (Value <> nil) and not f_IsAsterisk then
   begin
    SetText(GetFullPath(Value));
    f_SavedText := Get_Caption;
    if not Get_ErrorColor then
     Set_Valid(True);
    Get_Req.SetFocus(Self, True);
   end;
   if NeedHide then
   begin
    DropContainer.EscPressed := True;
    try
     HideControl;
    finally
     DropContainer.EscPressed := False;
    end;//try..finally
   end;//NeedHide
   Get_Req.UpdateState(Self, nil);
  finally
   l_Op := nil;
   Dec(f_LockShowPrompts);
  end;//try..finally
 end;//with Get_Req.QueryCard
//#UC END# *47CEA0D903B6_48D399A20288_impl*
end;//TevDropCombo.ChooseNode

function TevDropCombo.Get_IsList: Boolean;
//#UC START# *47CEA0F901D9_48D399A20288get_var*
var
 l_Req : IevReq;
//#UC END# *47CEA0F901D9_48D399A20288get_var*
begin
//#UC START# *47CEA0F901D9_48D399A20288get_impl*
 l_Req := Get_Req;
 if (l_Req = nil) then
  Result := false
 else
  Result := l_Req.Para.AsObject.BoolA[k2_tiNumList];
//#UC END# *47CEA0F901D9_48D399A20288get_impl*
end;//TevDropCombo.Get_IsList

function TevDropCombo.NeedClearOnEscape: Boolean;
//#UC START# *486C75F002CD_48D399A20288_var*
//#UC END# *486C75F002CD_48D399A20288_var*
begin
//#UC START# *486C75F002CD_48D399A20288_impl*
 if ComboReq.IsContext then
  Result := False
 else
  Result := ((not l3IsNil(Get_Caption)) and (Get_Value = nil));
//#UC END# *486C75F002CD_48D399A20288_impl*
end;//TevDropCombo.NeedClearOnEscape

procedure TevDropCombo.DoDrop(const aPoint: TPoint;
 AInvert: Boolean;
 AWidth: Integer;
 ByUser: Boolean);
 {* Вываливает выпадающий виджет по указанным координатам }
//#UC START# *48D37D66029A_48D399A20288_var*

function FindCurrent(const aTree : InevSimpleTree;
                     const aText : Il3CString): Il3SimpleNode;

 function FindCurr(const aIterNode: Il3SimpleNode): boolean;
 begin//FindCurr
  Result := l3Same(aIterNode.Text, aText, true);
 end;//FindCurr

begin
 if (aTree = nil) then
  Result := nil
 else
  Result := aTree.SimpleIterateF(l3L2SNA(@FindCurr), imCheckResult);
end;

//#UC END# *48D37D66029A_48D399A20288_var*
begin
//#UC START# *48D37D66029A_48D399A20288_impl*
 f_LastGoodContext := nil;
 f_InputWithTree := False;
 if ComboReq.IsContext then
 begin
  if byUser then
   f_ShowHistoryList := True;
   if f_ShowHistoryList then
   begin
    MakeNodesFromItems;
    ChangeDropTreeForHistory(True);
    SetRootNode(f_HistoryRoot);
    f_SelectedValue := FindCurrent(f_Tree, Get_Caption);
   end
   else
   begin
    ChangeDropTreeForHistory(False);
    f_RootNode := nil;
   end;
 end
 else
 begin
  DropContainer.DropTextStyle := evd_saGUI;
  DropContainer.AllowEmptyCurrent := False;
 end;
 DropContainer.DoDrop(aPoint, AInvert, AWidth, ByUser);
 if not ComboReq.IsContext or f_ShowHistoryList then
  if (f_SelectedValue <> nil) and not f_IsAsterisk then
   DropContainer.Current := f_Tree.GetIndex(f_SelectedValue);
 inherited;
//#UC END# *48D37D66029A_48D399A20288_impl*
end;//TevDropCombo.DoDrop

function TevDropCombo.Get_IsLogicalStateButtonEnabled: Boolean;
//#UC START# *50F01D1902E4_48D399A20288get_var*
var
 l_Control : IevEditorControl;
 l_BTN     : IevEditorStateButton;
//#UC END# *50F01D1902E4_48D399A20288get_var*
begin
//#UC START# *50F01D1902E4_48D399A20288get_impl*
 Result := False;
 l_Control := FindButton(ev_btLogical);
 if (l_Control <> nil) and
  Supports(l_Control, IevEditorStateButton, l_BTN) then
  try
   Result := l_BTN.Enabled;
  finally
   l_Control := nil;
  end;
//#UC END# *50F01D1902E4_48D399A20288get_impl*
end;//TevDropCombo.Get_IsLogicalStateButtonEnabled

procedure TevDropCombo.SetMaskText(const aText: Il3CString);
//#UC START# *54E2F4B6034D_48D399A20288_var*
//#UC END# *54E2F4B6034D_48D399A20288_var*
begin
//#UC START# *54E2F4B6034D_48D399A20288_impl*
 inherited SetText(aText);
 // - http://mdp.garant.ru/pages/viewpage.action?pageId=588810734
 // Чтобы не было поиска ноды с совпадающим текстом,
 // ибо в случае с маской её скорее всего не будет, а перебрать может
 // потребоваться немало 
//#UC END# *54E2F4B6034D_48D399A20288_impl*
end;//TevDropCombo.SetMaskText

procedure TevDropCombo.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_48D399A20288_var*
//#UC END# *479731C50290_48D399A20288_var*
begin
//#UC START# *479731C50290_48D399A20288_impl*
 f_ItemCachedText := nil;
 f_SelectedValue := nil;
 f_RootNode := nil;
 f_Tree := nil;
 f_LastGoodContext := nil;
 f_HistoryRoot := nil;
 f_PromptTree := nil;
 f_SavedText := nil;
 inherited;
//#UC END# *479731C50290_48D399A20288_impl*
end;//TevDropCombo.Cleanup

constructor TevDropCombo.Create(const aPara: InevPara);
//#UC START# *47CFE07602FE_48D399A20288_var*
//#UC END# *47CFE07602FE_48D399A20288_var*
begin
//#UC START# *47CFE07602FE_48D399A20288_impl*
 inherited;
 f_ComboStyle := ev_cbFilterable;
 f_Asterisk := #0;
 f_IsAsterisk := False;
 f_IsAsteriskLastChar := False;
//#UC END# *47CFE07602FE_48D399A20288_impl*
end;//TevDropCombo.Create

procedure TevDropCombo.SetText(const Value: Il3CString);
//#UC START# *48D148F7020F_48D399A20288_var*
//#UC END# *48D148F7020F_48D399A20288_var*
begin
//#UC START# *48D148F7020F_48D399A20288_impl*
 inherited SetText(Value);
 // это нужно для того, чтобы в DropCombo можно было присваивать текст.
 // K: 371630544
 if Value <> nil then
  DoSynchronizeSelectedValueWithText;
//#UC END# *48D148F7020F_48D399A20288_impl*
end;//TevDropCombo.SetText

procedure TevDropCombo.DoTextChange(const aView: InevView;
 const aPara: InevPara;
 const anOp: InevOp);
//#UC START# *48D14C0E023E_48D399A20288_var*
var
 l_Cap : Il3CString;
//#UC END# *48D14C0E023E_48D399A20288_var*
begin
//#UC START# *48D14C0E023E_48D399A20288_impl*
 if l3IsNil(Get_Caption) then
  f_SelectedValue := nil;
 if f_NeedAdd then 
 begin
  f_NeedAdd := false;
  Get_Req.AddField(aView, True);
 end//f_NeedAdd 
 else
 if ComboReq.IsContext then
 begin
  if not Get_Req.QueryCard.InsertRowMode then
   Change(aView, aPara);
 end
 else
 if f_ComboStyle <> ev_cbDropDown then
  if not Get_Req.QueryCard.InsertRowMode then
  begin
   with DropContainer do
   begin
    if not IsDropTreeVisible then
    begin
     DropDown(aView, aPara, False);
     // http://mdp.garant.ru/pages/viewpage.action?pageId=227478809&focusedCommentId=227967079#comment-227967079
     // Старый код:
(*     if not l3IsNil(Get_Caption) then
      f_SelectedValue := nil;*)
     // Новый код:
     l_Cap := Get_Caption;
     if l3IsNil(l_Cap) then
      f_SelectedValue := nil
     else
     if (f_SelectedValue <> nil) then
      if not l3Same(l_Cap, f_SelectedValue.Text) then
       f_SelectedValue := nil;
     f_InputWithTree := True; //Именно здесь, т.к. в предыдущем вызове флаг обнуляется
    end;//not IsDropTreeVisible
    CheckAsterisk;
    Change(aView, aPara);
   end;//with DropContainer
  end;//not Get_Req.QueryCard.InsertRowMode
 inherited; 
//#UC END# *48D14C0E023E_48D399A20288_impl*
end;//TevDropCombo.DoTextChange

procedure TevDropCombo.DoInsertRow(const aView: InevView);
//#UC START# *48D14FA70154_48D399A20288_var*
//#UC END# *48D14FA70154_48D399A20288_var*
begin
//#UC START# *48D14FA70154_48D399A20288_impl*
 Get_Req.AddField(aView, True);
//#UC END# *48D14FA70154_48D399A20288_impl*
end;//TevDropCombo.DoInsertRow

procedure TevDropCombo.AfterSetText(const Value: Il3CString);
//#UC START# *48D247CA0077_48D399A20288_var*
//#UC END# *48D247CA0077_48D399A20288_var*
begin
//#UC START# *48D247CA0077_48D399A20288_impl*
 Get_Req.AfterSetText(Self);
 inherited;
//#UC END# *48D247CA0077_48D399A20288_impl*
end;//TevDropCombo.AfterSetText

function TevDropCombo.GetSelectAllOnFocus: Boolean;
//#UC START# *48D249F00054_48D399A20288_var*
//#UC END# *48D249F00054_48D399A20288_var*
begin
//#UC START# *48D249F00054_48D399A20288_impl*
 Result := not ComboReq.IsContext and inherited GetSelectAllOnFocus;
//#UC END# *48D249F00054_48D399A20288_impl*
end;//TevDropCombo.GetSelectAllOnFocus

procedure TevDropCombo.DoClearText;
//#UC START# *48D24C9F02F5_48D399A20288_var*
var
 l_DN : InevSimpleNode;
//#UC END# *48D24C9F02F5_48D399A20288_var*
begin
//#UC START# *48D24C9F02F5_48D399A20288_impl*
 inherited;
 f_SelectedValue := nil;
 l_DN := Get_DefaultNode;
 if (l_DN <> nil) then
  ShowNode(l_DN);
//#UC END# *48D24C9F02F5_48D399A20288_impl*
end;//TevDropCombo.DoClearText

function TevDropCombo.DoAnalyzeString(const aValue: Il3CString;
 aPos: Integer;
 out aRslt: Il3CString): Boolean;
//#UC START# *48D24F5F02BF_48D399A20288_var*

const
 cZ = cc_Austerisk;
 
  function WasAteriks: Boolean;
  var
   l_Text : Il3CString;
  begin//WasAteriks
   l_Text := Get_Caption;
   if ComboReq.IsContext then
   begin
    if l3Same(aValue, cZ) then
    begin
     if (aPos >= 0) then
      Result := l3IsChar(l_Text, aPos, cZ)
     else
      Result := true;
     if not Result then
      Result := (aPos > 0) and l3IsChar(l_Text, aPos - 1, cZ);
     if not Result then
      Result := l3IsChar(l_Text, aPos + 1, cZ);
    end//l3Same(aValue, cZ)
    else
     Result := False;
   end//ComboReq.IsContext
   else
    Result := l3Same(aValue, cZ) and (l3Pos(l_Text, cZ) <> l3NotFound);
  end;//WasAteriks
                                   
//#UC END# *48D24F5F02BF_48D399A20288_var*
begin
//#UC START# *48D24F5F02BF_48D399A20288_impl*
 Result := false;
 if f_IsAsterisk then
  if l3IsNil(Get_Caption) then
   f_IsAsterisk := false;
   // - ну не бывает в ПУСТОЙ строке никаких звездочек
 if (Get_Req.Para.AsObject.BoolA[k2_tiNumList] and f_IsAsterisk) then
 begin
  Result := True;
  if f_IsAsterisk then
   if l3Same(aValue, cZ) then
    aRslt := nil;
  f_NeedAdd := False;
 end//Get_Req.Para.BoolA[k2_tiNumList] and f_IsAsterisk
 else
 if WasAteriks then // f_IsAsterisk - выставляется только для полей IsNumList
 begin
  Result := True;
  aRslt := nil;
  f_NeedAdd := False;
 end//WasAteriks
 else
 if l3Same(aValue, ';') then
 begin
  Result := True;
  aRslt := nil;
  f_NeedAdd := True;
 end//l3Same(aValue, ';')
 else
 if ComboReq.IsContext then
  Result := Get_Req.AnalyzeString(aValue, aRslt);
//#UC END# *48D24F5F02BF_48D399A20288_impl*
end;//TevDropCombo.DoAnalyzeString

procedure TevDropCombo.DoEscPressed;
//#UC START# *48D3824000D5_48D399A20288_var*
//#UC END# *48D3824000D5_48D399A20288_var*
begin
//#UC START# *48D3824000D5_48D399A20288_impl*
 ComboReq.EscPressed(Self);
 if ComboReq.IsContext and not f_ShowHistoryList then
 begin
  Inc(f_LockShowPrompts);
  try
   DoSetCOntextText(f_SavedText);
  finally
   Dec(f_LockShowPrompts);
  end;
 end;
//#UC END# *48D3824000D5_48D399A20288_impl*
end;//TevDropCombo.DoEscPressed

procedure TevDropCombo.DoDropDownCurrentChanged(const aNode: InevSimpleNode);
//#UC START# *48D38273036D_48D399A20288_var*
//#UC END# *48D38273036D_48D399A20288_var*
begin
//#UC START# *48D38273036D_48D399A20288_impl*
 if ComboReq.IsContext and not f_ShowHistoryList then
 begin
  f_LockSaveText := True;
  try
   if Assigned(aNode) then
    DoSetCOntextText(getFullPath(aNode))
   else
    DoSetCOntextText(f_SavedText);
  finally
   f_LockSaveText := False;
  end;//try..finally
 end;//ComboReq.IsContext and not f_ShowHistoryList 
//#UC END# *48D38273036D_48D399A20288_impl*
end;//TevDropCombo.DoDropDownCurrentChanged

procedure TevDropCombo.DoAfterHideControl;
//#UC START# *48D382AA012A_48D399A20288_var*
//#UC END# *48D382AA012A_48D399A20288_var*
begin
//#UC START# *48D382AA012A_48D399A20288_impl*
 ChooseMean(False);
 Get_Req.UpdateState(Self, nil);
 if (Get_DefaultNode <> nil) and (Get_Value = nil) then
  ShowNode(Get_DefaultNode);
//#UC END# *48D382AA012A_48D399A20288_impl*
end;//TevDropCombo.DoAfterHideControl

procedure TevDropCombo.DoSynchronizeSelectedValueWithText;
//#UC START# *4E93093B00C1_48D399A20288_var*

 function FindCurrent(const aTree : InevSimpleTree;
                      const aText : Il3CString): Il3SimpleNode;

  function FindCurr(const aIterNode: Il3SimpleNode): boolean;
  begin//FindCurr
   Result := l3Same(l3GetFullPathCStr(aTree.RootNode, aIterNode),
                    aText, true);
   //Result := l3Same(aIterNode.Text, aText, true);
  end;//FindCurr

 begin
  if (aTree = nil) then
   Result := nil
  else
   Result := aTree.SimpleIterateF(l3L2SNA(@FindCurr), imCheckResult);
 end;

var
 l_Text: Il3CString;
//#UC END# *4E93093B00C1_48D399A20288_var*
begin
//#UC START# *4E93093B00C1_48D399A20288_impl*
 inherited;
 // http://mdp.garant.ru/pages/viewpage.action?pageId=290952615
 // http://mdp.garant.ru/pages/viewpage.action?pageId=290951667&focusedCommentId=290953794#comment-290953794
 if not f_TreeInit then
  InitTree;
 l_Text := Get_Caption;
 if l3IsNil(l_Text) then
  f_SelectedValue := nil
 else
 if not (Assigned(f_SelectedValue) and l3Same(l_Text, f_SelectedValue.Text)) then
  f_SelectedValue := FindCurrent(f_Tree, l_Text);
 if not (l3IsNil(l_Text) and (f_SelectedValue = nil)) then // почему бы и не разрешить пустое значение
  if f_InputWithTree then // этот if вырос вот отсюда: http://mdp.garant.ru/pages/viewpage.action?pageId=508186273&focusedCommentId=509115803#comment-509115803
   Assert((f_Tree = nil) or (f_SelectedValue <> nil));
 // - либо это атрибут без словаря, либо значение должно найтись
 f_State := esCompleted;
//#UC END# *4E93093B00C1_48D399A20288_impl*
end;//TevDropCombo.DoSynchronizeSelectedValueWithText

end.
