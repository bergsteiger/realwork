unit caUserManager;

// ������: "w:\common\components\rtl\Garant\ComboAccess\caUserManager.pas"
// ���������: "SimpleClass"
// ������� ������: "TcaUserManager" MUID: (56C428E4014A)

{$Include w:\common\components\rtl\Garant\ComboAccess\caDefine.inc}

interface

{$If Defined(UsePostgres) AND Defined(TestComboAccess)}
uses
 l3IntfUses
 , l3ProtoObject
 , daInterfaces
 , daTypes
 , l3DatLst
;

type
 TcaUserManager = class(Tl3ProtoObject, IdaUserManager)
  private
   f_HTManager: IdaUserManager;
   f_PGManager: IdaUserManager;
  private
   function IsUsersEqual(const aLeft: IdaArchiUser;
    const aRight: IdaArchiUser): Boolean;
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
   procedure Cleanup; override;
    {* ������� ������� ����� �������. }
  public
   constructor Create(const aHTManager: IdaUserManager;
    const aPGManager: IdaUserManager); reintroduce;
   class function Make(const aHTManager: IdaUserManager;
    const aPGManager: IdaUserManager): IdaUserManager; reintroduce;
   procedure IterateArchiUsersF(anAction: ArchiUsersIterator_IterateArchiUsersF_Action);
 end;//TcaUserManager
{$IfEnd} // Defined(UsePostgres) AND Defined(TestComboAccess)

implementation

{$If Defined(UsePostgres) AND Defined(TestComboAccess)}
uses
 l3ImplUses
 , l3ListUtils
 , l3Base
;

constructor TcaUserManager.Create(const aHTManager: IdaUserManager;
 const aPGManager: IdaUserManager);
//#UC START# *56C429340002_56C428E4014A_var*
//#UC END# *56C429340002_56C428E4014A_var*
begin
//#UC START# *56C429340002_56C428E4014A_impl*
 inherited Create;
 f_HTManager := aHTManager;
 f_PGManager := aPGManager;
//#UC END# *56C429340002_56C428E4014A_impl*
end;//TcaUserManager.Create

class function TcaUserManager.Make(const aHTManager: IdaUserManager;
 const aPGManager: IdaUserManager): IdaUserManager;
var
 l_Inst : TcaUserManager;
begin
 l_Inst := Create(aHTManager, aPGManager);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TcaUserManager.Make

function TcaUserManager.IsUsersEqual(const aLeft: IdaArchiUser;
 const aRight: IdaArchiUser): Boolean;
//#UC START# *57359E8903CF_56C428E4014A_var*
//#UC END# *57359E8903CF_56C428E4014A_var*
begin
//#UC START# *57359E8903CF_56C428E4014A_impl*
 Result := (aLeft = nil) = (aRight = nil);
 if Result and Assigned(aLeft) then
  Result := (aLeft.ID = aRight.ID) and
   (aLeft.Active = aRight.Active) and
   (aLeft.HasAdminRights = aRight.HasAdminRights) and
   (aLeft.IP = aRight.IP) and
   (aLeft.LoginName = aRight.LoginName) and
   (aLeft.Password = aRight.Password) and
   (aLeft.UserName = aRight.UserName);
//#UC END# *57359E8903CF_56C428E4014A_impl*
end;//TcaUserManager.IsUsersEqual

function TcaUserManager.CheckPassword(const aLogin: AnsiString;
 const aPassword: AnsiString;
 RequireAdminRights: Boolean;
 out theUserID: TdaUserID): TdaLoginError;
//#UC START# *5628D14D0151_56C428E4014A_var*
var
 l_Result: TdaLoginError;
 l_UserID: TdaUserID;
//#UC END# *5628D14D0151_56C428E4014A_var*
begin
//#UC START# *5628D14D0151_56C428E4014A_impl*
 Result := f_HTManager.CheckPassword(aLogin, aPassword, RequireAdminRights, theUserID);
 l_Result := f_PGManager.CheckPassword(aLogin, aPassword, RequireAdminRights, l_UserID);
 Assert((Result = l_Result) and (theUserID = l_UserID))
//#UC END# *5628D14D0151_56C428E4014A_impl*
end;//TcaUserManager.CheckPassword

function TcaUserManager.IsUserAdmin(anUserID: TdaUserID): Boolean;
//#UC START# *56EA993D0218_56C428E4014A_var*
//#UC END# *56EA993D0218_56C428E4014A_var*
begin
//#UC START# *56EA993D0218_56C428E4014A_impl*
 Result := f_HTManager.IsUserAdmin(anUserID);
 Assert(Result = f_PGManager.IsUserAdmin(anUserID));
