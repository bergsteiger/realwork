unit VerticalCursorMovingTest;

interface

uses
 l3IntfUses
 , TextEditorVisitor
 , PrimTextLoad_Form
;

type
 TVerticalCursorMovingTest = class(TTextEditorVisitor)
  {* ���� ������������� ����������� �������. }
  procedure DoVisit(aForm: TPrimTextLoadForm);
   {* ���������� ����� }
 end;//TVerticalCursorMovingTest
 
implementation

uses
 l3ImplUses
 , nevBase
 , TestFrameWork
 , evMsgCode
 , evOp
;

end.
