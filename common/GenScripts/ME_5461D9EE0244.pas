unit ncsReplyWaiter;

interface

uses
 l3IntfUses
 , l3ProtoObject
 , ncsReplyDecsriptionList
 , ncsMessage
 , Windows
 , ncsReplyDescription
;

type
 TncsReplyWaiter = class(Tl3ProtoObject)
  function FindDesc(aMessage: TncsMessage): TncsReplyDescription;
  procedure SubmitReply(aMessage: TncsMessage);
  procedure SubmitMessage(aMessage: TncsMessage);
  procedure Clear;
  function WaitForReply(aMessage: TncsMessage;
   var theReply: TncsMessage;
   aTimeOut: LongWord): Boolean;
 end;//TncsReplyWaiter
 
implementation

uses
 l3ImplUses
 , SysUtils
 , l3Base
;

end.
