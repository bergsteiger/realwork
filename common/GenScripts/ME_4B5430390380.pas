unit PrimSelfInfo_Form;
 {* Регистрационные данные }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Settings\Forms\PrimSelfInfo_Form.pas"
// Стереотип: "VCMForm"
// Элемент модели: "PrimSelfInfo" MUID: (4B5430390380)
// Имя типа: "TPrimSelfInfoForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmEntityForm
 {$IfEnd} // NOT Defined(NoVCM)
 , AdminDomainInterfaces
 , vtPanel
 , vtLabel
 {$If Defined(Nemesis)}
 , nscComboBox
 {$IfEnd} // Defined(Nemesis)
 , ElPopBtn
 {$If NOT Defined(NoVCL)}
 , ExtCtrls
 {$IfEnd} // NOT Defined(NoVCL)
 , vtFocusLabel
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
;

type
 TPrimSelfInfoForm = class({$If NOT Defined(NoVCM)}
 TvcmEntityForm
 {$IfEnd} // NOT Defined(NoVCM)
 )
  {* Регистрационные данные }
  private
   f_PasswordChanged: Boolean;
   f_pnMainData: TvtPanel;
    {* Поле для свойства pnMainData }
   f_UserNameLabel: TvtLabel;
    {* Поле для свойства UserNameLabel }
   f_PasswordLabel: TvtLabel;
    {* Поле для свойства PasswordLabel }
   f_LoginLabel: TvtLabel;
    {* Поле для свойства LoginLabel }
   f_InfoLabel: TvtLabel;
    {* Поле для свойства InfoLabel }
   f_EMailLabel: TvtLabel;
    {* Поле для свойства EMailLabel }
   f_ConfirmPasswordLabel: TvtLabel;
    {* Поле для свойства ConfirmPasswordLabel }
   f_vtAsteriskLabelLogin: TvtLabel;
    {* Поле для свойства vtAsteriskLabelLogin }
   f_vtAsteriskLabelFIO: TvtLabel;
    {* Поле для свойства vtAsteriskLabelFIO }
   f_edPassword: TnscComboBoxWithPwdChar;
    {* Поле для свойства edPassword }
   f_edUserName: TnscEdit;
    {* Поле для свойства edUserName }
   f_edLogin: TnscEdit;
    {* Поле для свойства edLogin }
   f_edEmail: TnscEdit;
    {* Поле для свойства edEmail }
   f_edConfirm: TnscComboBoxWithPwdChar;
    {* Поле для свойства edConfirm }
   f_BottomPanel: TvtPanel;
    {* Поле для свойства BottomPanel }
   f_RegisterButton: TElPopupButton;
    {* Поле для свойства RegisterButton }
   f_HelpPanel: TvtPanel;
    {* Поле для свойства HelpPanel }
   f_HelpPaintBox: TPaintBox;
    {* Поле для свойства HelpPaintBox }
   f_HelpLabel: TvtFocusLabel;
    {* Поле для свойства HelpLabel }
   f_Info: InsUserProperty;
    {* Поле для свойства Info }
  private
   procedure edPasswordChange(Sender: TObject);
   procedure edConfirmChange(Sender: TObject);
   procedure edUserNameChange(Sender: TObject);
   procedure RegisterButtonClick(Sender: TObject);
   procedure HelpLabelClick(Sender: TObject);
   procedure HelpPaintBoxPaint(Sender: TObject);
   procedure CheckFields;
   procedure InitUserFields;
   procedure Save;
   procedure CMDialogKey(var Message: TCMDialogKey); message CM_DIALOGKEY;
  protected
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   {$If NOT Defined(NoVCM)}
   procedure InitControls; override;
    {* Процедура инициализации контролов. Для перекрытия в потомках }
   {$IfEnd} // NOT Defined(NoVCM)
   procedure ClearFields; override;
   {$If NOT Defined(NoVCM)}
   procedure SetupFormLayout; override;
    {* Тут можно настроить внешний вид формы }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure MakeControls; override;
   {$IfEnd} // NOT Defined(NoVCM)
  public
   property pnMainData: TvtPanel
    read f_pnMainData;
   property BottomPanel: TvtPanel
    read f_BottomPanel;
   property Info: InsUserProperty
    read f_Info;
 end;//TPrimSelfInfoForm
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , l3StringIDEx
 , nsUserProperty
 , DataAdapter
 , SecurityUnit
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , Graphics
 , SearchRes
 , nsConst
 , nsVerifyValue
 , l3Base
 , l3String
 , nsTypes
 {$If NOT Defined(NoVCM)}
 , vcmMessagesSupport
 {$IfEnd} // NOT Defined(NoVCM)
 , l3Chars
 , Windows
 , l3MessageID
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

