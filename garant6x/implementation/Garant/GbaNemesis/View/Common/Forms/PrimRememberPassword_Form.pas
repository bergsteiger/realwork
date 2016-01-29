unit PrimRememberPassword_Form;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Common/Forms/PrimRememberPassword_Form.pas"
// Начат: 25.08.2009 17:51
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMForm::Class>> F1 Core::Common::View::Common::PrimRememberPassword
//
// Забыли пароль?
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  l3Interfaces,
  Classes
  {$If not defined(NoVCL)}
  ,
  Controls
  {$IfEnd} //not NoVCL
  
  {$If not defined(NoVCL)}
  ,
  Forms
  {$IfEnd} //not NoVCL
  
  {$If not defined(NoVCM)}
  ,
  vcmEntityForm
  {$IfEnd} //not NoVCM
  
  {$If defined(Nemesis)}
  ,
  nscComboBox
  {$IfEnd} //Nemesis
  ,
  vtLabel,
  ElPopBtn,
  vcmExternalInterfaces {a},
  vcmInterfaces {a},
  vcmBase {a}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TnsSendAction = function (aSender: TCustomForm): TModalResult of object;

 TPrimRememberPasswordForm = {form} class(TvcmEntityForm)
  {* Забыли пароль? }
 private
 // private fields
   f_EMailLabel : TvtLabel;
    {* Поле для свойства EMailLabel}
   f_HintLabel : TvtLabel;
    {* Поле для свойства HintLabel}
   f_btnCancel : TElPopupButton;
    {* Поле для свойства btnCancel}
   f_btnSend : TElPopupButton;
    {* Поле для свойства btnSend}
   f_edEmail : TnscEdit;
    {* Поле для свойства edEmail}
   f_SendAction : TnsSendAction;
    {* Поле для свойства SendAction}
 protected
  procedure MakeControls; override;
 private
 // private methods
   procedure EMailEditChange(Sender: TObject);
     {* TNotifyEvent is used for events that do not require parameters. }
   procedure BtnSendClick(Sender: TObject);
     {* TNotifyEvent is used for events that do not require parameters. }
   procedure DoSend;
     {* Сигнатура метода DoSend }
 protected
 // property methods
   function pm_GetEMail: Il3CString;
 protected
 // overridden protected methods
   procedure InitFields; override;
   {$If not defined(NoVCL)}
   procedure CreateParams(var Params: TCreateParams); override;
   {$IfEnd} //not NoVCL
   {$If not defined(NoVCM)}
   procedure InitControls; override;
     {* Процедура инициализации контролов. Для перекрытия в потомках }
   {$IfEnd} //not NoVCM
 public
 // overridden public methods
   {$If not defined(NoVCL)}
   function IsRealInstance: Boolean; override;
   {$IfEnd} //not NoVCL
 public
 // public methods
   class function Make(
    const aParams : IvcmMakeParams = nil;
    aZoneType     : TvcmZoneType = vcm_ztAny;
    aUserType     : TvcmEffectiveUserType = 0;
    aDataSource   : IvcmFormDataSource = nil): IvcmEntityForm; reintroduce;
 public
 // public properties
   property EMailLabel: TvtLabel
     read f_EMailLabel;
     {* *Электронная почта: }
   property HintLabel: TvtLabel
     read f_HintLabel;
     {* *Адрес электронной почты, указанный при регистрации. На этот адрес будет выслано письмо, содержащее Ваши регистрационное имя и пароль. }
   property btnCancel: TElPopupButton
     read f_btnCancel;
     {* Отмена }
   property btnSend: TElPopupButton
     read f_btnSend;
     {* Отправить запрос }
   property edEmail: TnscEdit
     read f_edEmail;
   property EMail: Il3CString
     read pm_GetEMail;
   property SendAction: TnsSendAction
     read f_SendAction
     write f_SendAction;
 end;//TPrimRememberPasswordForm

 TvcmEntityFormRef = TPrimRememberPasswordForm;
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  l3String,
  nsVerifyValue,
  Windows,
  Graphics
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  ,
  StdRes {a},
  l3Base {a}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

