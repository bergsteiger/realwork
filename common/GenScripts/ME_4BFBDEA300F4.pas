unit ScrollBackTest;

interface

uses
 l3IntfUses
 , PrimScrollTest
 , PrimTextLoad_Form
;

type
 TScrollBackTest = class(TPrimScrollTest)
  {* ���� �������������� ��������� � �������� ������� }
  procedure DoVisit(aForm: TPrimTextLoadForm);
   {* ���������� ����� }
 end;//TScrollBackTest
 
implementation

uses
 l3ImplUses
 , TestFrameWork
;

end.
