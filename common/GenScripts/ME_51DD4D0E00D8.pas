unit destListoverride;

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
 TdestListoverride = class(TddRTFDestination)
  procedure Close(aState: TddRTFState;
   aNewDest: TddRTFDestination);
  procedure WriteText(aRDS: TRDS;
   aText: Tl3String;
   aState: TddRTFState);
 end;//TdestListoverride
 
implementation

uses
 l3ImplUses
 , SysUtils
 , destListOverrideTable
;

end.
