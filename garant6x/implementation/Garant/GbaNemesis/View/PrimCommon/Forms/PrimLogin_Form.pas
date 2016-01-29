unit PrimLogin_Form;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/PrimCommon/Forms/PrimLogin_Form.pas"
// Начат: 25.08.2009 16:25
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMForm::Class>> F1 Базовые определения предметной области::F1 Application Template::View::PrimCommon::PrimLogin
//
// Вход в систему ГАРАНТ
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
  Controls
  {$IfEnd} //not NoVCL
  
  {$If not defined(NoVCL)}
  ,
  Forms
  {$IfEnd} //not NoVCL
  ,
  Windows
  {$If not defined(NoVCL)}
  ,
  ExtCtrls
  {$IfEnd} //not NoVCL
  
  {$If not defined(NoVCM)}
  ,
  vcmEntityForm
  {$IfEnd} //not NoVCM
  ,
  vtPanel,
  vtFocusLabel,
  vtGroupBox
  {$If defined(Nemesis)}
  ,
  nscComboBox
  {$IfEnd} //Nemesis
  ,
  vtLabel
  {$If defined(Nemesis)}
  ,
  nscComboBoxWithReadOnly
  {$IfEnd} //Nemesis
  ,
  vtCheckBox,
  ElPopBtn,
  Messages,
  vcmExternalInterfaces {a},
  vcmInterfaces {a}
  ;

