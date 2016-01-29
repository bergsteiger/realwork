unit l3CustomControlCanvas;

interface

uses
 l3IntfUses
 , l3WinControlCanvas
 , Controls
 , l3Interfaces
;

type
 Tl3CustomControlCanvas = class(Tl3WinControlCanvas)
  procedure Create(aControl: TCustomControl;
   const aCaret: Il3Caret);
 end;//Tl3CustomControlCanvas
 
implementation

uses
 l3ImplUses
;

type
 THackControl = class(TCustomControl)
 end;//THackControl
 
end.
