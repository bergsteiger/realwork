unit npControlsListPrim;
 {* ������ ����������� �� �����, �� ������� ���� ����������� ����������. }

// ������: "w:\common\components\gui\Garant\VT\npControlsListPrim.pas"
// ���������: "SimpleClass"

{$Include vtDefine.inc}

interface

{$If NOT Defined(NoVCM)}
uses
 l3IntfUses
 , l3ProtoDataContainer
 , npControls
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 , vtNavigator
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

type
 _ItemType_ = TnpControls;
 _l3UncomparabeObjectRefList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include l3UncomparabeObjectRefList.imp.pas}
 TnpControlsListPrim = class(_l3UncomparabeObjectRefList_)
  {* ������ ����������� �� �����, �� ������� ���� ����������� ����������. }
  public
   function Find(aControl: TControl): TnpControls; overload;
    {* ����� ��������� � ������� ������ ��������� }
   function Find(aNavigator: TvtNavigatorPrim): TnpControls; overload;
    {* ����� Link }
   procedure AddControl(aNavigator: TvtNavigatorPrim;
    aControl: TControl);
    {* ����������� ��� �������� ��� ���������, ���� ��������� �� �����, �� ���� ��� � ������ � ��������� � ���� ���������. }
   procedure DeleteControl(aControl: TControl);
    {* ������� ��������� �� ������ (���������� ��� �����������) }
   procedure DockOnForm(aControl: TControl);
    {* ������������ ��������� � ���������� �� �����, �� �������� �� ��� ���������� }
 end;//TnpControlsListPrim
{$IfEnd} // NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoVCM)}
uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

function CompareExistingItems(const CI: CompareItemsRec): Integer; forward;

{$If Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
 const aFrom: _ItemType_);
//#UC START# *47B2C42A0163_4F61DE50034C_var*
//#UC END# *47B2C42A0163_4F61DE50034C_var*
begin
//#UC START# *47B2C42A0163_4F61DE50034C_impl*
 Assert(false);
//#UC END# *47B2C42A0163_4F61DE50034C_impl*
end;//AssignItem
{$IfEnd} // Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)

function CompareExistingItems(const CI: CompareItemsRec): Integer;
 {* ���������� ��� ������������ ��������. }
//#UC START# *47B99D4503A2_4F61DE50034C_var*
//#UC END# *47B99D4503A2_4F61DE50034C_var*
begin
//#UC START# *47B99D4503A2_4F61DE50034C_impl*
 Result := -1;
 Assert(false);
//#UC END# *47B99D4503A2_4F61DE50034C_impl*
end;//CompareExistingItems

type _Instance_R_ = TnpControlsListPrim;

{$Include l3UncomparabeObjectRefList.imp.pas}

function TnpControlsListPrim.Find(aControl: TControl): TnpControls;
 {* ����� ��������� � ������� ������ ��������� }
//#UC START# *4F61DEF6012B_4F61DE50034C_var*
var
 l_Index, I : Integer;
//#UC END# *4F61DEF6012B_4F61DE50034C_var*
begin
//#UC START# *4F61DEF6012B_4F61DE50034C_impl*
 Result := nil;
 for l_Index := 0 to Pred(Count) do
 begin
  I := Items[l_Index].IndexOf(aControl);
  if (I <> -1) then
  begin
   Result := Items[l_Index];
   Break;
  end;//I <> -1
 end;//for l_Index
//#UC END# *4F61DEF6012B_4F61DE50034C_impl*
end;//TnpControlsListPrim.Find

function TnpControlsListPrim.Find(aNavigator: TvtNavigatorPrim): TnpControls;
 {* ����� Link }
//#UC START# *4F61DF1D01E2_4F61DE50034C_var*
var
 l_Index : Integer;
//#UC END# *4F61DF1D01E2_4F61DE50034C_var*
begin
//#UC START# *4F61DF1D01E2_4F61DE50034C_impl*
 Result := nil;
 for l_Index := 0 to Pred(Count) do
  if (Items[l_Index].Navigator = aNavigator) then
  begin
   Result := Items[l_Index];
   Break;
  end;//Items[l_Index].Navigator = aNavigator
//#UC END# *4F61DF1D01E2_4F61DE50034C_impl*
end;//TnpControlsListPrim.Find

procedure TnpControlsListPrim.AddControl(aNavigator: TvtNavigatorPrim;
 aControl: TControl);
 {* ����������� ��� �������� ��� ���������, ���� ��������� �� �����, �� ���� ��� � ������ � ��������� � ���� ���������. }
//#UC START# *4F61DF43019D_4F61DE50034C_var*
var
 l_Navigator : TnpControls;
//#UC END# *4F61DF43019D_4F61DE50034C_var*
begin
//#UC START# *4F61DF43019D_4F61DE50034C_impl*
 DeleteControl(aControl);
 (* ������� ��������� � ��������� � ������ *)
 l_Navigator := Find(aNavigator);
 (* �������� ����� ��������� *)
 if not Assigned(l_Navigator) then
 begin
  l_Navigator := TnpControls.Create(aNavigator);
  try
   Add(l_Navigator);
   (* ������� � ������ ����������� ���������� *)
   l_Navigator.Add(aControl);
  finally
   FreeAndNil(l_Navigator);
  end;//try..finally
 end//not Assigned(l_Navigator)
 else
 (* ������� � ������ ����������� ���������� *)
  l_Navigator.Add(aControl);
//#UC END# *4F61DF43019D_4F61DE50034C_impl*
end;//TnpControlsListPrim.AddControl

procedure TnpControlsListPrim.DeleteControl(aControl: TControl);
 {* ������� ��������� �� ������ (���������� ��� �����������) }
//#UC START# *4F61DF7A0326_4F61DE50034C_var*
var
 l_Index : Integer;
//#UC END# *4F61DF7A0326_4F61DE50034C_var*
begin
//#UC START# *4F61DF7A0326_4F61DE50034C_impl*
 for l_Index := 0 to Pred(Count) do
  if Items[l_Index].DeleteControl(aControl) then
   Break;
//#UC END# *4F61DF7A0326_4F61DE50034C_impl*
end;//TnpControlsListPrim.DeleteControl

procedure TnpControlsListPrim.DockOnForm(aControl: TControl);
 {* ������������ ��������� � ���������� �� �����, �� �������� �� ��� ���������� }
//#UC START# *4F61DF950395_4F61DE50034C_var*
var
 lN : TnpControls;
//#UC END# *4F61DF950395_4F61DE50034C_var*
begin
//#UC START# *4F61DF950395_4F61DE50034C_impl*
 lN := Find(aControl);
 if Assigned(lN) then
 begin
  (* ����� ����������� ��������� ����� ������������� ����� �� ������
     ����������� lN *)
  aControl.ManualDock(lN.Navigator);
  Assert(lN.IndexOf(lN.Navigator) < 0);
  // - �������� ����, ���������� ����
 end;//Assigned(lN)
//#UC END# *4F61DF950395_4F61DE50034C_impl*
end;//TnpControlsListPrim.DockOnForm
{$IfEnd} // NOT Defined(NoVCM)

end.
