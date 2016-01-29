unit ClickOnCommentTest;

interface

uses
 l3IntfUses
 , TextViaEditorProcessor
 , PrimTextLoad_Form
 , evCustomEditorWindow
;

type
 TClickOnCommentTest = class(TTextViaEditorProcessor)
  {* Тестирование кликанья мышью на заголовке комментария. }
  procedure Process(aForm: TPrimTextLoadForm);
   {* Собственно процесс обработки текста }
  function CheckCollapsed(aText: TevCustomEditorWindow): Boolean;
 end;//TClickOnCommentTest
 
implementation

uses
 l3ImplUses
 , TestFrameWork
 , nevTools
 , l3Base
;

end.
