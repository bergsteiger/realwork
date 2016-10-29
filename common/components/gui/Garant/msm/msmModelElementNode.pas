unit msmModelElementNode;

// ћодуль: "w:\common\components\gui\Garant\msm\msmModelElementNode.pas"
// —тереотип: "SimpleClass"
// Ёлемент модели: "TmsmModelElementNode" MUID: (57AC3AE0039B)

{$Include w:\common\components\msm.inc}

interface

uses
 l3IntfUses
 , msmViewOfModelElementList
 , l3TreeInterfaces
 , l3Interfaces
 , msmElementViews
 , msmModelElements
 //#UC START# *57AC3AE0039Bintf_uses*
 //#UC END# *57AC3AE0039Bintf_uses*
;

type
 TmsmModelElementNode = class;

 ITmsmModelElementNodeWrap = interface
  ['{A155D9AE-0917-4C04-ABFA-50CA81FEE383}']
  function GetSelf: TmsmModelElementNode;
 end;//ITmsmModelElementNodeWrap

 //#UC START# *57AC3AE0039Bci*
 //#UC END# *57AC3AE0039Bci*
 //#UC START# *57AC3AE0039Bcit*
 //#UC END# *57AC3AE0039Bcit*
 TmsmModelElementNode = class(TmsmViewOfModelElementList, Il3SimpleNode, Il3SimpleRootNode, ITmsmModelElementNodeWrap)
  private
   f_Flags: Integer;
  protected
   f_IndexInParent: Integer;
  protected
   function GetIsFirst: Boolean; virtual;
   function MakeNode(const anElement: ImsmModelElement;
    anIndex: Integer): Il3SimpleNode;
   function GetChild: Il3SimpleNode; virtual;
   function GetIsLast: Boolean; virtual;
   function GetPrev: Il3SimpleNode; virtual;
   function GetNext: Il3SimpleNode; virtual;
   function GetParent: Il3SimpleNode; virtual;
   function GetThisChildrenCount: Integer; virtual;
   function GetText: Tl3PCharLenPrim; virtual;
   function IsFirst: Boolean;
    {* это первый узел внутри родител€? }
   function IsLast: Boolean;
    {* это последний узел внутри родител€? }
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
             примен€етс€ в виртуальных нодах - указател€х на данные. }
   procedure BeginMove(var aUserParam: Pointer);
    {* начать перемещение узла. }
   procedure EndMove(aUserParam: Pointer);
    {* закончить перемещение узла. }
   procedure Delete;
    {* удалить узел из дерева, а его данные с посто€нного носител€ (например из Ѕƒ) или св€занные объекты. }
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
    {* может ли узел прин€ть данные }
   function DropData(const aData: Tl3TreeData): Boolean;
    {* прин€ть данные }
   function CanMove: Boolean;
    {* определ€ет возможность перемещени€ узла }
   function Get_Prev: Il3SimpleNode;
   function GetSelf: TmsmModelElementNode;
   procedure Cleanup; override;
    {* ‘ункци€ очистки полей объекта. }
  public
   constructor Create(const anElement: TmsmModelElementView;
    anIndex: Integer); reintroduce;
   class function Make(const anElement: TmsmModelElementView;
    anIndex: Integer): Il3SimpleRootNode; reintroduce;
 //#UC START# *57AC3AE0039Bpubl*
  public
   property Element;
 //#UC END# *57AC3AE0039Bpubl*
 end;//TmsmModelElementNode

implementation

uses
 l3ImplUses
 , SysUtils
 , msmModelElement
 {$If NOT Defined(NoScripts)}
 , l3NodesKeyWordsPack
 {$IfEnd} // NOT Defined(NoScripts)
 //#UC START# *57AC3AE0039Bimpl_uses*
 , l3InterfacesMisc
 , l3String
 , l3Bits
 //#UC END# *57AC3AE0039Bimpl_uses*
;

