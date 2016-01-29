unit PrimShutDown_Form;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/PrimCommon/Forms/PrimShutDown_Form.pas"
// Начат: 21.08.2009 21:18
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMForm::Class>> F1 Базовые определения предметной области::F1 Application Template::View::PrimCommon::PrimShutDown
//
// Предупреждение
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
  l3Interfaces,
  Classes
  {$If not defined(NoVCL)}
  ,
  Forms
  {$IfEnd} //not NoVCL
  
  {$If not defined(NoVCL)}
  ,
  ExtCtrls
  {$IfEnd} //not NoVCL
  
  {$If not defined(NoVCM)}
  ,
  vcmEntityForm
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmUserControls
  {$IfEnd} //not NoVCM
  ,
  vtPanel,
  F1_Application_Template_InternalOperations_Controls,
  vtLabel,
  l3StringIDEx
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  ,
  vtButton,
  PrimShutDown_sftNone_UserType,
  Windows,
  vcmExternalInterfaces {a},
  vcmInterfaces {a}
  ;

type
 TPrimShutDownForm = {form} class(TvcmEntityForm, Il3WndProcRetListener, Il3Listener)
  {* Предупреждение }
 private
 // private fields
   f_ShutdownTimer : TTimer;
    {* Поле для свойства ShutdownTimer}
   f_vtPanel1 : TvtPanel;
    {* Поле для свойства vtPanel1}
   f_LeftPanel : TvtPanel;
    {* Поле для свойства LeftPanel}
   f_Image : TImage;
    {* Поле для свойства Image}
   f_CenterPanel : TvtPanel;
    {* Поле для свойства CenterPanel}
   f_TopSpacerPanel : TvtPanel;
    {* Поле для свойства TopSpacerPanel}
   f_WarningText : TvtLabel;
    {* Поле для свойства WarningText}
   f_RightSpacerPanel : TvtPanel;
    {* Поле для свойства RightSpacerPanel}
   f_pnlBottom : TvtPanel;
    {* Поле для свойства pnlBottom}
   f_CloseButton : TvtButton;
    {* Поле для свойства CloseButton}
 protected
  procedure InitEntities; override;
  procedure MakeControls; override;
 private
 // private methods
   procedure ShutdownTimerTimer(Sender: TObject);
     {* TNotifyEvent is used for events that do not require parameters. }
   procedure CloseButtonClick(Sender: TObject);
     {* TNotifyEvent is used for events that do not require parameters. }
   procedure VcmEntityFormCloseQuery(Sender: TObject;
     var CanClose: Boolean);
   procedure UpdateCloseButton;
     {* Сигнатура метода UpdateCloseButton }
   procedure ShutdownAll;
     {* Сигнатура метода ShutdownAll }
   procedure UpdateSize;
     {* Сигнатура метода UpdateSize }
 protected
 // realized methods
   procedure System_InitShutdown_Execute(aShotdown: Boolean;
    aCloseInterval: Integer);
     {* Начать процесс завершения работы }
   procedure System_InitShutdown(const aParams: IvcmExecuteParams);
     {* Начать процесс завершения работы }
   procedure WndProcRetListenerNotify(Msg: PCWPRetStruct;
     var theResult: Tl3HookProcResult);
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
   procedure InitFields; override;
   {$If not defined(NoVCM)}
   procedure InitControls; override;
     {* Процедура инициализации контролов. Для перекрытия в потомках }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCL)}
   procedure DoShow; override;
   {$IfEnd} //not NoVCL
    {$If not defined(NoVCM)}
   procedure SetupFormLayout; override;
     {* Тут можно настроить внешний вид формы }
    {$IfEnd} //not NoVCM
    {$If not defined(NoVCL)}
   procedure DoClose(var Action: TCloseAction); override;
    {$IfEnd} //not NoVCL
 protected
 // protected fields
   f_InShutdown : Boolean;
   f_CloseInterval : Integer;
   f_CloseCaption : AnsiString;
 public
 // public properties
   property ShutdownTimer: TTimer
     read f_ShutdownTimer;
   property vtPanel1: TvtPanel
     read f_vtPanel1;
   property LeftPanel: TvtPanel
     read f_LeftPanel;
   property Image: TImage
     read f_Image;
   property CenterPanel: TvtPanel
     read f_CenterPanel;
   property TopSpacerPanel: TvtPanel
     read f_TopSpacerPanel;
   property WarningText: TvtLabel
     read f_WarningText;
   property RightSpacerPanel: TvtPanel
     read f_RightSpacerPanel;
   property pnlBottom: TvtPanel
     read f_pnlBottom;
   property CloseButton: TvtButton
     read f_CloseButton;
     {* Выход }
 end;//TPrimShutDownForm

 TvcmEntityFormRef = TPrimShutDownForm;

