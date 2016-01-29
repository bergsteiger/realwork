unit ncsSynchroClientTransporter;

interface

uses
 l3IntfUses
 , ncsSynchroTransporter
 , ncsMessageInterfaces
 , ncsTCPClient
 , idComponent
;

type
 TncsSynchroClientTransporter = class(TncsSynchroTransporter, IncsClientTransporter)
  procedure Create;
  function Make: IncsClientTransporter;
  procedure TransportStatus(ASender: TObject;
   const AStatus: TIdStatus;
   const AStatusText: AnsiString);
  procedure TransportConnected;
  procedure BeforeHandshake;
  procedure Connect(const aServerHost: AnsiString;
   aServerPort: Integer;
   const aSessionID: AnsiString);
  procedure Disconnect(Immidiate: Boolean);
   {* Immidiate = True - �������� �����
Immidiate = False - ��������� ���������� ������ ������ ncsDisconnect � ���������� ������ }
  procedure HandShake;
 end;//TncsSynchroClientTransporter
 
implementation

uses
 l3ImplUses
 , csIdIOHandlerAdapter
 , csIdIOHandlerAbstractAdapter
 , l3Base
 , IdException
 , SysUtils
 , ncsMessage
;

end.
