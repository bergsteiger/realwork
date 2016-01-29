unit PrimUserProperty_Form;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Admin/Forms/PrimUserProperty_Form.pas"
// Начат: 27.01.2009 15:50
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMForm::Class>> F1 Администратор::Admin::View::Admin::PrimUserProperty
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If defined(Admin)}
uses
  Classes,
  AdminInterfaces
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
  vtComboBoxQS
  {$If defined(Nemesis)}
  ,
  nscComboBox
  {$IfEnd} //Nemesis
  ,
  vtLabel,
  l3StringIDEx
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  ,
  vtCheckBox,
  PrimUserProperty_admUseProperties_UserType
  {$If not defined(NoVCM)}
  ,
  vcmControllers
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCL)}
  ,
  Forms
  {$IfEnd} //not NoVCL
  ,
  vcmExternalInterfaces {a},
  vcmInterfaces {a}
  ;
{$IfEnd} //Admin

{$If defined(Admin)}
type
 TPrimUserPropertyForm = {form} class(TvcmEntityForm, IbsUserPropertyListener)
 private
 // private fields
   f_PasswordChanged : Boolean;
   f_LockCheckBox : Boolean;
   f_pnMainData : TvtPanel;
    {* Поле для свойства pnMainData}
   f_f_TopPanel : TvtPanel;
    {* Поле для свойства f_TopPanel}
   f_UserNameLabel : TvtLabel;
    {* Поле для свойства UserNameLabel}
   f_PasswordLabel : TvtLabel;
    {* Поле для свойства PasswordLabel}
   f_LoginLabel : TvtLabel;
    {* Поле для свойства LoginLabel}
   f_EMailLabel : TvtLabel;
    {* Поле для свойства EMailLabel}
   f_ConfirmPasswordLabel : TvtLabel;
    {* Поле для свойства ConfirmPasswordLabel}
   f_GroupLabel : TvtLabel;
    {* Поле для свойства GroupLabel}
   f_edPassword : TnscComboBoxWithPwdChar;
    {* Поле для свойства edPassword}
   f_edUserName : TnscEdit;
    {* Поле для свойства edUserName}
   f_edLogin : TnscEdit;
    {* Поле для свойства edLogin}
   f_edEmail : TnscEdit;
    {* Поле для свойства edEmail}
   f_edConfirm : TnscComboBoxWithPwdChar;
    {* Поле для свойства edConfirm}
   f_edGroup : TvtComboBoxQS;
    {* Поле для свойства edGroup}
   f_f_MiddlePanel : TvtPanel;
    {* Поле для свойства f_MiddlePanel}
   f_edPrivilegedUser : TvtCheckBox;
    {* Поле для свойства edPrivilegedUser}
   f_edBuyConsulting : TvtCheckBox;
    {* Поле для свойства edBuyConsulting}
   f_f_DontDeleteIdleUserPanel : TvtPanel;
    {* Поле для свойства f_DontDeleteIdleUserPanel}
   f_edDontDeleteIdleUser : TvtCheckBox;
    {* Поле для свойства edDontDeleteIdleUser}
   f_f_BottomPanel : TvtPanel;
    {* Поле для свойства f_BottomPanel}
   f_InfoLabel : TvtLabel;
    {* Поле для свойства InfoLabel}
   f_edHasSharedFilters : TvtCheckBox;
    {* Поле для свойства edHasSharedFilters}
 protected
  procedure SignalDataSourceChanged(const anOld : IvcmViewAreaController;
                                const aDsNew : IvcmViewAreaController); override;
  procedure MakeControls; override;
 private
 // private methods
   function CheckUnsaved(const aUserProperty: IdsUserProperty): Boolean;
     {* Возвращает признак отсутсвия несохраненных изменений (при необходимости выдавая запрос пользователю) }
   procedure EdLoginChange(Sender: TObject);
     {* TNotifyEvent is used for events that do not require parameters. }
   procedure EdPasswordChange(Sender: TObject);
     {* TNotifyEvent is used for events that do not require parameters. }
   procedure EdConfirmChange(Sender: TObject);
     {* TNotifyEvent is used for events that do not require parameters. }
   procedure EdUserNameChange(Sender: TObject);
     {* TNotifyEvent is used for events that do not require parameters. }
   procedure EdEmailChange(Sender: TObject);
     {* TNotifyEvent is used for events that do not require parameters. }
   procedure EdBuyConsultingClick(Sender: TObject);
     {* TNotifyEvent is used for events that do not require parameters. }
   procedure EdPrivilegedUserClick(Sender: TObject);
     {* TNotifyEvent is used for events that do not require parameters. }
   procedure EdGroupChange(Sender: TObject);
     {* TNotifyEvent is used for events that do not require parameters. }
   procedure EdHasSharedFiltersClick(Sender: TObject);
     {* TNotifyEvent is used for events that do not require parameters. }
   procedure EdDontDeleteIdleUserClick(Sender: TObject);
     {* TNotifyEvent is used for events that do not require parameters. }
   procedure DoCheckUnsavedProperties;
     {* Сигнатура метода DoCheckUnsavedProperties }
   function ShowDontDeleteIdleUsers: Boolean;
   procedure InitUserFields;
     {* Сигнатура метода InitUserFields }
   procedure CheckFields;
     {* Сигнатура метода CheckFields }
 protected
 // realized methods
   procedure CheckUnsavedProperties;
 protected
 // overridden protected methods
   {$If not defined(NoVCM)}
   procedure NotifyDataSourceChanged(const anOld: IvcmViewAreaController;
    const aNew: IvcmViewAreaController); override;
     {* Изменился источник данных. Для перекрытия в потомках }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   function CallCloseQuery(aCaller: TCustomForm): Boolean; override;
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure InitControls; override;
     {* Процедура инициализации контролов. Для перекрытия в потомках }
   {$IfEnd} //not NoVCM
    {$If not defined(NoVCM)}
   procedure SetupFormLayout; override;
     {* Тут можно настроить внешний вид формы }
    {$IfEnd} //not NoVCM
 protected
 // protected fields
   dsUserProperty : IdsUserProperty;
   f_IsCorrectInfo : Boolean;
 protected
 // protected methods
   procedure SaveChangedProfile(const aDataSource: IdsUserProperty);
   procedure RestoreFields;
     {* Сигнатура метода RestoreFields }
 public
 // public properties
   property pnMainData: TvtPanel
     read f_pnMainData;
   property f_TopPanel: TvtPanel
     read f_f_TopPanel;
   property UserNameLabel: TvtLabel
     read f_UserNameLabel;
     {* *ФИО пользователя: }
   property PasswordLabel: TvtLabel
     read f_PasswordLabel;
     {* Пароль: }
   property LoginLabel: TvtLabel
     read f_LoginLabel;
     {* *Регистрационное имя: }
   property EMailLabel: TvtLabel
     read f_EMailLabel;
     {* Электронная почта: }
   property ConfirmPasswordLabel: TvtLabel
     read f_ConfirmPasswordLabel;
     {* Подтверждение пароля: }
   property GroupLabel: TvtLabel
     read f_GroupLabel;
     {* Группа: }
   property edPassword: TnscComboBoxWithPwdChar
     read f_edPassword;
   property edUserName: TnscEdit
     read f_edUserName;
   property edLogin: TnscEdit
     read f_edLogin;
   property edEmail: TnscEdit
     read f_edEmail;
   property edConfirm: TnscComboBoxWithPwdChar
     read f_edConfirm;
   property edGroup: TvtComboBoxQS
     read f_edGroup;
   property f_MiddlePanel: TvtPanel
     read f_f_MiddlePanel;
   property edPrivilegedUser: TvtCheckBox
     read f_edPrivilegedUser;
     {* Привилегированный пользователь }
   property edBuyConsulting: TvtCheckBox
     read f_edBuyConsulting;
     {* Разрешено использование услуги Правового консалтинга }
   property f_DontDeleteIdleUserPanel: TvtPanel
     read f_f_DontDeleteIdleUserPanel;
   property edDontDeleteIdleUser: TvtCheckBox
     read f_edDontDeleteIdleUser;
     {* Не удалять при бездействии }
   property f_BottomPanel: TvtPanel
     read f_f_BottomPanel;
   property InfoLabel: TvtLabel
     read f_InfoLabel;
     {* * - поля, обязательные для заполнения }
   property edHasSharedFilters: TvtCheckBox
     read f_edHasSharedFilters;
     {* Фильтры этого пользователя являются общими }
 end;//TPrimUserPropertyForm

 TvcmEntityFormRef = TPrimUserPropertyForm;
{$IfEnd} //Admin