type
 TnsLoginAction = function (aSender: TCustomForm): TModalResult of object;

 TPrimLoginForm = {form} class(TvcmEntityForm)
  {* Вход в систему ГАРАНТ }
 private
 // private fields
   f_NeedRelogin : Boolean;
   f_RegisteredGroupBox : TvtGroupBox;
    {* Поле для свойства RegisteredGroupBox}
   f_lblLogin : TvtLabel;
    {* Поле для свойства lblLogin}
   f_lblPassword : TvtLabel;
    {* Поле для свойства lblPassword}
   f_EnterPaintBox : TPaintBox;
    {* Поле для свойства EnterPaintBox}
   f_edUserName : TnscComboBoxWithReadOnly;
    {* Поле для свойства edUserName}
   f_edPassword : TnscComboBoxWithPwdChar;
    {* Поле для свойства edPassword}
   f_lblForgetPassword : TvtFocusLabel;
    {* Поле для свойства lblForgetPassword}
   f_cbAutoLogin : TvtCheckBox;
    {* Поле для свойства cbAutoLogin}
   f_btnOk : TElPopupButton;
    {* Поле для свойства btnOk}
   f_NewUserGroupBox : TvtGroupBox;
    {* Поле для свойства NewUserGroupBox}
   f_NewUserLabel : TvtLabel;
    {* Поле для свойства NewUserLabel}
   f_NewUserPaintBox : TPaintBox;
    {* Поле для свойства NewUserPaintBox}
   f_lblNewUser : TvtFocusLabel;
    {* Поле для свойства lblNewUser}
   f_HelpPanel : TvtPanel;
    {* Поле для свойства HelpPanel}
   f_HelpPaintBox : TPaintBox;
    {* Поле для свойства HelpPaintBox}
   f_HelpLabel : TvtFocusLabel;
    {* Поле для свойства HelpLabel}
   f_ForgetPasswordChosen : Boolean;
    {* Поле для свойства ForgetPasswordChosen}
   f_NewUserChosen : Boolean;
    {* Поле для свойства NewUserChosen}
   f_LoginAction : TnsLoginAction;
    {* Поле для свойства LoginAction}
 protected
  procedure MakeControls; override;
 private
 // private methods
   procedure FormShow(Sender: TObject);
     {* TNotifyEvent is used for events that do not require parameters. }
   procedure FormHide(Sender: TObject);
     {* TNotifyEvent is used for events that do not require parameters. }
   procedure ForgetPasswordLabelClick(Sender: TObject);
     {* TNotifyEvent is used for events that do not require parameters. }
   procedure LoginEditChange(Sender: TObject);
     {* TNotifyEvent is used for events that do not require parameters. }
   procedure NewUserLabelClick(Sender: TObject);
     {* TNotifyEvent is used for events that do not require parameters. }
   procedure BtnOkClick(Sender: TObject);
     {* TNotifyEvent is used for events that do not require parameters. }
   procedure HelpPaintBoxPaint(Sender: TObject);
     {* TNotifyEvent is used for events that do not require parameters. }
   procedure HelpLabelClick(Sender: TObject);
     {* TNotifyEvent is used for events that do not require parameters. }
   procedure NewUserPaintBoxPaint(Sender: TObject);
     {* TNotifyEvent is used for events that do not require parameters. }
   procedure EnterPaintBoxPaint(Sender: TObject);
     {* TNotifyEvent is used for events that do not require parameters. }
   procedure VcmEntityFormRefPaint(Sender: TObject);
     {* TNotifyEvent is used for events that do not require parameters. }
   procedure Save;
     {* Сигнатура метода Save }
   procedure RepositionControls;
     {* Сигнатура метода RepositionControls }
   procedure CMDialogKey(var Message: TCMDialogKey); message CM_DIALOGKEY;
 protected
 // property methods
   function pm_GetLogin: Il3CString;
   function pm_GetPassword: Il3CString;
   function pm_GetIsAutoLogin: Boolean;
 protected
 // overridden protected methods
   {$If not defined(NoVCL)}
   procedure WndProc(var Message: TMessage); override;
   {$IfEnd} //not NoVCL
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
    {$If not defined(NoVCL)}
   function ShowModal: Integer; override;
    {$IfEnd} //not NoVCL
 public
 // public methods
   constructor Create(aOwner: TComponent;
     const aLogin: Il3CString;
     aIsAutoLogin: Boolean); reintroduce;
   constructor CreateForRelogin(aOwner: TComponent;
     const aLogin: Il3CString;
     const aPassword: Il3CString;
     aIsAutoLogin: Boolean);
 public
 // public properties
   property RegisteredGroupBox: TvtGroupBox
     read f_RegisteredGroupBox;
     {* Зарегистрированный пользователь }
   property lblLogin: TvtLabel
     read f_lblLogin;
     {* Регистрационное имя: }
   property lblPassword: TvtLabel
     read f_lblPassword;
     {* Пароль: }
   property EnterPaintBox: TPaintBox
     read f_EnterPaintBox;
   property edUserName: TnscComboBoxWithReadOnly
     read f_edUserName;
   property edPassword: TnscComboBoxWithPwdChar
     read f_edPassword;
   property lblForgetPassword: TvtFocusLabel
     read f_lblForgetPassword;
     {* Забыли пароль? }
   property cbAutoLogin: TvtCheckBox
     read f_cbAutoLogin;
     {* Запомнить пароль }
   property btnOk: TElPopupButton
     read f_btnOk;
     {* Войти в систему }
   property NewUserGroupBox: TvtGroupBox
     read f_NewUserGroupBox;
     {* Новый пользователь }
   property NewUserLabel: TvtLabel
     read f_NewUserLabel;
     {* Если Вы впервые входите в систему ГАРАНТ и еще не создали свою учетную запись, зарегистрируйтесь для начала работы. }
   property NewUserPaintBox: TPaintBox
     read f_NewUserPaintBox;
   property lblNewUser: TvtFocusLabel
     read f_lblNewUser;
     {* Зарегистрировать нового пользователя }
   property HelpPanel: TvtPanel
     read f_HelpPanel;
   property HelpPaintBox: TPaintBox
     read f_HelpPaintBox;
   property HelpLabel: TvtFocusLabel
     read f_HelpLabel;
     {* Помощь }
   property Login: Il3CString
     read pm_GetLogin;
   property Password: Il3CString
     read pm_GetPassword;
   property IsAutoLogin: Boolean
     read pm_GetIsAutoLogin;
   property ForgetPasswordChosen: Boolean
     read f_ForgetPasswordChosen;
   property NewUserChosen: Boolean
     read f_NewUserChosen;
   property LoginAction: TnsLoginAction
     read f_LoginAction
     write f_LoginAction;
 end;//TPrimLoginForm

 TvcmEntityFormRef = TPrimLoginForm;

implementation

