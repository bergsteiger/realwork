unit htUserManager;

// Модуль: "w:\common\components\rtl\Garant\HT\htUserManager.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "ThtUserManager" MUID: (5629E343023B)

{$Include w:\common\components\rtl\Garant\HT\htDefineDA.inc}

interface

uses
 l3IntfUses
 , l3ProtoObject
 , daInterfaces
 , daUserStatusChangedSubscriberList
 , daTypes
 , l3DatLst
;

type
 ThtUserManager = class(Tl3ProtoObject, IdaUserManager)
  private
   f_UserStatusChangedSubscriberList: TdaUserStatusChangedSubscriberList;
   f_PriorityCalculator: IdaPriorityCalculator;
  protected
   function CheckPassword(const aLogin: AnsiString;
    const aPassword: AnsiString;
    RequireAdminRights: Boolean;
    out theUserID: TdaUserID): TdaLoginError;
   function IsUserAdmin(anUserID: TdaUserID): Boolean;
   function Get_AllUsers: Tl3StringDataList;
   function Get_AllGroups: Tl3StringDataList;
   function GetUserName(anUserID: TdaUserID): AnsiString;
   function GetUserPriorities(aGroupId: TdaUserID;
    var aImportPriority: TdaPriority;
    var aExportPriority: TdaPriority): Boolean;
   procedure ReSortUserList;
   function Get_ArchiUsersCount: Integer;
   function UserByID(aID: TdaUserID): IdaArchiUser;
   function UserByLogin(const aLogin: AnsiString): IdaArchiUser;
   procedure UpdateUserInfo(aUserID: TdaUserID;
    aIsGroup: Boolean);
   procedure MakeFullArchiUsersList;
   function GetUserDisplayName(anID: TdaUserID): AnsiString;
   function IsUserExists(anID: TdaUserID): Boolean;
   procedure RegisterUserStatusChangedSubscriber(const aSubscriber: IdaUserStatusChangedSubscriber);
   procedure UnRegisterUserStatusChangedSubscriber(const aSubscriber: IdaUserStatusChangedSubscriber);
   procedure NotifyUserActiveChanged(anUserID: TdaUserID;
    anActive: Boolean);
   function CSCheckPassword(const aLogin: AnsiString;
    const aPassword: AnsiString;
    RequireAdminRights: Boolean;
    out theUserID: TdaUserID): Boolean;
   procedure GetUserInfo(aUser: TdaUserID;
    var aUserName: AnsiString;
    var aLoginName: AnsiString;
    var aActFlag: Byte);
   function Get_PriorityCalculator: IdaPriorityCalculator;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   constructor Create; reintroduce;
   class function Make: IdaUserManager; reintroduce;
   procedure IterateArchiUsersF(anAction: ArchiUsersIterator_IterateArchiUsersF_Action);
   procedure IterateUserGroupsF(anAction: ArchiUsersIterator_IterateUserGroupsF_Action);
 end;//ThtUserManager

implementation

uses
 l3ImplUses
 {$If NOT Defined(Nemesis)}
 , dt_User
 {$IfEnd} // NOT Defined(Nemesis)
 {$If NOT Defined(Nemesis)}
 , dt_Serv
 {$IfEnd} // NOT Defined(Nemesis)
 , SysUtils
 , htPriorityCalculator
 , l3Types
 , l3Base
;

constructor ThtUserManager.Create;
//#UC START# *5629F0F901C8_5629E343023B_var*
//#UC END# *5629F0F901C8_5629E343023B_var*
begin
//#UC START# *5629F0F901C8_5629E343023B_impl*
 inherited Create;
//#UC END# *5629F0F901C8_5629E343023B_impl*
end;//ThtUserManager.Create

class function ThtUserManager.Make: IdaUserManager;
var
 l_Inst : ThtUserManager;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//ThtUserManager.Make

function ThtUserManager.CheckPassword(const aLogin: AnsiString;
 const aPassword: AnsiString;
 RequireAdminRights: Boolean;
 out theUserID: TdaUserID): TdaLoginError;
//#UC START# *5628D14D0151_5629E343023B_var*
var
 l_Result: Boolean;
