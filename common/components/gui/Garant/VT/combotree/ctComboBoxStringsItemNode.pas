unit ctComboBoxStringsItemNode;

// Модуль: "w:\common\components\gui\Garant\VT\ComboTree\ctComboBoxStringsItemNode.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TctComboBoxStringsItemNode" MUID: (4872337C032B)

{$Include w:\common\components\gui\Garant\VT\vtDefine.inc}

interface

uses
 l3IntfUses
 , l3CacheableBase
 , l3TreeInterfaces
 , ComboBoxStrings
 , l3Interfaces
;

type
 IctNodeWrap = interface
  {* Обёртка над нодой, позволяющая получить реализацию. }
  ['{E3E8625D-6EC1-4C23-B489-A81FA82366C8}']
  function GetSelf: TctComboBoxStringsItemNode;
 end;//IctNodeWrap

 TctComboBoxStringsItemNode = class(Tl3CacheableBase, Il3SimpleNode, IctNodeWrap)
  private
   f_Index: Integer;
   f_Flags: Integer;
   f_Strings: TComboBoxStrings;
    {* Поле для свойства Strings }
  protected
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
   function CanAcceptData(const aData: Tl3TreeData): Boolean;
    {* может ли узел принять данные }
   function DropData(const aData: Tl3TreeData): Boolean;
    {* принять данные }
   function CanMove: Boolean;
    {* определяет возможность перемещения узла }
   function Get_Prev: Il3SimpleNode;
   function GetSelf: TctComboBoxStringsItemNode;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   constructor Create(aStrings: TComboBoxStrings;
    anIndex: Integer); reintroduce; virtual;
   class function Make(aStrings: TComboBoxStrings;
    anIndex: Integer): Il3SimpleNode; reintroduce;
  protected
   property Strings: TComboBoxStrings
    read f_Strings;
 end;//TctComboBoxStringsItemNode

implementation

uses
 l3ImplUses
 , SysUtils
 , l3String
 , l3Base
 , l3InterfacesMisc
 , l3Bits
 {$If NOT Defined(NoScripts)}
 , l3NodesKeyWordsPack
 {$IfEnd} // NOT Defined(NoScripts)
;

constructor TctComboBoxStringsItemNode.Create(aStrings: TComboBoxStrings;
 anIndex: Integer);
//#UC START# *487233D60341_4872337C032B_var*
//#UC END# *487233D60341_4872337C032B_var*
begin
//#UC START# *487233D60341_4872337C032B_impl*
 inherited Create;
 l3Set(f_Strings, aStrings);
 f_Index := anIndex;
//#UC END# *487233D60341_4872337C032B_impl*
end;//TctComboBoxStringsItemNode.Create

class function TctComboBoxStringsItemNode.Make(aStrings: TComboBoxStrings;
 anIndex: Integer): Il3SimpleNode;
var
 l_Inst : TctComboBoxStringsItemNode;
begin
 l_Inst := Create(aStrings, anIndex);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TctComboBoxStringsItemNode.Make

function TctComboBoxStringsItemNode.IsFirst: Boolean;
 {* это первый узел внутри родителя? }
//#UC START# *47723CDB00A4_4872337C032B_var*
//#UC END# *47723CDB00A4_4872337C032B_var*
begin
//#UC START# *47723CDB00A4_4872337C032B_impl*
 Result := (f_Index = 0);
//#UC END# *47723CDB00A4_4872337C032B_impl*
end;//TctComboBoxStringsItemNode.IsFirst

function TctComboBoxStringsItemNode.IsLast: Boolean;
 {* это последний узел внутри родителя? }
//#UC START# *47723CFF0148_4872337C032B_var*
//#UC END# *47723CFF0148_4872337C032B_var*
begin
//#UC START# *47723CFF0148_4872337C032B_impl*
 Result := (f_Index = Pred(f_Strings.Count));
//#UC END# *47723CFF0148_4872337C032B_impl*
end;//TctComboBoxStringsItemNode.IsLast

function TctComboBoxStringsItemNode.HasChild: Boolean;
 {* есть ли дочерние узлы? }
