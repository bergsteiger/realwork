unit NOT_COMPLETED_nsBaseNode;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Data\Tree\NOT_COMPLETED_nsBaseNode.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TnsBaseNode" MUID: (4ADDF4470087)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , nsPrimCacheableNode
 , l3Tree_TLB
 , BaseTreeSupportUnit
;

type
 InsCacheable = interface
  ['{DFCFB2AE-BBBB-44F4-963F-AB185ED1AAAB}']
  procedure ClearNums(aRecursive: Boolean);
  function Next: InsCacheable;
 end;//InsCacheable

 InsLastCache = interface
  ['{AF66F55C-8880-4568-A079-B9E5C2EC90E8}']
  function Get_LastChild: Il3Node;
  procedure Set_LastChild(const aValue: Il3Node);
  property LastChild: Il3Node
   read Get_LastChild
   write Set_LastChild;
 end;//InsLastCache

 TnsBaseNode = class(TnsPrimCacheableNode, InsCacheable, InsLastCache)
  private
   f_AllChildrenCount: Integer;
   f_ChildNode: Il3Node;
    {* Поле для свойства ChildNode }
   f_LastChild: Il3Node;
    {* Поле для свойства LastChild }
   f_NextNode: Il3Node;
    {* Поле для свойства NextNode }
  protected
   f_TotalNumInParent: Integer;
   f_ParentNode: Pointer;
   f_PrevNode: Pointer;
  protected
   function pm_GetLastChild: Il3Node;
   procedure pm_SetLastChild(const aValue: Il3Node);
   procedure ClearCache; virtual;
   procedure CallNextClearNums; virtual;
   procedure DoClearNums; virtual;
   function InsCacheableNext: InsCacheable;
   procedure InsCacheableClearNums(aRecursive: Boolean);
   procedure ClearNums(aRecursive: Boolean);
   function Next: InsCacheable;
   function Get_LastChild: Il3Node;
   procedure Set_LastChild(const aValue: Il3Node);
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure Set_ChildNode(const aValue: Il3Node); override;
   procedure ClearFields; override;
   function Get_AllChildrenCount: Integer; override;
   function Get_ChildNode: Il3Node; override;
   procedure DoSortChilds(const aChild: Il3Node = nil); override;
   function DoGetNumInParent(aOnlyOneLevel: Boolean = False): Integer; override;
   procedure DoReleaseChilds; override;
   procedure DoIncAllChildrenCount(aInc: Integer); override;
  public
   constructor Create(const aNode: INode;
    aNumInParent: Integer;
    aTotalNumInParent: Integer); reintroduce;
   class function Make(const aNode: INode;
    aNumInParent: Integer = -1;
    aTotalNumInParent: Integer = -1): Il3Node; reintroduce;
  public
   property ChildNode: Il3Node
    read f_ChildNode
    write f_ChildNode;
   property LastChild: Il3Node
    read pm_GetLastChild
    write pm_SetLastChild;
   property NextNode: Il3Node
    read f_NextNode
    write f_NextNode;
 end;//TnsBaseNode

implementation

uses
 l3ImplUses
 , SysUtils
 , l3Nodes
 , l3Types
 , l3TreeInterfaces
;

function TnsBaseNode.pm_GetLastChild: Il3Node;
//#UC START# *4ADEE7A00336_4ADDF4470087get_var*
//#UC END# *4ADEE7A00336_4ADDF4470087get_var*
begin
//#UC START# *4ADEE7A00336_4ADDF4470087get_impl*
 Result := f_LastChild;
//#UC END# *4ADEE7A00336_4ADDF4470087get_impl*
end;//TnsBaseNode.pm_GetLastChild

procedure TnsBaseNode.pm_SetLastChild(const aValue: Il3Node);
//#UC START# *4ADEE7A00336_4ADDF4470087set_var*
//#UC END# *4ADEE7A00336_4ADDF4470087set_var*
begin
//#UC START# *4ADEE7A00336_4ADDF4470087set_impl*
 f_LastChild := aValue;
