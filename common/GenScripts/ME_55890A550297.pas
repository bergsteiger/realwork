unit l3Timer;

// ������: "w:\common\components\rtl\Garant\L3\l3Timer.pas"
// ���������: "SimpleClass"

{$Include l3Define.inc}

interface

uses
 l3IntfUses
 , l3ProtoObject
 , Classes
 , Windows
 , Messages
;

type
 Tl3Timer = class(Tl3ProtoObject)
  private
   f_WindowHandle: THandle;
   f_Enabled: Boolean;
    {* ���� ��� �������� Enabled }
   f_Interval: Cardinal;
    {* ���� ��� �������� Interval }
   f_OnTimer: TNotifyEvent;
    {* ���� ��� �������� OnTimer }
   f_OnLocalTimeChange: TNotifyEvent;
    {* ���� ��� �������� OnLocalTimeChange }
  private
   procedure UpdateTimer;
   procedure WndProc(var Msg: TMessage);
  protected
   procedure pm_SetEnabled(aValue: Boolean);
   procedure pm_SetInterval(aValue: Cardinal);
   procedure pm_SetOnTimer(aValue: TNotifyEvent);
   procedure DoOnTimer; virtual;
   procedure DoOnLocalTimeChange; virtual;
   procedure Cleanup; override;
    {* ������� ������� ����� �������. }
   procedure InitFields; override;
  public
   property Enabled: Boolean
    read f_Enabled
    write pm_SetEnabled;
   property Interval: Cardinal
    read f_Interval
    write pm_SetInterval;
   property OnTimer: TNotifyEvent
    read f_OnTimer
    write pm_SetOnTimer;
   property OnLocalTimeChange: TNotifyEvent
    read f_OnLocalTimeChange
    write f_OnLocalTimeChange;
 end;//Tl3Timer

implementation

uses
 l3ImplUses
 , l3ExceptionHandler
;

procedure Tl3Timer.pm_SetEnabled(aValue: Boolean);
//#UC START# *55890AE80379_55890A550297set_var*
//#UC END# *55890AE80379_55890A550297set_var*
begin
//#UC START# *55890AE80379_55890A550297set_impl*
 if aValue <> f_Enabled then
 begin
  f_Enabled := aValue;
  UpdateTimer;
 end;
//#UC END# *55890AE80379_55890A550297set_impl*
end;//Tl3Timer.pm_SetEnabled

procedure Tl3Timer.pm_SetInterval(aValue: Cardinal);
//#UC START# *55890B7A0309_55890A550297set_var*
//#UC END# *55890B7A0309_55890A550297set_var*
begin
//#UC START# *55890B7A0309_55890A550297set_impl*
 if aValue <> f_Interval then
 begin
   f_Interval := aValue;
   UpdateTimer;
 end;
//#UC END# *55890B7A0309_55890A550297set_impl*
end;//Tl3Timer.pm_SetInterval

procedure Tl3Timer.pm_SetOnTimer(aValue: TNotifyEvent);
//#UC START# *55890C00017C_55890A550297set_var*
//#UC END# *55890C00017C_55890A550297set_var*
begin
//#UC START# *55890C00017C_55890A550297set_impl*
  f_OnTimer := aValue;
  UpdateTimer;
//#UC END# *55890C00017C_55890A550297set_impl*
end;//Tl3Timer.pm_SetOnTimer

procedure Tl3Timer.UpdateTimer;
//#UC START# *5589142F0292_55890A550297_var*
//#UC END# *5589142F0292_55890A550297_var*
begin
//#UC START# *5589142F0292_55890A550297_impl*
  KillTimer(f_WindowHandle, 1);
  if (f_Interval <> 0) and f_Enabled and Assigned(f_OnTimer) then
    if SetTimer(f_WindowHandle, 1, f_Interval, nil) = 0 then
      raise EOutOfResources.Create('Not enough timers available');
//#UC END# *5589142F0292_55890A550297_impl*
end;//Tl3Timer.UpdateTimer

procedure Tl3Timer.WndProc(var Msg: TMessage);
//#UC START# *5589144E02EE_55890A550297_var*
//#UC END# *5589144E02EE_55890A550297_var*
begin
//#UC START# *5589144E02EE_55890A550297_impl*
  with Msg do
    case Msg of
     WM_TIMER:
      try
        DoOnTimer;
      except
        Tl3ExceptionHandler.Instance.HandleException(Self);
      end;
     WM_TIMECHANGE:
      try
        DoOnLocalTimeChange;
      except
        Tl3ExceptionHandler.Instance.HandleException(Self);
      end;
    else
      Result := DefWindowProc(f_WindowHandle, Msg, wParam, lParam);
    end;
//#UC END# *5589144E02EE_55890A550297_impl*
end;//Tl3Timer.WndProc

procedure Tl3Timer.DoOnTimer;
//#UC START# *55891D9D0016_55890A550297_var*
//#UC END# *55891D9D0016_55890A550297_var*
begin
//#UC START# *55891D9D0016_55890A550297_impl*
 if Assigned(f_OnTimer) then
  f_OnTimer(Self);
//#UC END# *55891D9D0016_55890A550297_impl*
end;//Tl3Timer.DoOnTimer

procedure Tl3Timer.DoOnLocalTimeChange;
//#UC START# *5589417C02FC_55890A550297_var*
//#UC END# *5589417C02FC_55890A550297_var*
begin
//#UC START# *5589417C02FC_55890A550297_impl*
 if Assigned(f_OnLocalTimeChange) then
  OnLocalTimeChange(Self);
//#UC END# *5589417C02FC_55890A550297_impl*
end;//Tl3Timer.DoOnLocalTimeChange

procedure Tl3Timer.Cleanup;
 {* ������� ������� ����� �������. }
//#UC START# *479731C50290_55890A550297_var*
//#UC END# *479731C50290_55890A550297_var*
begin
//#UC START# *479731C50290_55890A550297_impl*
  f_Enabled := False;
  UpdateTimer;
  Classes.DeallocateHWnd(f_WindowHandle);
  inherited;
//#UC END# *479731C50290_55890A550297_impl*
end;//Tl3Timer.Cleanup

procedure Tl3Timer.InitFields;
//#UC START# *47A042E100E2_55890A550297_var*
//#UC END# *47A042E100E2_55890A550297_var*
begin
//#UC START# *47A042E100E2_55890A550297_impl*
  inherited;
  f_Enabled := False;
  f_Interval := 1000;
  f_WindowHandle := Classes.AllocateHWnd(WndProc);
//#UC END# *47A042E100E2_55890A550297_impl*
end;//Tl3Timer.InitFields

end.
