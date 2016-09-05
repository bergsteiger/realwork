unit evContentsTagNode;

// Модуль: "w:\common\components\gui\Garant\Everest\evContentsTagNode.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TevContentsTagNode" MUID: (4DFEF1A701F9)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
 l3IntfUses
 , evContentsNode
 , l3TreeInterfaces
 , l3Variant
 , evInternalInterfaces
 , l3Tree_TLB
 , l3Interfaces
 , l3IID
;

type
 TevContentsTagNode = class(TevContentsNode, Il3HandleNode)
  private
   f_Filter: InevContentsNodeFilter;
   f_Tag: Tl3Tag;
    {* Узел тэга. }
  private
   procedure MakeChildNode(aTag: Tl3Variant);
    {* Создает новую ноду. }
   procedure CheckTable(aTag: Tl3Variant);
    {* Проверяет таблицу на метки. }
  protected
   function pm_GetDocument: Tl3Variant;
   function GetPara: Tl3Variant;
    {* Получить параграф, на который ссылается узел. }
   function MakeAndInsertNode(const aNode: Il3Node;
    aTag: Tl3Variant;
    aSub: Tl3Variant): Il3Node;
    {* Чисто обобщающая функция вставки. }
   function GetLayerID: Integer;
   function GetHandle: Integer; virtual;
   function Get_Handle: Integer;
   procedure Set_Handle(aValue: Integer);
   procedure DoTryGetChildren; override;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   function GetAsPCharLen: Tl3WString; override;
   function COMQueryInterface(const IID: Tl3GUID;
    out Obj): Tl3HResult; override;
    {* Реализация запроса интерфейса }
   procedure Remove; override;
   procedure DoChanged; override;
  public
   constructor Create(aTag: Tl3Variant;
    const aFilter: InevContentsNodeFilter); reintroduce; virtual;
   class function Make(aTag: Tl3Variant;
    const aFilter: InevContentsNodeFilter): Il3Node; virtual;
  public
   property Document: Tl3Variant
    read pm_GetDocument;
 end;//TevContentsTagNode

implementation

uses
 l3ImplUses
 , l3InterfacesMisc
 , l3Types
 , SysUtils
 , Block_Const
 , Table_Const
 , evdTypes
 , Document_Const
 , Sub_Const
 , LeafPara_Const
 , l3Base
 {$If Defined(k2ForEditor)}
 , evDocumentPart
 {$IfEnd} // Defined(k2ForEditor)
 , evContentsNodeFactory
 , k2Tags
 , k2NullTagImpl
 , nevTools
 //#UC START# *4DFEF1A701F9impl_uses*
 //#UC END# *4DFEF1A701F9impl_uses*
;

function TevContentsTagNode.pm_GetDocument: Tl3Variant;
//#UC START# *4DFF1CB103D3_4DFEF1A701F9get_var*
var
 l_Tag : Tl3Variant;
//#UC END# *4DFF1CB103D3_4DFEF1A701F9get_var*
begin
//#UC START# *4DFF1CB103D3_4DFEF1A701F9get_impl*
 Result := Tk2NullTagImpl.Instance;
 l_Tag := f_Tag;
 while l_Tag.IsValid do
 begin
  if l_Tag.IsKindOf(k2_typDocument) then
  begin
   Result := l_Tag.Box;
   Exit;
  end;{k2_idDocument}
  l_Tag := l_Tag.Owner;
 end;//while l_Tag.IsValid
//#UC END# *4DFF1CB103D3_4DFEF1A701F9get_impl*
end;//TevContentsTagNode.pm_GetDocument

procedure TevContentsTagNode.MakeChildNode(aTag: Tl3Variant);
 {* Создает новую ноду. }
//#UC START# *4DFF17350370_4DFEF1A701F9_var*

 function FindSub(aSub: Tl3Variant; anIndex: Integer): Boolean;
 var
  l_Tag  : Il3TagRef;
  l_Node : Il3Node;
 begin
  if NeedCreate then
  begin
   if ChildNode <> nil then
   begin
    if not (Supports(ChildNode, Il3TagRef, l_Tag) and l_Tag.AsObject.IsSame(aSub)) then
     MakeAndInsertNode(nil, aTag, aSub.AsObject);
   end
   else
   begin
    l_Node := MakeAndInsertNode(nil, aTag, aSub.AsObject);
    Set_ChildNode(l_Node);
   end;
  end; //if not f_OnlyCheck then
  Result := not NotReady;
 end;

var
 l_Tag  : Il3TagRef;
 l_Node : Il3Node;