uses
  SysUtils,
  Graphics,
  nsStartupSupport,
  nsFlashWindow,
  DataAdapter,
  SearchRes,
  nsConst,
  l3String,
  afwFacade,
  l3Base
  {$If not defined(NoVCL)}
  ,
  StdCtrls
  {$IfEnd} //not NoVCL
  
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  ,
  StdRes {a}
  ;

var
   g_Relogin : THandle;

// start class TPrimLoginForm

procedure TPrimLoginForm.FormShow(Sender: TObject);
//#UC START# *520B3FAB012D_4A93D80F014F_var*
//#UC END# *520B3FAB012D_4A93D80F014F_var*
begin
//#UC START# *520B3FAB012D_4A93D80F014F_impl*
 TnsStartupSupport.StartupCompletedNotify;
 nsFlashWindowByHandle(Handle);
 if f_NeedRelogin then
 begin
  f_NeedRelogin := False;
  PostMessage(Handle, g_Relogin, 0, 0);
 end;
 RepositionControls;
//#UC END# *520B3FAB012D_4A93D80F014F_impl*
end;//TPrimLoginForm.FormShow

procedure TPrimLoginForm.FormHide(Sender: TObject);
//#UC START# *520B3FB803CE_4A93D80F014F_var*
//#UC END# *520B3FB803CE_4A93D80F014F_var*
begin
//#UC START# *520B3FB803CE_4A93D80F014F_impl*
 TnsStartupSupport.StartupPendingNotify;
//#UC END# *520B3FB803CE_4A93D80F014F_impl*
end;//TPrimLoginForm.FormHide

procedure TPrimLoginForm.ForgetPasswordLabelClick(Sender: TObject);
//#UC START# *520B3FD500B3_4A93D80F014F_var*
//#UC END# *520B3FD500B3_4A93D80F014F_var*
begin
//#UC START# *520B3FD500B3_4A93D80F014F_impl*
 f_ForgetPasswordChosen := True;
 ModalResult := mrCancel;
//#UC END# *520B3FD500B3_4A93D80F014F_impl*
end;//TPrimLoginForm.ForgetPasswordLabelClick

procedure TPrimLoginForm.LoginEditChange(Sender: TObject);
//#UC START# *520B3FE001BA_4A93D80F014F_var*
//#UC END# *520B3FE001BA_4A93D80F014F_var*
begin
//#UC START# *520B3FE001BA_4A93D80F014F_impl*
 if (edUserName.TextLen <= 0) then
 begin
  cbAutoLogin.Enabled := False;
  btnOk.Enabled := False;
 end
 else
 begin
 {$IfNDEF nsAutoLoginDisable}
  cbAutoLogin.Enabled := True;
 {$ENDIF nsAutoLoginDisable}
  btnOk.Enabled := True;
 end;
//#UC END# *520B3FE001BA_4A93D80F014F_impl*
end;//TPrimLoginForm.LoginEditChange

procedure TPrimLoginForm.NewUserLabelClick(Sender: TObject);
//#UC START# *520B3FF10172_4A93D80F014F_var*
//#UC END# *520B3FF10172_4A93D80F014F_var*
begin
//#UC START# *520B3FF10172_4A93D80F014F_impl*
 {$IfNDef nsWithoutLogin}
 if not DefDataAdapter.Authorization.GetAutoregistrationStatus then
  DefDataAdapter.ShowAutoregistrationDisabledMessage
 else
 begin
  f_NewUserChosen := True;
  ModalResult := mrCancel;
 end;
 {$Else  nsWithoutLogin}
 Assert(false);
 {$EndIf nsWithoutLogin}
//#UC END# *520B3FF10172_4A93D80F014F_impl*
end;//TPrimLoginForm.NewUserLabelClick

procedure TPrimLoginForm.BtnOkClick(Sender: TObject);
//#UC START# *520B3FFC00F0_4A93D80F014F_var*
//#UC END# *520B3FFC00F0_4A93D80F014F_var*
begin
//#UC START# *520B3FFC00F0_4A93D80F014F_impl*
 Save;
//#UC END# *520B3FFC00F0_4A93D80F014F_impl*
end;//TPrimLoginForm.BtnOkClick

