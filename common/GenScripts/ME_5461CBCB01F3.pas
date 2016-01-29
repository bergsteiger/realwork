unit destShp;

interface

uses
 l3IntfUses
 , ddRTFdestination
 , destShapeTxt
 , destShapeInst
 , destNorm
 , destShapeRslt
 , ddRTFState
 , RTFtypes
 , l3Base
;

type
 TdestShp = class(TddRTFDestination)
  procedure Close(aState: TddRTFState;
   aNewDest: TddRTFDestination);
  procedure WriteText(aRDS: TRDS;
   aText: Tl3String;
   aState: TddRTFState);
 end;//TdestShp
 
implementation

uses
 l3ImplUses
 , ddRTFShape
 , ddPicture
 , SysUtils
;

end.
