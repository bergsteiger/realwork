unit SelectionCellTest;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DailyTest"
// Модуль: "w:/common/components/rtl/Garant/Daily/SelectionCellTest.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::EditorTests::TSelectionCellTest
//
// Тест на выделение ячейки.
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
  Classes
  {$If defined(nsTest) AND not defined(NoVCM)}
  ,
  TextViaEditorProcessor
  {$IfEnd} //nsTest AND not NoVCM
  ,
  evCustomEditorWindow
  {$If defined(nsTest) AND not defined(NoVCM)}
  ,
  PrimTextLoad_Form
  {$IfEnd} //nsTest AND not NoVCM
  
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 _CursorMover_Parent_ = TTextViaEditorProcessor;
 {$Include w:\common\components\gui\Garant\Everest\EditorUsers\CursorMover.imp.pas}
 _ClipboardOperations_Parent_ = _CursorMover_;
 {$Include w:\common\components\rtl\Garant\ScriptEngine\ClipboardOperations.imp.pas}
 _SelectOperation_Parent_ = _ClipboardOperations_;
 {$Include w:\common\components\gui\Garant\Everest\EditorUsers\SelectOperation.imp.pas}
 TSelectionCellTest = {abstract} class(_SelectOperation_)
  {* Тест на выделение ячейки. }
 protected
 // realized methods
   {$If defined(nsTest) AND not defined(NoVCM)}
   procedure Process(aForm: TPrimTextLoadForm); override;
     {* Собственно процесс обработки текста }
   {$IfEnd} //nsTest AND not NoVCM
 protected
 // overridden protected methods
   function GetFolder: AnsiString; override;
     {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
     {* Идентификатор элемента модели, который описывает тест }
 end;//TSelectionCellTest
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  TestFrameWork,
  evMsgCode,
  evOp,
  l3Base,
  l3InternalInterfaces,
  evTypes
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
  
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}

{$Include w:\common\components\gui\Garant\Everest\EditorUsers\CursorMover.imp.pas}

{$Include w:\common\components\rtl\Garant\ScriptEngine\ClipboardOperations.imp.pas}

{$Include w:\common\components\gui\Garant\Everest\EditorUsers\SelectOperation.imp.pas}

// start class TSelectionCellTest

{$If defined(nsTest) AND not defined(NoVCM)}
procedure TSelectionCellTest.Process(aForm: TPrimTextLoadForm);
//#UC START# *4BE13147032C_4D413AD401BD_var*
//#UC END# *4BE13147032C_4D413AD401BD_var*
begin
//#UC START# *4BE13147032C_4D413AD401BD_impl*
 aForm.Text.Selection.Cursor.Move(aForm.Text.View, ev_ocParaDown);
 SelectPara(aForm.Text);
 CopyAndPaste2DocumentBottom(aForm.Text);
//#UC END# *4BE13147032C_4D413AD401BD_impl*
end;//TSelectionCellTest.Process
{$IfEnd} //nsTest AND not NoVCM

function TSelectionCellTest.GetFolder: AnsiString;
 {-}
begin
 Result := 'EditorTests';
end;//TSelectionCellTest.GetFolder

function TSelectionCellTest.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4D413AD401BD';
end;//TSelectionCellTest.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

end.