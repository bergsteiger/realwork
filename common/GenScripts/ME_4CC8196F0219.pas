unit MergeAndCheck;

interface

uses
 l3IntfUses
 , DrawTestPrim
 , PrimTextLoad_Form
;

type
 TMergeAndCheck = class(TDrawTestPrim)
  {* ���� ����������� ����� � ��������� ������������� }
  procedure DoBeforeDrawing(aForm: TPrimTextLoadForm);
   {* ���������� �����-������ �������� ����� ����������. }
 end;//TMergeAndCheck
 
implementation

uses
 l3ImplUses
 , TestFrameWork
 , evOp
 , evCursorTools
;

end.
