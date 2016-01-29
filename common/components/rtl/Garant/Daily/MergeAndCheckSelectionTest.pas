unit MergeAndCheckSelectionTest;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DailyTest"
// Модуль: "w:/common/components/rtl/Garant/Daily/MergeAndCheckSelectionTest.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::EditorTests::TMergeAndCheckSelectionTest
//
// Тест проверки выделения после объединения ячеек.
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
  MergeCellsTest,
  evCustomEditorWindow
  {$If defined(nsTest) AND not defined(NoVCM)}
  ,
  PrimTextLoad_Form
  {$IfEnd} //nsTest AND not NoVCM
  
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 _ClipboardOperations_Parent_ = TMergeCellsTest;
 {$Include w:\common\components\rtl\Garant\ScriptEngine\ClipboardOperations.imp.pas}
 _SelectOperation_Parent_ = _ClipboardOperations_;
 {$Include w:\common\components\gui\Garant\Everest\EditorUsers\SelectOperation.imp.pas}
 TMergeAndCheckSelectionTest = {abstract} class(_SelectOperation_)
  {* Тест проверки выделения после объединения ячеек. }
 protected
 // overridden protected methods
   function GetFolder: AnsiString; override;
     {* Папка в которую входит тест }
   {$If defined(nsTest) AND not defined(NoVCM)}
   procedure CheckOperation(aForm: TPrimTextLoadForm); override;
     {* Проверка после применения инструмента. }
   {$IfEnd} //nsTest AND not NoVCM
   function NeedSelection: Boolean; override;
     {* Нужно ли чего-нибудь выделять. }
   function GetModelElementGUID: AnsiString; override;
     {* Идентификатор элемента модели, который описывает тест }
 end;//TMergeAndCheckSelectionTest
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  TestFrameWork,
  l3Base,
  evOp,
  l3InternalInterfaces,
  evTypes,
  evMsgCode
  {$If defined(k2ForEditor)}
  ,
  evCursorTools
  {$IfEnd} //k2ForEditor
  
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

{$Include w:\common\components\rtl\Garant\ScriptEngine\ClipboardOperations.imp.pas}

{$Include w:\common\components\gui\Garant\Everest\EditorUsers\SelectOperation.imp.pas}

// start class TMergeAndCheckSelectionTest

function TMergeAndCheckSelectionTest.GetFolder: AnsiString;
 {-}
begin
 Result := 'EditorTests';
end;//TMergeAndCheckSelectionTest.GetFolder

{$If defined(nsTest) AND not defined(NoVCM)}
procedure TMergeAndCheckSelectionTest.CheckOperation(aForm: TPrimTextLoadForm);
//#UC START# *4C9999C50326_4CE133F801BA_var*
//#UC END# *4C9999C50326_4CE133F801BA_var*
begin
//#UC START# *4C9999C50326_4CE133F801BA_impl*
 if aForm.Text.HasSelection then
  CopyAndPaste2DocumentBottom(aForm.Text);
//#UC END# *4C9999C50326_4CE133F801BA_impl*
end;//TMergeAndCheckSelectionTest.CheckOperation
{$IfEnd} //nsTest AND not NoVCM

function TMergeAndCheckSelectionTest.NeedSelection: Boolean;
//#UC START# *4CC8189D02DF_4CE133F801BA_var*
//#UC END# *4CC8189D02DF_4CE133F801BA_var*
begin
//#UC START# *4CC8189D02DF_4CE133F801BA_impl*
 Result := True;
//#UC END# *4CC8189D02DF_4CE133F801BA_impl*
end;//TMergeAndCheckSelectionTest.NeedSelection

function TMergeAndCheckSelectionTest.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4CE133F801BA';
end;//TMergeAndCheckSelectionTest.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

end.