unit MouseSelectPtTest;

interface

uses
 l3IntfUses
 , TextEditorVisitor
 , PrimTextLoad_Form
;

type
 TMouseSelectPtTest = class(TTextEditorVisitor)
  {* Тест щелканья мышью по определенной точке. }
  procedure DoVisit(aForm: TPrimTextLoadForm);
   {* Обработать текст }
 end;//TMouseSelectPtTest
 
implementation

uses
 l3ImplUses
 , TestFrameWork
 , nevTools
 , l3Base
;

end.
