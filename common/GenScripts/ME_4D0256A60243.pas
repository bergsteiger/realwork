unit AutoBlockTest;

interface

uses
 l3IntfUses
 , TextViaEditorProcessor
 , PrimTextLoad_Form
;

type
 TAutoBlockTest = class(TTextViaEditorProcessor)
  {* Тест разбиения документа на блоки }
  procedure Process(aForm: TPrimTextLoadForm);
   {* Собственно процесс обработки текста }
 end;//TAutoBlockTest
 
implementation

uses
 l3ImplUses
 , evAutoBlock
 , TestFrameWork
;

end.
