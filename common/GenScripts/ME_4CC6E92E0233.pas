unit DeleteColumnToolTest;

interface

uses
 l3IntfUses
 , TextViaEditorProcessor
 , PrimTextLoad_Form
;

type
 TDeleteColumnToolTest = class(TTextViaEditorProcessor)
  {* Тест удаления колонки через редактор }
  procedure Process(aForm: TPrimTextLoadForm);
   {* Собственно процесс обработки текста }
 end;//TDeleteColumnToolTest
 
implementation

uses
 l3ImplUses
 , evCursorTools
 , nevTools
 , TestFrameWork
;

end.
