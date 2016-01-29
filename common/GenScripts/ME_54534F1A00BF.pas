unit ncsReceiveThread;

interface

uses
 l3IntfUses
 , ncsTransporterIOThread
;

type
 TncsReceiveThread = class(TncsTransporterIOThread)
 end;//TncsReceiveThread
 
implementation

uses
 l3ImplUses
 , Classes
 , l3TempMemoryStream
 , SysUtils
 , l3Base
 , ncsMessage
 , ncsMessageFactory
 , evdNcsTypes
 , ncsProfile
;

end.
