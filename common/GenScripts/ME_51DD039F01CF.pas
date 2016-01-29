unit destLevelText;

interface

uses
 l3IntfUses
 , ddRTFdestination
 , l3Memory
 , ddRTFState
 , RTFtypes
 , l3Base
 , ddCustomRTFReader
;

type
 TdestLevelText = class(TddRTFDestination)
  procedure Close(aState: TddRTFState;
   aNewDest: TddRTFDestination);
  procedure WriteText(aRDS: TRDS;
   aText: Tl3String;
   aState: TddRTFState);
 end;//TdestLevelText
 
implementation

uses
 l3ImplUses
 , destListLevel
 , SysUtils
 , l3Types
 , l3String
;

end.
