unit pgUserManager;

// Модуль: "w:\common\components\rtl\Garant\PG\pgUserManager.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TpgUserManager" MUID: (5629FC88034B)

{$Include w:\common\components\rtl\Garant\PG\pgDefine.inc}

interface

{$If Defined(UsePostgres)}
uses
 l3IntfUses
 , l3ProtoObject
 , daInterfaces
 , l3DatLst
 , daArchiUserList
 , daUserStatusChangedSubscriberList
 , daTypes
;

type
 TpgUserManager = class(Tl3ProtoObject, IdaUserManager)
  private
   f_Factory: IdaTableQueryFactory;
   f_PasswordQuery: IdaTabledQuery;
   f_UserFlagsQuery: IdaTabledQuery;
   f_AllUsers: Tl3StringDataList;
   f_AllGroups: Tl3StringDataList;
   f_UserNameQuery: IdaTabledQuery;
   f_ArchiUsers: TdaArchiUserList;
   f_UserStatusChangedSubscriberList: TdaUserStatusChangedSubscriberList;
   f_UserLoginQuery: IdaTabledQuery;
   f_PriorityCalculator: IdaPriorityCalculator;
   f_AllArchiUsersQuery: IdaTabledQuery;
   f_AllGroupsQuery: IdaTabledQuery;
  private
   procedure FillListByResultSet(aList: Tl3StringDataList;
    const aResultSet: IdaResultSet;
    const anIDFieldName: AnsiString;
    aDataSize: Integer;
    const aNameFieldName: AnsiString);
   procedure FillAllUsers(aList: Tl3StringDataList);
   procedure FillAllGroups(aList: Tl3StringDataList);
   procedure SortUsersInList(aList: Tl3StringDataList);
   function UserNameQuery: IdaTabledQuery;
   function UserLoginQuery: IdaTabledQuery;
   function AllArchiUsersQuery: IdaTabledQuery;
   function AllGroupsQuery: IdaTabledQuery;
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
   constructor Create(const aFactory: IdaTableQueryFactory); reintroduce;
   class function Make(const aFactory: IdaTableQueryFactory): IdaUserManager; reintroduce;
   procedure IterateArchiUsersF(anAction: ArchiUsersIterator_IterateArchiUsersF_Action);
   procedure IterateUserGroupsF(anAction: ArchiUsersIterator_IterateUserGroupsF_Action);
 end;//TpgUserManager
{$IfEnd} // Defined(UsePostgres)

implementation

{$If Defined(UsePostgres)}
uses
 l3ImplUses
 , SysUtils
 , daScheme
 , daDataProvider
 , daUserManagerUtils
 , l3Base
 , pgPriorityCalculator
 , daArchiUser
;

constructor TpgUserManager.Create(const aFactory: IdaTableQueryFactory);
//#UC START# *562A074E0321_5629FC88034B_var*
//#UC END# *562A074E0321_5629FC88034B_var*
begin
//#UC START# *562A074E0321_5629FC88034B_impl*
 inherited Create;
 f_Factory := aFactory;

 f_PasswordQuery := f_Factory.MakeTabledQuery(TdaScheme.Instance.Table(da_mtPassword));
 f_PasswordQuery.AddSelectField(f_Factory.MakeSelectField('', TdaScheme.Instance.Table(da_mtPassword)['Password']));
 f_PasswordQuery.AddSelectField(f_Factory.MakeSelectField('', TdaScheme.Instance.Table(da_mtPassword)['User_ID']));
 f_PasswordQuery.WhereCondition := f_Factory.MakeParamsCondition('', TdaScheme.Instance.Table(da_mtPassword)['ShortName'], da_copEqual, 'p_ShortName');
 f_PasswordQuery.Prepare;

 f_UserFlagsQuery := f_Factory.MakeTabledQuery(TdaScheme.Instance.Table(da_mtUsers));
 f_UserFlagsQuery.AddSelectField(f_Factory.MakeSelectField('', TdaScheme.Instance.Table(da_mtUsers)['Active']));
 f_UserFlagsQuery.WhereCondition := f_Factory.MakeParamsCondition('', TdaScheme.Instance.Table(da_mtUsers)['ID'], da_copEqual, 'p_UserID');
 f_UserFlagsQuery.Prepare;
