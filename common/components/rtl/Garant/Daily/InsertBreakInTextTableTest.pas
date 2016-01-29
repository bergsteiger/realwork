unit InsertBreakInTextTableTest;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DailyTest"
// Модуль: "w:/common/components/rtl/Garant/Daily/InsertBreakInTextTableTest.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::EditorTests::TInsertBreakInTextTableTest
//
// Вставка текста в моноширинную таблицу в режиме рисования текста.
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
 TInsertBreakInTextTableTest = {abstract} class(_CursorMover_)
  {* Вставка текста в моноширинную таблицу в режиме рисования текста. }
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
 end;//TInsertBreakInTextTableTest
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  nevBase,
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

// start class TInsertBreakInTextTableTest

procedure TInsertBreakInTextTableTest.Navigate(aText: TevCustomEditorWindow;
  const anOp: Il3OpPack);
//#UC START# *4C4FE56300FB_4CD7EBBB02D3_var*
var
 i : Integer;
//#UC END# *4C4FE56300FB_4CD7EBBB02D3_var*
begin
//#UC START# *4C4FE56300FB_4CD7EBBB02D3_impl*
 for i := 0 to 3 do
  aText.Selection.Cursor.Move(aText.View, ev_ocCharRight);
 aText.Selection.Cursor.Move(aText.View, ev_ocLineDown);
//#UC END# *4C4FE56300FB_4CD7EBBB02D3_impl*
end;//TInsertBreakInTextTableTest.Navigate

procedure TInsertBreakInTextTableTest.DoProcess(aText: TevCustomEditorWindow;
  const anOp: Il3OpPack);
//#UC START# *4C9214F6002C_4CD7EBBB02D3_var*
//#UC END# *4C9214F6002C_4CD7EBBB02D3_var*
begin
//#UC START# *4C9214F6002C_4CD7EBBB02D3_impl*
 aText.Selection.DrawLines := True;
 aText.Selection.ProcessCommand(ev_msgBreakPara, 0, anOp, 1);
//#UC END# *4C9214F6002C_4CD7EBBB02D3_impl*
end;//TInsertBreakInTextTableTest.DoProcess

function TInsertBreakInTextTableTest.GetFolder: AnsiString;
 {-}
begin
 Result := 'EditorTests';
end;//TInsertBreakInTextTableTest.GetFolder

function TInsertBreakInTextTableTest.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4CD7EBBB02D3';
end;//TInsertBreakInTextTableTest.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

end.