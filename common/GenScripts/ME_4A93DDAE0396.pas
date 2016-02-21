unit PrimLongProcess_Form;
 {* Информация }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\PrimCommon\Forms\PrimLongProcess_Form.pas"
// Стереотип: "VCMForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmEntityForm
 {$IfEnd} // NOT Defined(NoVCM)
 , vtPanel
 , vtLabel
 , vtGradientWaitbar
 {$If NOT Defined(NoVCL)}
 , ExtCtrls
 {$IfEnd} // NOT Defined(NoVCL)
 , vtButton
 , Messages
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 , l3Interfaces
 , nsTypes
;

type
 TnsLongProcessData = object
  public
   rMessage: Il3CString;
   rMessageType: TnsLongProcessType;
   rIconName: PAnsiChar;
 end;//TnsLongProcessData

 TPrimLongProcessForm = class(TvcmEntityForm)
  {* Информация }
  private
   f_InLongProcess: Boolean;
   f_ClientPanel: TvtPanel;
    {* Поле для свойства ClientPanel }
   f_MessageLabel: TvtLabel;
    {* Поле для свойства MessageLabel }
   f_BottomPanel: TvtPanel;
    {* Поле для свойства BottomPanel }
   f_ProgressBar: TvtGradientWaitbar;
    {* Поле для свойства ProgressBar }
   f_LeftPanel: TvtPanel;
    {* Поле для свойства LeftPanel }
   f_Image: TImage;
    {* Поле для свойства Image }
   f_ButtonPanel: TvtPanel;
    {* Поле для свойства ButtonPanel }
   f_btnExit: TvtButton;
    {* Поле для свойства btnExit }
  protected
   f_Data: TnsLongProcessData;
  private
   procedure Prepare;
    {* подготовка формы к открытию на основе данных f_Data }
   procedure btnExitClick(Sender: TObject);
   procedure vcmEntityFormCloseQuery(Sender: TObject;
    var CanClose: Boolean);
   procedure WMSysCommand(var Message: TWMSysCommand);
  protected
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   {$If NOT Defined(NoVCL)}
   procedure CreateParams(var Params: TCreateParams); override;
   {$IfEnd} // NOT Defined(NoVCL)
   {$If NOT Defined(NoVCM)}
   procedure InitControls; override;
    {* Процедура инициализации контролов. Для перекрытия в потомках }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   function HasFormFloatingZoneTypeAndVisible: Boolean; override;
   {$IfEnd} // NOT Defined(NoVCM)
  public
   constructor Create(const aData: TnsLongProcessData); reintroduce;
   class function Make(const aData: TnsLongProcessData): BadFactoryType; reintroduce;
   {$If NOT Defined(NoVCL)}
   function ShowModal: Integer; override;
   {$IfEnd} // NOT Defined(NoVCL)
  public
   property ClientPanel: TvtPanel
    read f_ClientPanel;
   property BottomPanel: TvtPanel
    read f_BottomPanel;
   property LeftPanel: TvtPanel
    read f_LeftPanel;
   property ButtonPanel: TvtPanel
    read f_ButtonPanel;
 end;//TPrimLongProcessForm

function TnsLongProcessData_C(const aMessage: Il3CString;
 aMessageType: TnsLongProcessType;
 anIconName: PAnsiChar): TnsLongProcessData;

implementation

uses
 l3ImplUses
 , Windows
 , l3String
 , l3AsincMessageWindowRes
 , DataAdapter
 , afwFacade
 , Graphics
 {$If NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)}
 , vcmTabbedContainerFormDispatcher
 {$IfEnd} // NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

function TnsLongProcessData_C(const aMessage: Il3CString;
 aMessageType: TnsLongProcessType;
 anIconName: PAnsiChar): TnsLongProcessData;
//#UC START# *4B17B6FA024F_498C7D4301A5_var*
//#UC END# *4B17B6FA024F_498C7D4301A5_var*
begin
 Finalize(Result);
 System.FillChar(Result, SizeOf(Result), 0);
//#UC START# *4B17B6FA024F_498C7D4301A5_impl*
 Result.rMessage := aMessage;
 Result.rMessageType := aMessageType;
 Result.rIconName := anIconName;
//#UC END# *4B17B6FA024F_498C7D4301A5_impl*
end;//TnsLongProcessData_C

procedure TPrimLongProcessForm.Prepare;
 {* подготовка формы к открытию на основе данных f_Data }
