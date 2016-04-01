unit NOT_COMPLETED_nsParaListNode;
 {* Список параграфов }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\f1DocumentTagsImplementation\NOT_COMPLETED_nsParaListNode.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TnsParaListNode" MUID: (467FCE2703D6)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , nsParaListNodeModelPart
 , l3Variant
 , k2Interfaces
 , F1TagDataProviderInterface
 , k2TagList
 , l3Interfaces
 , k2Base
 , k2Prim
 , l3Types
;

type
 TnsParaListNode = class(TnsParaListNodeModelPart)
  {* Список параграфов }
  private
   f_NodeChildrenCount: Integer;
  protected
   procedure MakeChildForInsert(var anIndex: Integer;
    var aChild: Tl3Tag;
    const anOp: Ik2Op); virtual;
   function NodeChildrenCount: Integer; virtual;
   function BaseChildrenCount: LongInt;
   function GetChildNode(anIndex: Integer): If1TagDataProvider;
   function GetChildPrim(aCount: Integer;
    anIndex: LongInt;
    aCheckInCache: Boolean;
    aList: Tk2TagList;
    aCheckInTree: Boolean): Tl3Tag;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure InitFields; override;
   function DoIterateChildrenF(Action: Mk2Children_IterateChildrenF_Action;
    aLo: Tl3Index;
    aHi: Tl3Index;
    aLoadedOnly: Boolean): Integer; override;
   procedure DoIterateProperties(Action: Ml3TagHolder_IterateProperties_Action;
    All: Boolean); override;
   function DeleteChildPrim(anIndex: Integer;
    aChild: Tl3Variant;
    const aContext: Il3OpPack): Boolean; override;
   function DoDeleteChild(anIndex: Integer;
    const aContext: Ik2Op): Boolean; override;
   function DoGetSubAtom(aProp: Tk2Prop;
    out Data: Tl3Variant): Boolean; override;
   procedure CheckChildInsert(var anIndex: Integer;
    var aChild: Tl3Variant;
    const anOp: Ik2Op); override;
   function DoIterateChildrenBack(Action: Mk2Children_IterateChildrenBack_Action;
    aHi: Tl3Index;
    aLo: Tl3Index;
    aLoadedOnly: Boolean): Integer; override;
   {$If NOT Defined(k2TagIsAtomic)}
   function IterateInnerChildrenOnWrite: Boolean; override;
   {$IfEnd} // NOT Defined(k2TagIsAtomic)
   function pm_GetChildrenCount: Integer; override;
   function pm_GetChildPrim(anIndex: Integer): Tl3Variant; override;
 end;//TnsParaListNode

implementation

uses
 l3ImplUses
 , f1ChildMaker
 , nsCommentStorer
 , nsParentedTagNode
 , nevTools
 , SectionBreak_Const
 , k2Tags
 , l3MinMax
 , LeafParaDecorationsHolder_Const
 , CommentPara_Const
 , SysUtils
 , k2BaseStruct
 , nsTagString
;

procedure TnsParaListNode.MakeChildForInsert(var anIndex: Integer;
 var aChild: Tl3Tag;
 const anOp: Ik2Op);
//#UC START# *4CED5C3D02CB_467FCE2703D6_var*
var
 l_Obj: TObject;
//#UC END# *4CED5C3D02CB_467FCE2703D6_var*
begin
//#UC START# *4CED5C3D02CB_467FCE2703D6_impl*
 if (TagDataProvider <> nil) AND
    not (ns_nsNotNeedSynchronizeWithTree in f_State) then
 begin
  try
   // - это, чтобы не разрушить структуру дерева
   if (anOp <> nil) then
    anOp.CheckReadOnly;
  except
   Exit;
  end;//try..except
(*  if (anOp <> nil) AND anOp.Processor.ReadOnly then
   // - это, чтобы не разрушить структуру дерева
   Exit;*)
  l_Obj := aChild.AsObject;
  if not(l_Obj Is TnsParentedTagNode) OR
     not TnsParentedTagNode(l_Obj).HasTagDataProvider then
   TagDataProvider.CreateNewNode(anIndex, aChild, Tf1ChildMaker.Make(Self), anOp);
 end;//TagDataProvider <> nil
//#UC END# *4CED5C3D02CB_467FCE2703D6_impl*
end;//TnsParaListNode.MakeChildForInsert