//#UC END# *4ADEE7A00336_4ADDF4470087set_impl*
end;//TnsBaseNode.pm_SetLastChild

constructor TnsBaseNode.Create(const aNode: INode;
 aNumInParent: Integer;
 aTotalNumInParent: Integer);
//#UC START# *4AE05F2A0067_4ADDF4470087_var*
//#UC END# *4AE05F2A0067_4ADDF4470087_var*
begin
//#UC START# *4AE05F2A0067_4ADDF4470087_impl*
 DoClearNums;
 inherited Create(aNode, aNumInParent);
 f_AllChildrenCount := -1;
 f_TotalNumInParent := aTotalNumInParent;
//#UC END# *4AE05F2A0067_4ADDF4470087_impl*
end;//TnsBaseNode.Create

class function TnsBaseNode.Make(const aNode: INode;
 aNumInParent: Integer = -1;
 aTotalNumInParent: Integer = -1): Il3Node;
var
 l_Inst : TnsBaseNode;
begin
 l_Inst := Create(aNode, aNumInParent, aTotalNumInParent);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TnsBaseNode.Make

procedure TnsBaseNode.ClearCache;
//#UC START# *4ADEE7F1039D_4ADDF4470087_var*
//#UC END# *4ADEE7F1039D_4ADDF4470087_var*
begin
//#UC START# *4ADEE7F1039D_4ADDF4470087_impl*
 f_AdapterCaption := nil;
 f_AllChildrenCount := -1;
//#UC END# *4ADEE7F1039D_4ADDF4470087_impl*
end;//TnsBaseNode.ClearCache

procedure TnsBaseNode.CallNextClearNums;
//#UC START# *4ADEE7FC0068_4ADDF4470087_var*
var
 l_Cacheable : InsCacheable;
//#UC END# *4ADEE7FC0068_4ADDF4470087_var*
begin
//#UC START# *4ADEE7FC0068_4ADDF4470087_impl*
 l_Cacheable := InsCacheableNext;
 while (l_Cacheable <> nil) do
 begin
  l_Cacheable.ClearNums(false);
  l_Cacheable := l_Cacheable.Next;
 end;//while (l_Cacheable
//#UC END# *4ADEE7FC0068_4ADDF4470087_impl*
end;//TnsBaseNode.CallNextClearNums

procedure TnsBaseNode.DoClearNums;
//#UC START# *4ADEE99702C7_4ADDF4470087_var*
//#UC END# *4ADEE99702C7_4ADDF4470087_var*
begin
//#UC START# *4ADEE99702C7_4ADDF4470087_impl*
 f_NumInParent := -1;
 f_TotalNumInParent := -1;
//#UC END# *4ADEE99702C7_4ADDF4470087_impl*
end;//TnsBaseNode.DoClearNums

function TnsBaseNode.InsCacheableNext: InsCacheable;
//#UC START# *4ADEE9B203C9_4ADDF4470087_var*
//#UC END# *4ADEE9B203C9_4ADDF4470087_var*
begin
//#UC START# *4ADEE9B203C9_4ADDF4470087_impl*
 Supports(f_NextNode, InsCacheable, Result);
//#UC END# *4ADEE9B203C9_4ADDF4470087_impl*
end;//TnsBaseNode.InsCacheableNext

procedure TnsBaseNode.InsCacheableClearNums(aRecursive: Boolean);
//#UC START# *4ADEE9D002E9_4ADDF4470087_var*
//#UC END# *4ADEE9D002E9_4ADDF4470087_var*
begin
//#UC START# *4ADEE9D002E9_4ADDF4470087_impl*
 DoClearNums;
 if aRecursive then
  CallNextClearNums;