//#UC START# *523ABFDC0014_4A93DDAE0396_var*
//#UC END# *523ABFDC0014_4A93DDAE0396_var*
begin
//#UC START# *523ABFDC0014_4A93DDAE0396_impl*
 //if f_Data <> nil then
 begin
  Image.Picture.Icon.Handle := LoadIconA(0, f_Data.rIconName);
  // в дальнейшем нужно икону как-то получать от главной формы
  ProgressBar.Active := True;
  FormStyle := fsNormal;
  f_InLongProcess := True;
  case f_Data.rMessageType of
   lptUpdate:
    begin
     CCaption := vcmCStr(str_lpUpdateCaption);
     MessageLabel.CCaption := l3Cat([vcmCStr(str_lpUpdateMessage), vcmCStr(str_lpExitMessage)]);
    end;
   lptProcessWithExit,
   lptProcessWithoutExit:
    begin
     if not l3IsNil(f_Data.rMessage) then
      MessageLabel.CCaption := l3Cat([f_Data.rMessage, vcmCStr(str_lpWaitMessage)])
     else
      MessageLabel.CCaption := l3Cat([str_l3mmLongOperation.AsCStr, vcmCStr(str_lpWaitMessage)]);
     if f_Data.rMessageType = lptProcessWithoutExit then
     begin
      ButtonPanel.Visible := False;
      Height := Height - ButtonPanel.Height;
     end
     else
      MessageLabel.CCaption := l3Cat([MessageLabel.CCaption, vcmCStr(str_lpExitMessage)]);
    end;
   else
    MessageLabel.CCaption := vcmCStr(str_lpWaitMessage);
  end;
 end;
//#UC END# *523ABFDC0014_4A93DDAE0396_impl*
end;//TPrimLongProcessForm.Prepare

constructor TPrimLongProcessForm.Create(const aData: TnsLongProcessData);
//#UC START# *523AC0C700E6_4A93DDAE0396_var*
//#UC END# *523AC0C700E6_4A93DDAE0396_var*
begin
//#UC START# *523AC0C700E6_4A93DDAE0396_impl*
 inherited Create(nil);
 f_Data := aData;
 Prepare;
//#UC END# *523AC0C700E6_4A93DDAE0396_impl*
end;//TPrimLongProcessForm.Create

procedure TPrimLongProcessForm.btnExitClick(Sender: TObject);
//#UC START# *523AC9A902C2_4A93DDAE0396_var*
//#UC END# *523AC9A902C2_4A93DDAE0396_var*
begin
//#UC START# *523AC9A902C2_4A93DDAE0396_impl*
 {$IfNDef nsWithoutLogin}
 if defDataAdapter.Authorization.IsServerAlive then
 {$EndIf nsWithoutLogin}
 begin
  Hide; // прячем текущую форму
  afw.ProcessMessages; // делаем так, чтобы форма спряталась, т.к. после этого мы уже не попадем в состояние Idle

  {$If not defined(NoTabs)}
  if TvcmTabbedContainerFormDispatcher.Instance.NeedUseTabs then
   TvcmTabbedContainerFormDispatcher.Instance.CloseAll
  else
  {$IfEnd}
   if Assigned(g_Dispatcher) then
    with g_Dispatcher do
    begin
     BeginCancelModal;
     try
      CloseAllWindows;
     finally
      EndCancelModal;
     end;
    end;
 end;//defDataAdapter.Authorization.IsServerAlive

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
//#UC END# *523AC9A902C2_4A93DDAE0396_impl*
end;//TPrimLongProcessForm.btnExitClick

procedure TPrimLongProcessForm.vcmEntityFormCloseQuery(Sender: TObject;
 var CanClose: Boolean);
//#UC START# *523ADA5A023D_4A93DDAE0396_var*
//#UC END# *523ADA5A023D_4A93DDAE0396_var*
begin
//#UC START# *523ADA5A023D_4A93DDAE0396_impl*
 {$IfDef l3HackedVCL}
 if f_InLongProcess 
    and
    NeedCancelModal then
  f_InLongProcess := false;
 {$EndIf l3HackedVCL} 

 if f_InLongProcess then
  CanClose := false;
//#UC END# *523ADA5A023D_4A93DDAE0396_impl*
end;//TPrimLongProcessForm.vcmEntityFormCloseQuery

class function TPrimLongProcessForm.Make(const aData: TnsLongProcessData): BadFactoryType;
var
 l_Inst : TPrimLongProcessForm;
begin
 l_Inst := Create(aData);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TPrimLongProcessForm.Make

procedure TPrimLongProcessForm.WMSysCommand(var Message: TWMSysCommand);
//#UC START# *523AC0AA0039_4A93DDAE0396_var*
//#UC END# *523AC0AA0039_4A93DDAE0396_var*
begin
//#UC START# *523AC0AA0039_4A93DDAE0396_impl*
 if not (csDesigning in ComponentState) then
 begin
  with Message do begin
   if (CmdType and $FFF0 = SC_MINIMIZE) then
    DefaultHandler(Message)
   else
    inherited;
  end;//with Message
 end
 else
  inherited;
//#UC END# *523AC0AA0039_4A93DDAE0396_impl*
end;//TPrimLongProcessForm.WMSysCommand

procedure TPrimLongProcessForm.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4A93DDAE0396_var*
//#UC END# *479731C50290_4A93DDAE0396_var*
begin
//#UC START# *479731C50290_4A93DDAE0396_impl*
 Finalize(f_Data);
 inherited;
