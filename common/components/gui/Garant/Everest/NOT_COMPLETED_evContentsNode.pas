unit NOT_COMPLETED_evContentsNode;

// Модуль: "w:\common\components\gui\Garant\Everest\NOT_COMPLETED_evContentsNode.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TevContentsNode" MUID: (4DFEF11703D8)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
 l3IntfUses
 , l3VirtualNode
 , l3Tree_TLB
;

type
 TevContentsNodeState = (
  {* Состояние узла дерева оглавления. }
  ev_cntNotReady
   {* Узел только что создан и не инициализирован. }
  , ev_cntNeedUpdate
   {* Нужно пересоздать дочерние }
  , ev_cntReady
   {* Узел готов к отображению и не требует обновления. }
  , ev_cntInUpdate
   {* Полный перебор. }
  , ev_cntFirstFind
   {* Поиск первого тега для узла. }
 );//TevContentsNodeState

 TevContentsNode = class(Tl3VirtualFlagsNode)
  private
   f_AllChildrenCount: Integer;
   f_ThisChildrenCount: Integer;
   f_ParentNode: Pointer;
   f_PrevNode: Pointer;
   f_ChildNode: Il3Node;
   f_NextNode: Il3Node;
   f_NodeState: TevContentsNodeState;
  private
   function CheckChildren: Boolean;
    {* Проверяет есть ли у задания дочерние. }
   procedure TryGetChildren;
  protected
   function NeedCreate: Boolean;
   function NotReady: Boolean;
   function NeedUpdate: Boolean;
   procedure IncThisChildrenCount;
   procedure DoTryGetChildren; virtual; abstract;
   function NeedMakeChildren: Boolean; virtual;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure Set_ChildNode(const aValue: Il3Node); override;
   procedure Set_ParentNode(const aValue: Il3Node); override;
   procedure Set_PrevNode(const aValue: Il3Node); override;
   procedure Set_NextNode(const aValue: Il3Node); override;
   function Get_AllChildrenCount: Integer; override;
   function DoGetThisChildrenCount: Integer; override;
   function Get_ParentNode: Il3Node; override;
   function Get_ChildNode: Il3Node; override;
   function Get_NextNode: Il3Node; override;
   function Get_PrevNode: Il3Node; override;
   function IsFirstNode: Boolean; override;
   function IsLastNode: Boolean; override;
   function HasChildNode: Boolean; override;
   function IterateChild(Action: Tl3NodeAction;
    IterMode: Integer;
    const aFromNode: Il3Node = nil): Il3Node; override;
   procedure DoReleaseChilds; override;
   procedure DoIncAllChildrenCount(aInc: Integer); override;
  public
   constructor Create; reintroduce; virtual;
 end;//TevContentsNode

implementation

uses
 l3ImplUses
 , l3InterfacesMisc
 , l3Types
 , l3Bits
 , l3TreeInterfaces
;

function TevContentsNode.NeedCreate: Boolean;
//#UC START# *4E09C3EA0357_4DFEF11703D8_var*
//#UC END# *4E09C3EA0357_4DFEF11703D8_var*
begin
//#UC START# *4E09C3EA0357_4DFEF11703D8_impl*
 Assert(f_NodeState <> ev_cntNeedUpdate);
 Result := (f_NodeState = ev_cntInUpdate) or (ChildNode = nil);
//#UC END# *4E09C3EA0357_4DFEF11703D8_impl*
end;//TevContentsNode.NeedCreate

function TevContentsNode.NotReady: Boolean;
//#UC START# *4E09C6110082_4DFEF11703D8_var*
//#UC END# *4E09C6110082_4DFEF11703D8_var*
begin
//#UC START# *4E09C6110082_4DFEF11703D8_impl*
 Result := f_NodeState = ev_cntFirstFind;
//#UC END# *4E09C6110082_4DFEF11703D8_impl*
end;//TevContentsNode.NotReady

function TevContentsNode.CheckChildren: Boolean;
 {* Проверяет есть ли у задания дочерние. }
