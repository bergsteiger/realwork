unit nscFocusLabel;

interface

uses
 l3IntfUses
 , vtFocusLabel
 , Messages
;

type
 TnscFocusLabel = class(TvtFocusLabel)
  procedure SetHotTruck(aValue: Boolean);
  procedure UpdateTruckFromCursor;
  procedure CMMouseEnter(var Message: TMessage);
  procedure CMMouseLeave(var Message: TMessage);
  procedure WMWindowPosChanged(var Message: TMessage);
 end;//TnscFocusLabel
 
implementation

uses
 l3ImplUses
 , Windows
;

end.