constructor TmsmModelElementNode.Create(const anElement: TmsmModelElementView;
 anIndex: Integer);
//#UC START# *57AC3DD20352_57AC3AE0039B_var*
var
 l_Element : TmsmModelElementView;
//#UC END# *57AC3DD20352_57AC3AE0039B_var*
begin
//#UC START# *57AC3DD20352_57AC3AE0039B_impl*
 //Assert(anElement.rElement <> nil);
 Assert(anElement.rListName <> '');
 Assert(anElement.rTextName <> '');
 l_Element := anElement;
 if (l_Element.rElement <> nil) then
 begin
  if l_Element.rElement.BoolProp['IsSomeView'] then
   l_Element.rElement := l_Element.rElement.ElementProp['Viewed'];
  l_Element.rElement := l_Element.rElement.ElementProp['ReferencedOriginal'];
 end;//l_Element.rElement <> nil
 f_IndexInParent := anIndex;
 inherited Create(l_Element);
//#UC END# *57AC3DD20352_57AC3AE0039B_impl*
end;//TmsmModelElementNode.Create

function TmsmModelElementNode.GetIsFirst: Boolean;
//#UC START# *57E90FC602BD_57AC3AE0039B_var*
var
 l_P : ImsmModelElement;
//#UC END# *57E90FC602BD_57AC3AE0039B_var*
begin
//#UC START# *57E90FC602BD_57AC3AE0039B_impl*
 l_P := Element.rElement.Parent;
 Result := ((l_P = nil) OR l_P.MEList[Element.rListName][0].IsSameElement(Element.rElement));
//#UC END# *57E90FC602BD_57AC3AE0039B_impl*
end;//TmsmModelElementNode.GetIsFirst

class function TmsmModelElementNode.Make(const anElement: TmsmModelElementView;
 anIndex: Integer): Il3SimpleRootNode;
var
 l_Inst : TmsmModelElementNode;
begin
 l_Inst := Create(anElement, anIndex);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TmsmModelElementNode.Make

function TmsmModelElementNode.MakeNode(const anElement: ImsmModelElement;
 anIndex: Integer): Il3SimpleNode;
//#UC START# *57AC3E47003C_57AC3AE0039B_var*
//#UC END# *57AC3E47003C_57AC3AE0039B_var*
begin
//#UC START# *57AC3E47003C_57AC3AE0039B_impl*
 Result := TmsmModelElementNode.Make(TmsmModelElementView_C(anElement, Self.Element.rListName, Self.Element.rTextName), anIndex);
//#UC END# *57AC3E47003C_57AC3AE0039B_impl*
end;//TmsmModelElementNode.MakeNode

function TmsmModelElementNode.GetChild: Il3SimpleNode;
//#UC START# *57E90FF10291_57AC3AE0039B_var*
//#UC END# *57E90FF10291_57AC3AE0039B_var*
begin
//#UC START# *57E90FF10291_57AC3AE0039B_impl*
 if (List = nil) then
  Result := nil
 else
 if (List.Count > 0) then
  Result := MakeNode(TmsmModelElement.MakeFromValue(List[0]), 0)
 else
  Result := nil;
//#UC END# *57E90FF10291_57AC3AE0039B_impl*
end;//TmsmModelElementNode.GetChild

function TmsmModelElementNode.GetIsLast: Boolean;
//#UC START# *57E90FDF00A5_57AC3AE0039B_var*
var
 l_P : ImsmModelElement;
 l_C : ImsmModelElementList;
//#UC END# *57E90FDF00A5_57AC3AE0039B_var*
begin
//#UC START# *57E90FDF00A5_57AC3AE0039B_impl*
 l_P := Element.rElement.Parent;
 if (l_P = nil) then
  Result := true
 else
 begin
  l_C := l_P.MEList[Element.rListName];
  Result := l_C[l_C.Count - 1].IsSameElement(Element.rElement);
 end;//(l_P = nil)