{$If NOT Defined(NoVCM)}
const
 {* Локализуемые строки SelfInfo Hints }
 str_PrimSelfInfo_edPasswordHint: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'PrimSelfInfo_edPasswordHint'; rValue : 'Введите пароль для авторизации в системе');
  {* 'Введите пароль для авторизации в системе' }
 str_PrimSelfInfo_edUserNameHint: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'PrimSelfInfo_edUserNameHint'; rValue : 'Введите свои имя, фамилию и отчество');
  {* 'Введите свои имя, фамилию и отчество' }
 str_PrimSelfInfo_edLoginHint: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'PrimSelfInfo_edLoginHint'; rValue : 'Введите имя для работы в системе ГАРАНТ');
  {* 'Введите имя для работы в системе ГАРАНТ' }
 str_PrimSelfInfo_edEmailHint: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'PrimSelfInfo_edEmailHint'; rValue : 'Электронная почта: адрес, на который будет выслан забытый Вами пароль');
  {* 'Электронная почта: адрес, на который будет выслан забытый Вами пароль' }
 str_PrimSelfInfo_edConfirmHint: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'PrimSelfInfo_edConfirmHint'; rValue : 'Подтвердите пароль, введенный в предыдущей строке');
  {* 'Подтвердите пароль, введенный в предыдущей строке' }

procedure TPrimSelfInfoForm.edPasswordChange(Sender: TObject);
//#UC START# *5261516401F6_4B5430390380_var*
//#UC END# *5261516401F6_4B5430390380_var*
begin
//#UC START# *5261516401F6_4B5430390380_impl*
 f_PasswordChanged := True;
 CheckFields;
//#UC END# *5261516401F6_4B5430390380_impl*
end;//TPrimSelfInfoForm.edPasswordChange

procedure TPrimSelfInfoForm.edConfirmChange(Sender: TObject);
//#UC START# *5261516C030F_4B5430390380_var*
//#UC END# *5261516C030F_4B5430390380_var*
begin
//#UC START# *5261516C030F_4B5430390380_impl*
 CheckFields;
//#UC END# *5261516C030F_4B5430390380_impl*
end;//TPrimSelfInfoForm.edConfirmChange

procedure TPrimSelfInfoForm.edUserNameChange(Sender: TObject);
//#UC START# *5261517401D4_4B5430390380_var*
//#UC END# *5261517401D4_4B5430390380_var*
begin
//#UC START# *5261517401D4_4B5430390380_impl*
 CheckFields;
//#UC END# *5261517401D4_4B5430390380_impl*
end;//TPrimSelfInfoForm.edUserNameChange

procedure TPrimSelfInfoForm.RegisterButtonClick(Sender: TObject);
//#UC START# *5261517B03B9_4B5430390380_var*
//#UC END# *5261517B03B9_4B5430390380_var*
begin
//#UC START# *5261517B03B9_4B5430390380_impl*
 Save;
//#UC END# *5261517B03B9_4B5430390380_impl*
end;//TPrimSelfInfoForm.RegisterButtonClick

procedure TPrimSelfInfoForm.HelpLabelClick(Sender: TObject);
//#UC START# *5261518F02B3_4B5430390380_var*
//#UC END# *5261518F02B3_4B5430390380_var*
begin
//#UC START# *5261518F02B3_4B5430390380_impl*
 Application.HelpSystem.ShowHelp('ut_SelfInfo', '');
//#UC END# *5261518F02B3_4B5430390380_impl*
end;//TPrimSelfInfoForm.HelpLabelClick

