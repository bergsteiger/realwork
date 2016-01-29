unit destListOverrideTable;

interface

uses
 l3IntfUses
 , ddRTFdestination
 , rtfListTable
 , destListTable
 , destListoverride
 , ddCustomRTFReader
 , ddRTFState
 , RTFtypes
 , l3Base
;

type
 TdestListOverrideTable = class(TddRTFDestination)
  procedure AddListOverride(aListOverride: TdestListoverride);
  function LS2List(aLS: Integer;
   out aWasRestart: Boolean): TrtfList;
  procedure Create(aRTFReader: TddCustomRTFReader;
   const aDestListTable: TdestListTable);
  procedure Close(aState: TddRTFState;
   aNewDest: TddRTFDestination);
  procedure WriteText(aRDS: TRDS;
   aText: Tl3String;
   aState: TddRTFState);
 end;//TdestListOverrideTable
 
implementation

uses
 l3ImplUses
 , SysUtils
 , ddTypes
;

end.