//#UC END# *562A074E0321_5629FC88034B_impl*
end;//TpgUserManager.Create

class function TpgUserManager.Make(const aFactory: IdaTableQueryFactory): IdaUserManager;
var
 l_Inst : TpgUserManager;
begin
 l_Inst := Create(aFactory);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TpgUserManager.Make

procedure TpgUserManager.FillListByResultSet(aList: Tl3StringDataList;
 const aResultSet: IdaResultSet;
 const anIDFieldName: AnsiString;
 aDataSize: Integer;
 const aNameFieldName: AnsiString);
//#UC START# *57172C740069_5629FC88034B_var*
var
 l_ID: TdaUserID;
//#UC END# *57172C740069_5629FC88034B_var*
begin
//#UC START# *57172C740069_5629FC88034B_impl*
 aList.Changing;
 try
  aList.Clear;
  aList.DataSize := SizeOf(l_ID);
  aList.NeedAllocStr := True;
  while not aResultSet.EOF do
  begin
   l_ID := aResultSet.Field[anIDFieldName].AsLargeInt;
   Tl3StringDataList(aList).AddStr(aResultSet.Field[aNameFieldName].AsString, @l_ID);
   aResultSet.Next;
  end;
 finally
  aList.Changed;
 end;
//#UC END# *57172C740069_5629FC88034B_impl*
end;//TpgUserManager.FillListByResultSet

procedure TpgUserManager.FillAllUsers(aList: Tl3StringDataList);
//#UC START# *5715E71600DD_5629FC88034B_var*
//#UC END# *5715E71600DD_5629FC88034B_var*
begin
//#UC START# *5715E71600DD_5629FC88034B_impl*
 !!! Needs to be implemented !!!
//#UC END# *5715E71600DD_5629FC88034B_impl*
end;//TpgUserManager.FillAllUsers

procedure TpgUserManager.FillAllGroups(aList: Tl3StringDataList);
//#UC START# *5715E74402CA_5629FC88034B_var*
//#UC END# *5715E74402CA_5629FC88034B_var*
begin
//#UC START# *5715E74402CA_5629FC88034B_impl*
 !!! Needs to be implemented !!!
//#UC END# *5715E74402CA_5629FC88034B_impl*
end;//TpgUserManager.FillAllGroups

procedure TpgUserManager.SortUsersInList(aList: Tl3StringDataList);
//#UC START# *5715ED0002E0_5629FC88034B_var*

 function l_CompareUsers(I, J: Integer): Integer;
 var
  l_Reg1, l_Reg2: TdaRegionID;
  l_Name1, l_Name2: AnsiString;
 begin
  // сначала сравниваем регионы
  l_Reg1 := GetUserRegion(TdaUserID(aList.DataInt[I]));
  l_Reg2 := GetUserRegion(TdaUserID(aList.DataInt[J]));
  if l_Reg1 <> l_Reg2 then
  begin
   // если регион наш, родной, то он должен быть наверху, однозначно!
   if l_Reg1 = GlobalDataProvider.RegionID then
   begin
    Result := -1;
    Exit;
   end
   else
    if l_Reg2 = GlobalDataProvider.RegionID then
    begin
     Result := 1;
     Exit;
    end
  end;
  // По региону не вышел наверх. Сортируем по имени (к которому название региона уже приклеено)
  l_Name1 := aList.PasStr[I];
  l_Name2 := aList.PasStr[J];
  if l_Name1 < l_Name2 then
   Result := -1
  else
   if l_Name1 > l_Name2 then
    Result := 1
   else
    Result := 0;
 end;

//#UC END# *5715ED0002E0_5629FC88034B_var*
begin
//#UC START# *5715ED0002E0_5629FC88034B_impl*
 aList.SortF(l3LocalStub(@l_CompareUsers));
//#UC END# *5715ED0002E0_5629FC88034B_impl*
end;//TpgUserManager.SortUsersInList

