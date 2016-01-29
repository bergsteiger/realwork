unit ChromeLikeTabSetAnimationManager;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "ChromeLikeControls"
// Модуль: "w:/common/components/gui/Garant/ChromeLikeControls/ChromeLikeTabSetAnimationManager.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi::ChromeLikeControls::ChromeLikeTabSet::ChromeLikeTabSetAnimationManager
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

interface

{$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
uses
  Classes,
  l3LongintList,
  SyncObjs,
  l3ProtoObject,
  ChromeLikeTabSetTypes
  ;

type
 TChromeLikeThreadTimer = class(Tl3ProtoObject)
 private
 // private fields
   f_Continue : Boolean;
   f_Running : Boolean;
   f_TimerThread : TThread;
   f_NeedAnimateEvent : TEvent;
   f_Interval : Integer;
    {* Поле для свойства Interval}
   f_Enabled : Boolean;
    {* Поле для свойства Enabled}
   f_OnTimer : TNotifyEvent;
    {* Поле для свойства OnTimer}
 private
 // private methods
   procedure StartTimer;
     {* Сигнатура метода StartTimer }
   procedure StopTimer;
     {* Сигнатура метода StopTimer }
 protected
 // property methods
   procedure pm_SetEnabled(aValue: Boolean);
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
 public
 // public methods
   constructor Create(aNeedAnimateEvent: TEvent); reintroduce;
 public
 // public properties
   property Interval: Integer
     read f_Interval
     write f_Interval;
   property Enabled: Boolean
     read f_Enabled
     write pm_SetEnabled;
   property OnTimer: TNotifyEvent
     read f_OnTimer
     write f_OnTimer;
 end;//TChromeLikeThreadTimer

 TChromeLikeTimerThread = class(TThread)
 private
 // private fields
   f_Timer : TChromeLikeThreadTimer;
   f_NeedAnimateEvent : TEvent;
 private
 // private methods
   procedure DoExecute;
     {* Сигнатура метода DoExecute }
 protected
 // realized methods
   procedure Execute; override;
 public
 // public methods
   constructor Create(aTimer: TChromeLikeThreadTimer;
     aNeedAnimateEvent: TEvent); reintroduce;
 end;//TChromeLikeTimerThread

