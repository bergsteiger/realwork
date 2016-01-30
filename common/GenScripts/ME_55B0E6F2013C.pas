{$IfNDef tfwDictionaryListPrim_imp}

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\tfwDictionaryListPrim.imp.pas"
// Стереотип: "Impurity"

{$Define tfwDictionaryListPrim_imp}

{$If NOT Defined(NoScripts)}
 {$Define l3Items_NoChanging}

 {$Undef l3Items_NeedsBeforeFreeItem}

 _l3UncomparabeObjectRefList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include l3UncomparabeObjectRefList.imp.pas}
 _tfwDictionaryListPrim_ = {abstract} class(_l3UncomparabeObjectRefList_)
 end;//_tfwDictionaryListPrim_

{$Else NOT Defined(NoScripts)}

_l3UncomparabeObjectRefList_Parent_ = Tl3ProtoDataContainer;
{$Define l3Items_IsProto}
{$Include l3UncomparabeObjectRefList.imp.pas}
_tfwDictionaryListPrim_ = _l3UncomparabeObjectRefList_;

{$IfEnd} // NOT Defined(NoScripts)
{$Else tfwDictionaryListPrim_imp}

{$IfNDef tfwDictionaryListPrim_imp_impl}

{$Define tfwDictionaryListPrim_imp_impl}

{$If NOT Defined(NoScripts)}
{$If Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
 const aFrom: _ItemType_);
//#UC START# *47B2C42A0163_55B0E6F2013C_var*
//#UC END# *47B2C42A0163_55B0E6F2013C_var*
begin
//#UC START# *47B2C42A0163_55B0E6F2013C_impl*
 !!! Needs to be implemented !!!
//#UC END# *47B2C42A0163_55B0E6F2013C_impl*
end;//AssignItem
{$IfEnd} // Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)

type _Instance_R_ = _tfwDictionaryListPrim_;

{$Include l3UncomparabeObjectRefList.imp.pas}
{$IfEnd} // NOT Defined(NoScripts)

{$EndIf tfwDictionaryListPrim_imp_impl}

{$EndIf tfwDictionaryListPrim_imp}

