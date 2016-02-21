unit ComboBoxStrings;

// Модуль: "w:\common\components\gui\Garant\VT\ComboTree\ComboBoxStrings.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\gui\Garant\VT\vtDefine.inc}

interface

uses
 l3IntfUses
 , l3VCLStrings
 , l3TreeInterfaces
 , l3Interfaces
;

type
 TComboBoxStrings = class(Tl3Strings, Il3SimpleNode, Il3SimpleRootNode)
  private
   f_Flags: Integer;
  protected
   function DoMakeChild: Il3SimpleNode; virtual;
    {* Создать первого ребенка }
   function IsFirst: Boolean;
    {* это первый узел внутри родителя? }
   function IsLast: Boolean;
    {* это последний узел внутри родителя? }
   function HasChild: Boolean;
    {* есть ли дочерние узлы? }
   function MaybeChild: Boolean;
    {* может ли иметь дочерние узлы? }
   function GetLevel: Integer;
   function GetLevelFor(const aNode: Il3SimpleNode): Integer;
   function IsSame(const aNode: Il3SimpleNode): Boolean;
    {* сравнивает ноды. }
   function IsDisappeared: Boolean;
    {* True если интерфейс на удаленную ноду,
             применяется в виртуальных нодах - указателях на данные. }
   procedure BeginMove(var aUserParam: Pointer);
    {* начать перемещение узла. }
   procedure EndMove(aUserParam: Pointer);
    {* закончить перемещение узла. }
   procedure Delete;
    {* удалить узел из дерева, а его данные с постоянного носителя (например из БД) или связанные объекты. }
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
   function CanExpandCollapseAll: Boolean;
   procedure ExpandCollapseAll(anExpand: Boolean);
   function CanAcceptData(const aData: Tl3TreeData): Boolean;
    {* может ли узел принять данные }
   function DropData(const aData: Tl3TreeData): Boolean;
    {* принять данные }
   function CanMove: Boolean;
    {* определяет возможность перемещения узла }
   function Get_Prev: Il3SimpleNode;
 end;//TComboBoxStrings

implementation

uses
 l3ImplUses
 , l3String
 , ctComboBoxStringsItemNode
 , l3InterfacesMisc
 , l3Bits
 {$If NOT Defined(NoScripts)}
 , l3NodesKeyWordsPack
 {$IfEnd} // NOT Defined(NoScripts)
;

function TComboBoxStrings.DoMakeChild: Il3SimpleNode;
 {* Создать первого ребенка }
//#UC START# *49BE43ED01CF_48721FA80370_var*
//#UC END# *49BE43ED01CF_48721FA80370_var*
begin
//#UC START# *49BE43ED01CF_48721FA80370_impl*
 Result := TctComboBoxStringsItemNode.Make(Self, 0);
//#UC END# *49BE43ED01CF_48721FA80370_impl*
end;//TComboBoxStrings.DoMakeChild

function TComboBoxStrings.IsFirst: Boolean;
 {* это первый узел внутри родителя? }
//#UC START# *47723CDB00A4_48721FA80370_var*
//#UC END# *47723CDB00A4_48721FA80370_var*
begin
//#UC START# *47723CDB00A4_48721FA80370_impl*
 Result := true;
//#UC END# *47723CDB00A4_48721FA80370_impl*
end;//TComboBoxStrings.IsFirst

function TComboBoxStrings.IsLast: Boolean;
 {* это последний узел внутри родителя? }
//#UC START# *47723CFF0148_48721FA80370_var*
//#UC END# *47723CFF0148_48721FA80370_var*
begin
//#UC START# *47723CFF0148_48721FA80370_impl*
 Result := true;
//#UC END# *47723CFF0148_48721FA80370_impl*
end;//TComboBoxStrings.IsLast

function TComboBoxStrings.HasChild: Boolean;
 {* есть ли дочерние узлы? }
//#UC START# *47723D0F0392_48721FA80370_var*
//#UC END# *47723D0F0392_48721FA80370_var*
begin
//#UC START# *47723D0F0392_48721FA80370_impl*
 Result := (Count > 0);
//#UC END# *47723D0F0392_48721FA80370_impl*
end;//TComboBoxStrings.HasChild

function TComboBoxStrings.MaybeChild: Boolean;
 {* может ли иметь дочерние узлы? }
//#UC START# *47723D1D03D6_48721FA80370_var*
//#UC END# *47723D1D03D6_48721FA80370_var*
begin
//#UC START# *47723D1D03D6_48721FA80370_impl*
 Result := HasChild;
//#UC END# *47723D1D03D6_48721FA80370_impl*
end;//TComboBoxStrings.MaybeChild

function TComboBoxStrings.GetLevel: Integer;
//#UC START# *47723D2E0051_48721FA80370_var*
//#UC END# *47723D2E0051_48721FA80370_var*
begin
//#UC START# *47723D2E0051_48721FA80370_impl*
 Result := 0;