//#UC END# *5628D14D0151_5629E343023B_var*
begin
//#UC START# *5628D14D0151_5629E343023B_impl*
 l_Result:= GlobalHtServer.xxxCheckArchivariusPassword(aLogin, aPassword, RequireAdminRights);
 if l_Result then
  Result := da_leOk
 else
 begin
  if RequireAdminRights and GlobalHtServer.xxxCheckArchivariusPassword(aLogin, aPassword, False) then
   Result := da_leInsufficientRights
  else
   Result := da_leUserParamsWrong;
 end;
 theUserID := GlobalHTServer.xxxUserID;
//#UC END# *5628D14D0151_5629E343023B_impl*
end;//ThtUserManager.CheckPassword

function ThtUserManager.IsUserAdmin(anUserID: TdaUserID): Boolean;
//#UC START# *56EA993D0218_5629E343023B_var*
//#UC END# *56EA993D0218_5629E343023B_var*
begin
//#UC START# *56EA993D0218_5629E343023B_impl*
 Result := dt_User.UserManager.xxxIsUserAdmin(anUserID);
//#UC END# *56EA993D0218_5629E343023B_impl*
end;//ThtUserManager.IsUserAdmin

function ThtUserManager.Get_AllUsers: Tl3StringDataList;
//#UC START# *5715DEF20209_5629E343023Bget_var*
//#UC END# *5715DEF20209_5629E343023Bget_var*
begin
//#UC START# *5715DEF20209_5629E343023Bget_impl*
 Result := dt_User.UserManager.xxxAllUsers;
//#UC END# *5715DEF20209_5629E343023Bget_impl*
end;//ThtUserManager.Get_AllUsers

function ThtUserManager.Get_AllGroups: Tl3StringDataList;
//#UC START# *5715DF0D03C2_5629E343023Bget_var*
//#UC END# *5715DF0D03C2_5629E343023Bget_var*
begin
//#UC START# *5715DF0D03C2_5629E343023Bget_impl*
 Result := dt_User.UserManager.xxxAllGroups;
//#UC END# *5715DF0D03C2_5629E343023Bget_impl*
end;//ThtUserManager.Get_AllGroups

function ThtUserManager.GetUserName(anUserID: TdaUserID): AnsiString;
//#UC START# *5718B5CF0399_5629E343023B_var*
//#UC END# *5718B5CF0399_5629E343023B_var*
begin
//#UC START# *5718B5CF0399_5629E343023B_impl*
 Result := dt_User.UserManager.GetUserName(anUserID);
//#UC END# *5718B5CF0399_5629E343023B_impl*
end;//ThtUserManager.GetUserName

function ThtUserManager.GetUserPriorities(aGroupId: TdaUserID;
 var aImportPriority: TdaPriority;
 var aExportPriority: TdaPriority): Boolean;
//#UC START# *571DCFB50217_5629E343023B_var*
//#UC END# *571DCFB50217_5629E343023B_var*
begin
//#UC START# *571DCFB50217_5629E343023B_impl*
 !!! Needs to be implemented !!!
//#UC END# *571DCFB50217_5629E343023B_impl*
end;//ThtUserManager.GetUserPriorities

procedure ThtUserManager.ReSortUserList;
//#UC START# *5721F5E60367_5629E343023B_var*
//#UC END# *5721F5E60367_5629E343023B_var*
begin
//#UC START# *5721F5E60367_5629E343023B_impl*
 !!! Needs to be implemented !!!
//#UC END# *5721F5E60367_5629E343023B_impl*
end;//ThtUserManager.ReSortUserList

function ThtUserManager.Get_ArchiUsersCount: Integer;
//#UC START# *5729C59E00D5_5629E343023Bget_var*
//#UC END# *5729C59E00D5_5629E343023Bget_var*
begin
//#UC START# *5729C59E00D5_5629E343023Bget_impl*
 Result := dt_User.UserManager.xxxGetArchiUsersCount;
//#UC END# *5729C59E00D5_5629E343023Bget_impl*
end;//ThtUserManager.Get_ArchiUsersCount

procedure ThtUserManager.IterateArchiUsersF(anAction: ArchiUsersIterator_IterateArchiUsersF_Action);
//#UC START# *5729DD530330_5629E343023B_var*
var
 Hack : Pointer absolute anAction;
//#UC END# *5729DD530330_5629E343023B_var*
begin
//#UC START# *5729DD530330_5629E343023B_impl*
 try
  dt_User.UserManager.xxxIterateArchiUsers(anAction);
 finally
  l3FreeLocalStub(Hack);
 end;//try..finally