procedure TPrimLoginForm.HelpPaintBoxPaint(Sender: TObject);
//#UC START# *520B4005028E_4A93D80F014F_var*
//#UC END# *520B4005028E_4A93D80F014F_var*
begin
//#UC START# *520B4005028E_4A93D80F014F_impl*
 with Sender as TPaintBox do
  nsSearchRes.ImageList16x16.Draw(Canvas, width - c_SmallSizeIcon, (Height - c_SmallSizeIcon) div 2, c_srchHelp);
//#UC END# *520B4005028E_4A93D80F014F_impl*
end;//TPrimLoginForm.HelpPaintBoxPaint

procedure TPrimLoginForm.HelpLabelClick(Sender: TObject);
//#UC START# *520B40120072_4A93D80F014F_var*
//#UC END# *520B40120072_4A93D80F014F_var*
begin
//#UC START# *520B40120072_4A93D80F014F_impl*
 Application.HelpSystem.ShowHelp(HelpKeyword, '');
//#UC END# *520B40120072_4A93D80F014F_impl*
end;//TPrimLoginForm.HelpLabelClick

procedure TPrimLoginForm.NewUserPaintBoxPaint(Sender: TObject);
//#UC START# *520B40590179_4A93D80F014F_var*
//#UC END# *520B40590179_4A93D80F014F_var*
begin
//#UC START# *520B40590179_4A93D80F014F_impl*
 with Sender as TPaintBox do
  dmStdRes.LargeImageList.Draw(Canvas, width - c_LargeSizeIcon, (Height - c_LargeSizeIcon) div 2, cNewUser);
//#UC END# *520B40590179_4A93D80F014F_impl*
end;//TPrimLoginForm.NewUserPaintBoxPaint

procedure TPrimLoginForm.EnterPaintBoxPaint(Sender: TObject);
//#UC START# *520B406702B5_4A93D80F014F_var*
//#UC END# *520B406702B5_4A93D80F014F_var*
begin
//#UC START# *520B406702B5_4A93D80F014F_impl*
 with Sender as TPaintBox do
  dmStdRes.LargeImageList.Draw(Canvas, width - c_LargeSizeIcon, (Height - c_LargeSizeIcon) div 2, cEnterToSystem);
//#UC END# *520B406702B5_4A93D80F014F_impl*
end;//TPrimLoginForm.EnterPaintBoxPaint

procedure TPrimLoginForm.VcmEntityFormRefPaint(Sender: TObject);
//#UC START# *520B4075004C_4A93D80F014F_var*
//#UC END# *520B4075004C_4A93D80F014F_var*
begin
//#UC START# *520B4075004C_4A93D80F014F_impl*
 {$IfDef InsiderTest}
 if TdmStdRes.IsBatchMode then
  Save;
 {$EndIf InsiderTest}
//#UC END# *520B4075004C_4A93D80F014F_impl*
end;//TPrimLoginForm.VcmEntityFormRefPaint

procedure TPrimLoginForm.Save;
//#UC START# *520B41BE00B4_4A93D80F014F_var*
//#UC END# *520B41BE00B4_4A93D80F014F_var*
begin
//#UC START# *520B41BE00B4_4A93D80F014F_impl*
 if Assigned(LoginAction) then
  ModalResult := LoginAction(Self);
//#UC END# *520B41BE00B4_4A93D80F014F_impl*
end;//TPrimLoginForm.Save

procedure TPrimLoginForm.RepositionControls;
//#UC START# *520B41F90398_4A93D80F014F_var*
var
 l_Delta: Integer;
