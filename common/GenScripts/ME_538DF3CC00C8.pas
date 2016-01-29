unit csLoopBack;

interface

uses
 l3IntfUses
 , CsQueryTypes
 , CsCommon
 , CsDataPipe
 , CsQueryRequester
 , CsReplyProceduresPrim
;

type
 TcsLoopBack = class
  procedure ExecuteQuery(aQueryId: TCsQueryId;
   aClientID: TCsClientId;
   aPipe: TCsDataPipe;
   aQueryProc: TCsQueryProc;
   aReplyProcedures: TCsReplyProceduresPrim);
  function ProcessInternal(aQueryId: TCsQueryId): Boolean;
 end;//TcsLoopBack
 
implementation

uses
 l3ImplUses
 , CsQueryRequesterTool
 , CsReplyTool
;

end.
