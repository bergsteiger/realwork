unit nevControlsBlockModelControlMapper;

interface

uses
 l3IntfUses
 , k2InterfaceMapper
 , l3Variant
 , l3IID
;

type
 TnevControlsBlockModelControlMapper = class(Tk2InterfaceMapper)
  function Make(aTag: Tl3Variant;
   const IID: Tl3GUID;
   out Tool;
   const aProcessor: Ik2Processor): Boolean;
 end;//TnevControlsBlockModelControlMapper
 
implementation

uses
 l3ImplUses
 , k2Tags
 , SysUtils
;

end.
