unit msmModelElementNode;

// Модуль: "w:\common\components\gui\Garant\msm\msmModelElementNode.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TmsmModelElementNode" MUID: (57AC3AE0039B)

{$Include w:\common\components\msm.inc}

interface

uses
 l3IntfUses
 , msmModelElementNodeAncestor
 , l3TreeInterfaces
 , msmElementViews
 , msmModelElements
 , l3Interfaces
 , l3IID
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
 TmsmModelElementNode = class(TmsmModelElementNodeAncestor, Il3SimpleNode, Il3SimpleRootNode, ITmsmModelElementNodeWrap)
  private
   f_Flags: Integer;
   f_IndexInParent: Integer;
   f_Element: TmsmModelElementView;
   f_ElementList: ImsmModelElementList;
  protected
   function MakeNode(const anElement: ImsmModelElement;
    anIndex: Integer): Il3SimpleNode;
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
   function GetSelf: TmsmModelElementNode;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   function COMQueryInterface(const IID: Tl3GUID;
    out Obj): Tl3HResult; override;
    {* Реализация запроса интерфейса }
   procedure ClearFields; override;
  public
   constructor Create(const anElement: TmsmModelElementView;
    anIndex: Integer); reintroduce;
   class function Make(const anElement: TmsmModelElementView;
    anIndex: Integer): Il3SimpleRootNode; reintroduce;
  public
   property Element: TmsmModelElementView
    read f_Element;
   property ElementList: ImsmModelElementList
    read f_ElementList;
 //#UC START# *57AC3AE0039Bpubl*
 //#UC END# *57AC3AE0039Bpubl*
 end;//TmsmModelElementNode

implementation

uses
 l3ImplUses
 , SysUtils
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
//#UC END# *57AC3DD20352_57AC3AE0039B_var*
begin
//#UC START# *57AC3DD20352_57AC3AE0039B_impl*
 Assert(anElement.rElement <> nil);
 Assert(anElement.rListName <> '');
 Assert(anElement.rTextName <> '');
 f_Element := anElement;
 if f_Element.rElement.IsView then
  f_Element.rElement := f_Element.rElement.ElementProp['Original']
 else
 if f_Element.rElement.BoolProp['IsDiagram'] then
  f_Element.rElement := f_Element.rElement.ElementProp['Original'];
 f_ElementList := f_Element.rElement.List[f_Element.rListName];
 f_IndexInParent := anIndex;
 inherited Create;
//#UC END# *57AC3DD20352_57AC3AE0039B_impl*
end;//TmsmModelElementNode.Create

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
 Result := TmsmModelElementNode.Make(TmsmModelElementView_C(anElement, Self.f_Element.rListName, Self.f_Element.rTextName), anIndex);
//#UC END# *57AC3E47003C_57AC3AE0039B_impl*
end;//TmsmModelElementNode.MakeNode

function TmsmModelElementNode.IsFirst: Boolean;
 {* это первый узел внутри родителя? }
//#UC START# *47723CDB00A4_57AC3AE0039B_var*
var
 l_P : ImsmModelElement;
//#UC END# *47723CDB00A4_57AC3AE0039B_var*
begin
//#UC START# *47723CDB00A4_57AC3AE0039B_impl*
 l_P := f_Element.rElement.Parent;
 Result := ((l_P = nil) OR l_P.List[f_Element.rListName][0].IsSameElement(f_Element.rElement));
//#UC END# *47723CDB00A4_57AC3AE0039B_impl*
end;//TmsmModelElementNode.IsFirst

function TmsmModelElementNode.IsLast: Boolean;
 {* это последний узел внутри родителя? }
//#UC START# *47723CFF0148_57AC3AE0039B_var*
var
 l_P : ImsmModelElement;
 l_C : ImsmModelElementList;
//#UC END# *47723CFF0148_57AC3AE0039B_var*
begin
//#UC START# *47723CFF0148_57AC3AE0039B_impl*
 l_P := f_Element.rElement.Parent;
 if (l_P = nil) then
  Result := true
 else
 begin
  l_C := l_P.List[f_Element.rListName];
  Result := l_C[l_C.Count - 1].IsSameElement(f_Element.rElement);
 end;//(l_P = nil)