implementation

{$If defined(Admin)}
uses
  DataAdapter,
  nsGroupTreeStruct,
  l3Base,
  l3String,
  nsUserNodes,
  SecurityUnit,
  nsConst,
  l3Chars,
  nsTypes,
  nsVerifyValue,
  ctTypes
  {$If not defined(NoVCL)}
  ,
  Controls
  {$IfEnd} //not NoVCL
  
  {$If not defined(NoVCM)}
  ,
  vcmBase
  {$IfEnd} //not NoVCM
  ,
  l3MessageID
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  ,
  SysUtils {a},
  StdRes {a}
  ;
{$IfEnd} //Admin

{$If defined(Admin)}

var
   { Локализуемые строки admUsePropertiesLocalConstants }
  str_admUsePropertiesCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'admUsePropertiesCaption'; rValue : 'Свойства пользователя');
   { Заголовок пользовательского типа "Свойства пользователя" }

var
   { Локализуемые строки Hints }
  str_PrimUserProperty_edPasswordHint : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'PrimUserProperty_edPasswordHint'; rValue : 'Новый Пароль: должен совпадать с подтверждением пароля');
   { 'Новый Пароль: должен совпадать с подтверждением пароля' }
  str_PrimUserProperty_edUserNameHint : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'PrimUserProperty_edUserNameHint'; rValue : 'Имя пользователя: не должно быть пустым');
   { 'Имя пользователя: не должно быть пустым' }
  str_PrimUserProperty_edLoginHint : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'PrimUserProperty_edLoginHint'; rValue : 'Новое регистрационное имя');
   { 'Новое регистрационное имя' }
  str_PrimUserProperty_edEmailHint : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'PrimUserProperty_edEmailHint'; rValue : 'Электронная почта: адрес, на который будет выслан забытый Вами пароль');
   { 'Электронная почта: адрес, на который будет выслан забытый Вами пароль' }
  str_PrimUserProperty_edConfirmHint : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'PrimUserProperty_edConfirmHint'; rValue : 'Подтверждение пароля: должно совпадать с новым паролем');
   { 'Подтверждение пароля: должно совпадать с новым паролем' }
  str_PrimUserProperty_edGroupHint : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'PrimUserProperty_edGroupHint'; rValue : 'Группа пользователя');
   { 'Группа пользователя' }

