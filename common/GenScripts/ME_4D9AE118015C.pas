unit ScrollUpAndDownAndCheckShapes;

interface

uses
 l3IntfUses
 , DrawTest
 , PrimTextLoad_Form
;

type
 TScrollUpAndDownAndCheckShapes = class(TDrawTest)
  {* Прокрутка вниз, потом вверх и сравнение разультатов. }
  function GetScrollCount(aUp: Boolean): Integer;
 end;//TScrollUpAndDownAndCheckShapes
 
implementation

uses
 l3ImplUses
 , TestFrameWork
 , evMsgCode
 , evOp
 , l3InternalInterfaces
 , Forms
;

end.
