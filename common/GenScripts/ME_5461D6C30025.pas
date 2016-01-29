unit ncsReplyDescription;

interface

uses
 l3IntfUses
 , l3ProtoObject
 , ncsMessage
 , SyncObjs
 , Windows
;

type
 TncsReplyDescription = class(Tl3ProtoObject)
  procedure Create(aMessage: TncsMessage);
  procedure RequestEvent;
  function WaitForReply(aTimeOut: LongWord): Boolean;
  procedure AbortWait;
 end;//TncsReplyDescription
 
implementation

uses
 l3ImplUses
 , SysUtils
 , l3Base
 , l3Utils
;

end.
