{$IfNDef nsUserPropertyImpl_imp}

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Data\Users\nsUserPropertyImpl.imp.pas"
// Стереотип: "Impurity"
// Элемент модели: "nsUserPropertyImpl" MUID: (4B50388A00E5)
// Имя типа: "_nsUserPropertyImpl_"

{$Define nsUserPropertyImpl_imp}

 _nsUserPropertyImpl_ = class(_nsUserPropertyImpl_Parent_)
  private
   f_Profile: IUserProfile;
   f_Changed: Boolean;
   f_NewUser: Boolean;
  protected
   function DefaultGroupID: Integer; virtual; abstract;
   procedure SetProfileData(const aProfile: IUserProfile;
    aChanged: Boolean;
    aNewUser: Boolean);
   procedure ClearNewUser; virtual;
   function Get_UID: Integer;
   function Get_GroupUID: Integer;
   function Get_Login: Il3CString;
   function Get_Name: Il3CString;
   function Get_Mail: Il3CString;
   function Get_IsChanged: Boolean;
   procedure Set_IsChanged(aValue: Boolean);
   function Get_IsNewUser: Boolean;
   function Get_CanBuyConsulting: Boolean;
   function Get_IsSystem: Boolean;
   function Get_IsPrivileged: Boolean;
   function Get_DontDeleteIdle: Boolean;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   function HasUserProfile: Boolean;
   function HasPassword: Boolean;
   procedure SaveUserProfile(const aName: Tl3WString;
    const aMail: Tl3WString;
    aCanBuyConsulting: Boolean;
    aIsPrivileged: Boolean;
    aDontDeleteIdle: Boolean;
    const aPassword: Tl3WString;
    aGroupUID: Integer;
    IsPasswordChanged: Boolean = False);
   procedure SaveUserInfo(const aName: Tl3WString;
    const aMail: Tl3WString;
    const aPassword: Tl3WString;
    IsPasswordChanged: Boolean = False);
 end;//_nsUserPropertyImpl_

{$Else nsUserPropertyImpl_imp}

{$IfNDef nsUserPropertyImpl_imp_impl}

{$Define nsUserPropertyImpl_imp_impl}

procedure _nsUserPropertyImpl_.SetProfileData(const aProfile: IUserProfile;
 aChanged: Boolean;
 aNewUser: Boolean);
//#UC START# *4B5047BC003A_4B50388A00E5_var*
//#UC END# *4B5047BC003A_4B50388A00E5_var*
begin
//#UC START# *4B5047BC003A_4B50388A00E5_impl*
 f_Profile := aProfile;
 f_Changed := aChanged;
 f_NewUser := aNewUser;
//#UC END# *4B5047BC003A_4B50388A00E5_impl*
end;//_nsUserPropertyImpl_.SetProfileData

procedure _nsUserPropertyImpl_.ClearNewUser;
//#UC START# *4B5049D901A9_4B50388A00E5_var*
//#UC END# *4B5049D901A9_4B50388A00E5_var*
begin
//#UC START# *4B5049D901A9_4B50388A00E5_impl*
 f_NewUser := False;
 f_Changed := False;
//#UC END# *4B5049D901A9_4B50388A00E5_impl*
end;//_nsUserPropertyImpl_.ClearNewUser

function _nsUserPropertyImpl_.HasUserProfile: Boolean;
//#UC START# *4B5025A002EE_4B50388A00E5_var*
//#UC END# *4B5025A002EE_4B50388A00E5_var*
begin
//#UC START# *4B5025A002EE_4B50388A00E5_impl*
 Result := Assigned(f_Profile);
//#UC END# *4B5025A002EE_4B50388A00E5_impl*
end;//_nsUserPropertyImpl_.HasUserProfile

function _nsUserPropertyImpl_.HasPassword: Boolean;
//#UC START# *4B5025A700F0_4B50388A00E5_var*
//#UC END# *4B5025A700F0_4B50388A00E5_var*
begin
//#UC START# *4B5025A700F0_4B50388A00E5_impl*
 if HasUserProfile then
  Result := f_Profile.HasPassword
 else
  Result := False;
//#UC END# *4B5025A700F0_4B50388A00E5_impl*
end;//_nsUserPropertyImpl_.HasPassword

procedure _nsUserPropertyImpl_.SaveUserProfile(const aName: Tl3WString;
 const aMail: Tl3WString;
 aCanBuyConsulting: Boolean;
 aIsPrivileged: Boolean;
 aDontDeleteIdle: Boolean;
 const aPassword: Tl3WString;
 aGroupUID: Integer;
 IsPasswordChanged: Boolean = False);
//#UC START# *4B5026560312_4B50388A00E5_var*
var
 l_UserManager: IUserManager;