// start class TPrimRememberPasswordForm

procedure TPrimRememberPasswordForm.EMailEditChange(Sender: TObject);
//#UC START# *525D12A30273_4A93EC4B03CC_var*
//#UC END# *525D12A30273_4A93EC4B03CC_var*
begin
//#UC START# *525D12A30273_4A93EC4B03CC_impl*
 btnSend.Enabled := nsEmailVerify.Verify(edEmail.Text);
 if btnSend.Enabled then
  edEmail.Font.Color := clWindowText
 else
  edEmail.Font.Color := clRed;
//#UC END# *525D12A30273_4A93EC4B03CC_impl*
end;//TPrimRememberPasswordForm.EMailEditChange

procedure TPrimRememberPasswordForm.BtnSendClick(Sender: TObject);
//#UC START# *525D12C2011A_4A93EC4B03CC_var*
//#UC END# *525D12C2011A_4A93EC4B03CC_var*
begin
//#UC START# *525D12C2011A_4A93EC4B03CC_impl*
 DoSend;
//#UC END# *525D12C2011A_4A93EC4B03CC_impl*
end;//TPrimRememberPasswordForm.BtnSendClick

procedure TPrimRememberPasswordForm.DoSend;
//#UC START# *525D13F30292_4A93EC4B03CC_var*
//#UC END# *525D13F30292_4A93EC4B03CC_var*
begin
//#UC START# *525D13F30292_4A93EC4B03CC_impl*
 if Assigned(SendAction) then
  ModalResult := SendAction(self);
//#UC END# *525D13F30292_4A93EC4B03CC_impl*
end;//TPrimRememberPasswordForm.DoSend

function TPrimRememberPasswordForm.pm_GetEMail: Il3CString;
//#UC START# *525D1318002B_4A93EC4B03CCget_var*
//#UC END# *525D1318002B_4A93EC4B03CCget_var*
begin
//#UC START# *525D1318002B_4A93EC4B03CCget_impl*
 Result := edEmail.Text;
//#UC END# *525D1318002B_4A93EC4B03CCget_impl*
end;//TPrimRememberPasswordForm.pm_GetEMail

class function TPrimRememberPasswordForm.Make(
  const aParams : IvcmMakeParams = nil;
  aZoneType     : TvcmZoneType = vcm_ztAny;
  aUserType     : TvcmEffectiveUserType = 0;
  aDataSource   : IvcmFormDataSource = nil): IvcmEntityForm;
begin
 Result := inherited Make(aParams, aZoneType, aUserType, nil, aDataSource);
end;

procedure TPrimRememberPasswordForm.InitFields;
//#UC START# *47A042E100E2_4A93EC4B03CC_var*
//#UC END# *47A042E100E2_4A93EC4B03CC_var*
begin
//#UC START# *47A042E100E2_4A93EC4B03CC_impl*
 inherited;
 BorderIcons := [biSystemMenu];
 BorderStyle := bsSingle;
 Position := poScreenCenter;
//#UC END# *47A042E100E2_4A93EC4B03CC_impl*
end;//TPrimRememberPasswordForm.InitFields

{$If not defined(NoVCL)}
procedure TPrimRememberPasswordForm.CreateParams(var Params: TCreateParams);
//#UC START# *48C7925A02E5_4A93EC4B03CC_var*
//#UC END# *48C7925A02E5_4A93EC4B03CC_var*
begin
//#UC START# *48C7925A02E5_4A93EC4B03CC_impl*
 inherited;
 with Params do
 begin
  ExStyle := ExStyle or WS_EX_APPWINDOW and not WS_EX_TOOLWINDOW;
  WndParent := GetDesktopWindow;
 end;
//#UC END# *48C7925A02E5_4A93EC4B03CC_impl*
end;//TPrimRememberPasswordForm.CreateParams
{$IfEnd} //not NoVCL