function TpgUserManager.UserNameQuery: IdaTabledQuery;
//#UC START# *5718C16B036E_5629FC88034B_var*
//#UC END# *5718C16B036E_5629FC88034B_var*
begin
//#UC START# *5718C16B036E_5629FC88034B_impl*
 if f_UserNameQuery = nil then
 begin
  f_UserNameQuery := f_Factory.MakeTabledQuery(TdaScheme.Instance.Table(da_mtUsers));
  f_UserNameQuery.AddSelectField(f_Factory.MakeSelectField('', TdaScheme.Instance.Table(da_mtUsers)['user_name']));
  f_UserNameQuery.WhereCondition := f_Factory.MakeParamsCondition('', TdaScheme.Instance.Table(da_mtUsers)['ID'], da_copEqual, 'p_UserID');
  f_UserNameQuery.Prepare;
 end;
 Result := f_UserNameQuery;
//#UC END# *5718C16B036E_5629FC88034B_impl*
end;//TpgUserManager.UserNameQuery

function TpgUserManager.UserLoginQuery: IdaTabledQuery;
//#UC START# *573B0837013B_5629FC88034B_var*
//#UC END# *573B0837013B_5629FC88034B_var*
begin
//#UC START# *573B0837013B_5629FC88034B_impl*
 if f_UserLoginQuery = nil then
 begin
  f_UserLoginQuery := f_Factory.MakeTabledQuery(TdaScheme.Instance.Table(da_mtPassword));
  f_UserNameQuery := f_Factory.MakeTabledQuery(TdaScheme.Instance.Table(da_mtUsers));
  f_UserNameQuery.AddSelectField(f_Factory.MakeSelectField('', TdaScheme.Instance.Table(da_mtPassword)['ShortName']));
  f_UserNameQuery.WhereCondition := f_Factory.MakeParamsCondition('', TdaScheme.Instance.Table(da_mtPassword)['User_ID'], da_copEqual, 'p_UserID');
  f_UserNameQuery.Prepare;
 end;
 Result := f_UserLoginQuery;
//#UC END# *573B0837013B_5629FC88034B_impl*
end;//TpgUserManager.UserLoginQuery

function TpgUserManager.AllArchiUsersQuery: IdaTabledQuery;
//#UC START# *57514203013A_5629FC88034B_var*
//#UC END# *57514203013A_5629FC88034B_var*
begin
//#UC START# *57514203013A_5629FC88034B_impl*
 !!! Needs to be implemented !!!
//#UC END# *57514203013A_5629FC88034B_impl*
end;//TpgUserManager.AllArchiUsersQuery

function TpgUserManager.AllGroupsQuery: IdaTabledQuery;
//#UC START# *575809C5019A_5629FC88034B_var*
//#UC END# *575809C5019A_5629FC88034B_var*
begin
//#UC START# *575809C5019A_5629FC88034B_impl*
 if f_AllGroupsQuery = nil then
 begin
  f_AllGroupsQuery := f_Factory.MakeTabledQuery(f_Factory.MakeSimpleFromClause(TdaScheme.Instance.Table(da_mtGroups)));
  f_AllGroupsQuery.AddSelectField(f_Factory.MakeSelectField('', TdaScheme.Instance.Table(da_mtGroups)['id']));
  f_AllGroupsQuery.AddSelectField(f_Factory.MakeSelectField('', TdaScheme.Instance.Table(da_mtGroups)['group_name']));
  f_AllGroupsQuery.AddOrderBy(f_Factory.MakeSortField(f_AllGroupsQuery.SelectFieldByName('group_name')));
  f_AllGroupsQuery.Prepare;
 end;
 Result := f_AllGroupsQuery;
//#UC END# *575809C5019A_5629FC88034B_impl*
end;//TpgUserManager.AllGroupsQuery

function TpgUserManager.CheckPassword(const aLogin: AnsiString;
 const aPassword: AnsiString;
 RequireAdminRights: Boolean;
 out theUserID: TdaUserID): TdaLoginError;
//#UC START# *5628D14D0151_5629FC88034B_var*
var
 l_ResultSet: IdaResultSet;
 l_Flags: Byte;
