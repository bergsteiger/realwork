unit ScrollByArrowAndCheckShapesTest;

interface

uses
 l3IntfUses
 , DrawTest
 , PrimTextLoad_Form
;

type
 TScrollByArrowAndCheckShapesTest = class(TDrawTest)
  {* ���������� �������� �� ������������ ������� � �������� "��������". }
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
