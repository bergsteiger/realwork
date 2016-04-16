unit PrimLogin_Form;
 {* Вход в систему ГАРАНТ }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\PrimCommon\Forms\PrimLogin_Form.pas"
// Стереотип: "VCMForm"
// Элемент модели: "PrimLogin" MUID: (4A93D80F014F)
// Имя типа: "TPrimLoginForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmEntityForm
 {$IfEnd} // NOT Defined(NoVCM)
 , Windows
 , l3Interfaces
 , vtGroupBox
 , vtLabel
 {$If NOT Defined(NoVCL)}
 , ExtCtrls
 {$IfEnd} // NOT Defined(NoVCL)
 {$If Defined(Nemesis)}
 , nscComboBoxWithReadOnly
 {$IfEnd} // Defined(Nemesis)
 {$If Defined(Nemesis)}
 , nscComboBox
 {$IfEnd} // Defined(Nemesis)
 , vtFocusLabel
 , vtCheckBox
 , ElPopBtn
 , vtPanel
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 , Classes
 , Messages
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
;

type
 TnsLoginAction = function(aSender: TCustomForm): TModalResult of object;

 TPrimLoginForm = class({$If NOT Defined(NoVCM)}
 TvcmEntityForm
 {$IfEnd} // NOT Defined(NoVCM)
 )
  {* Вход в систему ГАРАНТ }
  private
   f_NeedRelogin: Boolean;
   f_RegisteredGroupBox: TvtGroupBox;
    {* Поле для свойства RegisteredGroupBox }
   f_lblLogin: TvtLabel;
    {* Поле для свойства lblLogin }
   f_lblPassword: TvtLabel;
    {* Поле для свойства lblPassword }
   f_EnterPaintBox: TPaintBox;
    {* Поле для свойства EnterPaintBox }
   f_edUserName: TnscComboBoxWithReadOnly;
    {* Поле для свойства edUserName }
   f_edPassword: TnscComboBoxWithPwdChar;
    {* Поле для свойства edPassword }
   f_lblForgetPassword: TvtFocusLabel;
    {* Поле для свойства lblForgetPassword }
   f_cbAutoLogin: TvtCheckBox;
    {* Поле для свойства cbAutoLogin }
   f_btnOk: TElPopupButton;
    {* Поле для свойства btnOk }
   f_NewUserGroupBox: TvtGroupBox;
    {* Поле для свойства NewUserGroupBox }
   f_NewUserLabel: TvtLabel;
    {* Поле для свойства NewUserLabel }
   f_NewUserPaintBox: TPaintBox;
    {* Поле для свойства NewUserPaintBox }
   f_lblNewUser: TvtFocusLabel;
    {* Поле для свойства lblNewUser }
   f_HelpPanel: TvtPanel;
    {* Поле для свойства HelpPanel }
   f_HelpPaintBox: TPaintBox;
    {* Поле для свойства HelpPaintBox }
   f_HelpLabel: TvtFocusLabel;
    {* Поле для свойства HelpLabel }
   f_ForgetPasswordChosen: Boolean;
    {* Поле для свойства ForgetPasswordChosen }
   f_NewUserChosen: Boolean;
    {* Поле для свойства NewUserChosen }
   f_LoginAction: TnsLoginAction;
    {* Поле для свойства LoginAction }
  private
   procedure FormShow(Sender: TObject);
   procedure FormHide(Sender: TObject);
   procedure ForgetPasswordLabelClick(Sender: TObject);
   procedure LoginEditChange(Sender: TObject);
   procedure NewUserLabelClick(Sender: TObject);
   procedure btnOkClick(Sender: TObject);
   procedure HelpPaintBoxPaint(Sender: TObject);
   procedure HelpLabelClick(Sender: TObject);
   procedure NewUserPaintBoxPaint(Sender: TObject);
   procedure EnterPaintBoxPaint(Sender: TObject);
   procedure vcmEntityFormRefPaint(Sender: TObject);
   procedure Save;
   procedure RepositionControls;
   procedure CMDialogKey(var Message: TCMDialogKey); message CM_DIALOGKEY;
  protected
   function pm_GetLogin: Il3CString;
   function pm_GetPassword: Il3CString;
   function pm_GetIsAutoLogin: Boolean;
   {$If NOT Defined(NoVCL)}
   procedure WndProc(var Message: TMessage); override;
   {$IfEnd} // NOT Defined(NoVCL)
   {$If NOT Defined(NoVCL)}
   procedure CreateParams(var Params: TCreateParams); override;
   {$IfEnd} // NOT Defined(NoVCL)
   {$If NOT Defined(NoVCM)}
   procedure InitControls; override;
    {* Процедура инициализации контролов. Для перекрытия в потомках }
   {$IfEnd} // NOT Defined(NoVCM)
  public
   constructor Create(aOwner: TComponent;
    const aLogin: Il3CString;
    aIsAutoLogin: Boolean); reintroduce;
   constructor CreateForRelogin(aOwner: TComponent;
    const aLogin: Il3CString;
    const aPassword: Il3CString;
    aIsAutoLogin: Boolean); reintroduce;
   {$If NOT Defined(NoVCL)}
   function IsRealInstance: Boolean; override;
   {$IfEnd} // NOT Defined(NoVCL)
   {$If NOT Defined(NoVCL)}
   function ShowModal: Integer; override;
   {$IfEnd} // NOT Defined(NoVCL)
  public
   property RegisteredGroupBox: TvtGroupBox
    read f_RegisteredGroupBox;
    {* Зарегистрированный пользователь }
   property NewUserGroupBox: TvtGroupBox
    read f_NewUserGroupBox;
    {* Новый пользователь }
   property HelpPanel: TvtPanel
    read f_HelpPanel;
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

