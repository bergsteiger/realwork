unit k2InterfaceMapper;

interface

uses
 l3IntfUses
 , l3Variant
 , l3IID
;

type
 Tk2InterfaceMapper = class
  function Make(aTag: Tl3Variant;
   const IID: Tl3GUID;
   out Tool;
   const aProcessor: Ik2Processor): Boolean;
 end;//Tk2InterfaceMapper
 
implementation

uses
 l3ImplUses
;

end.
