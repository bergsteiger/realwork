unit nsINodeWrapBase;
 {* ���� ������. ������ ������� � ����������� ���� ��� ����� ���������� ��������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\Data\Tree\nsINodeWrapBase.pas"
// ���������: "SimpleClass"

{$Include nsDefine.inc}

interface

uses
 l3IntfUses
 , l3CacheableBase
 , l3TreeInterfaces
 , DynamicTreeUnit
 , IOUnit
 , l3Interfaces
 , l3IID
;

type
 RnsINodeWrap = class of TnsINodeWrapBase;

 TnsINodeWrapBase = class(Tl3CacheableBase, Il3SimpleNode, Il3SimpleInternalNode)
  {* ���� ������. ������ ������� � ����������� ���� ��� ����� ���������� ��������� }
  private
   f_AdapterNodeCaption: IString;
   f_ParentNode: Il3SimpleNode;
   f_AdapterNode: INodeBase;
    {* ���� ��� �������� AdapterNode }
  private
   function ConvertFlagMask(anIndex: Integer): Word;
  protected
   function DoGetText: Tl3WString; virtual;
    {* ���������� ������� ��������� ������ ���� }
   function GetChildNodeClass: RnsINodeWrap; virtual;
    {* ���������� ������� ��������� ������ ���������� ��������� ���� }
   function DoGetChild: Il3SimpleNode; virtual;
    {* ���������� ������� ��������� ������� ������ }
   function GetHasChild: Boolean; virtual;
    {* ���������� ������� ����������� ���� ���� �� �������� ���� }
   function GetMaybeChild: Boolean; virtual;
    {* ���������� ������� ����������� ����� �� ���� ����� �������� ���� }
   function MakeChild(const aNode: INodeBase): Il3SimpleNode; virtual;
   function MakeParent(const aNode: INodeBase): Il3SimpleNode; virtual;
   procedure DoExpandCollapseAll(anExpand: Boolean);
   function MakeSibling(const aNode: INodeBase): Il3SimpleNode; virtual;
    {* ������ ������ }
   procedure Set_Parent(const aValue: Il3SimpleNode);
   function IsFirst: Boolean;
    {* ��� ������ ���� ������ ��������? }
   function IsLast: Boolean;
    {* ��� ��������� ���� ������ ��������? }
   function HasChild: Boolean;
    {* ���� �� �������� ����? }
   function MaybeChild: Boolean;
    {* ����� �� ����� �������� ����? }
   function GetLevel: Integer;
   function GetLevelFor(const aNode: Il3SimpleNode): Integer;
   function IsSame(const aNode: Il3SimpleNode): Boolean;
    {* ���������� ����. }
   function IsDisappeared: Boolean;
    {* True ���� ��������� �� ��������� ����,
             ����������� � ����������� ����� - ���������� �� ������. }
   procedure BeginMove(var aUserParam: Pointer);
    {* ������ ����������� ����. }
   procedure EndMove(aUserParam: Pointer);
    {* ��������� ����������� ����. }
   procedure Delete;
    {* ������� ���� �� ������, � ��� ������ � ����������� �������� (�������� �� ��) ��� ��������� �������. }
   function Get_Text: Tl3PCharLenPrim;
   function Get_Parent: Il3SimpleNode;
   function Get_Child: Il3SimpleNode;
   function Get_Next: Il3SimpleNode;
   function Get_Flag(anIndex: Integer): Boolean;
   procedure Set_Flag(anIndex: Integer;
    aValue: Boolean);
   function Get_Flags: Integer;
   function Get_ThisChildrenCount: Integer;
   function pm_GetIndexInParent: Integer;
   function CanAcceptData(const aData: Tl3TreeData): Boolean;
    {* ����� �� ���� ������� ������ }
   function DropData(const aData: Tl3TreeData): Boolean;
    {* ������� ������ }
   function CanMove: Boolean;
    {* ���������� ����������� ����������� ���� }
   function Get_Prev: Il3SimpleNode;
   procedure Cleanup; override;
    {* ������� ������� ����� �������. }
   procedure ClearFields; override;
  public
   constructor Create(const aNode: INodeBase); reintroduce; virtual;
    {* ������ ��������� ���� ������ }
   class function Make(const aNode: INodeBase): Il3SimpleNode;
    {* ������ ��������� ���� ������ }
   function COMQueryInterface(const IID: Tl3GUID;
    out Obj): Tl3HResult; override;
    {* ���������� ������� ���������� }
  protected
   property AdapterNode: INodeBase
    read f_AdapterNode;
    {* ���� ����������� ������ ��� ������� �������� ���� ������ }
 end;//TnsINodeWrapBase

implementation

uses
 l3ImplUses
 , nsTypes
 , SysUtils
 , l3InterfacesMisc
 , l3Base
 {$If NOT Defined(NoScripts)}
 , l3NodesKeyWordsPack
 {$IfEnd} // NOT Defined(NoScripts)
;

const
 map_Default = $2000;
 map_nfUserDefined2 = $4000;
  {* ���� ��� ������������� "�������������". ����� ������������ ���������� ����������� }
 map_nfUserDefined1 = $8000;
  {* ���� ��� ������������� "�������������". ����� ������������ ���������� ����������� }

function TnsINodeWrapBase.DoGetText: Tl3WString;
 {* ���������� ������� ��������� ������ ���� }
//#UC START# *490825370178_4682732A02F9_var*
//#UC END# *490825370178_4682732A02F9_var*
begin
//#UC START# *490825370178_4682732A02F9_impl*
 if not Assigned(f_AdapterNodeCaption) then
  if Assigned(f_AdapterNode) then
   f_AdapterNode.GetCaption(f_AdapterNodeCaption);
 Result := nsWStr(f_AdapterNodeCaption);
//#UC END# *490825370178_4682732A02F9_impl*
end;//TnsINodeWrapBase.DoGetText

constructor TnsINodeWrapBase.Create(const aNode: INodeBase);
 {* ������ ��������� ���� ������ }
//#UC START# *490982310145_4682732A02F9_var*
//#UC END# *490982310145_4682732A02F9_var*
begin
//#UC START# *490982310145_4682732A02F9_impl*
 inherited Create;
 f_AdapterNode := aNode;
//#UC END# *490982310145_4682732A02F9_impl*
end;//TnsINodeWrapBase.Create

function TnsINodeWrapBase.GetChildNodeClass: RnsINodeWrap;
 {* ���������� ������� ��������� ������ ���������� ��������� ���� }
//#UC START# *490989330020_4682732A02F9_var*
//#UC END# *490989330020_4682732A02F9_var*
begin
//#UC START# *490989330020_4682732A02F9_impl*
 Result := RnsINodeWrap(ClassType);
//#UC END# *490989330020_4682732A02F9_impl*
end;//TnsINodeWrapBase.GetChildNodeClass

function TnsINodeWrapBase.DoGetChild: Il3SimpleNode;
 {* ���������� ������� ��������� ������� ������ }
//#UC START# *4909A13402E2_4682732A02F9_var*
var
 l_ChildNode : INodeBase;
//#UC END# *4909A13402E2_4682732A02F9_var*
begin
//#UC START# *4909A13402E2_4682732A02F9_impl*
 Result := nil;
 if HasChild AND (f_AdapterNode <> nil) then
 begin
  f_AdapterNode.GetFirstChild(l_ChildNode);
  Result := MakeChild(l_ChildNode);
  if (Result <> nil) then
   (Result As Il3SimpleInternalNode).Parent := Self;
 end;//AdapterNode <> nil
//#UC END# *4909A13402E2_4682732A02F9_impl*
end;//TnsINodeWrapBase.DoGetChild

function TnsINodeWrapBase.GetHasChild: Boolean;
 {* ���������� ������� ����������� ���� ���� �� �������� ���� }
//#UC START# *4909A1790056_4682732A02F9_var*
//#UC END# *4909A1790056_4682732A02F9_var*
begin
//#UC START# *4909A1790056_4682732A02F9_impl*
 Result := (f_AdapterNode <> nil) AND f_AdapterNode.HasChildren;
//#UC END# *4909A1790056_4682732A02F9_impl*
end;//TnsINodeWrapBase.GetHasChild

function TnsINodeWrapBase.GetMaybeChild: Boolean;
 {* ���������� ������� ����������� ����� �� ���� ����� �������� ���� }
//#UC START# *4909A1AA0089_4682732A02F9_var*
//#UC END# *4909A1AA0089_4682732A02F9_var*
begin
//#UC START# *4909A1AA0089_4682732A02F9_impl*
 Result := HasChild;
//#UC END# *4909A1AA0089_4682732A02F9_impl*
end;//TnsINodeWrapBase.GetMaybeChild

function TnsINodeWrapBase.MakeChild(const aNode: INodeBase): Il3SimpleNode;
//#UC START# *4909B8F903B5_4682732A02F9_var*
//#UC END# *4909B8F903B5_4682732A02F9_var*
begin
//#UC START# *4909B8F903B5_4682732A02F9_impl*
 Result := GetChildNodeClass.Make(aNode);
//#UC END# *4909B8F903B5_4682732A02F9_impl*
end;//TnsINodeWrapBase.MakeChild

function TnsINodeWrapBase.MakeParent(const aNode: INodeBase): Il3SimpleNode;
//#UC START# *4909B9070389_4682732A02F9_var*
//#UC END# *4909B9070389_4682732A02F9_var*
begin
//#UC START# *4909B9070389_4682732A02F9_impl*
 Result := RnsINodeWrap(ClassType).Make(aNode);
//#UC END# *4909B9070389_4682732A02F9_impl*
end;//TnsINodeWrapBase.MakeParent

class function TnsINodeWrapBase.Make(const aNode: INodeBase): Il3SimpleNode;
 {* ������ ��������� ���� ������ }
//#UC START# *4909BB540039_4682732A02F9_var*
var
 l_Node : TnsINodeWrapBase;
//#UC END# *4909BB540039_4682732A02F9_var*
begin
//#UC START# *4909BB540039_4682732A02F9_impl*
 if (aNode = nil) then
  Result := nil
 else
 begin
  l_Node := Create(aNode);
  try
   Result := l_Node;
  finally
   FreeAndNil(l_Node);
  end;//try..finally
 end;//aNode = nil
//#UC END# *4909BB540039_4682732A02F9_impl*
end;//TnsINodeWrapBase.Make

function TnsINodeWrapBase.ConvertFlagMask(anIndex: Integer): Word;
//#UC START# *4909BCF802C6_4682732A02F9_var*
//#UC END# *4909BCF802C6_4682732A02F9_var*
begin
//#UC START# *4909BCF802C6_4682732A02F9_impl*
 if anIndex = nfUserDefined2 then
  Result := map_nfUserDefined2
 else
  if anIndex = nfUserDefined1 then
   Result := map_nfUserDefined1
  else
   Result := map_Default;
//#UC END# *4909BCF802C6_4682732A02F9_impl*
end;//TnsINodeWrapBase.ConvertFlagMask

procedure TnsINodeWrapBase.DoExpandCollapseAll(anExpand: Boolean);
//#UC START# *4909C2A600C5_4682732A02F9_var*
//#UC END# *4909C2A600C5_4682732A02F9_var*
begin
//#UC START# *4909C2A600C5_4682732A02F9_impl*
 if f_AdapterNode <> nil then
  f_AdapterNode.ExpandAll(anExpand);
//#UC END# *4909C2A600C5_4682732A02F9_impl*
end;//TnsINodeWrapBase.DoExpandCollapseAll

function TnsINodeWrapBase.MakeSibling(const aNode: INodeBase): Il3SimpleNode;
 {* ������ ������ }
//#UC START# *4B0694200234_4682732A02F9_var*
//#UC END# *4B0694200234_4682732A02F9_var*
begin
//#UC START# *4B0694200234_4682732A02F9_impl*
 Result := Make(aNode);
//#UC END# *4B0694200234_4682732A02F9_impl*
end;//TnsINodeWrapBase.MakeSibling

procedure TnsINodeWrapBase.Set_Parent(const aValue: Il3SimpleNode);
//#UC START# *4682742C0340_4682732A02F9set_var*
//#UC END# *4682742C0340_4682732A02F9set_var*
begin
//#UC START# *4682742C0340_4682732A02F9set_impl*
 f_ParentNode := aValue;
//#UC END# *4682742C0340_4682732A02F9set_impl*
end;//TnsINodeWrapBase.Set_Parent

function TnsINodeWrapBase.IsFirst: Boolean;
 {* ��� ������ ���� ������ ��������? }
//#UC START# *47723CDB00A4_4682732A02F9_var*
//#UC END# *47723CDB00A4_4682732A02F9_var*
begin
//#UC START# *47723CDB00A4_4682732A02F9_impl*
 if (f_AdapterNode = nil) then
  Result := true
 else
  Result := f_AdapterNode.IsFirst;
//#UC END# *47723CDB00A4_4682732A02F9_impl*
end;//TnsINodeWrapBase.IsFirst

function TnsINodeWrapBase.IsLast: Boolean;
 {* ��� ��������� ���� ������ ��������? }
//#UC START# *47723CFF0148_4682732A02F9_var*
//#UC END# *47723CFF0148_4682732A02F9_var*
begin
//#UC START# *47723CFF0148_4682732A02F9_impl*
 if (f_AdapterNode = nil) then
  Result := true
 else
  Result := f_AdapterNode.IsLast;
//#UC END# *47723CFF0148_4682732A02F9_impl*
end;//TnsINodeWrapBase.IsLast

function TnsINodeWrapBase.HasChild: Boolean;
 {* ���� �� �������� ����? }
//#UC START# *47723D0F0392_4682732A02F9_var*
//#UC END# *47723D0F0392_4682732A02F9_var*
begin
//#UC START# *47723D0F0392_4682732A02F9_impl*
 Result := GetHasChild;
//#UC END# *47723D0F0392_4682732A02F9_impl*
end;//TnsINodeWrapBase.HasChild

function TnsINodeWrapBase.MaybeChild: Boolean;
 {* ����� �� ����� �������� ����? }
//#UC START# *47723D1D03D6_4682732A02F9_var*
//#UC END# *47723D1D03D6_4682732A02F9_var*
begin
//#UC START# *47723D1D03D6_4682732A02F9_impl*
 Result := GetMaybeChild;
//#UC END# *47723D1D03D6_4682732A02F9_impl*
end;//TnsINodeWrapBase.MaybeChild

function TnsINodeWrapBase.GetLevel: Integer;
//#UC START# *47723D2E0051_4682732A02F9_var*
//#UC END# *47723D2E0051_4682732A02F9_var*
begin
//#UC START# *47723D2E0051_4682732A02F9_impl*
 if (f_AdapterNode = nil) then
  Result := 0
 else
  Result := f_AdapterNode.GetLevel;
//#UC END# *47723D2E0051_4682732A02F9_impl*
end;//TnsINodeWrapBase.GetLevel

function TnsINodeWrapBase.GetLevelFor(const aNode: Il3SimpleNode): Integer;
//#UC START# *47723D3B0058_4682732A02F9_var*
var
 l_ParentNode: INodeBase;
//#UC END# *47723D3B0058_4682732A02F9_var*
begin
//#UC START# *47723D3B0058_4682732A02F9_impl*
 if (f_AdapterNode <> nil) and
    Supports(aNode, INodeBase, l_ParentNode) then
 begin
  try
   Result := f_AdapterNode.GetLevel - l_ParentNode.GetLevel;
  finally
   l_ParentNode := nil;
  end;//try..finally
 end
 else
  Result := 0
//#UC END# *47723D3B0058_4682732A02F9_impl*
end;//TnsINodeWrapBase.GetLevelFor

function TnsINodeWrapBase.IsSame(const aNode: Il3SimpleNode): Boolean;
 {* ���������� ����. }
//#UC START# *47723D4C0360_4682732A02F9_var*
var
 l_AdapterNode : INodeBase;
//#UC END# *47723D4C0360_4682732A02F9_var*
begin
//#UC START# *47723D4C0360_4682732A02F9_impl*
 Result := l3IEQ(Self, aNode);
 if not Result then begin
  if Supports(aNode, INodeBase, l_AdapterNode) then
   try
    Result := Pointer(f_AdapterNode) = Pointer(l_AdapterNode);
    if not Result then
     Result := f_AdapterNode.IsSameNode(l_AdapterNode);
   finally
    l_AdapterNode := nil;
   end;//try..finally
 end;//not Result
//#UC END# *47723D4C0360_4682732A02F9_impl*
end;//TnsINodeWrapBase.IsSame

function TnsINodeWrapBase.IsDisappeared: Boolean;
 {* True ���� ��������� �� ��������� ����,
             ����������� � ����������� ����� - ���������� �� ������. }
//#UC START# *47723DB901CA_4682732A02F9_var*
//#UC END# *47723DB901CA_4682732A02F9_var*
begin
//#UC START# *47723DB901CA_4682732A02F9_impl*
 Result := false;
//#UC END# *47723DB901CA_4682732A02F9_impl*
end;//TnsINodeWrapBase.IsDisappeared

procedure TnsINodeWrapBase.BeginMove(var aUserParam: Pointer);
 {* ������ ����������� ����. }
//#UC START# *47723DD1008F_4682732A02F9_var*
//#UC END# *47723DD1008F_4682732A02F9_var*
begin
//#UC START# *47723DD1008F_4682732A02F9_impl*
//#UC END# *47723DD1008F_4682732A02F9_impl*
end;//TnsINodeWrapBase.BeginMove

procedure TnsINodeWrapBase.EndMove(aUserParam: Pointer);
 {* ��������� ����������� ����. }
//#UC START# *47723DE0009F_4682732A02F9_var*
//#UC END# *47723DE0009F_4682732A02F9_var*
begin
//#UC START# *47723DE0009F_4682732A02F9_impl*
//#UC END# *47723DE0009F_4682732A02F9_impl*
end;//TnsINodeWrapBase.EndMove

procedure TnsINodeWrapBase.Delete;
 {* ������� ���� �� ������, � ��� ������ � ����������� �������� (�������� �� ��) ��� ��������� �������. }
//#UC START# *47723DED006A_4682732A02F9_var*
//#UC END# *47723DED006A_4682732A02F9_var*
begin
//#UC START# *47723DED006A_4682732A02F9_impl*
 f_AdapterNode.DeleteNode;
//#UC END# *47723DED006A_4682732A02F9_impl*
end;//TnsINodeWrapBase.Delete

function TnsINodeWrapBase.Get_Text: Tl3PCharLenPrim;
//#UC START# *47723E8C0086_4682732A02F9get_var*
//#UC END# *47723E8C0086_4682732A02F9get_var*
begin
//#UC START# *47723E8C0086_4682732A02F9get_impl*
 Result := DoGetText;
//#UC END# *47723E8C0086_4682732A02F9get_impl*
end;//TnsINodeWrapBase.Get_Text

function TnsINodeWrapBase.Get_Parent: Il3SimpleNode;
//#UC START# *4772408A0361_4682732A02F9get_var*
var
 l_ParentNode : INodeBase;
//#UC END# *4772408A0361_4682732A02F9get_var*
begin
//#UC START# *4772408A0361_4682732A02F9get_impl*
 Result := nil;
 if (f_ParentNode <> nil) then
 begin
  Result := f_ParentNode;
  Exit;
 end;//f_ParentNode <> nil
 if (f_AdapterNode <> nil) then
 begin
  f_AdapterNode.GetParent(l_ParentNode);
  Result := MakeParent(l_ParentNode);
 end;//AdapterNode <> nil
 f_ParentNode := Result;
//#UC END# *4772408A0361_4682732A02F9get_impl*
end;//TnsINodeWrapBase.Get_Parent

function TnsINodeWrapBase.Get_Child: Il3SimpleNode;
//#UC START# *477240B10267_4682732A02F9get_var*
//#UC END# *477240B10267_4682732A02F9get_var*
begin
//#UC START# *477240B10267_4682732A02F9get_impl*
 Result := DoGetChild;
//#UC END# *477240B10267_4682732A02F9get_impl*
end;//TnsINodeWrapBase.Get_Child

function TnsINodeWrapBase.Get_Next: Il3SimpleNode;
//#UC START# *477241AC00B9_4682732A02F9get_var*
var
 l_Next : INodeBase;
//#UC END# *477241AC00B9_4682732A02F9get_var*
begin
//#UC START# *477241AC00B9_4682732A02F9get_impl*
 Result := nil;
 if not IsLast then
 begin
  f_AdapterNode.GetNext(l_Next);
  Result := MakeSibling(l_Next);
  if (Result <> nil) then
   (Result As Il3SimpleInternalNode).Parent := Get_Parent;
 end;//not IsLast
//#UC END# *477241AC00B9_4682732A02F9get_impl*
end;//TnsINodeWrapBase.Get_Next

function TnsINodeWrapBase.Get_Flag(anIndex: Integer): Boolean;
//#UC START# *4772423302AF_4682732A02F9get_var*
//#UC END# *4772423302AF_4682732A02F9get_var*
begin
//#UC START# *4772423302AF_4682732A02F9get_impl*
 Result := False;
 if Assigned(f_AdapterNode) then
  Result := f_AdapterNode.HasFlag(ConvertFlagMask(anIndex));
//#UC END# *4772423302AF_4682732A02F9get_impl*
end;//TnsINodeWrapBase.Get_Flag

procedure TnsINodeWrapBase.Set_Flag(anIndex: Integer;
 aValue: Boolean);
//#UC START# *4772423302AF_4682732A02F9set_var*
//#UC END# *4772423302AF_4682732A02F9set_var*
begin
//#UC START# *4772423302AF_4682732A02F9set_impl*
 if Assigned(f_AdapterNode) then
  f_AdapterNode.SetFlag(ConvertFlagMask(anIndex), aValue);
//#UC END# *4772423302AF_4682732A02F9set_impl*
end;//TnsINodeWrapBase.Set_Flag

function TnsINodeWrapBase.Get_Flags: Integer;
//#UC START# *477242700004_4682732A02F9get_var*
//#UC END# *477242700004_4682732A02F9get_var*
begin
//#UC START# *477242700004_4682732A02F9get_impl*
 Result := 0; // !STUB!
//#UC END# *477242700004_4682732A02F9get_impl*
end;//TnsINodeWrapBase.Get_Flags

function TnsINodeWrapBase.Get_ThisChildrenCount: Integer;
//#UC START# *4772429202E4_4682732A02F9get_var*
//#UC END# *4772429202E4_4682732A02F9get_var*
begin
//#UC START# *4772429202E4_4682732A02F9get_impl*
 if Assigned(f_AdapterNode) then
  Result := f_AdapterNode.GetChildCount
 else
  Result := 0;
//#UC END# *4772429202E4_4682732A02F9get_impl*
end;//TnsINodeWrapBase.Get_ThisChildrenCount

function TnsINodeWrapBase.pm_GetIndexInParent: Integer;
//#UC START# *477242A40219_4682732A02F9get_var*
//#UC END# *477242A40219_4682732A02F9get_var*
begin
//#UC START# *477242A40219_4682732A02F9get_impl*
 if not Assigned(f_AdapterNode) then
  Result := -1
 else
  Result := Pred(f_AdapterNode.GetIndexFromParent);
//#UC END# *477242A40219_4682732A02F9get_impl*
end;//TnsINodeWrapBase.pm_GetIndexInParent

function TnsINodeWrapBase.CanAcceptData(const aData: Tl3TreeData): Boolean;
 {* ����� �� ���� ������� ������ }
//#UC START# *47A86F070101_4682732A02F9_var*
//#UC END# *47A86F070101_4682732A02F9_var*
begin
//#UC START# *47A86F070101_4682732A02F9_impl*
 Result := False;
//#UC END# *47A86F070101_4682732A02F9_impl*
end;//TnsINodeWrapBase.CanAcceptData

function TnsINodeWrapBase.DropData(const aData: Tl3TreeData): Boolean;
 {* ������� ������ }
//#UC START# *47A86F1C016B_4682732A02F9_var*
//#UC END# *47A86F1C016B_4682732A02F9_var*
begin
//#UC START# *47A86F1C016B_4682732A02F9_impl*
 Result := False;
//#UC END# *47A86F1C016B_4682732A02F9_impl*
end;//TnsINodeWrapBase.DropData

function TnsINodeWrapBase.CanMove: Boolean;
 {* ���������� ����������� ����������� ���� }
//#UC START# *47ADA09C019B_4682732A02F9_var*
//#UC END# *47ADA09C019B_4682732A02F9_var*
begin
//#UC START# *47ADA09C019B_4682732A02F9_impl*
 Result := False;
//#UC END# *47ADA09C019B_4682732A02F9_impl*
end;//TnsINodeWrapBase.CanMove

function TnsINodeWrapBase.Get_Prev: Il3SimpleNode;
//#UC START# *47B5759A03C0_4682732A02F9get_var*
var
 l_Prev : INodeBase;
//#UC END# *47B5759A03C0_4682732A02F9get_var*
begin
//#UC START# *47B5759A03C0_4682732A02F9get_impl*
 Result := nil;
 if not IsFirst then
 begin
  f_AdapterNode.GetPrev(l_Prev);
  Result := MakeSibling(l_Prev);
  if (Result <> nil) then
   (Result As Il3SimpleInternalNode).Parent := Get_Parent;
 end;//not IsLast
//#UC END# *47B5759A03C0_4682732A02F9get_impl*
end;//TnsINodeWrapBase.Get_Prev

procedure TnsINodeWrapBase.Cleanup;
 {* ������� ������� ����� �������. }
//#UC START# *479731C50290_4682732A02F9_var*
//#UC END# *479731C50290_4682732A02F9_var*
begin
//#UC START# *479731C50290_4682732A02F9_impl*
 f_ParentNode := nil;
 f_AdapterNodeCaption := nil;
 f_AdapterNode := nil;
 inherited;
//#UC END# *479731C50290_4682732A02F9_impl*
end;//TnsINodeWrapBase.Cleanup

function TnsINodeWrapBase.COMQueryInterface(const IID: Tl3GUID;
 out Obj): Tl3HResult;
 {* ���������� ������� ���������� }
//#UC START# *4A60B23E00C3_4682732A02F9_var*
//#UC END# *4A60B23E00C3_4682732A02F9_var*
begin
//#UC START# *4A60B23E00C3_4682732A02F9_impl*
 if IID.EQ(INodeBase) then
 begin
  if (f_AdapterNode = nil) then
   Result.SetNOINTERFACE
  else
  begin
   Result.SetOk;
   INodeBase(Obj) := f_AdapterNode;
  end;//l_AdapterNode = nil
 end//IID.EQ(INodeBase)
 else
 begin
  Result := inherited COMQueryInterface(IID, Obj);
  if Result.Fail then
  begin
   if not IID.EQ(Il3Wake) then
   begin
    if (f_AdapterNode = nil) then
     Result.SetNOINTERFACE
    else
     Result := Tl3HResult_C(f_AdapterNode.QueryInterface(IID.IID, Obj));
   end;//not IID.SomeOf(..
  end;//l3IFail(Result)
 end;//IID.EQ(INodeBase)
//#UC END# *4A60B23E00C3_4682732A02F9_impl*
end;//TnsINodeWrapBase.COMQueryInterface

procedure TnsINodeWrapBase.ClearFields;
begin
 f_AdapterNode := nil;
 inherited;
end;//TnsINodeWrapBase.ClearFields

end.
