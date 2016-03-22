unit caUserManager;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "ComboAccess"
// Модуль: "w:/common/components/rtl/Garant/ComboAccess/caUserManager.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For Archi::ComboAccess::Provider::TcaUserManager
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\ComboAccess\caDefine.inc}

interface

{$If defined(TestComboAccess) AND defined(UsePostgres)}
uses
  l3ProtoObject,
  daInterfaces,
  daTypes
  ;
{$IfEnd} //TestComboAccess AND UsePostgres

{$If defined(TestComboAccess) AND defined(UsePostgres)}
type
 TcaUserManager = class(Tl3ProtoObject, IdaUserManager)
 private
 // private fields
   f_HTManager : IdaUserManager;
   f_PGManager : IdaUserManager;
 protected
 // realized methods
   function CheckPassword(const aLogin: AnsiString;
    const aPassword: AnsiString;
    RequireAdminRights: Boolean;
    out theUserID: TdaUserID): TdaLoginError;
   function IsUserAdmin(anUserID: TdaUserID): Boolean;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
 public
 // public methods
   constructor Create(const aHTManager: IdaUserManager;
     const aPGManager: IdaUserManager); reintroduce;
   class function Make(const aHTManager: IdaUserManager;
     const aPGManager: IdaUserManager): IdaUserManager; reintroduce;
     {* Сигнатура фабрики TcaUserManager.Make }
 end;//TcaUserManager
{$IfEnd} //TestComboAccess AND UsePostgres

implementation

{$If defined(TestComboAccess) AND defined(UsePostgres)}

// start class TcaUserManager

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
end;

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

procedure TcaUserManager.Cleanup;
//#UC START# *479731C50290_56C428E4014A_var*
//#UC END# *479731C50290_56C428E4014A_var*
begin
//#UC START# *479731C50290_56C428E4014A_impl*
 f_HTManager := nil;
 f_PGManager := nil;
 inherited;
//#UC END# *479731C50290_56C428E4014A_impl*
end;//TcaUserManager.Cleanup

{$IfEnd} //TestComboAccess AND UsePostgres

end.