unit htUserManager;

interface

uses
 l3IntfUses
 , l3ProtoObject
 , daInterfaces
 , daTypes
;

type
 ThtUserManager = class(Tl3ProtoObject, IdaUserManager)
  procedure Create;
  function Make: IdaUserManager;
  function CheckPassword(const aLogin: AnsiString;
   const aPassword: AnsiString;
   RequireAdminRights: Boolean;
   out theUserID: TdaUserID): TdaLoginError;
 end;//ThtUserManager
 
implementation

uses
 l3ImplUses
 , dt_Serv
;

end.
