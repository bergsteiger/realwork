unit ComplexScrollByLines;

interface

uses
 l3IntfUses
 , TextEditorVisitor
 , PrimTextLoad_Form
;

type
 TComplexScrollByLines = class(TTextEditorVisitor)
  {* “ест вида - прокрутили на несколько строк вниз, а потом на несколько вверх. }
  function GetScrollLineCount2Down: Integer;
   {* количество строк дл€ прокрутки вниз }
  function GetScrollLineCount2Up: Integer;
   {* количество строк дл€ прокрутки вверх }
  procedure DoVisit(aForm: TPrimTextLoadForm);
   {* ќбработать текст }
 end;//TComplexScrollByLines
 
implementation

uses
 l3ImplUses
 , TestFrameWork
;

end.