//#UC END# *4DFF17350370_4DFEF1A701F9_var*
begin
//#UC START# *4DFF17350370_4DFEF1A701F9_impl*
 l_Node := nil;
 if aTag.IsKindOf(k2_typBlock) then
 begin
  if NeedCreate then
  begin
   if ChildNode <> nil then
   begin
    if not (Supports(ChildNode, Il3TagRef, l_Tag) and l_Tag.AsObject.IsSame(aTag)) then
     MakeAndInsertNode(nil, aTag, nil)
   end
   else
   begin
    l_Node := MakeAndInsertNode(nil, aTag, nil);
    Set_ChildNode(l_Node);
   end;
  end; //if not f_OnlyCheck then
 end
 else
  if aTag.IsKindOf(k2_typTable) then
   CheckTable(aTag)
  else                                    
   if aTag.IsKindOf(k2_typLeafPara) then
    aTag.rAtomEx([k2_tiSubs,
                  k2_tiChildren, k2_tiHandle, Ord(ev_sbtSub)]).IterateChildrenF(L2Mk2ChildrenIterateChildrenFAction(@FindSub));
//#UC END# *4DFF17350370_4DFEF1A701F9_impl*
end;//TevContentsTagNode.MakeChildNode

procedure TevContentsTagNode.CheckTable(aTag: Tl3Variant);
 {* Проверяет таблицу на метки. }
//#UC START# *4DFF1768028A_4DFEF1A701F9_var*

 function lp_CheckRow(aRow: Tl3Variant; anIndex: Long): Boolean;

  function lp_CheckCell(aCell: Tl3Variant; anIndex: Long): Boolean;

   function lp_CheckCellChild(aCellChild: Tl3Variant; anIndex: Long): Boolean;
   begin
    MakeChildNode(aCellChild.AsObject);
    Result := not (NotReady and (ChildNode <> nil));
   end;

  begin
   aCell.IterateChildrenF(L2Mk2ChildrenIterateChildrenFAction(@lp_CheckCellChild));
   Result := not (NotReady and (ChildNode <> nil));
  end;

 begin
  aRow.IterateChildrenF(L2Mk2ChildrenIterateChildrenFAction(@lp_CheckCell));
  Result := not (NotReady and (ChildNode <> nil));
 end;

//#UC END# *4DFF1768028A_4DFEF1A701F9_var*
begin
//#UC START# *4DFF1768028A_4DFEF1A701F9_impl*
 aTag.IterateChildrenF(L2Mk2ChildrenIterateChildrenFAction(@lp_CheckRow));
//#UC END# *4DFF1768028A_4DFEF1A701F9_impl*
end;//TevContentsTagNode.CheckTable

function TevContentsTagNode.GetPara: Tl3Variant;
 {* Получить параграф, на который ссылается узел. }
//#UC START# *4DFF1D6203A6_4DFEF1A701F9_var*
//#UC END# *4DFF1D6203A6_4DFEF1A701F9_var*
begin
//#UC START# *4DFF1D6203A6_4DFEF1A701F9_impl*
 Result := f_Tag;
//#UC END# *4DFF1D6203A6_4DFEF1A701F9_impl*
end;//TevContentsTagNode.GetPara

function TevContentsTagNode.MakeAndInsertNode(const aNode: Il3Node;
 aTag: Tl3Variant;
 aSub: Tl3Variant): Il3Node;
 {* Чисто обобщающая функция вставки. }
//#UC START# *4DFF1DDA0163_4DFEF1A701F9_var*
var
 l_Node       : Il3Node;
 l_NeedCreate : Boolean;
//#UC END# *4DFF1DDA0163_4DFEF1A701F9_var*
begin
//#UC START# *4DFF1DDA0163_4DFEF1A701F9_impl*
 if aSub = nil then
  l_NeedCreate := f_Filter.NeedCreate(aTag)
 else
  l_NeedCreate := f_Filter.NeedCreate(aSub);
 if l_NeedCreate then
 begin
  l_Node := TevContentsNodeFactory.CreateContentsNode(aTag, aSub, f_Filter);
  try
   Result := InsertChildBefore(aNode, l_Node)
  finally
   l_Node := nil;
  end;
  IncThisChildrenCount;
  f_Filter.ColorNode(Result);
 end // if l_NeedCreate then
//#UC END# *4DFF1DDA0163_4DFEF1A701F9_impl*
end;//TevContentsTagNode.MakeAndInsertNode

constructor TevContentsTagNode.Create(aTag: Tl3Variant;
 const aFilter: InevContentsNodeFilter);
//#UC START# *4DFF1D17010D_4DFEF1A701F9_var*
//#UC END# *4DFF1D17010D_4DFEF1A701F9_var*
begin
//#UC START# *4DFF1D17010D_4DFEF1A701F9_impl*
 aTag.SetRef(f_Tag);
 f_Filter := aFilter;
 inherited Create;
//#UC END# *4DFF1D17010D_4DFEF1A701F9_impl*
end;//TevContentsTagNode.Create