function TnsParaListNode.NodeChildrenCount: Integer;
//#UC START# *4CED5CEF011A_467FCE2703D6_var*
//#UC END# *4CED5CEF011A_467FCE2703D6_var*
begin
//#UC START# *4CED5CEF011A_467FCE2703D6_impl*
 if (TagDataProvider = nil) then
  Result := 0
 else
 begin
  if (f_NodeChildrenCount = -1) then
   f_NodeChildrenCount := TagDataProvider.ChildrenCount;
   // - наверное это надо кешировать на Tf1ListTagDataFromDTPPrim.GetChildrenCount,
   //   но тут - прилеплено на живую нитку
   // http://mdp.garant.ru/pages/viewpage.action?pageId=271190964
   //   http://mdp.garant.ru/pages/viewpage.action?pageId=271190964&focusedCommentId=338004037#comment-338004037
   // А то мол 3 000 000 раз... И что? Да хоть сто тыщ мульёнов...
  Result := f_NodeChildrenCount; 
 end;//TagDataProvider = nil
//#UC END# *4CED5CEF011A_467FCE2703D6_impl*
end;//TnsParaListNode.NodeChildrenCount

function TnsParaListNode.BaseChildrenCount: LongInt;
//#UC START# *5081611A023C_467FCE2703D6_var*
//#UC END# *5081611A023C_467FCE2703D6_var*
begin
//#UC START# *5081611A023C_467FCE2703D6_impl*
 Result := inherited pm_GetChildrenCount;
//#UC END# *5081611A023C_467FCE2703D6_impl*
end;//TnsParaListNode.BaseChildrenCount

function TnsParaListNode.GetChildNode(anIndex: Integer): If1TagDataProvider;
//#UC START# *508161B400B3_467FCE2703D6_var*
var
 l_First: If1TagDataProvider;
//#UC END# *508161B400B3_467FCE2703D6_var*
begin
//#UC START# *508161B400B3_467FCE2703D6_impl*
 l_First := TagDataProvider.FirstChild;
 if (l_First = nil) then
  Result := nil
 else
 if (anIndex = 0) then
  Result := l_First
 else
  Result := l_First.SiblingByIndex[anIndex];
//#UC END# *508161B400B3_467FCE2703D6_impl*
end;//TnsParaListNode.GetChildNode

function TnsParaListNode.GetChildPrim(aCount: Integer;
 anIndex: LongInt;
 aCheckInCache: Boolean;
 aList: Tk2TagList;
 aCheckInTree: Boolean): Tl3Tag;
//#UC START# *508161F401E8_467FCE2703D6_var*
var
 l_Node: If1TagDataProvider;
 l_H: InevObjectHolder;
 l_O: InevObject;
//#UC END# *508161F401E8_467FCE2703D6_var*
begin
//#UC START# *508161F401E8_467FCE2703D6_impl*
 Result := nil;
 if (anIndex < 0) OR (anIndex >= aCount) then
  Result := k2NullTag
 else
 begin
  if aCheckInCache AND (anIndex < aList.Count) then
   Result := aList.Items[anIndex]
  else
   Result := nil; 
  if (Result = nil) AND aCheckInTree then
  begin
   if (f_CurIndex = Pred(anIndex)) AND (f_CurNode <> nil) then
   begin
    l_Node := f_CurNode.Next;
    if (l_Node <> nil) then
     f_CurNode := l_Node
    else
    begin
     Result := k2NullTag;
     Exit;
    end;//l_Node <> nil
    Inc(f_CurIndex);
    Result := MakeChildTag(anIndex, f_CurNode).AsObject
   end//f_CurIndex = Pred(anIndex)..
   else
   begin
    l_Node := GetChildNode(anIndex);
    if (l_Node = nil) then
    begin
     f_CurNode := nil;
     f_CurIndex := 0;
     Result := k2NullTag;
     Exit;
    end//l_Node = nil
    else
    begin
     if (l_Node <> nil) then
      f_CurNode := l_Node
     else
     begin
      Result := k2NullTag;
      Exit;
     end;//l_Node <> nil
     f_CurIndex := anIndex;
     Result := MakeChildTag(anIndex, f_CurNode).AsObject;
    end;//l_Node = nil
   end;//f_CurIndex = Pred(anIndex)..
   if (anIndex >= aList.Count) then
    aList.Count := anIndex + 1;
   aList.Items[anIndex] := Result.Box;
   if Result.IsKindOf(k2_typSectionBreak) then
   begin
    if not Result.QT(InevObject, l_O) then
     Assert(false);
    l_H := l_O.Holder;
    Assert(l_H <> nil);
    l_H.SectionBreakAdded(l_O);
   end;//Result.IsKindOf(k2_typSectionBreak)
  end;//Result = nil
 end;//aCount = 0
//#UC END# *508161F401E8_467FCE2703D6_impl*
end;//TnsParaListNode.GetChildPrim