//#UC END# *57E90FDF00A5_57AC3AE0039B_impl*
end;//TmsmModelElementNode.GetIsLast

function TmsmModelElementNode.GetPrev: Il3SimpleNode;
//#UC START# *57E9100A01F2_57AC3AE0039B_var*
var
 l_I : Integer;
 l_P : ImsmModelElement;
//#UC END# *57E9100A01F2_57AC3AE0039B_var*
begin
//#UC START# *57E9100A01F2_57AC3AE0039B_impl*
 l_P := Element.rElement.Parent;
 if (l_P = nil) then
  Result := nil
 else
 begin
  l_I := pm_GetIndexInParent;
  if (l_I = 0) then
   Result := nil
  else
   Result := MakeNode(l_P.MEList[Element.rListName][l_I - 1], l_I - 1);
 end;//l_P = nil
//#UC END# *57E9100A01F2_57AC3AE0039B_impl*
end;//TmsmModelElementNode.GetPrev

function TmsmModelElementNode.GetNext: Il3SimpleNode;
//#UC START# *57E9101E01C8_57AC3AE0039B_var*
var
 l_I : Integer;
 l_P : ImsmModelElement;
//#UC END# *57E9101E01C8_57AC3AE0039B_var*
begin
//#UC START# *57E9101E01C8_57AC3AE0039B_impl*
 l_P := Element.rElement.Parent;
 if (l_P = nil) then
  Result := nil
 else
 begin
  l_I := pm_GetIndexInParent;
  if (l_I > l_P.ListProp[Element.rListName].Count - 1) then
   Assert(false)
  else
  if (l_I >= l_P.ListProp[Element.rListName].Count - 1) then
   Result := nil
  else
   Result := MakeNode(l_P.MEList[Element.rListName][l_I + 1], l_I + 1);
 end;//l_P = nil
//#UC END# *57E9101E01C8_57AC3AE0039B_impl*
end;//TmsmModelElementNode.GetNext

function TmsmModelElementNode.GetParent: Il3SimpleNode;
//#UC START# *57E9107B0059_57AC3AE0039B_var*
var
 l_P : ImsmModelElement;
//#UC END# *57E9107B0059_57AC3AE0039B_var*
begin
//#UC START# *57E9107B0059_57AC3AE0039B_impl*
 l_P := Element.rElement.Parent;
 if (l_P = nil) then
  Result := nil
 else
  Result := MakeNode(l_P, -1); 
//#UC END# *57E9107B0059_57AC3AE0039B_impl*
end;//TmsmModelElementNode.GetParent

function TmsmModelElementNode.GetThisChildrenCount: Integer;
//#UC START# *57E910B0002C_57AC3AE0039B_var*
//#UC END# *57E910B0002C_57AC3AE0039B_var*
begin
//#UC START# *57E910B0002C_57AC3AE0039B_impl*
 if (List = nil) then
  Result := 0
 else
  Result := List.Count;
//#UC END# *57E910B0002C_57AC3AE0039B_impl*
end;//TmsmModelElementNode.GetThisChildrenCount

function TmsmModelElementNode.GetText: Tl3PCharLenPrim;
//#UC START# *57E91213016A_57AC3AE0039B_var*
//#UC END# *57E91213016A_57AC3AE0039B_var*
begin
//#UC START# *57E91213016A_57AC3AE0039B_impl*
 Result := l3PCharLen(Element.rElement.StringProp[Element.rTextName]);
//#UC END# *57E91213016A_57AC3AE0039B_impl*
end;//TmsmModelElementNode.GetText

function TmsmModelElementNode.IsFirst: Boolean;
 {* это первый узел внутри родител€? }
//#UC START# *47723CDB00A4_57AC3AE0039B_var*
//#UC END# *47723CDB00A4_57AC3AE0039B_var*
begin
//#UC START# *47723CDB00A4_57AC3AE0039B_impl*
 Result := GetIsFirst;