implementation

uses
  SysUtils
  {$If not defined(NoVCM)}
  ,
  vcmBase
  {$IfEnd} //not NoVCM
  ,
  l3Base,
  DataAdapter,
  l3InternalInterfaces,
  l3String,
  l3MinMax,
  l3ScreenIC
  {$If not defined(NoVCL)}
  ,
  Controls
  {$IfEnd} //not NoVCL
  
  {$If not defined(NoVCL)}
  ,
  StdCtrls
  {$IfEnd} //not NoVCL
  ,
  f1NotificationManager,
  Messages,
  l3ListenersManager,
  l3MessageID
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  ,
  StdRes {a}
  ;

var
   { Локализуемые строки sftNoneLocalConstants }
  str_sftNoneCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'sftNoneCaption'; rValue : 'Предупреждение о закрытии приложения');
   { Заголовок пользовательского типа "Предупреждение о закрытии приложения" }

// start class TPrimShutDownForm

procedure TPrimShutDownForm.ShutdownTimerTimer(Sender: TObject);
//#UC START# *5267AF7901AC_4A8EC8AC02EE_var*
//#UC END# *5267AF7901AC_4A8EC8AC02EE_var*
begin
//#UC START# *5267AF7901AC_4A8EC8AC02EE_impl*
 Dec(f_CloseInterval);
 UpdateCloseButton;
 if f_CloseInterval <= 0 then
  ShutdownAll;
//#UC END# *5267AF7901AC_4A8EC8AC02EE_impl*
end;//TPrimShutDownForm.ShutdownTimerTimer

procedure TPrimShutDownForm.CloseButtonClick(Sender: TObject);
//#UC START# *5267AF870367_4A8EC8AC02EE_var*
//#UC END# *5267AF870367_4A8EC8AC02EE_var*
begin
//#UC START# *5267AF870367_4A8EC8AC02EE_impl*
 ShutdownAll;
//#UC END# *5267AF870367_4A8EC8AC02EE_impl*
end;//TPrimShutDownForm.CloseButtonClick

procedure TPrimShutDownForm.VcmEntityFormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
//#UC START# *5267AF9600C5_4A8EC8AC02EE_var*
//#UC END# *5267AF9600C5_4A8EC8AC02EE_var*
begin
//#UC START# *5267AF9600C5_4A8EC8AC02EE_impl*
 CanClose := not f_InShutdown;
//#UC END# *5267AF9600C5_4A8EC8AC02EE_impl*
end;//TPrimShutDownForm.VcmEntityFormCloseQuery

procedure TPrimShutDownForm.UpdateCloseButton;
//#UC START# *5267AFA601F6_4A8EC8AC02EE_var*
var
 l_Str: string;
//#UC END# *5267AFA601F6_4A8EC8AC02EE_var*
begin
//#UC START# *5267AFA601F6_4A8EC8AC02EE_impl*
 l_Str := f_CloseCaption;
 if f_CloseInterval > 0 then
  l_Str := l_Str + ' (' + IntToStr(f_CloseInterval) + ')'
 else
  SafeClose;
 CloseButton.Caption := l_Str;
//#UC END# *5267AFA601F6_4A8EC8AC02EE_impl*
end;//TPrimShutDownForm.UpdateCloseButton

