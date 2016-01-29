unit l3ControlCanvas;

interface

uses
 l3IntfUses
 , l3Canvas
 , l3Interfaces
 , Controls
 , l3Units
;

type
 Tl3ControlCanvas = class(Tl3Canvas)
  procedure Create(aControl: TControl;
   const aCaret: Il3Caret);
 end;//Tl3ControlCanvas
 
implementation

uses
 l3ImplUses
;

end.
