{$IfNDef PrintViewDecorationRules_imp}

// Модуль: "w:\common\components\gui\Garant\Everest\PrintViewDecorationRules.imp.pas"
// Стереотип: "Impurity"

{$Define PrintViewDecorationRules_imp}

 _nsEditionsDecorationRules_Parent_ = _PrintViewDecorationRules_Parent_;
 {$Include nsEditionsDecorationRules.imp.pas}
 _PrintViewDecorationRules_ = class(_nsEditionsDecorationRules_)
  {* Правила вывода декораций на печать }
  protected
   function GetAllowsThisDecor(aFI: TnevFormatInfoPrim;
    aType: TnevDecorType): Boolean; override;
 end;//_PrintViewDecorationRules_

{$Else PrintViewDecorationRules_imp}

{$IfNDef PrintViewDecorationRules_imp_impl}

{$Define PrintViewDecorationRules_imp_impl}

{$Include nsEditionsDecorationRules.imp.pas}

function _PrintViewDecorationRules_.GetAllowsThisDecor(aFI: TnevFormatInfoPrim;
 aType: TnevDecorType): Boolean;
//#UC START# *4F33E3A20056_4F4B4B10001B_var*
//#UC END# *4F33E3A20056_4F4B4B10001B_var*
begin
//#UC START# *4F33E3A20056_4F4B4B10001B_impl*
 if (aType = nev_dtHeader) AND
    (aFI <> nil) AND
    (aFI.Obj.AsObject.IntA[k2_tiStyle] = ev_saHeaderForChangesInfo) then
  // - не показываем ссылку на справку
  // http://mdp.garant.ru/pages/viewpage.action?pageId=321988011
  // (!)(!)(+)(!)(!) http://mdp.garant.ru/pages/viewpage.action?pageId=321986755  
  Result := false  
 else
  Result := inherited GetAllowsThisDecor(aFI, aType);
//#UC END# *4F33E3A20056_4F4B4B10001B_impl*
end;//_PrintViewDecorationRules_.GetAllowsThisDecor

{$EndIf PrintViewDecorationRules_imp_impl}

{$EndIf PrintViewDecorationRules_imp}

