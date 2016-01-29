unit VerticalCursorMovingTest;

interface

uses
 l3IntfUses
 , TextEditorVisitor
 , PrimTextLoad_Form
;

type
 TVerticalCursorMovingTest = class(TTextEditorVisitor)
  {* Тест вертикального перемещения курсора. }
  procedure DoVisit(aForm: TPrimTextLoadForm);
   {* Обработать текст }
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
