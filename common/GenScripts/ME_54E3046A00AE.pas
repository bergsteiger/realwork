unit destWrite2Parent;

interface

uses
 l3IntfUses
 , destSkip
 , ddRTFdestination
 , ddCustomRTFReader
 , RTFtypes
 , l3Base
 , ddRTFState
;

type
 TdestWrite2Parent = class(TdestSkip)
  procedure Create(aRTFReader: TddCustomRTFReader;
   aParent: TddRTFDestination);
 end;//TdestWrite2Parent
 
implementation

uses
 l3ImplUses
;

end.
