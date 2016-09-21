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
 , l3LongintList
 , Classes
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
   function IsMemberOfGroup(aUserGroupID: TdaUserGroupID;
    aUserID: TdaUserID): Boolean;
   function GetUserGroups(aUserID: TdaUserID): TdaUserGroupIDArray;
   procedure GetUserGroupsList(aUser: TdaUserID;
    aList: Tl3StringDataList); overload;
   procedure GetUserGroupsList(aUser: TdaUserID;
    aList: Tl3LongintList); overload;
   procedure SetUserGroupsList(aUser: TdaUserID;
    aList: Tl3StringDataList);
   function AddUserGroup(const aName: AnsiString): TdaUserGroupID;
   procedure EditUserGroup(aGroupID: TdaUserGroupID;
    const aName: AnsiString;
    aImportPriority: TdaPriority;
    aExportPriority: TdaPriority);
   procedure DelUserGroup(aGroupID: TdaUserGroupID);
   procedure RemoveUserFromAllGroups(aUser: TdaUserID);
   procedure SetUserGroup(aUser: TdaUserID;
    aGroup: TdaUserGroupID;
    Add: Boolean = True);
   procedure AdminChangePassWord(aUser: TdaUserID;
    const NewPass: AnsiString);
   procedure GetHostUserListOnGroup(aGroupID: TdaUserGroupID;
    aList: Tl3StringDataList;
    NeedSort: Boolean = False);
   procedure SetHostUserListOnGroup(aGroupID: TdaUserGroupID;
    aList: Tl3StringDataList);
   function AddUser(const aUserName: AnsiString;
    const aLoginName: AnsiString;
    const aPassword: AnsiString;
    ActFlag: Byte): TdaUserID;
   function AddUserID(anID: TdaUserID;
    const aUserName: AnsiString;
    const aLoginName: AnsiString;
    const aPassword: AnsiString;
    ActFlag: Byte): TdaUserID;
   procedure EditUser(aUser: TdaUserID;
    const aUserName: AnsiString;
    const aLoginName: AnsiString;
    ActFlag: Byte;
    const EditMask: TdaUserEditMask);
   procedure DelUser(aUser: TdaUserID);
   procedure GetUserListOnGroup(aUsGroup: TdaUserGroupID;
    aList: Tl3StringDataList;
    GetActiveUsersOnly: Boolean = False);
   procedure GetFiltredUserList(aList: TStrings;
    aOnlyActive: Boolean = False);
   procedure GetDocGroupData(aUserGroup: TdaUserGroupID;
    aFamily: TdaFamilyID;
    aDocDataList: Tl3StringDataList);
   procedure PutDocGroupData(aUserGroup: TdaUserGroupID;
    aFamily: TdaFamilyID;
    aDocDataList: Tl3StringDataList);
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
 //#UC START# *5629E343023Bimpl_uses*
 //#UC END# *5629E343023Bimpl_uses*
;

constructor ThtUserManager.Create;
//#UC START# *5629F0F901C8_5629E343023B_var*
//#UC END# *5629F0F901C8_5629E343023B_var*
begin
//#UC START# *5629F0F901C8_5629E343023B_impl*
 inherited Create;
 f_UserStatusChangedSubscriberList := TdaUserStatusChangedSubscriberList.Make;
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
 Result := dt_User.xxxUserManager.xxxIsUserAdmin(anUserID);
//#UC END# *56EA993D0218_5629E343023B_impl*
end;//ThtUserManager.IsUserAdmin

function ThtUserManager.Get_AllUsers: Tl3StringDataList;
//#UC START# *5715DEF20209_5629E343023Bget_var*
//#UC END# *5715DEF20209_5629E343023Bget_var*
begin
//#UC START# *5715DEF20209_5629E343023Bget_impl*
 Result := dt_User.xxxUserManager.xxxAllUsers;
//#UC END# *5715DEF20209_5629E343023Bget_impl*
end;//ThtUserManager.Get_AllUsers

function ThtUserManager.Get_AllGroups: Tl3StringDataList;
//#UC START# *5715DF0D03C2_5629E343023Bget_var*
//#UC END# *5715DF0D03C2_5629E343023Bget_var*
begin
//#UC START# *5715DF0D03C2_5629E343023Bget_impl*
 Result := dt_User.xxxUserManager.xxxAllGroups;
//#UC END# *5715DF0D03C2_5629E343023Bget_impl*
end;//ThtUserManager.Get_AllGroups