//#UC START# *47723D0F0392_4872337C032B_var*
//#UC END# *47723D0F0392_4872337C032B_var*
begin
//#UC START# *47723D0F0392_4872337C032B_impl*
 Result := false;
//#UC END# *47723D0F0392_4872337C032B_impl*
end;//TctComboBoxStringsItemNode.HasChild

function TctComboBoxStringsItemNode.MaybeChild: Boolean;
 {* может ли иметь дочерние узлы? }
//#UC START# *47723D1D03D6_4872337C032B_var*
//#UC END# *47723D1D03D6_4872337C032B_var*
begin
//#UC START# *47723D1D03D6_4872337C032B_impl*
 Result := false;
//#UC END# *47723D1D03D6_4872337C032B_impl*
end;//TctComboBoxStringsItemNode.MaybeChild

function TctComboBoxStringsItemNode.GetLevel: Integer;
//#UC START# *47723D2E0051_4872337C032B_var*
//#UC END# *47723D2E0051_4872337C032B_var*
begin
//#UC START# *47723D2E0051_4872337C032B_impl*
 Result := 1;
//#UC END# *47723D2E0051_4872337C032B_impl*
end;//TctComboBoxStringsItemNode.GetLevel

function TctComboBoxStringsItemNode.GetLevelFor(const aNode: Il3SimpleNode): Integer;
//#UC START# *47723D3B0058_4872337C032B_var*
var
 lCNode : Il3SimpleNode;
//#UC END# *47723D3B0058_4872337C032B_var*
begin
//#UC START# *47723D3B0058_4872337C032B_impl*
 Result := 0;
 lCNode := Self;
 while (lCNode <> nil) and not lCNode.IsSame(aNode) do
 begin
  Inc(Result);
  lCNode := lCNode.Parent;
 end;//while (lCNode <> nil)
 if (lCNode = nil) then
  Result := -1;
//#UC END# *47723D3B0058_4872337C032B_impl*
end;//TctComboBoxStringsItemNode.GetLevelFor

function TctComboBoxStringsItemNode.IsSame(const aNode: Il3SimpleNode): Boolean;
 {* сравнивает ноды. }
//#UC START# *47723D4C0360_4872337C032B_var*
var
 l_Wrap : IctNodeWrap;
 l_Node : TctComboBoxStringsItemNode;
//#UC END# *47723D4C0360_4872337C032B_var*
begin
//#UC START# *47723D4C0360_4872337C032B_impl*
 if l3IEQ(Self, aNode) then
  Result := true
 else
 begin
  if Supports(aNode, IctNodeWrap, l_Wrap) then
   try
    l_Node := l_Wrap.GetSelf;
    Result := (f_Strings = l_Node.f_Strings) AND (f_Index = l_Node.f_Index);
   finally
    l_Wrap := nil;
   end//try..finally
  else
   Result := false;
 end;//l3IEQ(Self, aNode)
//#UC END# *47723D4C0360_4872337C032B_impl*
end;//TctComboBoxStringsItemNode.IsSame

function TctComboBoxStringsItemNode.IsDisappeared: Boolean;
 {* True если интерфейс на удаленную ноду,
             применяется в виртуальных нодах - указателях на данные. }
//#UC START# *47723DB901CA_4872337C032B_var*
//#UC END# *47723DB901CA_4872337C032B_var*
begin
//#UC START# *47723DB901CA_4872337C032B_impl*
 Result := (f_Index < 0); 
//#UC END# *47723DB901CA_4872337C032B_impl*
end;//TctComboBoxStringsItemNode.IsDisappeared

procedure TctComboBoxStringsItemNode.BeginMove(var aUserParam: Pointer);
 {* начать перемещение узла. }
//#UC START# *47723DD1008F_4872337C032B_var*
//#UC END# *47723DD1008F_4872337C032B_var*
begin
//#UC START# *47723DD1008F_4872337C032B_impl*
 Assert(false);
//#UC END# *47723DD1008F_4872337C032B_impl*
end;//TctComboBoxStringsItemNode.BeginMove

