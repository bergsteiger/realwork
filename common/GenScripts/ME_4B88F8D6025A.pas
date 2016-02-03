{$IfNDef l3StringList_imp}

// ������: "w:\common\components\rtl\Garant\L3\l3StringList.imp.pas"
// ���������: "Impurity"

{$Define l3StringList_imp}

 _ItemType_ = Tl3PrimString;
 _l3UncomparabeObjectRefList_Parent_ = _l3StringList_Parent_;
 {$Include l3UncomparabeObjectRefList.imp.pas}
 _l3StringList_ = class(_l3UncomparabeObjectRefList_)
 end;//_l3StringList_

{$Else l3StringList_imp}

{$IfNDef l3StringList_imp_impl}

{$Define l3StringList_imp_impl}

function CompareExistingItems(const CI: CompareItemsRec): Integer; forward;

{$If Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
 const aFrom: _ItemType_);
//#UC START# *47B2C42A0163_4B88F8D6025A_var*
//#UC END# *47B2C42A0163_4B88F8D6025A_var*
begin
//#UC START# *47B2C42A0163_4B88F8D6025A_impl*
 aTo.Assign(aFrom);
 // - �� �������� ���� ����� AssignString, �� ��� ��� Tk2DictRec �� ����������
//#UC END# *47B2C42A0163_4B88F8D6025A_impl*
end;//AssignItem
{$IfEnd} // Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)

function CompareExistingItems(const CI: CompareItemsRec): Integer;
 {* ���������� ��� ������������ ��������. }
//#UC START# *47B99D4503A2_4B88F8D6025A_var*
//#UC END# *47B99D4503A2_4B88F8D6025A_var*
begin
//#UC START# *47B99D4503A2_4B88F8D6025A_impl*
 {$IfDef l3Items_HasCustomSort}
 Assert((CI.rSortIndex = l3_siNative) OR
        (CI.rSortIndex = l3_siCaseUnsensitive) OR
        (CI.rSortIndex = l3_siByID)
        );
 if (CI.rSortIndex = l3_siByID) then
  Result := CI.rA.StringID - CI.rB.StringID
 else
 {$EndIf l3Items_HasCustomSort}
  Result := l3Compare(CI.rA.AsWStr, CI.rB.AsWStr,
                      {$IfDef l3Items_HasCustomSort}
                      CI.rSortIndex
                      {$Else  l3Items_HasCustomSort}
                      {$IfDef l3Items_CaseUnsensitive}
                      l3_siCaseUnsensitive
                      {$Else  l3Items_CaseUnsensitive}
                      l3_siNative
                      {$EndIf l3Items_CaseUnsensitive}
                      {$EndIf l3Items_HasCustomSort}
                      );
//#UC END# *47B99D4503A2_4B88F8D6025A_impl*
end;//CompareExistingItems

{$Include l3UncomparabeObjectRefList.imp.pas}

{$EndIf l3StringList_imp_impl}

{$EndIf l3StringList_imp}

