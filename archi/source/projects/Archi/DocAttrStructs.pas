unit DocAttrStructs;

{ $Id: DocAttrStructs.pas,v 1.4 2007/12/24 15:25:10 lulin Exp $ }

interface

uses
 DocIntf,
 l3Nodes,
 l3TreeInterfaces,
 l3Tree_TLB,
 l3Types
;

type
 Tl3AttrContainerNode = class(Tl3CustomListContainerNode, Il3Node, Il3HandleNode)
  protected
//   fItems : TStringList;
//   function  GetItems : TStringList;
//   procedure SetItems(Value : TStringList);
   function  GetItemsCount : integer;                         override;

   procedure DeleteChildItem(aIndex         : integer;
                             const anOpProc : Il3Processor;
                             const aDelete  : Il3Node);       override;

   function  GetStrings(aIndex : integer) : PChar;            override;
   procedure SetStrings(aIndex : integer; Value : PChar);     override;

   function  GetItemParam(aIndex : integer) : integer;        override;
   procedure SetItemParam(aIndex : integer; Value : integer); override;

   function  GetItemFlag(aIndex : integer) : integer;         override;
   procedure SetItemFlag(aIndex : integer; Value : integer);  override;

   procedure Cleanup;                                         override;
  public
   function GetChildByNumber(aNum : Integer) : Il3Node;       override;

//   property Items : TStringList read GetItems write SetItems;
  end;//Tl3ListContainerNode

 Tl3AttrItemNode = class(Tl3CustomNode, Il3Node, Il3HandleNode)
  protected
   fListNode : Tl3CustomListContainerNode;
   fListItem : Integer;

   function  Get_NextNode   : Il3Node;       override;
   function  Get_PrevNode   : Il3Node;       override;
   function  Get_ParentNode : Il3Node;       override;
   function  Get_ChildNode  : Il3Node;       override;

   function  pm_GetSt : PChar;               override;
   procedure pm_SetSt(Value : PChar);        override;
   function  DoGetLen: Long;                override;

   function  pm_GetHandle: Tl3Handle;        override;
   procedure pm_SetHandle(Value: Tl3Handle); override;

   function  Get_Handle: Integer;            virtual;
   procedure Set_Handle(Value: Integer);     virtual;

   function  Get_Flags       : Integer;      override;
   procedure Set_Flags(Value : Integer);     override;

   procedure pm_SetListNode(aNode: Tl3CustomListContainerNode);
     virtual;
     {-}
  protected
  // internal methods
   procedure Cleanup;
     override;
     {-}

  public
   function  IsFirst    : WordBool;      override;
   function  IsLast     : WordBool;      override;

      function  IsSame(const aNode: Il3SimpleNode): Boolean;
   function  GetNumInParent(aOnlyOneLevel : Boolean = false) : Integer; override;

   function GetLevelForParent(const aNode : Il3Node) : Integer; override;
   procedure Delete(const anOpProc: Il3Processor = nil);  override;

   property ListNode : Tl3CustomListContainerNode
     read fListNode
     write pm_SetListNode;
     {-}
   property ListItem : Integer read fListItem write fListItem;
   property Handle : Integer read Get_Handle write Set_Handle;
  end;//Tl3AttrItemNode

implementation

{Tl3AttrContainerNode}

 procedure Tl3AttrContainerNode.Cleanup;
  begin
//   Items := nil;
   inherited;
  end;

 procedure Tl3AttrContainerNode.DeleteChildItem(aIndex         : integer;
                                                const anOpProc : Il3Processor;
                                                const aDelete  : Il3Node);
  begin
//   fItems.Delete(aIndex);
  end;

 function Tl3AttrContainerNode.GetChildByNumber(aNum : Integer) : Il3Node;
//  var
//   aNode : Tl3AttrItemNode;
  begin
{   If (aNum < 0) or (aNum >= ChildsCount)
    then Result := nil
    else
     begin
      aNode := Tl3AttrItemNode.Create(nil);
      try
       aNode.ListNode := Self;
       aNode.ListItem := aNum;
       Result := aNode as Il3Node;
      finally
       l3Free(aNode);
      end;
     end;
}
  end;

 function  Tl3AttrContainerNode.GetItemsCount : integer;
  begin
//   If fItems <> nil
//    then Result := fItems.Count
//    else Result := 0;
  end;

{ function  Tl3AttrContainerNode.GetItems : TStringList;
  begin
   Result := fItems;
  end;
}
{
procedure Tl3AttrContainerNode.SetItems(Value : TStringList);
 begin
   If fItems = Value then Exit;
   If fItems <> nil
    then
     begin
      fItems.OnChange   := Nil;
      fItems.OnChanging := Nil;
      //Del list Notify
     end;

   l3Set(fItems, Value);
   If fItems <> nil
    then
     begin
      fItems.OnChange   := ListChanged;
      fItems.OnChanging := ListChanging;
      ChildsCount       := fItems.Count;
      //Add to list Notify
     end;
    //else
    // ChildsCount := 0;

 end;
}

function  Tl3AttrContainerNode.GetStrings(aIndex : integer) : PChar;
 begin
//   Result := PChar(Items.Strings[aIndex]);
 end;

 procedure Tl3AttrContainerNode.SetStrings(aIndex : integer; Value : PChar);
  begin