//#UC END# *5628D14D0151_5629FC88034B_var*
begin
//#UC START# *5628D14D0151_5629FC88034B_impl*
 theUserID := 0;
 Result := da_leUserParamsWrong;
 if (AnsiLowerCase(aLogin) = c_SupervisorUserName) and not RequireAdminRights then
  Exit;
 f_PasswordQuery.Param['p_ShortName'].AsString := aLogin;
 l_ResultSet := f_PasswordQuery.OpenResultSet;
 try
  if l_ResultSet.IsEmpty then
    Exit;
  if (l_ResultSet.Field['Password'].AsString <> '') and (not AnsiSameText(l_ResultSet.Field['Password'].AsString, aPassword)) then
    Exit;
  theUserID := l_ResultSet.Field['User_ID'].AsLargeInt;
  f_UserFlagsQuery.Param['p_UserID'].AsLargeInt := theUserID;
 finally
  l_ResultSet := nil;
 end;

 if theUserID <> usSupervisor then
 begin
  l_ResultSet := f_UserFlagsQuery.OpenResultSet;
  try
   l_Flags := l_ResultSet.Field['Active'].AsByte;
   if (l_Flags and usActive) <> usActive then
    Exit;
   if RequireAdminRights and ((l_Flags and usAdmin) <> usAdmin) then
   begin
    Result := da_leInsufficientRights;
    Exit;
   end;
   Result := da_leOk;

  finally
   l_ResultSet := nil;
  end;
 end
 else
  Result := da_leOk;
//#UC END# *5628D14D0151_5629FC88034B_impl*
end;//TpgUserManager.CheckPassword

function TpgUserManager.IsUserAdmin(anUserID: TdaUserID): Boolean;
//#UC START# *56EA993D0218_5629FC88034B_var*
var
 l_ResultSet: IdaResultSet;
//#UC END# *56EA993D0218_5629FC88034B_var*
begin
//#UC START# *56EA993D0218_5629FC88034B_impl*
 Result := (anUserID = usSupervisor);
 if not Result then
 begin
  f_UserFlagsQuery.Param['p_UserID'].AsLargeInt := anUserID;
  l_ResultSet := f_UserFlagsQuery.OpenResultSet;
  try
   Result := not l_ResultSet.IsEmpty and ((l_ResultSet.Field['Active'].AsByte and usAdmin) = usAdmin);
  finally
   l_ResultSet := nil;
  end;
 end;
//#UC END# *56EA993D0218_5629FC88034B_impl*
end;//TpgUserManager.IsUserAdmin

function TpgUserManager.Get_AllUsers: Tl3StringDataList;
//#UC START# *5715DEF20209_5629FC88034Bget_var*
//#UC END# *5715DEF20209_5629FC88034Bget_var*
begin
//#UC START# *5715DEF20209_5629FC88034Bget_impl*
 if f_AllUsers = nil then
 begin
  f_AllUsers := Tl3StringDataList.Create;
  FillAllUsers(f_AllUsers);
  SortUsersInList(f_AllUsers);
 end;
 Result:=f_AllUsers;
//#UC END# *5715DEF20209_5629FC88034Bget_impl*
end;//TpgUserManager.Get_AllUsers

function TpgUserManager.Get_AllGroups: Tl3StringDataList;
//#UC START# *5715DF0D03C2_5629FC88034Bget_var*
//#UC END# *5715DF0D03C2_5629FC88034Bget_var*
begin
//#UC START# *5715DF0D03C2_5629FC88034Bget_impl*
 if f_AllGroups = nil then
 begin
  f_AllGroups := Tl3StringDataList.Create;
  FillAllGroups(f_AllGroups);
 end;
 Result := f_AllGroups;
//#UC END# *5715DF0D03C2_5629FC88034Bget_impl*
end;//TpgUserManager.Get_AllGroups

function TpgUserManager.GetUserName(anUserID: TdaUserID): AnsiString;
//#UC START# *5718B5CF0399_5629FC88034B_var*
var
 l_ResultSet: IdaResultSet;
//#UC END# *5718B5CF0399_5629FC88034B_var*
begin
//#UC START# *5718B5CF0399_5629FC88034B_impl*
 UserNameQuery.Param['p_UserID'].AsLargeInt := anUserID;
 l_ResultSet := UserNameQuery.OpenResultSet;
 try
  Result := l_ResultSet.Field['user_name'].AsString;
 finally
  l_ResultSet := nil;
 end;
//#UC END# *5718B5CF0399_5629FC88034B_impl*
end;//TpgUserManager.GetUserName

function TpgUserManager.GetUserPriorities(aGroupId: TdaUserID;
 var aImportPriority: TdaPriority;
 var aExportPriority: TdaPriority): Boolean;