//#UC END# *5729DD530330_5629E343023B_impl*
end;//ThtUserManager.IterateArchiUsersF

function ThtUserManager.UserByID(aID: TdaUserID): IdaArchiUser;
//#UC START# *57358B940211_5629E343023B_var*
//#UC END# *57358B940211_5629E343023B_var*
begin
//#UC START# *57358B940211_5629E343023B_impl*
 Result := dt_User.UserManager.xxxUserByID(aID);
//#UC END# *57358B940211_5629E343023B_impl*
end;//ThtUserManager.UserByID

function ThtUserManager.UserByLogin(const aLogin: AnsiString): IdaArchiUser;
//#UC START# *57358BCB0360_5629E343023B_var*
//#UC END# *57358BCB0360_5629E343023B_var*
begin
//#UC START# *57358BCB0360_5629E343023B_impl*
 Result := dt_User.UserManager.xxxUserByLogin(aLogin);
//#UC END# *57358BCB0360_5629E343023B_impl*
end;//ThtUserManager.UserByLogin

procedure ThtUserManager.UpdateUserInfo(aUserID: TdaUserID;
 aIsGroup: Boolean);
//#UC START# *5735AE4D0017_5629E343023B_var*
//#UC END# *5735AE4D0017_5629E343023B_var*
begin
//#UC START# *5735AE4D0017_5629E343023B_impl*
 dt_User.UserManager.xxxUpdateUserInfo(aUserID, aIsGroup);
//#UC END# *5735AE4D0017_5629E343023B_impl*
end;//ThtUserManager.UpdateUserInfo

procedure ThtUserManager.MakeFullArchiUsersList;
//#UC START# *5735AE7F0071_5629E343023B_var*
//#UC END# *5735AE7F0071_5629E343023B_var*
begin
//#UC START# *5735AE7F0071_5629E343023B_impl*
 dt_User.UserManager.xxxmakeFullUsersList;
//#UC END# *5735AE7F0071_5629E343023B_impl*
end;//ThtUserManager.MakeFullArchiUsersList

function ThtUserManager.GetUserDisplayName(anID: TdaUserID): AnsiString;
//#UC START# *5735AECA0121_5629E343023B_var*
//#UC END# *5735AECA0121_5629E343023B_var*
begin
//#UC START# *5735AECA0121_5629E343023B_impl*
 Result := dt_User.UserManager.xxxGetUserDisplayName(anID);
//#UC END# *5735AECA0121_5629E343023B_impl*
end;//ThtUserManager.GetUserDisplayName

function ThtUserManager.IsUserExists(anID: TdaUserID): Boolean;
//#UC START# *5739732402E4_5629E343023B_var*
//#UC END# *5739732402E4_5629E343023B_var*
begin
//#UC START# *5739732402E4_5629E343023B_impl*
 Result := dt_User.UserManager.xxxIsUserExists(anID);
//#UC END# *5739732402E4_5629E343023B_impl*
end;//ThtUserManager.IsUserExists

procedure ThtUserManager.RegisterUserStatusChangedSubscriber(const aSubscriber: IdaUserStatusChangedSubscriber);
//#UC START# *5739832A00A2_5629E343023B_var*
//#UC END# *5739832A00A2_5629E343023B_var*
begin
//#UC START# *5739832A00A2_5629E343023B_impl*
 if f_UserStatusChangedSubscriberList.IndexOf(aSubscriber) = -1 then
  f_UserStatusChangedSubscriberList.Add(aSubscriber);
//#UC END# *5739832A00A2_5629E343023B_impl*
end;//ThtUserManager.RegisterUserStatusChangedSubscriber

procedure ThtUserManager.UnRegisterUserStatusChangedSubscriber(const aSubscriber: IdaUserStatusChangedSubscriber);
//#UC START# *5739834700B2_5629E343023B_var*
//#UC END# *5739834700B2_5629E343023B_var*
begin
//#UC START# *5739834700B2_5629E343023B_impl*
 f_UserStatusChangedSubscriberList.Remove(aSubscriber);
//#UC END# *5739834700B2_5629E343023B_impl*
end;//ThtUserManager.UnRegisterUserStatusChangedSubscriber