//   Items.Strings[aIndex] := l3GetStrPas(Value);
  end;

 function  Tl3AttrContainerNode.GetItemParam(aIndex : integer) : integer;
  begin
//   Result := Integer(Items.Objects[aIndex]);
  end;

 procedure Tl3AttrContainerNode.SetItemParam(aIndex : integer; Value : integer);
  begin
//   Items.Objects[aIndex] := Pointer(Value);
  end;

 function  Tl3AttrContainerNode.GetItemFlag(aIndex : integer) : integer;
  begin
//   Result := 0;
  end;

 procedure Tl3AttrContainerNode.SetItemFlag(aIndex : integer; Value : integer);
  begin
  end;

{.Tl3AttrContainerNode}

{Tl3AttrItemNode}
 function  Tl3AttrItemNode.Get_NextNode   : Il3Node;
//  var
//   lNextIndex : Integer;
  begin
//   If IsLast
//    then lNextIndex := 0
//    else lNextIndex := Succ(fListItem);
//   Result := fListNode.GetChildByNumber(lNextIndex);
  end;

 function  Tl3AttrItemNode.Get_PrevNode   : Il3Node;
//  var
//   lPrevIndex : Integer;
  begin
//   If IsFirst
//    then lPrevIndex := Pred(fListNode.ChildsCount)
//    else lPrevIndex := Pred(fListItem);
//   Result := fListNode.GetChildByNumber(lPrevIndex);
  end;

 function  Tl3AttrItemNode.Get_ParentNode : Il3Node;
  begin
//   Result := fListNode as Il3Node;
  end;

 function  Tl3AttrItemNode.Get_ChildNode  : Il3Node;
  begin
//   Result := Nil;
  end;

 function  Tl3AttrItemNode.pm_GetSt : PChar;
  begin
//   Result := fListNode.Strings[fListItem];
  end;

 procedure Tl3AttrItemNode.pm_SetSt(Value : PChar);
  begin
//   fListNode.Strings[fListItem] := Value;
  end;

 function  Tl3AttrItemNode.DoGetLen: Long;
  begin
//   Result := l3StrLen(fListNode.Strings[fListItem]);
  end;

 function  Tl3AttrItemNode.pm_GetHandle: Tl3Handle;
  begin
//   Result := Get_Handle;
  end;

 procedure Tl3AttrItemNode.pm_SetHandle(Value: Tl3Handle);
  begin
//   Set_Handle(Value);
  end;

 function  Tl3AttrItemNode.Get_Handle : Integer;
  begin
//   Result := fListNode.ItemParam[fListItem];
  end;

 procedure Tl3AttrItemNode.Set_Handle(Value : Integer);
  begin
 {  Changing;
   Try
    fListNode.ItemParam[fListItem] := Value;
    Notify(ntDataChange, Self as Il3Node);
   finally
    Changed;
   end;
}
  end;

 function  Tl3AttrItemNode.Get_Flags : Integer;
  begin
//   Result := fListNode.ItemFlag[fListItem];
  end;

 procedure Tl3AttrItemNode.Set_Flags(Value : Integer);
  begin
//   fListNode.ItemFlag[fListItem] := Value;
  end;

procedure Tl3AttrItemNode.pm_SetListNode(aNode: Tl3CustomListContainerNode);
begin
// fListNode := aNode;
end;

procedure Tl3AttrItemNode.Cleanup;
  //override;
  {-}
begin
// ListNode := nil;
 inherited;
end;

 function  Tl3AttrItemNode.IsFirst : WordBool;
  begin
//   Result := fListItem = 0;
  end;

 function  Tl3AttrItemNode.IsLast : WordBool;
  begin
//   Result := fListItem = Pred(fListNode.ChildsCount);
  end;

 function Tl3AttrItemNode.GetLevelForParent(const aNode : Il3Node) : Integer;
  begin
//   Result := 1;
//   if (ParentNode <> nil) then
//    Inc(Result, ParentNode.GetLevelForParent(aNode));
  end;

 procedure Tl3AttrItemNode.Delete(const anOpProc: Il3Processor = nil);
  begin
//   fListNode.DeleteChildItem(fListItem, anOpProc, Self);
//   ListNode := Nil;
  end;

 function Tl3AttrItemNode.GetNumInParent(aOnlyOneLevel : Boolean = false) : Integer;
  begin
//   Result := fListItem;
  end;

  function Tl3AttrItemNode.IsSame(const aNode: Il3SimpleNode): Boolean;
//  var
//   lIntfObj : Tl3AttrItemNode;
  begin
(*   Try
    {$IfOpt D+}
     Result := False;
     lIntfObj := Tl3AttrItemNode((aIntf as Il3NodeWrap).GetSelf);
     If Not(lIntfObj is Tl3AttrItemNode) then Exit;
    {$else}
     lIntfObj := (aIntf as Il3NodeWrap).GetSelf as Tl3AttrItemNode;
    {$endif}

    //Result := l3IEQ(Self, aIntf);
    Result := Self = lIntfObj;
    If Result then Exit;
    Result := (fListNode = lIntfObj.fListNode) and (fListItem = lIntfObj.fListItem);
   except
    Result := False;
   end;
*)
  end;

{.Tl3AttrItemNode}

end.
