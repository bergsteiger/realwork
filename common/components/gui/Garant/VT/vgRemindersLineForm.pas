unit vgRemindersLineForm;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VT$Rem"
// Модуль: "w:/common/components/gui/Garant/VT/vgRemindersLineForm.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<GuiControl::Class>> Shared Delphi::VT$Rem::NewReminders::TvgRemindersLineForm
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\VT\vtDefine.inc}

interface

{$If not defined(NoVGScene)}
uses
  Messages
  {$If not defined(NoVCL)}
  ,
  Controls
  {$IfEnd} //not NoVCL
  
  {$If not defined(NoVCL)}
  ,
  Forms
  {$IfEnd} //not NoVCL
  ,
  vg_scene,
  Classes
  ;
{$IfEnd} //not NoVGScene

{$If not defined(NoVGScene)}
const
  { vgReminder Messages }
 WM_SYNCPOS = WM_USER + 1;

type
 TvgRemindersLineForm = class(TForm)
 private
 // private fields
   f_ActivateProcessingLockCount : Integer;
   f_Scene : TvgCustomScene;
    {* Поле для свойства Scene}
   f_Background : TvgBackground;
    {* Поле для свойства Background}
   f_ParentControl : TWinControl;
    {* Поле для свойства ParentControl}
   f_RemindersLine : Pointer;
    {* Поле для свойства RemindersLine}
 private
 // private methods
   procedure WMMouseActivate(var Msg: TWMMouseActivate); message WM_MOUSEACTIVATE;
   procedure WMActivate(var Msg: TWMActivate); message WM_ACTIVATE;
   procedure WMContextMenu(var Msg: TMessage); message WM_CONTEXTMENU ;
   procedure WMSyncPos(var Msg: TMessage); message WM_SYNCPOS;
   procedure CMShowingChanged(var Msg: TMessage); message CM_SHOWINGCHANGED;
 protected
 // property methods
   function pm_GetIsActivateProcessingLocked: Boolean;
 protected
 // overridden protected methods
   {$If not defined(NoVCL)}
   procedure CreateParams(var Params: TCreateParams); override;
   {$IfEnd} //not NoVCL
   {$If not defined(NoVCL)}
   function CloseQuery: Boolean; override;
     {* CloseQuery is called automatically when an attempt is made to close the form. CloseQuery can allow the form to close by returning true, or prevent the form from closing by returning false.

As implemented in TCustomForm, CloseQuery polls any MDI children by calling their CloseQuery methods. If no child form aborts the close, CloseQuery then calls the OnCloseQuery event handler, if it exists, to determine if the close should be allowed. If no such event handler exists, CloseQuery returns true. }
   {$IfEnd} //not NoVCL
    {$If not defined(NoVCL)}
   procedure SetBounds(ALeft: Integer;
     ATop: Integer;
     AWidth: Integer;
     AHeight: Integer); override;
    {$IfEnd} //not NoVCL
    {$If not defined(NoVCL)}
   procedure UpdateActions; override;
     {* Сигнатура метода UpdateActions }
    {$IfEnd} //not NoVCL
 public
 // overridden public methods
   destructor Destroy; override;
    {$If not defined(NoVCL)}
   procedure DockDrop(Source: TDragDockObject;
     X: Integer;
     Y: Integer); override;
    {$IfEnd} //not NoVCL
   {$If not defined(NoVCL)}
   constructor CreateNew(AOwner: TComponent;
    Dummy: Integer = 0); override;
   {$IfEnd} //not NoVCL
 public
 // public methods
   procedure LockActivateProcessing;
     {* Сигнатура метода LockActivateProcessing }
   procedure UnlockActivateProcessing;
     {* Сигнатура метода UnlockActivateProcessing }
 private
 // private properties
   property IsActivateProcessingLocked: Boolean
     read pm_GetIsActivateProcessingLocked;
 public
 // public properties
   property Scene: TvgCustomScene
     read f_Scene;
   property Background: TvgBackground
     read f_Background;
   property ParentControl: TWinControl
     read f_ParentControl
     write f_ParentControl;
   property RemindersLine: Pointer
     read f_RemindersLine
     write f_RemindersLine;
     {* IvgRemindersLine }
 end;//TvgRemindersLineForm
{$IfEnd} //not NoVGScene