//#UC START# *4DFF17B70111_4DFEF11703D8_var*
//#UC END# *4DFF17B70111_4DFEF11703D8_var*
begin
//#UC START# *4DFF17B70111_4DFEF11703D8_impl*
 if f_NodeState = ev_cntReady then
  Result := f_ThisChildrenCount > 0
 else
 begin
  if f_NodeState in [ev_cntNeedUpdate, ev_cntFirstFind, ev_cntInUpdate] then 
   Result := ChildNode <> nil
  else
  begin
   Result := False;
   if IsChanging then Exit;
   Assert(f_NodeState <> ev_cntInUpdate);
   f_NodeState := ev_cntFirstFind;
   TryGetChildren;
   Result := ChildNode <> nil;
   if Result then
    f_NodeState := ev_cntNeedUpdate
   else
    f_NodeState := ev_cntReady; // дочерних нет...
  end;
 end;
//#UC END# *4DFF17B70111_4DFEF11703D8_impl*
end;//TevContentsNode.CheckChildren

procedure TevContentsNode.TryGetChildren;
//#UC START# *4E09D24E0182_4DFEF11703D8_var*
//#UC END# *4E09D24E0182_4DFEF11703D8_var*
begin
//#UC START# *4E09D24E0182_4DFEF11703D8_impl*
 if NeedMakeChildren then
 begin
  if f_NodeState = ev_cntInUpdate then Exit;
  if f_NodeState <> ev_cntFirstFind then
   f_NodeState := ev_cntInUpdate;
  try
   DoTryGetChildren;
  finally
   f_NodeState := ev_cntReady;
  end;
 end; // if NeedMakeChildren then
//#UC END# *4E09D24E0182_4DFEF11703D8_impl*
end;//TevContentsNode.TryGetChildren

function TevContentsNode.NeedUpdate: Boolean;
//#UC START# *4E09E20A0130_4DFEF11703D8_var*
//#UC END# *4E09E20A0130_4DFEF11703D8_var*
begin
//#UC START# *4E09E20A0130_4DFEF11703D8_impl*
 Result := f_NodeState = ev_cntInUpdate;
//#UC END# *4E09E20A0130_4DFEF11703D8_impl*
end;//TevContentsNode.NeedUpdate

procedure TevContentsNode.IncThisChildrenCount;
//#UC START# *4E26C5080278_4DFEF11703D8_var*
//#UC END# *4E26C5080278_4DFEF11703D8_var*
begin
//#UC START# *4E26C5080278_4DFEF11703D8_impl*
 Inc(f_ThisChildrenCount);
//#UC END# *4E26C5080278_4DFEF11703D8_impl*
end;//TevContentsNode.IncThisChildrenCount

constructor TevContentsNode.Create;
//#UC START# *4DFEF25D0323_4DFEF11703D8_var*
//#UC END# *4DFEF25D0323_4DFEF11703D8_var*
begin
//#UC START# *4DFEF25D0323_4DFEF11703D8_impl*
 inherited Create;
 f_ThisChildrenCount := 0;
 f_ParentNode := nil;
 f_NodeState := ev_cntNotReady;
 f_AllChildrenCount := 0;
//#UC END# *4DFEF25D0323_4DFEF11703D8_impl*
end;//TevContentsNode.Create

function TevContentsNode.NeedMakeChildren: Boolean;
//#UC START# *4DFF1C860175_4DFEF11703D8_var*
//#UC END# *4DFF1C860175_4DFEF11703D8_var*
begin
//#UC START# *4DFF1C860175_4DFEF11703D8_impl*
 Result := (f_NodeState <> ev_cntReady) and not IsChanging;
//#UC END# *4DFF1C860175_4DFEF11703D8_impl*
end;//TevContentsNode.NeedMakeChildren

procedure TevContentsNode.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4DFEF11703D8_var*
//#UC END# *479731C50290_4DFEF11703D8_var*
begin
//#UC START# *479731C50290_4DFEF11703D8_impl*
 inherited;
 f_NextNode := nil;
 f_PrevNode := nil;
 f_ParentNode := nil;
 f_ThisChildrenCount := 0;
 f_NodeState := ev_cntNotReady;
//#UC END# *479731C50290_4DFEF11703D8_impl*
end;//TevContentsNode.Cleanup

procedure TevContentsNode.Set_ChildNode(const aValue: Il3Node);
//#UC START# *4ADEEFA00164_4DFEF11703D8_var*
//#UC END# *4ADEEFA00164_4DFEF11703D8_var*
begin
//#UC START# *4ADEEFA00164_4DFEF11703D8_impl*
 f_ChildNode := aValue;
//#UC END# *4ADEEFA00164_4DFEF11703D8_impl*
end;//TevContentsNode.Set_ChildNode

