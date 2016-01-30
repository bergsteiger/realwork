{$IfNDef RoundedControl_imp}

// Модуль: "w:\common\components\SandBox\RoundedControl.imp.pas"
// Стереотип: "GUIControlMixIn"

{$Define RoundedControl_imp}

 _RegionableControl_Parent_ = _RoundedControl_Parent_;
 {$Include RegionableControl.imp.pas}
 _RoundedControl_ = class(_RegionableControl_)
  protected
   procedure TuneRegion(aRegion: Tl3Region); override;
 end;//_RoundedControl_

{$Else RoundedControl_imp}

{$IfNDef RoundedControl_imp_impl}

{$Define RoundedControl_imp_impl}

{$Include RegionableControl.imp.pas}

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

{$EndIf RoundedControl_imp_impl}

{$EndIf RoundedControl_imp}

