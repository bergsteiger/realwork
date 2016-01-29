unit ddPictureSegment;

interface

uses
 l3IntfUses
 , ddObjectSegment
 , ddTextSegment
;

type
 TddPictureSegment = class(TddObjectSegment)
  function Clone: TddTextSegment;
 end;//TddPictureSegment
 
implementation

uses
 l3ImplUses
;

end.
