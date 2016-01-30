{$IfNDef ClickOnCommentHeader_imp}

// Модуль: "w:\common\components\gui\Garant\Everest\EditorUsers\ClickOnCommentHeader.imp.pas"
// Стереотип: "Impurity"

{$Define ClickOnCommentHeader_imp}

{$If NOT Defined(NoScripts)}
 _MouseClickOnPoint_Parent_ = _ClickOnCommentHeader_Parent_;
 {$Include MouseClickOnPoint.imp.pas}
 _ClickOnCommentHeader_ = class(_MouseClickOnPoint_)
  private
   function CheckCollapsed(aText: TevCustomEditorWindow): Boolean; virtual; abstract;
  protected
   function GetPoint(const aMap: InevMap): Tl3Point; override;
    {* Возвращает точку, на которую нужно спозиционироваться. }
 end;//_ClickOnCommentHeader_

{$Else NOT Defined(NoScripts)}

_MouseClickOnPoint_Parent_ = _ClickOnCommentHeader_Parent_;
{$Include MouseClickOnPoint.imp.pas}
_ClickOnCommentHeader_ = _MouseClickOnPoint_;

{$IfEnd} // NOT Defined(NoScripts)
{$Else ClickOnCommentHeader_imp}

{$IfNDef ClickOnCommentHeader_imp_impl}

{$Define ClickOnCommentHeader_imp_impl}

{$If NOT Defined(NoScripts)}
{$Include MouseClickOnPoint.imp.pas}

function _ClickOnCommentHeader_.GetPoint(const aMap: InevMap): Tl3Point;
 {* Возвращает точку, на которую нужно спозиционироваться. }
//#UC START# *4C3C927B027E_4DE7451703C8_var*
//#UC END# *4C3C927B027E_4DE7451703C8_var*
begin
//#UC START# *4C3C927B027E_4DE7451703C8_impl*
 Result.X := aMap.Bounds.Left + 100;
 Result.Y := aMap.Bounds.Top + 30;
//#UC END# *4C3C927B027E_4DE7451703C8_impl*
end;//_ClickOnCommentHeader_.GetPoint
{$IfEnd} // NOT Defined(NoScripts)

{$EndIf ClickOnCommentHeader_imp_impl}

{$EndIf ClickOnCommentHeader_imp}