// start class TPrimUserPropertyForm

function TPrimUserPropertyForm.CheckUnsaved(const aUserProperty: IdsUserProperty): Boolean;
//#UC START# *4C8A10120190_497F02D20216_var*
//#UC END# *4C8A10120190_497F02D20216_var*
begin
//#UC START# *4C8A10120190_497F02D20216_impl*
 // Проверяем не изменены ли данные для текущего пользователя
 Result := True;
 // Учитывая, что форма может быть создана фиктивно при работе с настройками
 // панелей инструментов, то CheckUnsaved который вызывается из _CloseQuery
 // подадут пустой _DataSource
 if Assigned(aUserProperty) and aUserProperty.IsChanged then
  // Если изменены - пытаемся их сохранить
  if Ask(qr_UserChanged) then
   if f_IsCorrectInfo then
    SaveChangedProfile(aUserProperty)
   else
   begin
    // Сохранить данные нельзя, т.к. они введены не правильно или не полностью
    Say(err_WrongUserData);
    Result := False;
   end
  else
   Result := False;
//#UC END# *4C8A10120190_497F02D20216_impl*
end;//TPrimUserPropertyForm.CheckUnsaved

procedure TPrimUserPropertyForm.EdLoginChange(Sender: TObject);
//#UC START# *527BD93C01C3_497F02D20216_var*
//#UC END# *527BD93C01C3_497F02D20216_var*
begin
//#UC START# *527BD93C01C3_497F02D20216_impl*
 CheckFields;
//#UC END# *527BD93C01C3_497F02D20216_impl*
end;//TPrimUserPropertyForm.EdLoginChange

procedure TPrimUserPropertyForm.EdPasswordChange(Sender: TObject);
//#UC START# *527BD9440399_497F02D20216_var*
//#UC END# *527BD9440399_497F02D20216_var*
begin
//#UC START# *527BD9440399_497F02D20216_impl*
 f_PasswordChanged := True;
 CheckFields;
//#UC END# *527BD9440399_497F02D20216_impl*
end;//TPrimUserPropertyForm.EdPasswordChange

procedure TPrimUserPropertyForm.EdConfirmChange(Sender: TObject);
//#UC START# *527BD94D0009_497F02D20216_var*
//#UC END# *527BD94D0009_497F02D20216_var*
begin
//#UC START# *527BD94D0009_497F02D20216_impl*
 CheckFields;
//#UC END# *527BD94D0009_497F02D20216_impl*
end;//TPrimUserPropertyForm.EdConfirmChange

procedure TPrimUserPropertyForm.EdUserNameChange(Sender: TObject);
//#UC START# *527BD954035C_497F02D20216_var*
//#UC END# *527BD954035C_497F02D20216_var*
begin
//#UC START# *527BD954035C_497F02D20216_impl*
 CheckFields;
//#UC END# *527BD954035C_497F02D20216_impl*
end;//TPrimUserPropertyForm.EdUserNameChange

procedure TPrimUserPropertyForm.EdEmailChange(Sender: TObject);
//#UC START# *527BD95C03CE_497F02D20216_var*
//#UC END# *527BD95C03CE_497F02D20216_var*
begin
//#UC START# *527BD95C03CE_497F02D20216_impl*
 CheckFields;
//#UC END# *527BD95C03CE_497F02D20216_impl*
end;//TPrimUserPropertyForm.EdEmailChange

procedure TPrimUserPropertyForm.EdBuyConsultingClick(Sender: TObject);
//#UC START# *527BD9660133_497F02D20216_var*
//#UC END# *527BD9660133_497F02D20216_var*
begin
//#UC START# *527BD9660133_497F02D20216_impl*
 if not f_LockCheckBox then
  CheckFields;
//#UC END# *527BD9660133_497F02D20216_impl*
end;//TPrimUserPropertyForm.EdBuyConsultingClick

procedure TPrimUserPropertyForm.EdPrivilegedUserClick(Sender: TObject);
//#UC START# *527BD96D033A_497F02D20216_var*
//#UC END# *527BD96D033A_497F02D20216_var*
begin
//#UC START# *527BD96D033A_497F02D20216_impl*
 if not f_LockCheckBox then
  CheckFields;
//#UC END# *527BD96D033A_497F02D20216_impl*
end;//TPrimUserPropertyForm.EdPrivilegedUserClick

procedure TPrimUserPropertyForm.EdGroupChange(Sender: TObject);
//#UC START# *527BD9750041_497F02D20216_var*
//#UC END# *527BD9750041_497F02D20216_var*
begin
//#UC START# *527BD9750041_497F02D20216_impl*
 // http://mdp.garant.ru/pages/viewpage.action?pageId=268342582
 // переименование группы вело к изменению текста в комбо ->
 // считалось, что св-во пользователя изменилось.
//  l3System.Msg2Log('edGroupChange!!! ' +
//                   'dsUserProperty.HasUserProfile: %s; ' +
//                   'dsUserProperty.GroupUID: %d; ' +
//                   'GetUserID(edGroup.CurrentNode): %d;',
//                   [BoolToStr(dsUserProperty.HasUserProfile, True),
//                    dsUserProperty.GroupUID,
//                    GetUserID(edGroup.CurrentNode)
//                   ]);

 if not dsUserProperty.IsReadOnlyFor268342582 and // not dsUserProperty.IsReadOnly - это "костыль" к К268342582
    dsUserProperty.HasUserProfile and
   (dsUserProperty.GroupUID <> GetUserID(edGroup.CurrentNode)) then
  CheckFields;