implementation

uses
 l3ImplUses
 , SysUtils
 , Graphics
 , nsStartupSupport
 , nsFlashWindow
 , DataAdapter
 , SearchRes
 , nsConst
 , l3String
 , afwFacade
 , l3Base
 {$If NOT Defined(NoVCL)}
 , StdCtrls
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

{$If NOT Defined(NoVCM)}
var g_Relogin: THandle;

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

procedure TPrimLoginForm.btnOkClick(Sender: TObject);
//#UC START# *520B3FFC00F0_4A93D80F014F_var*
//#UC END# *520B3FFC00F0_4A93D80F014F_var*
begin
//#UC START# *520B3FFC00F0_4A93D80F014F_impl*
 Save;
//#UC END# *520B3FFC00F0_4A93D80F014F_impl*
end;//TPrimLoginForm.btnOkClick

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

procedure TPrimLoginForm.vcmEntityFormRefPaint(Sender: TObject);
//#UC START# *520B4075004C_4A93D80F014F_var*
//#UC END# *520B4075004C_4A93D80F014F_var*
begin
//#UC START# *520B4075004C_4A93D80F014F_impl*
 {$IfDef InsiderTest}
 if TdmStdRes.IsBatchMode then
  Save;
 {$EndIf InsiderTest}
//#UC END# *520B4075004C_4A93D80F014F_impl*
end;//TPrimLoginForm.vcmEntityFormRefPaint

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

{$If NOT Defined(NoVCL)}
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
{$IfEnd} // NOT Defined(NoVCL)

{$If NOT Defined(NoVCL)}
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
{$IfEnd} // NOT Defined(NoVCL)

procedure TPrimLoginForm.InitControls;
 {* Процедура инициализации контролов. Для перекрытия в потомках }
//#UC START# *4A8E8F2E0195_4A93D80F014F_var*
//#UC END# *4A8E8F2E0195_4A93D80F014F_var*
begin
//#UC START# *4A8E8F2E0195_4A93D80F014F_impl*

//#UC END# *4A8E8F2E0195_4A93D80F014F_impl*
end;//TPrimLoginForm.InitControls

{$If NOT Defined(NoVCL)}
function TPrimLoginForm.IsRealInstance: Boolean;
//#UC START# *4B0E846D022B_4A93D80F014F_var*
//#UC END# *4B0E846D022B_4A93D80F014F_var*
begin
//#UC START# *4B0E846D022B_4A93D80F014F_impl*
 Result := True;
//#UC END# *4B0E846D022B_4A93D80F014F_impl*
end;//TPrimLoginForm.IsRealInstance
{$IfEnd} // NOT Defined(NoVCL)

{$If NOT Defined(NoVCL)}
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
{$IfEnd} // NOT Defined(NoVCL)

initialization
//#UC START# *520B5769020F*
 g_Relogin := RegisterWindowMessage('{47DA09C5-4047-4A4F-983F-83F787A5E3E0}');
//#UC END# *520B5769020F*
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimLoginForm);
 {* Регистрация PrimLogin }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(NoVCM)

end.
