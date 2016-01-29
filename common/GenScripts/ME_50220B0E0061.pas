unit vtScrollBar;

interface

uses
 l3IntfUses
 , Controls
 , Forms
 , Classes
 , StdCtrls
 , Messages
;

type
 TvtScrollBarAlign = (
  sbalNone
  , sbalTop
  , sbalRight
  , sbalBottom
  , sbalLeft
 );//TvtScrollBarAlign
 
 TvtScrollBar = class(TWinControl)
  procedure DoScroll(ScrollCode: TScrollCode;
   var ScrollPos: Integer);
  procedure DoChange;
  procedure SetParams(APosition: Integer;
   AMin: Integer;
   AMax: Integer);
  procedure DoWMScroll(var Msg: TWMScroll);
  function InUpdating: Boolean;
  procedure WMHScroll(var Msg: TWMHScroll);
  procedure WMVScroll(var Msg: TWMVScroll);
 end;//TvtScrollBar
 
implementation

uses
 l3ImplUses
 , Consts
 , Windows
 , afwFacade
 , TtfwClassRef_Proxy
;

end.
