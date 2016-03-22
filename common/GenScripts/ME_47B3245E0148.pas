{$IfNDef l3Sortable_imp}

// ������: "w:\common\components\rtl\Garant\L3\l3Sortable.imp.pas"
// ���������: "Impurity"
// ������� ������: "l3Sortable" MUID: (47B3245E0148)
// ��� ����: "_l3Sortable_"

{$Define l3Sortable_imp}

type
 PItemType = ^_ItemType_;

 _l3Sortable_ = {abstract} class(_l3Sortable_Parent_)
  private
   {$If NOT Defined(l3Items_NoSort)}
   f_Duplicates: Tl3Duplicates;
    {* ��� ��������� � �����������. }
   {$IfEnd} // NOT Defined(l3Items_NoSort)
  private
   procedure Swap(var I1: _ItemType_;
    var I2: _ItemType_); virtual; abstract;
    {* ������ �������� ��������� �������. �� ��������� ���������� ��������. }
  protected
   function pm_GetSortIndex: Tl3SortIndex;
   procedure pm_SetSortIndex(aValue: Tl3SortIndex);
   {$If NOT Defined(l3Items_NoSort)}
   function pm_GetSorted: Boolean;
   {$IfEnd} // NOT Defined(l3Items_NoSort)
   {$If NOT Defined(l3Items_NoSort)}
   procedure pm_SetSorted(aValue: Boolean);
   {$IfEnd} // NOT Defined(l3Items_NoSort)
   function pm_GetHi: Integer;
   {$If Defined(l3Items_NoSort)}
   procedure pm_SetDuplicates(aValue: Tl3Duplicates);
   {$IfEnd} // Defined(l3Items_NoSort)
   function DoGetSortIndex: Tl3SortIndex; virtual;
   procedure DoSetSortIndex(Value: Tl3SortIndex); virtual;
   {$If NOT Defined(l3Items_NoSort)}
   function DoFindInsertionPlace(const aFindData: _ItemType_;
    out theIndex: Integer): Boolean; virtual;
    {* ���� ��������� ��������� �������� � ������. ���� �� ������� - ���������� ����� �������������� �������. }
   {$IfEnd} // NOT Defined(l3Items_NoSort)
   procedure Cleanup; override;
  public
   procedure Sort; virtual;
    {* ��������� ���������. }
   procedure SortInterval(aLo: Integer;
    aHi: Integer);
    {* ��������� �������� ���������. ������� ��������������� ��������� - �� �������. }
  protected
   {$If Defined(l3Items_NoSort)}
   property Duplicates: Tl3Duplicates
    write pm_SetDuplicates;
   {$IfEnd} // Defined(l3Items_NoSort)
  public
   property SortIndex: Tl3SortIndex
    read pm_GetSortIndex
    write pm_SetSortIndex
    default l3_siUnsorted;
    {* ������ ����������. }
   {$If NOT Defined(l3Items_NoSort)}
   property Sorted: Boolean
    read pm_GetSorted
    write pm_SetSorted
    default False;
    {* ��������� �����������? }
   {$IfEnd} // NOT Defined(l3Items_NoSort)
   {$If NOT Defined(l3Items_NoSort)}
   property Duplicates: Tl3Duplicates
    read f_Duplicates
    write f_Duplicates
    default l3Types.l3_dupIgnore;
    {* ��� ��������� � �����������. }
   {$IfEnd} // NOT Defined(l3Items_NoSort)
   property Hi: Integer
    read pm_GetHi;
 end;//_l3Sortable_

{$Else l3Sortable_imp}

{$IfNDef l3Sortable_imp_impl}

{$Define l3Sortable_imp_impl}

function _l3Sortable_.pm_GetSortIndex: Tl3SortIndex;
//#UC START# *47B5AF7F03DC_47B3245E0148get_var*
//#UC END# *47B5AF7F03DC_47B3245E0148get_var*
begin
//#UC START# *47B5AF7F03DC_47B3245E0148get_impl*
 Result := DoGetSortIndex;
//#UC END# *47B5AF7F03DC_47B3245E0148get_impl*
end;//_l3Sortable_.pm_GetSortIndex

procedure _l3Sortable_.pm_SetSortIndex(aValue: Tl3SortIndex);
//#UC START# *47B5AF7F03DC_47B3245E0148set_var*
//#UC END# *47B5AF7F03DC_47B3245E0148set_var*
begin
//#UC START# *47B5AF7F03DC_47B3245E0148set_impl*
 if (SortIndex <> aValue) then
 begin
  DoSetSortIndex(aValue);
  {$If not defined(l3Items_NoSort)}
  if Sorted then
   Sort;
  {$IfEnd} //not l3Items_NoSort 
 end;//SortIndex <> Value
