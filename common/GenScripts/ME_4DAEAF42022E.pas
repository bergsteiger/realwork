unit nevScroller;

interface

uses
 l3IntfUses
 , nevViewControl
 , nevTools
;

type
 TnevScroller = class(TnevViewControl, InevScroller)
  procedure Top;
  procedure Bottom;
  procedure PageUp;
  function PageDown: Boolean;
  procedure LineUp(aCount: Integer);
  procedure LineDown(aCount: Integer);
  function Min: Integer;
  function Max: Integer;
  function Page: Integer;
  function Pos: Integer;
  function ScrollTo(aPosition: Integer): Boolean;
  procedure WheelUp;
  procedure WheelDown;
  procedure EndScroll;
 end;//TnevScroller
 
implementation

uses
 l3ImplUses
;

end.
