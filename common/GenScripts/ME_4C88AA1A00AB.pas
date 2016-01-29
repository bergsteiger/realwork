unit PasteColumnTest;

interface

uses
 l3IntfUses
 , TextViaEditorProcessor
 , PrimTextLoad_Form
;

type
 TPasteColumnTest = class(TTextViaEditorProcessor)
  {* Тест копирования и вставки из буфера колонки с объединенной ячейкой. }
  procedure Process(aForm: TPrimTextLoadForm);
   {* Собственно процесс обработки текста }
 end;//TPasteColumnTest
 
implementation

uses
 l3ImplUses
 , evCursorTools
 , nevTools
 , l3Base
 , TestFrameWork
;

end.
