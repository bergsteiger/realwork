unit destlfolevel;

interface

uses
 l3IntfUses
 , ddRTFdestination
 , destListoverride
 , ddCustomRTFReader
 , ddRTFState
 , RTFtypes
 , l3Base
;

type
 Tdestlfolevel = class(TddRTFDestination)
  procedure Create(aRTFReader: TddCustomRTFReader;
   aListOverride: TdestListoverride);
  procedure Close(aState: TddRTFState;
   aNewDest: TddRTFDestination);
  procedure WriteText(aRDS: TRDS;
   aText: Tl3String;
   aState: TddRTFState);
 end;//Tdestlfolevel
 
implementation

uses
 l3ImplUses
;

end.
