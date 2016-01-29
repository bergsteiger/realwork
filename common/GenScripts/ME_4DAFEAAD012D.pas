unit InsertFormulaTest;

interface

uses
 l3IntfUses
 , TextViaEditorProcessor
 , PrimTextLoad_Form
;

type
 TInsertFormulaTest = class(TTextViaEditorProcessor)
  {* Тест на вставку формулы. }
  function GetFormulaText: AnsiString;
  procedure Process(aForm: TPrimTextLoadForm);
   {* Собственно процесс обработки текста }
 end;//TInsertFormulaTest
 
implementation

uses
 l3ImplUses
 , TestFrameWork
;

end.
