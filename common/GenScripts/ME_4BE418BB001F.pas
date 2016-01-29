unit TextEditorVisitorPrim;

interface

uses
 l3IntfUses
 , TextViaEditorProcessorPrim
 , PrimTextLoad_Form
;

type
 TTextEditorVisitorPrim = class(TTextViaEditorProcessorPrim)
  {* Тест, работающий с текстом документа через редактор, но не изменяющий его }
  procedure VisitText(const aStr: AnsiString);
   {* Собственно процедура обработки текста }
  procedure DoVisit(aForm: TPrimTextLoadForm);
   {* Обработать текст }
  function TreatExceptionAsSuccess: Boolean;
 end;//TTextEditorVisitorPrim
 
implementation

uses
 l3ImplUses
 , TestFrameWork
 , l3Base
 , k2OperationContainer
;

end.
