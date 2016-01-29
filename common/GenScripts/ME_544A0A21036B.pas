unit ncsServerTransporter;

interface

uses
 l3IntfUses
 , ncsTransporter
 , ncsMessageInterfaces
 , csIdIOHandlerAbstractAdapter
;

type
 TncsServerTransporter = class(TncsTransporter, IncsServerTransporter)
  procedure Create(anIOHandler: TcsIdIOHandlerAbstractAdapter;
   const aSessionID: AnsiString);
  function IntMake(anIOHandler: TcsIdIOHandlerAbstractAdapter;
   const aSessionID: AnsiString): IncsServerTransporter;
  function Make(anIOHandler: TcsIdIOHandlerAbstractAdapter;
   out IsMainSocket: Boolean): IncsServerTransporter;
  procedure ProcessMessages(IsMainSocket: Boolean);
  procedure Terminate(WaitForTermination: Boolean);
  function Terminated: Boolean;
  procedure HandShake;
  function HandShakeKind: TncsSocketKind;
  procedure RegisterSendBackHandler(aHandler: TcsIdIOHandlerAbstractAdapter);
 end;//TncsServerTransporter
 
implementation

uses
 l3ImplUses
 , SysUtils
 , ncsServerTransporterPtrPool
;

end.
