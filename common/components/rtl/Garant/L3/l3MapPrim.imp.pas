{$IfNDef l3MapPrim_imp}

// Модуль: "w:\common\components\rtl\Garant\L3\l3MapPrim.imp.pas"
// Стереотип: "Impurity"
// Элемент модели: "l3MapPrim" MUID: (57F7CE280389)
// Имя типа: "_l3MapPrim_"

{$Define l3MapPrim_imp}

 //#UC START# *57F7CE280389ci*
 //#UC END# *57F7CE280389ci*
 _l3MapPrimPrim_Parent_ = _l3MapPrim_Parent_;
 {$Include w:\common\components\rtl\Garant\L3\l3MapPrimPrim.imp.pas}
 //#UC START# *57F7CE280389cit*
 type
 //#UC END# *57F7CE280389cit*
 _l3MapPrim_ = class(_l3MapPrimPrim_)
 //#UC START# *57F7CE280389publ*
 //#UC END# *57F7CE280389publ*
 end;//_l3MapPrim_

{$Else l3MapPrim_imp}

{$IfNDef l3MapPrim_imp_impl}

{$Define l3MapPrim_imp_impl}

function CompareExistingItems(const CI: CompareItemsRec): Integer; forward;

{$If NOT Defined(l3Items_IsAtomic)}
function IsSameItems(const A: _ItemType_;
 const B: _ItemType_): Boolean;
 {* Сравнивает элементы списка }
//#UC START# *47B07CF403D0_57F7CE280389_var*
//#UC END# *47B07CF403D0_57F7CE280389_var*
begin
//#UC START# *47B07CF403D0_57F7CE280389_impl*
 Result := false;
//#UC END# *47B07CF403D0_57F7CE280389_impl*
end;//IsSameItems
{$IfEnd} // NOT Defined(l3Items_IsAtomic)

function CompareExistingItems(const CI: CompareItemsRec): Integer;
 {* Сравнивает два существующих элемента. }
//#UC START# *47B99D4503A2_57F7CE280389_var*
//#UC END# *47B99D4503A2_57F7CE280389_var*
begin
//#UC START# *47B99D4503A2_57F7CE280389_impl*
 Result := CompareKeys(CI.rA^.rKey, CI.rB^.rKey);
//#UC END# *47B99D4503A2_57F7CE280389_impl*
end;//CompareExistingItems

{$Include w:\common\components\rtl\Garant\L3\l3MapPrimPrim.imp.pas}

//#UC START# *57F7CE280389impl*
//#UC END# *57F7CE280389impl*

{$EndIf l3MapPrim_imp_impl}

{$EndIf l3MapPrim_imp}

