unit ScrollByArrow;

interface

uses
 l3IntfUses
 , PrimScrollTest
 , PrimTextLoad_Form
;

type
 TScrollByArrow = class(TPrimScrollTest)
  {* ��������� ��������� �������� �� ����������. }
  procedure DoVisit(aForm: TPrimTextLoadForm);
   {* ���������� ����� }
 end;//TScrollByArrow
 
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
