unit destListLevel;

interface

uses
 l3IntfUses
 , ddRTFdestination
 , rtfListTable
 , ddRTFState
 , RTFtypes
 , l3Base
 , ddCustomRTFReader
;

type
 TdestListLevel = class(TddRTFDestination)
  procedure Close(aState: TddRTFState;
   aNewDest: TddRTFDestination);
  procedure WriteText(aRDS: TRDS;
   aText: Tl3String;
   aState: TddRTFState);
 end;//TdestListLevel
 
implementation

uses
 l3ImplUses
 , SysUtils
 , destList
;

end.