class function TevContentsTagNode.Make(aTag: Tl3Variant;
 const aFilter: InevContentsNodeFilter): Il3Node;
//#UC START# *4DFF1D3501C1_4DFEF1A701F9_var*
var
 l_RCN: TevContentsTagNode;
//#UC END# *4DFF1D3501C1_4DFEF1A701F9_var*
begin
//#UC START# *4DFF1D3501C1_4DFEF1A701F9_impl*
 l_RCN := TevContentsTagNode.Create(aTag, aFilter);
 try
  Result := l_RCN;
 finally
  l3Free(l_RCN);
 end;
//#UC END# *4DFF1D3501C1_4DFEF1A701F9_impl*
end;//TevContentsTagNode.Make

function TevContentsTagNode.GetLayerID: Integer;
//#UC START# *4DFF1E5C023F_4DFEF1A701F9_var*
//#UC END# *4DFF1E5C023F_4DFEF1A701F9_var*
begin
//#UC START# *4DFF1E5C023F_4DFEF1A701F9_impl*
 with f_Tag do
  if IsKindOf(k2_typBlock) then
   Result := rLong(k2_tiLayerID, Ord(ev_sbtSub))
  else
   Result := Ord(ev_sbtSub);
//#UC END# *4DFF1E5C023F_4DFEF1A701F9_impl*
end;//TevContentsTagNode.GetLayerID

function TevContentsTagNode.GetHandle: Integer;
//#UC START# *4DFF2034008D_4DFEF1A701F9_var*
//#UC END# *4DFF2034008D_4DFEF1A701F9_var*
begin
//#UC START# *4DFF2034008D_4DFEF1A701F9_impl*
 Result := f_Tag.IntA[k2_tiHandle];
//#UC END# *4DFF2034008D_4DFEF1A701F9_impl*
end;//TevContentsTagNode.GetHandle

function TevContentsTagNode.Get_Handle: Integer;
//#UC START# *46827CAF03CD_4DFEF1A701F9get_var*
//#UC END# *46827CAF03CD_4DFEF1A701F9get_var*
begin
//#UC START# *46827CAF03CD_4DFEF1A701F9get_impl*
 Result := GetHandle;
//#UC END# *46827CAF03CD_4DFEF1A701F9get_impl*
end;//TevContentsTagNode.Get_Handle

procedure TevContentsTagNode.Set_Handle(aValue: Integer);
//#UC START# *46827CAF03CD_4DFEF1A701F9set_var*
//#UC END# *46827CAF03CD_4DFEF1A701F9set_var*
begin
//#UC START# *46827CAF03CD_4DFEF1A701F9set_impl*
//#UC END# *46827CAF03CD_4DFEF1A701F9set_impl*
end;//TevContentsTagNode.Set_Handle

procedure TevContentsTagNode.DoTryGetChildren;
//#UC START# *4DFF03AF01A1_4DFEF1A701F9_var*

 function lp_CheckTag(aTag: Tl3Variant; anIndex: Long): Boolean;
 begin
  MakeChildNode(aTag.AsObject);
  Result := not (NotReady and (ChildNode <> nil));
 end;

//#UC END# *4DFF03AF01A1_4DFEF1A701F9_var*
begin
//#UC START# *4DFF03AF01A1_4DFEF1A701F9_impl*
 f_Tag.IterateChildrenF(L2Mk2ChildrenIterateChildrenFAction(@lp_CheckTag));
//#UC END# *4DFF03AF01A1_4DFEF1A701F9_impl*
end;//TevContentsTagNode.DoTryGetChildren

procedure TevContentsTagNode.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4DFEF1A701F9_var*
//#UC END# *479731C50290_4DFEF1A701F9_var*
begin
//#UC START# *479731C50290_4DFEF1A701F9_impl*
 f_Filter := nil;
 inherited;
 FreeAndNil(f_Tag);
//#UC END# *479731C50290_4DFEF1A701F9_impl*
end;//TevContentsTagNode.Cleanup

function TevContentsTagNode.GetAsPCharLen: Tl3WString;
//#UC START# *47A869BB02DE_4DFEF1A701F9_var*
//#UC END# *47A869BB02DE_4DFEF1A701F9_var*
begin
//#UC START# *47A869BB02DE_4DFEF1A701F9_impl*
 Result := evGetBlockName(f_Tag).AsWStr;
//#UC END# *47A869BB02DE_4DFEF1A701F9_impl*
end;//TevContentsTagNode.GetAsPCharLen

function TevContentsTagNode.COMQueryInterface(const IID: Tl3GUID;
 out Obj): Tl3HResult;
 {* Реализация запроса интерфейса }
