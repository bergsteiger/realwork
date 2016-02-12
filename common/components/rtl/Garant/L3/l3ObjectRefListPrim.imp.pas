{$IfNDef l3ObjectRefListPrim_imp}

// ������: "w:\common\components\rtl\Garant\L3\l3ObjectRefListPrim.imp.pas"
// ���������: "Impurity"

{$Define l3ObjectRefListPrim_imp}

 _l3RefList_Parent_ = _l3ObjectRefListPrim_Parent_;
 {$Include w:\common\components\rtl\Garant\L3\l3RefList.imp.pas}
 _l3ObjectRefListPrim_ = {abstract} class(_l3RefList_)
 end;//_l3ObjectRefListPrim_

{$Else l3ObjectRefListPrim_imp}

{$IfNDef l3ObjectRefListPrim_imp_impl}

{$Define l3ObjectRefListPrim_imp_impl}

{$If not Declared(_DataType_)}type _DataType_ = Tl3Ptr;{$IfEnd}

{$If not Declared(_FindDataType_)}type _FindDataType_ = _ItemType_;{$IfEnd}

{$If NOT Defined(l3Items_IsAtomic)}
function IsSameItems(const A: _ItemType_;
 const B: _ItemType_): Boolean;
 {* ���������� �������� ������ }
//#UC START# *47B07CF403D0_47B5A0AE03CC_var*
//#UC END# *47B07CF403D0_47B5A0AE03CC_var*
begin
//#UC START# *47B07CF403D0_47B5A0AE03CC_impl*
 Result := (A = B);
//#UC END# *47B07CF403D0_47B5A0AE03CC_impl*
end;//IsSameItems
{$IfEnd} // NOT Defined(l3Items_IsAtomic)

{$Include w:\common\components\rtl\Garant\L3\l3RefList.imp.pas}

{$EndIf l3ObjectRefListPrim_imp_impl}

{$EndIf l3ObjectRefListPrim_imp}