//#UC END# *527BD9750041_497F02D20216_impl*
end;//TPrimUserPropertyForm.EdGroupChange

procedure TPrimUserPropertyForm.EdHasSharedFiltersClick(Sender: TObject);
//#UC START# *527BD97D0353_497F02D20216_var*
var
 l_UID: Integer;
 l_Has: Boolean;
//#UC END# *527BD97D0353_497F02D20216_var*
begin
//#UC START# *527BD97D0353_497F02D20216_impl*
 if not f_LockCheckBox then
 begin
  l_UID := dsUserProperty.UID;
  with defDataAdapter.NativeAdapter.MakeUserManager do
  begin
   l_Has := HasSharedFilters(l_UID);
   SetSharedFiltersState(l_UID, not l_Has);
   l_Has := HasSharedFilters(l_UID);
   edHasSharedFilters.Checked := l_Has;
  end;//with defDataAdapter.NativeAdapter.MakeUserManager
 end;//not f_LockCheckBox
//#UC END# *527BD97D0353_497F02D20216_impl*
end;//TPrimUserPropertyForm.EdHasSharedFiltersClick

procedure TPrimUserPropertyForm.EdDontDeleteIdleUserClick(Sender: TObject);
//#UC START# *527BD9860158_497F02D20216_var*
//#UC END# *527BD9860158_497F02D20216_var*
begin
//#UC START# *527BD9860158_497F02D20216_impl*
 if not f_LockCheckBox then
  CheckFields;
//#UC END# *527BD9860158_497F02D20216_impl*
end;//TPrimUserPropertyForm.EdDontDeleteIdleUserClick

procedure TPrimUserPropertyForm.DoCheckUnsavedProperties;
//#UC START# *527BDA0E0133_497F02D20216_var*
//#UC END# *527BDA0E0133_497F02D20216_var*
begin
//#UC START# *527BDA0E0133_497F02D20216_impl*
 if not CheckUnsaved(dsUserProperty) then
  RestoreFields;
//#UC END# *527BDA0E0133_497F02D20216_impl*
end;//TPrimUserPropertyForm.DoCheckUnsavedProperties

function TPrimUserPropertyForm.ShowDontDeleteIdleUsers: Boolean;
//#UC START# *527BDB0900E7_497F02D20216_var*
//#UC END# *527BDB0900E7_497F02D20216_var*
begin
//#UC START# *527BDB0900E7_497F02D20216_impl*
 Result := defDataAdapter.CommonInterfaces.IsEraseOfInactiveUsersEnabled;
//#UC END# *527BDB0900E7_497F02D20216_impl*
end;//TPrimUserPropertyForm.ShowDontDeleteIdleUsers

procedure TPrimUserPropertyForm.InitUserFields;
//#UC START# *527BDB1F021C_497F02D20216_var*
 procedure lp_SetupEnabled(const aEnabled: Boolean);
 begin
  edPassword.Enabled := aEnabled;
  edConfirm.Enabled := aEnabled;
  edLogin.Enabled := aEnabled;
  edUserName.Enabled := aEnabled;
  edEmail.Enabled := aEnabled;
  edBuyConsulting.Enabled := aEnabled;
  edPrivilegedUser.Enabled := aEnabled and defDataAdapter.PrivelegedUsersAllowed;
  edDontDeleteIdleUser.Enabled := aEnabled and not dsUserProperty.IsNewUser;
  edGroup.Enabled := aEnabled;
 end;

 procedure lp_ClearFileds;
 begin
  edPassword.Text := nil;
  edConfirm.Text := nil;
  edLogin.Text := nil;
  edUserName.Text := nil;
  edEmail.Text := nil;
 end;
