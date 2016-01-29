unit ncsSendThread;

interface

uses
 l3IntfUses
 , ncsTransporterIOThread
 , ncsMessage
;

type
 TncsSendThread = class(TncsTransporterIOThread)
  procedure Send(aMessage: TncsMessage);
 end;//TncsSendThread
 
implementation

uses
 l3ImplUses
 , SysUtils
 , ncsProfile
 , l3TempMemoryStream
 , Classes
;

end.
