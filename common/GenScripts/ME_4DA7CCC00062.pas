unit WholeSelectionWithMouseTest;

interface

uses
 l3IntfUses
 , TextEditorVisitor
 , PrimTextLoad_Form
;

type
 TWholeSelectionWithMouseTest = class(TTextEditorVisitor)
  {* Выделение с помощью мыши всего документа (с прокруткой). }
  procedure DoVisit(aForm: TPrimTextLoadForm);
   {* Обработать текст }
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
