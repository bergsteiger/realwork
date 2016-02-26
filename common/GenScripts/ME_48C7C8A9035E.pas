unit afwHintManager;

// Модуль: "w:\common\components\gui\Garant\AFW\implementation\Visual\afwHintManager.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\gui\Garant\AFW\afwDefine.inc}

interface

uses
 l3IntfUses
 , l3ProtoObject
 , l3Interfaces
 {$If NOT Defined(NoVCL)}
 , ExtCtrls
 {$IfEnd} // NOT Defined(NoVCL)
 , Classes
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 , Graphics
;

type
 THackApplication = class(TComponent)
  public
   FHandle: hWnd;
   FBiDiMode: TBiDiMode;
   FBiDiKeyboard: AnsiString;
   FNonBiDiKeyboard: AnsiString;
   FObjectInstance: Pointer;
   FMainForm: TForm;
   FMouseControl: TControl;
   FHelpSystem: IUnknown;
   FHelpFile: AnsiString;
   FHint: AnsiString;
   FHintActive: Boolean;
   FUpdateFormatSettings: Boolean;
   FUpdateMetricSettings: Boolean;
   FShowMainForm: Boolean;
   FHintColor: TColor;
   FHintControl: TControl;
 end;//THackApplication

 TafwHintManager = class(Tl3ProtoObject)
  private
   f_HintPos: TPoint;
   f_Timer: TTimer;
  private
   procedure TimerProc(Sender: TObject);
  protected
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure InitFields; override;
  public
   procedure ActivateHint(const aPt: TPoint);
   procedure CancelHint;
   class function Instance: TafwHintManager;
    {* Метод получения экземпляра синглетона TafwHintManager }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
 end;//TafwHintManager

implementation

uses
 l3ImplUses
 , l3Base
 , SysUtils
;

var g_TafwHintManager: TafwHintManager = nil;
 {* Экземпляр синглетона TafwHintManager }

procedure TafwHintManagerFree;
 {* Метод освобождения экземпляра синглетона TafwHintManager }
begin
 l3Free(g_TafwHintManager);
end;//TafwHintManagerFree

procedure TafwHintManager.ActivateHint(const aPt: TPoint);
//#UC START# *48C7C90900F9_48C7C8A9035E_var*
var
 l_HC : TControl;
//#UC END# *48C7C90900F9_48C7C8A9035E_var*
begin
//#UC START# *48C7C90900F9_48C7C8A9035E_impl*
 if (f_HintPos.X = aPt.X) and (f_HintPos.Y = aPt.Y) then
  TimerProc(Self)
 else
 begin
  f_HintPos := aPt;
  // Restart the timer
  l_HC := THackApplication(Application).FHintControl;
  Application.CancelHint;
  THackApplication(Application).FHintControl := l_HC;
  f_Timer.Enabled := False;
  try
   f_Timer.Enabled := True;
  except
   on EOutOfResources do
    TimerProc(Self);
    // - не удалось установить таймер - включаемся сразу
  end;//try..except
 end;
//#UC END# *48C7C90900F9_48C7C8A9035E_impl*
end;//TafwHintManager.ActivateHint

procedure TafwHintManager.CancelHint;
//#UC START# *48C7C91600A7_48C7C8A9035E_var*
//#UC END# *48C7C91600A7_48C7C8A9035E_var*
begin
//#UC START# *48C7C91600A7_48C7C8A9035E_impl*
 f_Timer.Enabled := False;
 Application.CancelHint;
//#UC END# *48C7C91600A7_48C7C8A9035E_impl*
end;//TafwHintManager.CancelHint

procedure TafwHintManager.TimerProc(Sender: TObject);
//#UC START# *48C7C9210123_48C7C8A9035E_var*
//#UC END# *48C7C9210123_48C7C8A9035E_var*
begin
//#UC START# *48C7C9210123_48C7C8A9035E_impl*
 Application.ActivateHint(f_HintPos);
 f_Timer.Enabled := False;
//#UC END# *48C7C9210123_48C7C8A9035E_impl*
end;//TafwHintManager.TimerProc

class function TafwHintManager.Instance: TafwHintManager;
 {* Метод получения экземпляра синглетона TafwHintManager }
begin
 if (g_TafwHintManager = nil) then
 begin
  l3System.AddExitProc(TafwHintManagerFree);
  g_TafwHintManager := Create;
 end;
 Result := g_TafwHintManager;
end;//TafwHintManager.Instance

class function TafwHintManager.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_TafwHintManager <> nil;
end;//TafwHintManager.Exists

procedure TafwHintManager.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_48C7C8A9035E_var*
//#UC END# *479731C50290_48C7C8A9035E_var*
begin
//#UC START# *479731C50290_48C7C8A9035E_impl*
 l3Free(f_Timer);
 inherited;
//#UC END# *479731C50290_48C7C8A9035E_impl*
end;//TafwHintManager.Cleanup

procedure TafwHintManager.InitFields;
//#UC START# *47A042E100E2_48C7C8A9035E_var*
//#UC END# *47A042E100E2_48C7C8A9035E_var*
begin
//#UC START# *47A042E100E2_48C7C8A9035E_impl*
 inherited;
 f_Timer := TTimer.Create(nil);
 f_Timer.Interval := 100;
 f_Timer.OnTimer := TimerProc;
 f_Timer.Enabled := False;
//#UC END# *47A042E100E2_48C7C8A9035E_impl*
end;//TafwHintManager.InitFields

end.
