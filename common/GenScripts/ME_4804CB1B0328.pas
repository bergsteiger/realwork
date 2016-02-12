{$IfNDef evLeafParaPainter_imp}

// Модуль: "w:\common\components\gui\Garant\Everest\evLeafParaPainter.imp.pas"
// Стереотип: "Impurity"

{$Define evLeafParaPainter_imp}

{$If Defined(evNeedPainters)}
 {$Include w:\common\components\gui\Garant\Everest\evLeafParaPainterPrim.imp.pas}
 _evLeafParaPainter_ = class(_evLeafParaPainterPrim_)
  {* Рисователь листьевых параграфов. }
  protected
   function DoDraw: Boolean;
   function HackMargin: Integer; override;
    {* Отступ, который не надо заливать цетом родителя }
 end;//_evLeafParaPainter_

{$Else Defined(evNeedPainters)}

{$Include w:\common\components\gui\Garant\Everest\evLeafParaPainterPrim.imp.pas}
_evLeafParaPainter_ = _evLeafParaPainterPrim_;

{$IfEnd} // Defined(evNeedPainters)
{$Else evLeafParaPainter_imp}

{$IfNDef evLeafParaPainter_imp_impl}

{$Define evLeafParaPainter_imp_impl}

{$If Defined(evNeedPainters)}
{$Include w:\common\components\gui\Garant\Everest\evLeafParaPainterPrim.imp.pas}

function _evLeafParaPainter_.DoDraw: Boolean;
//#UC START# *4804CB4B00B2_4804CB1B0328_var*
//#UC END# *4804CB4B00B2_4804CB1B0328_var*
begin
//#UC START# *4804CB4B00B2_4804CB1B0328_impl*
 Result := false;
 Assert(false);
//#UC END# *4804CB4B00B2_4804CB1B0328_impl*
end;//_evLeafParaPainter_.DoDraw

function _evLeafParaPainter_.HackMargin: Integer;
 {* Отступ, который не надо заливать цетом родителя }
//#UC START# *4E6F459F0278_4804CB1B0328_var*
//#UC END# *4E6F459F0278_4804CB1B0328_var*
begin
//#UC START# *4E6F459F0278_4804CB1B0328_impl*
 Result := nevInch div 6;
//#UC END# *4E6F459F0278_4804CB1B0328_impl*
end;//_evLeafParaPainter_.HackMargin
{$IfEnd} // Defined(evNeedPainters)

{$EndIf evLeafParaPainter_imp_impl}

{$EndIf evLeafParaPainter_imp}

