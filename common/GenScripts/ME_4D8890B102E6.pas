unit MouseSelectPtTest;

interface

uses
 l3IntfUses
 , TextEditorVisitor
 , PrimTextLoad_Form
;

type
 TMouseSelectPtTest = class(TTextEditorVisitor)
  {* ���� �������� ����� �� ������������ �����. }
  procedure DoVisit(aForm: TPrimTextLoadForm);
   {* ���������� ����� }
 end;//TMouseSelectPtTest
 
implementation

uses
 l3ImplUses
 , TestFrameWork
 , nevTools
 , l3Base
;

end.
