unit destShapeTxt;

interface

uses
 l3IntfUses
 , destNorm
 , ddRTFState
 , ddRTFShape
;

type
 TdestShapeTxt = class(TdestNorm)
  procedure Apply2Shape(aState: TddRTFState;
   aShape: TddRTFShape);
 end;//TdestShapeTxt
 
implementation

uses
 l3ImplUses
;

end.
