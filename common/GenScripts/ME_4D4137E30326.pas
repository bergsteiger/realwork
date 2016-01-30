{$IfNDef SelectOperation_imp}

// Модуль: "w:\common\components\gui\Garant\Everest\EditorUsers\SelectOperation.imp.pas"
// Стереотип: "Impurity"

{$Define SelectOperation_imp}

{$If NOT Defined(NoScripts)}
 _SelectOperation_ = class(_SelectOperation_Parent_)
  {* Поддержка выделения параграфа, документа и т.п. }
  public
   procedure SelectPara(aText: TevCustomEditorWindow);
    {* Выделить параграф целиком }
   procedure SelectDocument(aText: TevCustomEditorWindow);
    {* Выделить документ целиком }
 end;//_SelectOperation_

{$Else NOT Defined(NoScripts)}

_SelectOperation_ = _SelectOperation_Parent_;

{$IfEnd} // NOT Defined(NoScripts)
{$Else SelectOperation_imp}

{$IfNDef SelectOperation_imp_impl}

{$Define SelectOperation_imp_impl}

{$If NOT Defined(NoScripts)}
procedure _SelectOperation_.SelectPara(aText: TevCustomEditorWindow);
 {* Выделить параграф целиком }
//#UC START# *4D41388401C4_4D4137E30326_var*
//#UC END# *4D41388401C4_4D4137E30326_var*
begin
//#UC START# *4D41388401C4_4D4137E30326_impl*
 aText.Select(ev_stPara);
//#UC END# *4D41388401C4_4D4137E30326_impl*
end;//_SelectOperation_.SelectPara

procedure _SelectOperation_.SelectDocument(aText: TevCustomEditorWindow);
 {* Выделить документ целиком }
//#UC START# *4D4138A60088_4D4137E30326_var*
//#UC END# *4D4138A60088_4D4137E30326_var*
begin
//#UC START# *4D4138A60088_4D4137E30326_impl*
 aText.Select(ev_stDocument);
//#UC END# *4D4138A60088_4D4137E30326_impl*
end;//_SelectOperation_.SelectDocument
{$IfEnd} // NOT Defined(NoScripts)

{$EndIf SelectOperation_imp_impl}

{$EndIf SelectOperation_imp}