//#UC END# *520B41F90398_4A93D80F014F_var*
begin
//#UC START# *520B41F90398_4A93D80F014F_impl*
 RegisteredGroupBox.Font.Style := [fsBold];
 NewUserGroupBox.Font.Style := [fsBold];

 ActiveControl := edPassword;

 with RegisteredGroupBox do
 begin
  Left := 5;
  Top := 4;
  Width := 400;
  Height := 125;
  TabOrder := 0;
 end;
 with lblLogin do
 begin
  AutoSize := False;
  Left := 4;
  Top := 22;
  Width := 134;
  Height := 18;
  Alignment := taRightJustify;
  Layout := tlCenter;
 end;
 with lblPassword do
 begin
  AutoSize := False;
  Left := 4;
  Top := 46;
  Width := 134;
  Height := 18;
  Alignment := taRightJustify;
  Layout := tlCenter;
 end;
 with EnterPaintBox do
 begin
  Left := 15;
  Top := 66;
  Width := 32;
  Height := 32;
  OnPaint := EnterPaintBoxPaint;
 end;
 with edUserName do
 begin
  Left := 141;
  Top := 20;
  Width := 229;
  Height := 21;
  OnChange := LoginEditChange;
  TabOrder := 0;
  ShowHint := True;
 end;
 with edPassword do
 begin
  Left := 141;
  Top := 44;
  Width := 137;
  Height := 21;
  OnChange := LoginEditChange;
  TabOrder := 1;
  ShowHint := True;
  PasswordChar := '*';
 end;
 with lblForgetPassword do
 begin
  Left := 281;
  Top := 47;
  Width := 113;
  Height := 18;
  Cursor := crHandPoint;
  TabOrder := 2;
  Font.Color := clBlue;
  HighlightColor := clBlue;
  Hyperlink := True;
  OnClick := ForgetPasswordLabelClick;
 end;
 with cbAutoLogin do
 begin
  Left := 141;
  Top := 70;
  Width := 229;
  Height := 17;
  TabOrder := 3;
 end;
 with btnOk do
 begin
  Left := 141;
  Top := 90;
  Width := 229;
  Height := 26;
  DrawDefaultFrame := False;
  Default := True;
  NumGlyphs := 1;
  ThinFrame := True;
  TabOrder := 4;
  ParentFont := True;
  OnClick := btnOkClick;
  DockOrientation := doNoOrient;
 end;

 with NewUserGroupBox do
 begin
  Left := 5;
  Top := 131;
  Width := 400;
  Height := 85;
 end;
 with NewUserLabel do
 begin
  Layout := tlCenter;
  WordWrap := True;
  Left := 69;
  Top := 17;
  Width := 258;
  Height := 45;
  Font.Size := 9; 
 end;
 with NewUserPaintBox do
 begin
  Left := 15;
  Top := 29;
  Width := 32;
  Height := 32;
  OnPaint := NewUserPaintBoxPaint;
 end;
 with lblNewUser do
 begin
  Left := 70;
  Top := 60;
  Width := 241;
  Height := 18;
  Cursor := crHandPoint;
  TabOrder := 0;
  Font.Color := clBlue;
  HighlightColor := clBlue;
  Hyperlink := True;
  OnClick := NewUserLabelClick;
 end;

 with HelpPanel do
 begin
  Left := 326;
  Top := 220;
  Width := 77;
  Height := 19;
  Anchors := [akRight, akBottom];
  BevelOuter := bvNone;
  ParentColor := True;
  TabOrder := 2;
 end;
 with HelpPaintBox do
 begin
  Left := 0;
  Top := 0;
  Width := 16;
  Height := 16;
  OnPaint := HelpPaintBoxPaint;
 end;
 with HelpLabel do
 begin
  Left := 20;
  Top := 0;
  Width := 56;
  Height := 18;
  Cursor := crHandPoint;
  TabOrder := 0;
  Font.Color := clBlue;
  HighlightColor := clBlue;
  Hyperlink := True;
  OnClick := HelpLabelClick;
 end;

 l_Delta := HelpLabel.Left + HelpLabel.Width + c_ControlBorder - HelpPanel.Width;
 if l_Delta > 0 then
  with HelpPanel do
   SetBounds(Left - l_Delta, Top, Width + l_Delta, Height);
 if NewUserGroupBox.Visible then
 begin
  l_Delta := NewUserLabel.Top + NewUserLabel.Height - lblNewUser.Top;
  if l_Delta > 0 then
  begin
   Height := Height + l_Delta;
   NewUserGroupBox.Height := NewUserGroupBox.Height + l_Delta;
   lblNewUser.Top := lblNewUser.Top + l_Delta
  end;
 end
 else
 begin
  l_Delta := RegisteredGroupBox.Top + RegisteredGroupBox.Height -
   (NewUserGroupBox.Top + NewUserGroupBox.Height);
  if l_Delta <> 0 then
   Height := Height + l_Delta;
 end;
