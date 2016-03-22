unit eeNode;

// Модуль: "w:\common\components\gui\Garant\Everest_Engine\eeNode.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TeeNode" MUID: (4AE8269E010D)

{$Include w:\common\components\gui\Garant\Everest_Engine\eeDefine.inc}

interface

uses
 l3IntfUses
 , l3CacheableBase
 , eeInterfaces
 , l3TreeInterfaces
 , l3Interfaces
 , l3IID
;

type
 TeeNode = class(Tl3CacheableBase, IeeNode)
  private
   f_Node: Il3SimpleNode;
  protected
   function Get_Text: Il3CString;
   procedure Set_Text(const aValue: Il3CString);
   function Get_ID: Integer;
   procedure Set_ID(aValue: Integer);
   function Get_HasChild: Boolean;
   function Get_IsFirst: Boolean;
   function Get_IsLast: Boolean;
   function Get_ChildNode: IeeNode;
   function Get_ParentNode: IeeNode;
   function Get_NextNode: IeeNode;
   function Get_PrevNode: IeeNode;
   function Get_AllChildrenCount: Integer;
   function Get_ThisChildrenCount: Integer;
   function InsertChild(const aNode: IeeNode): IeeNode;
   function InsertChildBefore(const aNextChild: IeeNode;
    const aChild: IeeNode): IeeNode;
   procedure Changing;
   procedure Changed;
   procedure Remove;
   procedure Delete;
   procedure RemoveChildren;
   function Move(aDirection: TeeDirection): Boolean;
   procedure RelocateChild(const aChild: IeeNode);
    {* перемещает указанного ребенка, руководствуясь критериями сортировки относительно других детей (в пределах одного уровня) }
   procedure SortChilds;
   function GetLevelForParent(const aParent: IeeNode): Integer;
    {* Рассчитывает уровень текущей ноды относительно заданного Paretnt'а }
   function Iterate(anAction: TeeNodeAction;
    anIterMode: Integer = 0;
    const aFromNode: IeeNode = nil): IeeNode;
    {* перебрать все дочерние узлы. IterMode см. imExpandOnly etc. }
   function IterateF(anAction: TeeNodeAction;
    anIterMode: Integer = 0;
    const aFromNode: IeeNode = nil): IeeNode;
    {* перебрать все дочерние узлы и освободить заглушку для Action }
   function IsSameNode(const aNode: IeeNode): Boolean;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   function COMQueryInterface(const IID: Tl3GUID;
    out Obj): Tl3HResult; override;
    {* Реализация запроса интерфейса }
  public
   constructor Create(const aNode: Il3SimpleNode); reintroduce;
   class function Make(const aNode: Il3SimpleNode): IeeNode;
 end;//TeeNode

implementation

uses
 l3ImplUses
 , eeNodeUtils
 , SysUtils
 , l3Base
 , l3Tree_TLB
 , l3Types
 , l3String
 , l3Nodes
 , l3InterfacesMisc
;

constructor TeeNode.Create(const aNode: Il3SimpleNode);
//#UC START# *54C4FE700267_4AE8269E010D_var*
//#UC END# *54C4FE700267_4AE8269E010D_var*
begin
//#UC START# *54C4FE700267_4AE8269E010D_impl*
 inherited Create;
 f_Node := aNode;
//#UC END# *54C4FE700267_4AE8269E010D_impl*
end;//TeeNode.Create

class function TeeNode.Make(const aNode: Il3SimpleNode): IeeNode;
//#UC START# *54C4FE8501CA_4AE8269E010D_var*
var
 l_Node : TeeNode;
//#UC END# *54C4FE8501CA_4AE8269E010D_var*
begin
//#UC START# *54C4FE8501CA_4AE8269E010D_impl*
 if (aNode = nil) then
  Result := nil
 else
 if not Supports(aNode, IeeNode, Result) then
  // - если aNode сама не поддерживает IeeNode, то делаем узел-заглушку
 begin
  l_Node := Create(aNode);
  try
   Result := l_Node;
  finally
   l3Free(l_Node);
  end;//try..finally
 end;//not Supports(aNode, IeeNode, Result)
//#UC END# *54C4FE8501CA_4AE8269E010D_impl*
end;//TeeNode.Make

function TeeNode.Get_Text: Il3CString;
//#UC START# *5481A1AD011A_4AE8269E010Dget_var*
//#UC END# *5481A1AD011A_4AE8269E010Dget_var*
begin
//#UC START# *5481A1AD011A_4AE8269E010Dget_impl*
 Result := l3CStr(f_Node);
//#UC END# *5481A1AD011A_4AE8269E010Dget_impl*
end;//TeeNode.Get_Text

procedure TeeNode.Set_Text(const aValue: Il3CString);
//#UC START# *5481A1AD011A_4AE8269E010Dset_var*
var
 ll3Node : Il3Node;
//#UC END# *5481A1AD011A_4AE8269E010Dset_var*
begin
//#UC START# *5481A1AD011A_4AE8269E010Dset_impl*
 if Supports(f_Node, Il3Node, ll3Node) then
  try
   ll3Node.Text := l3PCharLen(aValue);
  finally
   ll3Node := nil;
  end//try..finally
 else
  Assert(false); 
//#UC END# *5481A1AD011A_4AE8269E010Dset_impl*
end;//TeeNode.Set_Text

function TeeNode.Get_ID: Integer;
//#UC START# *5481A1C0038D_4AE8269E010Dget_var*
//#UC END# *5481A1C0038D_4AE8269E010Dget_var*
begin
//#UC START# *5481A1C0038D_4AE8269E010Dget_impl*
 Result := (f_Node As Il3HandleNode).Handle;
//#UC END# *5481A1C0038D_4AE8269E010Dget_impl*
end;//TeeNode.Get_ID

procedure TeeNode.Set_ID(aValue: Integer);
//#UC START# *5481A1C0038D_4AE8269E010Dset_var*
//#UC END# *5481A1C0038D_4AE8269E010Dset_var*
begin
//#UC START# *5481A1C0038D_4AE8269E010Dset_impl*
 (f_Node As Il3HandleNode).Handle := aValue;
//#UC END# *5481A1C0038D_4AE8269E010Dset_impl*
end;//TeeNode.Set_ID

function TeeNode.Get_HasChild: Boolean;
//#UC START# *5481A1D103AF_4AE8269E010Dget_var*
//#UC END# *5481A1D103AF_4AE8269E010Dget_var*
begin
//#UC START# *5481A1D103AF_4AE8269E010Dget_impl*
 if (f_Node = nil) then
  Result := false
 else
  Result := f_Node.HasChild;
//#UC END# *5481A1D103AF_4AE8269E010Dget_impl*
end;//TeeNode.Get_HasChild

function TeeNode.Get_IsFirst: Boolean;
//#UC START# *5481A1DD0225_4AE8269E010Dget_var*
//#UC END# *5481A1DD0225_4AE8269E010Dget_var*
begin
//#UC START# *5481A1DD0225_4AE8269E010Dget_impl*
 if (f_Node = nil) then
  Result := true
 else
  Result := f_Node.IsFirst;
//#UC END# *5481A1DD0225_4AE8269E010Dget_impl*
end;//TeeNode.Get_IsFirst

function TeeNode.Get_IsLast: Boolean;
//#UC START# *5481A1EA00F3_4AE8269E010Dget_var*
//#UC END# *5481A1EA00F3_4AE8269E010Dget_var*
begin
//#UC START# *5481A1EA00F3_4AE8269E010Dget_impl*
 if (f_Node = nil) then
  Result := true
 else
  Result := f_Node.IsLast;
//#UC END# *5481A1EA00F3_4AE8269E010Dget_impl*
end;//TeeNode.Get_IsLast

function TeeNode.Get_ChildNode: IeeNode;
//#UC START# *5481A22C010D_4AE8269E010Dget_var*
//#UC END# *5481A22C010D_4AE8269E010Dget_var*
begin
//#UC START# *5481A22C010D_4AE8269E010Dget_impl*
 if (f_Node = nil) then
  Result := nil
 else
  Result := TeeNode.Make(f_Node.Child);
//#UC END# *5481A22C010D_4AE8269E010Dget_impl*
end;//TeeNode.Get_ChildNode

function TeeNode.Get_ParentNode: IeeNode;
//#UC START# *5481A2410045_4AE8269E010Dget_var*
//#UC END# *5481A2410045_4AE8269E010Dget_var*
begin
//#UC START# *5481A2410045_4AE8269E010Dget_impl*
 if (f_Node = nil) then
  Result := nil
 else
  Result := TeeNode.Make(f_Node.Parent);
//#UC END# *5481A2410045_4AE8269E010Dget_impl*
end;//TeeNode.Get_ParentNode

function TeeNode.Get_NextNode: IeeNode;
//#UC START# *5481A2510256_4AE8269E010Dget_var*
var
 lNode : Il3Node;
//#UC END# *5481A2510256_4AE8269E010Dget_var*
begin
//#UC START# *5481A2510256_4AE8269E010Dget_impl*
 if (f_Node = nil) then
  Result := nil
 else
 if Supports(f_Node, Il3Node, lNode) then
 try
  Result := TeeNode.Make(lNode.NextNode);
 finally
  lNode := nil;
 end
 else
  Assert(false);
//#UC END# *5481A2510256_4AE8269E010Dget_impl*
end;//TeeNode.Get_NextNode

function TeeNode.Get_PrevNode: IeeNode;
//#UC START# *5481A26001CF_4AE8269E010Dget_var*
var
 lNode : Il3Node;
//#UC END# *5481A26001CF_4AE8269E010Dget_var*
begin
//#UC START# *5481A26001CF_4AE8269E010Dget_impl*
 if (f_Node = nil) then
  Result := nil
 else
 if Supports(f_Node, Il3Node, lNode) then
 try
  Result := TeeNode.Make(lNode.PrevNode);
 finally
  lNode := nil;
 end
 else
  Assert(false);
//#UC END# *5481A26001CF_4AE8269E010Dget_impl*
end;//TeeNode.Get_PrevNode

function TeeNode.Get_AllChildrenCount: Integer;
//#UC START# *5481A29002A5_4AE8269E010Dget_var*
var
 lNode : Il3Node;
//#UC END# *5481A29002A5_4AE8269E010Dget_var*
begin
//#UC START# *5481A29002A5_4AE8269E010Dget_impl*
 if (f_Node = nil) then
  Result := 0
 else
 begin
  if Supports(f_Node, Il3Node, lNode) then
  try
   Result := lNode.AllChildrenCount;
  finally
   lNode := nil;
  end
  else
  begin
   Assert(False);
   Result := -1;
  end;
 end;
//#UC END# *5481A29002A5_4AE8269E010Dget_impl*
end;//TeeNode.Get_AllChildrenCount

function TeeNode.Get_ThisChildrenCount: Integer;
//#UC START# *5481A2990264_4AE8269E010Dget_var*
//#UC END# *5481A2990264_4AE8269E010Dget_var*
begin
//#UC START# *5481A2990264_4AE8269E010Dget_impl*
 if (f_Node = nil) then
  Result := 0
 else
  Result := f_Node.ThisChildrenCount;
//#UC END# *5481A2990264_4AE8269E010Dget_impl*
end;//TeeNode.Get_ThisChildrenCount

function TeeNode.InsertChild(const aNode: IeeNode): IeeNode;
//#UC START# *5481A2AF0022_4AE8269E010D_var*
var
 l_Node, l_Node1 : Il3Node;
//#UC END# *5481A2AF0022_4AE8269E010D_var*
begin
//#UC START# *5481A2AF0022_4AE8269E010D_impl*
 if (f_Node = nil) then
  Result := nil
 else if Supports(aNode, Il3Node, l_Node) then
  try
   Result := aNode;
   if Supports(f_Node, Il3Node, l_Node1) then
    try
     l_Node1.InsertChild(l_Node);
    finally
     l_Node1 := nil;
    end
   else
    Assert(false); 
  finally
   l_Node := nil;
  end//try..finally
 else
  Result := nil;
//#UC END# *5481A2AF0022_4AE8269E010D_impl*
end;//TeeNode.InsertChild

function TeeNode.InsertChildBefore(const aNextChild: IeeNode;
 const aChild: IeeNode): IeeNode;
//#UC START# *5481A2C20167_4AE8269E010D_var*
var
 l_NextChild,
 l_Child,
 l_Node : Il3Node;
//#UC END# *5481A2C20167_4AE8269E010D_var*
begin
//#UC START# *5481A2C20167_4AE8269E010D_impl*
 if (f_Node = nil) then
  Result := nil
 else
  if Supports(aChild, Il3Node, l_Child) and
     Supports(aNextChild, Il3Node, l_NextChild) then
   try
    Result := aChild;
    if Supports(f_Node, Il3Node, l_Node) then
     try
      l_Node.InsertChildBefore(l_NextChild, l_Child);
     finally
      l_Node := nil;
     end
    else
     Assert(false); 
   finally
    l_Child := nil;
    l_NextChild := nil;
   end//try..finally
  else
   Result := nil;
//#UC END# *5481A2C20167_4AE8269E010D_impl*
end;//TeeNode.InsertChildBefore

procedure TeeNode.Changing;
//#UC START# *5481A2D702C7_4AE8269E010D_var*
var
 lNode : Il3Node;
//#UC END# *5481A2D702C7_4AE8269E010D_var*
begin
//#UC START# *5481A2D702C7_4AE8269E010D_impl*
 if Supports(f_Node, Il3Node, lNode) then
  try
   lNode.Changing;
  finally
   lNode := nil;
  end;
//#UC END# *5481A2D702C7_4AE8269E010D_impl*
end;//TeeNode.Changing

procedure TeeNode.Changed;
//#UC START# *5481A2DF0031_4AE8269E010D_var*
var
 lNode : Il3Node;
//#UC END# *5481A2DF0031_4AE8269E010D_var*
begin
//#UC START# *5481A2DF0031_4AE8269E010D_impl*
 if Supports(f_Node, Il3Node, lNode) then
  try
   lNode.Changed;
  finally
   lNode := nil;
  end;
//#UC END# *5481A2DF0031_4AE8269E010D_impl*
end;//TeeNode.Changed

procedure TeeNode.Remove;
//#UC START# *5481A2E8004B_4AE8269E010D_var*
var
 lNode : Il3Node;
//#UC END# *5481A2E8004B_4AE8269E010D_var*
begin
//#UC START# *5481A2E8004B_4AE8269E010D_impl*
 if Supports(f_Node, Il3Node, lNode) then
  try
   lNode.Remove;
  finally
   lNode := nil;
  end
 else
  Assert(false);
//#UC END# *5481A2E8004B_4AE8269E010D_impl*
end;//TeeNode.Remove

procedure TeeNode.Delete;
//#UC START# *5481A2F3014C_4AE8269E010D_var*
var
 lNode : Il3Node;
//#UC END# *5481A2F3014C_4AE8269E010D_var*
begin
//#UC START# *5481A2F3014C_4AE8269E010D_impl*
 if Supports(f_Node, Il3Node, lNode) then
  try
   lNode.Delete;
  finally
   lNode := nil;
  end
 else
  Assert(false); 
//#UC END# *5481A2F3014C_4AE8269E010D_impl*
end;//TeeNode.Delete

procedure TeeNode.RemoveChildren;
//#UC START# *5481A2FC0099_4AE8269E010D_var*
var
 lNode : Il3Node;
//#UC END# *5481A2FC0099_4AE8269E010D_var*
begin
//#UC START# *5481A2FC0099_4AE8269E010D_impl*
 if Supports(f_Node, Il3Node, lNode) then
  try
   lNode.ReleaseChilds;
  finally
   lNode := nil;
  end
 else
  Assert(false); 
//#UC END# *5481A2FC0099_4AE8269E010D_impl*
end;//TeeNode.RemoveChildren

function TeeNode.Move(aDirection: TeeDirection): Boolean;
//#UC START# *5481A30602F5_4AE8269E010D_var*
var
 lNode : Il3Node;
//#UC END# *5481A30602F5_4AE8269E010D_var*
begin
//#UC START# *5481A30602F5_4AE8269E010D_impl*
 Result := False;
 if (f_Node = nil) then
  Result := False
 else
 begin
  if Supports(f_Node, Il3Node, lNode) then
   try
    Result := lNode.Move(eeDirection2l3Direction(aDirection));
   finally
    lNode := nil;
   end
  else
   Assert(false); 
 end;
//#UC END# *5481A30602F5_4AE8269E010D_impl*
end;//TeeNode.Move

procedure TeeNode.RelocateChild(const aChild: IeeNode);
 {* перемещает указанного ребенка, руководствуясь критериями сортировки относительно других детей (в пределах одного уровня) }
//#UC START# *5481A3190230_4AE8269E010D_var*
var
 l_Child,
 l_Node : Il3Node;
//#UC END# *5481A3190230_4AE8269E010D_var*
begin
//#UC START# *5481A3190230_4AE8269E010D_impl*
 if (f_Node <> nil) and
   Supports(aChild, Il3Node, l_Child) then
  try
   if Supports(f_Node, Il3Node, l_Node) then
    try
     l_Node.SortChilds(l_Child);
    finally
     l_Node := nil;
    end
   else
    Assert(false); 
  finally
   l_Child := nil;
  end;//try..finally
//#UC END# *5481A3190230_4AE8269E010D_impl*
end;//TeeNode.RelocateChild

procedure TeeNode.SortChilds;
//#UC START# *5481A34602C4_4AE8269E010D_var*
var
 lNode : Il3Node;
//#UC END# *5481A34602C4_4AE8269E010D_var*
begin
//#UC START# *5481A34602C4_4AE8269E010D_impl*
 if (f_Node <> nil) then
 begin
  if Supports(f_Node, Il3Node, lNode) then
   try
    lNode.SortChilds(nil);
   finally
    lNode := nil;
   end
  else
   Assert(false); 
 end;
//#UC END# *5481A34602C4_4AE8269E010D_impl*
end;//TeeNode.SortChilds

function TeeNode.GetLevelForParent(const aParent: IeeNode): Integer;
 {* Рассчитывает уровень текущей ноды относительно заданного Paretnt'а }
//#UC START# *5481A3590043_4AE8269E010D_var*
var
 l_Parent : Il3SimpleNode;
 l_Node   : Il3SimpleNode;
//#UC END# *5481A3590043_4AE8269E010D_var*
begin
//#UC START# *5481A3590043_4AE8269E010D_impl*
 if (f_Node = nil) then
  Result := -1
 else
  if Supports(aParent, Il3SimpleNode, l_Parent) then
   try
    if Supports(f_Node, Il3SimpleNode, l_Node) then
     try
      Result := l_Node.GetLevelFor(l_Parent);
     finally
      l_Node := nil;
     end//try..finally
    else
    begin
     Assert(false);
     Result := -1;
    end;
   finally
    l_Parent := nil;
   end//try..finally
  else
   Result := -1;
//#UC END# *5481A3590043_4AE8269E010D_impl*
end;//TeeNode.GetLevelForParent

function TeeNode.Iterate(anAction: TeeNodeAction;
 anIterMode: Integer = 0;
 const aFromNode: IeeNode = nil): IeeNode;
 {* перебрать все дочерние узлы. IterMode см. imExpandOnly etc. }
//#UC START# *5481A3900306_4AE8269E010D_var*
 function l_CheckNode(const aNode: Il3Node): Boolean;
 begin
  Result := anAction(TeeNode.Make(aNode));
 end;

var
 l_FromNode : Il3Node;
 l_Node     : Il3Node;
//#UC END# *5481A3900306_4AE8269E010D_var*
begin
//#UC START# *5481A3900306_4AE8269E010D_impl*
 if (f_Node = nil) then
  Result := nil
 else
 begin
  Supports(aFromNode, Il3Node, l_FromNode);
  try
   if Supports(f_Node, Il3Node, l_Node) then
    try
     Result := TeeNode.Make(l_Node.IterateF(l3L2NA(@l_CheckNode), anIterMode, l_FromNode));
    finally
     l_Node := nil;
    end
   else
    Assert(false); 
  finally
   l_FromNode := nil;
  end;
 end;//f_Node = nil
//#UC END# *5481A3900306_4AE8269E010D_impl*
end;//TeeNode.Iterate

function TeeNode.IterateF(anAction: TeeNodeAction;
 anIterMode: Integer = 0;
 const aFromNode: IeeNode = nil): IeeNode;
 {* перебрать все дочерние узлы и освободить заглушку для Action }
//#UC START# *5481A3D0039F_4AE8269E010D_var*
//#UC END# *5481A3D0039F_4AE8269E010D_var*
begin
//#UC START# *5481A3D0039F_4AE8269E010D_impl*
 try
  Result := Iterate(anAction, anIterMode, aFromNode);
 finally
  l3FreeFA(Tl3FreeAction(anAction));
 end;//try..finally
//#UC END# *5481A3D0039F_4AE8269E010D_impl*
end;//TeeNode.IterateF

function TeeNode.IsSameNode(const aNode: IeeNode): Boolean;
//#UC START# *5481B02B03C1_4AE8269E010D_var*
var
 l_Node : Il3Node;
//#UC END# *5481B02B03C1_4AE8269E010D_var*
begin
//#UC START# *5481B02B03C1_4AE8269E010D_impl*
 Result := l3IEQ(Self, aNode);
 if not Result then
 begin
  if (f_Node = nil) then
   Result := (aNode = nil)
  else
  begin
   if Supports(aNode, Il3SimpleNode, l_Node) then
    try
     Result := f_Node.IsSame(l_Node);
    finally
     l_Node := nil;
    end;//try..finally
  end;//f_Node = nil
 end;//not Result
//#UC END# *5481B02B03C1_4AE8269E010D_impl*
end;//TeeNode.IsSameNode

procedure TeeNode.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4AE8269E010D_var*
//#UC END# *479731C50290_4AE8269E010D_var*
begin
//#UC START# *479731C50290_4AE8269E010D_impl*
 f_Node := nil;
 inherited;
//#UC END# *479731C50290_4AE8269E010D_impl*
end;//TeeNode.Cleanup

function TeeNode.COMQueryInterface(const IID: Tl3GUID;
 out Obj): Tl3HResult;
 {* Реализация запроса интерфейса }
//#UC START# *4A60B23E00C3_4AE8269E010D_var*
//#UC END# *4A60B23E00C3_4AE8269E010D_var*
begin
//#UC START# *4A60B23E00C3_4AE8269E010D_impl*
 if IID.EQ(Il3SimpleNode) then
 begin
  if (f_Node = nil) then
   Result.SetNoInterface
  else
  begin
   Result.SetOk;
   Il3SimpleNode(Obj) := f_Node;
  end;//f_Node = nil
 end//IID.EQ(Il3SimpleNode)
 else
 if IID.EQ(Il3Node) then
 begin
  if (f_Node = nil) then
   Result.SetNoInterface
  else
   Result := Tl3HResult_C(f_Node.QueryInterface(IID.IID, Obj));
 end//IID.EQ(Il3Node)
 else
 if IID.EQ(Il3RootNode) then
 begin
  if Supports(f_Node, IID.IID, Obj) then
   Result.SetOk
  else
   Result.SetNoInterface;
 end//IID.EQ(Il3RootNode)
 else
 begin
  Result := inherited COMQueryInterface(IID, Obj);
  if Result.Fail then
  begin
   if Supports(f_Node, IID.IID, Obj) then
    Result.SetOk
   else
    Result.SetNoInterface;
  end;//l3Fail(Result)
 end;//else
//#UC END# *4A60B23E00C3_4AE8269E010D_impl*
end;//TeeNode.COMQueryInterface

end.
