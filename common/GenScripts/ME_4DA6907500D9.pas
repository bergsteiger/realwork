unit LinesTest;

interface

uses
 l3IntfUses
 , TextEditorVisitor
 , l3FrameLinesSpy
 , PrimTextLoad_Form
 , l3InternalInterfaces
;

type
 TLinesTest = class(TTextEditorVisitor, Il3FrameLinesLogger)
  {* Тестирование отрисовки линий. }
  procedure DoVisit(aForm: TPrimTextLoadForm);
   {* Обработать текст }
  function OpenLinesLog(const aCanvas: Il3InfoCanvas;
   aObjID: Integer): AnsiString;
  procedure CloseLinesLog(const aLogName: AnsiString);
  function GetPrecision: Integer;
 end;//TLinesTest
 
implementation

uses
 l3ImplUses
 , SysUtils
 , TestFrameWork
;

end.
