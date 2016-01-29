unit npNavigatorListCBT;

interface

uses
 l3IntfUses
 , npNavigatorListPrim
 , l3Interfaces
;

type
 TnpNavigatorListCBT = class(TnpNavigatorListPrim, Il3CBTListener)
  procedure CBTListenerNotify(Code: Integer;
   WParam: WPARAM;
   LParam: LPARAM;
   var theResult: Tl3HookProcResult);
 end;//TnpNavigatorListCBT
 
implementation

uses
 l3ImplUses
 , l3ListenersManager
;

end.