//#UC END# *47723D2E0051_48721FA80370_impl*
end;//TComboBoxStrings.GetLevel

function TComboBoxStrings.GetLevelFor(const aNode: Il3SimpleNode): Integer;
//#UC START# *47723D3B0058_48721FA80370_var*
var
 lCNode : Il3SimpleNode;
//#UC END# *47723D3B0058_48721FA80370_var*
begin
//#UC START# *47723D3B0058_48721FA80370_impl*
 Result := 0;
 lCNode := Self;
 while (lCNode <> nil) and not lCNode.IsSame(aNode) do
 begin
  Inc(Result);
  lCNode := lCNode.Parent;
 end;//while (lCNode <> nil)
 if (lCNode = nil) then
  Result := -1;
//#UC END# *47723D3B0058_48721FA80370_impl*
end;//TComboBoxStrings.GetLevelFor

function TComboBoxStrings.IsSame(const aNode: Il3SimpleNode): Boolean;
 {* сравнивает ноды. }
//#UC START# *47723D4C0360_48721FA80370_var*
//#UC END# *47723D4C0360_48721FA80370_var*
begin
//#UC START# *47723D4C0360_48721FA80370_impl*
 Result := l3IEQ(Self, aNode);
//#UC END# *47723D4C0360_48721FA80370_impl*
end;//TComboBoxStrings.IsSame

function TComboBoxStrings.IsDisappeared: Boolean;
 {* True если интерфейс на удаленную ноду,
             применяется в виртуальных нодах - указателях на данные. }
//#UC START# *47723DB901CA_48721FA80370_var*
//#UC END# *47723DB901CA_48721FA80370_var*
begin
//#UC START# *47723DB901CA_48721FA80370_impl*
 Result := l3TestMask(Get_Flags, nfWasDisappear);
//#UC END# *47723DB901CA_48721FA80370_impl*
end;//TComboBoxStrings.IsDisappeared

procedure TComboBoxStrings.BeginMove(var aUserParam: Pointer);
 {* начать перемещение узла. }
//#UC START# *47723DD1008F_48721FA80370_var*
//#UC END# *47723DD1008F_48721FA80370_var*
begin
//#UC START# *47723DD1008F_48721FA80370_impl*
 Assert(false);
//#UC END# *47723DD1008F_48721FA80370_impl*
end;//TComboBoxStrings.BeginMove

procedure TComboBoxStrings.EndMove(aUserParam: Pointer);
 {* закончить перемещение узла. }
//#UC START# *47723DE0009F_48721FA80370_var*
//#UC END# *47723DE0009F_48721FA80370_var*
begin
//#UC START# *47723DE0009F_48721FA80370_impl*
 Assert(false);
//#UC END# *47723DE0009F_48721FA80370_impl*
end;//TComboBoxStrings.EndMove

procedure TComboBoxStrings.Delete;
 {* удалить узел из дерева, а его данные с постоянного носителя (например из БД) или связанные объекты. }
//#UC START# *47723DED006A_48721FA80370_var*
//#UC END# *47723DED006A_48721FA80370_var*
begin
//#UC START# *47723DED006A_48721FA80370_impl*
 Assert(false);
//#UC END# *47723DED006A_48721FA80370_impl*
end;//TComboBoxStrings.Delete

function TComboBoxStrings.Get_Text: Tl3PCharLenPrim;
//#UC START# *47723E8C0086_48721FA80370get_var*
//#UC END# *47723E8C0086_48721FA80370get_var*
begin
//#UC START# *47723E8C0086_48721FA80370get_impl*
 Result := l3PCharLen(ClassName);
//#UC END# *47723E8C0086_48721FA80370get_impl*
end;//TComboBoxStrings.Get_Text

function TComboBoxStrings.Get_Parent: Il3SimpleNode;
//#UC START# *4772408A0361_48721FA80370get_var*
//#UC END# *4772408A0361_48721FA80370get_var*
begin
//#UC START# *4772408A0361_48721FA80370get_impl*
 Result := nil;
//#UC END# *4772408A0361_48721FA80370get_impl*
end;//TComboBoxStrings.Get_Parent

function TComboBoxStrings.Get_Child: Il3SimpleNode;
//#UC START# *477240B10267_48721FA80370get_var*
//#UC END# *477240B10267_48721FA80370get_var*
begin
//#UC START# *477240B10267_48721FA80370get_impl*
 if (Count <= 0) then
  Result := nil
 else
  Result := DoMakeChild;
//#UC END# *477240B10267_48721FA80370get_impl*
end;//TComboBoxStrings.Get_Child

function TComboBoxStrings.Get_Next: Il3SimpleNode;
//#UC START# *477241AC00B9_48721FA80370get_var*
//#UC END# *477241AC00B9_48721FA80370get_var*
begin
//#UC START# *477241AC00B9_48721FA80370get_impl*
 Result := nil;