//#UC END# *527BDB1F021C_497F02D20216_var*
begin
//#UC START# *527BDB1F021C_497F02D20216_impl*
 try
  f_PasswordChanged := False;

  lp_SetupEnabled(Assigned(dsUserProperty));
  if not Assigned(dsUserProperty) then
   begin
    lp_ClearFileds;
    edGroup.CurrentNode := nil;
    Exit;
   end;

  if dsUserProperty.IsNewUser then
  begin
   CCaption := vcmCStr(str_CreateUserFormCaption);
   f_IsCorrectInfo := False;
  end
  else
  begin
   CCaption := vcmCStr(str_UsualUserFormCaption);
   f_IsCorrectInfo := True;
  end;

  edLogin.TextValid := True;
  edPassword.TextValid := True;
  edEmail.TextValid := True;
  edConfirm.TextValid := True;
  f_LockCheckBox := True;
  try
   edBuyConsulting.Checked := dsUserProperty.CanBuyConsulting;
   edBuyConsulting.Enabled := not dsUserProperty.IsSystem;
   edPrivilegedUser.Checked := dsUserProperty.IsPrivileged;
   edPrivilegedUser.Enabled := not dsUserProperty.IsSystem and defDataAdapter.PrivelegedUsersAllowed;

   f_DontDeleteIdleUserPanel.Visible := ShowDontDeleteIdleUsers;

   edDontDeleteIdleUser.Checked := dsUserProperty.IsSystem or dsUserProperty.DontDeleteIdle;
   edDontDeleteIdleUser.Enabled := not dsUserProperty.IsSystem;
   edHasSharedFilters.Checked := defDataAdapter.NativeAdapter.MakeUserManager.HasSharedFilters(dsUserProperty.UID);
  finally
   f_LockCheckBox := False;
  end;//try..finally
  if dsUserProperty.HasUserProfile then
  begin
   if dsUserProperty.HasPassword then
   begin
    edPassword.Text := nsCStr(cHasPassword);
    edConfirm.Text := nsCStr(cHasPassword);
   end
   else
   begin
    edPassword.Text := nil;
    edConfirm.Text := nil;
   end;
   edPassword.Enabled := True;
   edConfirm.Enabled := True;

   edLogin.Text := dsUserProperty.Login;
   edLogin.Enabled := dsUserProperty.IsNewUser;
   edUserName.Text := dsUserProperty.Name;
   edUserName.Enabled := True;
   edEmail.Text := dsUserProperty.Mail;
   edEmail.Enabled := True;

   edGroup.Enabled := not dsUserProperty.IsSystem;
  end
  else
  begin
   lp_ClearFileds;
   lp_SetupEnabled(dsUserProperty.IsNewUser);
  end;
  edGroup.CUrrentNode := GetUserByID(dsUserProperty.GroupUID, edGroup.TreeStruct);
 finally
  edPassword.ClearUndoRedoLists;
  edConfirm.ClearUndoRedoLists;
  edLogin.ClearUndoRedoLists;
  edUserName.ClearUndoRedoLists;
  edEmail.ClearUndoRedoLists;
  edGroup.ClearUndoRedoLists;
 end;
//#UC END# *527BDB1F021C_497F02D20216_impl*
end;//TPrimUserPropertyForm.InitUserFields

procedure TPrimUserPropertyForm.CheckFields;
//#UC START# *527BDB2A0394_497F02D20216_var*
//#UC END# *527BDB2A0394_497F02D20216_var*
begin
//#UC START# *527BDB2A0394_497F02D20216_impl*
 //l3System.Stack2Log;

 dsUserProperty.IsChanged := True;

 // Подсветим красным
 edLogin.TextValid := nsLoginVerify.Verify(edLogin.Text);
 edPassword.TextValid := nsPasswordVerify.Verify(edPassword.Text);
 edEmail.TextValid := nsEmailVerify.Verify(edEmail.Text);
 edConfirm.TextValid := nsPasswordVerify.Verify(edConfirm.Text) and
                        l3Same(edConfirm.Text, edPassword.Text);

 f_IsCorrectInfo := not l3IsNil(edLogin.Text) and
                    not l3ISNil(edUserName.Text) and
                    edLogin.TextValid and
                    edPassword.TextValid and
                    edConfirm.TextValid and
                    (l3IsNil(edEmail.Text) or
                     edEmail.TextValid);
//#UC END# *527BDB2A0394_497F02D20216_impl*
end;//TPrimUserPropertyForm.CheckFields

procedure TPrimUserPropertyForm.SaveChangedProfile(const aDataSource: IdsUserProperty);
//#UC START# *4C8A0FEE00C1_497F02D20216_var*
//#UC END# *4C8A0FEE00C1_497F02D20216_var*
begin
//#UC START# *4C8A0FEE00C1_497F02D20216_impl*
 if aDataSource.IsNewUser then
 begin
  try
   aDataSource.CreateUserProfile(l3PCharLen(edLogin.Text),
                                 l3PCharLen(edUserName.Text),
                                 l3PCharLen(edEmail.Text),
                                 l3PCharLen(edPassword.Text),
                                 edBuyConsulting.Checked,
                                 edPrivilegedUser.Checked,
                                 GetUserID(edGroup.CurrentNode));
   RestoreFields;
   aDataSource.CreateUserFinished(True);
  except
   on ELoginDuplicate do
    Say(war_LoginDuplicate, [edLogin.Text]);
   on EWrongAuthentication do
    Say(err_WrongAuthentification);
   on EXMLImportRunning do
    Say(inf_XMLImportRunning);
   on ENoMoreProfiles do
    Say(err_UsersLicenceViolation);
   on ENoMorePrivilegedProfiles do
    Say(err_PrivilegedUsersLicenceViolation);
  end;
 end else
 if l3Same(edPassword.Text, cHasPassword) then
 try
  aDataSource.SaveUserProfile(l3PCharLen(edUserName.Text),
                              l3PCharLen(edEmail.Text),
                              edBuyConsulting.Checked,
                              edPrivilegedUser.Checked,
                              edDontDeleteIdleUser.Checked,
                              cc_EmptyStr,
                              GetUserID(edGroup.CurrentNode))
 except
  on ENoMoreProfiles do
   Say(err_UsersLicenceViolation);
  on ENoMorePrivilegedProfiles do
   Say(err_PrivilegedUsersLicenceViolation);
 end else
 try
  aDataSource.SaveUserProfile(l3PCharLen(edUserName.Text),
                              l3PCharLen(edEmail.Text),
                              edBuyConsulting.Checked,
                              edPrivilegedUser.Checked,
                              edDontDeleteIdleUser.Checked,
                              l3PCharLen(edPassword.Text),
                              GetUserID(edGroup.CurrentNode),
                              f_PasswordChanged);
 except
  on ENoMoreProfiles do
   Say(err_UsersLicenceViolation);
  on ENoMorePrivilegedProfiles do
   Say(err_PrivilegedUsersLicenceViolation);
 end;