procedure TctComboBoxStringsItemNode.EndMove(aUserParam: Pointer);
 {* закончить перемещение узла. }
//#UC START# *47723DE0009F_4872337C032B_var*
//#UC END# *47723DE0009F_4872337C032B_var*
begin
//#UC START# *47723DE0009F_4872337C032B_impl*
 Assert(false);
//#UC END# *47723DE0009F_4872337C032B_impl*
end;//TctComboBoxStringsItemNode.EndMove

procedure TctComboBoxStringsItemNode.Delete;
 {* удалить узел из дерева, а его данные с постоянного носителя (например из БД) или связанные объекты. }
//#UC START# *47723DED006A_4872337C032B_var*
//#UC END# *47723DED006A_4872337C032B_var*
begin
//#UC START# *47723DED006A_4872337C032B_impl*
 Assert(false);
//#UC END# *47723DED006A_4872337C032B_impl*
end;//TctComboBoxStringsItemNode.Delete

function TctComboBoxStringsItemNode.Get_Text: Tl3PCharLenPrim;
//#UC START# *47723E8C0086_4872337C032Bget_var*
//#UC END# *47723E8C0086_4872337C032Bget_var*
begin
//#UC START# *47723E8C0086_4872337C032Bget_impl*
 Result := f_Strings.ItemW[f_Index];
//#UC END# *47723E8C0086_4872337C032Bget_impl*
end;//TctComboBoxStringsItemNode.Get_Text

function TctComboBoxStringsItemNode.Get_Parent: Il3SimpleNode;
//#UC START# *4772408A0361_4872337C032Bget_var*
//#UC END# *4772408A0361_4872337C032Bget_var*
begin
//#UC START# *4772408A0361_4872337C032Bget_impl*
 Result := f_Strings;
//#UC END# *4772408A0361_4872337C032Bget_impl*
end;//TctComboBoxStringsItemNode.Get_Parent

function TctComboBoxStringsItemNode.Get_Child: Il3SimpleNode;
//#UC START# *477240B10267_4872337C032Bget_var*
//#UC END# *477240B10267_4872337C032Bget_var*
begin
//#UC START# *477240B10267_4872337C032Bget_impl*
 Result := nil;
//#UC END# *477240B10267_4872337C032Bget_impl*
end;//TctComboBoxStringsItemNode.Get_Child

function TctComboBoxStringsItemNode.Get_Next: Il3SimpleNode;
//#UC START# *477241AC00B9_4872337C032Bget_var*
//#UC END# *477241AC00B9_4872337C032Bget_var*
begin
//#UC START# *477241AC00B9_4872337C032Bget_impl*
 if IsLast then
  Result := nil
 else
  Result := Make(f_Strings, f_Index + 1);
//#UC END# *477241AC00B9_4872337C032Bget_impl*
end;//TctComboBoxStringsItemNode.Get_Next

function TctComboBoxStringsItemNode.Get_Flag(anIndex: Integer): Boolean;
//#UC START# *4772423302AF_4872337C032Bget_var*
//#UC END# *4772423302AF_4872337C032Bget_var*
begin
//#UC START# *4772423302AF_4872337C032Bget_impl*
 Result := l3TestMask(f_Flags, anIndex);
//#UC END# *4772423302AF_4872337C032Bget_impl*
end;//TctComboBoxStringsItemNode.Get_Flag

procedure TctComboBoxStringsItemNode.Set_Flag(anIndex: Integer;
 aValue: Boolean);
//#UC START# *4772423302AF_4872337C032Bset_var*
//#UC END# *4772423302AF_4872337C032Bset_var*
begin
//#UC START# *4772423302AF_4872337C032Bset_impl*
 if aValue then
  l3SetMask(f_Flags, anIndex)
 else
  l3ClearMask(f_Flags, anIndex);
//#UC END# *4772423302AF_4872337C032Bset_impl*
end;//TctComboBoxStringsItemNode.Set_Flag

