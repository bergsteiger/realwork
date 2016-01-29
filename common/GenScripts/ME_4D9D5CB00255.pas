unit K259163553;

interface

uses
 l3IntfUses
 , ScrollUpAndDownAndCheckShapes
 , Types
;

type
 TK259163553 = class(TScrollUpAndDownAndCheckShapes)
  {* [$259163553] }
  function GetScrollCount(aUp: Boolean): Integer;
 end;//TK259163553
 
implementation

uses
 l3ImplUses
 , TestFrameWork
;

end.
