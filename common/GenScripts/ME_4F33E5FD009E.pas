{$IfNDef nevDocumentContainerDecorationRules_imp}

// ћодуль: "w:\common\components\gui\Garant\Everest\nevDocumentContainerDecorationRules.imp.pas"
// —тереотип: "Impurity"

{$Define nevDocumentContainerDecorationRules_imp}

 _nevDocumentContainerDecorationRules_ = class(_nevDocumentContainerDecorationRules_Parent_)
  protected
   function GetAllowsThisDecor(aFI: TnevFormatInfoPrim;
    aType: TnevDecorType): Boolean; virtual;
  public
   function AllowsThisDecor(aFI: TnevFormatInfoPrim;
    aType: TnevDecorType): Boolean;
    {* –азрешает ли контейтер документа примен€ть указанное декорирование }
 end;//_nevDocumentContainerDecorationRules_

{$Else nevDocumentContainerDecorationRules_imp}

{$IfNDef nevDocumentContainerDecorationRules_imp_impl}

{$Define nevDocumentContainerDecorationRules_imp_impl}

function _nevDocumentContainerDecorationRules_.GetAllowsThisDecor(aFI: TnevFormatInfoPrim;
 aType: TnevDecorType): Boolean;
//#UC START# *4F33E3A20056_4F33E5FD009E_var*
//#UC END# *4F33E3A20056_4F33E5FD009E_var*
begin
//#UC START# *4F33E3A20056_4F33E5FD009E_impl*
 Result := true;
//#UC END# *4F33E3A20056_4F33E5FD009E_impl*
end;//_nevDocumentContainerDecorationRules_.GetAllowsThisDecor

function _nevDocumentContainerDecorationRules_.AllowsThisDecor(aFI: TnevFormatInfoPrim;
 aType: TnevDecorType): Boolean;
 {* –азрешает ли контейтер документа примен€ть указанное декорирование }
//#UC START# *4F33E2A30116_4F33E5FD009E_var*
//#UC END# *4F33E2A30116_4F33E5FD009E_var*
begin
//#UC START# *4F33E2A30116_4F33E5FD009E_impl*
 Result := {_Instance_R_}(Self).GetAllowsThisDecor(aFI, aType);
//#UC END# *4F33E2A30116_4F33E5FD009E_impl*
end;//_nevDocumentContainerDecorationRules_.AllowsThisDecor

{$EndIf nevDocumentContainerDecorationRules_imp_impl}

{$EndIf nevDocumentContainerDecorationRules_imp}