//#UC END# *520B41F90398_4A93D80F014F_impl*
end;//TPrimLoginForm.RepositionControls

constructor TPrimLoginForm.Create(aOwner: TComponent;
  const aLogin: Il3CString;
  aIsAutoLogin: Boolean);
//#UC START# *520B432601B1_4A93D80F014F_var*
//#UC END# *520B432601B1_4A93D80F014F_var*
begin
//#UC START# *520B432601B1_4A93D80F014F_impl*
 inherited Create(aOwner);

 //HelpKeyword := Name;//'nsLoginForm';
 BorderIcons := [biSystemMenu];
 BorderStyle := bsSingle;
 ClientHeight := 245;
 ClientWidth := 409;
 FormStyle := fsStayOnTop;
 OnHide := FormHide;
 OnPaint := vcmEntityFormRefPaint;
 OnShow := FormShow;

 Position := poScreenCenter;
 f_NeedRelogin := False;
 if not l3IsNil(aLogin) then
  ActiveControl := edPassword
 else
  ActiveControl := edUsername;
 f_ForgetPasswordChosen := False;
 f_NewUserChosen := False;
 {$IfDef InsiderTest}
 if TdmStdRes.IsBatchMode then
 begin
  {$IfDef Admin}
  edUserName.Text := l3CStr('ADMIN');
  edPassword.Text := l3CStr('ADMIN');
  {$Else  Admin}
  edUserName.Text := l3CStr('tester');
  edPassword.Text := l3CStr('tester');
  {$EndIf Admin}
 end//TdmStdRes.IsBatchMode
 else
 {$EndIf InsiderTest}
 begin
  edUserName.Text := aLogin;
  //edPassword.Text := aPassword;
 end;//TdmStdRes.IsBatchMode
 {$IfDef nsAutoLoginDisable}
 cbAutoLogin.Enabled := False;
 lblForgetPassword.Enabled := False;
 {$If defined(Monitorings) or defined(Admin)}
 edUserName.ReadOnly := True;
 lblLogin.Enabled := False;
 {$IfEnd not (defined(Monitorings) or defined(Admin))}
 {$If defined(Admin)}
 lblNewUser.Enabled := False;
 NewUserGroupBox.Visible := False;
 {$IfEnd defined(Admin)}
 cbAutoLogin.Checked := False;
 {$Else nsAutoLoginDisable}
 cbAutoLogin.Checked := aIsAutoLogin;
 {$EndIf nsAutoLoginDisable}
 f_ForgetPasswordChosen := False;
 f_NewUserChosen := False;
 LoginEditChange(edUserName);
//#UC END# *520B432601B1_4A93D80F014F_impl*
end;//TPrimLoginForm.Create

constructor TPrimLoginForm.CreateForRelogin(aOwner: TComponent;
  const aLogin: Il3CString;
  const aPassword: Il3CString;
  aIsAutoLogin: Boolean);
//#UC START# *520B43670172_4A93D80F014F_var*
//#UC END# *520B43670172_4A93D80F014F_var*
begin
//#UC START# *520B43670172_4A93D80F014F_impl*
 Create(aOwner, aLogin, aIsAutoLogin);
 edPassword.Text := aPassword;
 f_NeedRelogin := True;
//#UC END# *520B43670172_4A93D80F014F_impl*
end;//TPrimLoginForm.CreateForRelogin

function TPrimLoginForm.pm_GetLogin: Il3CString;
//#UC START# *520B40DD01F1_4A93D80F014Fget_var*
//#UC END# *520B40DD01F1_4A93D80F014Fget_var*
begin
//#UC START# *520B40DD01F1_4A93D80F014Fget_impl*
 Result := edUserName.Text;
//#UC END# *520B40DD01F1_4A93D80F014Fget_impl*
end;//TPrimLoginForm.pm_GetLogin

function TPrimLoginForm.pm_GetPassword: Il3CString;
//#UC START# *520B410301A6_4A93D80F014Fget_var*
//#UC END# *520B410301A6_4A93D80F014Fget_var*
begin
//#UC START# *520B410301A6_4A93D80F014Fget_impl*
 Result := edPassword.Text;
