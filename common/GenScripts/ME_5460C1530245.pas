unit destShapeInst;

interface

uses
 l3IntfUses
 , ddRTFdestination
 , ddRTFShape
 , ddRTFState
 , RTFtypes
 , l3Base
 , ddCustomRTFReader
;

type
 TdestShapeInst = class(TddRTFDestination)
  function NeedImport: Boolean;
   {* Определят должен ли импортироваться текст из Shape. }
  procedure Apply2Shape(aShape: TddRTFShape);
  procedure Close(aState: TddRTFState;
   aNewDest: TddRTFDestination);
  procedure WriteText(aRDS: TRDS;
   aText: Tl3String;
   aState: TddRTFState);
 end;//TdestShapeInst
 
implementation

uses
 l3ImplUses
;

end.