//#UC END# *4C8A0FEE00C1_497F02D20216_impl*
end;//TPrimUserPropertyForm.SaveChangedProfile

procedure TPrimUserPropertyForm.RestoreFields;
//#UC START# *4C8A12540363_497F02D20216_var*
//#UC END# *4C8A12540363_497F02D20216_var*
begin
//#UC START# *4C8A12540363_497F02D20216_impl*
 if Assigned(dsUserProperty) then
  dsUserProperty.IsChanged := False;
 InitUserFields;
//#UC END# *4C8A12540363_497F02D20216_impl*
end;//TPrimUserPropertyForm.RestoreFields

procedure TPrimUserPropertyForm.CheckUnsavedProperties;
//#UC START# *49F6DC2600C0_497F02D20216_var*
//#UC END# *49F6DC2600C0_497F02D20216_var*
begin
//#UC START# *49F6DC2600C0_497F02D20216_impl*
 DoCheckUnsavedProperties;
//#UC END# *49F6DC2600C0_497F02D20216_impl*
end;//TPrimUserPropertyForm.CheckUnsavedProperties

{$If not defined(NoVCM)}
procedure TPrimUserPropertyForm.NotifyDataSourceChanged(const anOld: IvcmViewAreaController;
  const aNew: IvcmViewAreaController);
//#UC START# *497469C90140_497F02D20216_var*
var
 l_DataSource: IdsUserProperty;
//#UC END# *497469C90140_497F02D20216_var*
begin
//#UC START# *497469C90140_497F02D20216_impl*
 inherited;
 if (anOld <> nil) then
  anOld.Unsubscribe(IbsUserPropertyListener(Self));
 if (aNew <> nil) then
  aNew.Subscribe(IbsUserPropertyListener(Self));

 // Проверяем не изменены ли данные для текущего пользователя
 if Supports(anOld, IdsUserProperty, l_DataSource) then
  CheckUnsaved(l_DataSource);

 if (dsUserProperty <> nil) then
  InitUserFields
 else
  f_IsCorrectInfo := false
//#UC END# *497469C90140_497F02D20216_impl*
end;//TPrimUserPropertyForm.NotifyDataSourceChanged
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
function TPrimUserPropertyForm.CallCloseQuery(aCaller: TCustomForm): Boolean;
//#UC START# *4980407F0076_497F02D20216_var*
//#UC END# *4980407F0076_497F02D20216_var*
begin
//#UC START# *4980407F0076_497F02D20216_impl*
 if not defDataAdapter.InTerminateProcess then
  // Проверяем не изменены ли данные для текущего пользователя
  DoCheckUnsavedProperties;
 Result := True;
