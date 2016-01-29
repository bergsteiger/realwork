unit K259163541;

interface

uses
 l3IntfUses
 , ScrollUpAndDownAndCheckShapes
 , Types
;

type
 TK259163541 = class(TScrollUpAndDownAndCheckShapes)
  {* [$259163541] }
  function GetScrollCount(aUp: Boolean): Integer;
 end;//TK259163541
 
implementation

uses
 l3ImplUses
 , TestFrameWork
;

end.