{$If not defined(NoVCM)}
procedure TPrimRememberPasswordForm.InitControls;
//#UC START# *4A8E8F2E0195_4A93EC4B03CC_var*
//#UC END# *4A8E8F2E0195_4A93EC4B03CC_var*
begin
//#UC START# *4A8E8F2E0195_4A93EC4B03CC_impl*
 inherited;

 ActiveControl := edEmail;

 ClientHeight := 127;
 ClientWidth := 423;

 with EMailLabel do
 begin
  AutoSize := False;
  Left := 8;
  Top := 7;
  Width := 125;
  Height := 17;
  Alignment := taRightJustify;
 end;

 with HintLabel do
 begin
  AutoSize := False;
  Left := 8;
  Top := 32;
  Width := 409;
  Height := 56;
  Alignment := taCenter;
  WordWrap := True;
 end;

 with btnCancel do
 begin
  Left := 342;
  Top := 94;
  Width := 75;
  Height := 25;
  DrawDefaultFrame := False;
  Cancel := True;
  ModalResult := mrCancel;
  NumGlyphs := 1;
  ThinFrame := True;
  TabOrder := 0;
  ParentFont := True;
  DockOrientation := doNoOrient;
 end;

 with btnSend do
 begin
  Left := 210;
  Top := 94;
  Width := 122;
  Height := 25;
  DrawDefaultFrame := False;
  Default := True;
  ModalResult := mrCancel;
  NumGlyphs := 1;
  ThinFrame := True;
  Enabled := False;
  TabOrder := 1;
  ParentFont := True;
  OnClick := btnSendClick;
  DockOrientation := doNoOrient;
 end;

 with edEmail do
 begin
  Left := 146;
  Top := 6;
  Width := 267;
  Height := 21;
  OnChange := EMailEditChange;
  TabOrder := 2;
 end;
//#UC END# *4A8E8F2E0195_4A93EC4B03CC_impl*
end;//TPrimRememberPasswordForm.InitControls
{$IfEnd} //not NoVCM

{$If not defined(NoVCL)}
function TPrimRememberPasswordForm.IsRealInstance: Boolean;
//#UC START# *4B0E846D022B_4A93EC4B03CC_var*
//#UC END# *4B0E846D022B_4A93EC4B03CC_var*
begin
//#UC START# *4B0E846D022B_4A93EC4B03CC_impl*
 Result := True;
//#UC END# *4B0E846D022B_4A93EC4B03CC_impl*
end;//TPrimRememberPasswordForm.IsRealInstance
{$IfEnd} //not NoVCL

procedure TPrimRememberPasswordForm.MakeControls;
begin
 inherited;
 f_EMailLabel := TvtLabel.Create(Self);
 f_EMailLabel.Name := 'EMailLabel';
 f_EMailLabel.Parent := Self;
 f_EMailLabel.Caption := '*Электронная почта:';
 f_HintLabel := TvtLabel.Create(Self);
 f_HintLabel.Name := 'HintLabel';
 f_HintLabel.Parent := Self;
 f_HintLabel.Caption := '*Адрес электронной почты, указанный при регистрации. На этот адрес будет выслано письмо, содержащее Ваши регистрационное имя и пароль.';
 f_btnCancel := TElPopupButton.Create(Self);
 f_btnCancel.Name := 'btnCancel';
 f_btnCancel.Parent := Self;
 f_btnCancel.Caption := 'Отмена';
 f_btnSend := TElPopupButton.Create(Self);
 f_btnSend.Name := 'btnSend';
 f_btnSend.Parent := Self;
 f_btnSend.Caption := 'Отправить запрос';
 f_edEmail := TnscEdit.Create(Self);
 f_edEmail.Name := 'edEmail';
 f_edEmail.Parent := Self;
end;

{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация PrimRememberPassword
 TtfwClassRef.Register(TPrimRememberPasswordForm);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.