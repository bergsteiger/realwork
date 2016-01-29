unit DeleteCharTest;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DailyTest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/rtl/Garant/Daily/DeleteCharTest.pas"
// Начат: 28.09.2010 13:22
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::EditorTests::TDeleteCharTest
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Daily\TestDefine.inc.pas}

interface

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  TextViaEditorProcessorWithNavigate,
  evCustomEditorWindow,
  l3Variant
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 _CursorMover_Parent_ = TTextViaEditorProcessorWithNavigate;
 {$Include w:\common\components\gui\Garant\Everest\EditorUsers\CursorMover.imp.pas}
 TDeleteCharTest = {abstract} class(_CursorMover_)
 protected
 // realized methods
   procedure Navigate(aText: TevCustomEditorWindow;
    const anOp: Il3OpPack); override;
     {* Устанавливает курсор или выделение }
   procedure DoProcess(aText: TevCustomEditorWindow;
    const anOp: Il3OpPack); override;
 protected
 // overridden protected methods
   function GetFolder: AnsiString; override;
     {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
     {* Идентификатор элемента модели, который описывает тест }
 protected
 // protected methods
   function CharCount: Integer; virtual;
 end;//TDeleteCharTest
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  TestFrameWork,
  evMsgCode,
  evOp
  {$If not defined(NoVCM)}
  ,
  vcmBase
  {$IfEnd} //not NoVCM
  ,
  SysUtils
  {$If not defined(NoVCL)}
  ,
  Forms
  {$IfEnd} //not NoVCL
  ,
  l3Base
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}

{$Include w:\common\components\gui\Garant\Everest\EditorUsers\CursorMover.imp.pas}

// start class TDeleteCharTest

function TDeleteCharTest.CharCount: Integer;
//#UC START# *4DF781CB0217_4CA30546032E_var*
//#UC END# *4DF781CB0217_4CA30546032E_var*
begin
//#UC START# *4DF781CB0217_4CA30546032E_impl*
 Result := 1;
//#UC END# *4DF781CB0217_4CA30546032E_impl*
end;//TDeleteCharTest.CharCount

procedure TDeleteCharTest.Navigate(aText: TevCustomEditorWindow;
  const anOp: Il3OpPack);
//#UC START# *4C4FE56300FB_4CA30546032E_var*
//#UC END# *4C4FE56300FB_4CA30546032E_var*
begin
//#UC START# *4C4FE56300FB_4CA30546032E_impl*
 with aText do
 begin
  Check(MoveLeafCursor(ev_ocParaDown, true));
  Check(MoveLeafCursor(ev_ocBottomRight, false));
 end;//with aText
//#UC END# *4C4FE56300FB_4CA30546032E_impl*
end;//TDeleteCharTest.Navigate

procedure TDeleteCharTest.DoProcess(aText: TevCustomEditorWindow;
  const anOp: Il3OpPack);
//#UC START# *4C9214F6002C_4CA30546032E_var*
var
 l_Index : Integer;
//#UC END# *4C9214F6002C_4CA30546032E_var*
begin
//#UC START# *4C9214F6002C_4CA30546032E_impl*
 with aText do
  for l_Index := 0 to Pred(CharCount) do
   Check(Selection.Cursor.Text.Modify.DeleteChar(View, false, anOp));
//#UC END# *4C9214F6002C_4CA30546032E_impl*
end;//TDeleteCharTest.DoProcess

function TDeleteCharTest.GetFolder: AnsiString;
 {-}
begin
 Result := 'EditorTests';
end;//TDeleteCharTest.GetFolder

function TDeleteCharTest.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4CA30546032E';
end;//TDeleteCharTest.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

end.