procedure TPrimShutDownForm.ShutdownAll;
//#UC START# *5267AFB4031F_4A8EC8AC02EE_var*
//#UC END# *5267AFB4031F_4A8EC8AC02EE_var*
begin
//#UC START# *5267AFB4031F_4A8EC8AC02EE_impl*
 f_InShutdown := False;
 {$IFDEF Monitorings}
 Tf1NotificationManager.Instance.ServerDown;
 {$ENDIF Monitorings}
 {$IfNDef nsWithoutLogin}
 if defDataAdapter.Authorization.IsServerAlive then
 {$EndIf  nsWithoutLogin}
  g_Dispatcher.CloseAllWindows;
 try
  try
   g_ShowFinalSplash := False;
   GlobalCrashCleanup;
  finally
   GlobalDone;
  end;
 finally
  TerminateProcess(GetCurrentProcess, 255);
 end;
//#UC END# *5267AFB4031F_4A8EC8AC02EE_impl*
end;//TPrimShutDownForm.ShutdownAll

procedure TPrimShutDownForm.UpdateSize;
//#UC START# *5267AFC1022B_4A8EC8AC02EE_var*
var
 l_Rect: TRect;
 l_Canvas: Il3InfoCanvas;
//#UC END# *5267AFC1022B_4A8EC8AC02EE_var*
begin
//#UC START# *5267AFC1022B_4A8EC8AC02EE_impl*
 //http://mdp.garant.ru/pages/viewpage.action?pageId=494529735
 RightSpacerPanel.Width := ClientWidth - (CloseButton.Left + CloseButton.Width);
 l3FillChar(l_Rect, SizeOf(l_Rect), 0);
 l_Rect.Right := WarningText.Width;
 l_Canvas := l3CrtIC;
 try
  l_Canvas.Font.AssignFont(WarningText.Font);
  l_Canvas.DrawText(l3PCharLen(WarningText.CCaption), l_Rect, DT_WORDBREAK or DT_CALCRECT);
  WarningText.Height := l_Rect.Bottom - l_Rect.Top;
  ClientHeight := Max(Image.Top + Image.Height, TopSpacerPanel.Height + l_Rect.Bottom) + pnlBottom.Height;
 finally
  l_Canvas := nil;
 end;
//#UC END# *5267AFC1022B_4A8EC8AC02EE_impl*
end;//TPrimShutDownForm.UpdateSize

procedure TPrimShutDownForm.System_InitShutdown_Execute(aShotdown: Boolean;
  aCloseInterval: Integer);
//#UC START# *4A8EC9E902CD_4A8EC8AC02EEexec_var*
//#UC END# *4A8EC9E902CD_4A8EC8AC02EEexec_var*
begin
//#UC START# *4A8EC9E902CD_4A8EC8AC02EEexec_impl*
 f_InShutdown := True;
 f_CloseInterval := aCloseInterval;
 if aShotdown then
  WarningText.CCaption := vcmFmt(str_ShotdownWarning, [f_CloseInterval])
 else
  WarningText.CCaption := vcmFmt(str_LogoutWarning, [f_CloseInterval]);
 UpdateSize;
 UpdateCloseButton;
 ShutDownTimer.Enabled := True;
//#UC END# *4A8EC9E902CD_4A8EC8AC02EEexec_impl*
end;//TPrimShutDownForm.System_InitShutdown_Execute

procedure TPrimShutDownForm.System_InitShutdown(const aParams: IvcmExecuteParams);
begin
 with (aParams.Data As ISystem_InitShutdown_Params) do
  System_InitShutdown_Execute(Shotdown, CloseInterval);
end;

procedure TPrimShutDownForm.WndProcRetListenerNotify(Msg: PCWPRetStruct;
  var theResult: Tl3HookProcResult);
