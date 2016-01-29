unit ncsClientTransporter;

interface

uses
 l3IntfUses
 , ncsTransporter
 , ncsMessageInterfaces
 , idComponent
 , ncsTCPClient
;

type
 TncsClientArray = array [TncsSocketKind] of TncsTCPClient;
 
 TncsClientTransporter = class(TncsTransporter, IncsClientTransporter)
  procedure TransportConnected;
  procedure SendTransportStatus(ASender: TObject;
   const AStatus: TIdStatus;
   const AStatusText: AnsiString);
  procedure Create;
  function Make: IncsClientTransporter;
  procedure ReceiveTransportStatus(ASender: TObject;
   const AStatus: TIdStatus;
   const AStatusText: AnsiString);
  procedure BeforeSendHandshake;
  procedure BeforeReceiveHandshake;
  procedure Connect(const aServerHost: AnsiString;
   aServerPort: Integer;
   const aSessionID: AnsiString);
  procedure Disconnect(Immidiate: Boolean);
   {* Immidiate = True - отрубить сразу
Immidiate = False - дождаться завершения обмена послав ncsDisconnect и дождавшись ответа }
  procedure HandShake;
  function HandShakeKind: TncsSocketKind;
 end;//TncsClientTransporter
 
implementation

uses
 l3ImplUses
 , SysUtils
 , l3Base
 , IdException
 , csIdIOHandlerAdapter
 , csIdIOHandlerAbstractAdapter
 , ncsMessage
;

end.