//#UC END# *56EA993D0218_56C428E4014A_impl*
end;//TcaUserManager.IsUserAdmin

function TcaUserManager.Get_AllUsers: Tl3StringDataList;
//#UC START# *5715DEF20209_56C428E4014Aget_var*
//#UC END# *5715DEF20209_56C428E4014Aget_var*
begin
//#UC START# *5715DEF20209_56C428E4014Aget_impl*
 !!! Needs to be implemented !!!
//#UC END# *5715DEF20209_56C428E4014Aget_impl*
end;//TcaUserManager.Get_AllUsers

function TcaUserManager.Get_AllGroups: Tl3StringDataList;
//#UC START# *5715DF0D03C2_56C428E4014Aget_var*
//#UC END# *5715DF0D03C2_56C428E4014Aget_var*
begin
//#UC START# *5715DF0D03C2_56C428E4014Aget_impl*
 !!! Needs to be implemented !!!
//#UC END# *5715DF0D03C2_56C428E4014Aget_impl*
end;//TcaUserManager.Get_AllGroups

function TcaUserManager.GetUserName(anUserID: TdaUserID): AnsiString;
//#UC START# *5718B5CF0399_56C428E4014A_var*
//#UC END# *5718B5CF0399_56C428E4014A_var*
begin
//#UC START# *5718B5CF0399_56C428E4014A_impl*
 Result := f_HTManager.GetUserName(anUserID);
 Assert(Result = f_PGManager.GetUserName(anUserID));
//#UC END# *5718B5CF0399_56C428E4014A_impl*
end;//TcaUserManager.GetUserName

function TcaUserManager.GetUserPriorities(aGroupId: TdaUserID;
 var aImportPriority: TdaPriority;
 var aExportPriority: TdaPriority): Boolean;
//#UC START# *571DCFB50217_56C428E4014A_var*
//#UC END# *571DCFB50217_56C428E4014A_var*
begin
//#UC START# *571DCFB50217_56C428E4014A_impl*
 !!! Needs to be implemented !!!
//#UC END# *571DCFB50217_56C428E4014A_impl*
end;//TcaUserManager.GetUserPriorities

procedure TcaUserManager.ReSortUserList;
//#UC START# *5721F5E60367_56C428E4014A_var*
//#UC END# *5721F5E60367_56C428E4014A_var*
begin
//#UC START# *5721F5E60367_56C428E4014A_impl*
 !!! Needs to be implemented !!!
//#UC END# *5721F5E60367_56C428E4014A_impl*
end;//TcaUserManager.ReSortUserList

function TcaUserManager.Get_ArchiUsersCount: Integer;
//#UC START# *5729C59E00D5_56C428E4014Aget_var*
//#UC END# *5729C59E00D5_56C428E4014Aget_var*
begin
//#UC START# *5729C59E00D5_56C428E4014Aget_impl*
 Result := f_HTManager.ArchiUsersCount;
 Assert(Result = f_PGManager.ArchiUsersCount);
//#UC END# *5729C59E00D5_56C428E4014Aget_impl*
end;//TcaUserManager.Get_ArchiUsersCount

procedure TcaUserManager.IterateArchiUsersF(anAction: ArchiUsersIterator_IterateArchiUsersF_Action);
//#UC START# *5729DD530330_56C428E4014A_var*
//#UC END# *5729DD530330_56C428E4014A_var*
begin
//#UC START# *5729DD530330_56C428E4014A_impl*
 f_HTManager.ForEachF(anAction);
//#UC END# *5729DD530330_56C428E4014A_impl*
end;//TcaUserManager.IterateArchiUsersF

function TcaUserManager.UserByID(aID: TdaUserID): IdaArchiUser;
//#UC START# *57358B940211_56C428E4014A_var*
var
 l_Check: IdaArchiUser;
//#UC END# *57358B940211_56C428E4014A_var*
begin
//#UC START# *57358B940211_56C428E4014A_impl*
 Result := f_HTManager.UserByID(aID);
 l_Check := f_PGManager.UserByID(aID);
 Assert(IsUsersEqual(Result, l_Check));
//#UC END# *57358B940211_56C428E4014A_impl*
end;//TcaUserManager.UserByID

function TcaUserManager.UserByLogin(const aLogin: AnsiString): IdaArchiUser;
//#UC START# *57358BCB0360_56C428E4014A_var*
var
 l_Check: IdaArchiUser;
