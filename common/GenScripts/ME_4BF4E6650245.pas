unit SelectPtTest;

interface

uses
 l3IntfUses
 , TextEditorVisitor
 , PrimTextLoad_Form
;

type
 TSelectPtTest = class(TTextEditorVisitor)
  {* ���� ���� - ��������� � ������ � ����� �� ��������� ������������ ������-������ ��������� }
  procedure DoVisit(aForm: TPrimTextLoadForm);
   {* ���������� ����� }
 end;//TSelectPtTest
 
implementation

uses
 l3ImplUses
 , l3Units
 , TestFrameWork
;

end.
