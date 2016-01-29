{$IfNDef RoundedControl_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "SandBox"
// Модуль: "RoundedControl.imp.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: GUIControlMixIn::Class Shared Delphi Sand Box::SandBox::Rounded::RoundedControl
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define RoundedControl_imp}
 _RegionableControl_Parent_ = _RoundedControl_Parent_;
 {$Include w:\common\components\gui\Garant\SkinnedControls\RegionableControl.imp.pas}
 _RoundedControl_ = {mixin} class(_RegionableControl_)
 protected
 // overridden protected methods
   procedure TuneRegion(aRegion: Tl3Region); override;
 end;//_RoundedControl_

{$Else RoundedControl_imp}

{$Include w:\common\components\gui\Garant\SkinnedControls\RegionableControl.imp.pas}

// start class _RoundedControl_

procedure _RoundedControl_.TuneRegion(aRegion: Tl3Region);
//#UC START# *4CC847800383_517C0F4B027C_var*
const
 cRad = 15;
var
 l_R : Tl3Region;
//#UC END# *4CC847800383_517C0F4B027C_var*
begin
//#UC START# *4CC847800383_517C0F4B027C_impl*
 l_R := Tl3Region.Create;
 try
  l_R.Rgn := CreateRoundRectRgn(1, 0, Width + 1, Height, cRad, cRad);
  aRegion.Combine(l_R, RGN_OR);
  //aRegion.CombineRect(l3SRect(Width - cRad, 0, Width, Height), RGN_OR);
 finally
  FreeAndNil(l_R);
 end;//try..fianlly
//#UC END# *4CC847800383_517C0F4B027C_impl*
end;//_RoundedControl_.TuneRegion

{$EndIf RoundedControl_imp}