//#UC END# *47723CDB00A4_57AC3AE0039B_impl*
end;//TmsmModelElementNode.IsFirst

function TmsmModelElementNode.IsLast: Boolean;
 {* это последний узел внутри родител€? }
//#UC START# *47723CFF0148_57AC3AE0039B_var*
//#UC END# *47723CFF0148_57AC3AE0039B_var*
begin
//#UC START# *47723CFF0148_57AC3AE0039B_impl*
 Result := GetIsLast;
//#UC END# *47723CFF0148_57AC3AE0039B_impl*
end;//TmsmModelElementNode.IsLast

function TmsmModelElementNode.HasChild: Boolean;
 {* есть ли дочерние узлы? }
//#UC START# *47723D0F0392_57AC3AE0039B_var*
//#UC END# *47723D0F0392_57AC3AE0039B_var*
begin
//#UC START# *47723D0F0392_57AC3AE0039B_impl*
 Result := (Get_ThisChildrenCount > 0);
//#UC END# *47723D0F0392_57AC3AE0039B_impl*
end;//TmsmModelElementNode.HasChild

function TmsmModelElementNode.MaybeChild: Boolean;
 {* может ли иметь дочерние узлы? }
//#UC START# *47723D1D03D6_57AC3AE0039B_var*
//#UC END# *47723D1D03D6_57AC3AE0039B_var*
begin
//#UC START# *47723D1D03D6_57AC3AE0039B_impl*
 Result := HasChild;
//#UC END# *47723D1D03D6_57AC3AE0039B_impl*
end;//TmsmModelElementNode.MaybeChild

function TmsmModelElementNode.GetLevel: Integer;
//#UC START# *47723D2E0051_57AC3AE0039B_var*
var
 l_Node : Il3SimpleNode;
//#UC END# *47723D2E0051_57AC3AE0039B_var*
begin
//#UC START# *47723D2E0051_57AC3AE0039B_impl*
 //Result := 1;
 Result := 0;
 l_Node := Get_Parent;
 while (l_Node <> nil) do
 begin
  Inc(Result);
  l_Node := l_Node.Parent;
 end;//while (l_Node <> nil)
//#UC END# *47723D2E0051_57AC3AE0039B_impl*
end;//TmsmModelElementNode.GetLevel

function TmsmModelElementNode.GetLevelFor(const aNode: Il3SimpleNode): Integer;
//#UC START# *47723D3B0058_57AC3AE0039B_var*
var
 lCNode : Il3SimpleNode;
 l_Child : Il3SimpleNode;
//#UC END# *47723D3B0058_57AC3AE0039B_var*
begin
//#UC START# *47723D3B0058_57AC3AE0039B_impl*
 //Result := 1;
 Result := 0;
 lCNode := Self;
 while (lCNode <> nil) and not lCNode.IsSame(aNode) do
 begin
  Inc(Result);
  if (lCNode.Parent = nil) then
  begin
   l_Child := aNode.Child;
   while (l_Child <> nil) do
   begin
    if l_Child.IsSame(lCNode) then
     Exit
    else
     l_Child := l_Child.Next; 
   end;//while true
  end;//lCNode.Parent = nil
  lCNode := lCNode.Parent;
 end;//while (lCNode <> nil)
 if (lCNode = nil) then
  Result := -1;
//#UC END# *47723D3B0058_57AC3AE0039B_impl*
end;//TmsmModelElementNode.GetLevelFor

function TmsmModelElementNode.IsSame(const aNode: Il3SimpleNode): Boolean;
 {* сравнивает ноды. }
//#UC START# *47723D4C0360_57AC3AE0039B_var*
var
 l_W : ITmsmModelElementNodeWrap;
