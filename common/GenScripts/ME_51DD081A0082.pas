unit destWord6Number;

interface

uses
 l3IntfUses
 , ddRTFdestination
 , ddRTFState
 , RTFtypes
 , l3Base
;

type
 TdestWord6Number = class(TddRTFDestination)
  {* Текст нумерации в стиле Word 6/95 }
  procedure Close(aState: TddRTFState;
   aNewDest: TddRTFDestination);
  procedure WriteText(aRDS: TRDS;
   aText: Tl3String;
   aState: TddRTFState);
 end;//TdestWord6Number
 
implementation

uses
 l3ImplUses
 , destNorm
;

end.