function ThtUserManager.GetUserName(anUserID: TdaUserID): AnsiString;
//#UC START# *5718B5CF0399_5629E343023B_var*
//#UC END# *5718B5CF0399_5629E343023B_var*
begin
//#UC START# *5718B5CF0399_5629E343023B_impl*
 Result := dt_User.xxxUserManager.xxxGetUserName(anUserID);
//#UC END# *5718B5CF0399_5629E343023B_impl*
end;//ThtUserManager.GetUserName

function ThtUserManager.GetUserPriorities(aGroupId: TdaUserID;
 var aImportPriority: TdaPriority;
 var aExportPriority: TdaPriority): Boolean;
//#UC START# *571DCFB50217_5629E343023B_var*
//#UC END# *571DCFB50217_5629E343023B_var*
begin
//#UC START# *571DCFB50217_5629E343023B_impl*
 Result := dt_User.xxxUserManager.xxxGetUserPriorities(aGroupId, aImportPriority, aExportPriority);
//#UC END# *571DCFB50217_5629E343023B_impl*
end;//ThtUserManager.GetUserPriorities

procedure ThtUserManager.ReSortUserList;
//#UC START# *5721F5E60367_5629E343023B_var*
//#UC END# *5721F5E60367_5629E343023B_var*
begin
//#UC START# *5721F5E60367_5629E343023B_impl*
 dt_User.xxxUserManager.xxxReSortUserList;
//#UC END# *5721F5E60367_5629E343023B_impl*
end;//ThtUserManager.ReSortUserList

function ThtUserManager.Get_ArchiUsersCount: Integer;
//#UC START# *5729C59E00D5_5629E343023Bget_var*
//#UC END# *5729C59E00D5_5629E343023Bget_var*
begin
//#UC START# *5729C59E00D5_5629E343023Bget_impl*
 Result := dt_User.xxxUserManager.xxxGetArchiUsersCount(Get_PriorityCalculator);
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
  dt_User.xxxUserManager.xxxIterateArchiUsers(anAction);
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
 Result := dt_User.xxxUserManager.xxxUserByID(Get_PriorityCalculator, aID);
//#UC END# *57358B940211_5629E343023B_impl*
end;//ThtUserManager.UserByID

function ThtUserManager.UserByLogin(const aLogin: AnsiString): IdaArchiUser;
//#UC START# *57358BCB0360_5629E343023B_var*
//#UC END# *57358BCB0360_5629E343023B_var*
begin
//#UC START# *57358BCB0360_5629E343023B_impl*
 Result := dt_User.xxxUserManager.xxxUserByLogin(Get_PriorityCalculator, aLogin);
//#UC END# *57358BCB0360_5629E343023B_impl*
end;//ThtUserManager.UserByLogin

procedure ThtUserManager.UpdateUserInfo(aUserID: TdaUserID;
 aIsGroup: Boolean);
//#UC START# *5735AE4D0017_5629E343023B_var*
//#UC END# *5735AE4D0017_5629E343023B_var*
begin
//#UC START# *5735AE4D0017_5629E343023B_impl*
 dt_User.xxxUserManager.xxxUpdateUserInfo(Get_PriorityCalculator, aUserID, aIsGroup);
//#UC END# *5735AE4D0017_5629E343023B_impl*
end;//ThtUserManager.UpdateUserInfo

procedure ThtUserManager.MakeFullArchiUsersList;
//#UC START# *5735AE7F0071_5629E343023B_var*
//#UC END# *5735AE7F0071_5629E343023B_var*
begin
//#UC START# *5735AE7F0071_5629E343023B_impl*
 dt_User.xxxUserManager.xxxmakeFullUsersList(Get_PriorityCalculator);
//#UC END# *5735AE7F0071_5629E343023B_impl*
end;//ThtUserManager.MakeFullArchiUsersList

function ThtUserManager.GetUserDisplayName(anID: TdaUserID): AnsiString;
//#UC START# *5735AECA0121_5629E343023B_var*
//#UC END# *5735AECA0121_5629E343023B_var*
begin
//#UC START# *5735AECA0121_5629E343023B_impl*
 Result := dt_User.xxxUserManager.xxxGetUserDisplayName(Get_PriorityCalculator, anID);
//#UC END# *5735AECA0121_5629E343023B_impl*
end;//ThtUserManager.GetUserDisplayName

