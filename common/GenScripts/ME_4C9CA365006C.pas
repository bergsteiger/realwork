unit CommentAndScrollTest;

interface

uses
 l3IntfUses
 , TextEditorVisitor
 , nevTools
 , PrimTextLoad_Form
;

type
 TCommentAndScrollTest = class(TTextEditorVisitor)
  {* Тест для добавления и удаления комментария и последующего скроллирования. }
  procedure MoveCursor4Insert(aForm: TPrimTextLoadForm);
   {* Переместить курсор перед вставкой комментария. }
  function GetUserComment(const aPoint: InevBasePoint): InevBasePoint;
   {* Получить пользовательский комментарий }
  procedure DoScroll(aForm: TPrimTextLoadForm);
   {* Прокрутка текста в редакторе (если нужна). }
  procedure DoVisit(aForm: TPrimTextLoadForm);
   {* Обработать текст }
 end;//TCommentAndScrollTest
 
implementation

uses
 l3ImplUses
 , evCursorTools
 , evOp
 , evTypes
 , l3Base
 , CommentPara_Const
 , eeEditorExport
 , TestFrameWork
;

end.
