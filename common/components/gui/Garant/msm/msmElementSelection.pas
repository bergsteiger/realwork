unit msmElementSelection;

// Модуль: "w:\common\components\gui\Garant\msm\msmElementSelection.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TmsmElementSelection" MUID: (57D8F2850376)

{$Include w:\common\components\gui\Garant\msm\msm.inc}

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
 , msmConcreteModels
 , msmModelElements
 , msmModel
 {$If NOT Defined(NoScripts)}
 , tfwScriptingInterfaces
 {$IfEnd} // NOT Defined(NoScripts)
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

type
 _ItemType_ = ImsmModelElement;
 _l3InterfaceRefListPrim_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3InterfaceRefListPrim.imp.pas}
 TmsmElementSelection = class(_l3InterfaceRefListPrim_, ImsmElementSelection)
  private
   f_CurrentElement: ImsmModelElement;
   f_Model: TmsmModel;
  protected
   procedure SelectElement(const anElement: ImsmModelElement);
   procedure DeselectElement(const anElement: ImsmModelElement);
   procedure InvertElement(const anElement: ImsmModelElement);
   function IsElementSelected(const anElement: ImsmModelElement): Boolean;
   function Get_CurrentElement: ImsmModelElement;
   procedure Set_CurrentElement(const aValue: ImsmModelElement);
   procedure Clear;
   procedure ProcessSelectedF(anAction: ImsmElementSelection_ProcessSelectedF_Action);
   function Empty: Boolean;
   function IsElementSelectedOrCurrent(const anElement: ImsmModelElement): Boolean;
   function Clone: ImsmElementSelection;
   function AsArray: ItfwArray;
   procedure SelectElements(const anElements: ItfwArray);
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure ClearFields; override;
  public
   constructor Create(aModel: TmsmModel); reintroduce;
   class function Make(aModel: TmsmModel): ImsmElementSelection; reintroduce;
  protected
   property Model: TmsmModel
    read f_Model;
 end;//TmsmElementSelection

implementation

uses
 l3ImplUses
 , msmListAndTreeInterfaces
 , msmControllers
 {$If NOT Defined(NoScripts)}
 , tfwWordsIterator
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , tfwWordRefList
 {$IfEnd} // NOT Defined(NoScripts)
 , SysUtils
 , l3Base
 , l3MinMax
 , RTLConsts
 //#UC START# *57D8F2850376impl_uses*
 , msmModelElement
 //#UC END# *57D8F2850376impl_uses*
;

{$If Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
 const aFrom: _ItemType_); forward;
{$IfEnd} // Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)
function CompareExistingItems(const CI: CompareItemsRec): Integer; forward;

{$If NOT Defined(l3Items_IsAtomic)}
function IsSameItems(const A: _ItemType_;
 const B: _ItemType_): Boolean;
 {* Сравнивает элементы списка }
//#UC START# *47B07CF403D0_57D8F2850376_var*
//#UC END# *47B07CF403D0_57D8F2850376_var*
begin
//#UC START# *47B07CF403D0_57D8F2850376_impl*
 Result := A.IsSameElement(B);
//#UC END# *47B07CF403D0_57D8F2850376_impl*
end;//IsSameItems
{$IfEnd} // NOT Defined(l3Items_IsAtomic)

{$If Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
 const aFrom: _ItemType_);
//#UC START# *47B2C42A0163_57D8F2850376_var*
//#UC END# *47B2C42A0163_57D8F2850376_var*
begin
//#UC START# *47B2C42A0163_57D8F2850376_impl*
 !!! Needs to be implemented !!!
//#UC END# *47B2C42A0163_57D8F2850376_impl*
end;//AssignItem
{$IfEnd} // Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)

function CompareExistingItems(const CI: CompareItemsRec): Integer;
 {* Сравнивает два существующих элемента. }
//#UC START# *47B99D4503A2_57D8F2850376_var*
//#UC END# *47B99D4503A2_57D8F2850376_var*
begin
//#UC START# *47B99D4503A2_57D8F2850376_impl*
 Result := -1;
 Assert(false);
//#UC END# *47B99D4503A2_57D8F2850376_impl*
end;//CompareExistingItems

type _Instance_R_ = TmsmElementSelection;

{$Include w:\common\components\rtl\Garant\L3\l3InterfaceRefListPrim.imp.pas}

constructor TmsmElementSelection.Create(aModel: TmsmModel);
//#UC START# *57D8F3590260_57D8F2850376_var*
//#UC END# *57D8F3590260_57D8F2850376_var*
begin
//#UC START# *57D8F3590260_57D8F2850376_impl*
 //Assert(aModel <> nil);
 f_Model := aModel;
 inherited Create;
