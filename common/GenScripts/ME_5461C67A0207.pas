unit destSkip;

interface

uses
 l3IntfUses
 , ddRTFdestination
 , ddRTFState
 , RTFtypes
 , l3Base
;

type
 TdestSkip = class(TddRTFDestination)
  procedure Close(aState: TddRTFState;
   aNewDest: TddRTFDestination);
  procedure WriteText(aRDS: TRDS;
   aText: Tl3String;
   aState: TddRTFState);
 end;//TdestSkip
 
implementation

uses
 l3ImplUses
;

end.