//#UC END# *47723D4C0360_57AC3AE0039B_var*
begin
//#UC START# *47723D4C0360_57AC3AE0039B_impl*
 Result := l3IEQ(Self, aNode);
 if not Result then
 begin
  if Supports(aNode, ITmsmModelElementNodeWrap, l_W) then
   try
    if (Self.Element.rElement = nil) then
     Result := (l_W.GetSelf.Element.rElement = nil) 
    else
     Result := Self.Element.rElement.IsSameElement(l_W.GetSelf.Element.rElement);
   finally
    l_W := nil;
   end;//try..finally
 end;//not Result
//#UC END# *47723D4C0360_57AC3AE0039B_impl*
end;//TmsmModelElementNode.IsSame

function TmsmModelElementNode.IsDisappeared: Boolean;
 {* True если интерфейс на удаленную ноду,
             примен€етс€ в виртуальных нодах - указател€х на данные. }
//#UC START# *47723DB901CA_57AC3AE0039B_var*
//#UC END# *47723DB901CA_57AC3AE0039B_var*
begin
//#UC START# *47723DB901CA_57AC3AE0039B_impl*
 Result := false;
//#UC END# *47723DB901CA_57AC3AE0039B_impl*
end;//TmsmModelElementNode.IsDisappeared

procedure TmsmModelElementNode.BeginMove(var aUserParam: Pointer);
 {* начать перемещение узла. }
//#UC START# *47723DD1008F_57AC3AE0039B_var*
//#UC END# *47723DD1008F_57AC3AE0039B_var*
begin
//#UC START# *47723DD1008F_57AC3AE0039B_impl*
 Assert(false);
//#UC END# *47723DD1008F_57AC3AE0039B_impl*
end;//TmsmModelElementNode.BeginMove

procedure TmsmModelElementNode.EndMove(aUserParam: Pointer);
 {* закончить перемещение узла. }
//#UC START# *47723DE0009F_57AC3AE0039B_var*
//#UC END# *47723DE0009F_57AC3AE0039B_var*
begin
//#UC START# *47723DE0009F_57AC3AE0039B_impl*
 Assert(false);
//#UC END# *47723DE0009F_57AC3AE0039B_impl*
end;//TmsmModelElementNode.EndMove

procedure TmsmModelElementNode.Delete;
 {* удалить узел из дерева, а его данные с посто€нного носител€ (например из Ѕƒ) или св€занные объекты. }
//#UC START# *47723DED006A_57AC3AE0039B_var*
//#UC END# *47723DED006A_57AC3AE0039B_var*
begin
//#UC START# *47723DED006A_57AC3AE0039B_impl*
 Assert(false);
//#UC END# *47723DED006A_57AC3AE0039B_impl*
end;//TmsmModelElementNode.Delete

function TmsmModelElementNode.Get_Text: Tl3PCharLenPrim;
//#UC START# *47723E8C0086_57AC3AE0039Bget_var*
//#UC END# *47723E8C0086_57AC3AE0039Bget_var*
begin
//#UC START# *47723E8C0086_57AC3AE0039Bget_impl*
 Result := GetText;
//#UC END# *47723E8C0086_57AC3AE0039Bget_impl*
end;//TmsmModelElementNode.Get_Text

function TmsmModelElementNode.Get_Parent: Il3SimpleNode;
//#UC START# *4772408A0361_57AC3AE0039Bget_var*
//#UC END# *4772408A0361_57AC3AE0039Bget_var*
begin
//#UC START# *4772408A0361_57AC3AE0039Bget_impl*
 Result := GetParent;
//#UC END# *4772408A0361_57AC3AE0039Bget_impl*
end;//TmsmModelElementNode.Get_Parent

function TmsmModelElementNode.Get_Child: Il3SimpleNode;
//#UC START# *477240B10267_57AC3AE0039Bget_var*
//#UC END# *477240B10267_57AC3AE0039Bget_var*
begin
//#UC START# *477240B10267_57AC3AE0039Bget_impl*
 Result := GetChild;
