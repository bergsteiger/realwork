unit DeleteSectionBreakTest;

interface

uses
 l3IntfUses
 , DrawTestPrim
 , PrimTextLoad_Form
;

type
 TDeleteSectionBreakTest = class(TDrawTestPrim)
  {* ���� �� �������� �������. }
  procedure DoBeforeDrawing(aForm: TPrimTextLoadForm);
   {* ���������� �����-������ �������� ����� ����������. }
 end;//TDeleteSectionBreakTest
 
implementation

uses
 l3ImplUses
 , evCursorTools
 , TestFrameWork
;

end.
