unit evReqRowModelControlMapper;

interface

uses
 l3IntfUses
 , k2InterfaceMapper
 , l3Variant
 , l3IID
;

type
 TevReqRowModelControlMapper = class(Tk2InterfaceMapper)
  function Make(aTag: Tl3Variant;
   const IID: Tl3GUID;
   out Tool;
   const aProcessor: Ik2Processor): Boolean;
 end;//TevReqRowModelControlMapper
 
implementation

uses
 l3ImplUses
 , SysUtils
 , k2Tags
;

end.