procedure TPrimSelfInfoForm.HelpPaintBoxPaint(Sender: TObject);
//#UC START# *526151A2028E_4B5430390380_var*
//#UC END# *526151A2028E_4B5430390380_var*
begin
//#UC START# *526151A2028E_4B5430390380_impl*
 with Sender as TPaintBox do
  nsSearchRes.ImageList16x16.Draw(Canvas, width - c_SmallSizeIcon, (Height - c_SmallSizeIcon) div 2, c_srchHelp);
//#UC END# *526151A2028E_4B5430390380_impl*
end;//TPrimSelfInfoForm.HelpPaintBoxPaint

procedure TPrimSelfInfoForm.CheckFields;
//#UC START# *5261520B011E_4B5430390380_var*
var
 l_Result : Boolean;
//#UC END# *5261520B011E_4B5430390380_var*
begin
//#UC START# *5261520B011E_4B5430390380_impl*
 Info.IsChanged := True;

 l_Result := True;
 // Подсветим красным
 edLogin.TextValid := nsLoginVerify.Verify(edLogin.Text);
 edPassword.TextValid := nsPasswordVerify.Verify(edPassword.Text);
 edEmail.TextValid := nsEmailVerify.Verify(edEmail.Text);
 edConfirm.TextValid := nsPasswordVerify.Verify(edConfirm.Text) and l3Same(edConfirm.Text, edPassword.Text);
 // Логин
 if l3IsNil(edLogin.Text) then
  l_Result := False
 else
 // ФИО пользователя
 if l3IsNil(edUserName.Text) then
  l_Result := False;

 RegisterButton.Enabled := l_Result;
//#UC END# *5261520B011E_4B5430390380_impl*
end;//TPrimSelfInfoForm.CheckFields

procedure TPrimSelfInfoForm.InitUserFields;
//#UC START# *5261521202EE_4B5430390380_var*
//#UC END# *5261521202EE_4B5430390380_var*
begin
//#UC START# *5261521202EE_4B5430390380_impl*
 f_PasswordChanged := False;

 if Info = nil then
  Exit;
  
 edLogin.TextValid := True;
 edPassword.TextValid := True;
 edEmail.TextValid := True;
 edConfirm.TextValid := True;
 if Info.HasPassword then
 begin
  edPassword.Text := nsCStr(cHasPassword);
  edConfirm.Text := nsCStr(cHasPassword);
 end
 else
 begin
  edPassword.Text := nil;
  edConfirm.Text := nil;
 end;

 edLogin.Text := Info.Login;
 edLogin.Enabled := False;
 edUserName.Text := Info.Name;
 edEmail.Text := Info.Mail;
//#UC END# *5261521202EE_4B5430390380_impl*
end;//TPrimSelfInfoForm.InitUserFields

procedure TPrimSelfInfoForm.Save;
//#UC START# *5261521D0133_4B5430390380_var*
  procedure lpSetFocus(aEdit : TnscComboBox);
  begin
   with aEdit do
   begin
    SelectAll;
    SetFocus;
   end;
  end;

  procedure lpClearPassword;
  begin
   edPassword.Text := nil;
   edConfirm.Text  := nil;
   lpSetFocus(edPassword);
  end;
//#UC END# *5261521D0133_4B5430390380_var*
begin
//#UC START# *5261521D0133_4B5430390380_impl*
 if not l3Same(edPassword.Text, edConfirm.Text) then
 begin
  lpClearPassword;
  vcmAsk(err_PasswordAndConfirmNotSame);
  Exit;
 end
 else
 if not nsPasswordVerify.Verify(edPassword.Text) then
 begin
  lpClearPassword;
  vcmAsk(err_PasswordHasErrorSimbols);
  Exit;
 end
 else
 // Поле ФИО
 if l3IsNil(edUserName.Text) then
 begin
  lpSetFocus(edUserName);
  vcmAsk(err_SurnameNotDefined);
  Exit;
 end
 else
 // Email
 if not l3IsNil(edEmail.Text) and not nsEmailVerify.Verify(edEmail.Text) then
 begin
  lpSetFocus(edEmail);
  vcmAsk(err_EmailNotValid);
  Exit;
 end;

 if l3Same(edPassword.Text, cHasPassword) then
 try
  Info.SaveUserInfo(l3PCharLen(edUserName.Text),
                    l3PCharLen(edEmail.Text),
                    cc_EmptyStr)
 except
  on ENoMoreProfiles do
   Say(err_UsersLicenceViolation);
  on ENoMorePrivilegedProfiles do
   Say(err_PrivilegedUsersLicenceViolation);
 end
 else
 try
  Info.SaveUserInfo(l3PCharLen(edUserName.Text),
                    l3PCharLen(edEmail.Text),
                    l3PCharLen(edPassword.Text),
                    f_PasswordChanged);
  if f_PasswordChanged then
   defDataAdapter.RegistryPassword := l3Str(edPassword.Text);
 except
  on ENoMoreProfiles do
   Say(err_UsersLicenceViolation);
  on ENoMorePrivilegedProfiles do
   Say(err_PrivilegedUsersLicenceViolation);
 end;
 ModalResult := mrOk;