//#UC END# *57358BCB0360_56C428E4014A_var*
begin
//#UC START# *57358BCB0360_56C428E4014A_impl*
 Result := f_HTManager.UserByLogin(aLogin);
 l_Check := f_PGManager.UserByLogin(aLogin);
 Assert(IsUsersEqual(Result, l_Check));
//#UC END# *57358BCB0360_56C428E4014A_impl*
end;//TcaUserManager.UserByLogin

procedure TcaUserManager.UpdateUserInfo(aUserID: TdaUserID;
 aIsGroup: Boolean);
//#UC START# *5735AE4D0017_56C428E4014A_var*
//#UC END# *5735AE4D0017_56C428E4014A_var*
begin
//#UC START# *5735AE4D0017_56C428E4014A_impl*
 f_HTManager.UpdateUserInfo(aUserID, aIsGroup);
 f_PGManager.UpdateUserInfo(aUserID, aIsGroup);
//#UC END# *5735AE4D0017_56C428E4014A_impl*
end;//TcaUserManager.UpdateUserInfo

procedure TcaUserManager.MakeFullArchiUsersList;
//#UC START# *5735AE7F0071_56C428E4014A_var*
//#UC END# *5735AE7F0071_56C428E4014A_var*
begin
//#UC START# *5735AE7F0071_56C428E4014A_impl*
 f_HTManager.MakeFullArchiUsersList;
 f_PGManager.MakeFullArchiUsersList;
//#UC END# *5735AE7F0071_56C428E4014A_impl*
end;//TcaUserManager.MakeFullArchiUsersList

function TcaUserManager.GetUserDisplayName(anID: TdaUserID): AnsiString;
//#UC START# *5735AECA0121_56C428E4014A_var*
//#UC END# *5735AECA0121_56C428E4014A_var*
begin
//#UC START# *5735AECA0121_56C428E4014A_impl*
 Result := f_HTManager.GetUserDisplayName(anID);
 Assert(Result = f_PGManager.GetUserDisplayName(anID));
//#UC END# *5735AECA0121_56C428E4014A_impl*
end;//TcaUserManager.GetUserDisplayName

function TcaUserManager.IsUserExists(anID: TdaUserID): Boolean;
//#UC START# *5739732402E4_56C428E4014A_var*
//#UC END# *5739732402E4_56C428E4014A_var*
begin
//#UC START# *5739732402E4_56C428E4014A_impl*
 Result := f_HTManager.IsUserExists(anID);
 Assert(Result = f_PGManager.IsUserExists(anID));
//#UC END# *5739732402E4_56C428E4014A_impl*
end;//TcaUserManager.IsUserExists

procedure TcaUserManager.RegisterUserStatusChangedSubscriber(const aSubscriber: IdaUserStatusChangedSubscriber);
//#UC START# *5739832A00A2_56C428E4014A_var*
//#UC END# *5739832A00A2_56C428E4014A_var*
begin
//#UC START# *5739832A00A2_56C428E4014A_impl*
 !!! Needs to be implemented !!!
//#UC END# *5739832A00A2_56C428E4014A_impl*
end;//TcaUserManager.RegisterUserStatusChangedSubscriber

procedure TcaUserManager.UnRegisterUserStatusChangedSubscriber(const aSubscriber: IdaUserStatusChangedSubscriber);
//#UC START# *5739834700B2_56C428E4014A_var*
//#UC END# *5739834700B2_56C428E4014A_var*
begin
//#UC START# *5739834700B2_56C428E4014A_impl*
 !!! Needs to be implemented !!!
//#UC END# *5739834700B2_56C428E4014A_impl*
end;//TcaUserManager.UnRegisterUserStatusChangedSubscriber

procedure TcaUserManager.NotifyUserActiveChanged(anUserID: TdaUserID;
 anActive: Boolean);
//#UC START# *5739835200CF_56C428E4014A_var*
//#UC END# *5739835200CF_56C428E4014A_var*
begin
//#UC START# *5739835200CF_56C428E4014A_impl*
 !!! Needs to be implemented !!!
//#UC END# *5739835200CF_56C428E4014A_impl*
end;//TcaUserManager.NotifyUserActiveChanged

procedure TcaUserManager.Cleanup;
 {* ������� ������� ����� �������. }
//#UC START# *479731C50290_56C428E4014A_var*
//#UC END# *479731C50290_56C428E4014A_var*
begin
//#UC START# *479731C50290_56C428E4014A_impl*
 f_HTManager := nil;
 f_PGManager := nil;
 inherited;
//#UC END# *479731C50290_56C428E4014A_impl*
end;//TcaUserManager.Cleanup
{$IfEnd} // Defined(UsePostgres) AND Defined(TestComboAccess)

end.
