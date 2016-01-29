unit OvcBase;

interface

uses
 l3IntfUses
 , Controls
 , OvcController
;

type
 TOvcBase = class(TCustomControl)
  {* base class for Orpheus components. Provides controller access. }
 end;//TOvcBase
 
implementation

uses
 l3ImplUses
 , TtfwClassRef_Proxy
;

end.
