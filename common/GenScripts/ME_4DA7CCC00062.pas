unit WholeSelectionWithMouseTest;

interface

uses
 l3IntfUses
 , TextEditorVisitor
 , PrimTextLoad_Form
;

type
 TWholeSelectionWithMouseTest = class(TTextEditorVisitor)
  {* ��������� � ������� ���� ����� ��������� (� ����������). }
  procedure DoVisit(aForm: TPrimTextLoadForm);
   {* ���������� ����� }
 end;//TWholeSelectionWithMouseTest
 
implementation

uses
 l3ImplUses
 , nevGUIInterfaces
 , nevBase
 , l3Units
 , l3Base
 , Windows
 , TestFrameWork
;

end.