procedure TnsParaListNode.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_467FCE2703D6_var*
//#UC END# *479731C50290_467FCE2703D6_var*
begin
//#UC START# *479731C50290_467FCE2703D6_impl*
 f_CurIndex := 0;
 f_CurNode := nil;
 inherited;
//#UC END# *479731C50290_467FCE2703D6_impl*
end;//TnsParaListNode.Cleanup

procedure TnsParaListNode.InitFields;
//#UC START# *47A042E100E2_467FCE2703D6_var*
//#UC END# *47A042E100E2_467FCE2703D6_var*
begin
//#UC START# *47A042E100E2_467FCE2703D6_impl*
 inherited;
 f_NodeChildrenCount := -1;
//#UC END# *47A042E100E2_467FCE2703D6_impl*
end;//TnsParaListNode.InitFields

function TnsParaListNode.DoIterateChildrenF(Action: Mk2Children_IterateChildrenF_Action;
 aLo: Tl3Index;
 aHi: Tl3Index;
 aLoadedOnly: Boolean): Integer;
//#UC START# *48CF96D80241_467FCE2703D6_var*
var
 l_Count: Integer;
 l_List: Tk2TagList;

  function DoChild(aChild: Tl3Variant; anIndex: Long): Bool;
  begin//DoChild
   if (aChild = nil) OR not aChild.IsValid then
   begin
    if aLoadedOnly then
     Result := true
    else
    begin
     if (l_List = nil) then
      l_List := cAtom(k2_tiChildren) As Tk2TagList;
     Result := Action(GetChildPrim(l_Count, anIndex, false, l_List, true), anIndex);
    end;//not aLoadedOnly
   end//aChild = nil..
   else
    Result := Action(aChild, anIndex);
  end;//DoChild

var
 l_Index: Integer;
 l_TagCount: Integer;
 l_NodeCount: Integer;
 l_Action: Mk2Children_IterateChildrenF_Action;
 l_Child: Tl3Variant;
//#UC END# *48CF96D80241_467FCE2703D6_var*
begin
//#UC START# *48CF96D80241_467FCE2703D6_impl*
 l_TagCount := BaseChildrenCount;
 l_NodeCount := NodeChildrenCount;
 l_Count := Max(l_TagCount, l_NodeCount);
 l_List := nil;
 if (l_TagCount >= l_NodeCount) then
 begin
  l_Action := L2Mk2ChildrenIterateChildrenFAction(@DoChild);
  try
   Result := inherited DoIterateChildrenF(l_Action, aLo, aHi, aLoadedOnly);
  finally
   k2FreeTIA(Action);
  end;//try..finally
 end//l_TagCount >= l_NodeCount
 else
 begin
  try
  Result := 0;
  for l_Index := Max(aLo, 0) to Min(aHi, Pred(l_Count)) do
  begin
   Result := l_Index;
   if (l_List = nil) then
    l_List := cAtom(k2_tiChildren) As Tk2TagList;
   l_Child := GetChildPrim(l_Count, l_Index, true, l_List, not aLoadedOnly);
   if (l_Child <> nil) AND not Action(l_Child, l_Index) then
    break;
  end;//for l_Index
  finally
   k2FreeTIA(Action);
  end;//try..finally
 end;//l_TagCount = l_NodeCount
//#UC END# *48CF96D80241_467FCE2703D6_impl*
end;//TnsParaListNode.DoIterateChildrenF

procedure TnsParaListNode.DoIterateProperties(Action: Ml3TagHolder_IterateProperties_Action;
 All: Boolean);
//#UC START# *49A545D501F6_467FCE2703D6_var*
var
 l_Count: Integer;  
//#UC END# *49A545D501F6_467FCE2703D6_var*
begin
//#UC START# *49A545D501F6_467FCE2703D6_impl*
 l_Count := pm_GetChildrenCount;
 if (l_Count > 0) then
  Child[0];
  // - чтобы правильно записакть детей в поток
 inherited;
//#UC END# *49A545D501F6_467FCE2703D6_impl*
end;//TnsParaListNode.DoIterateProperties

function TnsParaListNode.DeleteChildPrim(anIndex: Integer;
 aChild: Tl3Variant;
 const aContext: Il3OpPack): Boolean;
//#UC START# *4C6CE735026E_467FCE2703D6_var*
var
 l_Sink: If1CommentSink;
 l_Child: Tl3Variant;
