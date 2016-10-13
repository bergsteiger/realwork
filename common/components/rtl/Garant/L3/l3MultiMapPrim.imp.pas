{$IfNDef l3MultiMapPrim_imp}

// ������: "w:\common\components\rtl\Garant\L3\l3MultiMapPrim.imp.pas"
// ���������: "Impurity"
// ������� ������: "l3MultiMapPrim" MUID: (57F7D217018F)
// ��� ����: "_l3MultiMapPrim_"

{$Define l3MultiMapPrim_imp}

 //#UC START# *57F7D217018Fci*
 //#UC END# *57F7D217018Fci*
 _l3MapPrimPrim_Parent_ = _l3MultiMapPrim_Parent_;
 {$Include w:\common\components\rtl\Garant\L3\l3MapPrimPrim.imp.pas}
 //#UC START# *57F7D217018Fcit*
 type
 //#UC END# *57F7D217018Fcit*
 _l3MultiMapPrim_ = class(_l3MapPrimPrim_)
  protected
   procedure InitFields; override;
 //#UC START# *57F7D217018Fpubl*
 //#UC END# *57F7D217018Fpubl*
 end;//_l3MultiMapPrim_

{$Else l3MultiMapPrim_imp}

{$IfNDef l3MultiMapPrim_imp_impl}

{$Define l3MultiMapPrim_imp_impl}

function CompareExistingItems(const CI: CompareItemsRec): Integer; forward;

{$If NOT Defined(l3Items_IsAtomic)}
function IsSameItems(const A: _ItemType_;
 const B: _ItemType_): Boolean;
 {* ���������� �������� ������ }
//#UC START# *47B07CF403D0_57F7D217018F_var*
//#UC END# *47B07CF403D0_57F7D217018F_var*
begin
//#UC START# *47B07CF403D0_57F7D217018F_impl*
 Result := (CompareKeys(A.rKey, B.rKey) = 0)
           AND (CompareValues(A.rValue, B.rValue) = 0);
//#UC END# *47B07CF403D0_57F7D217018F_impl*
end;//IsSameItems
{$IfEnd} // NOT Defined(l3Items_IsAtomic)

function CompareExistingItems(const CI: CompareItemsRec): Integer;
 {* ���������� ��� ������������ ��������. }
//#UC START# *47B99D4503A2_57F7D217018F_var*
//#UC END# *47B99D4503A2_57F7D217018F_var*
begin
//#UC START# *47B99D4503A2_57F7D217018F_impl*
 Result := CompareKeys(CI.rA^.rKey, CI.rB^.rKey);
 if (Result = 0) then
  Result := CompareValues(CI.rA^.rValue, CI.rB^.rValue);
//#UC END# *47B99D4503A2_57F7D217018F_impl*
end;//CompareExistingItems

{$Include w:\common\components\rtl\Garant\L3\l3MapPrimPrim.imp.pas}

procedure _l3MultiMapPrim_.InitFields;
//#UC START# *47A042E100E2_57F7D217018F_var*
//#UC END# *47A042E100E2_57F7D217018F_var*
begin
//#UC START# *47A042E100E2_57F7D217018F_impl*
 inherited;
 //Duplicates := l3_dupAccept;
 Duplicates := l3_dupIgnore;
//#UC END# *47A042E100E2_57F7D217018F_impl*
end;//_l3MultiMapPrim_.InitFields

//#UC START# *57F7D217018Fimpl*
//#UC END# *57F7D217018Fimpl*

{$EndIf l3MultiMapPrim_imp_impl}

{$EndIf l3MultiMapPrim_imp}

