unit csTaskRequest;

interface

uses
 l3IntfUses
 , ddGetTaskRequestPrim
 , ddTaskResultRequestPrim
;

type
 TddGetTaskRequest = class(TddGetTaskRequestPrim)
 end;//TddGetTaskRequest
 
 TddTaskResultRequest = class(TddTaskResultRequestPrim)
 end;//TddTaskResultRequest
 
implementation

uses
 l3ImplUses
;

end.