//#UC END# *4ADEE9D002E9_4ADDF4470087_impl*
end;//TnsBaseNode.InsCacheableClearNums

procedure TnsBaseNode.ClearNums(aRecursive: Boolean);
//#UC START# *4ADEE648003C_4ADDF4470087_var*
//#UC END# *4ADEE648003C_4ADDF4470087_var*
begin
//#UC START# *4ADEE648003C_4ADDF4470087_impl*
 InsCacheableClearNums(aRecursive);
//#UC END# *4ADEE648003C_4ADDF4470087_impl*
end;//TnsBaseNode.ClearNums

function TnsBaseNode.Next: InsCacheable;
//#UC START# *4ADEE659029C_4ADDF4470087_var*
//#UC END# *4ADEE659029C_4ADDF4470087_var*
begin
//#UC START# *4ADEE659029C_4ADDF4470087_impl*
 Result := InsCacheableNext;
//#UC END# *4ADEE659029C_4ADDF4470087_impl*
end;//TnsBaseNode.Next

function TnsBaseNode.Get_LastChild: Il3Node;
//#UC START# *4ADEE67A002B_4ADDF4470087get_var*
//#UC END# *4ADEE67A002B_4ADDF4470087get_var*
begin
//#UC START# *4ADEE67A002B_4ADDF4470087get_impl*
 Result := LastChild;
//#UC END# *4ADEE67A002B_4ADDF4470087get_impl*
end;//TnsBaseNode.Get_LastChild

procedure TnsBaseNode.Set_LastChild(const aValue: Il3Node);
//#UC START# *4ADEE67A002B_4ADDF4470087set_var*
//#UC END# *4ADEE67A002B_4ADDF4470087set_var*
begin
//#UC START# *4ADEE67A002B_4ADDF4470087set_impl*
 LastChild := aValue;
//#UC END# *4ADEE67A002B_4ADDF4470087set_impl*
end;//TnsBaseNode.Set_LastChild

procedure TnsBaseNode.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4ADDF4470087_var*
//#UC END# *479731C50290_4ADDF4470087_var*
begin
//#UC START# *479731C50290_4ADDF4470087_impl*
 ClearCache;
 inherited;
//#UC END# *479731C50290_4ADDF4470087_impl*
end;//TnsBaseNode.Cleanup

procedure TnsBaseNode.Set_ChildNode(const aValue: Il3Node);
//#UC START# *4ADEEFA00164_4ADDF4470087_var*
//#UC END# *4ADEEFA00164_4ADDF4470087_var*
begin
//#UC START# *4ADEEFA00164_4ADDF4470087_impl*
 ChildNode := aValue;
//#UC END# *4ADEEFA00164_4ADDF4470087_impl*
end;//TnsBaseNode.Set_ChildNode

procedure TnsBaseNode.ClearFields;
begin
 ChildNode := nil;
 LastChild := nil;
 NextNode := nil;
 inherited;
end;//TnsBaseNode.ClearFields

function TnsBaseNode.Get_AllChildrenCount: Integer;
//#UC START# *54C78C200291_4ADDF4470087_var*
 procedure CountChild(const aNode: Il3Node);
 begin
  Inc(Result, aNode.AllChildrenCount);
  Inc(Result);
 end;
//#UC END# *54C78C200291_4ADDF4470087_var*
begin
//#UC START# *54C78C200291_4ADDF4470087_impl*
 if (f_AllChildrenCount < 0) then
 begin
  Result := 0;
  IterateF(l3L2NA(@CountChild), imOneLevel);
  f_AllChildrenCount := Result;
 end
 else
  Result := f_AllChildrenCount;
//#UC END# *54C78C200291_4ADDF4470087_impl*
end;//TnsBaseNode.Get_AllChildrenCount

function TnsBaseNode.Get_ChildNode: Il3Node;
//#UC START# *54C78E2702B3_4ADDF4470087_var*
//#UC END# *54C78E2702B3_4ADDF4470087_var*
begin
//#UC START# *54C78E2702B3_4ADDF4470087_impl*
 Result := ChildNode;
