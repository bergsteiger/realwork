unit ddFormulaSegment;

interface

uses
 l3IntfUses
 , ddObjectSegment
 , ddTextSegment
;

type
 TddFormulaSegment = class(TddObjectSegment)
  function Clone: TddTextSegment;
 end;//TddFormulaSegment
 
implementation

uses
 l3ImplUses
;

end.