//#UC END# *479731C50290_4A93DDAE0396_impl*
end;//TPrimLongProcessForm.Cleanup

{$If NOT Defined(NoVCL)}
procedure TPrimLongProcessForm.CreateParams(var Params: TCreateParams);
//#UC START# *48C7925A02E5_4A93DDAE0396_var*
var
 l_ExtendedStyle: Integer;
//#UC END# *48C7925A02E5_4A93DDAE0396_var*
begin
//#UC START# *48C7925A02E5_4A93DDAE0396_impl*
 inherited;
 if not (csDesigning in ComponentState) then
 begin
  with Params do
  begin
   ExStyle := ExStyle or WS_EX_APPWINDOW;
   WndParent := GetDesktopWindow;
  end;
  l_ExtendedStyle := GetWindowLong(Application.Handle, GWL_EXSTYLE);
  SetWindowLong(Application.Handle,
                GWL_EXSTYLE,
                l_ExtendedStyle or WS_EX_TOOLWINDOW {AND NOT WS_EX_APPWINDOW}); 
 end;
//#UC END# *48C7925A02E5_4A93DDAE0396_impl*
end;//TPrimLongProcessForm.CreateParams
{$IfEnd} // NOT Defined(NoVCL)

{$If NOT Defined(NoVCM)}
procedure TPrimLongProcessForm.InitControls;
 {* Процедура инициализации контролов. Для перекрытия в потомках }
//#UC START# *4A8E8F2E0195_4A93DDAE0396_var*
//#UC END# *4A8E8F2E0195_4A93DDAE0396_var*
begin
//#UC START# *4A8E8F2E0195_4A93DDAE0396_impl*
 BorderIcons := [];
 BorderStyle := bsDialog;
 ClientHeight := 143;
 ClientWidth := 362;
 Position := poScreenCenter;
 OnCloseQuery := vcmEntityFormCloseQuery;

 with ClientPanel do
 begin
  Align := alClient;
  BevelOuter := bvNone;
  BorderWidth := 4;
  TabOrder := 0;
 end;

 with MessageLabel do
 begin
  Align := alClient;
  WordWrap := True;
 end;

 with BottomPanel do
 begin
  Height := 26;
  Align := alBottom;
  BevelInner := bvLowered;
  BevelOuter := bvNone;
  TabOrder := 1;
 end;

 with ProgressBar do
 begin
  Left := 2;
  Top := 2;
  Width := 358;
  Height := 22;
  Active := False;
  Color1 := clSkyBlue;
  Color2 := clBlue;
  Anchors := [akLeft, akTop, akRight, akBottom];
 end;

 with LeftPanel do
 begin
  Width := 49;
  Align := alLeft;
  BevelOuter := bvNone;
  TabOrder := 2;
 end;

 with Image do
 begin
  Left := 8;
  Top := 8;
  Width := 32;
  Height := 32;
 end;

 with ButtonPanel do
 begin
  Height := 30;
  Align := alBottom;
  BevelOuter := bvNone;
  TabOrder := 3;
  Top := BottomPanel.Top - 1; // ButtonPanel должна быть выше BottomPanel
 end;

 with btnExit do
 begin
  Left := 280;
  Top := 1;
  Width := 75;
  Height := 25;
  //Anchors := [akRight, akBottom];
  TabOrder := 0;
  OnClick := btnExitClick;
 end;
//#UC END# *4A8E8F2E0195_4A93DDAE0396_impl*
end;//TPrimLongProcessForm.InitControls
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCL)}
function TPrimLongProcessForm.ShowModal: Integer;
//#UC START# *520B42AF0115_4A93DDAE0396_var*
//#UC END# *520B42AF0115_4A93DDAE0396_var*
begin
//#UC START# *520B42AF0115_4A93DDAE0396_impl*
 {$IfDef InsiderTest}
 Inc(Self.g_AllowModal);
 try
 {$EndIf InsiderTest}
  Result := inherited ShowModal;
 {$IfDef InsiderTest}
 finally
  Dec(Self.g_AllowModal);
 end;//try..finally
 {$EndIf InsiderTest}
//#UC END# *520B42AF0115_4A93DDAE0396_impl*
end;//TPrimLongProcessForm.ShowModal
{$IfEnd} // NOT Defined(NoVCL)

{$If NOT Defined(NoVCM)}
function TPrimLongProcessForm.HasFormFloatingZoneTypeAndVisible: Boolean;
//#UC START# *523AC062006F_4A93DDAE0396_var*
//#UC END# *523AC062006F_4A93DDAE0396_var*
begin
//#UC START# *523AC062006F_4A93DDAE0396_impl*
 Result := False;
//#UC END# *523AC062006F_4A93DDAE0396_impl*
end;//TPrimLongProcessForm.HasFormFloatingZoneTypeAndVisible
{$IfEnd} // NOT Defined(NoVCM)

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimLongProcessForm);
 {* Регистрация PrimLongProcess }
{$IfEnd} // NOT Defined(NoScripts)

end.
