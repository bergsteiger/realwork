unit ScrollBackByLineTest;

interface

uses
 l3IntfUses
 , PrimScrollTest
 , PrimTextLoad_Form
;

type
 TScrollBackByLineTest = class(TPrimScrollTest)
  {* ��������� ��������� ����� ����� }
  procedure DoVisit(aForm: TPrimTextLoadForm);
   {* ���������� ����� }
 end;//TScrollBackByLineTest
 
implementation

uses
 l3ImplUses
 , TestFrameWork
;

end.
