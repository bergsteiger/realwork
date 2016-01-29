unit CsProcWithId;

interface

uses
 l3IntfUses
 , CsObject
 , CsQueryTypes
 , CsDataPipe
;

type
 TCsReplyProc = procedure(aPipe: TCsDataPipe) of object;
 
 TCsProcWithId = class(TCsObject)
  procedure Create(aQueryId: TCsQueryId;
   aProc: TCsReplyProc);
 end;//TCsProcWithId
 
implementation

uses
 l3ImplUses
;

end.