//#UC END# *47B5AF7F03DC_47B3245E0148set_impl*
end;//_l3Sortable_.pm_SetSortIndex

{$If NOT Defined(l3Items_NoSort)}
function _l3Sortable_.pm_GetSorted: Boolean;
//#UC START# *47B5AFCB0366_47B3245E0148get_var*
//#UC END# *47B5AFCB0366_47B3245E0148get_var*
begin
//#UC START# *47B5AFCB0366_47B3245E0148get_impl*
 Result := SortIndex <> l3_siUnsorted;
//#UC END# *47B5AFCB0366_47B3245E0148get_impl*
end;//_l3Sortable_.pm_GetSorted
{$IfEnd} // NOT Defined(l3Items_NoSort)

{$If NOT Defined(l3Items_NoSort)}
procedure _l3Sortable_.pm_SetSorted(aValue: Boolean);
//#UC START# *47B5AFCB0366_47B3245E0148set_var*
//#UC END# *47B5AFCB0366_47B3245E0148set_var*
begin
//#UC START# *47B5AFCB0366_47B3245E0148set_impl*
 if aValue then
  SortIndex := l3_siNative
 else
  SortIndex := l3_siUnsorted;
//#UC END# *47B5AFCB0366_47B3245E0148set_impl*
end;//_l3Sortable_.pm_SetSorted
{$IfEnd} // NOT Defined(l3Items_NoSort)

function _l3Sortable_.pm_GetHi: Integer;
//#UC START# *47B9802D02E7_47B3245E0148get_var*
//#UC END# *47B9802D02E7_47B3245E0148get_var*
begin
//#UC START# *47B9802D02E7_47B3245E0148get_impl*
 Result := Pred(_Instance_R_(Self).Count);
//#UC END# *47B9802D02E7_47B3245E0148get_impl*
end;//_l3Sortable_.pm_GetHi

{$If Defined(l3Items_NoSort)}
procedure _l3Sortable_.pm_SetDuplicates(aValue: Tl3Duplicates);
//#UC START# *4A6599C1023B_47B3245E0148set_var*
//#UC END# *4A6599C1023B_47B3245E0148set_var*
begin
//#UC START# *4A6599C1023B_47B3245E0148set_impl*
 Assert(aValue = l3_dupIgnore);
//#UC END# *4A6599C1023B_47B3245E0148set_impl*
end;//_l3Sortable_.pm_SetDuplicates
{$IfEnd} // Defined(l3Items_NoSort)

procedure _l3Sortable_.Sort;
 {* ��������� ���������. }
//#UC START# *47B5AE6B0294_47B3245E0148_var*
//#UC END# *47B5AE6B0294_47B3245E0148_var*
begin
//#UC START# *47B5AE6B0294_47B3245E0148_impl*
 SortInterval(0, Hi);
//#UC END# *47B5AE6B0294_47B3245E0148_impl*
end;//_l3Sortable_.Sort

procedure _l3Sortable_.SortInterval(aLo: Integer;
 aHi: Integer);
 {* ��������� �������� ���������. ������� ��������������� ��������� - �� �������. }
//#UC START# *47B5B0D4000D_47B3245E0148_var*

var
 l_SortIndex : Tl3SortIndex;

 procedure QuickSort(L, R: Longint);
 var
  I, J : Integer;
  P    : Integer;
  l_P  : PItemType;
 begin//QuickSort
  repeat
   I := L;
   J := R;
   P := (L + R) shr 1;
   repeat
    l_P := _Instance_R_(Self).ItemSlot(P);
    while DoCompareItems(_Instance_R_(Self).ItemSlot(I)^, l_P^, l_SortIndex
                         {$IfDef l3Items_CompareItemsRec_NeedsRList}, Self{$EndIf}) < 0 do
     Inc(I);
    while DoCompareItems(_Instance_R_(Self).ItemSlot(J)^, l_P^, l_SortIndex
                         {$IfDef l3Items_CompareItemsRec_NeedsRList}, Self{$EndIf}) > 0 do
     Dec(J);
    if (I <= J) then
    begin
     Swap(_Instance_R_(Self).ItemSlot(I)^, _Instance_R_(Self).ItemSlot(J)^);
     if (P = I) then
      P := J
     else
     if (P = J) then
      P := I;
     Inc(I);
     Dec(J);
    end;//I <= J
   until (I > J);
   if (L < J) then
    QuickSort(L, J);
   L := I;
  until (I >= R);
 end;//QuickSort