//#UC START# *571DCFB50217_5629FC88034B_var*
//#UC END# *571DCFB50217_5629FC88034B_var*
begin
//#UC START# *571DCFB50217_5629FC88034B_impl*
 !!! Needs to be implemented !!!
//#UC END# *571DCFB50217_5629FC88034B_impl*
end;//TpgUserManager.GetUserPriorities

procedure TpgUserManager.ReSortUserList;
//#UC START# *5721F5E60367_5629FC88034B_var*
//#UC END# *5721F5E60367_5629FC88034B_var*
begin
//#UC START# *5721F5E60367_5629FC88034B_impl*
 !!! Needs to be implemented !!!
//#UC END# *5721F5E60367_5629FC88034B_impl*
end;//TpgUserManager.ReSortUserList

function TpgUserManager.Get_ArchiUsersCount: Integer;
//#UC START# *5729C59E00D5_5629FC88034Bget_var*
//#UC END# *5729C59E00D5_5629FC88034Bget_var*
begin
//#UC START# *5729C59E00D5_5629FC88034Bget_impl*
 Result := 0;
 Assert(False);
//!! !!! Needs to be implemented !!!
//#UC END# *5729C59E00D5_5629FC88034Bget_impl*
end;//TpgUserManager.Get_ArchiUsersCount

procedure TpgUserManager.IterateArchiUsersF(anAction: ArchiUsersIterator_IterateArchiUsersF_Action);
//#UC START# *5729DD530330_5629FC88034B_var*
//#UC END# *5729DD530330_5629FC88034B_var*
begin
//#UC START# *5729DD530330_5629FC88034B_impl*
 Assert(False);
//!! !!! Needs to be implemented !!!
//#UC END# *5729DD530330_5629FC88034B_impl*
end;//TpgUserManager.IterateArchiUsersF

function TpgUserManager.UserByID(aID: TdaUserID): IdaArchiUser;
//#UC START# *57358B940211_5629FC88034B_var*
var
 i: Integer;
 l_AU: IdaArchiUser;
//#UC END# *57358B940211_5629FC88034B_var*
begin
//#UC START# *57358B940211_5629FC88034B_impl*
 Result := nil;
 if f_ArchiUsers.Count = 0 then
  MakeFullArchiUsersList;

 for i := 0 to f_ArchiUsers.Hi do
 begin
  l_AU := f_ArchiUsers.Items[i];
  if l_AU.ID = aID then
  begin
   Result := l_AU;
   break;
  end;
 end
//#UC END# *57358B940211_5629FC88034B_impl*
end;//TpgUserManager.UserByID

function TpgUserManager.UserByLogin(const aLogin: AnsiString): IdaArchiUser;
//#UC START# *57358BCB0360_5629FC88034B_var*
var
 i: Integer;
 l_AU: IdaArchiUser;
//#UC END# *57358BCB0360_5629FC88034B_var*
begin
//#UC START# *57358BCB0360_5629FC88034B_impl*
 Result := nil;
 if f_ArchiUsers.Count = 0 then
  MakeFullArchiUsersList;

 for i := 0 to f_ArchiUsers.Hi do
 begin
  l_AU := f_ArchiUsers.Items[i];
  if CompareText(l_AU.LoginName, aLogin) = 0 then
  begin
   Result := l_AU;
   break;
  end;
 end
//#UC END# *57358BCB0360_5629FC88034B_impl*
end;//TpgUserManager.UserByLogin

procedure TpgUserManager.UpdateUserInfo(aUserID: TdaUserID;
 aIsGroup: Boolean);
//#UC START# *5735AE4D0017_5629FC88034B_var*
//#UC END# *5735AE4D0017_5629FC88034B_var*
begin
//#UC START# *5735AE4D0017_5629FC88034B_impl*
 MakeFullArchiUsersList;
(*
 if not aIsGroup then
 begin
  GetUserInfo(aUserID, l_Username, l_LoginName, l_AFlag);

  l_AU:= xxxUserByID(aUserID);
  if l_AU = nil then
  begin
   l_AU:= IdaArchiUser.Make(CalcUserPriorities);
   try
    l_AU.ID:= aUserID;
    l_AU.UserName:= l_UserName;
    l_AU.LoginName:= l_LoginName;
    l_AU.Active := Boolean(l_AFlag);

   finally
    l3Free(l_AU);
   end;
  end;
 end;
*)
//#UC END# *5735AE4D0017_5629FC88034B_impl*
end;//TpgUserManager.UpdateUserInfo

