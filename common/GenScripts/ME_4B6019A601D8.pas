unit nscFocusLabel;

// Модуль: "w:\common\components\gui\Garant\Nemesis\nscFocusLabel.pas"
// Стереотип: "GuiControl"
// Элемент модели: "TnscFocusLabel" MUID: (4B6019A601D8)

{$Include w:\common\components\gui\Garant\Nemesis\nscDefine.inc}

interface

{$If Defined(Nemesis)}
uses
 l3IntfUses
 , vtFocusLabel
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 , Messages
;

type
 TnscFocusLabel = class(TvtFocusLabel)
  private
   f_HotTruck: Boolean;
   f_AllowTrucking: Boolean;
  private
   procedure SetHotTruck(aValue: Boolean);
   procedure UpdateTruckFromCursor;
   procedure CMMouseEnter(var Message: TMessage); message CM_MOUSEENTER;
   procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
   procedure WMWindowPosChanged(var Message: TMessage); message WM_WINDOWPOSCHANGED;
  protected
   procedure pm_SetAllowTrucking(aValue: Boolean);
   function NeedUnderLine: Boolean; override;
   function AllowClickByKeyBoard: Boolean; override;
   function AllowTranslateReturn: Boolean; override;
  public
   property HotTruck: Boolean
    read f_HotTruck;
   property AllowTrucking: Boolean
    read f_AllowTrucking
    write pm_SetAllowTrucking;
 end;//TnscFocusLabel
{$IfEnd} // Defined(Nemesis)

implementation

{$If Defined(Nemesis)}
uses
 l3ImplUses
 , Windows
;

procedure TnscFocusLabel.pm_SetAllowTrucking(aValue: Boolean);
//#UC START# *4B613A0400DC_4B6019A601D8set_var*
//#UC END# *4B613A0400DC_4B6019A601D8set_var*
begin
//#UC START# *4B613A0400DC_4B6019A601D8set_impl*
 if (f_AllowTrucking <> aValue) then
 begin
  f_AllowTrucking := aValue;
  if AllowTrucking then
   UpdateTruckFromCursor;
  Invalidate;
 end;
//#UC END# *4B613A0400DC_4B6019A601D8set_impl*
end;//TnscFocusLabel.pm_SetAllowTrucking

procedure TnscFocusLabel.SetHotTruck(aValue: Boolean);
//#UC START# *4B613A180222_4B6019A601D8_var*
//#UC END# *4B613A180222_4B6019A601D8_var*
begin
//#UC START# *4B613A180222_4B6019A601D8_impl*
 if (f_HotTruck <> aValue) then
 begin
  f_HotTruck := aValue;
  if AllowTrucking then
   Invalidate;
 end;
//#UC END# *4B613A180222_4B6019A601D8_impl*
end;//TnscFocusLabel.SetHotTruck

procedure TnscFocusLabel.UpdateTruckFromCursor;
//#UC START# *4B613A2A035D_4B6019A601D8_var*
var
 l_Pos: TPoint;
//#UC END# *4B613A2A035D_4B6019A601D8_var*
begin
//#UC START# *4B613A2A035D_4B6019A601D8_impl*
 if AllowTrucking and HandleAllocated then
 begin
  GetCursorPos(l_Pos);
  SetHotTruck(PtInRect(ClientRect, ScreenToClient(l_Pos)));
 end;
//#UC END# *4B613A2A035D_4B6019A601D8_impl*
end;//TnscFocusLabel.UpdateTruckFromCursor

procedure TnscFocusLabel.CMMouseEnter(var Message: TMessage);
//#UC START# *4B613A38003A_4B6019A601D8_var*
//#UC END# *4B613A38003A_4B6019A601D8_var*
begin
//#UC START# *4B613A38003A_4B6019A601D8_impl*
 inherited;
 SetHotTruck(True);
//#UC END# *4B613A38003A_4B6019A601D8_impl*
end;//TnscFocusLabel.CMMouseEnter

procedure TnscFocusLabel.CMMouseLeave(var Message: TMessage);
//#UC START# *4B613A4E0094_4B6019A601D8_var*
//#UC END# *4B613A4E0094_4B6019A601D8_var*
begin
//#UC START# *4B613A4E0094_4B6019A601D8_impl*
 inherited;
 SetHotTruck(False);
//#UC END# *4B613A4E0094_4B6019A601D8_impl*
end;//TnscFocusLabel.CMMouseLeave

procedure TnscFocusLabel.WMWindowPosChanged(var Message: TMessage);
//#UC START# *4B613A6900B7_4B6019A601D8_var*
//#UC END# *4B613A6900B7_4B6019A601D8_var*
begin
//#UC START# *4B613A6900B7_4B6019A601D8_impl*
 inherited;
 UpdateTruckFromCursor;
//#UC END# *4B613A6900B7_4B6019A601D8_impl*
end;//TnscFocusLabel.WMWindowPosChanged

function TnscFocusLabel.NeedUnderLine: Boolean;
//#UC START# *4B61371503B9_4B6019A601D8_var*
//#UC END# *4B61371503B9_4B6019A601D8_var*
begin
//#UC START# *4B61371503B9_4B6019A601D8_impl*
 Result := inherited NeedUnderLine or (AllowTrucking and HotTruck);
//#UC END# *4B61371503B9_4B6019A601D8_impl*
end;//TnscFocusLabel.NeedUnderLine

function TnscFocusLabel.AllowClickByKeyBoard: Boolean;
//#UC START# *4C03EAA20362_4B6019A601D8_var*
//#UC END# *4C03EAA20362_4B6019A601D8_var*
begin
//#UC START# *4C03EAA20362_4B6019A601D8_impl*
 Result := True;
//#UC END# *4C03EAA20362_4B6019A601D8_impl*
end;//TnscFocusLabel.AllowClickByKeyBoard

function TnscFocusLabel.AllowTranslateReturn: Boolean;
//#UC START# *4C03EAB40015_4B6019A601D8_var*
//#UC END# *4C03EAB40015_4B6019A601D8_var*
begin
//#UC START# *4C03EAB40015_4B6019A601D8_impl*
 Result := False;
//#UC END# *4C03EAB40015_4B6019A601D8_impl*
end;//TnscFocusLabel.AllowTranslateReturn
{$IfEnd} // Defined(Nemesis)

end.