//#UC END# *47723CFF0148_57AC3AE0039B_impl*
end;//TmsmModelElementNode.IsLast

function TmsmModelElementNode.HasChild: Boolean;
 {* есть ли дочерние узлы? }
//#UC START# *47723D0F0392_57AC3AE0039B_var*
//#UC END# *47723D0F0392_57AC3AE0039B_var*
begin
//#UC START# *47723D0F0392_57AC3AE0039B_impl*
 Result := f_ElementList.Count > 0;
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
//#UC END# *47723D3B0058_57AC3AE0039B_var*
begin
//#UC START# *47723D3B0058_57AC3AE0039B_impl*
 //Result := 1;
 Result := 0;
 lCNode := Self;
 while (lCNode <> nil) and not lCNode.IsSame(aNode) do
 begin
  Inc(Result);
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
    Result := Self.f_Element.rElement.IsSameElement(l_W.GetSelf.f_Element.rElement);
   finally
    l_W := nil;
   end;//try..finally
 end;//not Result
//#UC END# *47723D4C0360_57AC3AE0039B_impl*
end;//TmsmModelElementNode.IsSame

function TmsmModelElementNode.IsDisappeared: Boolean;
 {* True если интерфейс на удаленную ноду,
             применяется в виртуальных нодах - указателях на данные. }
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
 {* удалить узел из дерева, а его данные с постоянного носителя (например из БД) или связанные объекты. }
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
 Result := l3PCharLen(f_Element.rElement.StringProp[f_Element.rTextName]);
//#UC END# *47723E8C0086_57AC3AE0039Bget_impl*
end;//TmsmModelElementNode.Get_Text

function TmsmModelElementNode.Get_Parent: Il3SimpleNode;
//#UC START# *4772408A0361_57AC3AE0039Bget_var*
var
 l_P : ImsmModelElement;
//#UC END# *4772408A0361_57AC3AE0039Bget_var*
begin
//#UC START# *4772408A0361_57AC3AE0039Bget_impl*
 l_P := f_Element.rElement.Parent;
 if (l_P = nil) then
  Result := nil
 else
  Result := MakeNode(l_P, -1); 
//#UC END# *4772408A0361_57AC3AE0039Bget_impl*
end;//TmsmModelElementNode.Get_Parent

function TmsmModelElementNode.Get_Child: Il3SimpleNode;
//#UC START# *477240B10267_57AC3AE0039Bget_var*
//#UC END# *477240B10267_57AC3AE0039Bget_var*
begin
//#UC START# *477240B10267_57AC3AE0039Bget_impl*
 if (f_ElementList.Count > 0) then
  Result := MakeNode(f_ElementList[0], 0)
 else
  Result := nil;
//#UC END# *477240B10267_57AC3AE0039Bget_impl*
end;//TmsmModelElementNode.Get_Child

function TmsmModelElementNode.Get_Next: Il3SimpleNode;
//#UC START# *477241AC00B9_57AC3AE0039Bget_var*
var
 l_I : Integer;
 l_P : ImsmModelElement;
//#UC END# *477241AC00B9_57AC3AE0039Bget_var*
begin
//#UC START# *477241AC00B9_57AC3AE0039Bget_impl*
 l_P := f_Element.rElement.Parent;
 if (l_P = nil) then
  Result := nil
 else
 begin
  l_I := pm_GetIndexInParent;
  if (l_I > l_P.List[f_Element.rListName].Count - 1) then
   Assert(false)
  else
  if (l_I >= l_P.List[f_Element.rListName].Count - 1) then
   Result := nil
  else
   Result := MakeNode(l_P.List[f_Element.rListName][l_I + 1], l_I + 1);
 end;//l_P = nil
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
 Result := f_ElementList.Count;
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
  l_P := f_Element.rElement.Parent;
  if (l_P = nil) then
  begin
   Result := 0;
   f_IndexInParent := 0;
  end//l_P = nil
  else
  begin
   l_C := l_P.List[f_Element.rListName];
   for l_I := 0 to Pred(l_C.Count) do
    if l_C[l_I].IsSameElement(f_Element.rElement) then
    begin
     Result := l_I;
     f_IndexInParent := l_I;
     Exit;
    end;//(l_C[l_I].IsSameElement(f_Element)
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
 {* может ли узел принять данные }