//#UC END# *57D8F3590260_57D8F2850376_impl*
end;//TmsmElementSelection.Create

class function TmsmElementSelection.Make(aModel: TmsmModel): ImsmElementSelection;
var
 l_Inst : TmsmElementSelection;
begin
 l_Inst := Create(aModel);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TmsmElementSelection.Make

procedure TmsmElementSelection.SelectElement(const anElement: ImsmModelElement);
//#UC START# *57D8F1FA01A6_57D8F2850376_var*
//#UC END# *57D8F1FA01A6_57D8F2850376_var*
begin
//#UC START# *57D8F1FA01A6_57D8F2850376_impl*
 Assert(anElement <> nil);
 if not IsElementSelected(anElement) then
 begin
  Add(anElement);
  if (Model <> nil) then
   Model.Fire(SelectionChangedEvent.Instance);
 end;//not IsElementSelected(anElement)
//#UC END# *57D8F1FA01A6_57D8F2850376_impl*
end;//TmsmElementSelection.SelectElement

procedure TmsmElementSelection.DeselectElement(const anElement: ImsmModelElement);
//#UC START# *57D8F212010D_57D8F2850376_var*
//#UC END# *57D8F212010D_57D8F2850376_var*
begin
//#UC START# *57D8F212010D_57D8F2850376_impl*
 Assert(anElement <> nil);
 if IsElementSelected(anElement) then
 begin
  Remove(anElement);
  if (Model <> nil) then
   Model.Fire(SelectionChangedEvent.Instance);
 end;//IsElementSelected(anElement)
//#UC END# *57D8F212010D_57D8F2850376_impl*
end;//TmsmElementSelection.DeselectElement

procedure TmsmElementSelection.InvertElement(const anElement: ImsmModelElement);
//#UC START# *57D8F221019F_57D8F2850376_var*
//#UC END# *57D8F221019F_57D8F2850376_var*
begin
//#UC START# *57D8F221019F_57D8F2850376_impl*
 if (anElement = nil) then
  Self.Clear
 else
 begin
  Assert(anElement <> nil);
  if anElement.IsSameElement(f_CurrentElement) then
  begin
   Set_CurrentElement(nil);
   if not IsElementSelected(anElement) then
    Exit;
  end;//anElement.IsSameElement(f_CurrentElement)
  if IsElementSelected(anElement) then
   Remove(anElement)
  else
   Add(anElement);
 end;//anElement = nil
 if (Model <> nil) then
  Model.Fire(SelectionChangedEvent.Instance);  
//#UC END# *57D8F221019F_57D8F2850376_impl*
end;//TmsmElementSelection.InvertElement

function TmsmElementSelection.IsElementSelected(const anElement: ImsmModelElement): Boolean;
//#UC START# *57D8F23600F5_57D8F2850376_var*
//#UC END# *57D8F23600F5_57D8F2850376_var*
begin
//#UC START# *57D8F23600F5_57D8F2850376_impl*
 if (anElement = nil) then
  Result := false
 else
  Result := IndexOf(anElement) >= 0;
//#UC END# *57D8F23600F5_57D8F2850376_impl*
end;//TmsmElementSelection.IsElementSelected

function TmsmElementSelection.Get_CurrentElement: ImsmModelElement;
//#UC START# *57D8F7E2013F_57D8F2850376get_var*
//#UC END# *57D8F7E2013F_57D8F2850376get_var*
begin
//#UC START# *57D8F7E2013F_57D8F2850376get_impl*
 Result := f_CurrentElement;
//#UC END# *57D8F7E2013F_57D8F2850376get_impl*
end;//TmsmElementSelection.Get_CurrentElement

procedure TmsmElementSelection.Set_CurrentElement(const aValue: ImsmModelElement);
//#UC START# *57D8F7E2013F_57D8F2850376set_var*
//#UC END# *57D8F7E2013F_57D8F2850376set_var*
begin
//#UC START# *57D8F7E2013F_57D8F2850376set_impl*
 f_CurrentElement := aValue;
 if (Model <> nil) then
  Model.Fire(CurrentElementChangedEvent.Instance);
//#UC END# *57D8F7E2013F_57D8F2850376set_impl*
end;//TmsmElementSelection.Set_CurrentElement

procedure TmsmElementSelection.Clear;
//#UC START# *57D9003D00C1_57D8F2850376_var*
//#UC END# *57D9003D00C1_57D8F2850376_var*
begin
//#UC START# *57D9003D00C1_57D8F2850376_impl*
 inherited Clear;
//#UC END# *57D9003D00C1_57D8F2850376_impl*
end;//TmsmElementSelection.Clear

procedure TmsmElementSelection.ProcessSelectedF(anAction: ImsmElementSelection_ProcessSelectedF_Action);
//#UC START# *57D90B4601A0_57D8F2850376_var*
var
 l_Index : Integer;