function TctComboBoxStringsItemNode.Get_Flags: Integer;
//#UC START# *477242700004_4872337C032Bget_var*
//#UC END# *477242700004_4872337C032Bget_var*
begin
//#UC START# *477242700004_4872337C032Bget_impl*
 Result := f_Flags;
//#UC END# *477242700004_4872337C032Bget_impl*
end;//TctComboBoxStringsItemNode.Get_Flags

function TctComboBoxStringsItemNode.Get_ThisChildrenCount: Integer;
//#UC START# *4772429202E4_4872337C032Bget_var*
//#UC END# *4772429202E4_4872337C032Bget_var*
begin
//#UC START# *4772429202E4_4872337C032Bget_impl*
 Result := 0;
//#UC END# *4772429202E4_4872337C032Bget_impl*
end;//TctComboBoxStringsItemNode.Get_ThisChildrenCount

function TctComboBoxStringsItemNode.pm_GetIndexInParent: Integer;
//#UC START# *477242A40219_4872337C032Bget_var*
//#UC END# *477242A40219_4872337C032Bget_var*
begin
//#UC START# *477242A40219_4872337C032Bget_impl*
 Result := f_Index;
//#UC END# *477242A40219_4872337C032Bget_impl*
end;//TctComboBoxStringsItemNode.pm_GetIndexInParent

function TctComboBoxStringsItemNode.CanAcceptData(const aData: Tl3TreeData): Boolean;
 {* может ли узел принять данные }
//#UC START# *47A86F070101_4872337C032B_var*
//#UC END# *47A86F070101_4872337C032B_var*
begin
//#UC START# *47A86F070101_4872337C032B_impl*
 Result := false;
//#UC END# *47A86F070101_4872337C032B_impl*
end;//TctComboBoxStringsItemNode.CanAcceptData

function TctComboBoxStringsItemNode.DropData(const aData: Tl3TreeData): Boolean;
 {* принять данные }
//#UC START# *47A86F1C016B_4872337C032B_var*
//#UC END# *47A86F1C016B_4872337C032B_var*
begin
//#UC START# *47A86F1C016B_4872337C032B_impl*
 Result := false;
//#UC END# *47A86F1C016B_4872337C032B_impl*
end;//TctComboBoxStringsItemNode.DropData

function TctComboBoxStringsItemNode.CanMove: Boolean;
 {* определяет возможность перемещения узла }
//#UC START# *47ADA09C019B_4872337C032B_var*
//#UC END# *47ADA09C019B_4872337C032B_var*
begin
//#UC START# *47ADA09C019B_4872337C032B_impl*
 Result := false;
//#UC END# *47ADA09C019B_4872337C032B_impl*
end;//TctComboBoxStringsItemNode.CanMove

function TctComboBoxStringsItemNode.Get_Prev: Il3SimpleNode;
//#UC START# *47B5759A03C0_4872337C032Bget_var*
//#UC END# *47B5759A03C0_4872337C032Bget_var*
begin
//#UC START# *47B5759A03C0_4872337C032Bget_impl*
 if IsFirst then
  Result := nil
 else
  Result := Make(f_Strings, f_Index - 1);
//#UC END# *47B5759A03C0_4872337C032Bget_impl*
end;//TctComboBoxStringsItemNode.Get_Prev

function TctComboBoxStringsItemNode.GetSelf: TctComboBoxStringsItemNode;
//#UC START# *48723F5D006F_4872337C032B_var*
//#UC END# *48723F5D006F_4872337C032B_var*
begin
//#UC START# *48723F5D006F_4872337C032B_impl*
 Result := Self;
//#UC END# *48723F5D006F_4872337C032B_impl*
end;//TctComboBoxStringsItemNode.GetSelf

procedure TctComboBoxStringsItemNode.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4872337C032B_var*
//#UC END# *479731C50290_4872337C032B_var*
begin
//#UC START# *479731C50290_4872337C032B_impl*
 FreeAndNil(f_Strings);
 inherited;
//#UC END# *479731C50290_4872337C032B_impl*
end;//TctComboBoxStringsItemNode.Cleanup

end.