procedure TpgUserManager.MakeFullArchiUsersList;
//#UC START# *5735AE7F0071_5629FC88034B_var*
//#UC END# *5735AE7F0071_5629FC88034B_var*
begin
//#UC START# *5735AE7F0071_5629FC88034B_impl*
 Assert(False);
//!! !!! Needs to be implemented !!!
//#UC END# *5735AE7F0071_5629FC88034B_impl*
end;//TpgUserManager.MakeFullArchiUsersList

function TpgUserManager.GetUserDisplayName(anID: TdaUserID): AnsiString;
//#UC START# *5735AECA0121_5629FC88034B_var*
var
 l_Name  : AnsiString;
 l_Flags : Byte;
 lUser : IdaArchiUser;
//#UC END# *5735AECA0121_5629FC88034B_var*
begin
//#UC START# *5735AECA0121_5629FC88034B_impl*
 lUser := UserByID(anID);
 if lUser <> nil then
  l_Name := lUser.UserName;
 if l_Name = '' then
  l_Name := 'Пользователь #'+ IntToStr(anID);

 Result := ConcatRegionAndUserNames(GetRegionStringFromUserID(anID), l_Name);
//#UC END# *5735AECA0121_5629FC88034B_impl*
end;//TpgUserManager.GetUserDisplayName

function TpgUserManager.IsUserExists(anID: TdaUserID): Boolean;
//#UC START# *5739732402E4_5629FC88034B_var*
var
 l_ResultSet: IdaResultSet;
//#UC END# *5739732402E4_5629FC88034B_var*
begin
//#UC START# *5739732402E4_5629FC88034B_impl*
 UserNameQuery.Param['p_UserID'].AsLargeInt := anID;
 l_ResultSet := UserNameQuery.OpenResultSet;
 try
  Result := not l_ResultSet.IsEmpty;
 finally
  l_ResultSet := nil;
 end;
//#UC END# *5739732402E4_5629FC88034B_impl*
end;//TpgUserManager.IsUserExists

procedure TpgUserManager.RegisterUserStatusChangedSubscriber(const aSubscriber: IdaUserStatusChangedSubscriber);
//#UC START# *5739832A00A2_5629FC88034B_var*
//#UC END# *5739832A00A2_5629FC88034B_var*
begin
//#UC START# *5739832A00A2_5629FC88034B_impl*
 !!! Needs to be implemented !!!
//#UC END# *5739832A00A2_5629FC88034B_impl*
end;//TpgUserManager.RegisterUserStatusChangedSubscriber

procedure TpgUserManager.UnRegisterUserStatusChangedSubscriber(const aSubscriber: IdaUserStatusChangedSubscriber);
//#UC START# *5739834700B2_5629FC88034B_var*
//#UC END# *5739834700B2_5629FC88034B_var*
begin
//#UC START# *5739834700B2_5629FC88034B_impl*
 !!! Needs to be implemented !!!
//#UC END# *5739834700B2_5629FC88034B_impl*
end;//TpgUserManager.UnRegisterUserStatusChangedSubscriber

procedure TpgUserManager.NotifyUserActiveChanged(anUserID: TdaUserID;
 anActive: Boolean);
//#UC START# *5739835200CF_5629FC88034B_var*
//#UC END# *5739835200CF_5629FC88034B_var*
begin
//#UC START# *5739835200CF_5629FC88034B_impl*
 !!! Needs to be implemented !!!
//#UC END# *5739835200CF_5629FC88034B_impl*
end;//TpgUserManager.NotifyUserActiveChanged

function TpgUserManager.CSCheckPassword(const aLogin: AnsiString;
 const aPassword: AnsiString;
 RequireAdminRights: Boolean;
 out theUserID: TdaUserID): Boolean;
//#UC START# *573AC17202BF_5629FC88034B_var*
var
 l_AU: IdaArchiUser;
 l_HasAdminRights: Boolean;