//#UC END# *5261521D0133_4B5430390380_impl*
end;//TPrimSelfInfoForm.Save

procedure TPrimSelfInfoForm.CMDialogKey(var Message: TCMDialogKey);
//#UC START# *526152250198_4B5430390380_var*
//#UC END# *526152250198_4B5430390380_var*
begin
//#UC START# *526152250198_4B5430390380_impl*
 if (Message.CharCode = VK_ESCAPE) and (fsModal in FormState) then
 begin
  ModalResult := mrCancel;
  Message.Result := 1;
 end else
  inherited;
//#UC END# *526152250198_4B5430390380_impl*
end;//TPrimSelfInfoForm.CMDialogKey

procedure TPrimSelfInfoForm.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4B5430390380_var*
//#UC END# *479731C50290_4B5430390380_var*
begin
//#UC START# *479731C50290_4B5430390380_impl*
 f_Info := nil;
 inherited Cleanup;
//#UC END# *479731C50290_4B5430390380_impl*
end;//TPrimSelfInfoForm.Cleanup

procedure TPrimSelfInfoForm.InitControls;
 {* Процедура инициализации контролов. Для перекрытия в потомках }
//#UC START# *4A8E8F2E0195_4B5430390380_var*
var
 l_Profile: IUserProfile;
//#UC END# *4A8E8F2E0195_4B5430390380_var*
begin
//#UC START# *4A8E8F2E0195_4B5430390380_impl*
 if (ZoneType <> vcm_ztForToolbarsInfo) then
 begin
  defDataAdapter.NativeAdapter.MakeUserManager.GetSelfProfile(l_Profile);
  f_Info := TnsUserProperty.Make(l_Profile);
 end; 
 inherited;

 with pnMainData do
 begin
  Align := alClient;
  BevelOuter := bvNone;
  TabOrder := 0;
 end;
  with UserNameLabel do
  begin
   AutoSize := False;
   Left := 0;
   Top := 84;
   Width := 207;
   Height := 17;
   Alignment := taRightJustify;
   BiDiMode := bdLeftToRight;
  end;
  with PasswordLabel do
  begin
   AutoSize := False;
   Left := 0;
   Top := 36;
   Width := 207;
   Height := 17;
   Alignment := taRightJustify;
   BiDiMode := bdLeftToRight;
  end;
  with LoginLabel do
  begin
   AutoSize := False;
   Left := 0;
   Top := 12;
   Width := 207;
   Height := 17;
   Alignment := taRightJustify;
   BiDiMode := bdLeftToRight;
  end;
  with InfoLabel do
  begin
   Left := 222;
   Top := 131;
   Width := 235;
   Height := 16;
  end;
  with EMailLabel do
  begin
   AutoSize := False;
   Left := 0;
   Top := 108;
   Width := 207;
   Height := 17;
   Alignment := taRightJustify;
   BiDiMode := bdLeftToRight;
  end;
  with ConfirmPasswordLabel do
  begin
   AutoSize := False;
   Left := 0;
   Top := 60;
   Width := 207;
   Height := 17;
   Alignment := taRightJustify;
   BiDiMode := bdLeftToRight;
  end;
  with vtAsteriskLabelLogin do
  begin
   Left := 207;
   Top := 12;
   Width := 9;
   Height := 16;
   Alignment := taRightJustify;
   BiDiMode := bdLeftToRight;
  end;
  with vtAsteriskLabelFIO do
  begin
   Left := 207;
   Top := 84;
   Width := 9;
   Height := 16;
   Alignment := taRightJustify;
   BiDiMode := bdLeftToRight;
  end;
  with edLogin do
  begin
    Left := 222;
    Top := 10;
    Width := 249;
    Height := 21;
    Hint := str_PrimSelfInfo_edLoginHint.AsStr;
    TabOrder := 0;
    MaxLength := 31;
  end;
  with edPassword do
  begin
   Left := 222;
   Top := 34;
   Width := 249;
   Height := 21;
   Hint := str_PrimSelfInfo_edPasswordHint.AsStr;
   OnChange := edPasswordChange;
   TabOrder := 1;
   MaxLength := 255;
   PasswordChar := '*';
  end;
  with edConfirm do
  begin
   Left := 222;
   Top := 58;
   Width := 249;
   Height := 21;
   Hint := str_PrimSelfInfo_edConfirmHint.AsStr;
   OnChange := edConfirmChange;
   TabOrder := 2;
   MaxLength := 255;
   PasswordChar := '*';
  end;
  with edUserName do
  begin
   Left := 222;
   Top := 82;
   Width := 249;
   Height := 21;
   Hint := str_PrimSelfInfo_edUserNameHint.AsStr;
   OnChange := edUserNameChange;
   TabOrder := 3;
  end;
  with edEmail do
  begin
   Left := 222;
   Top := 106;
   Width := 249;
   Height := 21;
   Hint := str_PrimSelfInfo_edEmailHint.AsStr;
   OnChange := edUserNameChange;
   TabOrder := 4;
  end;
 with BottomPanel do
 begin
  Left := 0;
  Top := 155;
  Width := 476;
  Height := 33;
  Align := alBottom;
  BevelOuter := bvNone;
  TabOrder := 1;
 end;
  with RegisterButton do
  begin
   Left := 364;
   Top := 0;
   Width := 105;
   Height := 25;
   DrawDefaultFrame := False;
   Default := True;
   //ModalResult := mrOk;
   NumGlyphs := 1;
   Enabled := False;
   TabOrder := 0;
   OnClick := RegisterButtonClick;
   DockOrientation := doNoOrient;
  end;
  with HelpPanel do
  begin
   Left := 9;
   Top := 7;
   Width := 85;
   Height := 19;
   BevelOuter := bvNone;
   TabOrder := 1;
  end;
   with HelpPaintBox do
   begin
    Left := 0;
    Top := 0;
    Width := 16;
    Height := 19;
    OnPaint := HelpPaintBoxPaint;
   end;
   with HelpLabel do
   begin
    Left := 20;
    Top := 0;
    Width := 56;
    Height := 19;
    Cursor := crHandPoint;
    TabOrder := 0;
    Font.Color := clBlue;
    HighlightColor := clBlue;
    Hyperlink := True;
    OnClick := HelpLabelClick;
   end;
