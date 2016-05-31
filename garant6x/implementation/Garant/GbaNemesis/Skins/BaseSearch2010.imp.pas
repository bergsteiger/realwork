{$IfNDef BaseSearch2010_imp}

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Skins\BaseSearch2010.imp.pas"
// Стереотип: "VCMForm"
// Элемент модели: "BaseSearch2010" MUID: (4CC804B60371)
// Имя типа: "_BaseSearch2010_"

{$Define BaseSearch2010_imp}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
const
 GradientStartColor = $CF9560;
 GradientEndColor = $E1B484;

type
 _RegionableForm_Parent_ = _BaseSearch2010_Parent_;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\Skins\RegionableForm.imp.pas}
 _SkinnedForm_Parent_ = _RegionableForm_;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\Skins\SkinnedForm.imp.pas}
 _BaseSearch2010_ = {abstract} class(_SkinnedForm_)
  protected
   function BackColor1: TColor;
    {* Начало градиента }
   function BackColor2: TColor;
    {* Конец градиента }
   {$If NOT Defined(NoVCM)}
   procedure InitControls; override;
    {* Процедура инициализации контролов. Для перекрытия в потомках }
   {$IfEnd} // NOT Defined(NoVCM)
   procedure TuneRegion(aRegion: Tl3Region); override;
 end;//_BaseSearch2010_

{$Else NOT Defined(Admin) AND NOT Defined(Monitorings)}

_RegionableForm_Parent_ = _BaseSearch2010_Parent_;
{$Include w:\garant6x\implementation\Garant\GbaNemesis\Skins\RegionableForm.imp.pas}
_SkinnedForm_Parent_ = _RegionableForm_;
{$Include w:\garant6x\implementation\Garant\GbaNemesis\Skins\SkinnedForm.imp.pas}
_BaseSearch2010_ = _SkinnedForm_;

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
{$Else BaseSearch2010_imp}

{$IfNDef BaseSearch2010_imp_impl}

{$Define BaseSearch2010_imp_impl}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
{$Include w:\garant6x\implementation\Garant\GbaNemesis\Skins\RegionableForm.imp.pas}

{$Include w:\garant6x\implementation\Garant\GbaNemesis\Skins\SkinnedForm.imp.pas}

function _BaseSearch2010_.BackColor1: TColor;
 {* Начало градиента }
//#UC START# *4CC95AAD0069_4CC804B60371_var*
//#UC END# *4CC95AAD0069_4CC804B60371_var*
begin
//#UC START# *4CC95AAD0069_4CC804B60371_impl*
 if IsSkinned then
  Result := GradientStartColor
 else
  Result := c_MainMenuColor;
//#UC END# *4CC95AAD0069_4CC804B60371_impl*
end;//_BaseSearch2010_.BackColor1

function _BaseSearch2010_.BackColor2: TColor;
 {* Конец градиента }
//#UC START# *4CC95B14022B_4CC804B60371_var*
//#UC END# *4CC95B14022B_4CC804B60371_var*
begin
//#UC START# *4CC95B14022B_4CC804B60371_impl*
 if IsSkinned then
  Result := GradientEndColor
 else
  Result := c_MainMenuColor;
//#UC END# *4CC95B14022B_4CC804B60371_impl*
end;//_BaseSearch2010_.BackColor2

{$If NOT Defined(NoVCM)}
procedure _BaseSearch2010_.InitControls;
 {* Процедура инициализации контролов. Для перекрытия в потомках }
//#UC START# *4A8E8F2E0195_4CC804B60371_var*
//#UC END# *4A8E8F2E0195_4CC804B60371_var*
begin
//#UC START# *4A8E8F2E0195_4CC804B60371_impl*
 inherited;
 Self.Color := BackColor1;
//#UC END# *4A8E8F2E0195_4CC804B60371_impl*
end;//_BaseSearch2010_.InitControls
{$IfEnd} // NOT Defined(NoVCM)

procedure _BaseSearch2010_.TuneRegion(aRegion: Tl3Region);
//#UC START# *4CC847800383_4CC804B60371_var*
(*const
 cRad = 25;
var
 l_R : Tl3Region;*)
//#UC END# *4CC847800383_4CC804B60371_var*
begin
//#UC START# *4CC847800383_4CC804B60371_impl*
(* if IsSkinned then
 begin
  l_R := Tl3Region.Create;
  try
   l_R.Rgn := CreateRoundRectRgn(0, 0, Width + 1, Height, cRad, cRad);
   aRegion.Combine(l_R, RGN_OR);
   aRegion.CombineRect(l3SRect(0, 0, Width, cRad + 1), RGN_OR);
  finally
   FreeAndNil(l_R);
  end;//try..fianlly
 end;//IsSkinned*)
//#UC END# *4CC847800383_4CC804B60371_impl*
end;//_BaseSearch2010_.TuneRegion
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

{$EndIf BaseSearch2010_imp_impl}

{$EndIf BaseSearch2010_imp}

