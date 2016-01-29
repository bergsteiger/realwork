{$IfNDef l3Dictionary_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "L3"
// Модуль: "w:/common/components/rtl/Garant/L3/l3Dictionary.imp.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Impurity::Class>> Shared Delphi Low Level::L3::l3CoreObjects::l3Dictionary
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define l3Dictionary_imp}
 _StringType_ = _ItemType_;
 _IDIndexType_ = Tl3IDIndex;
 _l3DictionaryPrim_Parent_ = _l3Dictionary_Parent_;
 {$Include ..\L3\l3DictionaryPrim.imp.pas}
 _l3Dictionary_ = {abstract mixin} class(_l3DictionaryPrim_)
 end;//_l3Dictionary_

{$Else l3Dictionary_imp}

// start class _l3Dictionary_

function ItemToWStr(const anItem: _ItemType_): Tl3WString;
//#UC START# *5304D6C5002B_53036F2101D3_var*
//#UC END# *5304D6C5002B_53036F2101D3_var*
begin
//#UC START# *5304D6C5002B_53036F2101D3_impl*
 Result := anItem.AsWStr;
//#UC END# *5304D6C5002B_53036F2101D3_impl*
end;//ItemToWStr


{$Include ..\L3\l3DictionaryPrim.imp.pas}


{$EndIf l3Dictionary_imp}