//#UC END# *573AC17202BF_5629FC88034B_var*
begin
//#UC START# *573AC17202BF_5629FC88034B_impl*
 Result := False;
 if (AnsiLowerCase(aLogin) = c_SupervisorUserName) and not RequireAdminRights then
  Exit;
 l_AU := UserByLogin(aLogin);
 if l_AU <> nil then
 begin
  Result := l_AU.Active and ((l_AU.Password = '') or (AnsiCompareText(aPassword, l_AU.Password) = 0));
  if Result and RequireAdminRights then
   Result := l_AU.HasAdminRights;
  if Result then
  begin
   l_AU.LoginDate := Now;
   theUserID := l_AU.ID;
  end;
 end; // l_AU <> nil
//#UC END# *573AC17202BF_5629FC88034B_impl*
end;//TpgUserManager.CSCheckPassword

procedure TpgUserManager.GetUserInfo(aUser: TdaUserID;
 var aUserName: AnsiString;
 var aLoginName: AnsiString;
 var aActFlag: Byte);
//#UC START# *573AEE9902DF_5629FC88034B_var*
var
 l_ResultSet: IdaResultSet;
//#UC END# *573AEE9902DF_5629FC88034B_var*
begin
//#UC START# *573AEE9902DF_5629FC88034B_impl*
 UserLoginQuery.Param['p_UserID'].AsLargeInt := aUser;
 l_ResultSet := UserLoginQuery.OpenResultSet;
 try
  if not l_ResultSet.IsEmpty then
   aLoginName := l_ResultSet.Field['ShoreName'].AsString
  else
   aLoginName := c_UnknownLogin;
 finally
  l_ResultSet := nil;
 end;
 f_UserFlagsQuery.Param['p_UserID'].AsLargeInt := aUser;
 l_ResultSet := f_UserFlagsQuery.OpenResultSet;
 try
  if not l_ResultSet.IsEmpty then
  begin
   aUserName := l_ResultSet.Field['user_name'].AsString;
   aActFlag := l_ResultSet.Field['Active'].AsByte;
  end
  else
  begin
   aUserName := Format(c_UnknownUserName, [GetRegionStringFromUserID(aUser), aUser]);
   aActFlag := 0; // не активный и не админ
  end;
 finally
  l_ResultSet := nil;
 end;

//#UC END# *573AEE9902DF_5629FC88034B_impl*
end;//TpgUserManager.GetUserInfo

function TpgUserManager.Get_PriorityCalculator: IdaPriorityCalculator;
//#UC START# *575020410175_5629FC88034Bget_var*
//#UC END# *575020410175_5629FC88034Bget_var*
begin
//#UC START# *575020410175_5629FC88034Bget_impl*
 if f_PriorityCalculator = nil then
  f_PriorityCalculator := TpgPriorityCalculator.Make;
 Result := f_PriorityCalculator;
//#UC END# *575020410175_5629FC88034Bget_impl*
end;//TpgUserManager.Get_PriorityCalculator

procedure TpgUserManager.IterateUserGroupsF(anAction: ArchiUsersIterator_IterateUserGroupsF_Action);
//#UC START# *5757D9BB0116_5629FC88034B_var*
var
 Hack : Pointer absolute anAction;
 l_ResultSet: IdaResultSet;
 l_IDField: IdaField;
 l_NameField: IdaField;
//#UC END# *5757D9BB0116_5629FC88034B_var*
begin
//#UC START# *5757D9BB0116_5629FC88034B_impl*
 try
  l_ResultSet := AllGroupsQuery.OpenResultSet;
  try
   l_IDField := l_ResultSet.Field['id'];
   l_NameField := l_ResultSet.Field['group_name'];
   while not l_ResultSet.EOF do
   begin
    if not anAction(l_NameField.AsString, l_IDField.AsInteger) then
     break;
    l_ResultSet.Next;
   end;
  finally
   l_ResultSet := nil;
  end;
 finally
  l3FreeLocalStub(Hack);
 end;//try..finally
//#UC END# *5757D9BB0116_5629FC88034B_impl*
end;//TpgUserManager.IterateUserGroupsF

procedure TpgUserManager.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_5629FC88034B_var*
//#UC END# *479731C50290_5629FC88034B_var*
begin
//#UC START# *479731C50290_5629FC88034B_impl*
 f_PasswordQuery := nil;
 f_UserFlagsQuery := nil;
 f_Factory := nil;
 inherited;
//#UC END# *479731C50290_5629FC88034B_impl*
end;//TpgUserManager.Cleanup
{$IfEnd} // Defined(UsePostgres)

end.
