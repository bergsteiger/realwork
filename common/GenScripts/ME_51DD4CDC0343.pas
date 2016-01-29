unit destListTable;

interface

uses
 l3IntfUses
 , ddRTFdestination
 , rtfListTable
 , destList
 , ddRTFState
 , RTFtypes
 , l3Base
 , ddCustomRTFReader
;

type
 TdestListTable = class(TddRTFDestination)
  procedure AddList(aList: TdestList);
  procedure Close(aState: TddRTFState;
   aNewDest: TddRTFDestination);
  procedure WriteText(aRDS: TRDS;
   aText: Tl3String;
   aState: TddRTFState);
 end;//TdestListTable
 
implementation

uses
 l3ImplUses
 , SysUtils
;

end.