//#UC END# *4980407F0076_497F02D20216_impl*
end;//TPrimUserPropertyForm.CallCloseQuery
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimUserPropertyForm.InitControls;
//#UC START# *4A8E8F2E0195_497F02D20216_var*
//#UC END# *4A8E8F2E0195_497F02D20216_var*
begin
//#UC START# *4A8E8F2E0195_497F02D20216_impl*
 inherited;
 with pnMainData do
 begin
  Width := 582;
  Height := 238;
  Align := alClient;
  BevelOuter := bvNone;
 end;
  with f_TopPanel do
  begin
   Left := 0;
   Top := 0;
   Width := 582;
   Height := 153;
   Align := alTop;
   BevelOuter := bvNone;
  end;
   with UserNameLabel do
   begin
    AutoSize := False;
    Left := 0;
    Top := 81;
    Width := 182;
    Height := 17;
    Alignment := taRightJustify;
   end;
   with PasswordLabel do
   begin
    AutoSize := False;
    Left := 0;
    Top := 33;
    Width := 182;
    Height := 17;
    Alignment := taRightJustify;
   end;
   with LoginLabel do
   begin
    AutoSize := False;
    Left := 0;
    Top := 9;
    Width := 182;
    Height := 17;
    Alignment := taRightJustify;
   end;
   with EMailLabel do
   begin
    AutoSize := False;
    Left := 0;
    Top := 105;
    Width := 182;
    Height := 17;
    Alignment := taRightJustify;
   end;
   with ConfirmPasswordLabel do
   begin
    AutoSize := False;
    Left := 0;
    Top := 57;
    Width := 182;
    Height := 17;
    Alignment := taRightJustify;
   end;
   with GroupLabel do
   begin
    AutoSize := False;
    Left := 0;
    Top := 129;
    Width := 182;
    Height := 17;
    Alignment := taRightJustify;
   end;
   with edLogin do
   begin
    Left := 194;
    Top := 8;
    Width := 382;
    Height := 21;
    Hint := str_PrimUserProperty_edLoginHint.AsStr;
    OnChange := edLoginChange;
    TabOrder := 0;
    ParentShowHint := False;
    ShowHint := True;
    MaxLength := 31;
   end;
   with edPassword do
   begin
    Left := 194;
    Top := 32;
    Width := 382;
    Height := 21;
    Hint := str_PrimUserProperty_edPasswordHint.AsStr;
    OnChange := edPasswordChange;
    TabOrder := 1;
    ParentShowHint := False;
    ShowHint := True;
    MaxLength := 255;
    PasswordChar := '*';
   end;
   with edConfirm do
   begin
    Left := 194;
    Top := 56;
    Width := 382;
    Height := 21;
    Hint := str_PrimUserProperty_edConfirmHint.AsStr;
    OnChange := edConfirmChange;
    TabOrder := 2;
    ParentShowHint := False;
    ShowHint := True;
    MaxLength := 255;
    PasswordChar := '*';
   end;
   with edUserName do
   begin
    Left := 194;
    Top := 80;
    Width := 382;
    Height := 21;
    Hint := str_PrimUserProperty_edUserNameHint.AsStr;
    OnChange := edUserNameChange;
    TabOrder := 3;
    ParentShowHint := False;
    ShowHint := True;
   end;
   with edEmail do
   begin
    Left := 194;
    Top := 104;
    Width := 382;
    Height := 21;
    Hint := str_PrimUserProperty_edEmailHint.AsStr;
    OnChange := edEmailChange;
    TabOrder := 4;
    ParentShowHint := False;
    ShowHint := True;
   end;
   with edGroup do
   begin
    Left := 194;
    Top := 128;
    Width := 382;
    Height := 21;
    Hint := str_PrimUserProperty_edGroupHint.AsStr;
    OnChange := edGroupChange;
    ParentShowHint := False;
    ShowHint := True;
    TabOrder := 5;
    ComboStyle := ct_cbDropDownList;
   end;
  with f_MiddlePanel do
  begin
   Align := alTop;
   Top := 154;
   Height := 34;
   BevelOuter := bvNone;
   TabOrder := 1;
  end;
   with edPrivilegedUser do
   begin
    Left := 194;
    Top := 0;
    Width := 346;
    Height := 17;
    OnClick := edPrivilegedUserClick;
   end;
   with edBuyConsulting do
   begin
    Left := 194;
    Top := 17;
    Width := 376;
    Height := 17;
    OnClick := edBuyConsultingClick;
   end;
  with f_DontDeleteIdleUserPanel do
  begin
   Left := 0;
   Top := 187;
   Width := 582;
   Height := 17;
   Align := alTop;
   BevelOuter := bvNone;
   TabOrder := 2;
  end;
   with edDontDeleteIdleUser do
   begin
    Left := 194;
    Top := 0;
    Width := 346;
    Height := 17;
    TabOrder := 0;
    OnClick := edDontDeleteIdleUserClick;
   end;
  with f_BottomPanel do
  begin
   Align := alTop;
   Top := 205;
   Height := 34;
   BevelOuter := bvNone;
   TabOrder := 3;
  end;
   with InfoLabel do
   begin
    AutoSize := False;
    Left := 8;
    Top := 17;
    Width := 505;
    Height := 17;
    Alignment := taRightJustify;
   end;
   with edHasSharedFilters do
   begin
    Left := 194;
    Top := 0;
    Width := 346;
    Height := 17;
    TabOrder := 0;
    OnClick := edHasSharedFiltersClick;
   end;
 edGroup.SetSimpleTree(TnsGroupTreeStruct.Make(defDataAdapter.GetGroupsTree, False));
//#UC END# *4A8E8F2E0195_497F02D20216_impl*
end;//TPrimUserPropertyForm.InitControls
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimUserPropertyForm.SetupFormLayout;
//#UC START# *529332B40230_497F02D20216_var*
//#UC END# *529332B40230_497F02D20216_var*
begin
//#UC START# *529332B40230_497F02D20216_impl*
 inherited;
 Width := 598;
 Height := 276;
//#UC END# *529332B40230_497F02D20216_impl*
end;//TPrimUserPropertyForm.SetupFormLayout
{$IfEnd} //not NoVCM

procedure TPrimUserPropertyForm.SignalDataSourceChanged(const anOld : IvcmViewAreaController;
 const aDsNew : IvcmViewAreaController);
begin
 inherited;
 if (aDsNew = nil) then
 begin
  dsUserProperty := nil;
 end//aDsNew = nil
 else
 begin
  Supports(aDsNew, IdsUserProperty, dsUserProperty);
 end;//aDsNew = nil
end;

