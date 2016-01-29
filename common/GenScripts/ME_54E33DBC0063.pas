unit ncsSynchroCompatibilityClientTransporter;

interface

uses
 l3IntfUses
 , ncsSynchroClientTransporter
 , CsQueryTypes
 , ncsMessageInterfaces
;

type
 TncsSynchroCompatibilityClientTransporter = class(TncsSynchroClientTransporter)
  procedure Create(aQueryID: TCsQueryId);
  function Make(aQueryID: TCsQueryId): IncsClientTransporter;
 end;//TncsSynchroCompatibilityClientTransporter
 
implementation

uses
 l3ImplUses
 , CsConst
;

end.
