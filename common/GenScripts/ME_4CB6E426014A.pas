unit ScrollByLineTest;

interface

uses
 l3IntfUses
 , TextEditorVisitor
 , PrimTextLoad_Form
;

type
 TScrollByLineTest = class(TTextEditorVisitor)
  {* Тест прокрутки вниз построчно }
  procedure DoVisit(aForm: TPrimTextLoadForm);
   {* Обработать текст }
 end;//TScrollByLineTest
 
implementation

uses
 l3ImplUses
 , TestFrameWork
;

end.