//#UC END# *477240B10267_57AC3AE0039Bget_impl*
end;//TmsmModelElementNode.Get_Child

function TmsmModelElementNode.Get_Next: Il3SimpleNode;
//#UC START# *477241AC00B9_57AC3AE0039Bget_var*
//#UC END# *477241AC00B9_57AC3AE0039Bget_var*
begin
//#UC START# *477241AC00B9_57AC3AE0039Bget_impl*
 Result := GetNext;
//#UC END# *477241AC00B9_57AC3AE0039Bget_impl*
end;//TmsmModelElementNode.Get_Next

function TmsmModelElementNode.Get_Flag(anIndex: Integer): Boolean;
//#UC START# *4772423302AF_57AC3AE0039Bget_var*
//#UC END# *4772423302AF_57AC3AE0039Bget_var*
begin
//#UC START# *4772423302AF_57AC3AE0039Bget_impl*
 Result := l3TestMask(f_Flags, anIndex);
//#UC END# *4772423302AF_57AC3AE0039Bget_impl*
end;//TmsmModelElementNode.Get_Flag

procedure TmsmModelElementNode.Set_Flag(anIndex: Integer;
 aValue: Boolean);
//#UC START# *4772423302AF_57AC3AE0039Bset_var*
//#UC END# *4772423302AF_57AC3AE0039Bset_var*
begin
//#UC START# *4772423302AF_57AC3AE0039Bset_impl*
 if aValue then
  l3SetMask(f_Flags, anIndex)
 else
  l3ClearMask(f_Flags, anIndex);
//#UC END# *4772423302AF_57AC3AE0039Bset_impl*
end;//TmsmModelElementNode.Set_Flag

function TmsmModelElementNode.Get_Flags: Integer;
//#UC START# *477242700004_57AC3AE0039Bget_var*
//#UC END# *477242700004_57AC3AE0039Bget_var*
begin
//#UC START# *477242700004_57AC3AE0039Bget_impl*
 Result := f_Flags;
//#UC END# *477242700004_57AC3AE0039Bget_impl*
end;//TmsmModelElementNode.Get_Flags

function TmsmModelElementNode.Get_ThisChildrenCount: Integer;
//#UC START# *4772429202E4_57AC3AE0039Bget_var*
//#UC END# *4772429202E4_57AC3AE0039Bget_var*
begin
//#UC START# *4772429202E4_57AC3AE0039Bget_impl*
 Result := GetThisChildrenCount;
//#UC END# *4772429202E4_57AC3AE0039Bget_impl*
end;//TmsmModelElementNode.Get_ThisChildrenCount

function TmsmModelElementNode.pm_GetIndexInParent: Integer;
//#UC START# *477242A40219_57AC3AE0039Bget_var*
var
 l_I : Integer;
 l_P : ImsmModelElement;
 l_C : ImsmModelElementList;
//#UC END# *477242A40219_57AC3AE0039Bget_var*
begin
//#UC START# *477242A40219_57AC3AE0039Bget_impl*
 if (f_IndexInParent < 0) then
 begin
  l_P := Element.rElement.Parent;
  if (l_P = nil) then
  begin
   Result := 0;
   f_IndexInParent := 0;
  end//l_P = nil
  else
  begin
   l_C := l_P.MEList[Element.rListName];
   for l_I := 0 to Pred(l_C.Count) do
    if l_C[l_I].IsSameElement(Element.rElement) then
    begin
     Result := l_I;
     f_IndexInParent := l_I;
     Exit;
    end;//(l_C[l_I].IsSameElement(Element)
   Result := 0;
   Assert(false);
  end;//l_P = nil
 end//f_IndexInParent < 0
 else
  Result := f_IndexInParent;
//#UC END# *477242A40219_57AC3AE0039Bget_impl*
end;//TmsmModelElementNode.pm_GetIndexInParent

