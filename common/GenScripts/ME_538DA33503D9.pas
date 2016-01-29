unit CsQueryRequesterTool;

interface

uses
 l3IntfUses
 , CsQueryTypes
 , CsCommon
 , CsDataPipe
 , CsQueryRequester
;

type
 TCsQueryRequesterTool = class
  function ExecuteQuery(aQueryId: TCsQueryId;
   aClientID: TCsClientId;
   aPipe: TCsDataPipe;
   aQueryProc: TCsQueryProc;
   aWrite2Log: Boolean): Boolean;
 end;//TCsQueryRequesterTool
 
implementation

uses
 l3ImplUses
 , l3Base
 , CsConst
 , TypInfo
;

end.