 TChromeLikeTabSetAnimationManager = class(Tl3ProtoObject)
 private
 // private fields
   f_Animables : Tl3LongintList;
   f_Timer : TChromeLikeThreadTimer;
   f_NeedAnimateEvent : TEvent;
 private
 // private methods
   procedure DoOnAnimationTimer(Sender: TObject);
     {* TNotifyEvent is used for events that do not require parameters. }
   procedure CheckNeedAnimate;
     {* Сигнатура метода CheckNeedAnimate }
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
 public
 // public methods
   procedure AddAnimable(const aAnimable: IChromeLikeTabSetAnimable);
   procedure RemoveAnimable(const aAnimable: IChromeLikeTabSetAnimable);
   constructor Create; reintroduce;
     {* Сигнатура метода Create }
   procedure FinishAllImmediately;
     {* Сигнатура метода FinishAllImmediately }
   class function Exists: Boolean;
     {* Проверяет создан экземпляр синглетона или нет }
 public
 // singleton factory method
   class function Instance: TChromeLikeTabSetAnimationManager;
    {- возвращает экземпляр синглетона. }
 end;//TChromeLikeTabSetAnimationManager
{$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene

implementation

{$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
uses
  l3Base {a},
  SysUtils,
  MMSystem,
  Windows
  ;

// start class TChromeLikeThreadTimer

procedure TChromeLikeThreadTimer.StartTimer;
//#UC START# *550A630D0016_550A606F030D_var*
//#UC END# *550A630D0016_550A606F030D_var*
begin
//#UC START# *550A630D0016_550A606F030D_impl*
 Assert(f_NeedAnimateEvent <> nil);
 if f_Running then
  Exit;
 f_Continue := True;
 f_TimerThread := TChromeLikeTimerThread.Create(Self, f_NeedAnimateEvent);
 f_TimerThread.FreeOnTerminate := False;
 {$IfDef XE}
 f_TimerThread.Start;
 {$Else}
 f_TimerThread.Resume;
 {$EndIf}
 f_Running := True;
//#UC END# *550A630D0016_550A606F030D_impl*
end;//TChromeLikeThreadTimer.StartTimer

procedure TChromeLikeThreadTimer.StopTimer;
//#UC START# *550A631A0106_550A606F030D_var*
//#UC END# *550A631A0106_550A606F030D_var*
begin
//#UC START# *550A631A0106_550A606F030D_impl*
 if (f_TimerThread <> nil) then
 begin
  f_Continue := False;
  f_Running := False;
  f_TimerThread.WaitFor;
  FreeAndNil(f_TimerThread);
 end;
//#UC END# *550A631A0106_550A606F030D_impl*
end;//TChromeLikeThreadTimer.StopTimer

constructor TChromeLikeThreadTimer.Create(aNeedAnimateEvent: TEvent);
//#UC START# *551B9C3F038F_550A606F030D_var*
//#UC END# *551B9C3F038F_550A606F030D_var*
begin
//#UC START# *551B9C3F038F_550A606F030D_impl*
 inherited Create;
 f_NeedAnimateEvent := aNeedAnimateEvent;
//#UC END# *551B9C3F038F_550A606F030D_impl*
end;//TChromeLikeThreadTimer.Create

procedure TChromeLikeThreadTimer.pm_SetEnabled(aValue: Boolean);
//#UC START# *550A62970061_550A606F030Dset_var*
//#UC END# *550A62970061_550A606F030Dset_var*
begin
//#UC START# *550A62970061_550A606F030Dset_impl*
 if (aValue <> f_Enabled) then
 begin
  f_Enabled := aValue;
  if f_Enabled then
   StartTimer
  else
   StopTimer;
 end;
//#UC END# *550A62970061_550A606F030Dset_impl*
end;//TChromeLikeThreadTimer.pm_SetEnabled

procedure TChromeLikeThreadTimer.Cleanup;
//#UC START# *479731C50290_550A606F030D_var*
//#UC END# *479731C50290_550A606F030D_var*
begin
//#UC START# *479731C50290_550A606F030D_impl*
 StopTimer;
 inherited;
//#UC END# *479731C50290_550A606F030D_impl*
end;//TChromeLikeThreadTimer.Cleanup
// start class TChromeLikeTimerThread

procedure TChromeLikeTimerThread.DoExecute;
//#UC START# *550A6158014E_550A606001EE_var*
//#UC END# *550A6158014E_550A606001EE_var*
begin
//#UC START# *550A6158014E_550A606001EE_impl*
 if Assigned(f_Timer.OnTimer) then
  f_Timer.OnTimer(f_Timer);
//#UC END# *550A6158014E_550A606001EE_impl*
end;//TChromeLikeTimerThread.DoExecute

constructor TChromeLikeTimerThread.Create(aTimer: TChromeLikeThreadTimer;
  aNeedAnimateEvent: TEvent);
//#UC START# *550A616A02E0_550A606001EE_var*
//#UC END# *550A616A02E0_550A606001EE_var*
begin
//#UC START# *550A616A02E0_550A606001EE_impl*
 inherited Create(True);
 f_Timer := aTimer;
 f_NeedAnimateEvent := aNeedAnimateEvent;
//#UC END# *550A616A02E0_550A606001EE_impl*
end;//TChromeLikeTimerThread.Create

procedure TChromeLikeTimerThread.Execute;
//#UC START# *4FFFDF740099_550A606001EE_var*
var
 l_SleepTime: Integer;
 l_Last: Integer;
//#UC END# *4FFFDF740099_550A606001EE_var*
begin
//#UC START# *4FFFDF740099_550A606001EE_impl*
 while (f_Timer.f_Continue) and (not Terminated) do
 begin
  f_NeedAnimateEvent.WaitFor(INFINITE);
  l_Last := Integer(timeGetTime);
  Synchronize(DoExecute);
  l_SleepTime := f_Timer.f_Interval - (Integer(timeGetTime) - l_Last);
  if (l_SleepTime < 10) then
   l_SleepTime := 10;
  Sleep(l_SleepTime);
 end;
//#UC END# *4FFFDF740099_550A606001EE_impl*
end;//TChromeLikeTimerThread.Execute

// start class TChromeLikeTabSetAnimationManager

var g_TChromeLikeTabSetAnimationManager : TChromeLikeTabSetAnimationManager = nil;

procedure TChromeLikeTabSetAnimationManagerFree;
begin
 l3Free(g_TChromeLikeTabSetAnimationManager);
end;

class function TChromeLikeTabSetAnimationManager.Instance: TChromeLikeTabSetAnimationManager;
begin
 if (g_TChromeLikeTabSetAnimationManager = nil) then
 begin
  l3System.AddExitProc(TChromeLikeTabSetAnimationManagerFree);
  g_TChromeLikeTabSetAnimationManager := Create;
 end;
 Result := g_TChromeLikeTabSetAnimationManager;
end;


procedure TChromeLikeTabSetAnimationManager.DoOnAnimationTimer(Sender: TObject);
//#UC START# *550A64410080_550A638900A0_var*
var
 l_Animable: IChromeLikeTabSetAnimable;
 l_Index: Integer;
//#UC END# *550A64410080_550A638900A0_var*
begin
//#UC START# *550A64410080_550A638900A0_impl*
 for l_Index := Pred(f_Animables.Count) downto 0 do
 begin
  l_Animable := IChromeLikeTabSetAnimable(f_Animables[l_Index]);
  try
   l_Animable.AnimateMovement;
  finally
   l_Animable := nil;
  end;//try..finally
 end;//for l_Index...
//#UC END# *550A64410080_550A638900A0_impl*
end;//TChromeLikeTabSetAnimationManager.DoOnAnimationTimer

procedure TChromeLikeTabSetAnimationManager.CheckNeedAnimate;
//#UC START# *551BA1000265_550A638900A0_var*
//#UC END# *551BA1000265_550A638900A0_var*
begin
//#UC START# *551BA1000265_550A638900A0_impl*
 if (f_Animables.Count = 0) then
  f_NeedAnimateEvent.ResetEvent
 else
 if (f_Animables.Count = 1) then
  f_NeedAnimateEvent.SetEvent;
//#UC END# *551BA1000265_550A638900A0_impl*
end;//TChromeLikeTabSetAnimationManager.CheckNeedAnimate

procedure TChromeLikeTabSetAnimationManager.AddAnimable(const aAnimable: IChromeLikeTabSetAnimable);
//#UC START# *550A645801E2_550A638900A0_var*
//#UC END# *550A645801E2_550A638900A0_var*
begin
//#UC START# *550A645801E2_550A638900A0_impl*
 if (f_Animables.IndexOf(Integer(aAnimable)) = -1) then
  f_Animables.Add(Integer(aAnimable));
 CheckNeedAnimate;
//#UC END# *550A645801E2_550A638900A0_impl*
end;//TChromeLikeTabSetAnimationManager.AddAnimable

procedure TChromeLikeTabSetAnimationManager.RemoveAnimable(const aAnimable: IChromeLikeTabSetAnimable);
//#UC START# *550A64790157_550A638900A0_var*
//#UC END# *550A64790157_550A638900A0_var*
begin
//#UC START# *550A64790157_550A638900A0_impl*
 if (f_Animables.IndexOf(Integer(aAnimable)) <> -1) then
  f_Animables.Remove(Integer(aAnimable));
 CheckNeedAnimate;
//#UC END# *550A64790157_550A638900A0_impl*
end;//TChromeLikeTabSetAnimationManager.RemoveAnimable

constructor TChromeLikeTabSetAnimationManager.Create;
//#UC START# *55111F0A00F9_550A638900A0_var*
//#UC END# *55111F0A00F9_550A638900A0_var*
begin
//#UC START# *55111F0A00F9_550A638900A0_impl*
 inherited;
 f_Animables := Tl3LongIntList.Create;
 f_NeedAnimateEvent := TSimpleEvent.Create;
 f_Timer := TChromeLikeThreadTimer.Create(f_NeedAnimateEvent);
 with f_Timer do
 begin
  Interval := 15;
  OnTimer := DoOnAnimationTimer;
  Enabled := True;
 end;//with f_Timer
//#UC END# *55111F0A00F9_550A638900A0_impl*
end;//TChromeLikeTabSetAnimationManager.Create

procedure TChromeLikeTabSetAnimationManager.FinishAllImmediately;
//#UC START# *55ACE28F00B0_550A638900A0_var*
var
 l_Index: Integer;
 l_Animable: IChromeLikeTabSetAnimable;
//#UC END# *55ACE28F00B0_550A638900A0_var*
begin
//#UC START# *55ACE28F00B0_550A638900A0_impl*
 for l_Index := Pred(f_Animables.Count) downto 0 do
 begin
  l_Animable := IChromeLikeTabSetAnimable(f_Animables[l_Index]);
  try
   l_Animable.FinishAnimationImmediately;
  finally
   l_Animable := nil;
  end;//try..finally
 end;//for l_Index..
//#UC END# *55ACE28F00B0_550A638900A0_impl*
end;//TChromeLikeTabSetAnimationManager.FinishAllImmediately

class function TChromeLikeTabSetAnimationManager.Exists: Boolean;
 {-}
begin
 Result := g_TChromeLikeTabSetAnimationManager <> nil;
end;//TChromeLikeTabSetAnimationManager.Exists

procedure TChromeLikeTabSetAnimationManager.Cleanup;
//#UC START# *479731C50290_550A638900A0_var*
//#UC END# *479731C50290_550A638900A0_var*
begin
//#UC START# *479731C50290_550A638900A0_impl*
 f_NeedAnimateEvent.SetEvent;
 FreeAndNil(f_Timer);
 FreeAndNil(f_Animables);
 FreeAndNil(f_NeedAnimateEvent);
 inherited;
//#UC END# *479731C50290_550A638900A0_impl*
end;//TChromeLikeTabSetAnimationManager.Cleanup
{$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene

end.