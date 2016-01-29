unit destList;

interface

uses
 l3IntfUses
 , ddRTFdestination
 , rtfListTable
 , destListLevel
 , ddRTFState
 , RTFtypes
 , l3Base
 , ddCustomRTFReader
;

type
 TdestList = class(TddRTFDestination)
  procedure AddLevel(aLevel: TdestListLevel);
  procedure Close(aState: TddRTFState;
   aNewDest: TddRTFDestination);
  procedure WriteText(aRDS: TRDS;
   aText: Tl3String;
   aState: TddRTFState);
 end;//TdestList
 
implementation

uses
 l3ImplUses
 , SysUtils
 , destListTable
;

end.