//#UC END# *4C6CE735026E_467FCE2703D6_var*
begin
//#UC START# *4C6CE735026E_467FCE2703D6_impl*
 if (aContext <> nil) AND aChild.IsKindOf(k2_typLeafParaDecorationsHolder) then
 begin
  Assert(aChild.ChildrenCount = 2);
  l_Child := aChild.Child[1];
  Assert(l_Child.IsKindOf(k2_typCommentPara));
  if l_Child.Box.QI(If1CommentSink, l_Sink) then
   try
    l_Sink.State := l_Sink.State - [ns_nsChanged];
    l_Sink.Store(nil);
    // - типа чтобы удалить комментарий из базы
    Result := inherited DeleteChildPrim(anIndex, aChild, aContext);
    Assert(Result);
    // - комментарий из базы уже удалили, поэтому мы не можем не удалить его из текста
   finally
    l_Sink := nil;
   end//try..finally
  else
   Result := inherited DeleteChildPrim(anIndex, aChild, aContext);
 end//aContext <> nil
 else
  Result := inherited DeleteChildPrim(anIndex, aChild, aContext);
//#UC END# *4C6CE735026E_467FCE2703D6_impl*
end;//TnsParaListNode.DeleteChildPrim

function TnsParaListNode.DoDeleteChild(anIndex: Integer;
 const aContext: Ik2Op): Boolean;
//#UC START# *4C6CED4C009B_467FCE2703D6_var*
//#UC END# *4C6CED4C009B_467FCE2703D6_var*
begin
//#UC START# *4C6CED4C009B_467FCE2703D6_impl*
 if (ns_nsNotNeedSynchronizeWithTree in f_State) OR
    ((aContext <> nil) AND
     (aContext.IsCheckOff OR
      aContext.InUndo)
      // http://mdp.garant.ru/pages/viewpage.action?pageId=265391680
    ) then
  Result := inherited DoDeleteChild(anIndex, aContext)
 else
 begin
  Result := false;
 end;//ns_nsNotNeedSynchronizeWithTree in f_State
//#UC END# *4C6CED4C009B_467FCE2703D6_impl*
end;//TnsParaListNode.DoDeleteChild

function TnsParaListNode.DoGetSubAtom(aProp: Tk2Prop;
 out Data: Tl3Variant): Boolean;
//#UC START# *4C6D1D450332_467FCE2703D6_var*
//var
// l_P: _PropLoc_;
//#UC END# *4C6D1D450332_467FCE2703D6_var*
begin
//#UC START# *4C6D1D450332_467FCE2703D6_impl*
 Case aProp.TagIndex of
  k2_tiAllChildrenCount:
  begin
(*   if (TagDataProvider <> nil) then
   begin
    Result := true;
    Data := TagDataProvider.AllParaChildrenCount;
   end//Node <> nil
   else
    Result := false;*)
   Result := BaseGetSubAtom(aProp, Data);
   if not Result AND (TagDataProvider <> nil) then
   begin
    Result := true;
    StoreIntAtom(aProp, TagDataProvider.AllParaChildrenCount);
    Result := BaseGetSubAtom(aProp, Data);
    //Data := Attr[aProp.TagIndex];
(*    l_P{$IfDef XE4}.r_PropInPrim_{$EndIf}.rProp := aProp;
    l_P.rOp := nil;
    l_P{$IfDef XE4}.r_PropInPrim_{$EndIf}.rDeleteMapped := true;
    l_P{$IfDef XE4}.r_PropInPrim_{$EndIf}.rVT := vtInt;
    BaseSetSubAtom(_PropIn_(l_P), Data);*)
   end;//not Result
  end;//k2_tiAllChildrenCount
  k2_tiInContents:
  begin
   ParseStyle;
(*   if (TagDataProvider.AsDocumentTextProvider <> nil) then
   // - затычка, надо открутить, когда будет сделана задача:
   // http://mdp.garant.ru/pages/viewpage.action?pageId=235057053
   begin
    Data := 1;
    Result := true;
   end//TagDataProvider.AsDocumentTextProvider <> nil
   else*)
    Result := inherited DoGetSubAtom(aProp, Data);
  end;//k2_tiInContents
  else
   Result := inherited DoGetSubAtom(aProp, Data);
 end;//Case aProp.TagIndex
//#UC END# *4C6D1D450332_467FCE2703D6_impl*
end;//TnsParaListNode.DoGetSubAtom

procedure TnsParaListNode.CheckChildInsert(var anIndex: Integer;
 var aChild: Tl3Variant;
 const anOp: Ik2Op);
//#UC START# *4CED66B8005F_467FCE2703D6_var*
//#UC END# *4CED66B8005F_467FCE2703D6_var*
begin
//#UC START# *4CED66B8005F_467FCE2703D6_impl*
 MakeChildForInsert(anIndex, aChild, anOp);