//#UC START# *4F79CF9200A0_4A8EC8AC02EE_var*
//#UC END# *4F79CF9200A0_4A8EC8AC02EE_var*
begin
//#UC START# *4F79CF9200A0_4A8EC8AC02EE_impl*
 if (Msg.Message = WM_SIZE) and (Msg.wParam = SIZE_RESTORED) then
 // в принципе, плевать, на какое окно реагировать
  SetWindowPos(Handle, HWND_TOP, 0, 0, 0, 0, SWP_SHOWWINDOW + SWP_NOMOVE + SWP_NOSIZE + SWP_NOACTIVATE);
//#UC END# *4F79CF9200A0_4A8EC8AC02EE_impl*
end;//TPrimShutDownForm.WndProcRetListenerNotify

procedure TPrimShutDownForm.Cleanup;
//#UC START# *479731C50290_4A8EC8AC02EE_var*
//#UC END# *479731C50290_4A8EC8AC02EE_var*
begin
//#UC START# *479731C50290_4A8EC8AC02EE_impl*
 Tl3ListenersManager.Remove(Self);
 inherited;
//#UC END# *479731C50290_4A8EC8AC02EE_impl*
end;//TPrimShutDownForm.Cleanup

procedure TPrimShutDownForm.InitFields;
//#UC START# *47A042E100E2_4A8EC8AC02EE_var*
//#UC END# *47A042E100E2_4A8EC8AC02EE_var*
begin
//#UC START# *47A042E100E2_4A8EC8AC02EE_impl*
 inherited;
 f_CloseCaption := CloseButton.Caption;
 Image.Picture.Icon.Handle := LoadIcon(0, IDI_EXCLAMATION);
 f_InShutdown := False;

 ActiveControl := CloseButton;
//#UC END# *47A042E100E2_4A8EC8AC02EE_impl*
end;//TPrimShutDownForm.InitFields

{$If not defined(NoVCM)}
procedure TPrimShutDownForm.InitControls;
//#UC START# *4A8E8F2E0195_4A8EC8AC02EE_var*
//#UC END# *4A8E8F2E0195_4A8EC8AC02EE_var*
begin
//#UC START# *4A8E8F2E0195_4A8EC8AC02EE_impl*
 inherited;
 with vtPanel1 do
 begin
  Align := alClient;
  BevelOuter := bvNone;
  TabOrder := 0;
 end;
  with LeftPanel do
  begin
   Width := 65;
   Align := alLeft;
   BevelOuter := bvNone;
   TabOrder := 0;
  end;
   with Image do
   begin
    Left := 15;
    Top := 11;
    Width := 32;
    Height := 32;
   end;
  with RightSpacerPanel do
  begin
   Width := 11;
   Align := alRight;
   BevelOuter := bvNone;
   TabOrder := 1;
  end;
  with CenterPanel do
  begin
   Align := alClient;
   BevelOuter := bvNone;
   TabOrder := 2;
  end;
   with TopSpacerPanel do
   begin
    Height := 11;
    Align := alTop;
    BevelOuter := bvNone;
   end;
   with WarningText do
   begin
    Align := alClient;
    Layout := tlCenter;
    WordWrap := True;
    Font.Size := 9;
   end;
 with pnlBottom do
 begin
  Height := 40;
  Align := alBottom;
  BevelOuter := bvNone;
  TabOrder := 1;
 end;
  with CloseButton do
  begin
   Left := 353;
   Top := 5;
   Width := 75;
   Height := 25;
   ModalResult := 1;
   TabOrder := 0;
   OnClick := CloseButtonClick;
  end;
 with ShutdownTimer do
 begin
  Enabled := False;
  OnTimer := ShutdownTimerTimer;
 end;
//#UC END# *4A8E8F2E0195_4A8EC8AC02EE_impl*
end;//TPrimShutDownForm.InitControls
{$IfEnd} //not NoVCM

{$If not defined(NoVCL)}
procedure TPrimShutDownForm.DoShow;
//#UC START# *4B321D1301DD_4A8EC8AC02EE_var*
//#UC END# *4B321D1301DD_4A8EC8AC02EE_var*
begin
//#UC START# *4B321D1301DD_4A8EC8AC02EE_impl*
 inherited;
 SetForegroundWindow(Handle);
 Tl3ListenersManager.Add(Self);