function ThtUserManager.IsUserExists(anID: TdaUserID): Boolean;
//#UC START# *5739732402E4_5629E343023B_var*
//#UC END# *5739732402E4_5629E343023B_var*
begin
//#UC START# *5739732402E4_5629E343023B_impl*
 Result := dt_User.xxxUserManager.xxxIsUserExists(anID);
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
 Result := dt_User.xxxUserManager.xxxCSCheckPassword(Get_PriorityCalculator, aLogin, aPassword, RequireAdminRights, theUserID);
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
 dt_User.xxxUserManager.xxxGetUserInfo(aUser, l_UserName, l_LoginName, aActFlag);
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
   dt_User.xxxUserManager.xxxIterateUserGroups(lAction);
  finally
   l3FreeFA(Tl3FreeAction(lAction));
  end;
 finally
  l3FreeLocalStub(Hack);
 end;//try..finally
//#UC END# *5757D9BB0116_5629E343023B_impl*
end;//ThtUserManager.IterateUserGroupsF

function ThtUserManager.IsMemberOfGroup(aUserGroupID: TdaUserGroupID;
 aUserID: TdaUserID): Boolean;
//#UC START# *575A8B790353_5629E343023B_var*
//#UC END# *575A8B790353_5629E343023B_var*
begin
//#UC START# *575A8B790353_5629E343023B_impl*
 Result := dt_User.xxxUserManager.xxxIsMemberOfGroup(aUserGroupID, aUserID);
//#UC END# *575A8B790353_5629E343023B_impl*
end;//ThtUserManager.IsMemberOfGroup

function ThtUserManager.GetUserGroups(aUserID: TdaUserID): TdaUserGroupIDArray;
//#UC START# *57625B5002DD_5629E343023B_var*
//#UC END# *57625B5002DD_5629E343023B_var*
begin
//#UC START# *57625B5002DD_5629E343023B_impl*
 Result := dt_User.xxxUserManager.xxxGetUserGroups(aUserID);
//#UC END# *57625B5002DD_5629E343023B_impl*
end;//ThtUserManager.GetUserGroups

procedure ThtUserManager.GetUserGroupsList(aUser: TdaUserID;
 aList: Tl3StringDataList);
//#UC START# *576289510024_5629E343023B_var*
//#UC END# *576289510024_5629E343023B_var*
begin
//#UC START# *576289510024_5629E343023B_impl*
 dt_User.xxxUserManager.xxxGetUserGroupList(aUser, aList);
//#UC END# *576289510024_5629E343023B_impl*
end;//ThtUserManager.GetUserGroupsList

procedure ThtUserManager.GetUserGroupsList(aUser: TdaUserID;
 aList: Tl3LongintList);
//#UC START# *57628A9403C6_5629E343023B_var*
//#UC END# *57628A9403C6_5629E343023B_var*
begin
//#UC START# *57628A9403C6_5629E343023B_impl*
 dt_User.xxxUserManager.xxxGetUserGroupList(aUser, aList);
//#UC END# *57628A9403C6_5629E343023B_impl*
end;//ThtUserManager.GetUserGroupsList

procedure ThtUserManager.SetUserGroupsList(aUser: TdaUserID;
 aList: Tl3StringDataList);
//#UC START# *5767ABE002DC_5629E343023B_var*
//#UC END# *5767ABE002DC_5629E343023B_var*
begin
//#UC START# *5767ABE002DC_5629E343023B_impl*
 dt_User.xxxUserManager.xxxSetUserGroupList(aUser, aList);
//#UC END# *5767ABE002DC_5629E343023B_impl*
end;//ThtUserManager.SetUserGroupsList

function ThtUserManager.AddUserGroup(const aName: AnsiString): TdaUserGroupID;
//#UC START# *576B95A600B9_5629E343023B_var*
var
 l_Name: ShortString;
//#UC END# *576B95A600B9_5629E343023B_var*
begin
//#UC START# *576B95A600B9_5629E343023B_impl*
 l_Name := aName;
 Result := dt_User.xxxUserManager.xxxAddUserGroup(l_Name);
//#UC END# *576B95A600B9_5629E343023B_impl*
end;//ThtUserManager.AddUserGroup

procedure ThtUserManager.EditUserGroup(aGroupID: TdaUserGroupID;
 const aName: AnsiString;
 aImportPriority: TdaPriority;
 aExportPriority: TdaPriority);
//#UC START# *576B960500C5_5629E343023B_var*
var
 l_Name: ShortString;