//#UC END# *520B410301A6_4A93D80F014Fget_impl*
end;//TPrimLoginForm.pm_GetPassword

function TPrimLoginForm.pm_GetIsAutoLogin: Boolean;
//#UC START# *520B41310164_4A93D80F014Fget_var*
//#UC END# *520B41310164_4A93D80F014Fget_var*
begin
//#UC START# *520B41310164_4A93D80F014Fget_impl*
 Result := cbAutoLogin.Checked;
//#UC END# *520B41310164_4A93D80F014Fget_impl*
end;//TPrimLoginForm.pm_GetIsAutoLogin

procedure TPrimLoginForm.CMDialogKey(var Message: TCMDialogKey);
//#UC START# *520B41D70270_4A93D80F014F_var*
//#UC END# *520B41D70270_4A93D80F014F_var*
begin
//#UC START# *520B41D70270_4A93D80F014F_impl*
 if (Message.CharCode = vk_Escape) and (fsModal in FormState) then
 begin
  ModalResult := mrCancel;
  Message.Result := 1;
 end
 else
  inherited;
//#UC END# *520B41D70270_4A93D80F014F_impl*
end;//TPrimLoginForm.CMDialogKey

{$If not defined(NoVCL)}
procedure TPrimLoginForm.WndProc(var Message: TMessage);
//#UC START# *47E136A80191_4A93D80F014F_var*
//#UC END# *47E136A80191_4A93D80F014F_var*
begin
//#UC START# *47E136A80191_4A93D80F014F_impl*
 if Message.Msg = g_Relogin then
 begin
  afw.ProcessMessages;
  btnOk.Click;
 end
 else
  inherited;
//#UC END# *47E136A80191_4A93D80F014F_impl*
end;//TPrimLoginForm.WndProc
{$IfEnd} //not NoVCL

{$If not defined(NoVCL)}
procedure TPrimLoginForm.CreateParams(var Params: TCreateParams);
//#UC START# *48C7925A02E5_4A93D80F014F_var*
//#UC END# *48C7925A02E5_4A93D80F014F_var*
begin
//#UC START# *48C7925A02E5_4A93D80F014F_impl*
 inherited;
 with Params do
 begin
  ExStyle := ExStyle or WS_EX_APPWINDOW and not(WS_EX_TOOLWINDOW);
  WndParent := GetDesktopWindow;
 end;
//#UC END# *48C7925A02E5_4A93D80F014F_impl*
end;//TPrimLoginForm.CreateParams
{$IfEnd} //not NoVCL

{$If not defined(NoVCM)}
procedure TPrimLoginForm.InitControls;
//#UC START# *4A8E8F2E0195_4A93D80F014F_var*
//#UC END# *4A8E8F2E0195_4A93D80F014F_var*
begin
//#UC START# *4A8E8F2E0195_4A93D80F014F_impl*

//#UC END# *4A8E8F2E0195_4A93D80F014F_impl*
end;//TPrimLoginForm.InitControls
{$IfEnd} //not NoVCM

{$If not defined(NoVCL)}
function TPrimLoginForm.IsRealInstance: Boolean;
//#UC START# *4B0E846D022B_4A93D80F014F_var*
//#UC END# *4B0E846D022B_4A93D80F014F_var*
begin
//#UC START# *4B0E846D022B_4A93D80F014F_impl*
 Result := True;
//#UC END# *4B0E846D022B_4A93D80F014F_impl*
end;//TPrimLoginForm.IsRealInstance
{$IfEnd} //not NoVCL

{$If not defined(NoVCL)}
function TPrimLoginForm.ShowModal: Integer;
//#UC START# *520B42AF0115_4A93D80F014F_var*
//#UC END# *520B42AF0115_4A93D80F014F_var*
begin
//#UC START# *520B42AF0115_4A93D80F014F_impl*
 f_ForgetPasswordChosen := false;
 f_NewUserChosen := false;
 Result := inherited ShowModal;
//#UC END# *520B42AF0115_4A93D80F014F_impl*
end;//TPrimLoginForm.ShowModal
{$IfEnd} //not NoVCL

