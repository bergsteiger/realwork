unit ncsMessageInterfaces;

interface

uses
 l3IntfUses
 , CsCommon
 , ncsMessage
 , Windows
 , csIdIOHandlerAbstractAdapter
;

type
 IncsTransporter = interface
  procedure Send(aMessage: TncsMessage);
  function WaitForReply(aMessage: TncsMessage;
   var theReply: TncsMessage;
   aTimeOut: LongWord): Boolean;
 end;//IncsTransporter
 
 TncsExecuteContext = object
 end;//TncsExecuteContext
 
 IncsExecutor = interface
  procedure Execute(const aContext: TncsExecuteContext);
 end;//IncsExecutor
 
 IncsMessageExecutorFactory = interface
  function MakeExecutor(aMessage: TncsMessage): IncsExecutor;
 end;//IncsMessageExecutorFactory
 
 PIncsMessageExecutorFactory = ^IncsMessageExecutorFactory;
 
 IncsClientTransporter = interface(IncsTransporter)
  procedure Connect(const aServerHost: AnsiString;
   aServerPort: Integer;
   const aSessionID: AnsiString);
  procedure Disconnect(Immidiate: Boolean);
   {* Immidiate = True - отрубить сразу
Immidiate = False - дождаться завершения обмена послав ncsDisconnect и дождавшись ответа }
 end;//IncsClientTransporter
 
 IncsServerTransporter = interface(IncsTransporter)
  procedure ProcessMessages(IsMainSocket: Boolean);
  procedure Terminate(WaitForTermination: Boolean);
  procedure RegisterSendBackHandler(aHandler: TcsIdIOHandlerAbstractAdapter);
 end;//IncsServerTransporter
 
 TncsSocketKind = (
  ncs_skSend
  , ncs_skReceive
 );//TncsSocketKind
 
implementation

uses
 l3ImplUses
;

end.