//#UC START# *47A86F070101_57AC3AE0039B_var*
//#UC END# *47A86F070101_57AC3AE0039B_var*
begin
//#UC START# *47A86F070101_57AC3AE0039B_impl*
 Result := false;
//#UC END# *47A86F070101_57AC3AE0039B_impl*
end;//TmsmModelElementNode.CanAcceptData

function TmsmModelElementNode.DropData(const aData: Tl3TreeData): Boolean;
 {* принять данные }
//#UC START# *47A86F1C016B_57AC3AE0039B_var*
//#UC END# *47A86F1C016B_57AC3AE0039B_var*
begin
//#UC START# *47A86F1C016B_57AC3AE0039B_impl*
 Result := false;
 Assert(false);
//#UC END# *47A86F1C016B_57AC3AE0039B_impl*
end;//TmsmModelElementNode.DropData

function TmsmModelElementNode.CanMove: Boolean;
 {* определяет возможность перемещения узла }
//#UC START# *47ADA09C019B_57AC3AE0039B_var*
//#UC END# *47ADA09C019B_57AC3AE0039B_var*
begin
//#UC START# *47ADA09C019B_57AC3AE0039B_impl*
 Result := false;
//#UC END# *47ADA09C019B_57AC3AE0039B_impl*
end;//TmsmModelElementNode.CanMove

function TmsmModelElementNode.Get_Prev: Il3SimpleNode;
//#UC START# *47B5759A03C0_57AC3AE0039Bget_var*
var
 l_I : Integer;
 l_P : ImsmModelElement;
//#UC END# *47B5759A03C0_57AC3AE0039Bget_var*
begin
//#UC START# *47B5759A03C0_57AC3AE0039Bget_impl*
 l_P := f_Element.rElement.Parent;
 if (l_P = nil) then
  Result := nil
 else
 begin
  l_I := pm_GetIndexInParent;
  if (l_I = 0) then
   Result := nil
  else
   Result := MakeNode(l_P.List[f_Element.rListName][l_I - 1], l_I - 1);
 end;//l_P = nil
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
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_57AC3AE0039B_var*
//#UC END# *479731C50290_57AC3AE0039B_var*
begin
//#UC START# *479731C50290_57AC3AE0039B_impl*
 Finalize(f_Element);
 inherited;
//#UC END# *479731C50290_57AC3AE0039B_impl*
end;//TmsmModelElementNode.Cleanup

function TmsmModelElementNode.COMQueryInterface(const IID: Tl3GUID;
 out Obj): Tl3HResult;
 {* Реализация запроса интерфейса }
//#UC START# *4A60B23E00C3_57AC3AE0039B_var*
//#UC END# *4A60B23E00C3_57AC3AE0039B_var*
begin
//#UC START# *4A60B23E00C3_57AC3AE0039B_impl*
 if IID.EQ(ImsmModelElement) then
 begin
  ImsmModelElement(Obj) := f_Element.rElement;
  Result.SetOk;
 end//IID.EQ(ImsmModelElement)
 else
  Result := inherited COMQueryInterface(IID, Obj);
//#UC END# *4A60B23E00C3_57AC3AE0039B_impl*
end;//TmsmModelElementNode.COMQueryInterface

procedure TmsmModelElementNode.ClearFields;
begin
 Finalize(f_Element);
 f_ElementList := nil;
 inherited;
end;//TmsmModelElementNode.ClearFields

//#UC START# *57AC3AE0039Bimpl*
//#UC END# *57AC3AE0039Bimpl*

end.
