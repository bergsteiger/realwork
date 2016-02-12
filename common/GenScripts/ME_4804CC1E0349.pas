unit evTextParaPainter;
 {* Рисователь текстового параграфа }

// Модуль: "w:\common\components\gui\Garant\Everest\evTextParaPainter.pas"
// Стереотип: "SimpleClass"

{$Include evDefine.inc}

interface

{$If Defined(evNeedPainters)}
uses
 l3IntfUses
 , evTextParaPainterPrim
 , l3Interfaces
 , nevBase
 , l3Units
 , l3Types
 , l3Variant
 , l3CustomString
;

type
 _AACSpaceDrawing_Parent_ = TevTextParaPainterPrim;
 {$Include w:\common\components\gui\Garant\Everest\AACSpaceDrawing.imp.pas}
 _evCollapsedStylePainter_Parent_ = _AACSpaceDrawing_;
 {$Include w:\common\components\gui\Garant\Everest\evCollapsedStylePainter.imp.pas}
 _nevStringCache_Parent_ = _evCollapsedStylePainter_;
 {$Include w:\common\components\gui\Garant\Everest\nevStringCache.imp.pas}
 TevTextParaPainter = class(_nevStringCache_)
  {* Рисователь текстового параграфа }
  protected
   procedure AssignFontFromStyle(const aFont: Il3Font;
    const aStyle: Tl3Variant);
   function NeedCalcSpace: Boolean; override;
    {* Проверка для срабатывания примеси. }
   function HeaderOwnSpace: Boolean; override;
   function GetSpaceTop(anInc: Boolean): Integer; override;
   {$If NOT Defined(DesignTimeLibrary)}
   class function IsCacheable: Boolean; override;
    {* функция класса, определяющая могут ли объекты данного класса попадать в кэш повторного использования. }
   {$IfEnd} // NOT Defined(DesignTimeLibrary)
 end;//TevTextParaPainter
{$IfEnd} // Defined(evNeedPainters)

implementation

{$If Defined(evNeedPainters)}
uses
 l3ImplUses
 {$If Defined(k2ForEditor)}
 , evParaTools
 {$IfEnd} // Defined(k2ForEditor)
 , k2Tags
 , l3MinMax
 , l3String
 , l3Chars
 , l3Const
 , evParaString
 , SysUtils
;

{$Include w:\common\components\gui\Garant\Everest\AACSpaceDrawing.imp.pas}

{$Include w:\common\components\gui\Garant\Everest\evCollapsedStylePainter.imp.pas}

{$Include w:\common\components\gui\Garant\Everest\nevStringCache.imp.pas}

procedure TevTextParaPainter.AssignFontFromStyle(const aFont: Il3Font;
 const aStyle: Tl3Variant);
//#UC START# *55CC63800051_4804CC1E0349_var*
//#UC END# *55CC63800051_4804CC1E0349_var*
begin
//#UC START# *55CC63800051_4804CC1E0349_impl*
 if aStyle.IsValid then
  if aStyle.HasSubAtom(k2_tiFont) then
   with aStyle.Attr[k2_tiFont] do
    with aFont do
    begin
     if HasSubAtom(k2_tiUnderline) then
      Underline := BoolA[k2_tiUnderline];
     if HasSubAtom(k2_tiBold) then
      Bold := BoolA[k2_tiBold];
     if HasSubAtom(k2_tiItalic) then
      Italic := BoolA[k2_tiItalic];
     if HasSubAtom(k2_tiStrikeout) then
      Strikeout := BoolA[k2_tiStrikeout];
     if HasSubAtom(k2_tiForeColor) then
      ForeColor := IntA[k2_tiForeColor];
     if HasSubAtom(k2_tiBackColor) then
      BackColor := IntA[k2_tiBackColor];
    end;//Font
//#UC END# *55CC63800051_4804CC1E0349_impl*
end;//TevTextParaPainter.AssignFontFromStyle

function TevTextParaPainter.NeedCalcSpace: Boolean;
 {* Проверка для срабатывания примеси. }
//#UC START# *5062C0650076_4804CC1E0349_var*
//#UC END# *5062C0650076_4804CC1E0349_var*
begin
//#UC START# *5062C0650076_4804CC1E0349_impl*
 Result := not Area.rCanvas.Printing and evHasAACStyle(ParaX.AsObject);
//#UC END# *5062C0650076_4804CC1E0349_impl*
end;//TevTextParaPainter.NeedCalcSpace

function TevTextParaPainter.HeaderOwnSpace: Boolean;
//#UC START# *51FF6BC10266_4804CC1E0349_var*
//#UC END# *51FF6BC10266_4804CC1E0349_var*
begin
//#UC START# *51FF6BC10266_4804CC1E0349_impl*
 Result := ParaX.AsObject.Attr[k2_tiStyle].BoolA[k2_tiHeaderHasOwnSpace];
//#UC END# *51FF6BC10266_4804CC1E0349_impl*
end;//TevTextParaPainter.HeaderOwnSpace

function TevTextParaPainter.GetSpaceTop(anInc: Boolean): Integer;
//#UC START# *5208B63400C1_4804CC1E0349_var*
//#UC END# *5208B63400C1_4804CC1E0349_var*
begin
//#UC START# *5208B63400C1_4804CC1E0349_impl*
 Result := Spaces.Top;
//#UC END# *5208B63400C1_4804CC1E0349_impl*
end;//TevTextParaPainter.GetSpaceTop

{$If NOT Defined(DesignTimeLibrary)}
class function TevTextParaPainter.IsCacheable: Boolean;
 {* функция класса, определяющая могут ли объекты данного класса попадать в кэш повторного использования. }
//#UC START# *47A6FEE600FC_4804CC1E0349_var*
//#UC END# *47A6FEE600FC_4804CC1E0349_var*
begin
//#UC START# *47A6FEE600FC_4804CC1E0349_impl*
 Result := true;
//#UC END# *47A6FEE600FC_4804CC1E0349_impl*
end;//TevTextParaPainter.IsCacheable
{$IfEnd} // NOT Defined(DesignTimeLibrary)

{$IfEnd} // Defined(evNeedPainters)
end.