implementation

{$If not defined(NoVGScene)}
uses
  Windows,
  Types,
  vgTypes,
  vtPopupForm,
  SysUtils,
  NewRemindersInterfaces
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts) AND not defined(NoVCM) AND not defined(NoVGScene)}
  ,
  ReminderWordsPack
  {$IfEnd} //not NoScripts AND not NoVCM AND not NoVGScene
  
  ;
{$IfEnd} //not NoVGScene

{$If not defined(NoVGScene)}

// start class TvgRemindersLineForm

procedure TvgRemindersLineForm.LockActivateProcessing;
//#UC START# *54100FBD0074_53319C7502F4_var*
//#UC END# *54100FBD0074_53319C7502F4_var*
begin
//#UC START# *54100FBD0074_53319C7502F4_impl*
 Inc(f_ActivateProcessingLockCount);
//#UC END# *54100FBD0074_53319C7502F4_impl*
end;//TvgRemindersLineForm.LockActivateProcessing

procedure TvgRemindersLineForm.UnlockActivateProcessing;
//#UC START# *54100FD20042_53319C7502F4_var*
//#UC END# *54100FD20042_53319C7502F4_var*
begin
//#UC START# *54100FD20042_53319C7502F4_impl*
 Dec(f_ActivateProcessingLockCount);
//#UC END# *54100FD20042_53319C7502F4_impl*
end;//TvgRemindersLineForm.UnlockActivateProcessing

function TvgRemindersLineForm.pm_GetIsActivateProcessingLocked: Boolean;
//#UC START# *5410102B01CD_53319C7502F4get_var*
//#UC END# *5410102B01CD_53319C7502F4get_var*
begin
//#UC START# *5410102B01CD_53319C7502F4get_impl*
 Result := (f_ActivateProcessingLockCount > 0);
//#UC END# *5410102B01CD_53319C7502F4get_impl*
end;//TvgRemindersLineForm.pm_GetIsActivateProcessingLocked

procedure TvgRemindersLineForm.WMMouseActivate(var Msg: TWMMouseActivate);
//#UC START# *534FDC010298_53319C7502F4_var*
//#UC END# *534FDC010298_53319C7502F4_var*
begin
//#UC START# *534FDC010298_53319C7502F4_impl*
 Msg.Result := MA_NOACTIVATE;
//#UC END# *534FDC010298_53319C7502F4_impl*
end;//TvgRemindersLineForm.WMMouseActivate

procedure TvgRemindersLineForm.WMActivate(var Msg: TWMActivate);
//#UC START# *535E45FB007C_53319C7502F4_var*
 function GetMainForm(aControl: TWinControl): TWinControl;
 begin
  Result := aControl;
  while Assigned(Result.Parent) do
   Result := Result.Parent;
 end;

var
 l_OtherHandle: THandle;
 l_Control: TControl;
 l_MainForm: TWinControl;