//#UC END# *54C78E2702B3_4ADDF4470087_impl*
end;//TnsBaseNode.Get_ChildNode

procedure TnsBaseNode.DoSortChilds(const aChild: Il3Node = nil);
//#UC START# *54C8E0850062_4ADDF4470087_var*
var
 lChild,
 lNextNode,
 lNextOfChild : Il3InternalNode;

 lEndList     : Boolean;

 lUserParam   : Pointer;

 procedure lpMoveNode(const aMoveNode : Il3InternalNode;
                      const aNextNode : Il3InternalNode);
 begin
  // Если aMoveNode и так стоит перед aNextNode или она единственная, то ничего делать не надо
  if (not aMoveNode.IsLast and (aMoveNode.NextNode As Il3InternalNode).IsSame(aNextNode)) or
     (aMoveNode.IsFirst and aMoveNode.IsLast) then
   exit;

  Notify(ntMoveBegin, aMoveNode);
  try
   lUserParam := nil;
   aMoveNode.BeginMove(lUserParam);
   try
    // aMoveNode перемещается из конца списка
    if aMoveNode.IsLast then
     LastChild := aMoveNode.PrevNode
    else
     if not aMoveNode.IsFirst then
      (aMoveNode.NextNode As Il3InternalNode).PrevNode := aMoveNode.PrevNode
     else
      (aMoveNode.NextNode As Il3InternalNode).PrevNode := nil;

    // aMoveNode перемещается из начала списка
    if aMoveNode.IsFirst then
     ChildNode := aMoveNode.NextNode
    else
     if not aMoveNode.IsLast then
      (aMoveNode.PrevNode As Il3InternalNode).NextNode := aMoveNode.NextNode
     else
      (aMoveNode.PrevNode As Il3InternalNode).NextNode := nil;

    
    // aMoveNode перемещается в конец списка
    if aNextNode = nil then
    begin
     aMoveNode.NextNode := nil;
     aMoveNode.PrevNode := LastChild;
     (aMoveNode.PrevNode As Il3InternalNode).NextNode := aMoveNode;
     LastChild := aMoveNode;
    end
    else
     // aMoveNode перемещается в начало списка
     if aNextNode.IsFirst then
     begin
      ChildNode := aMoveNode;
      aMoveNode.PrevNode := nil;
      aMoveNode.NextNode := aNextNode;
      aNextNode.PrevNode := aMoveNode;
     end
     else
     begin
      // вставляем aMoveNode перед aNextNode
      aMoveNode.PrevNode := aNextNode.PrevNode;
      aMoveNode.NextNode := aNextNode;
      (aNextNode.PrevNode As Il3InternalNode).NextNode := aMoveNode;
      aNextNode.PrevNode := aMoveNode;
     end;

    // Cбрасываем закэшированные NumInParent и TotalNumInParent
    (aMoveNode as InsCacheable).ClearNums(true);
   finally
    aMoveNode.EndMove(lUserParam);
   end;//try..finally
  finally
   Notify(ntMoveEnd, aMoveNode);
  end;//try..finally
 end;//lpMoveNode
