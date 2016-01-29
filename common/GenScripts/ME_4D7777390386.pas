unit ComplexScrollParams;

interface

uses
 l3IntfUses
 , TextEditorVisitor
 , nevVScrollerSpy
 , PrimTextLoad_Form
 , Types
;

type
 TComplexScrollParams = class(TTextEditorVisitor, InevVScrollerPosLogger)
  function GetSubNumber(aFirst: Boolean): Integer;
  procedure DoVisit(aForm: TPrimTextLoadForm);
   {* Обработать текст }
  function OpenLog: AnsiString;
  procedure CloseLog(const aLogName: AnsiString);
 end;//TComplexScrollParams
 
implementation

uses
 l3ImplUses
 , SysUtils
 , TestFrameWork
;

end.
