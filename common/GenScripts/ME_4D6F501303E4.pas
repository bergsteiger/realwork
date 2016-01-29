unit DrawSelectionInTableTest;

interface

uses
 l3IntfUses
 , TextEditorVisitor
 , evDelayedPaintersSpy
 , PrimTextLoad_Form
 , Types
;

type
 TDrawSelectionInTableTest = class(TTextEditorVisitor, IevDelayedPainterLogger)
  {* Тест для проверки правильности отрисовки выделения в таблице }
  procedure DoVisit(aForm: TPrimTextLoadForm);
   {* Обработать текст }
  function OpenSelectionLog: AnsiString;
  procedure CloseSelectionLog(const aLogName: AnsiString);
 end;//TDrawSelectionInTableTest
 
implementation

uses
 l3ImplUses
 , SysUtils
 , TestFrameWork
 , evOp
 , evCursorTools
;

end.