procedure ThtUserManager.NotifyUserActiveChanged(anUserID: TdaUserID;
 anActive: Boolean);
//#UC START# *5739835200CF_5629E343023B_var*

 type
  PIdaUserStatusChangedSubscriber = ^IdaUserStatusChangedSubscriber;

 function DoIt(aData : PIdaUserStatusChangedSubscriber; anIndex : Integer) : Boolean;
 begin
  aData^.UserStatusChanged(anUserID, anActive);
  Result := True;
 end;

//#UC END# *5739835200CF_5629E343023B_var*
begin
//#UC START# *5739835200CF_5629E343023B_impl*
 f_UserStatusChangedSubscriberList.IterateAllF(l3L2IA(@DoIt));
//#UC END# *5739835200CF_5629E343023B_impl*
end;//ThtUserManager.NotifyUserActiveChanged

function ThtUserManager.CSCheckPassword(const aLogin: AnsiString;
 const aPassword: AnsiString;
 RequireAdminRights: Boolean;
 out theUserID: TdaUserID): Boolean;
//#UC START# *573AC17202BF_5629E343023B_var*
//#UC END# *573AC17202BF_5629E343023B_var*
begin
//#UC START# *573AC17202BF_5629E343023B_impl*
 Result := dt_User.UserManager.xxxCSCheckPassword(aLogin, aPassword, RequireAdminRights, theUserID);
//#UC END# *573AC17202BF_5629E343023B_impl*
end;//ThtUserManager.CSCheckPassword

procedure ThtUserManager.GetUserInfo(aUser: TdaUserID;
 var aUserName: AnsiString;
 var aLoginName: AnsiString;
 var aActFlag: Byte);
//#UC START# *573AEE9902DF_5629E343023B_var*
var
 l_UserName: ShortString;
 l_LoginName: ShortString;
//#UC END# *573AEE9902DF_5629E343023B_var*
begin
//#UC START# *573AEE9902DF_5629E343023B_impl*
 dt_User.UserManager.xxxGetUserInfo(aUser, l_UserName, l_LoginName, aActFlag);
 aUserName := l_UserName;
 aLoginName := l_LoginName;
//#UC END# *573AEE9902DF_5629E343023B_impl*
end;//ThtUserManager.GetUserInfo

function ThtUserManager.Get_PriorityCalculator: IdaPriorityCalculator;
//#UC START# *575020410175_5629E343023Bget_var*
//#UC END# *575020410175_5629E343023Bget_var*
begin
//#UC START# *575020410175_5629E343023Bget_impl*
 if f_PriorityCalculator = nil then
  f_PriorityCalculator := ThtPriorityCalculator.Make;
 Result := f_PriorityCalculator;
//#UC END# *575020410175_5629E343023Bget_impl*
end;//ThtUserManager.Get_PriorityCalculator

procedure ThtUserManager.IterateUserGroupsF(anAction: ArchiUsersIterator_IterateUserGroupsF_Action);
//#UC START# *5757D9BB0116_5629E343023B_var*
var
 Hack : Pointer absolute anAction;
 lAction : Tl3IteratorAction;

 function lp_UserGroupIter(aData: Pointer; aIndex: Long): Bool;
 var
  l_Name: String;
 begin
  l_Name := PAnsiChar(aData);
  Result := anAction(l_Name, aIndex);
 end;

//#UC END# *5757D9BB0116_5629E343023B_var*
begin
//#UC START# *5757D9BB0116_5629E343023B_impl*
 try
  lAction := l3L2IA(@lp_UserGroupIter);
  try
   dt_User.UserManager.xxxIterateUserGroups(lAction);
  finally
   l3FreeFA(Tl3FreeAction(lAction));
  end;
 finally
  l3FreeLocalStub(Hack);
 end;//try..finally
//#UC END# *5757D9BB0116_5629E343023B_impl*
end;//ThtUserManager.IterateUserGroupsF

procedure ThtUserManager.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_5629E343023B_var*
//#UC END# *479731C50290_5629E343023B_var*
begin
//#UC START# *479731C50290_5629E343023B_impl*
 FreeAndNil(f_UserStatusChangedSubscriberList);
 inherited;
//#UC END# *479731C50290_5629E343023B_impl*
end;//ThtUserManager.Cleanup

end.
