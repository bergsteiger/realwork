unit destFontTable;

interface

uses
 l3IntfUses
 , l3StringList
 , ddRTFProperties
 , ddRTFdestination
 , ddRTFState
 , RTFtypes
 , l3Base
 , ddCustomRTFReader
;

type
 TddFontTable = class(Tl3StringList)
 end;//TddFontTable
 
 TdestFontTable = class(TddRTFDestination)
  procedure AddFont;
  function FontByNumber(aNumber: Integer): TddFontEntry;
  procedure Close(aState: TddRTFState;
   aNewDest: TddRTFDestination);
  procedure WriteText(aRDS: TRDS;
   aText: Tl3String;
   aState: TddRTFState);
 end;//TdestFontTable
 
implementation

uses
 l3ImplUses
 , SysUtils
;

end.
