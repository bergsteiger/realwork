unit afwInputControl;

interface

uses
 l3IntfUses
 , afwControl
 , l3InternalInterfaces
 , l3Units
 , l3Interfaces
 , Classes
 , Messages
;

type
 TafwInputControl = class(TafwControl)
  function MouseAction(const aPt: Tl3Point;
   aButton: Tl3MouseButton;
   anAction: Tl3MouseAction;
   aKeys: TShiftState): Tl3MouseResult;
 end;//TafwInputControl
 
implementation

uses
 l3ImplUses
 , Forms
 , TtfwClassRef_Proxy
;

end.