//#UC END# *4B321D1301DD_4A8EC8AC02EE_impl*
end;//TPrimShutDownForm.DoShow
{$IfEnd} //not NoVCL

{$If not defined(NoVCM)}
procedure TPrimShutDownForm.SetupFormLayout;
//#UC START# *529332B40230_4A8EC8AC02EE_var*
//#UC END# *529332B40230_4A8EC8AC02EE_var*
begin
//#UC START# *529332B40230_4A8EC8AC02EE_impl*
 inherited;
 FormStyle := fsStayOnTop;
 BorderIcons := [biMinimize, biMaximize];
 BorderStyle := bsSingle;
 ClientHeight := 89;
 ClientWidth := 437;
 OnCloseQuery := vcmEntityFormCloseQuery;
//#UC END# *529332B40230_4A8EC8AC02EE_impl*
end;//TPrimShutDownForm.SetupFormLayout
{$IfEnd} //not NoVCM

{$If not defined(NoVCL)}
procedure TPrimShutDownForm.DoClose(var Action: TCloseAction);
//#UC START# *5576E05C0204_4A8EC8AC02EE_var*
//#UC END# *5576E05C0204_4A8EC8AC02EE_var*
begin
//#UC START# *5576E05C0204_4A8EC8AC02EE_impl*
 Tl3ListenersManager.Remove(Self);
 inherited;
//#UC END# *5576E05C0204_4A8EC8AC02EE_impl*
end;//TPrimShutDownForm.DoClose
{$IfEnd} //not NoVCL

procedure TPrimShutDownForm.InitEntities;
begin
 inherited;
 with Entities.Entities do
 begin
  PublishFormEntity(en_System, nil);
  PublishOpWithResult(en_System, op_InitShutdown, System_InitShutdown, nil, nil);
 end;//with Entities.Entities
end;

procedure TPrimShutDownForm.MakeControls;
begin
 inherited;
 f_ShutdownTimer := TTimer.Create(Self);
 f_ShutdownTimer.Name := 'ShutdownTimer';
 with AddUsertype(sftNoneName,
  str_sftNoneCaption,
  str_sftNoneCaption,
  true,
  -1,
  -1,
  '',
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(sftNoneName
 f_vtPanel1 := TvtPanel.Create(Self);
 f_vtPanel1.Name := 'vtPanel1';
 f_vtPanel1.Parent := Self;
 f_LeftPanel := TvtPanel.Create(Self);
 f_LeftPanel.Name := 'LeftPanel';
 f_LeftPanel.Parent := vtPanel1;
 f_Image := TImage.Create(Self);
 f_Image.Name := 'Image';
 f_Image.Parent := LeftPanel;
 f_CenterPanel := TvtPanel.Create(Self);
 f_CenterPanel.Name := 'CenterPanel';
 f_CenterPanel.Parent := vtPanel1;
 f_TopSpacerPanel := TvtPanel.Create(Self);
 f_TopSpacerPanel.Name := 'TopSpacerPanel';
 f_TopSpacerPanel.Parent := CenterPanel;
 f_WarningText := TvtLabel.Create(Self);
 f_WarningText.Name := 'WarningText';
 f_WarningText.Parent := CenterPanel;
 f_RightSpacerPanel := TvtPanel.Create(Self);
 f_RightSpacerPanel.Name := 'RightSpacerPanel';
 f_RightSpacerPanel.Parent := vtPanel1;
 f_pnlBottom := TvtPanel.Create(Self);
 f_pnlBottom.Name := 'pnlBottom';
 f_pnlBottom.Parent := Self;
 f_CloseButton := TvtButton.Create(Self);
 f_CloseButton.Name := 'CloseButton';
 f_CloseButton.Parent := pnlBottom;
 f_CloseButton.Caption := 'Выход';
end;

initialization
// Инициализация str_sftNoneCaption
 str_sftNoneCaption.Init;
{$If not defined(NoScripts)}
// Регистрация PrimShutDown
 TtfwClassRef.Register(TPrimShutDownForm);
{$IfEnd} //not NoScripts

end.