unit l3WinControlCanvas;

interface

uses
 l3IntfUses
 , l3ControlCanvas
 , Controls
 , l3Interfaces
 , Windows
;

type
 Tl3WinControlCanvas = class(Tl3ControlCanvas)
  procedure Create(aControl: TWinControl;
   const aCaret: Il3Caret);
 end;//Tl3WinControlCanvas
 
implementation

uses
 l3ImplUses
 , l3CanvasPrim
 , l3Base
;

type
 THackWinControl = class(TWinControl)
 end;//THackWinControl
 
end.
