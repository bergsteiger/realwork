unit SelectRowAndDeleteTest;

interface

uses
 l3IntfUses
 , TextViaEditorProcessor
 , PrimTextLoad_Form
;

type
 TSelectRowAndDeleteTest = class(TTextViaEditorProcessor)
  {* Выделить строку и удалить. }
  procedure Process(aForm: TPrimTextLoadForm);
   {* Собственно процесс обработки текста }
 end;//TSelectRowAndDeleteTest
 
implementation

uses
 l3ImplUses
 , TestFrameWork
 , evOp
 , evCursorTools
;

end.
