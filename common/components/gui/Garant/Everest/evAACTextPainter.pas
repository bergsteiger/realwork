unit evAACTextPainter;
 {* Все "заточки" для отрисовки текста и содержания AAC. }

// Модуль: "w:\common\components\gui\Garant\Everest\evAACTextPainter.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TevAACTextPainter" MUID: (55CC33ED010B)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

{$If Defined(evNeedPainters)}
uses
 l3IntfUses
 , evTextParaPainter
 , l3Variant
 , nevBase
 , l3Units
;

type
 TevAACTextPainter = class(TevTextParaPainter)
  {* Все "заточки" для отрисовки текста и содержания AAC. }
  protected
   procedure CheckDrawFocused;
   procedure ValidateSegFont(aSeg: Tl3Variant); virtual;
   procedure BeforeDrawLeaf;
   procedure AfterDrawLeaf;
   procedure FillUnfilled(const aRect: Tl3Rect); override;
    {* Заливает область параграфа, которая не была залита }
   function GetBackColor: TnevColor; override;
 end;//TevAACTextPainter
{$IfEnd} // Defined(evNeedPainters)

implementation

{$If Defined(evNeedPainters)}
uses
 l3ImplUses
 {$If Defined(k2ForEditor)}
 , evAACContentUtils
 {$IfEnd} // Defined(k2ForEditor)
 , Graphics
 , k2Tags
 , HyperLink_Const
 , evdTextStyle_Const
 //#UC START# *55CC33ED010Bimpl_uses*
 //#UC END# *55CC33ED010Bimpl_uses*
;

procedure TevAACTextPainter.CheckDrawFocused;
//#UC START# *502268560274_55CC33ED010B_var*
//#UC END# *502268560274_55CC33ED010B_var*
begin
//#UC START# *502268560274_55CC33ED010B_impl*
 if (Area.rView.As_InevView.Metrics.AACLike = nev_aacLeft) then
  Area.rCanvas.NotFocused := False;
//#UC END# *502268560274_55CC33ED010B_impl*
end;//TevAACTextPainter.CheckDrawFocused

procedure TevAACTextPainter.ValidateSegFont(aSeg: Tl3Variant);
//#UC START# *4D664903006E_55CC33ED010B_var*
var
 l_Style : Tl3Variant;
//#UC END# *4D664903006E_55CC33ED010B_var*
begin
//#UC START# *4D664903006E_55CC33ED010B_impl*
 if Area.rView.As_InevView.Metrics.AACLike = nev_aacLeft then
 begin
  if not EvIsAACHyperlink(ParaX.AsObject, True) then
  begin
   l_Style := k2_typTextStyle.ValueTable.DRByID[evd_saActiveHyperLink];
   AssignFontFromStyle(Area.rCanvas.Font, l_Style);
  end; // if not EvIsAACHyperlink(ParaX.AsObject, True) then
 end; // if Area.rView.As_InevView.Metrics.AACLike = nev_aacLeft then
//#UC END# *4D664903006E_55CC33ED010B_impl*
end;//TevAACTextPainter.ValidateSegFont

procedure TevAACTextPainter.BeforeDrawLeaf;
//#UC START# *55CC5EDA00AD_55CC33ED010B_var*
//#UC END# *55CC5EDA00AD_55CC33ED010B_var*
begin
//#UC START# *55CC5EDA00AD_55CC33ED010B_impl*
 if (Area.rView.As_InevView.Metrics.AACLike = nev_aacLeft) then
  Area.rCanvas.BeginDarkColor;
//#UC END# *55CC5EDA00AD_55CC33ED010B_impl*
end;//TevAACTextPainter.BeforeDrawLeaf

procedure TevAACTextPainter.AfterDrawLeaf;
//#UC START# *55CC5F0D01A2_55CC33ED010B_var*
//#UC END# *55CC5F0D01A2_55CC33ED010B_var*
begin
//#UC START# *55CC5F0D01A2_55CC33ED010B_impl*
 if (Area.rView.As_InevView.Metrics.AACLike = nev_aacLeft) then
  Area.rCanvas.EndDarkColor;
//#UC END# *55CC5F0D01A2_55CC33ED010B_impl*
end;//TevAACTextPainter.AfterDrawLeaf

procedure TevAACTextPainter.FillUnfilled(const aRect: Tl3Rect);
 {* Заливает область параграфа, которая не была залита }
//#UC START# *4E2702FE01EA_55CC33ED010B_var*
//#UC END# *4E2702FE01EA_55CC33ED010B_var*
begin
//#UC START# *4E2702FE01EA_55CC33ED010B_impl*
 if (Area.rView.As_InevView.Metrics.AACLike = nev_aacLeft) and Area.rCanvas.Invert then
 begin
  Area.rCanvas.BeginDarkColor;
  try
   Area.rCanvas.FillEmptyRect(l3Rect(0, aRect.Top, aRect.Right + Spaces.Right, aRect.Bottom))
  finally
   Area.rCanvas.EndDarkColor;
  end;
 end // if Area.rView.As_InevView.Metrics.AACLike = nev_aacLeft then
 else
  inherited;
//#UC END# *4E2702FE01EA_55CC33ED010B_impl*
end;//TevAACTextPainter.FillUnfilled

function TevAACTextPainter.GetBackColor: TnevColor;
//#UC START# *55CC33A10342_55CC33ED010B_var*
//#UC END# *55CC33A10342_55CC33ED010B_var*
begin
//#UC START# *55CC33A10342_55CC33ED010B_impl*
 Result := inherited GetBackColor;
 if (Area.rView.As_InevView.Metrics.AACLike = nev_aacLeft) then
  Area.rCanvas.BackColor := cnAACLeftBackColor;
//#UC END# *55CC33A10342_55CC33ED010B_impl*
end;//TevAACTextPainter.GetBackColor
{$IfEnd} // Defined(evNeedPainters)

end.