//#UC START# *4A60B23E00C3_4DFEF1A701F9_var*
var
 l_Tag      : Tl3Variant;
 l_Document : InevPara;
 l_SubList  : InevSubList;
 l_Sub      : IevSub;
//#UC END# *4A60B23E00C3_4DFEF1A701F9_var*
begin
//#UC START# *4A60B23E00C3_4DFEF1A701F9_impl*
 Result.SetNoInterface;
 if IID.EQ(Il3TagRef) then
 begin
  Il3TagRef(Obj) := f_Tag.AsRef;
  Result.SetOk;
  Exit;
 end
 else
 if IID.EQ(IevSub) then
 begin
  l_Tag := f_Tag;
  if l_Tag.IsKindOf(k2_typBlock) then
  begin
   if Document.QT(InevPara, l_Document, nil) then 
   begin
    if (l_Document <> nil) then
    begin
     l_SubList := l_Document.MainSubList;
     if (l_SubList <> nil) then
      try
       with l_Tag.Attr[k2_tiHandle] do
        if IsValid then begin
         IevSub(Obj) := l_SubList.BlockEx[AsLong, GetLayerID];
         if (IevSub(Obj) <> nil) then
         begin
          Result.SetOk;
          Exit;
         end;{IevSub(Obj) <> nil}
        end;{IsValid}
      finally
       l_SubList := nil;
      end;{try..finally}
    end;//l_Document <> nil
   end
   else
    Result.SetNoInterface;
  end//..k2_idBlock..
  else
  if l_Tag.IsKindOf(k2_typSub) then
  begin
   if Document.QT(InevPara, l_Document, nil{Processor}) then
   begin
    if (l_Document <> nil) then
    begin
     l_SubList := l_Document.MainSubList;
     if (l_SubList <> nil) then
      try
       with l_Tag.Attr[k2_tiHandle] do
        if IsValid then
        begin
         IevSub(Obj) := l_SubList.SubEx[AsLong, GetLayerID];
         if (IevSub(Obj) <> nil) then
         begin
          Result.SetOk;
          Exit;
         end;{IevSub(Obj) <> nil}
        end;{IsValid}
      finally
       l_SubList := nil;
      end;{try..finally}
    end;//l_Document <> nil
   end
   else
    Result.SetNoInterface;
  end;//..k2_idSub..
 end//..IevSub..
 else
 if IID.EQ(IevDocumentPart) then
 begin
  if l3IOk(QueryInterface(IevSub, l_Sub)) then
   try
    Result := Tl3HResult_C(l_Sub.QueryInterface(IevDocumentPart, Obj));
    Exit;
   finally
    l_Sub := nil;
   end;{try..finally}
  {IevDocumentPart}
 end;
 Result := inherited COMQueryInterface(IID, Obj);
//#UC END# *4A60B23E00C3_4DFEF1A701F9_impl*
end;//TevContentsTagNode.COMQueryInterface

procedure TevContentsTagNode.Remove;
//#UC START# *54C791DB001D_4DFEF1A701F9_var*
var
 l_ParentNode : Il3InternalNode;
//#UC END# *54C791DB001D_4DFEF1A701F9_var*
begin
//#UC START# *54C791DB001D_4DFEF1A701F9_impl*
 if ParentNode = nil then
  Exit;
 Changing;
 try
  Flags := Flags or nfWasDisappear;
  Notify(ntDelete, Self);
  try
   l_ParentNode := (ParentNode as Il3InternalNode);
   if IsFirst then
    if IsLast then
     l_ParentNode.ChildNode := nil
    else
     l_ParentNode.ChildNode := NextNode;

   if l_ParentNode.Child <> nil then
   begin
    (NextNode as Il3InternalNode).PrevNode := PrevNode;
    (PrevNode as Il3InternalNode).NextNode := NextNode;
   end;

   if l3IEQ(Self, NextNode) then
   begin
    Set_NextNode(nil);
    Set_PrevNode(nil);
   end;
   ParentNode.IncAllChildrenCount(-(AllChildrenCount + 1));
   //ParentNode := nil; Changed send to ParentNode!!!
  finally
   Notify(ntDeleteDone, Self);
  end;
 finally
  Changed;
 end;
 Set_ParentNode(nil);
 Free;
//#UC END# *54C791DB001D_4DFEF1A701F9_impl*
end;//TevContentsTagNode.Remove

procedure TevContentsTagNode.DoChanged;
//#UC START# *54D9E08D0212_4DFEF1A701F9_var*
//#UC END# *54D9E08D0212_4DFEF1A701F9_var*
begin
//#UC START# *54D9E08D0212_4DFEF1A701F9_impl*
 try
  inherited;
 except
  on EDoChangedAlreadyDone do ;
 end;
//#UC END# *54D9E08D0212_4DFEF1A701F9_impl*
end;//TevContentsTagNode.DoChanged

end.
