unit ncsServerTransporterPool;

interface

uses
 l3IntfUses
 , l3ProtoObject
 , ncsServerTransporterList
 , ncsMessageInterfaces
;

type
 TncsServerTransporterPool = class(Tl3ProtoObject)
  procedure Register(const aTransporter: IncsServerTransporter);
  procedure UnRegister(const aTransporter: IncsServerTransporter);
  procedure TerminateAll;
 end;//TncsServerTransporterPool
 
implementation

uses
 l3ImplUses
 , SysUtils
;

end.