//#UC END# *57D90B4601A0_57D8F2850376_var*
begin
//#UC START# *57D90B4601A0_57D8F2850376_impl*
 if (f_CurrentElement <> nil) AND not IsElementSelected(f_CurrentElement) then
  if not anAction(f_CurrentElement) then
   Exit;
 for l_Index := 0 to Pred(Count) do
  if not anAction(Items[l_Index]) then
   Exit;
//#UC END# *57D90B4601A0_57D8F2850376_impl*
end;//TmsmElementSelection.ProcessSelectedF

function TmsmElementSelection.Empty: Boolean;
//#UC START# *57D916E503C0_57D8F2850376_var*
//#UC END# *57D916E503C0_57D8F2850376_var*
begin
//#UC START# *57D916E503C0_57D8F2850376_impl*
 Result := inherited Empty;
//#UC END# *57D916E503C0_57D8F2850376_impl*
end;//TmsmElementSelection.Empty

function TmsmElementSelection.IsElementSelectedOrCurrent(const anElement: ImsmModelElement): Boolean;
//#UC START# *57D91FEE0317_57D8F2850376_var*
//#UC END# *57D91FEE0317_57D8F2850376_var*
begin
//#UC START# *57D91FEE0317_57D8F2850376_impl*
 if (anElement = nil) then
  Result := false
 else
 if anElement.IsSameElement(f_CurrentElement) then
  Result := true
 else
  Result := IsElementSelected(anElement);
//#UC END# *57D91FEE0317_57D8F2850376_impl*
end;//TmsmElementSelection.IsElementSelectedOrCurrent

function TmsmElementSelection.Clone: ImsmElementSelection;
//#UC START# *57E2562D00BD_57D8F2850376_var*
var
 l_S : TmsmElementSelection;
 l_Index : Integer;
//#UC END# *57E2562D00BD_57D8F2850376_var*
begin
//#UC START# *57E2562D00BD_57D8F2850376_impl*
 l_S := TmsmElementSelection.Create(nil);
 try
  l_S.f_CurrentElement := Self.f_CurrentElement;
  for l_Index := 0 to Pred(Self.Count) do
   l_S.Add(Self.Items[l_Index]);
  Result := l_S;
 finally
  FreeAndNil(l_S);
 end;//try..finally
//#UC END# *57E2562D00BD_57D8F2850376_impl*
end;//TmsmElementSelection.Clone

function TmsmElementSelection.AsArray: ItfwArray;
//#UC START# *57E3F8490205_57D8F2850376_var*
var
 l_List : TtfwWordRefList;

 function DoElement(const anElement: ImsmModelElement): Boolean;
 begin//DoElement
  Result := true;
  l_List.Add(anElement.MainWord);
 end;//DoElement

//#UC END# *57E3F8490205_57D8F2850376_var*
begin
//#UC START# *57E3F8490205_57D8F2850376_impl*
 l_List := TtfwWordRefList.Create;
 try
  Self.ProcessSelectedF(L2ImsmElementSelectionProcessSelectedFAction(@DoElement));
  Result := TtfwWordsIterator.Make(l_List);
 finally
  FreeAndNil(l_List);
 end;//try..finally
//#UC END# *57E3F8490205_57D8F2850376_impl*
end;//TmsmElementSelection.AsArray

procedure TmsmElementSelection.SelectElements(const anElements: ItfwArray);
//#UC START# *57F4E7E40351_57D8F2850376_var*
var
 l_Index : Integer;
//#UC END# *57F4E7E40351_57D8F2850376_var*
begin
//#UC START# *57F4E7E40351_57D8F2850376_impl*
 Self.Clear;
 if (anElements <> nil) then
 begin
  for l_Index := 0 to Pred(anElements.Count) do
   Self.Add(TmsmModelElement.MakeFromValue(anElements.Items[l_Index]));
  if (Model <> nil) then
   Model.Fire(SelectionChangedEvent.Instance);
  if not Self.Empty then
   Self.Set_CurrentElement(Self.Last);
 end;//anElements <> nil
//#UC END# *57F4E7E40351_57D8F2850376_impl*
end;//TmsmElementSelection.SelectElements

procedure TmsmElementSelection.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_57D8F2850376_var*
//#UC END# *479731C50290_57D8F2850376_var*
begin
//#UC START# *479731C50290_57D8F2850376_impl*
 inherited;
 f_Model := nil;
//#UC END# *479731C50290_57D8F2850376_impl*
end;//TmsmElementSelection.Cleanup

procedure TmsmElementSelection.ClearFields;
begin
 f_CurrentElement := nil;
 inherited;
end;//TmsmElementSelection.ClearFields

end.