//#UC END# *576B960500C5_5629E343023B_var*
begin
//#UC START# *576B960500C5_5629E343023B_impl*
 l_Name := aName;
 dt_User.xxxUserManager.xxxEditUserGroup(aGroupID, l_Name, aImportPriority, aExportPriority);
//#UC END# *576B960500C5_5629E343023B_impl*
end;//ThtUserManager.EditUserGroup

procedure ThtUserManager.DelUserGroup(aGroupID: TdaUserGroupID);
//#UC START# *576BAC4402D8_5629E343023B_var*
//#UC END# *576BAC4402D8_5629E343023B_var*
begin
//#UC START# *576BAC4402D8_5629E343023B_impl*
 dt_User.xxxUserManager.xxxDelUserGroupByID(aGroupID);
//#UC END# *576BAC4402D8_5629E343023B_impl*
end;//ThtUserManager.DelUserGroup

procedure ThtUserManager.RemoveUserFromAllGroups(aUser: TdaUserID);
//#UC START# *577F6AD90170_5629E343023B_var*
//#UC END# *577F6AD90170_5629E343023B_var*
begin
//#UC START# *577F6AD90170_5629E343023B_impl*
 dt_User.xxxUserManager.xxxRemoveUserFromAllGroups(aUser);
//#UC END# *577F6AD90170_5629E343023B_impl*
end;//ThtUserManager.RemoveUserFromAllGroups

procedure ThtUserManager.SetUserGroup(aUser: TdaUserID;
 aGroup: TdaUserGroupID;
 Add: Boolean = True);
//#UC START# *577F80C503AF_5629E343023B_var*
//#UC END# *577F80C503AF_5629E343023B_var*
begin
//#UC START# *577F80C503AF_5629E343023B_impl*
 dt_User.xxxUserManager.xxxSetUserGroup(aUser, aGroup, Add);
//#UC END# *577F80C503AF_5629E343023B_impl*
end;//ThtUserManager.SetUserGroup

procedure ThtUserManager.AdminChangePassWord(aUser: TdaUserID;
 const NewPass: AnsiString);
//#UC START# *5783537E00A1_5629E343023B_var*
//#UC END# *5783537E00A1_5629E343023B_var*
begin
//#UC START# *5783537E00A1_5629E343023B_impl*
 dt_User.xxxUserManager.xxxAdminChangePassWord(aUser, NewPass);
//#UC END# *5783537E00A1_5629E343023B_impl*
end;//ThtUserManager.AdminChangePassWord

procedure ThtUserManager.GetHostUserListOnGroup(aGroupID: TdaUserGroupID;
 aList: Tl3StringDataList;
 NeedSort: Boolean = False);
//#UC START# *578392E7026A_5629E343023B_var*
//#UC END# *578392E7026A_5629E343023B_var*
begin
//#UC START# *578392E7026A_5629E343023B_impl*
 dt_User.xxxUserManager.xxxGetHostUserListOnGroup(aGroupID, aList, NeedSort);
//#UC END# *578392E7026A_5629E343023B_impl*
end;//ThtUserManager.GetHostUserListOnGroup

procedure ThtUserManager.SetHostUserListOnGroup(aGroupID: TdaUserGroupID;
 aList: Tl3StringDataList);
//#UC START# *5783933A010B_5629E343023B_var*
//#UC END# *5783933A010B_5629E343023B_var*
begin
//#UC START# *5783933A010B_5629E343023B_impl*
 dt_User.xxxUserManager.xxxSetHostUserListOnGroup(aGroupID, aList);
//#UC END# *5783933A010B_5629E343023B_impl*
end;//ThtUserManager.SetHostUserListOnGroup

function ThtUserManager.AddUser(const aUserName: AnsiString;
 const aLoginName: AnsiString;
 const aPassword: AnsiString;
 ActFlag: Byte): TdaUserID;
//#UC START# *5784BBF10299_5629E343023B_var*
//#UC END# *5784BBF10299_5629E343023B_var*
begin
//#UC START# *5784BBF10299_5629E343023B_impl*
 Result := dt_User.xxxUserManager.xxxAddUser(aUserName, aLoginName, aPassword, ActFlag);
//#UC END# *5784BBF10299_5629E343023B_impl*
end;//ThtUserManager.AddUser

function ThtUserManager.AddUserID(anID: TdaUserID;
 const aUserName: AnsiString;
 const aLoginName: AnsiString;
 const aPassword: AnsiString;
 ActFlag: Byte): TdaUserID;