//#UC END# *4CED66B8005F_467FCE2703D6_impl*
end;//TnsParaListNode.CheckChildInsert

function TnsParaListNode.DoIterateChildrenBack(Action: Mk2Children_IterateChildrenBack_Action;
 aHi: Tl3Index;
 aLo: Tl3Index;
 aLoadedOnly: Boolean): Integer;
//#UC START# *5081632303E6_467FCE2703D6_var*
var
 l_Count: Integer;
 l_List: Tk2TagList;

  function DoChild(aChild: Tl3Variant; anIndex: Long): Bool;
  begin//DoChild
   if (aChild = nil) OR not aChild.IsValid then
   begin
    if aLoadedOnly then
     Result := true
    else
    begin
     if (l_List = nil) then
      l_List := cAtom(k2_tiChildren) As Tk2TagList;
     Result := Action(GetChildPrim(l_Count, anIndex, false, l_List, true), anIndex);
    end;//not aLoadedOnly
   end//aChild = nil..
   else
    Result := Action(aChild, anIndex);
  end;//DoChild

var
 l_Index: Integer;
 l_TagCount: Integer;
 l_NodeCount: Integer;
 l_Action: Mk2Children_IterateChildrenBack_Action;
 l_Child: Tl3Variant;
//#UC END# *5081632303E6_467FCE2703D6_var*
begin
//#UC START# *5081632303E6_467FCE2703D6_impl*
 l_TagCount := BaseChildrenCount;
 l_NodeCount := NodeChildrenCount;
 l_Count := Max(l_TagCount, l_NodeCount);
 l_List := nil;
 if (l_TagCount >= l_NodeCount) then
 begin
  l_Action := L2Mk2ChildrenIterateChildrenFAction(@DoChild);
  try
   Result := inherited DoIterateChildrenBack(l_Action, aHi, aLo, aLoadedOnly);
  finally
   k2FreeTIA(Mk2Children_IterateChildrenF_Action(l_Action));
  end;//try..finally
 end//l_TagCount >= l_NodeCount
 else
 begin
  Result := Min(aHi, Pred(l_Count)) ;
  for l_Index := Min(aHi, Pred(l_Count)) downto Max(aLo, 0) do
  begin
   Result := l_Index;
   if (l_List = nil) then
    l_List := cAtom(k2_tiChildren) As Tk2TagList;
   l_Child := GetChildPrim(l_Count, l_Index, true, l_List, not aLoadedOnly);
   if (l_Child <> nil) AND not Action(l_Child, l_Index) then
    break;
  end;//for l_Index
 end;//l_TagCount = l_NodeCount
//#UC END# *5081632303E6_467FCE2703D6_impl*
end;//TnsParaListNode.DoIterateChildrenBack

{$If NOT Defined(k2TagIsAtomic)}
function TnsParaListNode.IterateInnerChildrenOnWrite: Boolean;
//#UC START# *5081947501ED_467FCE2703D6_var*
//#UC END# *5081947501ED_467FCE2703D6_var*
begin
//#UC START# *5081947501ED_467FCE2703D6_impl*
 Result := False;
//#UC END# *5081947501ED_467FCE2703D6_impl*
end;//TnsParaListNode.IterateInnerChildrenOnWrite
{$IfEnd} // NOT Defined(k2TagIsAtomic)

function TnsParaListNode.pm_GetChildrenCount: Integer;
//#UC START# *5335815D03DC_467FCE2703D6get_var*
//#UC END# *5335815D03DC_467FCE2703D6get_var*
begin
//#UC START# *5335815D03DC_467FCE2703D6get_impl*
 Result := Max(NodeChildrenCount, BaseChildrenCount);
//#UC END# *5335815D03DC_467FCE2703D6get_impl*
end;//TnsParaListNode.pm_GetChildrenCount

function TnsParaListNode.pm_GetChildPrim(anIndex: Integer): Tl3Variant;
//#UC START# *53358545012C_467FCE2703D6get_var*
var
 l_List : Tk2TagList;
//#UC END# *53358545012C_467FCE2703D6get_var*
begin
//#UC START# *53358545012C_467FCE2703D6get_impl*
 l_List := cAtom(k2_tiChildren) As Tk2TagList;
 Result := GetChildPrim(Max(NodeChildrenCount, l_List.Count),
                        anIndex,
                        true,
                        l_List,
                        true);
//#UC END# *53358545012C_467FCE2703D6get_impl*
end;//TnsParaListNode.pm_GetChildPrim

end.