procedure TevContentsNode.Set_ParentNode(const aValue: Il3Node);
//#UC START# *4DFF154E0063_4DFEF11703D8_var*
//#UC END# *4DFF154E0063_4DFEF11703D8_var*
begin
//#UC START# *4DFF154E0063_4DFEF11703D8_impl*
 f_ParentNode := Pointer(aValue);
//#UC END# *4DFF154E0063_4DFEF11703D8_impl*
end;//TevContentsNode.Set_ParentNode

procedure TevContentsNode.Set_PrevNode(const aValue: Il3Node);
//#UC START# *4DFF15710135_4DFEF11703D8_var*
//#UC END# *4DFF15710135_4DFEF11703D8_var*
begin
//#UC START# *4DFF15710135_4DFEF11703D8_impl*
 f_PrevNode := Pointer(aValue);
//#UC END# *4DFF15710135_4DFEF11703D8_impl*
end;//TevContentsNode.Set_PrevNode

procedure TevContentsNode.Set_NextNode(const aValue: Il3Node);
//#UC START# *4DFF15B3015B_4DFEF11703D8_var*
//#UC END# *4DFF15B3015B_4DFEF11703D8_var*
begin
//#UC START# *4DFF15B3015B_4DFEF11703D8_impl*
 f_NextNode := aValue;
//#UC END# *4DFF15B3015B_4DFEF11703D8_impl*
end;//TevContentsNode.Set_NextNode

function TevContentsNode.Get_AllChildrenCount: Integer;
//#UC START# *54C78C200291_4DFEF11703D8_var*
//#UC END# *54C78C200291_4DFEF11703D8_var*
begin
//#UC START# *54C78C200291_4DFEF11703D8_impl*
 if f_AllChildrenCount < 0 then
 begin
  Result := inherited Get_AllChildrenCount;
  f_AllChildrenCount := Result;
 end
 else
  Result := f_AllChildrenCount;
//#UC END# *54C78C200291_4DFEF11703D8_impl*
end;//TevContentsNode.Get_AllChildrenCount

function TevContentsNode.DoGetThisChildrenCount: Integer;
//#UC START# *54C78C8102DD_4DFEF11703D8_var*
//#UC END# *54C78C8102DD_4DFEF11703D8_var*
begin
//#UC START# *54C78C8102DD_4DFEF11703D8_impl*
 Result := f_ThisChildrenCount;
//#UC END# *54C78C8102DD_4DFEF11703D8_impl*
end;//TevContentsNode.DoGetThisChildrenCount

function TevContentsNode.Get_ParentNode: Il3Node;
//#UC START# *54C78E1002BE_4DFEF11703D8_var*
//#UC END# *54C78E1002BE_4DFEF11703D8_var*
begin
//#UC START# *54C78E1002BE_4DFEF11703D8_impl*
 Result := Il3Node(f_ParentNode);
//#UC END# *54C78E1002BE_4DFEF11703D8_impl*
end;//TevContentsNode.Get_ParentNode

function TevContentsNode.Get_ChildNode: Il3Node;
//#UC START# *54C78E2702B3_4DFEF11703D8_var*
//#UC END# *54C78E2702B3_4DFEF11703D8_var*
begin
//#UC START# *54C78E2702B3_4DFEF11703D8_impl*
 Result := f_ChildNode;
//#UC END# *54C78E2702B3_4DFEF11703D8_impl*
end;//TevContentsNode.Get_ChildNode

function TevContentsNode.Get_NextNode: Il3Node;
//#UC START# *54C78E370213_4DFEF11703D8_var*
//#UC END# *54C78E370213_4DFEF11703D8_var*
begin
//#UC START# *54C78E370213_4DFEF11703D8_impl*
 Result := f_NextNode;
//#UC END# *54C78E370213_4DFEF11703D8_impl*
end;//TevContentsNode.Get_NextNode

function TevContentsNode.Get_PrevNode: Il3Node;
//#UC START# *54C78E440118_4DFEF11703D8_var*
//#UC END# *54C78E440118_4DFEF11703D8_var*
begin
//#UC START# *54C78E440118_4DFEF11703D8_impl*
 if (f_PrevNode <> nil) then
  Result := Il3Node(f_PrevNode)
 else
  Result := nil;
//#UC END# *54C78E440118_4DFEF11703D8_impl*
end;//TevContentsNode.Get_PrevNode

function TevContentsNode.IsFirstNode: Boolean;
//#UC START# *54C78F5702CE_4DFEF11703D8_var*
var
 l_Node: Il3Node;
