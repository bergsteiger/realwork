unit CommentInTableAndScrollTest;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "TestFormsTest"
// Модуль: "w:/common/components/gui/Garant/Daily/CommentInTableAndScrollTest.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Operations For Tests::TestFormsTest::Everest::TCommentInTableAndScrollTest
//
// Тест вставки комметария в таблицу
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
  CommentAndScrollTest,
  PrimTextLoad_Form
  ;
{$IfEnd} //nsTest AND not NoVCM

{$If defined(nsTest) AND not defined(NoVCM)}
type
 TCommentInTableAndScrollTest = {abstract} class(TCommentAndScrollTest)
  {* Тест вставки комметария в таблицу }
 private
 // private methods
   function IsUserComment(const aView: InevInputView): Boolean;
     {* Проверяет указывает ли якорь на пользовательский комментарий. }
 protected
 // overridden protected methods
   procedure CheckTopAnchor(const aView: InevInputView); override;
     {* проверить якорь начала отрисовки после окончания прокрутки }
   function GetFolder: AnsiString; override;
     {* Папка в которую входит тест }
   procedure MoveCursor4Insert(aForm: TPrimTextLoadForm); override;
     {* Переместить курсор перед вставкой комментария. }
   function GetUserComment(const aPoint: InevBasePoint): InevBasePoint; override;
     {* Получить пользовательский комментарий }
   procedure DoScroll(aForm: TPrimTextLoadForm); override;
     {* Прокрутка текста в редакторе (если нужна). }
   function GetModelElementGUID: AnsiString; override;
     {* Идентификатор элемента модели, который описывает тест }
 end;//TCommentInTableAndScrollTest
{$IfEnd} //nsTest AND not NoVCM

implementation

{$If defined(nsTest) AND not defined(NoVCM)}
uses
  evOp,
  TableCell_Const,
  SBSCell_Const,
  CommentPara_Const,
  l3Variant,
  TestFrameWork,
  vcmBase,
  SysUtils
  {$If not defined(NoVCL)}
  ,
  Forms
  {$IfEnd} //not NoVCL
  ,
  l3Base
  ;
{$IfEnd} //nsTest AND not NoVCM

{$If defined(nsTest) AND not defined(NoVCM)}

// start class TCommentInTableAndScrollTest

function TCommentInTableAndScrollTest.IsUserComment(const aView: InevInputView): Boolean;
//#UC START# *4CA983690025_4CA2F3AA0033_var*
var
 l_Real   : InevBasePoint;
 l_Anchor : InevBasePoint;
//#UC END# *4CA983690025_4CA2F3AA0033_var*
begin
//#UC START# *4CA983690025_4CA2F3AA0033_impl*
 Result := False;
 l_Anchor := aView.TopAnchor;
 while l_Anchor <> nil do
 begin
  if l_Anchor.AsObject.IsKindOf(k2_typCommentPara) then
  begin
   Result := True;
   Break;
  end; // if l_Anchor.IsKindOf(k2_typCommentPara) then
  if l_Anchor.HasBaseLine then
   l_Anchor := l_Anchor.InnerFor(l_Anchor.Obj^.ToList.Obj[0], l_Real)
  else
   l_Anchor := l_Anchor.Inner;
 end; // while l_Anchor <> nil do
//#UC END# *4CA983690025_4CA2F3AA0033_impl*
end;//TCommentInTableAndScrollTest.IsUserComment

procedure TCommentInTableAndScrollTest.CheckTopAnchor(const aView: InevInputView);
//#UC START# *4C1F0A260192_4CA2F3AA0033_var*
//#UC END# *4C1F0A260192_4CA2F3AA0033_var*
begin
//#UC START# *4C1F0A260192_4CA2F3AA0033_impl*
 CheckFalse(IsUserComment(aView), 'Комментарий мы уже удалили! А TopAnchor его еще держит!');
//#UC END# *4C1F0A260192_4CA2F3AA0033_impl*
end;//TCommentInTableAndScrollTest.CheckTopAnchor

function TCommentInTableAndScrollTest.GetFolder: AnsiString;
 {-}
begin
 Result := 'Everest';
end;//TCommentInTableAndScrollTest.GetFolder

procedure TCommentInTableAndScrollTest.MoveCursor4Insert(aForm: TPrimTextLoadForm);
//#UC START# *4CA2F33F01E5_4CA2F3AA0033_var*
var
 l_Tag: Tl3Variant;
//#UC END# *4CA2F33F01E5_4CA2F3AA0033_var*
begin
//#UC START# *4CA2F33F01E5_4CA2F3AA0033_impl*
 l_Tag := aForm.Text.Selection.Cursor.MostInner.AsObject.Owner;
 while not l_Tag.IsKindOf(k2_typTableCell) or l_Tag.IsKindOf(k2_typSBSCell) do
 begin
  aForm.Text.Selection.Cursor.Move(aForm.Text.View, ev_ocLineDown);
  l_Tag := aForm.Text.Selection.Cursor.MostInner.AsObject.Owner;
 end; // while not l_Tag.IsKindOf(k2_typTableCell) ...
 aForm.Text.Selection.Cursor.Move(aForm.Text.View, ev_ocLineDown);
 //aForm.Text.Selection.Cursor.Move(aForm.Text.View, ev_ocLineDown); 
//#UC END# *4CA2F33F01E5_4CA2F3AA0033_impl*
end;//TCommentInTableAndScrollTest.MoveCursor4Insert

function TCommentInTableAndScrollTest.GetUserComment(const aPoint: InevBasePoint): InevBasePoint;
//#UC START# *4CA982110056_4CA2F3AA0033_var*
var
 l_PrevPoint: InevBasePoint;
//#UC END# *4CA982110056_4CA2F3AA0033_var*
begin
//#UC START# *4CA982110056_4CA2F3AA0033_impl*
 Result := aPoint;
 while not Result.AsObject.IsKindOf(k2_typCommentPara) do
 begin
  l_PrevPoint := Result;
  Result := Result.Inner;
  if Result = nil then
   Result := l_PrevPoint.Obj^.ToList.Obj[l_PrevPoint.Obj^.AsObject.ChildrenCount - 1].MakePoint;
 end; // while not Result.IsKindOf(k2_typCommentPara) do
//#UC END# *4CA982110056_4CA2F3AA0033_impl*
end;//TCommentInTableAndScrollTest.GetUserComment

procedure TCommentInTableAndScrollTest.DoScroll(aForm: TPrimTextLoadForm);
//#UC START# *4CA982800281_4CA2F3AA0033_var*
//#UC END# *4CA982800281_4CA2F3AA0033_var*
begin
//#UC START# *4CA982800281_4CA2F3AA0033_impl*
 while not IsUserComment(aForm.Text.View) do
  ScrollByLine(aForm, 1, False, False);
//#UC END# *4CA982800281_4CA2F3AA0033_impl*
end;//TCommentInTableAndScrollTest.DoScroll

function TCommentInTableAndScrollTest.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4CA2F3AA0033';
end;//TCommentInTableAndScrollTest.GetModelElementGUID

{$IfEnd} //nsTest AND not NoVCM

end.