unit ncsCompatibilityClientTransporter;

interface

uses
 l3IntfUses
 , ncsClientTransporter
 , CsQueryTypes
 , ncsMessageInterfaces
;

type
 TncsCompatibilityClientTransporter = class(TncsClientTransporter)
  procedure Create(aQueryID: TCsQueryId);
  function Make(aQueryID: TCsQueryId): IncsClientTransporter;
 end;//TncsCompatibilityClientTransporter
 
implementation

uses
 l3ImplUses
 , CsConst
;

end.
