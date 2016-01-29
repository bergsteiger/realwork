unit CsReplyProceduresWithRegistering;

interface

uses
 l3IntfUses
 , CsReplyProceduresPrim
 , CsQueryTypes
 , CsProcWithId
;

type
 TCsReplyProceduresWithRegistering = class(TCsReplyProceduresPrim)
  procedure Register(aQueryId: TCsQueryId;
   aProc: TCsReplyProc);
  procedure UnregisterAll;
 end;//TCsReplyProceduresWithRegistering
 
implementation

uses
 l3ImplUses
 , l3Base
 , TypInfo
 , SysUtils
;

end.