procedure TPrimLoginForm.MakeControls;
begin
 inherited;
 f_RegisteredGroupBox := TvtGroupBox.Create(Self);
 f_RegisteredGroupBox.Name := 'RegisteredGroupBox';
 f_RegisteredGroupBox.Parent := Self;
 f_RegisteredGroupBox.Caption := 'Зарегистрированный пользователь';
 f_lblLogin := TvtLabel.Create(Self);
 f_lblLogin.Name := 'lblLogin';
 f_lblLogin.Parent := RegisteredGroupBox;
 f_lblLogin.Caption := 'Регистрационное имя:';
 f_lblPassword := TvtLabel.Create(Self);
 f_lblPassword.Name := 'lblPassword';
 f_lblPassword.Parent := RegisteredGroupBox;
 f_lblPassword.Caption := 'Пароль:';
 f_EnterPaintBox := TPaintBox.Create(Self);
 f_EnterPaintBox.Name := 'EnterPaintBox';
 f_EnterPaintBox.Parent := RegisteredGroupBox;
 f_edUserName := TnscComboBoxWithReadOnly.Create(Self);
 f_edUserName.Name := 'edUserName';
 f_edUserName.Parent := RegisteredGroupBox;
 f_edPassword := TnscComboBoxWithPwdChar.Create(Self);
 f_edPassword.Name := 'edPassword';
 f_edPassword.Parent := RegisteredGroupBox;
 f_lblForgetPassword := TvtFocusLabel.Create(Self);
 f_lblForgetPassword.Name := 'lblForgetPassword';
 f_lblForgetPassword.Parent := RegisteredGroupBox;
 f_lblForgetPassword.Caption := 'Забыли пароль?';
 f_cbAutoLogin := TvtCheckBox.Create(Self);
 f_cbAutoLogin.Name := 'cbAutoLogin';
 f_cbAutoLogin.Parent := RegisteredGroupBox;
 f_cbAutoLogin.Caption := 'Запомнить пароль';
 f_btnOk := TElPopupButton.Create(Self);
 f_btnOk.Name := 'btnOk';
 f_btnOk.Parent := RegisteredGroupBox;
 f_btnOk.Caption := 'Войти в систему';
 f_NewUserGroupBox := TvtGroupBox.Create(Self);
 f_NewUserGroupBox.Name := 'NewUserGroupBox';
 f_NewUserGroupBox.Parent := Self;
 f_NewUserGroupBox.Caption := 'Новый пользователь';
 f_NewUserLabel := TvtLabel.Create(Self);
 f_NewUserLabel.Name := 'NewUserLabel';
 f_NewUserLabel.Parent := NewUserGroupBox;
 f_NewUserLabel.Caption := 'Если Вы впервые входите в систему ГАРАНТ и еще не создали свою учетную запись, зарегистрируйтесь для начала работы.';
 f_NewUserPaintBox := TPaintBox.Create(Self);
 f_NewUserPaintBox.Name := 'NewUserPaintBox';
 f_NewUserPaintBox.Parent := NewUserGroupBox;
 f_lblNewUser := TvtFocusLabel.Create(Self);
 f_lblNewUser.Name := 'lblNewUser';
 f_lblNewUser.Parent := NewUserGroupBox;
 f_lblNewUser.Caption := 'Зарегистрировать нового пользователя';
 f_HelpPanel := TvtPanel.Create(Self);
 f_HelpPanel.Name := 'HelpPanel';
 f_HelpPanel.Parent := Self;
 f_HelpPaintBox := TPaintBox.Create(Self);
 f_HelpPaintBox.Name := 'HelpPaintBox';
 f_HelpPaintBox.Parent := HelpPanel;
 f_HelpLabel := TvtFocusLabel.Create(Self);
 f_HelpLabel.Name := 'HelpLabel';
 f_HelpLabel.Parent := HelpPanel;
 f_HelpLabel.Caption := 'Помощь';
end;

initialization
//#UC START# *520B5769020F*
 g_Relogin := RegisterWindowMessage('{47DA09C5-4047-4A4F-983F-83F787A5E3E0}');
//#UC END# *520B5769020F*
{$If not defined(NoScripts)}
// Регистрация PrimLogin
 TtfwClassRef.Register(TPrimLoginForm);
{$IfEnd} //not NoScripts

end.