//#UC END# *4B5026560312_4B50388A00E5_var*
begin
//#UC START# *4B5026560312_4B50388A00E5_impl*
 l_UserManager := defDataAdapter.NativeAdapter.MakeUserManager;
 try
  l_UserManager.ChangeUserInfo(Get_UID, nsAStr(aName).S, nsAStr(aMail).S);
  if IsPasswordChanged then
   l_UserManager.ChangeUserPassword(Get_UID, nsAStr(aPassword).S);
  l_UserManager.UserCanBuyConsulting(Get_UID, aCanBuyConsulting);
  l_UserManager.UserIsPrivileged(Get_UID, aIsPrivileged);
  l_UserManager.SetErasableState(Get_UID, not aDontDeleteIdle);
  l_UserManager.ChangeUserGroup(Get_UID, aGroupUID);
 finally
  l_UserManager := nil;
 end;
 f_Changed := False;
//#UC END# *4B5026560312_4B50388A00E5_impl*
end;//_nsUserPropertyImpl_.SaveUserProfile

function _nsUserPropertyImpl_.Get_UID: Integer;
//#UC START# *4B5026E201E6_4B50388A00E5get_var*
//#UC END# *4B5026E201E6_4B50388A00E5get_var*
begin
//#UC START# *4B5026E201E6_4B50388A00E5get_impl*
 if HasUserProfile then
  Result := f_Profile.GetUID
 else
  Result := cBadUID;
//#UC END# *4B5026E201E6_4B50388A00E5get_impl*
end;//_nsUserPropertyImpl_.Get_UID

function _nsUserPropertyImpl_.Get_GroupUID: Integer;
//#UC START# *4B5026F60253_4B50388A00E5get_var*
//#UC END# *4B5026F60253_4B50388A00E5get_var*
begin
//#UC START# *4B5026F60253_4B50388A00E5get_impl*
 if HasUserProfile then
  Result := f_Profile.GetGroupId
 else
  Result := DefaultGroupID;
//#UC END# *4B5026F60253_4B50388A00E5get_impl*
end;//_nsUserPropertyImpl_.Get_GroupUID

function _nsUserPropertyImpl_.Get_Login: Il3CString;
//#UC START# *4B5026FD015E_4B50388A00E5get_var*
var
 l_Str: IString;
//#UC END# *4B5026FD015E_4B50388A00E5get_var*
begin
//#UC START# *4B5026FD015E_4B50388A00E5get_impl*
 if HasUserProfile then
  f_Profile.GetLogin(l_Str)
 else
  l_Str := nil;
 Result := nsCStr(l_Str);
//#UC END# *4B5026FD015E_4B50388A00E5get_impl*
end;//_nsUserPropertyImpl_.Get_Login

function _nsUserPropertyImpl_.Get_Name: Il3CString;
//#UC START# *4B502705014F_4B50388A00E5get_var*
var
 l_Str: IString;
//#UC END# *4B502705014F_4B50388A00E5get_var*
begin
//#UC START# *4B502705014F_4B50388A00E5get_impl*
 if HasUserProfile then
  f_Profile.GetName(l_Str)
 else
  l_Str := nil;
 Result := nsCStr(l_Str);
//#UC END# *4B502705014F_4B50388A00E5get_impl*
end;//_nsUserPropertyImpl_.Get_Name

function _nsUserPropertyImpl_.Get_Mail: Il3CString;
//#UC START# *4B50270B0138_4B50388A00E5get_var*
var
 l_Str: IString;
//#UC END# *4B50270B0138_4B50388A00E5get_var*
begin
//#UC START# *4B50270B0138_4B50388A00E5get_impl*
 if HasUserProfile then
  f_Profile.GetMail(l_Str)
 else
  l_Str := nil;
 Result := nsCStr(l_Str);
//#UC END# *4B50270B0138_4B50388A00E5get_impl*
end;//_nsUserPropertyImpl_.Get_Mail

function _nsUserPropertyImpl_.Get_IsChanged: Boolean;
//#UC START# *4B5027120274_4B50388A00E5get_var*
//#UC END# *4B5027120274_4B50388A00E5get_var*
begin
//#UC START# *4B5027120274_4B50388A00E5get_impl*
 if not f_NewUser then
  Result := f_Changed
 else
  Result := True;
//#UC END# *4B5027120274_4B50388A00E5get_impl*
end;//_nsUserPropertyImpl_.Get_IsChanged

procedure _nsUserPropertyImpl_.Set_IsChanged(aValue: Boolean);
//#UC START# *4B5027120274_4B50388A00E5set_var*
//#UC END# *4B5027120274_4B50388A00E5set_var*
begin
//#UC START# *4B5027120274_4B50388A00E5set_impl*
 f_Changed := aValue;
 // Сбросить f_NewUser дабы нопочка Отмена могла погаснуть
 if not f_Changed then
  f_NewUser := false;
