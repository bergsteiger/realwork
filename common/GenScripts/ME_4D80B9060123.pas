unit ScrollByArrowAndCheckShapesTest;

interface

uses
 l3IntfUses
 , DrawTest
 , PrimTextLoad_Form
;

type
 TScrollByArrowAndCheckShapesTest = class(TDrawTest)
  {* Прокрутить стрелкой до определенной позиции и сравнить "картинку". }
  function GetScrollCount: Integer;
 end;//TScrollByArrowAndCheckShapesTest
 
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
