{$IfNDef l3DelphiStringSearcher_imp}

// Модуль: "w:\common\components\rtl\Garant\L3\l3DelphiStringSearcher.imp.pas"
// Стереотип: "Impurity"

{$Define l3DelphiStringSearcher_imp}

 _l3DelphiStringSearcherPrim_Parent_ = _l3DelphiStringSearcher_Parent_;
 {$Include w:\common\components\rtl\Garant\L3\l3DelphiStringSearcherPrim.imp.pas}
 _l3DelphiStringSearcher_ = {abstract} class(_l3DelphiStringSearcherPrim_)
 end;//_l3DelphiStringSearcher_

{$Else l3DelphiStringSearcher_imp}

{$IfNDef l3DelphiStringSearcher_imp_impl}

{$Define l3DelphiStringSearcher_imp_impl}

{$If not Declared(_FindDataType_)}type _FindDataType_ = AnsiString;{$IfEnd}

function ItemToWStr(const anItem: _ItemType_): Tl3WString;
//#UC START# *5304D6C5002B_5304D68D03B2_var*
//#UC END# *5304D6C5002B_5304D68D03B2_var*
begin
//#UC START# *5304D6C5002B_5304D68D03B2_impl*
 Result := anItem.AsWStr;
//#UC END# *5304D6C5002B_5304D68D03B2_impl*
end;//ItemToWStr

{$Include w:\common\components\rtl\Garant\L3\l3DelphiStringSearcherPrim.imp.pas}

{$EndIf l3DelphiStringSearcher_imp_impl}

{$EndIf l3DelphiStringSearcher_imp}

