{$IfNDef l3Dictionary_imp}

// Модуль: "w:\common\components\rtl\Garant\L3\l3Dictionary.imp.pas"
// Стереотип: "Impurity"
// Элемент модели: "l3Dictionary" MUID: (53036F2101D3)
// Имя типа: "_l3Dictionary_"

{$Define l3Dictionary_imp}

 _StringType_ = _ItemType_;
 _IDIndexType_ = Tl3IDIndex;
 _l3DictionaryPrim_Parent_ = _l3Dictionary_Parent_;
 {$Include w:\common\components\rtl\Garant\L3\l3DictionaryPrim.imp.pas}
 _l3Dictionary_ = {abstract} class(_l3DictionaryPrim_)
 end;//_l3Dictionary_

{$Else l3Dictionary_imp}

{$IfNDef l3Dictionary_imp_impl}

{$Define l3Dictionary_imp_impl}

function ItemToWStr(const anItem: _ItemType_): Tl3WString;
//#UC START# *5304D6C5002B_53036F2101D3_var*
//#UC END# *5304D6C5002B_53036F2101D3_var*
begin
//#UC START# *5304D6C5002B_53036F2101D3_impl*
 Result := anItem.AsWStr;
//#UC END# *5304D6C5002B_53036F2101D3_impl*
end;//ItemToWStr

{$Include w:\common\components\rtl\Garant\L3\l3DictionaryPrim.imp.pas}

{$EndIf l3Dictionary_imp_impl}

{$EndIf l3Dictionary_imp}

