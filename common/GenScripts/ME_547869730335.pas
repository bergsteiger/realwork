unit RectWrap;

interface

uses
 l3IntfUses
 , Classes
 , Types
;

type
 TRectWrap = class(TPersistent)
  procedure Create(const aRect: TRect);
 end;//TRectWrap
 
implementation

uses
 l3ImplUses
;

end.
