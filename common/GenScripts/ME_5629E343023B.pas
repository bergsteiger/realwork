unit htUserManager;

// Модуль: "w:\common\components\rtl\Garant\HT\htUserManager.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\rtl\Garant\HT\htDefineDA.inc}

interface

uses
 l3IntfUses
 , l3ProtoObject
 , daInterfaces
 , daTypes
;

type
 ThtUserManager = class(Tl3ProtoObject, IdaUserManager)
  protected
   function CheckPassword(const aLogin: AnsiString;
    const aPassword: AnsiString;
    RequireAdminRights: Boolean;
    out theUserID: TdaUserID): TdaLoginError;
  public
   constructor Create; reintroduce;
   class function Make: IdaUserManager; reintroduce;
 end;//ThtUserManager

implementation

uses
 l3ImplUses
 {$If NOT Defined(Nemesis)}
 , dt_Serv
 {$IfEnd} // NOT Defined(Nemesis)
;

constructor ThtUserManager.Create;
//#UC START# *5629F0F901C8_5629E343023B_var*
//#UC END# *5629F0F901C8_5629E343023B_var*
begin
//#UC START# *5629F0F901C8_5629E343023B_impl*
 inherited Create;
// !!! Needs to be implemented !!!
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

end.
