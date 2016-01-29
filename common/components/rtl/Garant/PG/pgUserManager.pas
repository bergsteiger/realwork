unit pgUserManager;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "PG"
// Модуль: "w:/common/components/rtl/Garant/PG/pgUserManager.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For Archi::PG::Provider::TpgUserManager
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\PG\pgDefine.inc}

interface

{$If defined(UsePostgres)}
uses
  l3ProtoObject,
  daInterfaces,
  daTypes
  ;
{$IfEnd} //UsePostgres

{$If defined(UsePostgres)}
type
 TpgUserManager = class(Tl3ProtoObject, IdaUserManager)
 private
 // private fields
   f_Factory : IdaTableQueryFactory;
   f_PasswordQuery : IdaQuery;
   f_UserFlagsQuery : IdaQuery;
 protected
 // realized methods
   function CheckPassword(const aLogin: AnsiString;
    const aPassword: AnsiString;
    RequireAdminRights: Boolean;
    out theUserID: TdaUserID): TdaLoginError;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
 public
 // public methods
   constructor Create(const aFactory: IdaTableQueryFactory); reintroduce;
   class function Make(const aFactory: IdaTableQueryFactory): IdaUserManager; reintroduce;
     {* Сигнатура фабрики TpgUserManager.Make }
 end;//TpgUserManager
{$IfEnd} //UsePostgres

implementation

{$If defined(UsePostgres)}
uses
  SysUtils,
  daScheme
  ;
{$IfEnd} //UsePostgres

{$If defined(UsePostgres)}

// start class TpgUserManager

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
end;

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

procedure TpgUserManager.Cleanup;
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

{$IfEnd} //UsePostgres

end.