unit DrawTest;

interface

uses
 l3IntfUses
 , DrawTestPrim
 , PrimTextLoad_Form
;

type
 TDrawTest = class(TDrawTestPrim, TDrawTestPrim)
  {* ���� ����: ���������� � �������� � ��������. }
  procedure DoBeforeDrawing(aForm: TPrimTextLoadForm);
   {* ���������� �����-������ �������� ����� ����������. }
 end;//TDrawTest
 
implementation

uses
 l3ImplUses
 , TestFrameWork
;

end.
