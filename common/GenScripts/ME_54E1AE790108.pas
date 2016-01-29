unit destStyleSheet;

interface

uses
 l3IntfUses
 , ddRTFdestination
 , l3StringList
 , ddRTFProperties
 , ddRTFState
 , RTFtypes
 , l3Base
 , ddCustomRTFReader
;

type
 TdestStyleSheet = class(TddRTFDestination)
  procedure AddStyle;
  function StyleByNumber(aNumber: Integer): TddStyleEntry;
  procedure Close(aState: TddRTFState;
   aNewDest: TddRTFDestination);
  procedure WriteText(aRDS: TRDS;
   aText: Tl3String;
   aState: TddRTFState);
 end;//TdestStyleSheet
 
implementation

uses
 l3ImplUses
 , SysUtils
;

end.