//#UC END# *54C8E0850062_4ADDF4470087_var*
begin
//#UC START# *54C8E0850062_4ADDF4470087_impl*
 if not HasChild or // если в текущей ветке нет детей или
    ChildNode.IsLast then // если в ветке всего один элемент - то ничего делать не надо
  exit;

 if (aChild <> nil) then // Позиционирование указанного элемента относительно остальных детей
 begin
  // Позиционирование указанного элемента относительно остальных детей
  if not IsSame(aChild.ParentNode) then
   exit;

  lNextNode := (ChildNode as Il3InternalNode);
  lChild := aChild as Il3InternalNode;

  // Ищем позицию для перемещения для lСhild, начиная с lNextNode
  while true do
  begin
   if not lChild.IsSame(lNextNode) then
   begin
    if CompareChild(lChild, lNextNode) < 0 then
     Break; // позиция для перемещения найдена
   end;//not lChild.IsSameNode(lNextNode)

   lNextNode := lNextNode.NextNode as Il3InternalNode;

   if lNextNode.IsFirst then // просмотрен весь список детей
   begin
    lNextNode := nil; // будем перемещать lChild в конец списка.
    Break;
   end;
  end;//while true

  lpMoveNode(lChild, lNextNode); // перемещение
 end//aChild <> nil
 else // Сортировка всех детей в ветке
 begin
  lChild := ChildNode.NextNode as Il3InternalNode;
  lEndList := lChild.IsLast;
  while true do
  begin
   lNextNode := ChildNode as Il3InternalNode;

   while true do
   begin
    if not lChild.IsSame(lNextNode) then
    begin
     if (CompareChild(lChild, lNextNode) < 0) then
     begin
      lNextOfChild := lChild.NextNode as Il3InternalNode;
      if lNextNode.IsLast then
       lpMoveNode(lChild, nil)
      else
       lpMoveNode(lChild, lNextNode);
      lChild := lNextOfChild;
      Break;
     end
    end
    else
    begin
     lChild := lChild.NextNode as Il3InternalNode;
     Break;
    end;
    lNextNode := lNextNode.NextNode as Il3InternalNode;
   end;//while true

   if lEndList then Break; {конец списка}
   lEndList := lChild.IsLast;
  end;//while true
 end;//aChild <> nil
//#UC END# *54C8E0850062_4ADDF4470087_impl*
end;//TnsBaseNode.DoSortChilds

function TnsBaseNode.DoGetNumInParent(aOnlyOneLevel: Boolean = False): Integer;
//#UC START# *54C8E1F30128_4ADDF4470087_var*
//#UC END# *54C8E1F30128_4ADDF4470087_var*
begin
//#UC START# *54C8E1F30128_4ADDF4470087_impl*
 if aOnlyOneLevel then
  Result := inherited DoGetNumInParent(aOnlyOneLevel)
 else
 begin
  if (f_TotalNumInParent < 0) then
   f_TotalNumInParent := inherited DoGetNumInParent(false);
  Result := f_TotalNumInParent;
 end;//aOnlyOneLevel
//#UC END# *54C8E1F30128_4ADDF4470087_impl*
end;//TnsBaseNode.DoGetNumInParent

procedure TnsBaseNode.DoReleaseChilds;
//#UC START# *54C8E22F0223_4ADDF4470087_var*
//#UC END# *54C8E22F0223_4ADDF4470087_var*
begin
//#UC START# *54C8E22F0223_4ADDF4470087_impl*
 Notify(ntChildClear, Self);
 AllChildrenCount := 0;
 ChildNode := nil;
 AdapterNode := nil;
 LastChild := nil;
//#UC END# *54C8E22F0223_4ADDF4470087_impl*
end;//TnsBaseNode.DoReleaseChilds

procedure TnsBaseNode.DoIncAllChildrenCount(aInc: Integer);
//#UC START# *54C8E4A8037A_4ADDF4470087_var*
//#UC END# *54C8E4A8037A_4ADDF4470087_var*
begin
//#UC START# *54C8E4A8037A_4ADDF4470087_impl*
 if (aInc <> 0) then
 begin
  if (f_AllChildrenCount >= 0) then
   f_AllChildrenCount := f_AllChildrenCount + aInc
  else
   AllChildrenCount;

  if (ParentNode <> nil) then ParentNode.IncAllChildrenCount(aInc);
  CallNextClearNums;
 end;
//#UC END# *54C8E4A8037A_4ADDF4470087_impl*
end;//TnsBaseNode.DoIncAllChildrenCount

end.
