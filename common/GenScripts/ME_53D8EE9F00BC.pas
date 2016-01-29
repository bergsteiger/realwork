unit evIevAnchorIndexMapper;

interface

uses
 l3IntfUses
 , k2InterfaceMapper
 , l3Variant
 , l3IID
;

type
 TevIevAnchorIndexMapper = class(Tk2InterfaceMapper)
  function Make(aTag: Tl3Variant;
   const IID: Tl3GUID;
   out Tool;
   const aProcessor: Ik2Processor): Boolean;
 end;//TevIevAnchorIndexMapper
 
implementation

uses
 l3ImplUses
;

end.
