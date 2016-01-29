unit ncsTransporter;

interface

uses
 l3IntfUses
 , l3ProtoObject
 , ncsMessageInterfaces
 , ncsMessageQueue
 , ncsSendThread
 , csIdIOHandlerAbstractAdapter
 , ncsReceiveThread
 , ncsProcessThread
 , ncsReplyWaiter
 , CsCommon
 , ncsMessage
 , Windows
;

type
 TncsIOHandlerArray = array [TncsSocketKind] of TcsIdIOHandlerAbstractAdapter;
 
 TncsTransporter = class(Tl3ProtoObject, IncsTransporter)
  procedure SetConnected(aValue: Boolean);
  procedure StartProcessing;
  procedure StopProcessing(WaitForThreads: Boolean);
  procedure HandShake;
  function HandShakeKind: TncsSocketKind;
  procedure TransportStarted;
  procedure Send(aMessage: TncsMessage);
  function WaitForReply(aMessage: TncsMessage;
   var theReply: TncsMessage;
   aTimeOut: LongWord): Boolean;
  function Connected: Boolean;
   {* Есть физический коннект }
  function ClientID: TCsClientId;
  function Processing: Boolean;
   {* Есть полноценная обработка сообщений }
  function SessionID: AnsiString;
 end;//TncsTransporter
 
implementation

uses
 l3ImplUses
 , l3Utils
 , SysUtils
 , evdNcsTypes
;

end.