//#UC END# *477241AC00B9_48721FA80370get_impl*
end;//TComboBoxStrings.Get_Next

function TComboBoxStrings.Get_Flag(anIndex: Integer): Boolean;
//#UC START# *4772423302AF_48721FA80370get_var*
//#UC END# *4772423302AF_48721FA80370get_var*
begin
//#UC START# *4772423302AF_48721FA80370get_impl*
 Result := l3TestMask(f_Flags, anIndex);
//#UC END# *4772423302AF_48721FA80370get_impl*
end;//TComboBoxStrings.Get_Flag

procedure TComboBoxStrings.Set_Flag(anIndex: Integer;
 aValue: Boolean);
//#UC START# *4772423302AF_48721FA80370set_var*
//#UC END# *4772423302AF_48721FA80370set_var*
begin
//#UC START# *4772423302AF_48721FA80370set_impl*
 if aValue then
  l3SetMask(f_Flags, anIndex)
 else
  l3ClearMask(f_Flags, anIndex);
//#UC END# *4772423302AF_48721FA80370set_impl*
end;//TComboBoxStrings.Set_Flag

function TComboBoxStrings.Get_Flags: Integer;
//#UC START# *477242700004_48721FA80370get_var*
//#UC END# *477242700004_48721FA80370get_var*
begin
//#UC START# *477242700004_48721FA80370get_impl*
 Result := f_Flags;
//#UC END# *477242700004_48721FA80370get_impl*
end;//TComboBoxStrings.Get_Flags

function TComboBoxStrings.Get_ThisChildrenCount: Integer;
//#UC START# *4772429202E4_48721FA80370get_var*
//#UC END# *4772429202E4_48721FA80370get_var*
begin
//#UC START# *4772429202E4_48721FA80370get_impl*
 Result := Count;
//#UC END# *4772429202E4_48721FA80370get_impl*
end;//TComboBoxStrings.Get_ThisChildrenCount

function TComboBoxStrings.pm_GetIndexInParent: Integer;
//#UC START# *477242A40219_48721FA80370get_var*
//#UC END# *477242A40219_48721FA80370get_var*
begin
//#UC START# *477242A40219_48721FA80370get_impl*
 Result := 0;
//#UC END# *477242A40219_48721FA80370get_impl*
end;//TComboBoxStrings.pm_GetIndexInParent

function TComboBoxStrings.CanExpandCollapseAll: Boolean;
//#UC START# *4772433F0008_48721FA80370_var*
//#UC END# *4772433F0008_48721FA80370_var*
begin
//#UC START# *4772433F0008_48721FA80370_impl*
 Result := false;
//#UC END# *4772433F0008_48721FA80370_impl*
end;//TComboBoxStrings.CanExpandCollapseAll

procedure TComboBoxStrings.ExpandCollapseAll(anExpand: Boolean);
//#UC START# *47724349030A_48721FA80370_var*
//#UC END# *47724349030A_48721FA80370_var*
begin
//#UC START# *47724349030A_48721FA80370_impl*
 Assert(false);
//#UC END# *47724349030A_48721FA80370_impl*
end;//TComboBoxStrings.ExpandCollapseAll

function TComboBoxStrings.CanAcceptData(const aData: Tl3TreeData): Boolean;
 {* может ли узел принять данные }
//#UC START# *47A86F070101_48721FA80370_var*
//#UC END# *47A86F070101_48721FA80370_var*
begin
//#UC START# *47A86F070101_48721FA80370_impl*
 Result := false;
//#UC END# *47A86F070101_48721FA80370_impl*
end;//TComboBoxStrings.CanAcceptData

function TComboBoxStrings.DropData(const aData: Tl3TreeData): Boolean;
 {* принять данные }
//#UC START# *47A86F1C016B_48721FA80370_var*
//#UC END# *47A86F1C016B_48721FA80370_var*
begin
//#UC START# *47A86F1C016B_48721FA80370_impl*
 Result := false;
//#UC END# *47A86F1C016B_48721FA80370_impl*
end;//TComboBoxStrings.DropData

function TComboBoxStrings.CanMove: Boolean;
 {* определяет возможность перемещения узла }
//#UC START# *47ADA09C019B_48721FA80370_var*
//#UC END# *47ADA09C019B_48721FA80370_var*
begin
//#UC START# *47ADA09C019B_48721FA80370_impl*
 Result := false;
//#UC END# *47ADA09C019B_48721FA80370_impl*
end;//TComboBoxStrings.CanMove

function TComboBoxStrings.Get_Prev: Il3SimpleNode;
//#UC START# *47B5759A03C0_48721FA80370get_var*
//#UC END# *47B5759A03C0_48721FA80370get_var*
begin
//#UC START# *47B5759A03C0_48721FA80370get_impl*
 Result := nil;
//#UC END# *47B5759A03C0_48721FA80370get_impl*
end;//TComboBoxStrings.Get_Prev

end.
