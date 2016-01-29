unit RoundMarkerValue.imp;

interface

uses
 l3IntfUses
;

type
 _RoundMarkerValue_ = class
  function CalcDelta(aValue: Integer;
   aClientValue: Integer): Integer;
 end;//_RoundMarkerValue_
 
implementation

uses
 l3ImplUses
 , evTableCellUtils
;

end.