//#UC END# *54C78F5702CE_4DFEF11703D8_var*
begin
//#UC START# *54C78F5702CE_4DFEF11703D8_impl*
 l_Node := ParentNode;
 if l_Node = nil then
  Result := True
 else
 begin
  l_Node := l_Node.ChildNode;
  Result := (l_Node = nil) or l3IEQ(l_Node, Self);
 end;
//#UC END# *54C78F5702CE_4DFEF11703D8_impl*
end;//TevContentsNode.IsFirstNode

function TevContentsNode.IsLastNode: Boolean;
//#UC START# *54C78F8902C6_4DFEF11703D8_var*
var
 l_Node: Il3Node;
//#UC END# *54C78F8902C6_4DFEF11703D8_var*
begin
//#UC START# *54C78F8902C6_4DFEF11703D8_impl*
 l_Node := ParentNode;
 if l_Node = nil then
  Result := True
 else
 begin
  l_Node := l_Node.ChildNode;
  Result := (l_Node = nil) or l3IEQ(l_Node.Prev, Self);
 end;
//#UC END# *54C78F8902C6_4DFEF11703D8_impl*
end;//TevContentsNode.IsLastNode

function TevContentsNode.HasChildNode: Boolean;
//#UC START# *54C78FC902EA_4DFEF11703D8_var*
//#UC END# *54C78FC902EA_4DFEF11703D8_var*
begin
//#UC START# *54C78FC902EA_4DFEF11703D8_impl*
 Result := (ChildNode <> nil) or CheckChildren;
//#UC END# *54C78FC902EA_4DFEF11703D8_impl*
end;//TevContentsNode.HasChildNode

function TevContentsNode.IterateChild(Action: Tl3NodeAction;
 IterMode: Integer;
 const aFromNode: Il3Node = nil): Il3Node;
//#UC START# *54C8DFF102DD_4DFEF11703D8_var*
//#UC END# *54C8DFF102DD_4DFEF11703D8_var*
begin
//#UC START# *54C8DFF102DD_4DFEF11703D8_impl*
 if not l3TestMask(IterMode, imExpandOnly) then
  TryGetChildren;
 Result := inherited IterateChild(Action, IterMode, aFromNode);
//#UC END# *54C8DFF102DD_4DFEF11703D8_impl*
end;//TevContentsNode.IterateChild

procedure TevContentsNode.DoReleaseChilds;
//#UC START# *54C8E22F0223_4DFEF11703D8_var*
var
 l_CurNode  : Il3InternalNode;
 l_PrevNode : Il3InternalNode;
 l_IsLast   : Boolean;
//#UC END# *54C8E22F0223_4DFEF11703D8_var*
begin
//#UC START# *54C8E22F0223_4DFEF11703D8_impl*
 f_NodeState := ev_cntNotReady;
 if (f_ChildNode = nil) then
  Exit;
 l_CurNode := (f_ChildNode.PrevNode as Il3InternalNode); // Last
 repeat
  l_IsLast := l_CurNode.IsSame(f_ChildNode);
  l_PrevNode := (l_CurNode.PrevNode as Il3InternalNode);
  l_CurNode.ParentNode := nil;
  l_CurNode.NextNode := nil;
  l_CurNode._Release;
  l_CurNode := l_PrevNode;
 until l_IsLast;
 Set_ChildNode(nil);
 f_ThisChildrenCount := 0;
 AllChildrenCount := 0;
 Notify(ntChildClear, Self);
//#UC END# *54C8E22F0223_4DFEF11703D8_impl*
end;//TevContentsNode.DoReleaseChilds

procedure TevContentsNode.DoIncAllChildrenCount(aInc: Integer);
//#UC START# *54C8E4A8037A_4DFEF11703D8_var*
//#UC END# *54C8E4A8037A_4DFEF11703D8_var*
begin
//#UC START# *54C8E4A8037A_4DFEF11703D8_impl*
 if (aInc <> 0) then
 begin
  if (f_AllChildrenCount >= 0) then
   f_AllChildrenCount := f_AllChildrenCount + aInc
  else
   Get_AllChildrenCount;       
  if (ParentNode <> nil) then
   ParentNode.IncAllChildrenCount(aInc);
 end;
//#UC END# *54C8E4A8037A_4DFEF11703D8_impl*
end;//TevContentsNode.DoIncAllChildrenCount

end.