//#UC END# *47B5B0D4000D_47B3245E0148_var*
begin
//#UC START# *47B5B0D4000D_47B3245E0148_impl*
 if (aHi > aLo) then
 begin
  l_SortIndex := SortIndex;
  if (l_SortIndex = l3_siUnsorted) then
   l_SortIndex := l3_siNative;
  QuickSort(aLo, aHi);
 end;//aHi > aLo
//#UC END# *47B5B0D4000D_47B3245E0148_impl*
end;//_l3Sortable_.SortInterval

function _l3Sortable_.DoGetSortIndex: Tl3SortIndex;
//#UC START# *47B9841B03AD_47B3245E0148_var*
//#UC END# *47B9841B03AD_47B3245E0148_var*
begin
//#UC START# *47B9841B03AD_47B3245E0148_impl*
 Result := l3_siUnsorted;
//#UC END# *47B9841B03AD_47B3245E0148_impl*
end;//_l3Sortable_.DoGetSortIndex

procedure _l3Sortable_.DoSetSortIndex(Value: Tl3SortIndex);
//#UC START# *47B9843903DB_47B3245E0148_var*
//#UC END# *47B9843903DB_47B3245E0148_var*
begin
//#UC START# *47B9843903DB_47B3245E0148_impl*
 Assert(Value = l3_siUnsorted);
//#UC END# *47B9843903DB_47B3245E0148_impl*
end;//_l3Sortable_.DoSetSortIndex

{$If NOT Defined(l3Items_NoSort)}
function _l3Sortable_.DoFindInsertionPlace(const aFindData: _ItemType_;
 out theIndex: Integer): Boolean;
 {* ���� ��������� ��������� �������� � ������. ���� �� ������� - ���������� ����� �������������� �������. }
//#UC START# *47B98F7E03A7_47B3245E0148_var*
var
  L, H, i, C: Longint;
  // H ����������� ��������!!!!! ��. H := Pred(i);
  l_SI  : Tl3SortIndex;
  l_Dup : Tl3Duplicates;
//#UC END# *47B98F7E03A7_47B3245E0148_var*
begin
//#UC START# *47B98F7E03A7_47B3245E0148_impl*
 theIndex := 0;
 Result := false;
 H := Hi;
 l_SI := SortIndex;
 Assert(l_SI <> l3_siUnsorted);
 l_Dup := Duplicates;
// if (l_SI = aFindData.rSortIndex) then
 begin
  L := 0;
  while (L <= H) do
  begin
   i := (L + H) shr 1;
   C := DoCompareItems(_Instance_R_(Self).ItemSlot(i)^, aFindData, l_SI
                       {$IfDef l3Items_CompareItemsRec_NeedsRList}, Self{$EndIf});
   if (C < 0) then
    L := Succ(i)
   else
   begin
    if (C = 0) then
    begin
     Result := true;
     if (l_Dup = l3_dupAccept) then
     begin
      theIndex := i;
      L := Succ(i);
     end//aFindData.rDup = l3_dupAccept
     else
     begin
      H := Pred(i);
      L := i;
     end;//aFindData.rDup = l3_dupAccept
    end//C = 0
    else
     H := Pred(i);
   end;//C < 0
  end;//while (L <= H)
  if not Result OR (l_Dup <> l3_dupAccept) then
   theIndex := L;
 end//l_SI = aCompareIndex
(* else
 begin
  for i := 0 to H do
  begin
   C := DoCompareItem(i, aFindData);
   if (C >= 0) then
   begin
    theIndex := i;
    Result := (C = 0);
    if Result then break;
   end;//C >= 0
  end;//for i
 end;//l_SI = aCompareIndex*)
//#UC END# *47B98F7E03A7_47B3245E0148_impl*
end;//_l3Sortable_.DoFindInsertionPlace
{$IfEnd} // NOT Defined(l3Items_NoSort)

procedure _l3Sortable_.Cleanup;
//#UC START# *47C51B8E00FA_47B3245E0148_var*
//#UC END# *47C51B8E00FA_47B3245E0148_var*
begin
//#UC START# *47C51B8E00FA_47B3245E0148_impl*
 {$If not defined(l3Items_NoSort)}
 Duplicates := l3_dupIgnore;
 {$IfEnd}
 inherited;
//#UC END# *47C51B8E00FA_47B3245E0148_impl*
end;//_l3Sortable_.Cleanup

{$EndIf l3Sortable_imp_impl}

{$EndIf l3Sortable_imp}

