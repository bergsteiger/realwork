unit ScrollTest;

interface

uses
 l3IntfUses
 , PrimScrollTest
 , PrimTextLoad_Form
;

type
 TScrollTest = class(TPrimScrollTest)
  {* ���� �������������� ��������� }
  procedure DoVisit(aForm: TPrimTextLoadForm);
   {* ���������� ����� }
 end;//TScrollTest
 
implementation

uses
 l3ImplUses
 , TestFrameWork
;

end.
