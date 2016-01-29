unit ncsTransporterIOThread;

interface

uses
 l3IntfUses
 , ncsTransporterThread
 , csIdIOHandlerAbstractAdapter
;

type
 TncsTransporterIOThread = class(TncsTransporterThread)
  procedure ReleaseIOHandler;
 end;//TncsTransporterIOThread
 
implementation

uses
 l3ImplUses
 , SysUtils
;

end.
