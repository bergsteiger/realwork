unit evInevBaseLine4AnchorMapper;

interface

uses
 l3IntfUses
 , k2InterfaceMapper
 , l3Variant
 , l3IID
;

type
 TevInevBaseLine4AnchorMapper = class(Tk2InterfaceMapper)
  function Make(aTag: Tl3Variant;
   const IID: Tl3GUID;
   out Tool;
   const aProcessor: Ik2Processor): Boolean;
 end;//TevInevBaseLine4AnchorMapper
 
implementation

uses
 l3ImplUses
 , nevTools
;

end.
