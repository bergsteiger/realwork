unit ncsSynchroTransporter;

interface

uses
 l3IntfUses
 , l3ProtoObject
 , ncsMessageInterfaces
 , CsCommon
 , csIdIOHandlerAbstractAdapter
 , ncsMessage
 , Windows
;

type
 TncsSynchroTransporter = class(Tl3ProtoObject, IncsTransporter)
  procedure SetConnected(aValue: Boolean);
  procedure StartProcessing;
  procedure StopProcessing;
  procedure HandShake;
  procedure TransportStarted;
  procedure ProcessMessage(aMessage: TncsMessage);
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
 end;//TncsSynchroTransporter
 
implementation

uses
 l3ImplUses
 , Classes
 , l3TempMemoryStream
 , ncsProfile
 , SysUtils
 , ncsMessageFactory
 , evdNcsTypes
 , l3Base
 , ncsMessageExecutorFactory
 , DateUtils
;

end.
