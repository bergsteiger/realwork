unit destShapeRslt;

interface

uses
 l3IntfUses
 , destNorm
 , ddRTFState
 , ddRTFShape
 , l3Base
 , RTFtypes
;

type
 TdestShapeRslt = class(TdestNorm)
  procedure Apply2Shape(aState: TddRTFState;
   aShape: TddRTFShape);
 end;//TdestShapeRslt
 
implementation

uses
 l3ImplUses
 , ddPicture
;

end.