procedure TPrimUserPropertyForm.MakeControls;
begin
 inherited;
 with AddUsertype(admUsePropertiesName,
  str_admUsePropertiesCaption,
  str_admUsePropertiesCaption,
  true,
  -1,
  -1,
  '',
  nil,
  nil,
  nil,
  vcm_ccDisable) do
 begin
 end;//with AddUsertype(admUsePropertiesName
 f_pnMainData := TvtPanel.Create(Self);
 f_pnMainData.Name := 'pnMainData';
 f_pnMainData.Parent := Self;
 f_f_TopPanel := TvtPanel.Create(Self);
 f_f_TopPanel.Name := 'f_TopPanel';
 f_f_TopPanel.Parent := pnMainData;
 f_UserNameLabel := TvtLabel.Create(Self);
 f_UserNameLabel.Name := 'UserNameLabel';
 f_UserNameLabel.Parent := f_TopPanel;
 f_UserNameLabel.Caption := '*ФИО пользователя:';
 f_PasswordLabel := TvtLabel.Create(Self);
 f_PasswordLabel.Name := 'PasswordLabel';
 f_PasswordLabel.Parent := f_TopPanel;
 f_PasswordLabel.Caption := 'Пароль:';
 f_LoginLabel := TvtLabel.Create(Self);
 f_LoginLabel.Name := 'LoginLabel';
 f_LoginLabel.Parent := f_TopPanel;
 f_LoginLabel.Caption := '*Регистрационное имя:';
 f_EMailLabel := TvtLabel.Create(Self);
 f_EMailLabel.Name := 'EMailLabel';
 f_EMailLabel.Parent := f_TopPanel;
 f_EMailLabel.Caption := 'Электронная почта:';
 f_ConfirmPasswordLabel := TvtLabel.Create(Self);
 f_ConfirmPasswordLabel.Name := 'ConfirmPasswordLabel';
 f_ConfirmPasswordLabel.Parent := f_TopPanel;
 f_ConfirmPasswordLabel.Caption := 'Подтверждение пароля:';
 f_GroupLabel := TvtLabel.Create(Self);
 f_GroupLabel.Name := 'GroupLabel';
 f_GroupLabel.Parent := f_TopPanel;
 f_GroupLabel.Caption := 'Группа:';
 f_edPassword := TnscComboBoxWithPwdChar.Create(Self);
 f_edPassword.Name := 'edPassword';
 f_edPassword.Parent := f_TopPanel;
 f_edUserName := TnscEdit.Create(Self);
 f_edUserName.Name := 'edUserName';
 f_edUserName.Parent := f_TopPanel;
 f_edLogin := TnscEdit.Create(Self);
 f_edLogin.Name := 'edLogin';
 f_edLogin.Parent := f_TopPanel;
 f_edEmail := TnscEdit.Create(Self);
 f_edEmail.Name := 'edEmail';
 f_edEmail.Parent := f_TopPanel;
 f_edConfirm := TnscComboBoxWithPwdChar.Create(Self);
 f_edConfirm.Name := 'edConfirm';
 f_edConfirm.Parent := f_TopPanel;
 f_edGroup := TvtComboBoxQS.Create(Self);
 f_edGroup.Name := 'edGroup';
 f_edGroup.Parent := f_TopPanel;
 f_f_MiddlePanel := TvtPanel.Create(Self);
 f_f_MiddlePanel.Name := 'f_MiddlePanel';
 f_f_MiddlePanel.Parent := pnMainData;
 f_edPrivilegedUser := TvtCheckBox.Create(Self);
 f_edPrivilegedUser.Name := 'edPrivilegedUser';
 f_edPrivilegedUser.Parent := f_MiddlePanel;
 f_edPrivilegedUser.Caption := 'Привилегированный пользователь';
 f_edBuyConsulting := TvtCheckBox.Create(Self);
 f_edBuyConsulting.Name := 'edBuyConsulting';
 f_edBuyConsulting.Parent := f_MiddlePanel;
 f_edBuyConsulting.Caption := 'Разрешено использование услуги Правового консалтинга';
 f_f_DontDeleteIdleUserPanel := TvtPanel.Create(Self);
 f_f_DontDeleteIdleUserPanel.Name := 'f_DontDeleteIdleUserPanel';
 f_f_DontDeleteIdleUserPanel.Parent := pnMainData;
 f_edDontDeleteIdleUser := TvtCheckBox.Create(Self);
 f_edDontDeleteIdleUser.Name := 'edDontDeleteIdleUser';
 f_edDontDeleteIdleUser.Parent := f_DontDeleteIdleUserPanel;
 f_edDontDeleteIdleUser.Caption := 'Не удалять при бездействии';
 f_f_BottomPanel := TvtPanel.Create(Self);
 f_f_BottomPanel.Name := 'f_BottomPanel';
 f_f_BottomPanel.Parent := pnMainData;
 f_InfoLabel := TvtLabel.Create(Self);
 f_InfoLabel.Name := 'InfoLabel';
 f_InfoLabel.Parent := f_BottomPanel;
 f_InfoLabel.Caption := '* - поля, обязательные для заполнения';
 f_edHasSharedFilters := TvtCheckBox.Create(Self);
 f_edHasSharedFilters.Name := 'edHasSharedFilters';
 f_edHasSharedFilters.Parent := f_BottomPanel;
 f_edHasSharedFilters.Caption := 'Фильтры этого пользователя являются общими';
end;

{$IfEnd} //Admin

initialization
{$If defined(Admin)}
// Инициализация str_admUsePropertiesCaption
 str_admUsePropertiesCaption.Init;
{$IfEnd} //Admin
{$If defined(Admin)}
// Инициализация str_PrimUserProperty_edPasswordHint
 str_PrimUserProperty_edPasswordHint.Init;
{$IfEnd} //Admin
{$If defined(Admin)}
// Инициализация str_PrimUserProperty_edUserNameHint
 str_PrimUserProperty_edUserNameHint.Init;
{$IfEnd} //Admin
{$If defined(Admin)}
// Инициализация str_PrimUserProperty_edLoginHint
 str_PrimUserProperty_edLoginHint.Init;
{$IfEnd} //Admin
{$If defined(Admin)}
// Инициализация str_PrimUserProperty_edEmailHint
 str_PrimUserProperty_edEmailHint.Init;
{$IfEnd} //Admin
{$If defined(Admin)}
// Инициализация str_PrimUserProperty_edConfirmHint
 str_PrimUserProperty_edConfirmHint.Init;
{$IfEnd} //Admin
{$If defined(Admin)}
// Инициализация str_PrimUserProperty_edGroupHint
 str_PrimUserProperty_edGroupHint.Init;
{$IfEnd} //Admin
{$If defined(Admin) AND not defined(NoScripts)}
// Регистрация PrimUserProperty
 TtfwClassRef.Register(TPrimUserPropertyForm);
{$IfEnd} //Admin AND not NoScripts

end.