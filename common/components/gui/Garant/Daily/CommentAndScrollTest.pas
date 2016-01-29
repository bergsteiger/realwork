unit CommentAndScrollTest;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "TestFormsTest"
// Модуль: "w:/common/components/gui/Garant/Daily/CommentAndScrollTest.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Operations For Tests::TestFormsTest::Everest::TCommentAndScrollTest
//
// Тест для добавления и удаления комментария и последующего скроллирования.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\common\components\gui\sdotDefine.inc}

interface

{$If defined(nsTest) AND not defined(NoVCM)}
uses
  nevTools,
  TextEditorVisitor,
  PrimTextLoad_Form
  ;
{$IfEnd} //nsTest AND not NoVCM

{$If defined(nsTest) AND not defined(NoVCM)}
type
 TCommentAndScrollTest = {abstract} class(TTextEditorVisitor)
  {* Тест для добавления и удаления комментария и последующего скроллирования. }
 protected
 // realized methods
   procedure DoVisit(aForm: TPrimTextLoadForm); override;
     {* Обработать текст }
 protected
 // overridden protected methods
   procedure CheckTopAnchor(const aView: InevInputView); override;
     {* проверить якорь начала отрисовки после окончания прокрутки }
   function GetFolder: AnsiString; override;
     {* Папка в которую входит тест }
   function F1Like: Boolean; override;
   function GetModelElementGUID: AnsiString; override;
     {* Идентификатор элемента модели, который описывает тест }
 protected
 // protected methods
   procedure MoveCursor4Insert(aForm: TPrimTextLoadForm); virtual;
     {* Переместить курсор перед вставкой комментария. }
   function GetUserComment(const aPoint: InevBasePoint): InevBasePoint; virtual;
     {* Получить пользовательский комментарий }
   procedure DoScroll(aForm: TPrimTextLoadForm); virtual;
     {* Прокрутка текста в редакторе (если нужна). }
 end;//TCommentAndScrollTest
{$IfEnd} //nsTest AND not NoVCM

implementation

{$If defined(nsTest) AND not defined(NoVCM)}
uses
  Classes
  {$If defined(k2ForEditor)}
  ,
  evCursorTools
  {$IfEnd} //k2ForEditor
  ,
  evOp,
  evTypes,
  l3Base,
  CommentPara_Const,
  eeEditorExport,
  TestFrameWork,
  vcmBase,
  SysUtils
  {$If not defined(NoVCL)}
  ,
  Forms
  {$IfEnd} //not NoVCL
  
  ;
{$IfEnd} //nsTest AND not NoVCM

{$If defined(nsTest) AND not defined(NoVCM)}

// start class TCommentAndScrollTest

procedure TCommentAndScrollTest.MoveCursor4Insert(aForm: TPrimTextLoadForm);
//#UC START# *4CA2F33F01E5_4C9CA365006C_var*
var
 i : Integer;
//#UC END# *4CA2F33F01E5_4C9CA365006C_var*
begin
//#UC START# *4CA2F33F01E5_4C9CA365006C_impl*
 for i := 0 to 5 do
  aForm.Text.Selection.Cursor.Move(aForm.Text.View, ev_ocParaDown);
//#UC END# *4CA2F33F01E5_4C9CA365006C_impl*
end;//TCommentAndScrollTest.MoveCursor4Insert

function TCommentAndScrollTest.GetUserComment(const aPoint: InevBasePoint): InevBasePoint;
//#UC START# *4CA982110056_4C9CA365006C_var*
//#UC END# *4CA982110056_4C9CA365006C_var*
begin
//#UC START# *4CA982110056_4C9CA365006C_impl*
 Result := aPoint;
 while not Result.AsObject.IsKindOf(k2_typCommentPara) do
  Result := Result.Inner;
//#UC END# *4CA982110056_4C9CA365006C_impl*
end;//TCommentAndScrollTest.GetUserComment

procedure TCommentAndScrollTest.DoScroll(aForm: TPrimTextLoadForm);
//#UC START# *4CA982800281_4C9CA365006C_var*
//#UC END# *4CA982800281_4C9CA365006C_var*
begin
//#UC START# *4CA982800281_4C9CA365006C_impl*

//#UC END# *4CA982800281_4C9CA365006C_impl*
end;//TCommentAndScrollTest.DoScroll

procedure TCommentAndScrollTest.DoVisit(aForm: TPrimTextLoadForm);
//#UC START# *4BE419AF0217_4C9CA365006C_var*
var
 l_UserComment : InevBasePoint;
 l_PID         : Integer;
 i             : Integer;
//#UC END# *4BE419AF0217_4C9CA365006C_var*
begin
//#UC START# *4BE419AF0217_4C9CA365006C_impl*
 aForm.Text.Select(ev_stDocument);
 aForm.Text.Copy;
 MoveCursor4Insert(aForm);
 (aForm.Text as TeeEditorExport).InsertUserComment;
 aForm.Text.Paste;
 l3System.ClearClipboard;
 l_UserComment := GetUserComment(aForm.Text.Selection.Cursor);
 DoScroll(aForm);
 l_PID := l_UserComment.Obj^.PID;
 l_UserComment.Obj^.OwnerObj.SubRange(aForm.Text.View, l_PID + 1, l_PID + 1).Modify.Delete(aForm.Text.View);
 ScrollByLine(aForm, 1, True, False);
 CheckTopAnchor(aForm.Text.View);
//#UC END# *4BE419AF0217_4C9CA365006C_impl*
end;//TCommentAndScrollTest.DoVisit

procedure TCommentAndScrollTest.CheckTopAnchor(const aView: InevInputView);
//#UC START# *4C1F0A260192_4C9CA365006C_var*
//#UC END# *4C1F0A260192_4C9CA365006C_var*
begin
//#UC START# *4C1F0A260192_4C9CA365006C_impl*
 CheckFalse(aView.TopAnchor.Inner.AsObject.IsKindOf(k2_typCommentPara), 'Комментарий мы уже удалили! А TopAnchor его еще держит!');
//#UC END# *4C1F0A260192_4C9CA365006C_impl*
end;//TCommentAndScrollTest.CheckTopAnchor

function TCommentAndScrollTest.GetFolder: AnsiString;
 {-}
begin
 Result := 'Everest';
end;//TCommentAndScrollTest.GetFolder

function TCommentAndScrollTest.F1Like: Boolean;
//#UC START# *4C9B31F6015E_4C9CA365006C_var*
//#UC END# *4C9B31F6015E_4C9CA365006C_var*
begin
//#UC START# *4C9B31F6015E_4C9CA365006C_impl*
 Result := True;
//#UC END# *4C9B31F6015E_4C9CA365006C_impl*
end;//TCommentAndScrollTest.F1Like

function TCommentAndScrollTest.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4C9CA365006C';
end;//TCommentAndScrollTest.GetModelElementGUID

{$IfEnd} //nsTest AND not NoVCM

end.