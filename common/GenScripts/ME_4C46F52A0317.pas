unit DrawLineTest;

interface

uses
 l3IntfUses
 , TextViaEditorProcessor
 , PrimTextLoad_Form
;

type
 TDrawLineTest = class(TTextViaEditorProcessor)
  {* Тест рисования линии в документе }
  procedure Process(aForm: TPrimTextLoadForm);
   {* Собственно процесс обработки текста }
 end;//TDrawLineTest
 
implementation

uses
 l3ImplUses
 , evOp
 , nevBase
 , evMsgCode
 , TestFrameWork
;

end.
