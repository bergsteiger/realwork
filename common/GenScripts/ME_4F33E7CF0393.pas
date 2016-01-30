{$IfNDef nsEditionsDecorationRules_imp}

// Модуль: "w:\common\components\gui\Garant\Everest\nsEditionsDecorationRules.imp.pas"
// Стереотип: "Impurity"

{$Define nsEditionsDecorationRules_imp}

 _nsEditionsDecorationRules_ = class(_nsEditionsDecorationRules_Parent_)
  {* Правила оформления декораций для СР и ОИД }
  protected
   function GetAllowsThisDecor(aFI: TnevFormatInfoPrim;
    aType: TnevDecorType): Boolean; override;
 end;//_nsEditionsDecorationRules_

{$Else nsEditionsDecorationRules_imp}

{$IfNDef nsEditionsDecorationRules_imp_impl}

{$Define nsEditionsDecorationRules_imp_impl}

function _nsEditionsDecorationRules_.GetAllowsThisDecor(aFI: TnevFormatInfoPrim;
 aType: TnevDecorType): Boolean;
//#UC START# *4F33E3A20056_4F33E7CF0393_var*
//#UC END# *4F33E3A20056_4F33E7CF0393_var*
begin
//#UC START# *4F33E3A20056_4F33E7CF0393_impl*
 if (aType = nev_dtFooter) AND
    (aFI <> nil) AND
    (aFI.Obj.AsObject.IntA[k2_tiStyle] = ev_saFooterForChangesInfo) then
  // - не показываем ссылку на справку
  // http://mdp.garant.ru/pages/viewpage.action?pageId=321988011  
  Result := false  
 else
  Result := inherited GetAllowsThisDecor(aFI, aType);
//#UC END# *4F33E3A20056_4F33E7CF0393_impl*
end;//_nsEditionsDecorationRules_.GetAllowsThisDecor

{$EndIf nsEditionsDecorationRules_imp_impl}

{$EndIf nsEditionsDecorationRules_imp}

