unit ncsProcessThread;

interface

uses
 l3IntfUses
 , ncsTransporterThread
 , ncsReplyWaiter
 , ncsMessageInterfaces
 , ncsMessage
 , ncsMessageQueue
;

type
 TncsProcessThread = class(TncsTransporterThread)
  procedure ProcessMessage(aMessage: TncsMessage);
  procedure Create(anQueue: TncsMessageQueue;
   const aTransporter: IncsTransporter;
   aWaiter: TncsReplyWaiter);
 end;//TncsProcessThread
 
implementation

uses
 l3ImplUses
 , SysUtils
 , l3Base
 , ncsMessageExecutorFactory
 , evdNcsTypes
;

end.
