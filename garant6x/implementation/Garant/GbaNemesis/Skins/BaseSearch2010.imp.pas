{$IfNDef BaseSearch2010_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Skins"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Skins/BaseSearch2010.imp.pas"
// Начат: 27.10.2010
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMForm::Class>> F1 Интерфейсные элементы::NewInterface2010::Skins::BaseSearch::BaseSearch2010
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define BaseSearch2010_imp}
{$If not defined(Admin) AND not defined(Monitorings)}
const
  { Colors }
 GradientStartColor = $CF9560;
 GradientEndColor = $E1B484;

type
 _RegionableForm_Parent_ = _BaseSearch2010_Parent_;
 {$Include ..\Skins\RegionableForm.imp.pas}
 _SkinnedForm_Parent_ = _RegionableForm_;
 {$Include ..\Skins\SkinnedForm.imp.pas}
 _BaseSearch2010_ = {abstract form} class(_SkinnedForm_)
 protected
 // overridden protected methods
   {$If not defined(NoVCM)}
   procedure InitControls; override;
     {* Процедура инициализации контролов. Для перекрытия в потомках }
   {$IfEnd} //not NoVCM
   procedure TuneRegion(aRegion: Tl3Region); override;
 protected
 // protected methods
   function BackColor1: TColor;
     {* Начало градиента }
   function BackColor2: TColor;
     {* Конец градиента }
 end;//_BaseSearch2010_
{$Else}

 _RegionableForm_Parent_ = _BaseSearch2010_Parent_;
 {$Include ..\Skins\RegionableForm.imp.pas}
 _SkinnedForm_Parent_ = _RegionableForm_;
 {$Include ..\Skins\SkinnedForm.imp.pas}
 _BaseSearch2010_ = _SkinnedForm_;

{$IfEnd} //not Admin AND not Monitorings

{$Else BaseSearch2010_imp}

{$If not defined(Admin) AND not defined(Monitorings)}

{$Include ..\Skins\RegionableForm.imp.pas}

{$Include ..\Skins\SkinnedForm.imp.pas}

// start class _BaseSearch2010_

function _BaseSearch2010_.BackColor1: TColor;
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

{$If not defined(NoVCM)}
procedure _BaseSearch2010_.InitControls;
//#UC START# *4A8E8F2E0195_4CC804B60371_var*
//#UC END# *4A8E8F2E0195_4CC804B60371_var*
begin
//#UC START# *4A8E8F2E0195_4CC804B60371_impl*
 inherited;
 Self.Color := BackColor1;
//#UC END# *4A8E8F2E0195_4CC804B60371_impl*
end;//_BaseSearch2010_.InitControls
{$IfEnd} //not NoVCM

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

{$IfEnd} //not Admin AND not Monitorings

{$EndIf BaseSearch2010_imp}
