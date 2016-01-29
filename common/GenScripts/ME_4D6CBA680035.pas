unit ShowBaseSearchTest;

interface

uses
 l3IntfUses
 , TextEditorVisitor
 , PrimTextLoad_Form
;

type
 TShowBaseSearchTest = class(TTextEditorVisitor)
  {* Тест показа базового поиска }
  procedure ShowBaseSearch(aForm: TPrimTextLoadForm);
  procedure DoVisit(aForm: TPrimTextLoadForm);
   {* Обработать текст }
 end;//TShowBaseSearchTest
 
implementation

uses
 l3ImplUses
 , F1LikeFormWithBS_Form
 , TestFrameWork
 , Types
 , Messages
 , Windows
;

end.