function TmsmModelElementNode.CanExpandCollapseAll: Boolean;
//#UC START# *4772433F0008_57AC3AE0039B_var*
//#UC END# *4772433F0008_57AC3AE0039B_var*
begin
//#UC START# *4772433F0008_57AC3AE0039B_impl*
 Result := false;
//#UC END# *4772433F0008_57AC3AE0039B_impl*
end;//TmsmModelElementNode.CanExpandCollapseAll

procedure TmsmModelElementNode.ExpandCollapseAll(anExpand: Boolean);
//#UC START# *47724349030A_57AC3AE0039B_var*
//#UC END# *47724349030A_57AC3AE0039B_var*
begin
//#UC START# *47724349030A_57AC3AE0039B_impl*
 Assert(false);
//#UC END# *47724349030A_57AC3AE0039B_impl*
end;//TmsmModelElementNode.ExpandCollapseAll

function TmsmModelElementNode.CanAcceptData(const aData: Tl3TreeData): Boolean;
 {* может ли узел прин€ть данные }
//#UC START# *47A86F070101_57AC3AE0039B_var*
//#UC END# *47A86F070101_57AC3AE0039B_var*
begin
//#UC START# *47A86F070101_57AC3AE0039B_impl*
 Result := false;
//#UC END# *47A86F070101_57AC3AE0039B_impl*
end;//TmsmModelElementNode.CanAcceptData

function TmsmModelElementNode.DropData(const aData: Tl3TreeData): Boolean;
 {* прин€ть данные }
//#UC START# *47A86F1C016B_57AC3AE0039B_var*
//#UC END# *47A86F1C016B_57AC3AE0039B_var*
begin
//#UC START# *47A86F1C016B_57AC3AE0039B_impl*
 Result := false;
 Assert(false);
//#UC END# *47A86F1C016B_57AC3AE0039B_impl*
end;//TmsmModelElementNode.DropData

function TmsmModelElementNode.CanMove: Boolean;
 {* определ€ет возможность перемещени€ узла }
//#UC START# *47ADA09C019B_57AC3AE0039B_var*
//#UC END# *47ADA09C019B_57AC3AE0039B_var*
begin
//#UC START# *47ADA09C019B_57AC3AE0039B_impl*
 Result := false;
//#UC END# *47ADA09C019B_57AC3AE0039B_impl*
end;//TmsmModelElementNode.CanMove

function TmsmModelElementNode.Get_Prev: Il3SimpleNode;
//#UC START# *47B5759A03C0_57AC3AE0039Bget_var*
//#UC END# *47B5759A03C0_57AC3AE0039Bget_var*
begin
//#UC START# *47B5759A03C0_57AC3AE0039Bget_impl*
 Result := GetPrev;
//#UC END# *47B5759A03C0_57AC3AE0039Bget_impl*
end;//TmsmModelElementNode.Get_Prev

function TmsmModelElementNode.GetSelf: TmsmModelElementNode;
//#UC START# *57AC3B7301E9_57AC3AE0039B_var*
//#UC END# *57AC3B7301E9_57AC3AE0039B_var*
begin
//#UC START# *57AC3B7301E9_57AC3AE0039B_impl*
 Result := Self;
//#UC END# *57AC3B7301E9_57AC3AE0039B_impl*
end;//TmsmModelElementNode.GetSelf

procedure TmsmModelElementNode.Cleanup;
 {* ‘ункци€ очистки полей объекта. }
//#UC START# *479731C50290_57AC3AE0039B_var*
//#UC END# *479731C50290_57AC3AE0039B_var*
begin
//#UC START# *479731C50290_57AC3AE0039B_impl*
 inherited;
//#UC END# *479731C50290_57AC3AE0039B_impl*
end;//TmsmModelElementNode.Cleanup

//#UC START# *57AC3AE0039Bimpl*
//#UC END# *57AC3AE0039Bimpl*

end.
