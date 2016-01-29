unit destPicture;

interface

uses
 l3IntfUses
 , destNorm
 , ddPicture
 , RTFtypes
 , l3Base
 , l3Filer
 , l3Parser
 , ddCustomRTFReader
 , ddRTFState
 , ddRTFdestination
;

type
 TdestPicture = class(TdestNorm)
  procedure ApplyToPicture(aWhat: TIProp;
   aValue: LongInt);
  function Try2ReadKnownPicture(const aFiler: Tl3CustomFiler): Tl3String;
   {* ѕытаемс€ передать обработку "знающим" объектам. }
  procedure TryToClearText(aParser: Tl3CustomParser);
  procedure AddHexData(const aHexStream: Tl3String);
 end;//TdestPicture
 
implementation

uses
 l3ImplUses
 , SysUtils
 , ddConst
 , l3Interfaces
;

end.
