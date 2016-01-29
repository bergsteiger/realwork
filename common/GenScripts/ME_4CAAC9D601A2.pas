unit InsertRowTest;

interface

uses
 l3IntfUses
 , TextViaEditorProcessor
 , PrimTextLoad_Form
;

type
 TInsertRowTest = class(TTextViaEditorProcessor)
  {* Тест вставки строки }
  procedure Process(aForm: TPrimTextLoadForm);
   {* Собственно процесс обработки текста }
 end;//TInsertRowTest
 
implementation

uses
 l3ImplUses
 , evOp
 , TestFrameWork
;

end.