//#UC END# *4A8E8F2E0195_4B5430390380_impl*
end;//TPrimSelfInfoForm.InitControls

procedure TPrimSelfInfoForm.ClearFields;
begin
 f_Info := nil;
 inherited;
end;//TPrimSelfInfoForm.ClearFields

procedure TPrimSelfInfoForm.SetupFormLayout;
 {* Тут можно настроить внешний вид формы }
//#UC START# *529332B40230_4B5430390380_var*
//#UC END# *529332B40230_4B5430390380_var*
begin
//#UC START# *529332B40230_4B5430390380_impl*
 inherited;
 BorderIcons := [biSystemMenu];
 BorderStyle := bsSingle;
 ClientHeight := 188;
 ClientWidth := 476;
 Position := poScreenCenter;
 ActiveControl := edPassword;
 InitUserFields;
//#UC END# *529332B40230_4B5430390380_impl*
end;//TPrimSelfInfoForm.SetupFormLayout

procedure TPrimSelfInfoForm.MakeControls;
begin
 inherited;
 f_pnMainData := TvtPanel.Create(Self);
 f_pnMainData.Name := 'pnMainData';
 f_pnMainData.Parent := Self;
 f_UserNameLabel := TvtLabel.Create(Self);
 f_UserNameLabel.Name := 'UserNameLabel';
 f_UserNameLabel.Parent := pnMainData;
 f_PasswordLabel := TvtLabel.Create(Self);
 f_PasswordLabel.Name := 'PasswordLabel';
 f_PasswordLabel.Parent := pnMainData;
 f_LoginLabel := TvtLabel.Create(Self);
 f_LoginLabel.Name := 'LoginLabel';
 f_LoginLabel.Parent := pnMainData;
 f_InfoLabel := TvtLabel.Create(Self);
 f_InfoLabel.Name := 'InfoLabel';
 f_InfoLabel.Parent := pnMainData;
 f_EMailLabel := TvtLabel.Create(Self);
 f_EMailLabel.Name := 'EMailLabel';
 f_EMailLabel.Parent := pnMainData;
 f_ConfirmPasswordLabel := TvtLabel.Create(Self);
 f_ConfirmPasswordLabel.Name := 'ConfirmPasswordLabel';
 f_ConfirmPasswordLabel.Parent := pnMainData;
 f_vtAsteriskLabelLogin := TvtLabel.Create(Self);
 f_vtAsteriskLabelLogin.Name := 'vtAsteriskLabelLogin';
 f_vtAsteriskLabelLogin.Parent := pnMainData;
 f_vtAsteriskLabelFIO := TvtLabel.Create(Self);
 f_vtAsteriskLabelFIO.Name := 'vtAsteriskLabelFIO';
 f_vtAsteriskLabelFIO.Parent := pnMainData;
 f_edPassword := TnscComboBoxWithPwdChar.Create(Self);
 f_edPassword.Name := 'edPassword';
 f_edPassword.Parent := pnMainData;
 f_edUserName := TnscEdit.Create(Self);
 f_edUserName.Name := 'edUserName';
 f_edUserName.Parent := pnMainData;
 f_edLogin := TnscEdit.Create(Self);
 f_edLogin.Name := 'edLogin';
 f_edLogin.Parent := pnMainData;
 f_edEmail := TnscEdit.Create(Self);
 f_edEmail.Name := 'edEmail';
 f_edEmail.Parent := pnMainData;
 f_edConfirm := TnscComboBoxWithPwdChar.Create(Self);
 f_edConfirm.Name := 'edConfirm';
 f_edConfirm.Parent := pnMainData;
 f_BottomPanel := TvtPanel.Create(Self);
 f_BottomPanel.Name := 'BottomPanel';
 f_BottomPanel.Parent := Self;
 f_RegisterButton := TElPopupButton.Create(Self);
 f_RegisterButton.Name := 'RegisterButton';
 f_RegisterButton.Parent := BottomPanel;
 f_HelpPanel := TvtPanel.Create(Self);
 f_HelpPanel.Name := 'HelpPanel';
 f_HelpPanel.Parent := BottomPanel;
 f_HelpPaintBox := TPaintBox.Create(Self);
 f_HelpPaintBox.Name := 'HelpPaintBox';
 f_HelpPaintBox.Parent := HelpPanel;
 f_HelpLabel := TvtFocusLabel.Create(Self);
 f_HelpLabel.Name := 'HelpLabel';
 f_HelpLabel.Parent := HelpPanel;
end;//TPrimSelfInfoForm.MakeControls

initialization
 str_PrimSelfInfo_edPasswordHint.Init;
 {* Инициализация str_PrimSelfInfo_edPasswordHint }
 str_PrimSelfInfo_edUserNameHint.Init;
 {* Инициализация str_PrimSelfInfo_edUserNameHint }
 str_PrimSelfInfo_edLoginHint.Init;
 {* Инициализация str_PrimSelfInfo_edLoginHint }
 str_PrimSelfInfo_edEmailHint.Init;
 {* Инициализация str_PrimSelfInfo_edEmailHint }
 str_PrimSelfInfo_edConfirmHint.Init;
 {* Инициализация str_PrimSelfInfo_edConfirmHint }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimSelfInfoForm);
 {* Регистрация PrimSelfInfo }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
end.