//#UC END# *535E45FB007C_53319C7502F4_var*
begin
//#UC START# *535E45FB007C_53319C7502F4_impl*
 l_OtherHandle := Msg.ActiveWindow;
 if (Msg.Active = WA_ACTIVE) or (Msg.Active = WA_CLICKACTIVE) then // медали получили фокус
  if (Scene <> GetCaptureControl) and (not IsActivateProcessingLocked) then
  begin
   l_Control := FindControl(l_OtherHandle);
   if l_Control <> nil then
   begin
    if l_Control.Visible and
      (l_Control is TWinControl) and
      not (GetMainForm(l_Control as TWinControl) is TvtPopupForm) then
     PostMessage(l_OtherHandle, WM_ACTIVATE, WA_ACTIVE, 0) //535903432. Хер его знает, почему по-нормальному не работает
    else
    if ParentControl.Visible then
    begin
     l_MainForm := GetMainForm(ParentControl);
     if (l_MainForm <> nil) and
        l_MainForm.HandleAllocated then
        // - http://mdp.garant.ru/pages/viewpage.action?pageId=587161029
      PostMessage(GetMainForm(ParentControl).Handle, WM_ACTIVATE, WA_ACTIVE, 0); //535903432. Хер его знает, почему по-нормальному не работает
    end;
   end else
    SetActiveWindow(GetMainForm(ParentControl).Handle);
  end;
//#UC END# *535E45FB007C_53319C7502F4_impl*
end;//TvgRemindersLineForm.WMActivate

procedure TvgRemindersLineForm.WMContextMenu(var Msg: TMessage);
//#UC START# *535E4AF101D7_53319C7502F4_var*
//#UC END# *535E4AF101D7_53319C7502F4_var*
begin
//#UC START# *535E4AF101D7_53319C7502F4_impl*
 Msg.Result := 1;
//#UC END# *535E4AF101D7_53319C7502F4_impl*
end;//TvgRemindersLineForm.WMContextMenu

procedure TvgRemindersLineForm.WMSyncPos(var Msg: TMessage);
//#UC START# *535E4B38022D_53319C7502F4_var*
//#UC END# *535E4B38022D_53319C7502F4_var*
begin
//#UC START# *535E4B38022D_53319C7502F4_impl*
 if Assigned(f_RemindersLine) then
  IvgRemindersLine(f_RemindersLine).SyncPosition;
//#UC END# *535E4B38022D_53319C7502F4_impl*
end;//TvgRemindersLineForm.WMSyncPos

procedure TvgRemindersLineForm.CMShowingChanged(var Msg: TMessage);
//#UC START# *54477AC100E5_53319C7502F4_var*
//#UC END# *54477AC100E5_53319C7502F4_var*
begin
//#UC START# *54477AC100E5_53319C7502F4_impl*
 if Showing then
  ShowWindow(Handle, SW_SHOWNOACTIVATE)
 // - незачем все-таки медалям активироваться. Хотя бы когда зовут Show().
 // http://mdp.garant.ru/pages/viewpage.action?pageId=530833653
 // заодно помогает против этого - http://mdp.garant.ru/pages/viewpage.action?pageId=568163184
 else
  inherited;
//#UC END# *54477AC100E5_53319C7502F4_impl*
end;//TvgRemindersLineForm.CMShowingChanged

destructor TvgRemindersLineForm.Destroy;
//#UC START# *48077504027E_53319C7502F4_var*
//#UC END# *48077504027E_53319C7502F4_var*
begin
//#UC START# *48077504027E_53319C7502F4_impl*
 if Assigned(f_RemindersLine) then
  IvgRemindersLine(f_RemindersLine).RemindersLineFormDestroyed;
 f_RemindersLine := nil;
 FreeAndNil(f_Background);
 FreeAndNil(f_Scene);
 inherited;
//#UC END# *48077504027E_53319C7502F4_impl*
end;//TvgRemindersLineForm.Destroy

{$If not defined(NoVCL)}
procedure TvgRemindersLineForm.CreateParams(var Params: TCreateParams);
//#UC START# *48C7925A02E5_53319C7502F4_var*
//#UC END# *48C7925A02E5_53319C7502F4_var*
begin
//#UC START# *48C7925A02E5_53319C7502F4_impl*
 inherited;
 Params.ExStyle := Params.ExStyle and not (WS_EX_APPWINDOW) or WS_EX_TOOLWINDOW or WS_EX_TOPMOST or WS_EX_NOACTIVATE;
