unit ScrollAndCheckCursorTest;

interface

uses
 l3IntfUses
 , TextEditorVisitor
 , PrimTextLoad_Form
;

type
 TScrollAndCheckCursorTest = class(TTextEditorVisitor)
  procedure DoVisit(aForm: TPrimTextLoadForm);
   {* ���������� ����� }
 end;//TScrollAndCheckCursorTest
 
implementation

uses
 l3ImplUses
 , TestFrameWork
;

end.
