unit pgUserManager;

interface

uses
 l3IntfUses
 , l3ProtoObject
 , daInterfaces
 , daTypes
;

type
 TpgUserManager = class(Tl3ProtoObject, IdaUserManager)
  procedure Create(const aFactory: IdaTableQueryFactory);
  function Make(const aFactory: IdaTableQueryFactory): IdaUserManager;
  function CheckPassword(const aLogin: AnsiString;
   const aPassword: AnsiString;
   RequireAdminRights: Boolean;
   out theUserID: TdaUserID): TdaLoginError;
 end;//TpgUserManager
 
implementation

uses
 l3ImplUses
 , SysUtils
 , daScheme
;

end.