//#UC END# *4B5027120274_4B50388A00E5set_impl*
end;//_nsUserPropertyImpl_.Set_IsChanged

function _nsUserPropertyImpl_.Get_IsNewUser: Boolean;
//#UC START# *4B50271C00EE_4B50388A00E5get_var*
//#UC END# *4B50271C00EE_4B50388A00E5get_var*
begin
//#UC START# *4B50271C00EE_4B50388A00E5get_impl*
 Result := f_NewUser;
//#UC END# *4B50271C00EE_4B50388A00E5get_impl*
end;//_nsUserPropertyImpl_.Get_IsNewUser

function _nsUserPropertyImpl_.Get_CanBuyConsulting: Boolean;
//#UC START# *4B502720021F_4B50388A00E5get_var*
var
 l_UserManager: IUserManager;
//#UC END# *4B502720021F_4B50388A00E5get_var*
begin
//#UC START# *4B502720021F_4B50388A00E5get_impl*
 if HasUserProfile then
  Result := f_Profile.CanBuyConsulting
 else
 begin
  l_UserManager := defDataAdapter.NativeAdapter.MakeUserManager;
  try
   Result := l_UserManager.GetConsultingPaymentForNewbies;
  finally
   l_UserManager := nil;
  end;
 end;
//#UC END# *4B502720021F_4B50388A00E5get_impl*
end;//_nsUserPropertyImpl_.Get_CanBuyConsulting

function _nsUserPropertyImpl_.Get_IsSystem: Boolean;
//#UC START# *4B5027240286_4B50388A00E5get_var*
//#UC END# *4B5027240286_4B50388A00E5get_var*
begin
//#UC START# *4B5027240286_4B50388A00E5get_impl*
 if HasUserProfile then
  Result := f_Profile.IsSystem
 else
  Result := False;
//#UC END# *4B5027240286_4B50388A00E5get_impl*
end;//_nsUserPropertyImpl_.Get_IsSystem

function _nsUserPropertyImpl_.Get_IsPrivileged: Boolean;
//#UC START# *4B50272901C3_4B50388A00E5get_var*
//#UC END# *4B50272901C3_4B50388A00E5get_var*
begin
//#UC START# *4B50272901C3_4B50388A00E5get_impl*
 if HasUserProfile then
  Result := f_Profile.IsPrivileged
 else
  Result := False;
//#UC END# *4B50272901C3_4B50388A00E5get_impl*
end;//_nsUserPropertyImpl_.Get_IsPrivileged

procedure _nsUserPropertyImpl_.SaveUserInfo(const aName: Tl3WString;
 const aMail: Tl3WString;
 const aPassword: Tl3WString;
 IsPasswordChanged: Boolean = False);
//#UC START# *4B5460600098_4B50388A00E5_var*
var
 l_UserManager: IUserManager;
//#UC END# *4B5460600098_4B50388A00E5_var*
begin
//#UC START# *4B5460600098_4B50388A00E5_impl*
 l_UserManager := defDataAdapter.NativeAdapter.MakeUserManager;
 try
  l_UserManager.ChangeUserInfo(Get_UID, nsAStr(aName).S, nsAStr(aMail).S);
  if IsPasswordChanged then
   l_UserManager.ChangeUserPassword(Get_UID, nsAStr(aPassword).S);
 finally
  l_UserManager := nil;
 end;
 f_Changed := False;
//#UC END# *4B5460600098_4B50388A00E5_impl*
end;//_nsUserPropertyImpl_.SaveUserInfo

function _nsUserPropertyImpl_.Get_DontDeleteIdle: Boolean;
//#UC START# *4F3C01AD01FB_4B50388A00E5get_var*
var
 l_UserManager: IUserManager;
//#UC END# *4F3C01AD01FB_4B50388A00E5get_var*
begin
//#UC START# *4F3C01AD01FB_4B50388A00E5get_impl*
 l_UserManager := defDataAdapter.NativeAdapter.MakeUserManager;
 try
  Result := not l_UserManager.IsErasable(Get_UID);
 finally
  l_UserManager := nil;
 end;
//#UC END# *4F3C01AD01FB_4B50388A00E5get_impl*
end;//_nsUserPropertyImpl_.Get_DontDeleteIdle

procedure _nsUserPropertyImpl_.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4B50388A00E5_var*
//#UC END# *479731C50290_4B50388A00E5_var*
begin
//#UC START# *479731C50290_4B50388A00E5_impl*
 f_Profile := nil;
 f_Changed := False;
 f_NewUser := False;
 inherited;
//#UC END# *479731C50290_4B50388A00E5_impl*
end;//_nsUserPropertyImpl_.Cleanup

{$EndIf nsUserPropertyImpl_imp_impl}

{$EndIf nsUserPropertyImpl_imp}

