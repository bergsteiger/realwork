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
   procedure MakeFullArchiUsersList;
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
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   constructor Create(const aFactory: IdaTableQueryFactory); reintroduce;
   class function Make(const aFactory: IdaTableQueryFactory): IdaUserManager; reintroduce;
   procedure IterateArchiUsersF(anAction: ArchiUsersIterator_IterateArchiUsersF_Action);
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

procedure TpgUserManager.MakeFullArchiUsersList;
//#UC START# *57347AFF018E_5629FC88034B_var*
//#UC END# *57347AFF018E_5629FC88034B_var*
begin
//#UC START# *57347AFF018E_5629FC88034B_impl*
 Assert(False);
//!! !!! Needs to be implemented !!!
//#UC END# *57347AFF018E_5629FC88034B_impl*
end;//TpgUserManager.MakeFullArchiUsersList

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