//#UC START# *5784BC420208_5629E343023B_var*
//#UC END# *5784BC420208_5629E343023B_var*
begin
//#UC START# *5784BC420208_5629E343023B_impl*
 Result := dt_User.xxxUserManager.xxxAddUserID(anID, aUserName, aLoginName, aPassword, ActFlag);
//#UC END# *5784BC420208_5629E343023B_impl*
end;//ThtUserManager.AddUserID

procedure ThtUserManager.EditUser(aUser: TdaUserID;
 const aUserName: AnsiString;
 const aLoginName: AnsiString;
 ActFlag: Byte;
 const EditMask: TdaUserEditMask);
//#UC START# *5784BD1501E8_5629E343023B_var*
//#UC END# *5784BD1501E8_5629E343023B_var*
begin
//#UC START# *5784BD1501E8_5629E343023B_impl*
 dt_User.xxxUserManager.xxxEditUser(aUser, aUserName, aLoginName, ActFlag, EditMask);
//#UC END# *5784BD1501E8_5629E343023B_impl*
end;//ThtUserManager.EditUser

procedure ThtUserManager.DelUser(aUser: TdaUserID);
//#UC START# *5784BE1E02F7_5629E343023B_var*
//#UC END# *5784BE1E02F7_5629E343023B_var*
begin
//#UC START# *5784BE1E02F7_5629E343023B_impl*
 dt_User.xxxUserManager.xxxDelUser(aUser);
//#UC END# *5784BE1E02F7_5629E343023B_impl*
end;//ThtUserManager.DelUser

procedure ThtUserManager.GetUserListOnGroup(aUsGroup: TdaUserGroupID;
 aList: Tl3StringDataList;
 GetActiveUsersOnly: Boolean = False);
//#UC START# *57A87EF901F3_5629E343023B_var*
//#UC END# *57A87EF901F3_5629E343023B_var*
begin
//#UC START# *57A87EF901F3_5629E343023B_impl*
 dt_User.xxxUserManager.xxxGetUserListOnGroup(aUsGroup, aList, GetActiveUsersOnly);
//#UC END# *57A87EF901F3_5629E343023B_impl*
end;//ThtUserManager.GetUserListOnGroup

procedure ThtUserManager.GetFiltredUserList(aList: TStrings;
 aOnlyActive: Boolean = False);
//#UC START# *57A9DF2103CE_5629E343023B_var*
//#UC END# *57A9DF2103CE_5629E343023B_var*
begin
//#UC START# *57A9DF2103CE_5629E343023B_impl*
 if dt_User.xxxUserManager = nil then
  aList.Clear
 else
  dt_User.xxxUserManager.xxxGetFiltredUserList(aList, aOnlyActive);
//#UC END# *57A9DF2103CE_5629E343023B_impl*
end;//ThtUserManager.GetFiltredUserList

procedure ThtUserManager.GetDocGroupData(aUserGroup: TdaUserGroupID;
 aFamily: TdaFamilyID;
 aDocDataList: Tl3StringDataList);
//#UC START# *57AC28890131_5629E343023B_var*
//#UC END# *57AC28890131_5629E343023B_var*
begin
//#UC START# *57AC28890131_5629E343023B_impl*
 dt_User.xxxUserManager.xxxGetDocGroupData(aUserGroup, aFamily, aDocDataList);
//#UC END# *57AC28890131_5629E343023B_impl*
end;//ThtUserManager.GetDocGroupData

procedure ThtUserManager.PutDocGroupData(aUserGroup: TdaUserGroupID;
 aFamily: TdaFamilyID;
 aDocDataList: Tl3StringDataList);
//#UC START# *57AC289F0257_5629E343023B_var*
//#UC END# *57AC289F0257_5629E343023B_var*
begin
//#UC START# *57AC289F0257_5629E343023B_impl*
 dt_User.xxxUserManager.xxxPutDocGroupData(aUserGroup, aFamily, aDocDataList);
//#UC END# *57AC289F0257_5629E343023B_impl*
end;//ThtUserManager.PutDocGroupData

procedure ThtUserManager.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_5629E343023B_var*
//#UC END# *479731C50290_5629E343023B_var*
begin
//#UC START# *479731C50290_5629E343023B_impl*
 f_PriorityCalculator := nil;
 FreeAndNil(f_UserStatusChangedSubscriberList);
 inherited;
//#UC END# *479731C50290_5629E343023B_impl*
end;//ThtUserManager.Cleanup

end.