//#UC END# *48C7925A02E5_53319C7502F4_impl*
end;//TvgRemindersLineForm.CreateParams
{$IfEnd} //not NoVCL

{$If not defined(NoVCL)}
function TvgRemindersLineForm.CloseQuery: Boolean;
//#UC START# *4980403E021E_53319C7502F4_var*
//#UC END# *4980403E021E_53319C7502F4_var*
begin
//#UC START# *4980403E021E_53319C7502F4_impl*
 Result := False;
//#UC END# *4980403E021E_53319C7502F4_impl*
end;//TvgRemindersLineForm.CloseQuery
{$IfEnd} //not NoVCL

{$If not defined(NoVCL)}
procedure TvgRemindersLineForm.SetBounds(ALeft: Integer;
  ATop: Integer;
  AWidth: Integer;
  AHeight: Integer);
//#UC START# *4F2A599E0283_53319C7502F4_var*
//#UC END# *4F2A599E0283_53319C7502F4_var*
begin
//#UC START# *4F2A599E0283_53319C7502F4_impl*
 if Assigned(f_RemindersLine) then
  IvgRemindersLine(f_RemindersLine).CorrectBounds(ALeft, ATop, AWidth, AHeight);
 inherited SetBounds(ALeft, ATop, AWidth, AHeight);
//#UC END# *4F2A599E0283_53319C7502F4_impl*
end;//TvgRemindersLineForm.SetBounds
{$IfEnd} //not NoVCL

{$If not defined(NoVCL)}
procedure TvgRemindersLineForm.DockDrop(Source: TDragDockObject;
  X: Integer;
  Y: Integer);
//#UC START# *4F8851380274_53319C7502F4_var*
//#UC END# *4F8851380274_53319C7502F4_var*
begin
//#UC START# *4F8851380274_53319C7502F4_impl*
 Assert(Assigned(f_RemindersLine));
 IvgRemindersLine(f_RemindersLine).ControlDropped(Source.Control);
//#UC END# *4F8851380274_53319C7502F4_impl*
end;//TvgRemindersLineForm.DockDrop
{$IfEnd} //not NoVCL

{$If not defined(NoVCL)}
constructor TvgRemindersLineForm.CreateNew(AOwner: TComponent;
  Dummy: Integer = 0);
//#UC START# *4F9007B20376_53319C7502F4_var*
//#UC END# *4F9007B20376_53319C7502F4_var*
begin
//#UC START# *4F9007B20376_53319C7502F4_impl*
 inherited;

 f_ParentControl := nil;
 Visible := False;

 BorderStyle := bsNone;

 f_BackGround := TvgBackGround.Create(Self);
 f_BackGround.Align := vaClient;

 f_Scene := TvgScene.Create(Self);
 with f_Scene do
 begin
  Parent := Self;
  AddObject(f_BackGround);
  Align := alClient;
  Transparency := True;
 end;//with f_Scene
//#UC END# *4F9007B20376_53319C7502F4_impl*
end;//TvgRemindersLineForm.CreateNew
{$IfEnd} //not NoVCL

{$If not defined(NoVCL)}
procedure TvgRemindersLineForm.UpdateActions;
//#UC START# *533AA4B4006B_53319C7502F4_var*
//#UC END# *533AA4B4006B_53319C7502F4_var*
begin
//#UC START# *533AA4B4006B_53319C7502F4_impl*
 inherited;
 if Assigned(f_RemindersLine) then
  IvgRemindersLine(f_RemindersLine).UpdateActions;
//#UC END# *533AA4B4006B_53319C7502F4_impl*
end;//TvgRemindersLineForm.UpdateActions
{$IfEnd} //not NoVCL

{$IfEnd} //not NoVGScene

initialization
{$If not defined(NoScripts) AND not defined(NoVGScene)}
// Регистрация TvgRemindersLineForm
 TtfwClassRef.Register(TvgRemindersLineForm);
{$IfEnd} //not NoScripts AND not NoVGScene

end.