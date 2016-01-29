unit ncsSynchroServerTransporter;

interface

uses
 l3IntfUses
 , ncsSynchroTransporter
 , ncsMessageInterfaces
 , csIdIOHandlerAbstractAdapter
;

type
 TncsSynchroServerTransporter = class(TncsSynchroTransporter, IncsServerTransporter)
  procedure Create(anIOHandler: TcsIdIOHandlerAbstractAdapter;
   const aSessionID: AnsiString);
  function IntMake(anIOHandler: TcsIdIOHandlerAbstractAdapter;
   const aSessionID: AnsiString): IncsServerTransporter;
  function Make(anIOHandler: TcsIdIOHandlerAbstractAdapter): IncsServerTransporter;
  procedure ProcessMessages(IsMainSocket: Boolean);
  procedure Terminate(WaitForTermination: Boolean);
  function Terminated: Boolean;
  procedure RegisterSendBackHandler(aHandler: TcsIdIOHandlerAbstractAdapter);
  procedure HandShake;
 end;//TncsSynchroServerTransporter
 
implementation

uses
 l3ImplUses
 , SysUtils
 , ncsProfile
 , Classes
 , l3TempMemoryStream
 , ncsMessage
 , ncsMessageFactory
 , l3Base
;

end.
