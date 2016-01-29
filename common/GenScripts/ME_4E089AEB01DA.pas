unit vcmMessageQueue;

interface

uses
 l3IntfUses
 , vcmMessageQueuePrim
;

type
 TvcmMessageQueue = class(TvcmMessageQueuePrim)
  function Exists: Boolean;
 end;//TvcmMessageQueue
 
implementation

uses
 l3ImplUses
;

end.
