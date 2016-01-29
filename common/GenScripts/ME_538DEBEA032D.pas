unit CsReplyTool;

interface

uses
 l3IntfUses
 , CsDataPipe
 , CsReplyProceduresPrim
 , CsCommon
 , CsQueryTypes
;

type
 TcsProcessQueryProc = function(aQueryId: TCsQueryId): Boolean of object;
 
 TCsReplyTool = class
  procedure ProcessQuery(aPipe: TCsDataPipe;
   aProcessQueryProc: TcsProcessQueryProc;
   aReplyProcedures: TCsReplyProceduresPrim;
   aLogMessages: Boolean;
   out theClientId: TCsClientId);
 end;//TCsReplyTool
 
implementation

uses
 l3ImplUses
 , l3Base
 , TypInfo
 , CsErrors
 , CsConst
 , SysUtils
 , CsProcWithId
;

end.
