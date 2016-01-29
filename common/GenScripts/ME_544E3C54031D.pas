unit ncsMessageQueue;

interface

uses
 l3IntfUses
 , l3ProtoObject
 , ncsPriorityMessageList
 , SyncObjs
 , ncsMessage
 , Windows
;

type
 TncsMessageQueue = class(Tl3ProtoObject)
  procedure SignalMessageReady;
  procedure Push(aMessage: TncsMessage);
  function WaitForMessage(aTimeOut: LongWord): Boolean;
  function ExtractMessage(out theMessage: TncsMessage): Boolean;
   {* Увеличивает счетчик theMessage! Требуется theMessage.Free }
 end;//TncsMessageQueue
 
implementation

uses
 l3ImplUses
 , SysUtils
 , l3Types
 , l3Utils
;

end.
